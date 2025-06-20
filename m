Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D023AB9C
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413265; cv=none; b=c/JjiZAY4j0GcpQHVoGwJdMT3Ac/IHMxKB8woLi36QQgh4/CH+BHx/5N8f5Qzac9jClX6N2sYZ+sdKse+njFFpVh8Rc5GLDv14I+IRPa61+PlaWxzTeVNrOpkNj+yameVwErHdq2aJkG2vLMOEu6pferHX1jPDPGNLjhwuaxk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413265; c=relaxed/simple;
	bh=jPlftsksZLm3HDTsYNl6jAoQldgzL+HhOs3Po9+KyJ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEscduiPedRUzsyAEr844eVBqCmF6s+dX6+t2c/zR1tw7F8FBMLfsGlhXomBEAh8h159s4M5Gb+I1Y4NoypJ5kEvkiOmgfPD/U+Wka+UTwFWlcyfSKCyM7iFZsVFgIUFIs78u6R9VAvUHOgWWIDlhhZldh2Q0q4vUdIOVkeMILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ66i5GD; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ66i5GD"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-53185535ed9so1151243e0c.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750413262; x=1751018062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrYddkb6Up+K5NJVgh4YRCHJlB2OMjkuGpXC0RJ8kts=;
        b=XJ66i5GDim0E3qjYbekPBppeotMxdkt9RhxLbVw7eQCMKXLAga3405CZ6UK3HhDvlf
         X8xUkhwCsS/s1Ee1V8E8Zz7wzr8XB5H5NCjGIHXidHkfvhckYgnfGSqL/S56OirPfaSE
         l57UqtwLMaKLz9XOt7k9u0s60fQx34RRPFNXPNi8zGbIuR6Rq3Z7rvONxEYlAMzq0ZpV
         0Li6MiZyix3Ly+JGC4SVPqSAO7vtH009Hv3OUnQa2+coX6xp4JxUj7lqVq7zOstxyBhN
         omI+qQ0rlNen3wp38dWeJOCxijpoAMtWvmDfvXvg313mVCMBGcKlNwXl3AqGuAB41I3V
         PsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750413262; x=1751018062;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrYddkb6Up+K5NJVgh4YRCHJlB2OMjkuGpXC0RJ8kts=;
        b=f5BSp2kMh1tx1sbrxrWl+yncWZKMpnQXRtBsgoaNqgazXc9zkqUoPwQcg7TPfNiTzS
         essOIJK3inuw74wet/bHlx+mdCEgBwyHaRXYyC3x/zunWxNGSCtM6ORlGt4FduxIAloR
         G0Uu8XN7LtLXZz57muDn7VaPDY2r+MQXjkU0ePIIoZR8cR/l6cCsvspIgE79MdY0HgsL
         sUGt+WhlHy9cZOoQd1nRmaH5sKW+csh3z2hSrdS7rrFSi9AO5gOqznDIE5DHXcImIypP
         mSWN9bIbHm1AQTz7kIyWepguSUbGZIf+jHEKlhBVLhAx3yH2XLvjoDbMKGtjou5Wq5+X
         WI4A==
X-Forwarded-Encrypted: i=1; AJvYcCWxVm7S/HmJg3yhvkVnzRrYknurJV6Ezyl4H+8V9Nu9dPnm0wkJpU6pTMbYH+Zg3T+pkA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sPotXBBR8y7M4V9iZJ3AWBLD1iIVctk3ZY9zTLIwNyw+lJT6
	1ac3BOvuLUiCmOAj6/JeCJNASk4Rj9C/iPP/9G/LbxCHFSBLCgkbWnGA5Qlld3AwWahsuEREy8C
	JcmiFpZmVLcUkO2Ml7h8knfpjuqvSy4I=
X-Gm-Gg: ASbGncv7CNNcKdCjAuJWeeLiqYgZQC0s5MTNuBTgr8V/lkoaK/fj88NxQEE+20pni6X
	K+OIQJuTLBR8oGNXyP9mjpA6DWlxXmWw4xwg3nMhkDiF3RU1iX+12eBAKIQqz6OCS7rX5dzDkBX
	lHrkpaFkjSAbpk5CbjPbf6PUkhe9g6sAYGtdG4BQe7
X-Google-Smtp-Source: AGHT+IF1vm39MXIupNgrbBlhZWJoN9QokEltyqihluogCxWdxHc1TbsRk3rDd4BkQ5hWbMroxSjmo++beGBdZqExqHo=
X-Received: by 2002:a05:6122:620b:20b0:531:8ac0:30f0 with SMTP id
 71dfb90a1353d-531aebbe213mr350771e0c.7.1750413262461; Fri, 20 Jun 2025
 02:54:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Jun 2025 04:54:21 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250619225751.99699-5-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com> <20250619225751.99699-5-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Jun 2025 04:54:21 -0500
X-Gm-Features: Ac12FXzAq88gJCT3OcHtOgQqZaa1MK4UHlRk2LMTgd81GwjCofoIQEOKDQy6H5o
Message-ID: <CAOLa=ZQXeQX-v2JmKTpaJDLwWWKQSXoMUGbpmD6xx8KpbY91yw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 4/7] repo-info: add the --allow-empty flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, ben.knoble@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000b83c930637fdd83e"

--000000000000b83c930637fdd83e
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add a flag --allow-empty, which will force the output data to be empty
> when no field is requested.
>

While you did reply to my previous question about this flag. This patch
doesn't sell the need for it in anyway.

So we need:
1. More description in the commit messages about why we need this flag
and how it is useful.
2. Documentation around the same.

I still think this is early for this, and we should add this flag later
if the need arises.

[snip]

> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 998c835795..db4a6aad17 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -15,11 +15,12 @@ test_lazy_prereq PERLJSON '
>  '
>
>  test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
> -	git repo-info --format=json >output &&
> +	git repo-info --allow-empty --format=json >output &&
>  	test_line_count = 2 output
>  '
> +
>  test_expect_success 'plaintext: returns empty output with allow-empty' '
> -	git repo-info --format=plaintext >output &&
> +	git repo-info --allow-empty --format=plaintext >output &&
>  	test_line_count = 0 output
>  '

The earlier patches reference allow-empty without really talking about
it. Which feels odd and misplaced.

--000000000000b83c930637fdd83e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f2a069f149b9903f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVkw4c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2Y3Qy80OUp4MlQ1djRMRERmeWtFaXUwYjFTSzFoTwovVUg4aStOdThy
cExBQ0F2TDNFWXROK2lYUjJXMTZHdUgzTWFuRjF1VGZOY0tzajR3Z1ZSQU84Wmp5dHJGZ1F5CnBz
eGlaZU1uV1NwY0dLZGZCanlOUGtsZ3p5UzZWNTdSdWhybmwyRWVLSFRwOU9rSXhhUHJQWkY0bGht
M29NQmYKTWtOYVNlQnRpd0NSRVpIY3BRcDhVZXVLTWhkMDZxSnJyRXM0alBiMmFMQmNFeTR2d2J2
UmI0QUs1QXY3NXR5Swo2WExwdDl1MlVSeDF6NVlFNjJkdFdjUFl6Y0ZqWHUzQWNVdFZ2VC8yN003
a08wdnRWZ3Z4dExoRkZJTmVsZDVsCmVTSkFVdWREOUl1SXVQWXlUbE5ucFQ5SjY1T3I4K1ZYdXBY
SFgwaGJRTXdMdWd0MnFNckFWdXJKbFFKc1R1WDUKZ3RhQk9XVlhNV1FPaUlqblZmZFhCZ0o4eTRM
eHgwOGxwMS9hSWJDcW1HeFdTY200anJKb3BNMFNnMnFmSDN0QgphaDJBL3BJVGVPeXppVVh1Qm5Y
RlVPRk5zZ25sL3pmUGlHa3VwWUdnSjE0NjJvZWpnVTkzQzZDMVllZVQwaGhWCk1kSlRzd3paNWdD
QkozQ1RiY2pPYTJ0M1hKUlFGNGw1cnRQS3pkcz0KPVdZY3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b83c930637fdd83e--
