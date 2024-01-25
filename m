Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0E10971
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161972; cv=none; b=g5O2RnsJcQRv5ibW07eexLRKPjwxTO4sGdv5EZ4HELK+B7NXtVvqpzBejOCHztWMSTXaMpz/B8itrlnT4fs4J00g6OO8TClgU30C9R1JFqhBh2zforFlvgXeQOIDcb1r9bk/oWmOe7RUBNj26wYEh70KETo9Cb0tp8sZfpYbLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161972; c=relaxed/simple;
	bh=NzSQPbAHkF/wU/IRbZKjhalPV32pRNQ45VTV+DPlcus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSOH8Bj9MCVuoOvtTxJ55uqyiDElTnAPb7Q98jVVNy5CbQz4WPjZtJ2JRYb0mIB+Fvfrec7NcVFv5Cy7DtRzRjemQRqQyIQMh1s9Wsmi4YamzRBJLu97NOiqeoq3cq3ZViYiIgVGMGvHmKtv0ZW3O7rjmfH1+cCQhtuzxaSg1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4WI3G+t; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4WI3G+t"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddb129350cso960995b3a.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 21:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706161970; x=1706766770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOeTObOZE+XJIjKsRCTVWv9bgchUEsrb46Hw4vH3xww=;
        b=C4WI3G+tK3Pp0+sJ4pzcDUfER5TLA28mf6fBAX9uIP0F7jMEqNAvss23wagocKWs5e
         dk/r/Q3e/39QS7zeWw5Cp27n5eu7tLO7uMogwvMsEBZRnVwDazZWRzOsDpq/DqLt760u
         8hFeEMJhBXH5LwYXfMhcnbY6BBphw+s12UD0qoPe7NShRmaj/FIImamgJM5sUTIf/848
         FW0e0OO7JTUSWhj/B3OgQRDss0NDMX9BXVNR3B+h1sIQEpabSAmK/48CnudyC8ePJ6k3
         ARoeoD2m1s4TxjIG0WPf5Gi4AdCs1uTzrd0sinEGfuSZiFqAkAhD83xGZr/cLgkHQZJ4
         fkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706161970; x=1706766770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOeTObOZE+XJIjKsRCTVWv9bgchUEsrb46Hw4vH3xww=;
        b=bFym8zNOt7dJ0MlD7t9EhcVs+NgnrLDzJjJD8OXeAJXTKxN0lwYaYw4QNIrzE6jbeD
         XvDamHQQjprqFNV2nUO/+xyqYEICD9BMBMqr6VH25Dn9YIQOELGb2LmC/Rtg9rREeYjI
         Ijr/5RWEFLO85Yg6CyrJ4+5xPcOvz2s4MutZBR+irylXpwC0I0paObFpWl+f5VJdl7wj
         zRZCzOREzfmlW1ys7HGQohf2/rDyuTcOC0tJOtVxA6yWMmxg1+IlGWuOAMeB03hSYPqN
         /umpC+fzZp2w6501ZKrMjQt6t01xsmONE9cbjiTDVxVrSbUZa5a1Hspw3dbe8CCU8ye2
         A0SQ==
X-Gm-Message-State: AOJu0YxP6kPt09mngJZ1DVtmhBbOqKLQIo070VKiZMZxgdoZOy9a0mNi
	Qn1BR/cxGdKs910tpZD/5+5mNTifbPNfUxB3I9HS562r6EO4z7M7
X-Google-Smtp-Source: AGHT+IHrM4uCb/CDHwIHrVKVWnH+lJvxQohBnblLQv+/A75p+1tNkyEYV81RdqNu77NaAVgLJFm6DA==
X-Received: by 2002:a05:6a20:3d06:b0:19c:3264:ab14 with SMTP id y6-20020a056a203d0600b0019c3264ab14mr472583pzi.88.1706161969877;
        Wed, 24 Jan 2024 21:52:49 -0800 (PST)
Received: from [10.42.165.185] ([103.158.43.18])
        by smtp.gmail.com with ESMTPSA id v19-20020a170902d09300b001d6ee62787bsm11278544plv.42.2024.01.24.21.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 21:52:49 -0800 (PST)
Message-ID: <d1569248-ce56-4e19-9244-c60c7617ca28@gmail.com>
Date: Thu, 25 Jan 2024 11:22:46 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] FIX: use utf8_strnwidth for line_prefix in diff.c
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Md Isfarul Haque via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
 <ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
 <xmqqplxqcx5p.fsf@gitster.g>
From: Md Isfarul Haque <isfarul.876@gmail.com>
In-Reply-To: <xmqqplxqcx5p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 01:38, Junio C Hamano wrote:
> "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Md Isfarul Haque <isfarul.876@gmail.com>
>>
>> This patch adresses diff.c:2721 and proposes the fix using a new function.
> 
> Once the issue has fully been addressed, it is expected that the
> NEEDSWORK comment there would be removed, making this proposed log
> message useless.  Make it a habit to write a log message that is
> self-contained enough to help readers (including yourself in the
> future when you have forgotten the details of what you did in this
> commit).
> 

I understand. Sorry for the mess-up. I will keep it in mind the next time.

>> +const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)
>> +{
> 
> Given that there is only one caller of this function in the same
> file, I do not see a reason why this needs to be extern and exported
> in diff.h (actually I do not see a need for this helper at all).
> 
> When dealing with a string buffer, it is much more common in this
> codebase for the caller to prepare a strbuf (often on its stack) and
> pass a pointer to it to helper functions.  I.e.
> 
> 	static void prepare_diff_line_prefix_buf(struct strbuf *buf,
> 						struct diff_options *opt)
> 	{
> 		... stuff whatever you need into the string buffer ...
>                 strbuf_add(buf, ...);
> 	}
> 
> 	/* in show_stats() */
> 	struct strbuf line_prefix = STRBUF_INIT;
> 	...
> 	prepare_diff_line_prefix_buf(&line_prefix, options);
> 	... use line_prefix and ...
> 	... release the resource before returning ...
> 	strbuf_release(&line_prefix);
> 	
> is more common and less prone to resource leak over time.
> 

Ah, this is indeed very neat. Didn't strike me. I'm not extremely familiar
with the codebase and was unaware of this practice. I will follow this 
pattern in the future.

>> @@ -2635,7 +2649,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>>  	int width, name_width, graph_width, number_width = 0, bin_width = 0;
>>  	const char *reset, *add_c, *del_c;
>>  	int extra_shown = 0;
>> -	const char *line_prefix = diff_line_prefix(options);
>> +	const struct strbuf *line_prefix = diff_line_prefix_buf(options);
>>  	struct strbuf out = STRBUF_INIT;
>>  
>>  	if (data->nr == 0)
>> @@ -2718,7 +2732,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>>  	 * used to correctly count the display width instead of strlen().
>>  	 */
>>  	if (options->stat_width == -1)
>> -		width = term_columns() - strlen(line_prefix);
>> +		width = term_columns() - utf8_strnwidth(line_prefix->buf, line_prefix->len, 1);
> 
> I do not see the need for any of the diff_line_prefix_buf() related
> changes, only to do this change.  You have a const char *line_prefix
> at this point, and utf8_strnwidth() wants to know its length, so
> what you need is to massage the parameter to match what it wants.
> Perhaps even something simple and dumb like
> 
> 	utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
> 
> might be sufficient to replace strlen(line_prefix) in the original?

It was more of a force of habit on my end, since I usually do not use
functions that do not have a limit on the length they are reading.
However, considering that the string is generated by another function
and is most likely safe as it was used earlier, I will implement 
this suggestion.

> 
> This patch hopefully will change the behaviour of the command.  A
> patch needs to also protect the change from future breakages by
> adding a test or two to demonstrate the desired behaviour.  Such a
> test should pass with the code change in the patch, and should fail
> when the code change in the patch gets reverted.
> 

Alright. Where should I add the test? A new/existing test in t/t4013 
or t4124-log-graph-octopus.sh?

-- 

Thanks and regards,
Md Isfarul Haque

