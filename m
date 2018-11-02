Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A3A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeKCAq2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 20:46:28 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35792 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeKCAq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 20:46:27 -0400
Received: by mail-yw1-f65.google.com with SMTP id w135-v6so933954ywd.2
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Jv+0kLlcH6+hSdB6/u4cfPoQtnvEwTK5ezHEW/I4P4o=;
        b=aWAogtf6DiibsMwEgkAd2eQBzYGvaByhkJuL6yNI1zKKZPOpXbz8MBS8XErHuhLNww
         3o1iXQACjgJUEkrlxF3DEbrjORCKuzTe/xhZPffcQe8yndimZomrFsL/YNTihvGuzFG0
         w2SqPXo3AxNYgwWf6hx52a3bCLtc1vugE8JqqkfN+IC/vklJM9pJWWuXqwso36XpLbp6
         z1YoKGXcl7x52UNiY//aD4Fvnj4UgP2H6+rkMKpUGXzg4S4pJUOMNWAlOPN/sH2vjqfN
         +rtZMNGCK/s+bNw5NmQcEkzl70e2vD6J2xtCTQtLpYIQuPZEHlA/Q8GUe5G+HSpQVWtV
         zxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Jv+0kLlcH6+hSdB6/u4cfPoQtnvEwTK5ezHEW/I4P4o=;
        b=Pg8cCJZ0QE/8F2kV/oHV10l5LsMTGTbioBRYRZ7u+//gUElXj27/IIJ62F9DZixFOM
         UCoDJBunrTxKtWGe4e+JBwBch0MPXOMzjuEfNBhgKYLiQ3tPalGnffQyLK0rxCN3OZJy
         ax73sBDF5tG23aNn3ZWW2yVga1v8Gh0wCOnw6CLTEg9CcvbZNqCZ/00bU6Pab6cQ43IZ
         CuKMt4l7osc5STEdQQOaHc8Qs+JgNL25sGmzfSankpR9WfAuuNCBf0pbnDvh8cD+gdHN
         XttVpXxRRJdYZpK8HC74XUmQdTvuNZ35oTkApsgi/LT9OZ85hC05FOiTCeFt89dGJEfJ
         MUSg==
X-Gm-Message-State: AGRZ1gKLqm59VxFE19YzSoG9ctYCVZPjRbK506fVX++mn9ehmygs5ttu
        ad5ajq1JZv1Pf5x179OEUfE=
X-Google-Smtp-Source: AJdET5fPORFrFysuBGZsc5DKPgCrmWRHEkr6VmS52LIKPCPNxS8/0S7q6BNeeQA0LZVglyIMUAQ6ZQ==
X-Received: by 2002:a81:2509:: with SMTP id l9-v6mr5263636ywl.180.1541173137743;
        Fri, 02 Nov 2018 08:38:57 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q2-v6sm17410522ywa.24.2018.11.02.08.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 08:38:56 -0700 (PDT)
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
 <20181031120505.237235-1-dstolee@microsoft.com>
 <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
 <ad4ab388-6244-1811-ec1b-6f8143df620e@gmail.com>
 <CABPp-BG6+3F+FY0JP2mj0OCLjp17xQXTe54mBCN+RifQd4Aj2A@mail.gmail.com>
 <3aadf261-9ed7-6ded-4482-ab01d74802aa@gmail.com>
 <CABPp-BEa3U6m8jWrHJXjFo77T32LqEKkdDs7H89m0y_gjHgOWw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba7ee399-029d-8cff-c582-c3e54ab61796@gmail.com>
Date:   Fri, 2 Nov 2018 11:38:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEa3U6m8jWrHJXjFo77T32LqEKkdDs7H89m0y_gjHgOWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2018 10:58 AM, Elijah Newren wrote:
> On Thu, Nov 1, 2018 at 12:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 11/1/2018 2:57 PM, Elijah Newren wrote:
>>> On Thu, Nov 1, 2018 at 5:32 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>> No rush. I'd just like to understand how removing the commit-graph file
>>>> can make the new algorithm faster. Putting a similar count in the old
>>>> algorithm would involve giving a count for every call to
>>>> in_merge_bases_many(), which would be very noisy.
>>> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
>>> count: 92912
>>> To /home/newren/repo-mirror
>>>    * [new branch]              test5 -> test5
>>>
>>> real    0m3.024s
>>> user    0m2.752s
>>> sys    0m0.320s
>> Is the above test with or without the commit-graph file? Can you run it
>> in the other mode, too? I'd like to see if the "count" value changes
>> when the only difference is the presence of a commit-graph file.
> I apologize for providing misleading information earlier; this was an
> apples to oranges comparison.  Here's what I did:
>
> <build a version of git with your fixes>
> git clone coworker.bundle coworker-repo
> cd coworker-repo
> time git push --dry-run --follow-tags /home/newren/repo-mirror
> git config core.commitgraph true
> git config gc.writecommitgraph true
> git gc
> time git push --dry-run --follow-tags /home/newren/nucleus-mirror
>
>
> I figured I had just done a fresh clone, so surely the gc wouldn't do
> anything other than write the .git/objects/info/commit-graph file.
> However, the original bundle contained many references outside of
> refs/heads/ and refs/tags/:
>
> $ git bundle list-heads ../coworker.bundle | grep -v -e refs/heads/ -e
> refs/tags/ -e HEAD | wc -l
> 2396
>
> These other refs apparently referred to objects not otherwise
> referenced in refs/heads/ and refs/tags/, and caused the gc to explode
> lots of loose objects:
> $ git count-objects -v
> count: 147604
> size: 856416
> in-pack: 1180692
> packs: 1
> size-pack: 796143
> prune-packable: 0
> garbage: 0
> size-garbage: 0
>
>
> The slowdown with commit-graph was entirely due to there being lots of
> loose objects (147K of them).  If I add a git-prune before doing the
> timing with commit-graph, then the timing with commit-graph is faster
> than the run without a commit-graph.
>
> Sorry for the wild goose chase.
>
> And thanks for the fixes; get_reachable_subset() makes things much
> faster even without a commit-graph, and the commit-graph just improves
> it more.  :-)


Thanks for double-checking! It's good to have confidence that this is a good

algorithm to use.


Thanks,

-Stolee

