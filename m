Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BF278E41
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385946; cv=pass; b=T2j9DuQfX9IDAnNjfmRBC1FgMNJFpgqZ3mJINZPOsFFF/WFOKLsifm9IGcq5Fs5xOMxIArKz03GUyIeCfwPWewwZhsmvOSaKHSYQluaDc7TRl1U7/wr2hxHZDzV5AOPzTWXNzQtQxWSevNEE8kmFHvquzat7CCPSFpM+No/5J+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385946; c=relaxed/simple;
	bh=mHAB1TeSGQ7neKheTrxyxfgMhxDJdgQlbD6oDYO9EKg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QEg3jQOGq0s8K0wKbEqtfX2n5wgpVxra/L1stq0aYnKAlNuhJ6DBEHu7g4WyKFgPRuyPTuQ7aWZPBnHlukOelY13lxskimIRMrOsIJQlJ6rCRqsLK1EveUrTYQYKatscHWg/Jvawp4+UCasLA2J222Wlo7R6glIitvozfsFXAuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=Bhh7Itlo; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="Bhh7Itlo"
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bWntv2jcgz4VGY
	for <git@vger.kernel.org>; Tue, 01 Jul 2025 16:05:43 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bWntv1fcdz3hvq
	for <git@vger.kernel.org>; Tue, 01 Jul 2025 16:05:43 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1751385943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PTkVX5M6vyxLIPukF88X46RjysO+ha4cEdEwEbGPapY=;
	b=Bhh7ItlosaoqnvvCL4pP2d8y/AxbrUqsHWMrW54DKMVmRyzFfMOYqLniDh9NY6HUsHdHcR
	5Un6CRMtZsC58xzYFbwc2Jczu/GfuQe+YYnWW4dZzOkqvm8SjZHH/9Ci710Lk6NBUH66x4
	int+L1Ik1iYS3J1KPkL3bthvIxV0RCdTldybzqQP7mnYjdlw02fRLhtR5iC9JAGqJ+nHUG
	eNwDo1mmF1qU/vfxIL6n89bWLGqLjLhLuL+3YsykdAtUVG8mJFFZRTkRrc+hMe5bzQXhLk
	yvuU1N/M+4J2rIOJOOUxPmM/hVN9NJZRYwkMVUdCj19uHYx1J8z1ls7wRYgMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1751385943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PTkVX5M6vyxLIPukF88X46RjysO+ha4cEdEwEbGPapY=;
	b=AZc48y4BBnHR4x1EaOe+XPFrMTzgNNal5OiqvaURiGAX4ZE7Qej79pFd/xFZpun24Ov5Ag
	heYJu0zu6ISj3VgBQjOG/ZItxAlsvsvN8o+hgBka8qJGY2KZlm0YMzks9c/z9RoJowvb2x
	nRTAq2hU9thIsGobleHZMh6xyjAfJ+01N7P63ICYUzUYyszo29MamhjI3Q6T4Wt8xhg6vM
	RhLy5ogfTebLRankcU/+PIKRQEDUD776lzAy8LwyeokE7IPwgDgOmdtWgl0kvWQmXQBdyB
	XIXKnLLFfJ+OWorUG2M8Z1HjzCUc8LzMQccyfChjXPC8TBafXTZtDhzMiQPU4Q==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1751385943; a=rsa-sha256; cv=none;
	b=tQhYU91ebFkqz6475FFTDzXB45uhPBAZRACo3LsQCtBeTHTT7RHiumlt6YC88okTJAm0t1
	dkiLYSBsfZqMFAaSwpEoXOxuI5QIotF9NBmLk5xMlqfGK2GVFoZ3Ks+axj54SO12dr/9lY
	fp3LsIs+hNqfhJXmi1AH+kthZ1bA3q122SckdO5TK2TN5Xc91SIlacfPzDEFb8K4VfS7/M
	gQzAI/aiMQAbAhVjCcRMYNDTs6h9XnsVRtNkj8JQLLkKzpmJfYshuB5hpBrH1dxQ6OA2JK
	m6YIrEweTJA8wdUobhyITpUV9Sb98mee63/qA+FbR/PU7S+lkgpiKf/QSyoJLA==
Received: from [IPV6:2804:f1c:851:ac01:585a:523b:f539:a647] (unknown [IPv6:2804:f1c:851:ac01:585a:523b:f539:a647])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bWntt62BJz2Rj
	for <git@vger.kernel.org>; Tue, 01 Jul 2025 16:05:42 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
Date: Tue, 1 Jul 2025 13:05:39 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
From: Renato Botelho <garga@FreeBSD.org>
To: git@vger.kernel.org
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
Content-Language: en-US
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
In-Reply-To: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/06/25 11:09, Renato Botelho wrote:
> FreeBSD has a libsysinfo package which contains GNU libc's sysinfo port. 
>   Some users reported git 2.50.0 was failing to build when this port is 
> installed and it happened because configure script detected libsysinfo 
> but -lsysinfo was not added to LDFLAGS, ending up with following error:
> 
> scalar.o common-main.o libgit.a xdiff/lib.a reftable/libreftable.a 
> libgit.a -lz -pthread
> ld: error: undefined symbol: sysinfo
> 
> This patch [1] was added to git port adding a user option to enable/ 
> disable libsysinfo dependency and fix LDFLAGS when it's enabled.
> 
> I'm not sure about what is best approach for git project in this case.
> 
> [1] https://github.com/freebsd/freebsd-ports/blob/main/devel/git/files/ 
> patch-configure.ac

If someone let me know what would be the desired approach here I can 
work on a patch.  Would you like to make that option conditional as the 
patch did?  Or detect if OS is FreeBSD and do something different?

-- 
Renato Botelho

