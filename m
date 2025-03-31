Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA11C5D7D
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406498; cv=none; b=Ay+M3v+Rm/pJPc8hdnoyecxACPNn3W/EjKiSIcNZ9RlfrlQ0ZjFrv5Fo9+cUVBszJXWd2OMoK+9Y+9cF9RYSLZ/yaSDowpS2VlfVwF7hcFqQP+UpjQdMMQ+/pbqSSY6B0C+S9P8763p0I1dor4cuunmoOchbkWy528mSpkzDhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406498; c=relaxed/simple;
	bh=gzmyhE32V7ywoV2bpNWXhMHLy8VkAWAKgrpdWYMhAz8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC2QoT8w3L20Vmc6XBkigBHXW2XDJvdnbJcLhL+CWjU3Vhm0d8GNPhr960a+Ng8tvlzPEn542MdAYM6Yv5NaOymUKZJS8lTSX4HYUni5L95R7hGA+f9dp2YQA6LTrq0XUzZYZoguENQg8XExRsbpDKuglCYWX9CLmpeA6u9EEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhPLuaQF; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhPLuaQF"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5240a432462so3938669e0c.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743406496; x=1744011296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wukoIwuPK04vpk7kHGBk0r8vhW/lFtgPqX088tL+RnE=;
        b=hhPLuaQFDxyif5L7mtLZKDC024fjtjrBDt1Axz5qjTzVy4O29QmqGcCLIQIsnemNtV
         AZOheIoQGbDYhmiLDQasBFLs7vT4rKDyyTwb17rs3MuAJ1VELHpSZDHHgm6iBB2iFWYr
         dlwx0KoxAOL0UzGfmV41Rh3RG74JzEV5ZonlcHTP+sApirTJmY7fXQJr4A1/78q8tN2N
         aPj5ffyXuFIx6DkR6++l3IWM5HmJ/DTEz9q4EweYghVZquLioHz6++XbDJkSOAx3AZc4
         pf/44FhH8DQjJk34uqAiAK3W27FSiIQ2xOzw43pWw6QgGmyU045ONwPLal+05vpjpSzh
         ze6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743406496; x=1744011296;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wukoIwuPK04vpk7kHGBk0r8vhW/lFtgPqX088tL+RnE=;
        b=CFHkRiwHlBg2JexNw7sQlkt72eOA88wYvbvnKQXmwhADjydTHvMZ4NlJA/dLkJMRLf
         K3Ko4Bthh/6iGUNet3UgnnL5Wxj1sh2mpFvboxKXiJl5xMk52gp3QVwYiJeD7TfmVm9l
         pRUJAZzFzeLZvfxk7uWjF3epPsj3RE5sAV9VgAlyLrZfVvqO1YNWUmDGhAUItB4MwTis
         wLQZi7BLxiaK6Hg+aE4mGok/zh1paXchsXLsgVet39zryN49TLEGf7hCCEn9xeGjt3TG
         WDJicidChcGs7o7GSot0F2xvsipW3wpP2kCH0BZ5HvgJCxHTUju+XYLYgLGTa+9kjE2D
         397w==
X-Forwarded-Encrypted: i=1; AJvYcCXWdV/r9/YaONG66opUSfUmcVj7XQaXPDr6u7waCU5R4bmC5sLShhhoqnaOYtx00K6S1XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7F2FLI7O9XbE6A+wj6CnLuA5gzRqNtaZQOaiL76xBg7SKDBn
	GMWeMy4sQugzOUk4seref6SLYAJrRqLRfJp+jGx5qtoRhzS8PksSAxQT5cpuRCjllihH0xRrlGa
	p16cpLEX5j9ttEt1Cvrp5i5yL8z4=
X-Gm-Gg: ASbGncsZclEYcWvbSVq7G5UoeyVVslMnGYNVsF2YEIphTeOEW1UNsX//jkKUKdmNtqS
	3pAATfieDhou0TdhOetnyFJtT9pUuu611aP82nYwiDOgS3ssZK4TBxDLB7EYOAU90yxdJja0o+A
	9dlDIqQkwW7NAM5IuJt5xnlvVD9pN3ORI0e+fOMEASrW/17czm27dj93SCq+I/P+p7KBNZ+w==
X-Google-Smtp-Source: AGHT+IHLnZYFJcnlDIAp+CU32XH0+4IN7dz2sIu8RjuZNa173Qaq8Sv75gy4y3fFFHdD/2FQ0YhQQMKM4lVMIi5qrOY=
X-Received: by 2002:a05:6122:2105:b0:523:6eef:af62 with SMTP id
 71dfb90a1353d-52610c95f95mr5964867e0c.4.1743406495706; Mon, 31 Mar 2025
 00:34:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Mar 2025 00:34:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-o-suJAfu5yc2AW@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250330204339.191382-1-karthik.188@gmail.com> <Z-o-suJAfu5yc2AW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Mar 2025 00:34:54 -0700
X-Gm-Features: AQ5f1Jo40csqwjobzPg-rGseKLwNkshWotxd8geSVy4g6aLvTNCk_ORQMQ2gRtk
Message-ID: <CAOLa=ZTxjgdndbFHOC9dwxbjo6hUyrmyddGH1uhS0WYOSpY=fA@mail.gmail.com>
Subject: Re: [PATCH v4] blame: print unblamable and ignored commits in
 porcelain mode
To: Patrick Steinhardt <ps@pks.im>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	gitster@pobox.com, phillip.wood123@gmail.com, sunshine@sunshineco.com, 
	Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000e05d1f06319e749d"

--000000000000e05d1f06319e749d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Mar 30, 2025 at 10:43:39PM +0200, Karthik Nayak wrote:
>> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
>> index 370b768149..50a0a7ca4a 100755
>> --- a/t/t8013-blame-ignore-revs.sh
>> +++ b/t/t8013-blame-ignore-revs.sh
>> @@ -158,6 +158,21 @@ test_expect_success mark_unblamable_lines '
>>  	test_cmp expect actual
>>  '
>>
>> +for opt in --porcelain --line-porcelain
>> +do
>> +	test_expect_success "mark_unblamable_lines with $opt" '
>> +		sha=$(git rev-parse Y) &&
>> +
>> +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
>> +		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
>> +		cp expect raw &&
>> +		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&
>
> The intent here is to do two replacements in "raw", right? You can do
> this with a single call to sed(1) by chaining "-e":
>
> 	git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
> 	sed -e "s/^\ty3/unblamable\n&/" \
>         -e "s/^\ty4/unblamable\n&/" raw >expect &&
>
> Patrick

Nice, I first tried to use `-i`, but seems like that doesn't work with
the 'sed' shipped in OSX. Didn't know I could chain it. This makes it
cleaner.

--000000000000e05d1f06319e749d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fbed3844595d3cce_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mcVJad1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEFlQy85NkJrMEQ0UzcxcUpLaWoyZEJiOU1WUnJKTwprNk8rRHBnRVRB
dnlDWHJ6dEN2VDVSUDVNdUlBY3BCMGxvL1pmL3ZSWlZiRkZrUEpMUHNnTkhmY1cwRUtJSGhICmVP
Wk9NbWZSMm56bmZNaTVJczR4Z0lwOXJETHFIMjh5aGhxTVcyTUxCY0hwSzF1aEFhMWdDcWFMSkE4
TjMwSjMKcXA2S1ExcWoxdS85WXA3MEwvaVUvdFl6M2VYR0x5V3dYNWRTWXdGME9teFR2aVBXMWJS
QTdObWQxb09lU2R6ZgpGa2t1bnN5YlMydlRJT2RUTlh4ajJ0RmpTb2doNXRnUUl3NFZhUU9kUWND
S3dpcnNRK0p4VTNHK2lsZEorekswCml6SWt0T3ByL1FPMHFjOGM1NzNtZ0kwZ2h0SzlyMUx0TGU0
NXVMMTFWZFJvQ0FvVklBL2NRSGFwdFFxNU5MSUgKUGxZV3hNc3AvVTFTNVRYdnF3SkQxQWEwZkRz
YVM5NTRjZzFsMmdiS3JYajlFWERFTDNtQ1p3VjRvV2tTZGJJSwpBSk5EUEU2NEFwVnIwd1dmWVg3
UkZtellUeFl1RFRwZ0ljK1BxOFkxaFN1cGRFSXJDM0tLTlJFL1ZnSFRLclNFCmlJRmxGRU84OUla
SHFsS3BGaG1jNlV3QUlUVHQ4dmZ2T0owVU5lQT0KPXd4VVoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e05d1f06319e749d--
