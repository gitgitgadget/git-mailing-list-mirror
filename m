Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FFC3081D3
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403598; cv=none; b=sJfHRtcOa/mKr+J1J5lgtXRfoiIiq1zgVkdHyIYKWfR7cGRdnTwfUNSngkeZawL4UND4LKZZO+FLnVy4A2j9CBhB/DM/Bm9bsNZNdE97u94PhM2Ic30AvNSR8KJwJSN63AsBEaRkzIle2MuzJaFtppU0aEG0DTFmU3gGgbThte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403598; c=relaxed/simple;
	bh=OemzrRk8/y5sZxSnPocytWCiOv9QqKqarLZUCggbQ1U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=a3m85+/GvzDDNjElulc5L3sGH7t8Un2/wnTURhedAremgQvqWQuEy6G/tssmRiF4SatyaCGLgJyLHLjheU872sB0aAUd51vBmPc5vnoAU/ZCTdl9Kq7U4wynmSEpZTfaWWZCqsbwScMndedw4Tpv0LPrp4+N8VEEsYKFXlgByuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRcP+RUe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRcP+RUe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24c8ef94e5dso43248155ad.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403596; x=1758008396; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvKyoMBR8hteDb0BW9peslQGijvxEIaNi+zG87jRzAk=;
        b=XRcP+RUem7eRWLkMtSD4kbPKELsBIwRlw3nCLs0t3tI4qxmNMb/jr+YrDToYWgk9v8
         6+g63pSuv2OH3zTTY1fDcywa6gAN3dvB8+wrulfzAIrq3RqStfv1mtoQBsyag4JgVEpV
         6a2lgwdXkMQieXyQFXgpwfBCHF6zHnRlQlQOcEJSc/XiHnC/0LeoR4QCctVyUJ4DHDWF
         hulAVUTlqrNuYhn1wapPFB+qhaGkj8KSJkx2ntlVmBTURaY3Ts5LVaXDzQ+fJCmQxHGa
         lvB58lbxmsLYXCBdHKfEgFm0cBzsRmsZcsgGpz/2BAiePbA0og0EQkwX93+EF8QWmXIB
         EB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403596; x=1758008396;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvKyoMBR8hteDb0BW9peslQGijvxEIaNi+zG87jRzAk=;
        b=n/6i2NBvyJ70G90kpC+SFKYrIzZJ1S16w5ArxbBsDvd24u8eaabaMBkqMCPhDa0Uwk
         +uRrhGjSQTRbImkiLlCMJMEPRXiz28qPLbslbzpEsy1vjqWbS9rj6J0x6a3HJixj+REm
         kvT1txOiiFKaKxwP+l0EFWRuRFshpSlA43qICB5gn/luSfC7igMWejJ/GjjU6qe6c/JI
         8jCIELHSrt/deVS8otMzoLtOEuE6Op7ZgDTKGZbSL+syie+LOFnZ925U/4qShL9xVKNk
         9DuPOvdOEyHZWLFUIbbEzN6GnP9HQkHbt+wU/2y41gGFfUBrn3EbaqiyxlLiCVjEj1kr
         aEAw==
X-Forwarded-Encrypted: i=1; AJvYcCU1CHBMpzNz1IQhHsrZdXu1tq3Hs+LhCxc9jk1MbCIrzNsiKpsrd4BwAtRefzzdXnMaik4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypq8kZOMKXJWo01H7MmghmAtUDqiVqsDkqlKl6StXsOfmCioee
	vfqg9Okgd6Lhks+sZwDwjEbzAQELB6LsK24e+RAva0kB4M9kYx7/RDM0
X-Gm-Gg: ASbGnctCzu2l//ywQJlBQjpR9nXtc56D7vWJUqOcyRv17PqzeSgdG5lHx0N6X80/VS6
	2+HomclNm8rUCxuZY4GfAv7i/iX0azddROMxRQPKZyVv/iyMY4lu7vojDpYEWm56oNSvptxHHQr
	peJ0wPu7XHpV7E00kE9fxyuxfKsSc4u3P9vAn3Ws4cGGvlD1LxdjAXOm/m7n+vzGDoqZXVfqdO2
	O6bnll4M+Eu3y+2QkeaJcrL/Hx4lueQdsHXrJ0k0nP9Q4tubE4NlD/kpBlSHhM0yu43XvEk6VoF
	xJKeNzLhDXK6pTlbAgOYR1Zo/jr4uau8DgRpQVBoseLD5PTDfwS9nEepACSQZvQsJylKadg+kh4
	sWP/DVxcxrRVn29ITnlKLcIjDCtRb0LFtBrsvXxIuojTUc8kviuG3ITGnQf0QRwk=
X-Google-Smtp-Source: AGHT+IGHDNEWB8G3voNE7JFIeJA+Qkbz81wsgbTpFMTjAA6ADEuCFYblbgv0HNzHBIgdaTaMxP3W6Q==
X-Received: by 2002:a17:903:2450:b0:24c:cb6b:105a with SMTP id d9443c01a7336-2517a7dc904mr160816785ad.30.1757403596174;
        Tue, 09 Sep 2025 00:39:56 -0700 (PDT)
Received: from localhost ([106.51.239.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c860066d3sm166432785ad.71.2025.09.09.00.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 13:09:53 +0530
Message-Id: <DCO3KXDFLAOW.TJHMTZOP7LQG@gmail.com>
From: "Kousik Sanagavarapu" <five231003@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, "Kousik Sanagavarapu"
 <five231003@gmail.com>, <git@vger.kernel.org>
Subject: Re: Running out of inodes on an NFS which stores repos
X-Mailer: aerc 0.21.0
References: <20250906141711.64419-1-five231003@gmail.com>
 <aLxUkTzuVaZrWDs2@fruit.crustytoothpaste.net>
 <DCN87S14V9G8.3BAV5XX1BDHKM@gmail.com>
 <aL904XGUmXmnyXGl@fruit.crustytoothpaste.net>
In-Reply-To: <aL904XGUmXmnyXGl@fruit.crustytoothpaste.net>

On Tue Sep 9, 2025 at 5:59 AM IST, brian m. carlson wrote:
> On 2025-09-08 at 07:05:08, Kousik Sanagavarapu wrote:
>> Yes, I have now set the following config surrounding gc
>>
>> 	[receive]
>> 		autogc =3D true
>> 	[gc]
>> 		auto =3D 1
>> 		autopacklimit =3D 1
>>
>> Curious to know if this will have any noticable performance impact
>> though. As I mentioned in my previous msg, these are small repos but the
>> number of repos being created and the operations performed on them are
>> large - mostly pushes,
>
> The `transfer.unpackLimit` will not have any impact; it's in use at at
> least some major forges.  Packed objects can use things like bitmaps and
> other functionality, which forges like for performance.

Oh, got it.

> The gc settings you have will cause everything to repacked after every
> push, and repacking data can be quite expensive.  At work, we repack
> after about every 40 pushes or so.  You may wish to use a different
> value.

Got it, thanks for the info. I will try with a higher value and see how
it goes.
