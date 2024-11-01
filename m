Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537819BBC
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468776; cv=none; b=bUuCiGx5YHbj+ot7oZK1pShsyBZ27656JtiLhtEGYVKZxhXOgGURJ43iVSpgR66zbtcLPNlWiHOFcWIgmO51+2Ykzet+S2JhcIZyBRghKSv1+eC/7v01ZNdSBqEes7cvPbLnDgctrUxNGGUAa9271jtUXAqetGWqigkGdQafMf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468776; c=relaxed/simple;
	bh=Dt3QvnmaMn/w5ujQICkzTvmakyz0BjA1LRNKbb7AfPE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRz1kfrcMhSjZMCnoTm85yIvm0nBEIMu/WEcW/IepaaaSrHh4XdOx2mQMGxWXkLr8VFKZGclJAXgpMSZ8KhF+I8Alb43ZV8aLPNElrjv1y0oujid0XNQve6duHtX+gxPcm9EuGURv+qP3TAFH+ivkVWc9LxV7KXCdiuhmM+GQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBOL6Ukv; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBOL6Ukv"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d487a93a5so583634e0c.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730468774; x=1731073574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6hgC+hhLr4LiUzzhDk0hBaPvGHKvxoRfyNbVGHDh14=;
        b=fBOL6UkvSKVF5Pe+bR4leo7bDTrPkZB5bKqr5Oxlf81gze1w7+vuQbzi2NCUgTLnqY
         xVbITmbbR+o8IuvXLK8dVPQgYOTDayNK3QM5JNEnqMYp98PD4W0J9h9kJXA6AHKpRXS6
         PDwToWJaNOqV2l+Wy5xHVGu1cMrZmlG+/rxQkYxCOOjqk3K1H+Ht5GjGCBKqUXvV/ag0
         eTT9y9dXNdw21cqOwP2QF7occz6oBBSbwMsVqJvVhItq6sq8ksqr2osj+2fa4oQXLHie
         z1+3F6zLReo7aOJHvmWB3SZ0eomVsIquq5y/YwQzetoNtQYvfiUlckguz9oj1S6qR8/2
         CreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468774; x=1731073574;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6hgC+hhLr4LiUzzhDk0hBaPvGHKvxoRfyNbVGHDh14=;
        b=M/2oaU0nlJQmy/ZxZPlj8GtcIVR66MauLPKMo/sWUbCRRP37rBu1GYD5sXG7mbz9VY
         o/Q+G3PwYaMxSvapJmNxJSzH93LBDDrFYPkKPsUUTwdLw2zi8iDEdxw3ufApDczAno3i
         9PY9DV1Tb6npkuAwvOX8d/G0V5MLfG/lr51CGRVXFEHEj/Uk32nHS+ST9mdFdypd8e+Y
         m0lBH6uT2IOv13dQuuaIur+YmawvvQuVblgF4j6XGpzojjxoa7jmfRBS1XocCUSuMlDb
         20yg3cVKfSAIVNduPioSHY52WCYWAOsG+TU1zRFB7j/6qCbyszX7PJn9y9vLmgK6Q1oO
         m/xg==
X-Forwarded-Encrypted: i=1; AJvYcCUSqU4wiiQ341KWX1jclAG2yG/LP/ettOZJZfklX7xpNm4NmNl9/BEISsNp46V4q6ZAbL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfICSJAI+GmHVgmlEHkSji+1SBaWR5O2I72MET185gSVm38Pi
	iRFfsRKs1fN3o9OLPYK70lGfSV/IAm0sqTXS0WXHxnf4KmdK1M+A6dcpIHKhcfaMC6vL61pxKEy
	/4oOVk8SuLJ/N49IRIm0LKsAYYGA=
X-Google-Smtp-Source: AGHT+IFokmef0lLMbXwkci+ow6eXXk2zRwfusfrTXtc6resGmfwRtbuB+3POm3NjNPAreLALcG96dPi8Se10Uz+afcc=
X-Received: by 2002:a05:6122:200d:b0:507:90d1:e91e with SMTP id
 71dfb90a1353d-510150e465dmr21139071e0c.10.1730468773546; Fri, 01 Nov 2024
 06:46:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Nov 2024 08:46:11 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com> <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 Nov 2024 08:46:11 -0500
Message-ID: <CAOLa=ZQfcroHv_V7YOD0MeTSvbedJvLNMR2RVQ-dWRe8ERpzdw@mail.gmail.com>
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008af7380625da2849"

--0000000000008af7380625da2849
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

[snip]

> diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
> new file mode 100755
> index 00000000000..1f277b88291
> --- /dev/null
> +++ b/t/t6601-path-walk.sh
> @@ -0,0 +1,118 @@
> +#!/bin/sh
> +
> +test_description='direct path-walk API tests'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup test repository' '
> +	git checkout -b base &&
> +
> +	mkdir left &&
> +	mkdir right &&
> +	echo a >a &&
> +	echo b >left/b &&
> +	echo c >right/c &&
> +	git add . &&
> +	git commit -m "first" &&
> +
> +	echo d >right/d &&
> +	git add right &&
> +	git commit -m "second" &&
> +
> +	echo bb >left/b &&
> +	git commit -a -m "third" &&
> +
> +	git checkout -b topic HEAD~1 &&
> +	echo cc >right/c &&
> +	git commit -a -m "topic"
> +'
> +

Nit: Since the root level tree is already special cased out, we only
check one level of path here, would be nice to add another level of tree
to this.

> +test_expect_success 'all' '
> +	test-tool path-walk -- --all >out &&
> +
> +	cat >expect <<-EOF &&
> +	TREE::$(git rev-parse topic^{tree})
> +	TREE::$(git rev-parse base^{tree})
> +	TREE::$(git rev-parse base~1^{tree})
> +	TREE::$(git rev-parse base~2^{tree})
> +	TREE:left/:$(git rev-parse base:left)
> +	TREE:left/:$(git rev-parse base~2:left)
> +	TREE:right/:$(git rev-parse topic:right)
> +	TREE:right/:$(git rev-parse base~1:right)
> +	TREE:right/:$(git rev-parse base~2:right)
> +	trees:9
> +	BLOB:a:$(git rev-parse base~2:a)
> +	BLOB:left/b:$(git rev-parse base~2:left/b)
> +	BLOB:left/b:$(git rev-parse base:left/b)
> +	BLOB:right/c:$(git rev-parse base~2:right/c)
> +	BLOB:right/c:$(git rev-parse topic:right/c)
> +	BLOB:right/d:$(git rev-parse base~1:right/d)
> +	blobs:6
> +	EOF
> +
> +	test_cmp_sorted expect out
> +'

Isn't the order deterministic? Why do we need to sort it?

--0000000000008af7380625da2849
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c5c7cd9b87cbca9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jazI2SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL29RQy85aitZY1AxODdWNG1WTlZXdEIvSUsvVmZRVwpCZWxheU1rMG5N
QW94bk90TUdKUFRuMGtoNDkyVUxNNTZjV001VVVicFV6UVdKT1hnQzRwalkrdDlRK3d5RE5uCnhm
Y0NuOU1NQXFBTWNDVjk1d3FiRWZsekQvUFFjUFhBT2NnSXdRY09xSFhsZCtWcUhXMWU5a0lGbkN0
UmJ1aGEKclEvY1VtLys4QUFBRjFNaFVGaVlKWVBUcExmbEE1OHRjT1BnTTNuL1IyNXdCdTFjempj
VGhrZGpOMlFrRVRjTwpmVGMzeUVKRkxjRU9TTTVzTFVMUHU4R1hoR3pjcUpibkMyM1hzSW0xamZR
QjR5MjlCakJSeEdqakU3YmNqRTZkClo0NWhpb1FjU2N4eTNib05DM3lVZUxFcWtaREJNOU9rdDhs
b0pwUXdGK1JsSWNlZVNwMlIvajlNVEZQU2hYOWIKVjVlRHo4OGNDZ0pxWDJFdmZWQXErRUxXYU1I
VVh6ZHpxV3h3VXNrSFZsTGtFc3dZSUVtc2k4UTZhWVZNSnNGUAp4bEYrZVdRZGl5bHFqS2REckU3
QTgzZ0VaTEkwOEFpeUhCREN2RnR3T3pwSDR1MWZtZHdLR1RkelNwMmFnWlRpCmJEZkpKQ3AxMlMx
QkxBMHpnaUVtOXFVenFrb2xqSElCcWZNQnhPMD0KPUY3VlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008af7380625da2849--
