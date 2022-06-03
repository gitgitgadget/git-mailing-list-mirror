Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA37C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbiFCSIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbiFCSGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:06:09 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4535C36E
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 10:59:08 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r3so7815211ilt.8
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x8MnpDDlA5/SCWeBZjsQ3IF7U1PKbehfqhxya4rANlo=;
        b=U7Q5HGw9IXxw1J2j9DiuUm2M4k5cJaTPNr35QaZXnmoYGylKTlieDM1q6NCz7nCICw
         G9pEjlglkIfENPQWmBXCf8dsk1mmOlP8Rf/J6ZseNQRQXI6QuXS6MEVZLILZUW+fDtZN
         U5ippM3xjfs1OC+Wzrl2u63uG5uNjvePagCBtlgNnKZkMwCoW4I7ZpWh935HXGFtCVMb
         CpHSFiNwxhNc2w49MchqVGPy0II2dgaFo1uAxrcid1OBhirV/irV9XYfuKiAaxDo38A4
         +Uzvh0KD6W9qYyyv5pIpF53NuK/QvZ5gzjNqxHZCRGElWvdeFl9/L61qsl22tJA4Zlw6
         HRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x8MnpDDlA5/SCWeBZjsQ3IF7U1PKbehfqhxya4rANlo=;
        b=kGkZKcSOpjvmmAWmHrW2QAgQFfAKjdcgQPos6O1BApRXsj2DbHu0FVs2Ia24ZezEAJ
         sPiw12SXRHP6kzed0JhdGGs/PFHFsBXupHnoc7HbVH8m2SPwki96PfK8gbPCW6HYw5Lv
         lrwZdJ8ekTFtfo7eSl9aD/ccIfnB9YgP+97RDqvuZZTWqqLrSoUFCespzrxbV/LDiWFb
         8nw9TkhtqH5RVrzMe3Lrt4/nfaEkL7NazpYz0+BHr8YsTuu8BnC3ZRkecXU2gwQVhlke
         BebSxOrad7ZYPQVv592K8zw4uyfK8dGihaDysYhD+9no2Qg/tAqpWakU53V/r2De0NQH
         BpJQ==
X-Gm-Message-State: AOAM532/EbUcZsgxI4/s+pZSd7IVZS+BblLXc3K3uL6cn0B/eGU8n+SL
        uSAYTTQvdOtGto9OJlpxw1Z/
X-Google-Smtp-Source: ABdhPJyOo4ASDABMesHF4JOTX72VUNlf6xdYGI2T4JNVB7bXl/H+MVYM5BOl49J/57P2x0NRMVPazQ==
X-Received: by 2002:a92:c992:0:b0:2d3:a5a5:a886 with SMTP id y18-20020a92c992000000b002d3a5a5a886mr6731865iln.158.1654279115162;
        Fri, 03 Jun 2022 10:58:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e12d:e22a:252a:6357? ([2600:1700:e72:80a0:e12d:e22a:252a:6357])
        by smtp.gmail.com with ESMTPSA id a10-20020a027a0a000000b0032b3a78176fsm2752608jac.51.2022.06.03.10.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 10:58:34 -0700 (PDT)
Message-ID: <55d7146d-0fc4-3c29-b9a4-72f5ff856255@github.com>
Date:   Fri, 3 Jun 2022 13:58:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] log-tree: create for_each_decoration()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <4f9f34876413927d819313a70fcdefcad5b35689.1654263472.git.gitgitgadget@gmail.com>
 <xmqqa6athcif.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqa6athcif.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2022 1:39 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  	const struct name_decoration *decoration;
>> +	struct format_decorations_context ctx = {
>> +		.sb = sb,
>> +		.use_color = use_color,
>> +		.prefix = prefix,
>> +		.separator = separator,
>> +		.suffix = suffix,
>> +		.color_commit =	diff_get_color(use_color, DIFF_COMMIT),
>> +		.color_reset = decorate_get_color(use_color, DECORATION_NONE),
>> +	};
>>  
>>  	decoration = get_name_decoration(&commit->object);
>>  	if (!decoration)
>>  		return;
>>  
>> +	ctx.current_and_HEAD = current_pointed_by_HEAD(decoration);
>>  
>> +	for_each_decoration(commit, append_decoration, &ctx);
> 
> The function for_each_decoration() that does not take decoration but
> a commit felt iffy, especially because we already have called
> get_name_decoration() to obtain one for commit, and the API forces
> us to do that again at the beginning of for_each_decoration().

This is more an issue with this particular caller since it needs
that current_pointed_by_HEAD() information. I had considered it
as something to include in the prototype of decoration_fn so it
could be incorporated into for_each_decoration(), but it ended up
being overly clunky for this one consumer. I'm open to other ideas,
though.

>> +	strbuf_addstr(sb, ctx.color_commit);
>> +	strbuf_addstr(sb, ctx.suffix);
>> +	strbuf_addstr(sb, ctx.color_reset);
>> +}
>> +
>> +int for_each_decoration(const struct commit *c, decoration_fn fn, void *data)

The goal of this method was to make it super simple to iterate
without doing any prep work: just load the commit and go.

>> +{
>> +	const struct name_decoration *decoration;
>> +
>> +	decoration = get_name_decoration(&c->object);
>> +	while (decoration) {
>> +		int res;
>> +		if ((res = fn(decoration, data)))
>> +			return res;
>>  		decoration = decoration->next;
>>  	}
>> +
>> +	return 0;
>>  }
> 
> We'll know if this small waste is worth it when we see the new
> caller(s), I guess, but even if they start from commit, allowing
> them the same early return trick would require this piece of code:
> 
> 	decoration = get_name_decoration(&commit->object);
> 	if (!decoration)
> 		return;

The iterator returns quickly because the while loop notices a
NULL decoration. This use in format_decorations_extended() needs
that check because of the current_pointed_by_HEAD(decoration)
call based on the result being non-NULL.

> in them, and even if they do not need it, it would be trivial for
> them to say
> 
> 	for_each_decoration(get_name_decoration(&commit->object),
>         		    do_whatever_they_need_to_do, &ctx);
> 
> so, we may want to revisit this after we finish reading the series
> through.  Making the iterator take name_decoration does not look
> too bad.

You are right that this would work, but it's a bit messier. We
could go this route to avoid the duplicate get_name_decoration()
calls in format_decorations_extended().

Thanks,
-Stolee
