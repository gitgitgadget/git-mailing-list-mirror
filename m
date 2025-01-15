Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4021153808
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958361; cv=none; b=DXEYZTv0rlosQY2IUTZDzz13vf6LiY4kwsrA2GxC9jzZBhnp78mBKfhvco24vy+/Ge/mh7X4jlvcwNW3hijPh+jnXIjsDGrLVGObabhxqlPBcoUVsdELQ0sDwZHt9sWrrWzJxvBNfddYv01xB4NKCmMFXdDREtbsulba//VmVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958361; c=relaxed/simple;
	bh=wp0qqqnIPBwNQxqf3i5YAVpCFZj+qRbwj+UsWCSmozc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUXuQ2L8CK96v2M3NnELLZUJ8huYg6J5wbfkblfMR7oGAMmKpAOpkZ+3OsOIXk1m4k4jn8vfR/BpKCLv7IafGK1ouLfgKyrGhTvfGTXQ5eM9quDbOT0TBFFYx2r9HLXzmh8+c0prtPSDzcHmUc9rvdYAoEJya1A0NslgPmtw9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GginGTt/; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GginGTt/"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b63d564e13so2349120137.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736958358; x=1737563158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MbyV79Sc6xchAJdKHNk90zw0HPHBDz/rCZG2JLF8q8=;
        b=GginGTt/5MW7FN1048hldla9TGWVb5ju/5v4UTPlsZ2NLuFLiYJbGeCOr4YgVuhUq9
         OmnUDMz5bgyJrdXcQ6BSqtokPJ1TEkrsL4Ee95Zded4OGvQZr2bSSOqlnJ2VsgvMD+nG
         oPm3HInsX0vC5y1dQyaF9qoce5FMItIbiDgejxdpNeurNb0nLn3JLw6jfNH0if3bGmGV
         0Zw6zVHodD85xpV0TiLHEjf8HopJfyeTUsosX33E6vXn9YZtW+3tIoyym/HlNNGodA2p
         pE3U5P2942NeLzxsBrgUkVgSe/4FdspsjL4UjcUB0EDuLYp7biOAvdjjLP+RDeznZNRR
         6nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736958358; x=1737563158;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MbyV79Sc6xchAJdKHNk90zw0HPHBDz/rCZG2JLF8q8=;
        b=dJBtzTqQbtVVJg+NHhwpiA1J9nsXN3rXeTdo8xKGszsBn0VsbGz82eK6TIZckB7pL5
         KqGsQFvlVqD8FtQ9hwKm+uoeW+GNPTqcsKXs0czf0iYEn7PDDFxYHKrtEpfEFmIFLHvh
         AMrfbWZXyD23Cydtf71wk0enNzqfG01m0iSLyOAV7kouGr9OeBghPzMdyhx+au05/zw6
         c9/Z6cqTfKdU/26XHWYV3P8YaWB8Oq9f54y5F7UOFtoHORsrZb1vNiiFxyn2/DvfYjaM
         DQx0Q/ixPo0O6iLdb8ZZYSTWtOtzdw4XWrKpLHzlEeWDwNQzyhGePCnUnu+CXumiwsaC
         /fIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGP40n61GrcAWmKWSg0CB+MiaXoU+7ro+ifEXz+ex2b1EYpOlGXpZt4QtMDrZIXhwQkeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPE2IUn+rxd4gxUXamv0PFq9yhqi6iRz0GDzLUMCzSw6gd1pQ
	6X6RsSqWnNFdUnX3oVRnLsVUv/CMvtv+Upu7vl9C3C3D9k0Rv1uhhBn4ETkqhFBmwVBRIQU82D4
	ruoBITPIgsPMYmnOzo78rGiJ97T4=
X-Gm-Gg: ASbGnctxw92agNVMT+P2t2yA9LJ78ghjoJru2cBp7syPCNo0A0DE9NklW98yoX1T4dO
	8ay1ksHnU+fnlwHy4LtwJQ9W/WNdtpgLGv0ZK5QQ=
X-Google-Smtp-Source: AGHT+IEVZSnN6OwE24RgRTFs+Ao6s1uO5DeRZ3AQHjAJ//ikSHmf884EMLyBuzdK8X0ZyWm/NtLj+Cn+AzTsXkXodRU=
X-Received: by 2002:a05:6102:160c:b0:4b2:adce:bcfe with SMTP id
 ada2fe7eead31-4b3d0e67683mr24808279137.22.1736958358614; Wed, 15 Jan 2025
 08:25:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jan 2025 16:25:58 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-9-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im> <20250114-b4-pks-compat-drop-uncompress2-v2-9-614a2158e34e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 16:25:58 +0000
X-Gm-Features: AbW1kvYUVCyVnA6xBlLRRduDYI-EYCC3dQJoMu98lCPRjyaoENjOD5HxLEKY_tk
Message-ID: <CAOLa=ZRiRWubZJHvzgag8Ypaeye_xzZ9e5bdZxRBQFL_qhzb1Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ci: switch linux-musl to use Meson
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000f4c6d2062bc1212f"

--000000000000f4c6d2062bc1212f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 8885ee3c3f86c62e8783d27756b8779bd491e7e6..71d85ae85a02e5a4389e133ed53f45a5042af36e 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -378,10 +378,7 @@ linux32)
>  	CC=gcc
>  	;;
>  linux-musl)
> -	CC=gcc

Question: isn't this still needed? I thought there was no way to specify
the default compiler in meson and as such it is better to be explicit
about which compiler we want to use.

> -	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
> -	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
> -	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
> +	MESONFLAGS="$MESONFLAGS -DGIT_TEST_UTF8_LOCALE=C.UTF-8"
>  	;;
>  linux-leaks|linux-reftable-leaks)
>  	export SANITIZE=leak

[snip]

--000000000000f4c6d2062bc1212f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b9c2eb475804266e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSDRaTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnJ1Qy8wZTdKLzlWQ2hiZCtSUlovV0I3UjZXNnJEdwp0ZzRIS1ZMU3M5
Tmt0MnE1TXdaNXNYSXA4V2lBMm9PMVhzeHlwbWFqLzR4b1BvRzNPSDBXaE1WVkV0a1F4S1lOCjAx
WHNuejRlTitjQVVmUGNNK09pb0RXdzh3TmZZc3A1T3UwSWltemoyTWVlVlVUcDRFWjBldzVDRHNF
RjRUY0EKMkVhTTN4ZEppbEhGOUNnSUVEUGowbmM1Z2hFaXdRL0dkRENSMTZiZVVvYkxESVFNUGNs
ODVQeERYRVNONTJ1Rgphc1UzR2RkdWhkN3Q3ZXFBUk84eE4yVkJYZHZXd3Zib2VDUmFueFhXZElr
dVVkRU81dTkvR3k0NWZVa29nbDJwCmQ0ZzZxWXlGZHdUaHlHNVJFU2tERG91b1RYaXRqdXFudlpJ
bGhpa2pUdjF5WUg3V1NDYVZOc0tsU0Jqd2ZlMlIKQ0lFd2trbnFNY3BETW9acGIyV1dhVDhnY25V
cCtsL21zRUJrR0c0ZVRZZFRnOVZnRURqU29YVThGTnV3YVJsNQpnQ0U5NFFjdXA5M0xjTS9DaXh3
KzhxRXFFMkJXTnJXZC9lY0I0dURYZlBFYlhFdjRWWjJJRDdIdGhuUWNYSVdICm1JcTVLZ1JPOHFI
UEZwRXJDQXExckE4eU5CcitsZENGanFZRXJsRT0KPVJOY2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f4c6d2062bc1212f--
