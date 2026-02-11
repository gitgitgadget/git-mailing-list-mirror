Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28035261B92
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832163; cv=none; b=nLSPdhYZlEbFEa+jgfwqQo1Pwmt2vXX3iKaokWsfubpcwaYIYYFawDdxqfhpNnMTNheKtrHLWpa60ap4nJJxPWzSuzMTAuzMt59s7Z1kkGerdBQZ8jAoXT+2VrCxCTE8uVJZCRNcyKHDgCeK8sMFFYRTnkQ9Ekz4v+BKmysJN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832163; c=relaxed/simple;
	bh=56/60F0gYOKOoce3Btc6exkSKfBp2XvBzyYPvvlVm/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQtow6gQ4zUFOVaJDIGQFY3TeoqDbuyvwJ31ydivxgCNR311YEVvC0IokQ/IOg67Kn4KOxOR/fthE5EAc+/7qfLwHE09/D84CV7hHj2FLE5WK+Bm/VWCb5RqqrSVnulyuTA0sqkR+IPNmWmDyC2X4OjS0cu5WXbl2DfGerMxHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSvUdLGr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSvUdLGr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8951c720496so16232506d6.2
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770832161; x=1771436961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZB9qgW6ut9o2mggfyo76o38/WPPlNL13FysDTMJ8rY=;
        b=TSvUdLGrtHa5gR9sI1gUO9Rl6qDZtV027PKpmMwcvizyKabBheriw+/HnZYUnKSpEk
         9cENOIXeJq73ac16QYGYFohybnLjDPpkMjDFsh56OHBZ6WcAaMxKGAaXKLbAt3VH5dy0
         D8uc+jO7IxGcLIwgmOnfFq0RWQN667V/IXCeODByxe6TzvJg3m+tIV2K6H3/nHUO9Hbt
         juN2XhWfuVOuMrf913//VKUWmJUyJ+/79fXOKwyqQl46cUIq4A8+08gzbC4ACkxrA9On
         2jVuRdNpHzzuBTFfiSD7etfn+/4sH5iAx+kfA5J6mis6eQENqA8HuU3GiCbHnaXi/AyH
         1zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832161; x=1771436961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZB9qgW6ut9o2mggfyo76o38/WPPlNL13FysDTMJ8rY=;
        b=jzcJ+Z3pLGE36Ivu4E6Dtbes4JQyXFateRurwp8jfzvVINnMgmCvSMmQ8aWWZBOVUj
         DCbHx2Kk0mD0qFUF1s0VDanoTAmTHUQOgP8JDB8JzfQit53QWFBJOl0vPfkzvbYz7KwH
         dyP4pCjnrcuAVm+GMFSIacdwGYyKAdc03+js/5PHz0/ca/DtrCe9pt8TO2M6OEFePx7s
         91KxuH/qbP/if/jF2K6DYYCYP6VE94bLhAthZGaKpvi6EuzzFQkKn+4xjnTol7o6KDCU
         ZmRgrGMlx34GtDx8PFLXcIsq2oP4TdMhvJn39wf2hND63mSbYHXBbuX5jMgE8yuJveAg
         0JlQ==
X-Gm-Message-State: AOJu0Yyoxt+JZrc4meym5MObt4m92tSM88kg0n3JrJMPN0ZBpbJWZ+JI
	Bc8pQPP3vCMr5uTSLiYKzNvh3N3CcxzSz7fE2UkmbEy3wJNnlbkqsS5l
X-Gm-Gg: AZuq6aLxi4h5+R9pdTtAcWhwwE8fTFZm54ybheqrWz4HbyfFeOpyxAsUlhtG7w8qt1d
	1daK7tldkSrrFp6lTiB7t46C9SQAwJRdVDfHsS8mDdGevjskYxNdXCTL1tUX7RfNaLS/Ug2Ss8o
	pc5Ro2S2IEASvLNXTjoNhPR7ZGqU252z5twOmbpMnbmB2u9H9GJieT7Au3RZc5OxaxZLuW4WZBq
	xmjJnWiptyCgTd05RMC0O2u5JsCs1byW9KcTuGazzg1hIHogoZQmvsFHCp2Z/0mNZWULJ5f1HR+
	aMj3CbFLa56iDKos8WNU11+flI9h1KH7Esdi270fYqeIPTJsrro4boX00cT/LR1znwMKhVNVrbj
	c6IX51tuPnTBYwONcVVwLEk61EXHECoRYHjVuyq/s4xaVJHe+cDPIW+ZvLluJlJA5WA404V/pT9
	cn939tSbB/JIH4tWKT4VLig+3jg+mDqVArr3+Kqi3bnNanJ0kwo/SVjaKmdrfn/BSaYLuKLQ==
X-Received: by 2002:a05:6214:c23:b0:894:60de:d208 with SMTP id 6a1803df08f44-8972799328bmr4184826d6.64.1770832160701;
        Wed, 11 Feb 2026 09:49:20 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8d397sm18046736d6.34.2026.02.11.09.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 09:49:20 -0800 (PST)
Message-ID: <1fb94c08-c36a-445b-b613-dda33c238d6e@gmail.com>
Date: Wed, 11 Feb 2026 12:49:19 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] config: make 'git config list --type=<X>' work
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <e27d52c4a5970f774e324b0a9c0badb0532bf3d4.1770698579.git.gitgitgadget@gmail.com>
 <aYxyeAQ_-9KXxI-L@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aYxyeAQ_-9KXxI-L@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/2026 7:13 AM, Patrick Steinhardt wrote:
> On Tue, Feb 10, 2026 at 04:42:59AM +0000, Derrick Stolee via GitGitGadget wrote:

>> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
>> index ac3b536a15..5300dd4c51 100644
>> --- a/Documentation/git-config.adoc
>> +++ b/Documentation/git-config.adoc
> 
> The synopsis of `git config list` should also be amended.

Good point. Will fix.
 
>> diff --git a/builtin/config.c b/builtin/config.c
>> index e69b26af6a..c83514b4ff 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -363,21 +363,12 @@ static int show_all_config(const char *key_, const char *value_,
>>  {
>>  	const struct config_display_options *opts = cb;
>>  	const struct key_value_info *kvi = ctx->kvi;
>> +	struct strbuf formatted = STRBUF_INIT;
>>  
>> -	if (opts->show_origin || opts->show_scope) {
>> -		struct strbuf buf = STRBUF_INIT;
>> -		if (opts->show_scope)
>> -			show_config_scope(opts, kvi, &buf);
>> -		if (opts->show_origin)
>> -			show_config_origin(opts, kvi, &buf);
>> -		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
>> -		fwrite(buf.buf, 1, buf.len, stdout);
>> -		strbuf_release(&buf);
>> -	}
>> -	if (!opts->omit_values && value_)
>> -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
>> -	else
>> -		printf("%s%c", key_, opts->term);
>> +	if (format_config(opts, &formatted, key_, value_, kvi, 0) >= 0)
>> +		fwrite(formatted.buf, 1, formatted.len, stdout);
>> +
>> +	strbuf_release(&formatted);
>>  	return 0;
>>  }
>>  
> 
> I wonder whether there is a good argument to be made here that we should
> keep the old logic in case no "--type=" parameter was given. In that
> case, for example the following output would remain the same:

If no `--type=` parameter is given, then this new implementation does
the exact same thing as the display_options use a string format (which
does not mutate the config values).

>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index 9850fcd5b5..b5ce900126 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -2459,9 +2459,10 @@ done
>>  
>>  cat >.git/config <<-\EOF &&
>>  [section]
>> -foo = true
>> +foo = True
>>  number = 10
>>  big = 1M
>> +path = ~/dir
>>  EOF
>>  
>>  test_expect_success 'identical modern --type specifiers are allowed' '
> 
> I'm not really sure whether we want that though. I actually like that
> this also leads to some code duplication, so maybe this is fine?

The change you highlight here is a difference in the config file _contents_
and not the expected output. These changes are to help demonstrate that the
bool and path types make meaningful conversions when listing these values.

The previous tests for getting bool values did not demonstrate the way it
modifies case, for example.

Thanks,
-Stolee

