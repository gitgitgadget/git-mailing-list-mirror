Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCB61F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 10:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407902AbfJXKj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:39:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38369 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393146AbfJXKjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:39:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id o25so23733712qtr.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2QHFxpfnkX5Rc01R5XLxkdbB9e+BeyUYoXdADcnYRkY=;
        b=Y3R90uKW8HFxfXo1Fej39z+bG24o7obRew/TZ8zG6BkkNTgtoXDlNZWsjbdQ+hwzUC
         +KasL+O0WXvT2cXBNva7SD2AEiCEUSlAHQIxn8MlhKxnGC1qR1lyZiZnnd2YK2+Bb3he
         zC9UkpVHGnKFdk+52rIQG6PTv5hVldUXiMInVSZOcjeQJcjYpMkToOluJ2kpuRjO1XSS
         KTkmrhYgGylwXHQIX/1BjgjW1KzEHN1D1f+/OLIPxzG2eMzDtOJeo7w487HxIxI+5F8S
         jjEHo4y/AEZMCXHXRrQW/1Kbl/NWDAJgV8n7hgMiQWweumCmfvdqd9uQiXGDARn7WE4a
         066A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2QHFxpfnkX5Rc01R5XLxkdbB9e+BeyUYoXdADcnYRkY=;
        b=glaA4WRA3r+3SrlUWbhYgMBjLLzJ1qMYZGm+UfeqLquX75JQjAnapEDn4bsIWHQpLb
         pAwkNaeiND/YCT8lPobrnKn0xbQeIaCukpO8TPfdRDGtSA04ful5Ci/gMhse+TP0lHst
         K2HYitf3VagYonnGLVBq5qJSp3yqtxwTnBb9bvUjkK3lAlCE8HvBn/oIyKqU9K4iUlgk
         oZKXr7YG/0KIogZfecVwHUCfhLYc0i7+bDYgbJWFSM7RX+zQ//U0ISAaNWY3zBUyUp2z
         I+CDmkqgdJANIrGTl3bRPUPMSf3fm1EHtiz5bYwX75dzI+EsQsD9Uz1k+U+I6zrrZnT9
         bHIA==
X-Gm-Message-State: APjAAAXhNp0atGQJ/ymhjgm9GZoFV/hEzfQBQ+jJDLfVNYqzpIoQLjdl
        T3p2dXCbNExkFUr0vD5pMkngmCZFPr0=
X-Google-Smtp-Source: APXvYqykImt/zUs/pArcvOCWffXU+Ca4KmxHtRxr0J0tz/1Yy0IK7fkXzwKPtUOj3JD1/E4ckJXeXw==
X-Received: by 2002:a0c:fdcc:: with SMTP id g12mr11853219qvs.104.1571913594165;
        Thu, 24 Oct 2019 03:39:54 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l3sm18997814qtc.33.2019.10.24.03.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 03:39:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] commit-graph: fix writing first commit-graph
 during fetch
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
 <ca59b118f1fa4176214f55b8993145b5e1db39a0.1571835695.git.gitgitgadget@gmail.com>
 <20191023150402.GB26017@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e2eb7b76-a29b-04c4-e698-f3a67ae56ecc@gmail.com>
Date:   Thu, 24 Oct 2019 06:39:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191023150402.GB26017@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23/2019 11:04 AM, SZEDER Gábor wrote:
> On Wed, Oct 23, 2019 at 01:01:35PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>> You may ask: did this feature ever work at all? Yes, it did, as long as
>> you had a commit-graph covering all of your local refs. My testing was
>> unfortunately limited to this scenario. The UNINTERESTING commits are
>> always part of the "old" commit-graph, and when we add new commits to a
>> top layer of the commit-graph chain those are not needed. If we happen
>> to merge layers of the chain, then the commits are added as a list, not
>> using a commit walk. Further, the test added for this config option in
>> t5510-fetch.sh uses local filesystem clones, which somehow avoids this
>> logic.
> 
> Does this last sentence still holds, given that a submodule plays a
> crucial role in triggering this bug?  I think it either doesn't, or
> I still don't completely understand the situation.

This does not apply anymore. I forgot to delete it.
 
>> I tested running clear_commit_marks_many() to clear the UNINTERESTING
>> flag inside close_reachable(), but the tips did not have the flag, so
>> that did nothing.
>>
>> It turns out that the calculate_changed_submodule_paths() method is at
>> fault. Thanks, Peff, for pointing out this detail! More specifically,
>> for each submodule, the collect_changed_submodules() runs a revision
>> walk to essentially do file-history on the list of submodules. That
>> revision walk marks commits UNININTERESTING if they are simiplified away
> 
> s/simiplified/simplified/
> 
>> by not changing the submodule.
>>
>> Instead, I finally arrived on the conclusion that I should use a flag
>> that is not used in any other part of the code. In commit-reach.c, a
>> number of flags were defined for commit walk algorithms. The REACHABLE
>> flag seemed like it made the most sense, and it seems it was not
>> actually used in the file. The REACHABLE flag was used in early versions
>> of commit-reach.c, but was removed by 4fbcca4 (commit-reach: make
>> can_all_from_reach... linear, 2018-07-20).
>>
>> Add the REACHABLE flag to commit-graph.c and use it instead of
>> UNINTERESTING in close_reachable(). This fixes the bug in manual
>> testing.
> 
> I'm inclined to agree that using a flag that is not used anywhere else
> is the safest thing to do, and at -rcX time safest is good.  I'm not
> sure whether it's the right thing to do in the long term, though.
> 
> Furthermore, calling this flag REACHABLE is misleading, because the
> code actually means SEEN.
> Consider the following sequence of commands:
> 
>   # Create a pack with two commits
>   $ git commit --allow-empty -m one &&
>   $ git commit --allow-empty -m two &&
>   $ git repack -ad &&
>   # Make one of those commits unreachable
>   $ git reset --hard HEAD^ &&
>   # Not even from reflogs!
>   $ git reflog expire --expire-unreachable=now --all
>   # Now write a commit-graph from that pack file
>   $ git commit-graph write
>   Computing commit graph generation numbers: 100% (2/2), done.
> 
> It added two commits to the commit-graph, although one of them is
> clearly not reachable anymore, so marking it as REACHABLE while
> enumerating all commits feels wrong.

Since you are using "git commit-graph write", the command is scanning
all pack-files for commits to include. Even in this case, the
close_reachable() method needs to walk to see if any commits are missing.
(It could be that the root commit is loose for some strange reason.)

In this case, we are marking REACHABLE the commits that can be reached
from our "starting" commits. In your example we start with every commit.

If you had used `git commit-graph write --stdin-packs` and provided a
small pack name over stdin, the concept would be similar and even more
pronounced: the pack (perhaps downloaded via 'fetch') is not likely to
contain every commit, so we need to walk all reachable commits from
those included.

I'll have a v3 today with the requested fixes.

Thanks,
-Stolee
