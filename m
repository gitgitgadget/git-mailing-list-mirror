Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09F1C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA3522262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgL3TwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3TwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:52:18 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815C5C061575
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:51:38 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j12so16297806ota.7
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VfC4zFzwa8lN6ZQjylt+Ghl3bfrG5rMFbc9xff66/2k=;
        b=FTtp59bf79c4A2MApLf/NFIDXYYXuHJ1/dKnnHDCqw31FVa4UWVYCU43kT21S6ZMrv
         XVhJAVDnaA8kMJztfHMG7pzP5lzJVyH/yGlxANFjWEDqEi6qTxuXXf3RCAPnnCAIjw/L
         l5G+1E6i6luiUJxrAHe0RL+TArr+/dXK46ZbJYQ/iyIAHM9RRgKPMybVtvhIr/211NGH
         6j1jNJmbRzIK7vAGwvd7J60q6ef9K4hdVQEBEBs54+J9p1Jn6fK1Ul24yevQx8TTHqbR
         iMjIU9V/VNyFTrymIUD/hh64vLuae3UQfUXUgSUSHNKWV/ssbfDLV+yD6Re6vvwd4FYb
         NyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VfC4zFzwa8lN6ZQjylt+Ghl3bfrG5rMFbc9xff66/2k=;
        b=Y26rbqTEt3JEZ94f9OhPkexMVOmXUIvEaupVdkpNGIDqC+/NJ/jfffSnWtUNmmoZ2j
         oQeodc64zvnMTgP10JLTtA+pHoLkpJbfhJT5YytEY9yatsHX2LGwXlWJOP7gxappT3+g
         UbGCsTAw222hZC0mUVj92P6+peHC+Bf83nGRk5DacgWMSpfR7qaIVQmgescc9dSBDAt/
         i8yIrgzyq6uxucvIw/Dmkf02le5CDTNII6DWkErE86rtGxZ8EAF2qQA2TViIAeGn0mL/
         nRxaxjPqgNglkbMI1glI2cSbpj3VCzOh6nLwZUfdC7mWu2jqgP2wQUkHaz7xd1x71r7w
         cH3A==
X-Gm-Message-State: AOAM533pQ98DpNy0sPNnguOQ5EEYDjdxUQGOs9wVivv6R9DCH7gO2poa
        AsUfy9Xv3TMkvhNtE3VCPnU=
X-Google-Smtp-Source: ABdhPJxwVX345PBQSdCz9oQeXT4dUliOqmXrT/y9lXUXe5YX24xRLc/aWEean5RHX6OWmbwM4R0h0Q==
X-Received: by 2002:a9d:1ac:: with SMTP id e41mr14235979ote.46.1609357897786;
        Wed, 30 Dec 2020 11:51:37 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id z38sm10438181ooi.34.2020.12.30.11.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 11:51:37 -0800 (PST)
Subject: Re: [PATCH 1/8] tree-walk: report recursion counts
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <f727880add6e0380248279e1ad79f80762868a6c.1609356413.git.gitgitgadget@gmail.com>
 <CABPp-BHQY0v2GwmV6dokkTPGuJKmFYKJ7NCe2kes0pQbZgBGQQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b81e853a-64ef-dbe5-77d3-f3a2cf87c9bc@gmail.com>
Date:   Wed, 30 Dec 2020 14:51:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHQY0v2GwmV6dokkTPGuJKmFYKJ7NCe2kes0pQbZgBGQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 2:42 PM, Elijah Newren wrote:
> On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The traverse_trees() method recusively walks through trees, but also
> 
> recursively -- you're missing the second 'r'.

Thanks.

>> prunes the tree-walk based on a callback. Some callers, such as
>> unpack_trees(), are quite complicated and can have wildly different
>> performance between two different commands.
> 
> Not sure it belongs in the commit message, but you do have me curious
> what you're digging in to...

I'm still testing whether my idea will work out. Hopefully soon. ;)
 
>> Create constants that count these values and then report the results at
>> the end of a process. These counts are cumulative across multiple "root"
>> instances of traverse_trees(), but they provide reproducible values for
>> demonstrating improvements to the pruning algorithm when possible.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  tree-walk.c    | 33 +++++++++++++++++++++++++++++++++
>>  unpack-trees.c |  1 -
>>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> From the subject, you are changing tree-walk.  unpack-trees depends on
> tree-walk, but why is something exposed to it with this kind of
> change?  Maybe I'll see when I get to it.

Oops. I originally reported the stats at the end of unpack_trees(), but
it seems I didn't completely back out that change.

>> diff --git a/tree-walk.c b/tree-walk.c
>> index 0160294712b..2d6226d5f18 100644
>> --- a/tree-walk.c
>> +++ b/tree-walk.c
>> @@ -4,6 +4,7 @@
>>  #include "object-store.h"
>>  #include "tree.h"
>>  #include "pathspec.h"
>> +#include "json-writer.h"
>>
>>  static const char *get_mode(const char *str, unsigned int *modep)
>>  {
>> @@ -167,6 +168,25 @@ int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
>>         return 1;
>>  }
>>
>> +static int traverse_trees_atexit_registered;
>> +static int traverse_trees_count;
>> +static int traverse_trees_cur_depth;
>> +static int traverse_trees_max_depth;
>> +
>> +static void trace2_traverse_trees_statistics_atexit(void)
>> +{
>> +       struct json_writer jw = JSON_WRITER_INIT;
>> +
>> +       jw_object_begin(&jw, 0);
>> +       jw_object_intmax(&jw, "traverse_trees_count", traverse_trees_count);
>> +       jw_object_intmax(&jw, "traverse_trees_max_depth", traverse_trees_max_depth);
>> +       jw_end(&jw);
>> +
>> +       trace2_data_json("traverse_trees", the_repository, "statistics", &jw);
>> +
>> +       jw_release(&jw);
>> +}
> 
> Yeah, I don't know the json_writer or trace2 stuff; might be nice to
> cc Josh Steadmon or someone to review this patch.  (Or perhaps he
> already reviewed internally?)

I guess I could have pointed out that this change is modeled after
a similar statistics reporting in 42e50e78 (revision.c: add trace2
stats around Bloom filter usage, 2020-04-06).

>> +
>>  void setup_traverse_info(struct traverse_info *info, const char *base)
>>  {
>>         size_t pathlen = strlen(base);
>> @@ -180,6 +200,11 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
>>         info->namelen = pathlen;
>>         if (pathlen)
>>                 info->prev = &dummy;
>> +
>> +       if (trace2_is_enabled() && !traverse_trees_atexit_registered) {
>> +               atexit(trace2_traverse_trees_statistics_atexit);
>> +               traverse_trees_atexit_registered = 1;
>> +       }
>>  }
>>
>>  char *make_traverse_path(char *path, size_t pathlen,
>> @@ -416,6 +441,12 @@ int traverse_trees(struct index_state *istate,
>>         int interesting = 1;
>>         char *traverse_path;
>>
>> +       traverse_trees_count++;
>> +       traverse_trees_cur_depth++;
>> +
>> +       if (traverse_trees_cur_depth > traverse_trees_max_depth)
>> +               traverse_trees_max_depth = traverse_trees_cur_depth;
>> +
>>         if (n >= ARRAY_SIZE(entry))
>>                 BUG("traverse_trees() called with too many trees (%d)", n);
>>
>> @@ -515,6 +546,8 @@ int traverse_trees(struct index_state *istate,
>>         free(traverse_path);
>>         info->traverse_path = NULL;
>>         strbuf_release(&base);
>> +
>> +       traverse_trees_cur_depth--;
> 
> I double-checked to see if there were any other return sites in this
> function.  There aren't, which is nice and keeps this clean.
> 
>>         return error;
>>  }
>>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 323280dd48b..02f484604ac 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1559,7 +1559,6 @@ static void populate_from_existing_patterns(struct unpack_trees_options *o,
>>         free(sparse);
>>  }
>>
>> -
> 
> Did you mean to combine this cleanup with some other patch?  If not,
> could it be put into its own patch?

It should be dropped! Thanks.

>>  static int verify_absent(const struct cache_entry *,
>>                          enum unpack_trees_error_types,
>>                          struct unpack_trees_options *);
>> --
>> gitgitgadget
> 
> Seems like a good change other than a few small nits.  I don't know
> the json_writer/trace2 stuff, so you might want another reviewer, but
> it's only a few lines and seems relatively straightforward.

I should point out that an easy way to test this locally is
to run

  GIT_TRACE2_PERF=1 git read-tree -mu HEAD

to trigger a full recursive walk. The output JSON payload looks
like this:

  statistics:{"traverse_trees_count":203,"traverse_trees_max_depth":7}

Thanks,
-Stolee
