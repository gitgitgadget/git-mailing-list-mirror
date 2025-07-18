Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926A11712
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870425; cv=none; b=Frwt6CkROxpdmDrPFjbHabFzFQtNM9CkTF5lQ9oJLwFDmR/Qn+oPs4t6I+sB3hlTB993kmazZs4kQJCyFEw7f2E7VffS1fzNl3XuVd5zBs0hCuEzEnK2KLVdYD4NtxurAC8/Mjybh+DHkNXa0Nlg9OJAyR/bFg6GFylfgHxV6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870425; c=relaxed/simple;
	bh=JgfVubbw+Lj07bAq/Df7HIS4NadNzSK65PhWQ5ZGxIA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LTvvA6Pi1Ei1cgliYIPD/XT0LkeJcUocVhF3iVF05NQ0YHIFB2kGILDnbz02ZlEm6Qbywqr7VULVyzwK2G3ap1XYmS4Gl26Ybs+8ie6Ekg4oKyqHWelg78wzmAySQ4i/AiybFyeTZGG1l05YeoI1P4G2k70quiHgD3zB3DugDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqWVRMbC; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqWVRMbC"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87f298f3508so824289241.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752870423; x=1753475223; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgfVubbw+Lj07bAq/Df7HIS4NadNzSK65PhWQ5ZGxIA=;
        b=lqWVRMbCSeoe/ed069ihZb0ydLLPeXb2KcJU9i2iEUlhWwYZ7pAE3T32tACEZg1wZC
         R4fVqigCbSgaMFQXu5iGixC/3dTCt2gkJf5IajMep91IvHC9RMLVeGhi0p4NbkOEEV9S
         XlxfwszlBkumFdRKFBqoqbbfryD7vVqJLLLXr0RdTJ2f9IXA9EnDF2FCZAzwSCsIAxuC
         W6jyXI4kFd09iRAmj4RomQLKVSuB4Pozis8Li/V/PC9twSGqipga7bTOy+kaRQUc3oKD
         er2qQYSSas7w5uo6tPqP8j3TSasE9GTt4zrWqSyEVX56HAtQDmjTZcmzqMJnSQQl2NMm
         0C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752870423; x=1753475223;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgfVubbw+Lj07bAq/Df7HIS4NadNzSK65PhWQ5ZGxIA=;
        b=sVoxtBJ+r6IHF+X3s4E0eaNoFh9hoKs4QkmZ2yU9UtIw++pkqaiF3sY9CD97EbJhQd
         OwuAZIlRune8tSXu4DTU2ly4scYKcaL2eKy9A8dTXtR0OEaJh4YqEsDY+2NOix9cDBBh
         miL+PYoKmVtaH2cLM4wNUD2yi9a+ZKwdSFyzolj+3hTT0vFjp3aROI1DPsMgDwvhZZaF
         kZQ9vSbOeC9C8IL37SKHYFNpCjkfDFCBH+Nq8/PKWtCullXQwVp3LDtP7fBeFeBHg8rD
         1H9CWrywj3QO/XdjoxdwZseHsXBabJ2bI5BK8aY1EaZo5Z6XoynFa6xbx08ppcYMsJl0
         qn6w==
X-Forwarded-Encrypted: i=1; AJvYcCVmqOhnii8Tz//zvZrXjCzMSBk5qWbQU8KokLNwf5SUFgpgfDznZkv8sPoViLDeXKn/Dkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/TyjokfY5pFNefNF6PWL+3JxPfd+31VR3ptrBamz0KZHU4Sp
	H+1OY+LScqrCEqzyf5bR2k7h+tkjl+Nk73kulHt2ZDcOw7XpPUSxor0U
X-Gm-Gg: ASbGncu3S9+e0Bs6PS7hEcUxdfTm24/wOYYBOu3ek2qKcUnGxKCBuIDspZ/YWL7CFow
	nSZxjdU70kbO3YG/Q4a9ubMRmS8Iww6ePmdYs+sIqJVOHFIbyxnhsA1CdVthianJY0zbJlTzloe
	Lbl9iR0KUaAzprNr6SVIqJM4ftGMz6oeimEh3NM71HLRRYiEULJFYZGnqdHdsEEoNvVHn3Ck0oE
	8ooOyH/2A71EiLK5SPY7Kr7wCxokcqpkzWWyIpNfoGu5PfH3XI1aFxmsT7laLrmGSNq8n7JCe7E
	fGKoHjs+9Ux+8p0kj8m32l/xuQsScrzTTd+I9D9sWoLSfmc9NeJSyk7VSYNCER+Y72LeeefJK1j
	mTVcOy+dy9SdXjM83+xiB6Y2NK5C3HduuA4uuJwjFdjvjisbB
X-Google-Smtp-Source: AGHT+IFB8l8FresDOAYaW7bsvOrJzMDitm64VaDrG+fvUensvXx8ol+6iIQXGci+1qAf+sa4y/v4ww==
X-Received: by 2002:a05:6122:3c82:b0:531:2d3b:44d3 with SMTP id 71dfb90a1353d-5376456bed7mr1568147e0c.0.1752870423041;
        Fri, 18 Jul 2025 13:27:03 -0700 (PDT)
Received: from smtpclient.apple ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537686f3ad1sm564284e0c.8.2025.07.18.13.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2025 13:27:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <oir6mpubnuplnjatdhlyljslakmh72wlax4afuqnsiyob65xfh@5rft32ln2zvk>
Date: Fri, 18 Jul 2025 17:26:48 -0300
Cc: Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk
Content-Transfer-Encoding: 7bit
Message-Id: <6ED935E8-05CE-4155-B56C-A113926915E6@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
 <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
 <aHc6y9FGFXjowkU1@pks.im>
 <2v7b6mpufnn6cj7u7tactgu2ibggn4xpuezl2bsfjxv62afrsa@chfrii6vkrx3>
 <aHj0lF5Kbirzv3pZ@pks.im>
 <oir6mpubnuplnjatdhlyljslakmh72wlax4afuqnsiyob65xfh@5rft32ln2zvk>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> So maybe we have three different output modes for `--format=<mode>`:
> `user` (default), `keyvalue`, and `nul`?

What about `porcelain` (default), `keyvalue` and `null` (being `-z` an
alias for this last one)?

> For `git repo info`, I'm not entirely certain how the default
> user-friendly mode would/should differ from the key-value one

Even for the "survey" part, would it be useful to have a key-value and
another human-readable format?

Another thing that I was thinking (as a future feature): what about
using by default the user-friendly format and using the null-terminated
format when piping the output to another command (like git-diff does
with the colors)?

