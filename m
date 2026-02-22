Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89D35B62F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796614; cv=none; b=ihf+v5cWsrrzO8eblo8Q6F0naSb/J7tCglbZ14DKPs/EhLARvqh3mUiYVFA7svUTk2nFoSu0KMC/UKowa7M4y10ZmKsfbLCYKIC0reEEqKsVh5roBl387B5U+31cQi6XtaCzZspVTblo4CufSzgvqPib781img4QPSHPFydlikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796614; c=relaxed/simple;
	bh=JbZDp8NGXbxbIE3c7Hram9OWard1SU+mqfJx9gFw/Bs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mt1bY9YUbNbD1yxobD/3dvP50Kqp9Zkg5hPt4pv0QSJqHq5RdIQX9v1s6DfLytOI3J7Zy8nglglGz5dMqxMHLwWOOyAdyovtEitSxEtJjO0BBCK6xhrQY246q7C9AWmxCC2zLbUpaeZVQkjB62vjAIGw7dCxCPpBtU5vA73Bbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T88UeFmF; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T88UeFmF"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5673891928cso1731584e0c.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771796612; x=1772401412; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbZDp8NGXbxbIE3c7Hram9OWard1SU+mqfJx9gFw/Bs=;
        b=T88UeFmF6NoJulDkcquoXbIGzF204/lTkhPZbH7i40j82+V1jQF8hnhMXprS8Sbl2v
         K5aHawZ4st3btEFBCKG/r3y5f2XywCY3RMZjQku0C+0Mms7rBKb1HoFPadlsM/jP8y+Z
         SuLB+2ai1PL3A+QBTthuHEH5xRUXX7ytvHqi0gsCC0Ml7DNX7cXl70uztsJWIgk+kStO
         cv26yZgsa34KvBjj5meprRW+QzO+Nw+Zi1jvAxLWPIDnvDNp6pbD5ybBtMliBjYUAJ/S
         HI0ZAZlc7BiJY1eF2zeUAcWZXUbkVOsIesHQGFiIEDQd96WeKrjeEVuQjX8LNgV2/6ew
         sngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771796612; x=1772401412;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbZDp8NGXbxbIE3c7Hram9OWard1SU+mqfJx9gFw/Bs=;
        b=D05jJHtnjbZh1/yfDnua0Dimsn7t9CmCTBCI7snFW4dZ6payVN8LgoasNuUDpsHazD
         Fx+GR6myxLXQPNPw7MeJfxL1z4CFVejNMwnajraSdLfvK8lJ7S9vK+Tz2eOmFDGpk9vw
         BOvgDMLdtGCvuC0SRZfE207GbP3CpuElwKHfz65142HxXhhPJH82nzgTuHTv8a/Dfq8p
         T32qk93ISg1JAh8O/iqbeJHOlNFmYFO0+KHsElHSEiHd8HV/6EQNFZRtd6+Ne1ZFY3EA
         N5XaVK+phzYxZlz95VxxuJfzUJ7rhtDgEQ4e9hQuRAZII3C2M0zLvxr9xe3Lh3DiB0X9
         08pQ==
X-Gm-Message-State: AOJu0Yw2IkiZCFw8kVwUHFEDZrWT1TvVCP4Y/6w2q0PBH0GwgkjB2GDZ
	Lvh3C7wqi3peBVl7IyidYd5/5Wh2IFp5P92Y1BlK8rYSrqXRCR1BnJRCkFAs1g==
X-Gm-Gg: AZuq6aJH7ka5t7NDAEsiQp53jstWoAWRCySmGSPStg8DSdauWeWmjoRrb3rFfQfgceH
	sQt3sU/muWIUbybHFlgzkLoHaR15Mw1myjnVMGyJoYhdEje51XtztLlAB8jdWb7DZKvx5LYfOL4
	pEzXeZL4xaNX2tYG3URtKC83XW1Rw/nDpoXcHQQXIdONoryn3YldoQHKFySvlBQx6Zch/kbQCcF
	Ac7BsY6ubn0cG//3OctmPBMdg50FkvXAan4G/fn7949AjhdSzI5XgH+R04/+LAYQEzD2E/NiuHO
	uupoNvnQef7bzBbmTeu9400rKVl/OTd7swaHuhCk4phqSn0HVsPpxZNBLI9SsryWAL6rZIAl9Z9
	OeSh4ICUg8C3yoEDFik+id5OQVMFklnS38q4rOTZJmb952qYtMY7rwa/e0WspHF3nyc06WVs/D/
	MSOA/FGTSujPx0jWz+4xenGiQ8QxuFyCt08OFrIIutvLJ+0SkUGEqStA==
X-Received: by 2002:a05:6102:3f0b:b0:5f0:2451:5f5 with SMTP id ada2fe7eead31-5feb2e900e9mr2123923137.7.1771796612147;
        Sun, 22 Feb 2026 13:43:32 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm5399505241.9.2026.02.22.13.43.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 13:43:31 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 1/8] CodingGuidelines: instruct to name arrays in singular
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cRHm1vDABoHNKiuBRRsvk90Z1qGeeu3DT3VHdzEfJeP=g@mail.gmail.com>
Date: Sun, 22 Feb 2026 18:43:17 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 gitster@pobox.com,
 jltobler@gmail.com,
 avila.jn@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <776CC19F-6FF2-478A-A454-F62F9EB09ED5@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260218211845.96009-2-lucasseikioshiro@gmail.com>
 <CAPig+cRHm1vDABoHNKiuBRRsvk90Z1qGeeu3DT3VHdzEfJeP=g@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3864.400.21)

> While this is generally true on this project, it is nevertheless
> incomplete. More specifically, the singular form is used for an array
> name in cases when the individual items of the array are the typical
> subject of use, for instance, when the consumer of the array is
> walking the dogs one at a time. However, there are cases in which the
> array is generally employed as a whole, rather than as its unit parts,
> in which the plural form for the name is preferable. An example would
> be when walking all the dogs at the same time.

Thanks, Eric!

You explanation was very clear, and I'll use parts of it in the next
version, giving credits to you, of course.
