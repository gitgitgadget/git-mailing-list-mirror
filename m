Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478C01F464
	for <e@80x24.org>; Thu, 26 Sep 2019 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfIZNsa (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:48:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIZNsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:48:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so2650049wml.4
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uKkX0MTq9A/R6a7YPAAzTJx1lTWz+xF9r/a8tInyNbo=;
        b=F4AhJzCdhIY7aRKfRPx9kh2UEUelw0dDXxH8I71VO9OPrccx4652/kVYgqNaI95fb0
         qXbQUIxD0/G+rUOMOUPoLOrxOOQxwhSm+DgR8qUXCrgN8FIn+WEgn6F0uhy31rYSW9GB
         5QwDFEZTtVtDXhDX5bM1Ztd+dahpmTnzOac5Xi1GgWfQPJh/QAQBbFJDoHn5z3Uq9ohv
         FfNQ7on+P/koA4y6HxsELTCn919IVWVNDyUZRIbglygfyYs3j2vbl8LWWGuPXn5+4BUe
         p+f8sjNUuzETmsgLeVGDRaaKOUQFL/ko3vQxbS9ItswDscIRTV6CIlJS2MnPvuiYdf86
         gxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uKkX0MTq9A/R6a7YPAAzTJx1lTWz+xF9r/a8tInyNbo=;
        b=Zvq89fRtdH1T1wEwDasVq3em7adeOoKQwv/f9O7bw468Fg/i7sU9ioN1smjnl5jxdb
         F0Xsqtdid6bNDFQA38ibf+ni9X7292MnT4PvO7UEEh7X9yHQoBfsNcX8hZxtEpdZ4/nL
         m7JoqD+BHO7TmvSM1QJ/2qR5rsRK3j9BH2hWJVUIgJsmiZS0ielD0YEDJRO69mXt9AEA
         IoYYk97LCZuPeEyZVrgmhqmhTPOPkCBukj9LTfPmg58w/hIKywFWl89PIRMW1dO3yRZc
         HIT3EMpFu5gZNd1S4b+Csue8fQFXcUdmKQE+g+RiYMCpyDCTPEd4B3Th+I0AFbU+N7rp
         Y+Og==
X-Gm-Message-State: APjAAAXJgdfcwPcoCacvvWmEowmFo+eo8ez16/mZvJoj0XO4DCtBR/U8
        ZevVH0DXmNvv0fkPEwlOqnMccXA0
X-Google-Smtp-Source: APXvYqyLGqVmy9UqpbtS4jtd2ORBm/0tXJrGtbQdtH3oKuKGaUfNEg9EKvRsK3x9TZTqVA/UGOQ3rw==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr3250906wmc.125.1569505706640;
        Thu, 26 Sep 2019 06:48:26 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id z142sm7282241wmc.24.2019.09.26.06.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:48:26 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/19] hashmap bug/safety/ease-of-use fixes
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <935a9ad6-2dfb-3073-9f62-4e0f7bf7a170@gmail.com>
Date:   Thu, 26 Sep 2019 14:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 24/09/2019 02:03, Eric Wong wrote:
> Patches 1-11 are largely unchanged from the original series with the
> exception of 2, which is new and posted at:
> 
> 	https://public-inbox.org/git/20190908074953.kux7zz4y7iolqko4@whir/
> 
> 12-17 take further steps to get us away from hashmap_entry being
> the first element, but they're also a bit ugly because __typeof__
> isn't portable
> 
> 18-19 finally brings me to the APIs I want to expose without
> relying on __typeof :)

Looking at the overall diff for this series looks a lot nicer with the 
extra patches that eliminate most of the explicit calls to 
container_of(). Thanks for the improved api and the cocci-check patch as 
well.

I've only had time for a quick look through but the patches seem well 
ordered and easy to follow. I think there are some line folding issues 
where you have wrapped a line when you added the type parameter and then 
removed it in a later path without re-flowing the line. Apart from that 
the only thing I noticed is that hashmap.h still starts with

   * struct long2string {
   *     struct hashmap_entry ent; // must be the first member!

Is that still the case now that hashmap_{get,put,remove}_entry() use 
container_of() and hashmap_init() takes a struct hashmap_entry? That 
comment is in a lot of our structure definitions as well.

Best Wishes

Phillip

> Apologies for the delays, been busy with other stuff...
> 
> Previous discussion starts at:
> 
> 	https://public-inbox.org/git/20190826024332.3403-1-e@80x24.org/
> 
> The following changes since commit 745f6812895b31c02b29bdfe4ae8e5498f776c26:
> 
>    First batch after Git 2.23 (2019-08-22 12:41:04 -0700)
> 
> are available in the Git repository at:
> 
>    https://80x24.org/git-svn.git hashmap-wip-v2
> 
> for you to fetch changes up to 212a596edd99169b284912b7b70b6280e2fb90e6:
> 
>    hashmap: remove type arg from hashmap_{get,put,remove}_entry (2019-09-24 00:42:22 +0000)
> 
> ----------------------------------------------------------------
> Eric Wong (19):
>        diff: use hashmap_entry_init on moved_entry.ent
>        coccicheck: detect hashmap_entry.hash assignment
>        packfile: use hashmap_entry in delta_base_cache_entry
>        hashmap_entry_init takes "struct hashmap_entry *"
>        hashmap_get_next takes "const struct hashmap_entry *"
>        hashmap_add takes "struct hashmap_entry *"
>        hashmap_get takes "const struct hashmap_entry *"
>        hashmap_remove takes "const struct hashmap_entry *"
>        hashmap_put takes "struct hashmap_entry *"
>        introduce container_of macro
>        hashmap_get_next returns "struct hashmap_entry *"
>        hashmap: use *_entry APIs to wrap container_of
>        hashmap_get{,_from_hash} return "struct hashmap_entry *"
>        hashmap_cmp_fn takes hashmap_entry params
>        hashmap: use *_entry APIs for iteration
>        hashmap: hashmap_{put,remove} return hashmap_entry *
>        hashmap: introduce hashmap_free_entries
>        OFFSETOF_VAR macro to simplify hashmap iterators
>        hashmap: remove type arg from hashmap_{get,put,remove}_entry
> 
>   attr.c                              |  22 ++---
>   blame.c                             |  25 +++---
>   builtin/describe.c                  |  21 +++--
>   builtin/difftool.c                  |  56 ++++++------
>   builtin/fast-export.c               |  15 ++--
>   builtin/fetch.c                     |  30 ++++---
>   config.c                            |  24 +++---
>   contrib/coccinelle/hashmap.cocci    |  16 ++++
>   diff.c                              |  31 ++++---
>   diffcore-rename.c                   |  15 ++--
>   git-compat-util.h                   |  33 ++++++++
>   hashmap.c                           |  58 ++++++++-----
>   hashmap.h                           | 164 +++++++++++++++++++++++++++++-------
>   merge-recursive.c                   |  87 ++++++++++---------
>   name-hash.c                         |  57 +++++++------
>   oidmap.c                            |  20 +++--
>   oidmap.h                            |   6 +-
>   packfile.c                          |  22 +++--
>   patch-ids.c                         |  18 ++--
>   range-diff.c                        |  10 +--
>   ref-filter.c                        |  31 ++++---
>   refs.c                              |  23 +++--
>   remote.c                            |  21 +++--
>   revision.c                          |  28 +++---
>   sequencer.c                         |  44 ++++++----
>   sub-process.c                       |  20 +++--
>   sub-process.h                       |   4 +-
>   submodule-config.c                  |  52 +++++++-----
>   t/helper/test-hashmap.c             |  49 ++++++-----
>   t/helper/test-lazy-init-name-hash.c |  12 +--
>   30 files changed, 647 insertions(+), 367 deletions(-)
>   create mode 100644 contrib/coccinelle/hashmap.cocci
> 
> Eric Wong (19):
>    diff: use hashmap_entry_init on moved_entry.ent
>    coccicheck: detect hashmap_entry.hash assignment
>    packfile: use hashmap_entry in delta_base_cache_entry
>    hashmap_entry_init takes "struct hashmap_entry *"
>    hashmap_get_next takes "const struct hashmap_entry *"
>    hashmap_add takes "struct hashmap_entry *"
>    hashmap_get takes "const struct hashmap_entry *"
>    hashmap_remove takes "const struct hashmap_entry *"
>    hashmap_put takes "struct hashmap_entry *"
>    introduce container_of macro
>    hashmap_get_next returns "struct hashmap_entry *"
>    hashmap: use *_entry APIs to wrap container_of
>    hashmap_get{,_from_hash} return "struct hashmap_entry *"
>    hashmap_cmp_fn takes hashmap_entry params
>    hashmap: use *_entry APIs for iteration
>    hashmap: hashmap_{put,remove} return hashmap_entry *
>    hashmap: introduce hashmap_free_entries
>    OFFSETOF_VAR macro to simplify hashmap iterators
>    hashmap: remove type arg from hashmap_{get,put,remove}_entry
> 
>   attr.c                              |  22 ++--
>   blame.c                             |  25 +++--
>   builtin/describe.c                  |  21 ++--
>   builtin/difftool.c                  |  56 ++++++----
>   builtin/fast-export.c               |  15 ++-
>   builtin/fetch.c                     |  30 ++---
>   config.c                            |  24 ++--
>   contrib/coccinelle/hashmap.cocci    |  16 +++
>   diff.c                              |  31 +++---
>   diffcore-rename.c                   |  15 ++-
>   git-compat-util.h                   |  33 ++++++
>   hashmap.c                           |  58 ++++++----
>   hashmap.h                           | 164 +++++++++++++++++++++++-----
>   merge-recursive.c                   |  87 ++++++++-------
>   name-hash.c                         |  57 +++++-----
>   oidmap.c                            |  20 ++--
>   oidmap.h                            |   6 +-
>   packfile.c                          |  22 ++--
>   patch-ids.c                         |  18 +--
>   range-diff.c                        |  10 +-
>   ref-filter.c                        |  31 ++++--
>   refs.c                              |  23 +++-
>   remote.c                            |  21 ++--
>   revision.c                          |  28 +++--
>   sequencer.c                         |  44 +++++---
>   sub-process.c                       |  20 ++--
>   sub-process.h                       |   4 +-
>   submodule-config.c                  |  52 +++++----
>   t/helper/test-hashmap.c             |  49 +++++----
>   t/helper/test-lazy-init-name-hash.c |  12 +-
>   30 files changed, 647 insertions(+), 367 deletions(-)
>   create mode 100644 contrib/coccinelle/hashmap.cocci
> 
> 
> base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
> 
