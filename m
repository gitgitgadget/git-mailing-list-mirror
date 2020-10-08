Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614C2C43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01377215A4
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFU/opBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJHJHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHJHp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 05:07:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5DC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 02:07:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so5614460wmd.5
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rd6lZ0eikS2lwG5JylJ/NPlpJY1yb7cwghbOIMWdGY=;
        b=qFU/opBtXfn4d9bITF2hdAcv6ZS0aslfhsg2FZ43uzsVcv7sA4MGQoKtpfIO1Bfo9f
         Uqv8WzU/hJJj18X1MrhQj0ofTt3XARAMP5ixb75nDz1BFjR8J2gZ3JbxkdQAhhv3g3MS
         RvwtgmzFVqh8xFeDU5BoR6wKMGw3grPKFEZR4jV6gc+FefGOPQ5iqibAPd06AXgFM5ta
         YV95S86vlU2NYhGoWMKQk5+ZyTCTuWkKz8qijovV+HbeJBqiug4N1SMNpuObaSPmxYjF
         EPjwPxCDGYxHucJ34+ExTKCv6TDBU//Egf9mTrw3G07PL/mBj2OLtCJiz+1sdjom2PFB
         123Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rd6lZ0eikS2lwG5JylJ/NPlpJY1yb7cwghbOIMWdGY=;
        b=ndUzY7K/k/bcGCfguKRlVp8zmeSF1eKD3kttrb3cHTnANoTerrxQIwk3o/7HxvngHD
         APLzyn7z0lhFH7Y0UpT4uJCvNlUnwCN05uAafZgNLlxrvGS3NcahNaWR+gXlUVq59M4h
         8u7Zo2Lj2Q/IQZVDKqD6/FQ776MjeMMCBIhwShAEuNpHR64zKXZivzAwXT66VY8gIJM/
         q1azTTj2vsf94/49DSV4xdQ0Z3SgnzZXXsmHn3muLJsYc55YLJzbItQ/YvRaotDzOA2u
         6CI7v/ICu/ciNQXvVQqtZPYh3zQk1T/0gse2GYGC26GDYKGMXZZf4nvgf2I842WYQGcd
         p8Ew==
X-Gm-Message-State: AOAM532hAawkXCHwxl7xn2amL8IJ2C1DYXzfzi0+SLtPce1SQhJC3xzZ
        eTpZCPw4QIIaJzm6LNFinycfPrtl35U=
X-Google-Smtp-Source: ABdhPJwDDP0/84GNM05Iz+6MqPsKYa4rwzvSHqXlUWBTlXrBXgKr/ROrcseYlYrqLoAV8tXD6d70Tg==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr8089496wmf.185.1602148063402;
        Thu, 08 Oct 2020 02:07:43 -0700 (PDT)
Received: from [192.168.1.21] (88-105-142-27.dynamic.dsl.as9105.com. [88.105.142.27])
        by smtp.gmail.com with ESMTPSA id c8sm6695627wmd.18.2020.10.08.02.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 02:07:42 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>, git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
Date:   Thu, 8 Oct 2020 10:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 07/10/2020 21:10, Sangeeta NB wrote:
> Hello everyone,

Welcome to the list

> My name is Sangeeta and I’m one of the Outreachy applicants.  I would
> like to work on the microproject "Unify the meaning of dirty between
> diff and describe".
> 
> While looking at the files for `describe` and `diff` commands I found
> that the `describe.c`  is present in builtin[1] folder whereas diff.c
> is found in the root[2] folder as well as builtin[3] folder. I could
> not find any implementation of --dirty in the diff.c present in
> builtin[3] folder. So is it that I have to compare the implementation
> of describe.c[1] and diff.c(of root folder)?
> 
> Also, I was curious to know why is there a builtin folder when many
> commands described in that are described again in the root folder?

The files in the root directory are (mostly) library code that ends up 
in libgit.a. The builtin directory contains the individual git commands 
that form the git binary that is linked with libgit.a. builtin/diff.c 
contains cmd_diff() which will be called when the user runs `git diff`. 
That function parses the command line options and sets up the necessary 
data to pass to the diff implementation in /diff.c. The diff and log 
family of commands are a bit different to most of the other commands in 
that the option parsing is mostly done by calling setup_revisions() in 
/revision.c rather than using the option parsing library routines in 
/parse-options.c directly. I think the `--dirty` option for diff ends up 
being handled by handle_ignore_submodules_arg() in submodule.c, I'll 
leave it to you to see where that is called from (you can use `git grep`).

I'm going to be off line for the rest of today, hopefully someone else 
will be able to help if you get stuck or I'll try and answer any other 
questions tomorrow.

Best Wishes

Phillip

> Looking forward to working with you all.
> 
> Sangeeta
> [1] https://github.com/git/git/blob/master/builtin/describe.c
> [2] https://github.com/git/git/blob/master/builtin/diff.c
> [3] https://github.com/git/git/blob/master/diff.c
> 
