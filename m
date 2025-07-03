Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F918239086
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546157; cv=pass; b=oAEjUD25NA6fJZCy41AYdbLLarCwP7tkySyZaZGyNh23kOqHhut+9EMdorhmiTMvXSJW0UikLIDl+oDsoHKVu6+lpR3ijYTTxF3lyS0T8dGUWSSieKzAICrBZHdnltRHrfSzQu1M2yt1Q/FGq7dWhk92mxcuHLKxG+1gYaIKvoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546157; c=relaxed/simple;
	bh=PdFjw16gNDsVBtRMlCKkELYEz+yKR2mXNZrrIt3kzj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DheqEQMfa7p2f7l4Dfw93ZpKgF3fwWbMq/nt7aaK8Y7LfodkRHmi8MbdCJ44X8Y35IH4m6kkR2joEBOe1rG/9dBuP287AO5NZ5/3N+BS39yleJUFgWD5z2v5u6DXxQa/ijhAtGR4Fs41nXeQY+LgCIWeYCNIVThcpFMiaJ/Iezg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=VQJQoh06; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="VQJQoh06"
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bXx7r3rRNz3Kp7;
	Thu, 03 Jul 2025 12:35:52 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bXx7r0NN5z3wW0;
	Thu, 03 Jul 2025 12:35:52 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1751546152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FbIjoPfEzUrbagtEQjFfUvQQRgHVkSmOGdMLtXyfc3A=;
	b=VQJQoh06u13yT9sAKlfXhAivJBS8Ll+mAIXpRYdv/iLiOZPcNomAPdwtUonzMEfSHeGuDQ
	X3DBRACtLJ/faPZAQe1hyNnKtZzn+lJX5qhLOP8baifdhz+EnqjytIdyjDxvq6OTAoJ9Sv
	dwPb840HvQW8r38aC0wat/l5DK4aqHkM4eiLt238faCf9e16w1txCfMdlHpSXvJnVVYA1U
	YQd0tyXxo0SCsbB1u/TEpfb9cPIqz0MtGkxKpCDDlebVl2eNE1vHgtX9jcxldBTCZkkqec
	Kgj7X1VkTWyXO+J5WmRI8ztVTyC4XtP6Qwt5+9wo8aGzxIF6Xmes4oW/QMsqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1751546152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FbIjoPfEzUrbagtEQjFfUvQQRgHVkSmOGdMLtXyfc3A=;
	b=ktSFu+/AqeMHFLdln+YJHPv8VFKSPjZ2+8b2ropxi2K39Fo4s7sv/xInthzuSg4UywP0SL
	tcktN3MBitFvDbNkQJHYA+oW0eyVB7wJYZDP0ouSfq4RQZT/Cap8U1S0JMlLlTvOhN6G1O
	GDYEFXGV/mBX6QpEkeNuReTdgaoQzgYLduD1FFu9S8WlwHIApw/g+zrmApucTxPvP1s1qu
	Ir1Fj1a6TjH9XGiYy7KhmYtvjRqITaVca9rK5jDinvVpMUyl8zjDQ3ThsGeskbuZwT8UTD
	eHrVeJUmFdYHJyogcuZTDy6JXMuEsz5JmENRttJn+gV5Zc3J6uO24M6kONeFFw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1751546152; a=rsa-sha256; cv=none;
	b=KJ9qVzD0JHKUz8fP/1wsJ9/MMEelg3huU2q/ATVA+dl2qZzjcT0wBhBXZhOSqCD+thdYs8
	QYKS7WIXgBvtKQE/VYpqKi/pldnbwsD2nv9FycNzo6z1Oek+F4k/bWBqfLCzHiiTOM5lEl
	845SbSbZCrcQN74ubVJVSQLH27eDJXfY9pHUcX34Q1gA2zh4Sb41uSM6EDV2e5dAhNmuu8
	0bP6h+V7w28DZSi5u/eTeqNSDDPi9/rgCYCbpPTKEu0Zti578f50I2HbpEAqcQn+0fOl62
	0ESHM5bWickIrsmmDgXbn/xQDUtWPbo9puzE6cJSdGEIarhuA4HVENkH19cdVA==
Received: from [IPV6:2804:f1c:851:ac01:29a5:d790:eea7:3d35] (unknown [IPv6:2804:f1c:851:ac01:29a5:d790:eea7:3d35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bXx7q0FQGz2My;
	Thu, 03 Jul 2025 12:35:50 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <90f5ae50-51a5-4188-b76e-90ab2621551c@FreeBSD.org>
Date: Thu, 3 Jul 2025 09:35:47 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Patrick Steinhardt <ps@pks.im>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, GIT Mailing-list <git@vger.kernel.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
 <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
 <c8f4ae13-8578-4db3-bee3-1619f03428d4@ramsayjones.plus.com>
 <aGZB-DYo1nleB0bd@pks.im>
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
In-Reply-To: <aGZB-DYo1nleB0bd@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/07/25 05:40, Patrick Steinhardt wrote:
> On Wed, Jul 02, 2025 at 11:33:23PM +0100, Ramsay Jones wrote:
>> On 02/07/2025 12:28, Renato Botelho wrote:
>>> On 01/07/25 17:03, Ramsay Jones wrote:
>> [snip]
>>> BTW, should I start moving the port to meson?  Is it the default build method now?
>>
>> The git project only provides source code (i.e. the project does not
>> produce any binary distribution packages). So, each 'distributor' can
>> use whatever tools they prefer to create their packages.
>>
>> [A long time ago, we had some support for producing Red Hat and Debian
>> packages (if my memory serves me correctly), but that didn't last long!]
>>
>> If such a thing as a 'default build method' exists, then I would say that
>> the Makefile (without configure) is it! (Meson is the *latest* build system
>> used in the project, not the default).
> 
> Right now Meson is still considered experimental, as there are still
> some things missing compared to our Makefiles. I will address those
> missing pieces this release cycle, and once done our Makefile and Meson
> build instructions will both be considered officially supported ways to
> build Git.
> 
>>>    Is there a plan to remove autotools?
>>
>> At present there are no such plans.
> 
> There are no plans to remove our Makefile right now, but there is intent
> to remove autotools once Meson reaches feature parity with our Makefile.
> It will probably still be a couple releases before that happens, and we
> of course still have to make the final decision to actually go through
> with the removal. But it likely is to happen in the not-too-distant
> future.
Thank you for the explanation.  I'll keep an eye on the announcements 
and as soon as meson is considered "feature-complete" I'll start 
experimenting with it on FreeBSD ports to be ready to flip the switch 
when the time comes.

-- 
Renato Botelho

