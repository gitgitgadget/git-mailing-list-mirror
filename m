Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B1F3FC6
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485745; cv=pass; b=T18cjg2+pTKNcXe+snzYDrQgMxiEEn9rS7lBS9zLK3pv7ZKDggSoLcPs8C/Kt/TFc3Cti2PKk+Nm7svFHm7pbCT6VwObu7L6zdj/OGNeQyv+8yL0r4kd+pvs5ze0a62mmS5dTmfs8BnY/tvAHqJ5EOHbLGFjKnmr0JMKOy9U19U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485745; c=relaxed/simple;
	bh=VG1V1yWwBNDJQboe+ATXrVHg14hiPAzozl/GDSwwNvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnHpNjZjRhC2CqTFUnl/a8r+6mp7vpGgtVIcIdBe5fci90zv6UuBy3WVZqoviD3nZqUNj49w15USP2h4I1ARJ7SOC4Xhc9zlUFbKXHMgd3UeAD/R+3bXOexOfDe8drp2CpVuuiJuX78ARE68LMBV3/wM8pbw/sH0lfu/MpizLE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=ExAs/QU7; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="ExAs/QU7"
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bXVp64FqWz3Sxn;
	Wed, 02 Jul 2025 19:49:02 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bXVp63HZWz3m8L;
	Wed, 02 Jul 2025 19:49:02 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1751485742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kuT4thBeP8718f8l/lXuTtZxAADZODDkzUO1l46yO1g=;
	b=ExAs/QU7TbtLPUyRFvZaoOQOaGug0JuuWtPtHQeD7pGzvZ02kpB9GHjmFvItp8oI/hfeV3
	ufb/JNGA/7ZvAy2d4aNEutn7r/UQbyRECpBeAhIOlCiDL/x/g3NyaYAhgtYgvEVDvmrU1d
	TAVPtL8erx+PdtEsNt+B38edl/cG6twxXjuCV+NNIdu01vm34ZY9XXJGntCxt/jJMNCxvu
	IbZospaGMfEJxFCmjAznNlFk85GUlow8ZSM0UVt+i3TBBUWYEsqob0sBKPnVSOvtjAGXwG
	71Gv3miQVPujsARj4N9Gefl4P/USAq5YXG73juJhuGOkF1YuitekDsAnB/gg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1751485742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kuT4thBeP8718f8l/lXuTtZxAADZODDkzUO1l46yO1g=;
	b=FUEWXCwHj5cdtXpSX+61fsGvLqWcVlXwZca3ZJez7y50MyECpMdZGrp/i1FeHR9SWTY2Or
	oCuqBwFqk1r8h5GjoS89BBameXrEgtTOeSOucOnnvhJkb2yNhdBbC/e/yaxVDNloXw7V1T
	N1+fdY6fqMV59Qxi40Vf8Vxlf87ZQzu+hvUEUdneDzqPaUku2QPeu6kP82q/oZ8wPxWsU1
	Nz137cJZ/tZ1xYY6iM/PVMLEND4zrNDY47hVmy4ErJ8KgzKbWGqhLsrPpVOMExnNZsdZpc
	3DZXFu7xCe9yTVxvdF0sR97J7bqn5N+6xnUIwKhh+/avaoWp5+3dO2GFFPv7Dg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1751485742; a=rsa-sha256; cv=none;
	b=CGfL1ufzyiK+YINdOFNx2LS7uBbnLLVrRQN6NseeOnro2FaC2XZPPmXj28z9btoPA3vefp
	2Z7UQfXxRIzZ94Rblejsi+FlILNuB0tXpGJGgLShsn87u4MP3jOv1PkoixLWECm6jUzxhj
	31mvepGutgFuKYUGM5IAjfT60QS9Qxkrp86Zr26+MpHG12Pt+Xk7gg9Scq04Z5CESg26Kf
	6/Hkxc3q7qctmKv16ULyT/LQEuJ/oRSAV5DqxEdNpjDN51ezVVdBsYgiwkQdtUMflpP/Ic
	4T1+Hcqn4dCibmqiVJ9ugMq6CXyHoqGZ2/DSUoM1HomB0ffQST/lZv9/qO733g==
Received: from [IPV6:2804:f1c:851:ac01:8109:c30d:783c:bf9e] (unknown [IPv6:2804:f1c:851:ac01:8109:c30d:783c:bf9e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bXVp55RXXztds;
	Wed, 02 Jul 2025 19:49:01 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <39e370f3-5113-4feb-8a19-2cbdba6c17ce@FreeBSD.org>
Date: Wed, 2 Jul 2025 16:48:59 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt
 <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
 <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
 <xmqq34beed0q.fsf@gitster.g>
Content-Language: en-US
From: Renato Botelho <garga@FreeBSD.org>
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
In-Reply-To: <xmqq34beed0q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/25 14:08, Junio C Hamano wrote:
> Renato Botelho <garga@FreeBSD.org> writes:
> 
>>> I very quickly knocked up a patch to do the last option above (I
>>> moved
>>> the setting of HAVE_SYSINFO down the file rather that HAVE_BSD_SYSCTL
>>> up. I guess it doesn't matter, but I gave it *no* thought!).
>>> The patch is below. (I didn't write a commit message ;) ).
>>> Does this work for you?
>>
>> Your patch works just fine for FreeBSD.  I tried it with libsysinfo
>> installed and it just ignored it, as expected.
>>
>> I didn't test meson build since FreeBSD ports is based on autotools yet.
>>
>> BTW, should I start moving the port to meson?  Is it the default build
>> method now?  Is there a plan to remove autotools?
>>
>> Thank you!
> 
> So we have a bit of loose end that needs a finishing touch, but
> otherwise we are good to go?
 From my side, yes.

-- 
Renato Botelho
