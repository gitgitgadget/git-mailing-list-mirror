Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8955C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C248064EA0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBASNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhBASNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:13:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD9C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 10:13:07 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a19so17220324qka.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eYFxYEVWhK4289FNeFfO7tCMIGcNC3OPzi0RhkRgcSE=;
        b=UQnucwOjn+QyR/rAuigo5/9ymh8RyzWph31i3SMcQ3NqfCu1nJlMFh+U2tp0huv29C
         wAHKi0ksvNSOgsQzvmIsiC/Q7n5JgV0pFiJEqVRFTJD/uRLlX0wBGz6qlY1RQewzmxHC
         J/Ox87vy3cuKpa+Uce7MrzIsVfbXasnBmBZUD5ImC26IKcK1YSGxyiUemd1Mxu0xRWb/
         vcqw22jGKQrPocy6Srs6QukEz8hknx9Jlw20/3YpxhXVycRZz9ERbW0Wm8U3VTUwUiuY
         QSMkrIzWdbYQrr4X15o/wVrbPc3JOrU5ImZnVNePoQtm+9IsxNFblMWam7gg3Qw1xLWS
         XrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eYFxYEVWhK4289FNeFfO7tCMIGcNC3OPzi0RhkRgcSE=;
        b=XZ5a6YILPkaYMwVNvAwoSPeemn/ES4uAArBl3+HxgLohWZz2SZy8S+Z70npWV1bPTS
         u3kj9d4SahPT1T8TESqnQAq6rrL41S/RiRd1l1ZpUvzEuuJ2+yjPMlL9Ez8s/qzaKJOu
         LK2IuYMsloHDqr7HgPKtqJrG625pj41lTtkmmHBUueGOpWfj+RYoBAHCZpCcU1az5/GW
         Ae5Zbs7azFQlShYvyjA1t2Qkh7lLzmGHcd9coU1fZt6MxaHnrIuABYMP0P7TkVqV3Py+
         KhJG+8K2kCXh08exgRVtzmHxDGbJxJVjpdUioW1Txcg2ItdlVjF9aDnQ2CfeNR8z/H8/
         9v0A==
X-Gm-Message-State: AOAM5325B5RzdRL9ETkUYyPGC1p7V7vLhuOzBzW8Jkcbwyn1klyOHI86
        TKhira5BY9d1SK+gV5j7hjQ=
X-Google-Smtp-Source: ABdhPJxMBAN3AN6UcxdYJfX5FrrMa9YL1Sj2EaDVv4RGECyKyna/1tBQ9FdSLQvXGbp9UjHWzWK5yQ==
X-Received: by 2002:a37:5d84:: with SMTP id r126mr16799861qkb.396.1612203187081;
        Mon, 01 Feb 2021 10:13:07 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id c17sm15055102qka.16.2021.02.01.10.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 10:13:06 -0800 (PST)
Message-ID: <defb76f2-aa85-66be-7b3d-e6b741774f22@gmail.com>
Date:   Mon, 1 Feb 2021 13:13:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 4/5] commit-graph: be extra careful about mixed
 generations
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <b267a9653a7560d1e59708f20106ef054d140a9f.1612199707.git.gitgitgadget@gmail.com>
 <YBhChR3ReDhAde87@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YBhChR3ReDhAde87@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 1:04 PM, Taylor Blau wrote:
> On Mon, Feb 01, 2021 at 05:15:06PM +0000, Derrick Stolee via GitGitGadget wrote:
...
>>  	struct topo_level_slab *topo_levels;
>>  	const struct commit_graph_opts *opts;
>> @@ -1452,6 +1453,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>  		ctx->progress = start_delayed_progress(
>>  					_("Computing commit graph generation numbers"),
>>  					ctx->commits.nr);
>> +
>> +	if (ctx->write_generation_data && !ctx->trust_generation_numbers) {
>> +		for (i = 0; i < ctx->commits.nr; i++) {
>> +			struct commit *c = ctx->commits.list[i];
>> +			repo_parse_commit(ctx->r, c);
>> +			commit_graph_data_at(c)->generation = GENERATION_NUMBER_ZERO;
>> +		}
>> +	}
>> +
> 
> This took me a while to figure out since I spent quite a lot of time
> thinking that you were setting the topological level to zero, _not_ the
> corrected committer date.
> 
> Now that I understand which is which, I agree that this is the right way
> to go forward.
> 
> That said, I do find it unnecessarily complex that we compute both the
> generation number and the topological level in the same loops in
> compute_generation_numbers()...
> 
>>  	for (i = 0; i < ctx->commits.nr; i++) {
>>  		struct commit *c = ctx->commits.list[i];
>>  		uint32_t level;
>> @@ -1480,7 +1490,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>  				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
>>
>>  				if (level == GENERATION_NUMBER_ZERO ||
>> -				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
>> +				    (ctx->write_generation_data &&
>> +				     corrected_commit_date == GENERATION_NUMBER_ZERO)) {
> 
> ...for exactly reasons like this. It does make sense that they could be
> computed together since their computation is indeed quite similar. But
> in practice I think you end up spending a lot of time reasoning around
> complex conditionals like these.
> 
> So, I feel a little bit like we should spend some effort to split these
> up. I'm OK with a little bit of code duplication (though if we can
> factor out some common routine, that would also be nice). But I think
> there's a tradeoff between DRY-ness and understandability, and that we
> might be on the wrong side of it here.

You're probably right that it is valuable to split the computations.
It would allow us to skip all of the "if (ctx->write_generation_data)"
checks in this implementation and rely on the callers to make that
choice.

>>  					all_parents_computed = 0;
>>  					commit_list_insert(parent->item, &list);
>>  					break;
>> @@ -1500,12 +1511,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>  					max_level = GENERATION_NUMBER_V1_MAX - 1;
>>  				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
>>
>> -				if (current->date && current->date > max_corrected_commit_date)
>> -					max_corrected_commit_date = current->date - 1;
>> -				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
>> -
>> -				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
>> -					ctx->num_generation_data_overflows++;
>> +				if (ctx->write_generation_data) {
>> +					timestamp_t cur_g;
>> +					if (current->date && current->date > max_corrected_commit_date)
>> +						max_corrected_commit_date = current->date - 1;
>> +					cur_g = commit_graph_data_at(current)->generation
>> +					      = max_corrected_commit_date + 1;
>> +					if (cur_g - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
>> +						ctx->num_generation_data_overflows++;
>> +				}
> 
> Looks like two things happened here:
> 
>   - A new local variable was introduced to store the value of
>     'commit_graph_data_at(current)->generation' (now called 'cur_g'),
>     and
> 
>   - All of this was guarded by a conditional on
>     'ctx->write_generation_data'.
> 
> The first one is a readability improvement, and the second is the
> substantive one, no?

Yes. Adding these checks and tabs made things super-wide, so cur_g
exists only for readability. If we split the computation, then this
is no longer required.

Thanks,
-Stolee
