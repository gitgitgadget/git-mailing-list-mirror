Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB2C1F42D
	for <e@80x24.org>; Mon, 23 Apr 2018 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeDWQTU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:19:20 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38949 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWQTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:19:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id f1-v6so1163958qtj.6
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w9Mdt0+neoplx6b9TKb8LMi979eGdLpXNNU8A37+FaE=;
        b=rqZNlbKekLDUGVLChcR+ghv89hGkUHDrHeOj2BkHHhoGE+M//ilVzofzOSvyLP2W6U
         gbtImgrSwtQDFWfX4FEl/fzwQhl2s/QtM2MmxbLl7klGX3UdocVpYQZUqGY8fOAUzwOb
         rKqJLWa90W3r8xZgkDmHON5t4ubCZohLf4z85sf6sLdcOqHldNT12AFSZOJlvmAGw1XE
         f9aEy6s3yv3wQBo13eXM9Vv+sw7bMTJya5mjUg7t12OB/OwO7MNnPArxPrwpWgKz19cB
         jkRQgIih9FAGGUOWnTa9DSFW+o1Dze0p3leXew5bOu4BiulqUAJTp1/sUUOutkjyJSWA
         f0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w9Mdt0+neoplx6b9TKb8LMi979eGdLpXNNU8A37+FaE=;
        b=agscZnJKbnw/A8f/Tu3zgOTlVqRpQyWBwVAzW385nycGYQjbEiqnJQ9dvylHHQuK9z
         jmYjE2Gm71uyHHzuaLMBvL7j8Ws2GlzGnKQ3ssOH/q45ru+nUQvN1v0Pr084kpjY8Uer
         IRqnnwXzO/qxrzOnTYBf+G6/tn9BRwV694BeAkhnhyHAa7CyuOX0+duv0fjshFJ8JYu1
         6bIdj0lFWCuqNDpQdU699sMJqigP5cFQZsUSiigJvn1lv/hteZ4y4A5RRJOGvUBOLTdU
         nFl76cLEfYKabFBxqk9l5g8M4utd+Tmqz1NipmQ4kc5O79+oEi4wdqJ9JU3oyhp6hqDH
         mG8Q==
X-Gm-Message-State: ALQs6tAFENd7sCT9K9gvLS4fp0no07chM8Ij3EDT4xCYhGlKrJ5aiXOq
        2B5Jd+dNI4MKnhx96+9Jvek=
X-Google-Smtp-Source: AIpwx48/5+P4Y48FWvUaJRcgpyQ2M1VUpsd68hQ4XFVy4td89PLY7lroBjFWyrnn5LEOu6xQHbB8tA==
X-Received: by 2002:ac8:1e82:: with SMTP id c2-v6mr23930961qtm.402.1524500358794;
        Mon, 23 Apr 2018 09:19:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id y13-v6sm9747124qti.84.2018.04.23.09.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 09:19:18 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <cb1c1c86-48f7-5cf6-16ff-0d54550fe958@gmail.com>
Date:   Mon, 23 Apr 2018 12:19:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/18/2018 12:49 AM, Junio C Hamano wrote:
> Jameson Miller <jamill@microsoft.com> writes:
>
>> This patch series improves the performance of loading indexes by
>> reducing the number of malloc() calls. ...
>>
>> Jameson Miller (5):
>>    read-cache: teach refresh_cache_entry to take istate
>>    Add an API creating / discarding cache_entry structs
>>    mem-pool: fill out functionality
>>    Allocate cache entries from memory pools
>>    Add optional memory validations around cache_entry lifecyle
>>
>>   apply.c                |  26 +++---
>>   blame.c                |   5 +-
>>   builtin/checkout.c     |   8 +-
>>   builtin/difftool.c     |   8 +-
>>   builtin/reset.c        |   6 +-
>>   builtin/update-index.c |  26 +++---
>>   cache.h                |  40 ++++++++-
>>   git.c                  |   3 +
>>   mem-pool.c             | 136 ++++++++++++++++++++++++++++-
>>   mem-pool.h             |  34 ++++++++
>>   merge-recursive.c      |   4 +-
>>   read-cache.c           | 229 +++++++++++++++++++++++++++++++++++++++----------
>>   resolve-undo.c         |   6 +-
>>   split-index.c          |  31 +++++--
>>   tree.c                 |   4 +-
>>   unpack-trees.c         |  27 +++---
>>   16 files changed, 476 insertions(+), 117 deletions(-)
>>
>>
>> base-commit: cafaccae98f749ebf33495aec42ea25060de8682
> I couldn't quite figure out what these five patches were based on,
> even with this line.  Basing on and referring to a commit that is
> not part of our published history with "base-commit" is not all that
> useful to others.
My apologies - this patch series should be applied to the 'next'
branch.  It applies cleanly on top of
b46fe60e1d ("merge-fix/ps/test-chmtime-get", 2018-04-20), which
is a commit in the 'next' branch.
> Offhand without applying these patches and viewing the changes in
> wider contexts, one thing that makes me wonder is how the two
> allocation schemes can be used with two implementations of free().
> Upon add_index_entry() that replaces an index entry for an existing
> path, we'd discard an entry that was originally read as part of
> read_cache().  If we do that again, the second add_index_entry()
> will be discading, in its call to replace_index_entry(), the entry
> that was allocated by the caller of the first add_index_entry()
> call.  And replace_index_entry() would not have a way to know from
> which allocation the entry's memory came from.
>
> Perhaps it is not how you are using the "transient" stuff, and from
> the comment in 2/5, it is for "entries that are not meant to go into
> the index", but then higher stage index entries in unpack_trees seem
> to be allocated via the "transient" stuff, so I am not sure what the
> plans are for things like merge_recursive() that uses unpack_trees()
> to prepare the index and then later "fix it up" by further futzing
> around the index to adjust for renames it finds, etc.

Good points. The intention with this logic is that any entries
that *could* go into an index are allocated from the memory
pool. The "transient" entries only exist for a short period of
time. These have a defined lifetime and we can always trace the
corresponding "free" call. make_transient_cache_entry() is only
used to construct a temporary cache_entry to pass to the
checkout_entry() / write_entry(). There is a note in checkout.c
indicating that write_entry() needs to be re-factored to not take
a cache_entry.

The cache_entry type could gain knowledge about where it was
allocated from. This would allow us to only have a
single "free()" function, which could inspect the cache_entry to
see if it was allocated from a mem_pool (and possibly which
mem_pool) and take the appropriate action. The downside of this
approach is that cache_entry would need to gain a field to track
this information, and I *think* all of the bit field spots are
taken.

> Let me read it fully once we know where these patches are to be
> applied, but before that I cannot say much about them X-<.
>
> Thanks.
>

