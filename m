Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A227056D
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765574976; cv=none; b=rF9OQdYh8eWRk2ZNkxujuHDfbdnHLObXlCD8IMu4HYRR4mZelvCNGJKcUxHjnX33q1bxfS25sLGh8nJq/PQa4lylk5ndlrGQIQMud82Z7hdDY9e5MAP0mv+Gs3wAXJiNzjM1VEF/ezCUfcr+MLzWUPUnDmmaTsVpYENs7mK7K90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765574976; c=relaxed/simple;
	bh=bb29JC8iepPdmi6S3PkOvVxCbDx2zC0T7GByw9+7Vmk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qev1IshVdxGW6894gcmHJIU4cZdj0K0dDiKz21RnptAOkwuWxU2lcrTCusOcfckbEO1dBZW/JM1INnHXsBRfq6EOAe8Gya/BjO+egvBeacpWwHhZQmetqa60QNp0cgXNWqWAJbFIQRXrHpkcpftyEt0Jj+gUciuUY9P0M4fR1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVgc6qDg; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVgc6qDg"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5e5697a2cfcso584017137.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765574973; x=1766179773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uF7l80fa+XHo7dv+YbFgRfQhrUTvsuNtyzYN2sqM2yc=;
        b=gVgc6qDgr/IZPPr7oFIrJouOgsYwxu/WLEU+eE8TND/0zcrbX4H83trDrPm+ekgo9X
         craRb11qzVuASOK+T+oA8ITi8IpbZgLSLg8XsBM/rVNx9bU38JjGYNAfpYMm+LEidc3e
         ST43A8dycf+7QhSpXTwHfQOruc+ngeW0aigBVKAQGQoEkHfsZ4tAwzBShacds1oanUdM
         zvD4jD5WRmdoCyk/1PD/k4qiNuLgXKXUiBrmwUGQ2hjSbrM8VhkO/birQFaFb/gJR5wN
         pJA1m9jabICiDnA/HmWcV1xPnWYmqktUqFjdFpTiHkqDQY/G1RvaZbCBGIrlgjyRZaDC
         pdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765574973; x=1766179773;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uF7l80fa+XHo7dv+YbFgRfQhrUTvsuNtyzYN2sqM2yc=;
        b=OuqdBm7X0PUTEuEBByWXY29Y0Sdj9yjdXtnQ8zM+gLYKCKkhzQkXq8gDu9f+UCPkO0
         UerzKYv5Y3MmJUCbS0jsi7FStd5fMenPj2fSJ2pMzpPriV3J2bs1pE5oMik6BgWDO+HD
         QxgZR4SjbVTCUNqgA53HloiImQDf11QIJzoJe1xepbjYNSZ3AQlam+YKJ8gyJoVzl3J+
         zjWXWdTKd8FSSV3XUYelUm9jGPDWGLQaLk6q997jVsYRiWxnM5qn34OgdCLSl9UIH9In
         AbrKT7mhwAXhg+rX2qTyBuzpcUHaBUOsHGlHjNeImFruC5UHvjl6MeZZBjmomHjzur8b
         Pnpg==
X-Gm-Message-State: AOJu0YwPFfGz403QnAHvijtI3ynyUeKScJRKC4st2/YtaQQXzTtc3met
	Ks3WxpT2pbjXf120Ihz0oYO+NM1HWPpX+qJPF7BwxN9eNv3sQ9+OWrBl12xOfy4XkYLXf/0seEm
	YsUqJ2rEglvpfOSrW8WY939O+iImnTIE1lH2PjtI=
X-Gm-Gg: AY/fxX60ADhoaEpso3SDhiB4JVhS8R0jp6TSZIcuvVokJdm2EGAhOQQoezk7mwfjhKJ
	tjIms3NxvVtOgslXzVIZIcetFvVOfe9/yl7H0tUoaXl71REP6fHTN1i/5MV/MG7kxrlgv/VmhC+
	tCoTGz7iJnUSZUD7SH0iv1ibqrL786o0YKG39NoRozZbPFgspJ64cnLCQTaH9bj3zTF5RU0Pmpp
	D6eTESTK4QoE3fiYZVmP7bwBX4F0QH3IKnYhw3WFyqeLSqUksJgsFGYcvY8/L2Kh6wca77DPeN9
	ZwzCQ9RajSd7rI4VwQNFrmgBhyqQSQ==
X-Google-Smtp-Source: AGHT+IF4eVvGGE28owTqz1PChhoZa4a7vNS1cllar3/9Ka4vc2nSraVhvnRTfNIKP8nxgJCjHRkxtUo6YoV1fzER02M=
X-Received: by 2002:a05:6102:441c:b0:5dd:f9c2:5533 with SMTP id
 ada2fe7eead31-5e8277e5e76mr1362260137.30.1765574973332; Fri, 12 Dec 2025
 13:29:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Dec 2025 15:29:32 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Dec 2025 15:29:32 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwm2uh7gs.fsf@gitster.g>
References: <xmqqfr9jjrci.fsf@gitster.g> <CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com>
 <xmqqjyyvi743.fsf@gitster.g> <CAOLa=ZTAdpRurHGiBj2rQhtBJxuWPz4__2Q1LgJ4rC2qAdL=0g@mail.gmail.com>
 <xmqqwm2uh7gs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Dec 2025 15:29:32 -0600
X-Gm-Features: AQt7F2rWmYNXinyHp4i9f7VVqHz2WWSUPE36WPvtLRV_0WJJAvmMT7DJlNTiNIY
Message-ID: <CAOLa=ZRfhKMnnb-4n19Vy0kzBc3QV0df05WNur1_OFa40YssAA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #02)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001c36390645c7f567"

--0000000000001c36390645c7f567
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>>>  Expecting a (hopefully small and final) reroll.
>>>>>  cf. <CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com>
>>>>>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
>>>>
>>>> The only change needed from the last review was a typo. I think we should be
>>>> good as is.
>>>
>>> Meaning that we prefer to leave the typo in, or just we won't die
>>> with a known typo?
>>
>> The typo was in a comment in the tests, so I thought it wasn't worth
>> re-rolling, but happy to do so.
>
> I went back to the discussion to find that single typo and tweaked
> it myself in my tree, so no need to resend.
>
> Thanks.
>
>
> diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
> index a1ca4e1ac7..ce1c23684e 100755
> --- c/t/t5510-fetch.sh
> +++ w/t/t5510-fetch.sh
> @@ -1628,7 +1628,7 @@ test_expect_success "backfill tags when providing a refspec" '
>  	    test_commit fetch-me
>  	) &&
>
> -	# The "history" tag is backfilled eventhough we requested
> +	# The "history" tag is backfilled even though we requested
>  	# to only fetch HEAD
>  	git -C target fetch origin HEAD:branch &&
>  	git -C target tag -l >actual &&

Thanks for handling it. This looks good to me :)

--0000000000001c36390645c7f567
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5d484d03aa218bdb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rOGlUb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEF5Qy85SGE2L1BucENpNkpiYVpZUVhWVnFIYUJ5VgpleHpxQ1pIeW0r
WHoxdFZQQW9tS056NWtRN3FpazI4QVl0bjRmbXZQNmRXV05Td3RGVThOUk5GdG1JaVhnZjB5CkZT
MGxVZDR1eHY3S2R4S0o0aFFPM05idThocU8vNHk1K0tTRXA3VEFsMkJCZ1l6WWc0TFNscGZBMHdK
RTZHengKL0tXMHBTYXRIbFVDWG5LWlI3OEVGVGNBWmhraXRDNXM4ai9oWGMyS2N5UURNanRhZEkx
U0xKMTNScGhiQ3RSbwpjNE4zY0lsS0o2TnBpdy82WXhHeE51VktTeUwwbGFZMUVjYWt1bHlDVi92
QVNmbEpVTitRV3UwcTFVd1kzUHQwClJzVGIvNUErZFZGN0NId0VDb0I5ZjlFNDdFOVppeHFwZ1NN
RWZWVmpjOUx2RnlqemZzTGU3SWl3aUcvakl1M2MKTWViMnVHME9wTVloR0lSMVZkanUreXI1Zlpw
UFBlOXhZNm9ib3ZnQmxPL2hnT0k0N1FTTDBwQUZSWm1BZklDTQpGS29jd2o3SkEva3dDd0pheDl1
TVZFTEt3Y0g1NzNsNVRYMmUza0RkQ3lCZzFLbVQ4czdwMlVXWXY4UCtGYjNiCkFud1RBOXYyOFNv
RktycE14cDZQdVk3YkZ5b29KaGMxSGtyUEhnQT0KPVNSWmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001c36390645c7f567--
