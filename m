Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680922F2D
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137494; cv=none; b=kyW7ScxwRhm9LrDD/lmMqto0wMm2dM3ZKhN9UFMEjhojGAlCStqVsoqkuh3LbE612GcUQY2enzXNsMk1N3H0p1/iGcJHHX8lDGW4oxr0QPRFdywNrgq0XwG+O0X7v6x91B9N9CEsHdGma1iD3YleuNtcPNiAa7szqFZF/hMUB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137494; c=relaxed/simple;
	bh=zZ/9cL7PQJr2mb5mkkgl8QNczVtuzBCOrluruDc4tyU=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNz6UZSESPf6T8/fNMvg3cVSjWhOGLrMHSKS3TnHj/ZfdCCUS1wKQYowFodO5ae58sfFxBZIlSgqN2wpnckI/QnVFoX//dMDj3Zpw0W1Po8g3kCUv0W3cElR6rKe4cREDu5NYBHkKG5kYW4RyvDRbmjCp/VuRfSIxKinXVdgjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdiZTtIq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdiZTtIq"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fbe639a76so541043466b.1
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719137491; x=1719742291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN2J4XLrjnEurbuugD7zkVkyfpsc1yaH4QUGuZz4xq4=;
        b=FdiZTtIqsXkfqrGSNJBSkbxjiNfWGD5xgaWN+H4SubmtzFkqN0C2shxTbG7oiFt1RR
         FV7WXhU7cAvZWJ3WnXypgBjSQ4qHlNtxX5zBUKlVSJJTZtMfTYJncywo89qZ6S+OGBnu
         JMR41CUH/16aiGuTf08xpkFq2OLsEEinOcKIQDl8+GG/9FKR7td8xrVedBZJMCNi4vdw
         9JXzQGdO1qVlKTCV91cCMxjj4wKVao5cUFwfoQY7dH/MZ6MIGpjW8GnfMUU8M84YDzL4
         eiTv3p4eEyrlRmrltVDOX1660cZtzORgv2VgarPkDYC5se2045haw70foIqkZFNVVdPJ
         zTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719137491; x=1719742291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xN2J4XLrjnEurbuugD7zkVkyfpsc1yaH4QUGuZz4xq4=;
        b=iGsXFzN+Yb3ey5Fo3vYRh8odWodWS7ckr8TkJmuyJyo90AIiI+g8ukkMBNZMToYQ5q
         WMN4qg1Az1vp6sfOMR/hzQCYIQYVGrZUwaMAMj8hDdvWCh4vbqeeZERPMZljNB1dWnvL
         1tqL4POGOKD6W1Wbesd4EUt9U5JA2tkJlwQ+2zmcdQgpErS+4VEeNWYaq3baoVaJ+Tu1
         vAYlRZMto2XUgW7Uyu2SjwcTKX7lvgG+1XUBZwFGizZI1qNKsQUHVfO5iKZwCzTYBP+R
         Pb1zuHaGCor4D2p404mjfkepCyeFt6JMUMoAdsCSBYp8ldSjpmc5cSmzp2WKm6ZtPtHd
         06Bw==
X-Gm-Message-State: AOJu0Ywz09EST27B/DqrdpYNLHQf5b/mZnAZO3QkKFMW6JGBVi0y4pV3
	17CKj8uScgJV+hUW0FEaGlc+nomihj0a/AXXvKhF+qZHZEPpn1QkAWRwcw==
X-Google-Smtp-Source: AGHT+IFVCy3EJNXqaEEultpdPAzq5MxKX/SCpoqhnIWI6J7s0Jfz+86efkXr5/A4gIXjxLs5nQ/uEw==
X-Received: by 2002:a17:906:580a:b0:a6e:f793:fcf6 with SMTP id a640c23a62f3a-a6ffe39d9aamr208396466b.16.1719137490498;
        Sun, 23 Jun 2024 03:11:30 -0700 (PDT)
Received: from [192.168.1.69] ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf4ba8ecsm288548866b.92.2024.06.23.03.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 03:11:30 -0700 (PDT)
Date: Sun, 23 Jun 2024 13:11:22 +0300
From: serg.partizan@gmail.com
Subject: Re: [PATCH] Fix default font scaling
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <YY2JFS.UYR26AJBROJJ3@gmail.com>
In-Reply-To: <506e1f16-ac02-496c-a9dc-414726c1c37f@kdbg.org>
References: <20240615085345.47278-1-serg.partizan@gmail.com>
	<5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
	<Q1B6FS.FVKOG950Y3UN@gmail.com>
	<abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
	<N75EFS.1X38FZPYSV94@gmail.com>
	<0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
	<3M5FFS.HXL15VW2HPOG1@gmail.com>
	<506e1f16-ac02-496c-a9dc-414726c1c37f@kdbg.org>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5; format=flowed
Content-Transfer-Encoding: quoted-printable



On =DD=D4, =E7=D5=E0 23 2024 at 11:13:53 +02:00:00, Johannes Sixt=20
<j6t@kdbg.org> wrote:
> Am 21.06.24 um 09:18 schrieb Serhii Tereshchenko:
>>  Thanks! I tried booting into Fedora/37 with the same Tk version,=20
>> and it
>>  indeed does not have this scaling problem.
>>=20
>>  Then, I downgraded packages on Arch to 8.6.12 and 8.6.13 - also no=20
>> problem.
>>=20
>>  The only version affected is 8.6.14.
>>=20
>>  That's probably a bug in Tk (and there's quite a few reported,=20
>> mostly
>>  about "tk scaling" https://core.tcl-lang.org/tk/info/1de3a48312, we
>>  don't use it explicitly in git-gui but on my system it is set to=20
>> 1.3)
>=20
> What is the best course of action now? Since this change does not make
> things any different for me on Linux+KDE, I am inclined to pick up=20
> this
> patch with a modified commit message and code comment that clearly=20
> state
> that this is a work-around for a bug in Tk introduced in 8.6.14. This
> would help users who upgrade from an earlier version of Tk, because it
> does not look like a fix of Tk is in the works (or that the issue is
> regarded as a regression by Tk people at all).
>=20
> Suggestions?
>=20
> -- Hannes

I tried running default git-gui and this patch on macOS 12 Monterey,=20
and that version does not have font scaling, so there's no problem. I=20
will ask around and maybe find someone with latest macOS, which has=20
font scaling, and see if there's a problem.

Patch does not breaks anything, but produces a warning due to system=20
fonts being present in 'font names'.

Then, if turns out this linux-specific problem - i'd limit this fix=20
only to linux. If this affects other platforms - i'd filter fonts to=20
only include those starting with 'Tk' prefix.



