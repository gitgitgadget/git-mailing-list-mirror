Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA82D3A72
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546460; cv=pass; b=Zw4kA/vvIOiXl05UUmDuk3wqWpg6h8mWXfp6P6zvGO+MpqPf2bqcw02r5pnbLc+9jL7S1r2LWZl6ZAqYVQ56K/brHG+qdhgZYQWy9x9Ayr+5Ou8nZoAUQ5G7t74POTtlpvpN4H5R8q6gfrf+JsDXrIKwE95Nn/uVCZ36YHPVtME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546460; c=relaxed/simple;
	bh=bsFabzBqosiCkBablUXDghVhjl+kwx0Ct3GlENGJZ5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1ztQFwYaltOGdk9ldTqORwmtt27SMbXwLOHmoVEobA5lfrGF/Suf6LV30tksiRoTPp6lOCW5T6YiMF5pIWQ3SR1iggYfQk04swcFlk0MPs8I4aJ51yVCigP4VBV3DOl+mmZoRwm8gj0otNoAE1HGZl2ebjcJabLDeN5LRh153U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=KgaiJiDw; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="KgaiJiDw"
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bXxFj48kYz3KlW;
	Thu, 03 Jul 2025 12:40:57 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bXxFj1KRNz3wVC;
	Thu, 03 Jul 2025 12:40:57 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1751546457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bf+nzIHNELUTFPctQA3R5aW3s0Xt60dGvoRpMR2Uv1s=;
	b=KgaiJiDwdD70YBf3Hm8iIWvL1yGVyzIk69XQOHmPNrX9plFMu5/9ngHAd5yF8DYT/d8hcE
	pXKLyK42qNdFDlrsA35xOr8xqvi4AJDSUCVjlhY8vCtWXXzueKPiCNTFxoEyE5+2w+XU0k
	q6BrkkktDgK/hltm0sPP1kgXAlURJiyp7FuV/HBBdfBWSdd62cjsuIWVg5olckaetgH/Jn
	30JZeRGBpFuZaf4r65ytVGphvvQag5S8SRBlyR32F45/0Mzmslu6oUezN8XC9apEYMQbbV
	pvzSWhGDwN4qCDm+Bd7w96iUt8V198Bo07Y5NklPOGZPUE5qxvLbyPolFWs3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1751546457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bf+nzIHNELUTFPctQA3R5aW3s0Xt60dGvoRpMR2Uv1s=;
	b=eVOcDeAHQFFNEdD/B3g4h2rkvsueQp3Pg97zu3rLp7OLC1GvCObtiqTZT5+eSDcgBxBaNV
	NFi+Xvg54i0+2s8k1CfXDqJYUlEgTKj1AZYEcayxTXGp013V5bwufT8PN0s8qQ7GQax+sY
	RDNWyolMYupJTMW31rgdRoSoIAOYz7X9I0oSCed4vCm3TulBJu4F2JjxpWm/JzKEmsmwiN
	Rn68JhRJT1be+EYWIkE/crvKH3w6nER99biNxIiL5HeHmY3bxmOhLXjNhAiV64uEysA2EY
	hHq6w/EBTJXU0L4Rv/xVxEUafsK6VJLlm18z/T9sj/7hH9qNC6MY2RrJhN8kSQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1751546457; a=rsa-sha256; cv=none;
	b=J++DVovSfGFrkeELvTsw3Gjk/wzKUZje5desumYPrAfSAFvlQ9XpHN5N73iLe9SgUbM/he
	AfMeCeV+3mVGnSsMumyaDXw4ywcD+IQKQCxEXL4Qi1tPr5P89Xu1ZLIyLC2SdDumQsM67F
	Odkk4meCH4H5SYHbCyXPY/3eKUu9+8MoLi9HqbE0NS20pQKWzp0g9H4yUmIkpWc4sEs3FV
	WAix8fX2kJJ90sp7wwlQ1y2WC4104TMyJUiFTo9HiW7bFQewYXwd4fYjCIYmFKx7xVLk4N
	4oXR5kLQRiagQrbbOA285aSDG2XbalWlFrS76E9V3+QjqG1NBxIn3NORXNfvcQ==
Received: from [IPV6:2804:f1c:851:ac01:29a5:d790:eea7:3d35] (unknown [IPv6:2804:f1c:851:ac01:29a5:d790:eea7:3d35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bXxFh4D0jz2Kw;
	Thu, 03 Jul 2025 12:40:56 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <f61f6a80-da7c-4849-bc89-806eab84662e@FreeBSD.org>
Date: Thu, 3 Jul 2025 09:40:54 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: update settings for FreeBSD
To: Junio C Hamano <gitster@pobox.com>, Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
References: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
 <xmqqsek5fwnu.fsf@gitster.g>
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
In-Reply-To: <xmqqsek5fwnu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/25 00:47, Junio C Hamano wrote:
> Brad Smith <brad@comstyle.com> writes:
> 
>> FreeBSD 6.0 has memmem().
> 
> And anything older than that no longer matters?

The oldest supported version of FreeBSD is 13.5, which will EOL in April 
2026.

> That may indeed be true (6.0 was from Nov 2005), but if that is the
> reason why we simply lose NO_MEMMEM (instead of conditionally losing
> for 6.0 and newer), that needs to be explained in the proposed log
> message, together with the reason why we no longer do anything
> special with version "4.x" (which could be "We ditch the support for
> anything older than 6.0").
> 
> Assuming that our stance is "anything older than 6.0 no longer
> matters", the patch itself looks good.
> 
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   config.mak.uname | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index b1c5c4d5e8..da592eeaa0 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -302,16 +302,10 @@ ifeq ($(uname_S),FreeBSD)
>>           ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
>>   		OLD_ICONV = YesPlease
>>           endif
>> -	NO_MEMMEM = YesPlease
>>   	BASIC_CFLAGS += -I/usr/local/include
>>   	BASIC_LDFLAGS += -L/usr/local/lib
>>   	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>>   	USE_ST_TIMESPEC = YesPlease
>> -        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
>> -		PTHREAD_LIBS = -pthread
>> -		NO_UINTMAX_T = YesPlease
>> -		NO_STRTOUMAX = YesPlease
>> -        endif
>>   	PYTHON_PATH = /usr/local/bin/python
>>   	PERL_PATH = /usr/local/bin/perl
>>   	HAVE_PATHS_H = YesPlease
> 
> 

-- 
Renato Botelho

