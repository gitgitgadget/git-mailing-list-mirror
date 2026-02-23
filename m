Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADD1A9FA8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807703; cv=none; b=rwxwEPPpzIKyvtYWPhgrsf4aq+YtbOm5qSFB0s+SUK+6xJH5HL0WfD/Aubntdqu7lwUQXgRN3qFzcP8kP3Z6GtKgmIRRNzKJJ9kegE0vMWXAmkQ2gY7gG/dDndXGInFYd6X9UnbdyiWPLmLp5ejpfsztjCM1fETVjVHePLGBRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807703; c=relaxed/simple;
	bh=qCmtFFGXkDiendmhUkL4L91B/9Z9aCgD2ico96VFDnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjvBOgNg+3q/ND0ykeZbQ0yVS+bzyBp/99nRn5ceHTCBKzBERGiMSMdAGgCPkW69SooSnfHYuzNR7xkImEunRvHH6zUooGKU7VMtQQAPlUf/hBV8mmbfpUbwV8govqY14MJ8HNEAwBXgt5fiwPO1AT3s0lFCo6HYd1D+1Gy1+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/QSvNJB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/QSvNJB"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896f4627dffso52581646d6.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771807701; x=1772412501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nkb+lWqDMog+I7O9lTj1IYOg77OaPtK/dGb/3qXVQ5U=;
        b=j/QSvNJBL+qYNSwOrhK7y//MhpkiyI+0Ndj1ROgrW/gCCKuO0fl/MLaks2SWb1dK9L
         djqr3vGtMYuzC+x00HEgLrHT5duW34yrWsM2mIkMD9stayVAw9+OeeBJp+iiQDeKINsA
         BL03kdr6xr/0SPGGQFjRsTZqWOhXTFBgvacGlqtST6Lhnf9pRDwtgfGCjYK+wG+fIlh7
         TEUSEtn9LVSQZwfHVGhjDuWdOQyJCBcnKYMtJmA5moAPf275BUOVNVIP94IL+m+ZrTTT
         QUx1f+YP0cIgRwktIHz7wLOeoLDc/JJUKfooUEs6AxsUrmGv1M00aTzrDCH2cjuAYuqK
         uNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771807701; x=1772412501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nkb+lWqDMog+I7O9lTj1IYOg77OaPtK/dGb/3qXVQ5U=;
        b=HVpS6/Dkub7LUrucbSTgeUnML3B2bFCa7dVaAmjjNb2XoxJx+Ps0qfoeYPj/+G+xEb
         hL7U9WgtHgLfdzsxl9aYHd0eaFgROVokT86bD73dGaEXrBhPL/IlMYUZld7j17F4bvIL
         j8Jy9k2XiXqe2YMVb3xQBrF/tN5+MpzK24s/KKX3pDgVPv0Md/2I3HYa4boPe9CEohRH
         LG8cnd0EJZ4jzXQ5YOPPURkq5RxDmlJ8Kcq/+xBElw0zcowHiTRs1Z7c1dy5TWYH22hZ
         fM6akOADqi8MxNrpPXOZ09oNIWA0LE4OK5jTNu/U+jbTnFkC5r9fhcQ0x1jxHkPSymgl
         gUtg==
X-Forwarded-Encrypted: i=1; AJvYcCXK1h0ltiQtKTWmANM0xjLyvPBA4okxKeSCL2yn03XC1g1J3LyhmZT6UjGEiafdg72Zddw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82FMxRZnDrV02kJK7YFXRPfn3Bh02N1zT+fobmvSEIvwqGkI2
	URzhWUrTTa0Z05WK2MD2vGMLLI6jUes4KCw90qtEFn8wLOaoORU4hfqA
X-Gm-Gg: AZuq6aI82OWh9fFLMh7hVfetzK1xKmQsCjc+DTVNI8yncvgpNjV0w3BjIKL8lBrnU/9
	K5eqNIXPhBwbLJ0rsy0s8UyIPX1y+3mNErDbuo/AsxNGnFNgJsQNfzMx9A+osrDqFvTJOrrYp2E
	Pzmg9b10yOJzhBPrG8d+vUU4pnjI5Ra39TJPIILO7YkSU9Oe9GIxzhW6vNyE2lhVElBjBzf26Sw
	wcHZ2qNO1E34aZkgSOvYbmBdKd5RUqEO/XuKspnXFES6KyrqfSpCgextSFc5YyWxPLsH5Pw2MM4
	roziicxpQai4oCEmqR6xtAp64FAecajb/mxUjuQRZ7hMXPvjyOLtBGWT4m1ohbkAGv01NUKTC5z
	m69VQcT8o6JsKH1blmV/6I/5/HpXrKxIs8YzuehZAx0brbM2aeCRg8npgjJPDCTorR0NAh7+huJ
	chg00FkyJw/zjayxX002kLeTnEIOT9lQWvbgIzRBvkOyTJ2cUSjy1/a/3z4+ucS42e9sC3U7Jx4
	NdXqS7TkE6sEPGk4U9vDy3RacSfkGdmpze4soiiAwPn8PI1
X-Received: by 2002:a05:6214:40a:b0:88f:a4a0:2ddf with SMTP id 6a1803df08f44-89979d536fcmr115141456d6.46.1771807701401;
        Sun, 22 Feb 2026 16:48:21 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e6341c4sm54555506d6.35.2026.02.22.16.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:48:20 -0800 (PST)
Message-ID: <86490d73-dee3-4750-b99c-ff94848bcdbb@gmail.com>
Date: Sun, 22 Feb 2026 19:48:20 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] t34xx: don't expire reflogs where it matters
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-3-faeb321ad13b@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-3-faeb321ad13b@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 5:15 AM, Patrick Steinhardt wrote:
> We have a couple of tests in the t34xx range that rely on reflogs. This
> never really used to be a problem, but in a subsequent commit we will
> change the default maintenance strategy from "gc" to "geometric", and
> this will cause us to drop all reflogs in these tests.
> 
> This may seem surprising and like a bug at first, but it's actually not.
> The main difference between these two strategies is that the "gc"
> strategy will skip all maintenance in case the object database is in a
> well-optimized state. The "geometric" strategy has separate subtasks
> though, and the conditions for each of these tasks is evaluated on a
> case by case basis. This means that even if the object database is in
> good shape, we may still decide to expire reflogs.
> 
> So why is that a problem? The issue is that Git's test suite hardcodes
> the committer and author dates to a date in 2005. Interestingly though,
> these hardcoded dates not only impact the commits, but also the reflog
> entries. The consequence is that all newly written reflog entries are
> immediately considered stale as our reflog expiration threshold is in
> the range of weeks, only. It follows that executing `git reflog expire`
> will thus immediately purge all reflog entries.

I found these two paragraphs very valuable in explaining this patch.

Thanks!
-Stolee

