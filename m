Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E2AC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4252083B
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGxlhsom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgFSM7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732765AbgFSM65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 08:58:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B98C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 05:58:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so8728004qkm.12
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p5mfGOZe1e5BkNt0FJLidJfS5QBZsIB3xlZ7FUGDzj0=;
        b=DGxlhsomSwKDefs1T2lbRiAkJgLYmuqaOtPkg8pk9egM4sjokjfQsUv6dV6Jc9CHFV
         kD8SnIiVK5gZylSFUOzM09CkTwJ9Wu+E+uIS3wGuJqfFzfkwqmpAT3ZEtAokID13z9z8
         05Uaj9ALQNnlLPD9jnJSKcLQvgkc3ku3+wxACCwP4KAENLsXn5OT8KgRZ7RJ0ONE17zd
         R/7+zXFYcS4xquN43RYnXxiCIcEzJi9KegODUHrvzfF7P/W45skihsdSHK/oMdj+eZrR
         SdfZD9do0J1mzuGgKsWNBnBtFQJrpFdgYLAxjIANyPJuKq3gG7YHcYWjWgy7aXSJFUj9
         5kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p5mfGOZe1e5BkNt0FJLidJfS5QBZsIB3xlZ7FUGDzj0=;
        b=RPMd2uPPqyYBdkSjaXrO3qU4fttxt8gUaG3yi3ZzoFGZi7cCmBL3eQgc2yWCQ7Tryr
         eqyL7bD8k7sDWcX//sbDxfp7DKzLMQqfVL2xyRlflp33ry/RvOyL7i1ZFMDVgDlVRmiV
         jFtN9xbMIGMwEl6O8aUGNmxTyslpBuefLRaVuM7PwSEFznLpY4lyBpHXCjCQCpTtU4Yn
         azQ2pBb2D/lQPldlfbqfXPp4cV7cRXQBnoO18sPk+XgIlEpgniB58b89HbWtuHe0SHcC
         hspTMM1vA8yL+WAREPFSheKAh9gNawcldwfQmamAvMD6ZElHzW68RBYhPIDGCbOp8Wrk
         /Bhw==
X-Gm-Message-State: AOAM532vn/MxAzdxE/viud36Gd/VeJpHo8X6kB01JHknsIeET1uZp2qR
        4b/GrRT+LDdk+XFSCTKKnMs=
X-Google-Smtp-Source: ABdhPJybMxedtIt01PBpftNu0uKBjpp6OdoxrDGmdHIU52xI0JNbFOfoefDEHl8sXNCEMk6IqalCUg==
X-Received: by 2002:a37:9f46:: with SMTP id i67mr3041063qke.303.1592571535699;
        Fri, 19 Jun 2020 05:58:55 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e9sm5507355qkm.7.2020.06.19.05.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 05:58:55 -0700 (PDT)
Subject: Re: [PATCH 1/8] commit-graph: place bloom_settings in context
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <c966969071bf0ba135d304bbc0d5c16fbcbedc1e.1592252093.git.gitgitgadget@gmail.com>
 <4a7fbd99-c581-fb30-90b3-e78c30708ff2@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38a8ba15-7fed-8eec-41bf-ccae068335af@gmail.com>
Date:   Fri, 19 Jun 2020 08:58:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <4a7fbd99-c581-fb30-90b3-e78c30708ff2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/18/2020 4:30 PM, René Scharfe wrote:
> Am 15.06.20 um 22:14 schrieb Derrick Stolee via GitGitGadget:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Place an instance of struct bloom_settings into the struct
>> write_commit_graph_context. This allows simplifying the function
>> prototype of write_graph_chunk_bloom_data(). This will allow us
>> to combine the function prototypes and use function pointers to
>> simplify write_commit_graph_file().
>>
>> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  commit-graph.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 887837e8826..05b7035d8d5 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -882,6 +882,7 @@ struct write_commit_graph_context {
>>
>>  	const struct split_commit_graph_opts *split_opts;
>>  	size_t total_bloom_filter_data_size;
>> +	struct bloom_filter_settings bloom_settings;
> 
> That structure is quite busy already, so adding one more member wouldn't
> matter much.
> 
> Passing so many things to lots of functions makes it harder to argue
> about them, though, as all of them effectively become part of their
> signature, and you have to look at their implementation to see which
> pseudo-parameters they actually use.  It's like a God object.

Correct. The write_commit_graph_context _is_ a God object for the
commit-graph write. The good news is that it is limited only to
commit-graph.c and the write operations therein. Hopefully, the
code organization benefits enough from this structure to justify
the massive struct.

In contrast, it's still smaller and more contained than
"struct rev_info"!

>>  };
>>
>>  static void write_graph_chunk_fanout(struct hashfile *f,
>> @@ -1103,8 +1104,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
>>  }
>>
>>  static void write_graph_chunk_bloom_data(struct hashfile *f,
>> -					 struct write_commit_graph_context *ctx,
>> -					 const struct bloom_filter_settings *settings)
>> +					 struct write_commit_graph_context *ctx)
>>  {
>>  	struct commit **list = ctx->commits.list;
>>  	struct commit **last = ctx->commits.list + ctx->commits.nr;
>> @@ -1116,9 +1116,9 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
>>  			_("Writing changed paths Bloom filters data"),
>>  			ctx->commits.nr);
>>
>> -	hashwrite_be32(f, settings->hash_version);
>> -	hashwrite_be32(f, settings->num_hashes);
>> -	hashwrite_be32(f, settings->bits_per_entry);
>> +	hashwrite_be32(f, ctx->bloom_settings.hash_version);
>> +	hashwrite_be32(f, ctx->bloom_settings.num_hashes);
>> +	hashwrite_be32(f, ctx->bloom_settings.bits_per_entry);
>>
>>  	while (list < last) {
>>  		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>> @@ -1541,6 +1541,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>>  	struct object_id file_hash;
>>  	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>>
>> +	ctx->bloom_settings = bloom_settings;
> 
> So we use the defaults, no customization?  Then you could simply move
> the declaration of bloom_settings from write_commit_graph_file() to
> write_graph_chunk_bloom_data().  Glancing at pu I don't see additional
> uses there, so no need to put it into the context (yet?).

It certainly is not customized by a user (yet). However, you do make an
excellent point that I need to be more careful here! Patch 8
(commit-graph: persist existence of changed-paths) needs to load the
bloom_filter_settings from the existing commit-graph so we can be
future-proof from a future version customizing the settings inside the
commit-graph file!

This means that in v2 I'll move patches 7 & 8 to be after patch 1 and
add a test to verify the filter settings are preserved (after manually
changing the data in the file).

Thanks!
-Stolee
