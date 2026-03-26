Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E222248861
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529716; cv=none; b=Hv5POqJPK2SJIVCIQNEcI+CKUyRVt5E+XAb6sS1SUhQthwjrI1I3ryf5CgSGv70xfbSfYMmVBcC5BwUJ4EhrhocoTr8WZB8HnBSbJF9xVlWei5TBansGlZHfvgPXFvw1VTSE44nta1ygyIRjGB5DzCv2kXk05rXA2fsXVTCBX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529716; c=relaxed/simple;
	bh=mqmfbqMRN0pVC00OZgAe9wX167lKKcAzetxHKSTIQfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoAnysuUSbhtEXq2PMOOYPx35o4s3cqYkGdUJ4PMRFQ99Vio2YuSS2ccyYEGvqcWql8coFncLIrXVBF6qc9MiK9w2Ud2ODLau3+6LJnlh10X+RKSzpNiBJfIZAxOyC+DyRA/vW++BTPSaoBMutvoFb66Wx/VgtMEbm4/RGGezbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSk+1fOE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSk+1fOE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cbc593a67aso106917685a.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774529714; x=1775134514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms6XIgcPEIJStTU2v0rZA4qQWTns+k4AC0vPTsTg2ws=;
        b=oSk+1fOEhkheZFMdkXT3uM1rMQv6ZFyllRVA8aHDrfZHb1lgqHEQrNcILlC7BjJAq9
         Bbjd/jn4AKrz5C0mOne06lDpmd36Hfphe3R3yjYw+0HY9QwKaKXwoecw0Qxn0mTAhOQX
         WMTVdQQMnG98VMFBro9aMcSTcbEYFLl4Ms3n/P0m1Nm0vCQTaoAbtCO5x2G2GVsBKASB
         /lbrjZ37Q9wuN6tYLwA+HYoD+nHOqCu9o8lv5xputc3ruKg5gx59e6hck0iogwm/v9Zr
         TW8zADDkqcKVVd6XBJcmTcDwsh7Ug6q3beFk8VUCZr2B8irqc9txon/Kjg0R+FKEf94D
         rocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529714; x=1775134514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms6XIgcPEIJStTU2v0rZA4qQWTns+k4AC0vPTsTg2ws=;
        b=lGzsu5F6rgrQ8oV3zMwpCxiS3FxYv4h3Jw4kFrqmJm9M+VaLfHOlbptzl5redfZpw7
         1ZG37ixU8TN3X6liUGWExRu2GuntGsY++Ib5gIsmuE/dJnfx8Nk/n/H7f61MgOfOz2nt
         YZN9DQWJkT4wAw6Yg4wFp5SYSlTrwMtvCfniAGwM3bOP172eC+DnC8ELygtC7ZOWBnb2
         uUP2UQOCC5pVncPiv4S8kNBSBINLlWZfz3L+8/JLaz9goZVnJEz2GQi8Dt3KxYKEWme0
         1E5QG5injFQb1ppSnMdmxeris6A/qzgad5wMwJu+DqEJUwJVBgH6UITCM3ee0yDyR+vt
         iCPQ==
X-Gm-Message-State: AOJu0YzqsasrOgDjQv1nCyfn23PvOSX+IaOFRg1uAL5+pkvZYrfH5VAR
	e3QsOhpdpH80wJ3eTrXvjr/MfrR2tNxeDE3xckz3uFgY6jf6RnMQWPrn
X-Gm-Gg: ATEYQzwwv8Gesg/6mI5LPvpXAJMF7CKKxsZj7F5m+JIQaUMbG2944qoSDveq+k+PlZX
	7KRJqZ0DiWPxTB/jxQhUb0NpkGr+m75BBDs+/T9lX0pZEIehAJFc2lgE9CKWdQPGi7RHnRxIFYU
	xBrTBq6qQYOkrkLCyc51cQiBeieIqVsI+VcGtbHlkNKTMrYVe5OJJPXTWwTl9Z4/xFJuxH9MtNB
	xwpPlDqtwlwx8w6+VUaFPfQsm/tj/rV0AZi7hOhfryDySHvPHRtZ/P1Vwsof1rhFsWsjApqDLMy
	QwoSMMIbv8+J1sFmZj/IqIM+4j8s8PB7O0hYnwKNLGxMBKjr+LjiwmgilLkP2vzJxUkziQ0SbSs
	MluVZ0ouBa18XhrKyogAKZN/casOZob0+5jcYBVYrU5AsiiQaYs8aWGxL4A60TuwiextmypcD1w
	OIqFC0FbzbQTCuNS/CZO9deHdsY1JCYzBfEIteoBjqFYHLKAv5mxkuYliQEoRggIWgoBmiQQ==
X-Received: by 2002:a05:622a:1f99:b0:50b:5198:b5a2 with SMTP id d75a77b69052e-50b80ecc9e5mr97017041cf.70.1774529714027;
        Thu, 26 Mar 2026 05:55:14 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b920f77dasm24261671cf.3.2026.03.26.05.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:55:13 -0700 (PDT)
Message-ID: <a6bb702d-08c6-4c1d-9d3a-0a32bd73cfed@gmail.com>
Date: Thu, 26 Mar 2026 08:55:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] backfill: accept revision arguments
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 r.siddharth.shrimali@gmail.com
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
 <610a162973a7ad59eba4ef4d5a9288f1fea1d2e8.1774266019.git.gitgitgadget@gmail.com>
 <acJESdSvJUSCSWtK@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <acJESdSvJUSCSWtK@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/2026 3:59 AM, Patrick Steinhardt wrote:
> On Mon, Mar 23, 2026 at 11:40:16AM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/builtin/backfill.c b/builtin/backfill.c
>> index e80fc1b694..90c9d84793 100644
>> --- a/builtin/backfill.c
>> +++ b/builtin/backfill.c
>> @@ -134,7 +135,12 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>>  					 builtin_backfill_usage, options);
>>  
>>  	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
>> -			     0);
>> +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
>> +			     PARSE_OPT_KEEP_ARGV0 |
>> +			     PARSE_OPT_KEEP_DASHDASH);
>> +
>> +	repo_init_revisions(repo, &ctx.revs, prefix);
>> +	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
> 
> We should probably die here in case we still have unknown arguments.

That is indeed the fix for the bad test in patch 6. I'll make the
necessary update in v3's patch 6 along with the test for it.

Thanks,
-Stolee

