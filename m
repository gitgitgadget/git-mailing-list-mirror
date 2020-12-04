Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C983DC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C9D22A83
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgLDN6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgLDN6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 08:58:21 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD3C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 05:57:35 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id h10so1372923ooi.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 05:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EX1ZtnxzjsoQzOF4V52XtOnVxd2L4fXPE/d3f6kWUHg=;
        b=Cc5f+ci5lTzFYOVNF6F5gMJJiHJzLcGO6MxOD2w3Jf7/msuzj84WC6XY2P8Gmxob79
         51v0LUILQkGuvVFMNFv84JbgSAWief3nESSvxBKHAOnm66RQiHjScJ5AjkhGkUCBjIsM
         hnluRWAxXiJTVd9AelYbkBdunOef56qGHWjjsm55JgQhGP0ZhD9YShjw2Q+rwXibOH1M
         K21Dtv79SKyWkLn2JpBL599CuXcBHqiXTVWfusEfpZWbcwkc+lbPoIvmJ2ZLk31Rmr5Z
         A1YDzSb990v98jv4noE5JweMwa/vbtVByzOkIlKUU3ZOgDtwIUZ3C8PQbSSr2nNeEYID
         7cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EX1ZtnxzjsoQzOF4V52XtOnVxd2L4fXPE/d3f6kWUHg=;
        b=eZaSmBjFa9F0uCLWD4EygNZCaISN044qA705zKZTP7tjz2C8tFfvScWclhcY7CI72o
         T6N+L25Ab5Ky3eL9JD43iE7fL3WbZ2/o3vXJZx9v/g1x2bcqMWuH9NNi0GESE4TNHnK6
         t7PVSZMlaMX92HC/5iqiEljd3+fJOBdlFh4QGro+Xb00I0O20OpqxTisqvZzAvSUaAjl
         Sp7fPUgM+ghpaQYPHhs8tSiVQLfaVwAdux0SdHKgIR/fg6U4xDzqmvDV4Zlv2HrLWFUX
         3VAxnmplnk3O9FidAWfL7WwWwa5Wx1yLYmD3IpFdS8CyHVGX2XY7+F3wfAxDSZvK721i
         vxJw==
X-Gm-Message-State: AOAM533bnnx1n4W1CmcpXEuzwMd/pnW6ptKdzchrHW7Ki2c7ziw7nzuZ
        rE4UAA60bY9G2JM9xb8azIk=
X-Google-Smtp-Source: ABdhPJwXNifcuzo1E6nckI4wrL+lNSwRMEGiKW3pMcuozaeJnG56PJg2ZIaC2zMRIcXp87R807HXqw==
X-Received: by 2002:a4a:91de:: with SMTP id e30mr3556150ooh.58.1607090254993;
        Fri, 04 Dec 2020 05:57:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id h20sm620965otj.57.2020.12.04.05.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 05:57:34 -0800 (PST)
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e3387b6-d2ab-7d86-0535-2ef182fbc469@gmail.com>
Date:   Fri, 4 Dec 2020 08:57:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2020 7:48 AM, René Scharfe wrote:
> Am 03.12.20 um 17:16 schrieb Derrick Stolee via GitGitGadget:
...
>>  Documentation/technical/chunk-format.txt      |  54 ++
>>  .../technical/commit-graph-format.txt         |   3 +
>>  Documentation/technical/pack-format.txt       |   3 +
>>  Makefile                                      |   1 +
>>  chunk-format.c                                | 105 ++++
>>  chunk-format.h                                |  69 +++
>>  commit-graph.c                                | 298 ++++++-----
>>  midx.c                                        | 466 ++++++++----------
>>  t/t5318-commit-graph.sh                       |   2 +-
>>  t/t5319-multi-pack-index.sh                   |   6 +-
>>  10 files changed, 623 insertions(+), 384 deletions(-)
> 
> 623-384-54-3-3-1-69-2-6 = 101
> 
> So if we ignore changes to documentation, headers, tests and build
> script this spends ca. 100 more lines of code than the current version.
> That's roughly the size of the new file chunk-format.c -- from this
> bird's-eye-view the new API seems to be pure overhead.

Overhead in terms of lines of code, but many of those are function
prototypes and single lines containing only "{" and "}". So yes,
the code files are a bit longer, but the amount of executed code is
not meaningfully different.

Extra lines of code is an expected cost of refactoring. The remaining
question is, "is it worth the cost?" I believe it is.
 
> In the new code I see several magic numbers, use of void pointers and
> casting as well as repetition -- is this really going in the right
> direction?  I get the feeling that YAGNI.

void pointers are a cost of abstraction in C that we use all over the
codebase.

You (and Junio) are right to point out my magic numbers. Those should
be replaced with something better when possible.

As far as YAGNI, I doubt that very much. First, we have already seen
extensions to the commit-graph that added several new chunks, and
plugging into this (documented) API should be easier than the previous
ad-hoc mechanism.

I've CC'd Abhishek to get his opinion, since he's recently added chunks
to the commit-graph file. Outside of the fact that this series conflicts
with his series (which I will fix), it would be good to see if he
appreciates this model.

>> I was thinking about file formats recently and realized that the "chunks"
>> that are common to the commit-graph and multi-pack-index could inform future
>> file formats. To make that process easier, let's combine the process of
>> writing and reading chunks into a common API that both of these existing
>> formats use.

And another point on YAGNI: I'm literally prototyping a new file format and
want to use this API to build it instead of repeating myself. Specifically,
I noticed that the commit-graph and multi-pack-index were inconsistent in
how they protected the file format in different ways during writes and reads.
This leads to...

>> There is some extra benefit immediately: the writing and reading code for
>> each gets a bit cleaner. Also, there were different checks in each that made
>> the process more robust. Now, these share a common set of checks.

...my point that combining these checks make both codepaths slightly more
robust. I didn't even include the potential extension of storing the size
of each chunk in "struct commit_graph" and "struct multi_pack_index" for
run-time bound checks during lookups. That seemed like too much new
behavior for a series that intends to only refactor.

Thanks,
-Stolee
