Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4424BBFD
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687782; cv=pass; b=QumRVMSN4Vq7GGxuONWZXVkZrDEKZaGPgpKOSSZvxj2O+XkMKV3GyBLdN6cg9Qdl3/mchqLpg92xf0EHvRkCcc66PB9HSGsIg4/HCDNal7chIpue0doBlGC4f4i0URPkypz5wSkEfivXvnvKB012Ov53tBEeGKYbQ4+RqHno6y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687782; c=relaxed/simple;
	bh=VtZW/PbBjbnUECXgd1+NHw4Bnm4mKZm9ik6gatjKXQA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rt0dRWOVe6cM8VwJ01GE7nD4sYLvkLJEK7Q8y+6DdRy1AmMBC9WOecyjp25rNNYG4HYs9ws9bUBLJA8WHYGe0ANzS0d/swHHqsvi02a6174hziqg2zsWdfgRg8q6UJkbPfgOj3TxIOVWQo8lzClkemamqbyIXJvt+oncju79Fjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=BQOkyvd9; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="BQOkyvd9"
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bQqhf4X96z3t8J
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 14:09:38 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bQqhf2sPjz3NdM
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 14:09:38 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1750687778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=Yy3BWW9qviq23iYkqfpGsQWY4+YNBYYT0gqeyRGcxQc=;
	b=BQOkyvd9oKd5BnXim/c2wO7X24O2JFlNiLC1oR1ygh31Aq4OohLDcpKhhP3xRq375972pB
	YZH2Kref8e/4uJcDPOQXRfcqYe9dYCh8DUq+SqJkv91C8rI/3PvBW+p2uQ2X5mCE5F0ObG
	tFOhslYvcmypnK/h4tT0EvKSoi6wer5woKE3Lu7aNR1RE/HCdIQ4g3ytgutLSzOksl+o//
	enzcQROGBsyHGFh3FhacDMMwdG1JXtGeayvMv8fsd7McSTCV5ysvvxnYQm0BkZsL9YX6hk
	FzOvHk5dARqnApl41Z4UpxwoRnCvHUeYy+MFRv9fgcGoVkZh4sCdkxc9cVZ93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1750687778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=Yy3BWW9qviq23iYkqfpGsQWY4+YNBYYT0gqeyRGcxQc=;
	b=gsBMBHG8DwBc0FsyRuVQWQ+phyr3PS0F2+ql2lD81lc1lNRLSDHI1Jx6Ej+C/NvsOGMQDp
	u1j7dDTUjLD2cRS4mlpiqlOc+coIGwrIDBs5hGUGtOUPwWnPRnPg3hVrfQCcYEYGr49fMd
	vnGmoFKf9AVbt2RsNQgBPa5aPpHPoUTdphQWz/+NMDbGbZ3WoY5UxxQ9mlMGXY8CiZ93Bv
	gH3gErOdYh6a7dov/fHe133eWbx35hSiZgmKNJbg7vKeEC/3ydNRvT0LO8R3YZWpauD/R3
	W/1bzLvs5lJLMSpUQ+QiWQQattXUuIrj6OQvEMFYVjqC0tPJuFwXLACUy3ZyGQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1750687778; a=rsa-sha256; cv=none;
	b=MqlIoTfi7X5Z4KJZ2fnFt9xrpgxSdjmztm3BNNBFCcEJf5FVeJRRDuQ/SXRtTGzS54MKT+
	kVhUKm/LUXO+aBLqAAYIk9kMQsGCi03a1ZFER1SRkizr6GhAlgVr/lDX+VPxTdaOHYtpry
	0u+lDFaSu76N6R+qkjsXFm6iW1n6LlcDHJBC0XJx2eQvHXkRTGxx7bzcEb7G5xdVRqqT68
	zmr0O3v+icxg4Z0qrfZR9vFOeFnMCjsJQiZDXSm5VCeHBl7tPjSRoBFGgaqLe3ybBo21XV
	greQUKZw02ll4qS9nDSGqyMiHeSyTWIw89sRa+GMix+BAuhpGoCX6cjdfQzDLQ==
Received: from [IPV6:2804:f1c:851:ac01:244c:3dc8:fa2:a066] (unknown [IPv6:2804:f1c:851:ac01:244c:3dc8:fa2:a066])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bQqhf0Flzz1CQx
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 14:09:37 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
Date: Mon, 23 Jun 2025 11:09:35 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Renato Botelho <garga@FreeBSD.org>
Subject: Bug: build is broken on FreeBSD if libsysinfo is installed
Autocrypt: addr=garga@FreeBSD.org; keydata=
 xsBNBGStavwBCACjNlp/9+Y+VFe9ieR2h/WWbdvjz4Mb2z/f22bGoaskzCfvVNbo/v3i34I9
 H6OdgZkGqheQEAD2jNfRbmPr4z40xDMUpYGLds+1Mvg7G3Hms3j5Ef8KaLSWUNWIfwKdfSVR
 Qs35ccSJxAdRW5YdI6J3xZgika+3Bc4eJ05YE/nWW+PNTYevt5rqD50N3zybVYIcLoqVPpBi
 AZE/sf5SLiLACIJb1t/s4x+pi8vgWevxVVT9u8V1f8zYErmHSLSqjxii0B3eRZphX9NCJOv9
 +tfFZhnENInhn9gT7H4e2YumUltEy3jacONHJF3CC1pvvWEa6lEyypclMOkHQwNON7DLABEB
 AAHNLFJlbmF0byBCb3RlbGhvIChGcmVlQlNEKSA8Z2FyZ2FARnJlZUJTRC5vcmc+wsCXBBMB
 CgBBAhsDBQkFo5qABQsJCAcDBRUKCQgLBRYDAgEAAh4FAheAFiEERL7Dxegbnh7xTiQ5Ob6P
 xxJcZXoFAmSta78CGQEACgkQOb6PxxJcZXrYlggAgaZmr6c1yIWzN8VksHrHpwt/uxONEP+h
 ljy3yfrMsgfS5wx5Uzgfih1xYZUFC6jiI63CetqBqJpp3g1klRS1UWYKx2NeXphDMYZEdPm/
 a6sXh4bKZbk6IE8Yn0/YiRT57d9DtbvswC7Gn7Igj/MSbhl49TvTGyvuB6juaffVoYZViomx
 5zMoee8Ml2o2qj3MrCJ+/K8GU54RlpOGqGRsqdwVdr9XEWub6fF2YFwR46cjmbiU3P5urFHH
 nkJlBGPIwKxHimTW0lZsdx9aCKRDd/D80/WOEzXmk3k8B9lv/GsvOluHmveLhJG1R1tIJ31I
 f2q8dfTvqsQXnu8CcWRcgc7ATQRkrWr8AQgA1DufoxScA+CWQbUR6zExIu8wXQKrhuRt4DG2
 BgynT7EMUvEBadcbQRZXsBpemNfncc9Axyut/+rWiyKJf9BLQuo/9QYmSRvW1U6+0LJUYmdg
 kMyBeYaPk+vnssv/u9jLuvV7FVgyE0yk1iaWIKOVDD+XrQCOvGw9uSceBrQyCyo3A/eRM/+p
 vnDCaywR63PKE+3axk6lfNdGK3TnaWmS30/ZDCZlNsXuqprqR4JdT5wXids5o36dsuJ5EZ20
 s5hNMD34s4Yr1Y1R9elH6qBsFCpozs0+jwrArxq+UJJCR6hH5W8ZEwJtRC8tzR8mRE1WywzX
 BXYj0YhfGztQIxZckQARAQABwsB8BBgBCgAmFiEERL7Dxegbnh7xTiQ5Ob6PxxJcZXoFAmSt
 avwCGwwFCQWjmoAACgkQOb6PxxJcZXr1vgf/SKXhoZcUU5I7TqcbHg0lJz9tICTupCGHWr/s
 SQgjh9oEM5j1wqW7FlCGP90Tl9K0g3ow9YdbhU7VK470o6pymX9V9eLHzGgkZO/KMEtGBeK1
 u+5ePjCJ/MK5B21KODLSU7WrIL1VN5ceXfQPLYt02LMLtPri+oduHD6RNBeA7US1DUzleq5F
 9NHGbvV2U7BdDUezpiO8NaFjFZVB11I5d99FxUM5XGVstI3VhsRKZxjY0KnqJzaQgTFsPGmv
 AUfZVIN1pXgXiedhPXpr8+Y64jP+pHVwpVmh1zYWL6+q3kqFOUVP6c5iiMeoEXZvgJz7x/AC
 ek3X5gvu8Hpcv+MZIg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

FreeBSD has a libsysinfo package which contains GNU libc's sysinfo port. 
  Some users reported git 2.50.0 was failing to build when this port is 
installed and it happened because configure script detected libsysinfo 
but -lsysinfo was not added to LDFLAGS, ending up with following error:

scalar.o common-main.o libgit.a xdiff/lib.a reftable/libreftable.a 
libgit.a -lz -pthread
ld: error: undefined symbol: sysinfo

This patch [1] was added to git port adding a user option to 
enable/disable libsysinfo dependency and fix LDFLAGS when it's enabled.

I'm not sure about what is best approach for git project in this case.

[1] 
https://github.com/freebsd/freebsd-ports/blob/main/devel/git/files/patch-configure.ac
-- 
Renato Botelho

