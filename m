Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED01C6FF9
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235974; cv=none; b=W4h5x9AYQN09bK0z2nm+SyJrsd7f9LJpmTgC8k//jxs1wKLx5IbGw09awGlks4jCFn+CQ770llO7vY1tGOGEfAVHP0QOJIuFsC8f9xzNhcjirwBMTCu9UVmiy9TMP8Cn9ZeiomsVvs+BqCZfL1909mLOg315RiygNy0E+A22GZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235974; c=relaxed/simple;
	bh=hl+hNdduozOIfW+NJw3l+RJF/Rvr1IGzouCJY71rFu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkg1d4TatUiW1IU5FGQQW/c7rLCMH0bsD4d7t3x1CY0rirj6r3UbqFm+XrbIY+D8qSJEYfXuSUnODlF8IicBATOGHW7Ffrj3TirulJrGaSLkY0pK8BQOp5efpPd2hMOlARmgmUtiGWqNsisKSrR1SK2MnHGW+y6UjIdKG0xXSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc1spLlp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc1spLlp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso19319995e9.0
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747235970; x=1747840770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9EH7VuYDLzUXeN5m6+crhR+J7Z/IGY0H4vJVdTVIY30=;
        b=Lc1spLlpeTkINworqRpO97xFjw1VWvQsxGberDF5YdFkxXSbiTwZv9FyohVx/yl8Yy
         SlRP32YMaUphw25bEANQA+toun8uzgMeEd+jHfgGFBK9d1WFo336IfwxbsTYi8C2pmjx
         efE1fIp7ijnt9KqoMfvmkzas1BurYZ6J/8yTzpIvCkrz/nQSKJdistW5BwGlFUe38rBh
         iIvr5mXxBaw1uObTfFihqA2mc08wEvX9USPOkBhnDRDioif8jirCaJOtq8K7wXQsfUuk
         GVtubVS7mPNDNPbA+p3Sb3q+H4whSj4TEmYKtRC4OqAQS1MCJQvXwe0hQsIuhytwiOmg
         PKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235970; x=1747840770;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EH7VuYDLzUXeN5m6+crhR+J7Z/IGY0H4vJVdTVIY30=;
        b=kc2rIo4DcuSDUTnN/n+vUrOryx4s88BayS1DoysNYoYGA32nNrcTtuo9iRZjLjOODH
         qmtusnMqd7R8+12pMK/sIG9RHwoDR8jjws3wNA+Nq/N7amaXNqM/Pl1FExh2pHKsWMDF
         4JwXnCyftLbs0DDZ0BG+pIiNV3mi8DXqCn3MCBTaCF67Ma0MusNSwrb2BzGy8dS8nZMs
         cLLTZeVAGpdKWouwXhmCQkteDta4m1NjYu2ZMmxhGJthB2o3VG2I5WvSxdt6c8XQQrTf
         QL85UnV6bmUOb7HjNQyJB9SD0gnkOCqzTJXH+QDYKHidc/HZ/ucZk97SMEumLb4TwWcG
         xsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvLhGLjnlrqjs8u51f9OjAi47X4wP9fCW+hSC1593LjekFKkIvnTHKbRSEYdFJSGZxbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3icvYsG03G9S5/E67QD0Z4r0WclXfD6Aj3474LXVkTDFmCVg
	cX4+156GpVtBis1SLDvWxojJeyQ5CA20MyhytsXOcjmnmXaPuLhL
X-Gm-Gg: ASbGncvw5Q2y88G/eZleDetr2PUqwbThppvdx1ZpVxto6DpbKgRN2W8r9EOPS6+L8ep
	VuMAz/xC6YwLW51vv0ST+O15BlG/BtvUtX0Y0iXe87VcBzcg5/TdqszCkTVstMWFFcDfXiMbrpL
	f8K+VzMZHi/Xa+DxURWhFIVRZdb/lrTSI//bUGiJQr9T6FflBKxNUBdG8w3Coere788QSX/IwuT
	otqzVVhOrv/Qb24SCUoOLmnWxMsG/wjE4WzKQxzfGh3PHBoTXcK0txbMv0W7mzjdBNaKru336Jx
	3k9Iloc/to0YUC4TG+MDC3Rv0ruMyt/elrS29nzMfpRhN0QfRX9WJ6BHiGBNmvDg5fgb0eZRmn6
	MBOSYTNKocn6cXkEHUQm16W4jRO4=
X-Google-Smtp-Source: AGHT+IHzOwievT8bOLQDS/Y0lkRN3CtHNeCZxv4uZDSy2IjI8kOCyKDud+DhvjAT2U+bkq6OvaLMXw==
X-Received: by 2002:a05:600c:a00a:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-442f210c9abmr40107105e9.15.1747235969549;
        Wed, 14 May 2025 08:19:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3967f62sm32975065e9.25.2025.05.14.08.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:19:29 -0700 (PDT)
Message-ID: <ed18e1e5-2941-4f00-9139-66bf95f0faa7@gmail.com>
Date: Wed, 14 May 2025 16:19:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/11] contrib: remove "thunderbird-patch-inline"
To: Junio C Hamano <gitster@pobox.com>
Cc: Collin Funk <collin.funk1@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Matthieu Moy <git@matthieu-moy.fr>,
 Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
References: <87jz6mo4n9.fsf@gmail.com>
 <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com> <xmqqfrh9vlxr.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqfrh9vlxr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2025 17:22, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> Due to 'text/plan; format=flowed', the attached patch was damaged so
> the version I may be commenting on may be slightly different from
> what you wanted to show, but there is one thing I noticed.

Oh dear, I need to find out how to turn that off.
>> +SEP="$(printf '^\r\\{0,1\\}$')"
> 
> Here we assign to the variable SEP
> 
>>   SUBJECT=$(sed -n -e '/^Subject: /p' "${PATCH}")
>> -HEADERS=$(sed -e '/^'"${SEP}"'$/,$d' $1)
>> +HEADERS=$(sed -e "/${SEP}/"',$d' $1)
> 
> The old reference must be expecting that the variable SEP should be
> already set up.  I understand that a different separator is used in
> the new version, so it is perfectly fine that HEADERS need to be
> changed, but shouldn't the previous hunk that assign to SEP be
> removing an old assignment to SEP that gave the separator wanted by
> the older version?
> 
> It turns out that after the post-context of the first hunk there is
> assignment that the old separator value is assigned to SEP.  I think
> that should go.
Good point - for some reason I forgot to delete the original definition 
- I'll send a re-roll.

Thanks

Phillip>
>>   BODY=$(sed -e "1,/${SEP}/d" $1)
>>   CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
>>   DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
>> @@ -37,7 +43,7 @@ CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp
>>   echo "$SUBJECT" > $1
>>   echo "Cc: $CCS" >> $1
>>   echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
>> -echo "$SEP" >> $1
>> +echo >> $1
>>     echo "$CMT_MSG" >> $1
>>   echo "---" >> $1
