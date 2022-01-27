Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFEC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiA0LBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiA0LBk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:01:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D8C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:01:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1583576wms.3
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jur9NzgbTff9BfcxQPvJuoNt5ScM3SvT7gaAwUL7aHw=;
        b=UDTGBuYlIIcCtRuJEyDvDUTKHE9HEeaeXRIw1zJpqg44shFV7RK603hFUsUrzMq73J
         wXb3uXbVPXPtBXei/fW9vgI8dmiuzbav4kghN8g7dVwfo6QbpbG6tvEQYDmfXoZYYGKT
         HvIV37lBcCJlIRsOUPqb1ZWb8lAQb84byBpWq4hbN6uc5GNa9LKxMVa7i7NuUgOtl1hZ
         +n1QrQ3Q425C//lejR2Ssg9L7EN9lR63wOLgzqHtIUHC2J5YZ4LzwuuvEPOFSFTUJVXC
         4PoLQFRZaZ02kZR5HpZaXNY7wUYgAt6eFlhkmfeoAbgz8O7d+5ZaIO/cnKtHEF7vNbbV
         hb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jur9NzgbTff9BfcxQPvJuoNt5ScM3SvT7gaAwUL7aHw=;
        b=Se32R7Wz+5fvDWfDEDP/XVVAk6JJrc+glfzS1m1pps8bXEw0SkEdDScWP9nEPK5Yrr
         4rb90L0o8EzzEkh+8BPW5OcbgF61xCv8BSxZYQJm/bwgVz1rfnCUkf7hNyaGrjbri+c0
         +HKNELV2ri1viWlfF+xZ5aF3/wTgcZ2wY1fKAd0+hB0xKn2mwZ9LGMdlaI6GgTyS1LfA
         4AVoR+pm0ZXLk/WlE5Cwa+ypOIJp9+HHNbkn0p2tIWmEuO7QZFVJ/R43st34Wf7gbrHs
         hfp7PdKXevT30p5/vZTCisX4YiKwEeafegyhaWiMwopqZPZqdL3iX1kTbUYL+4gTLdfS
         yurw==
X-Gm-Message-State: AOAM531EXUYkGsw7A7lZLjTJdsV4ko7y1aprMALhHRn/UKXzkBwu1PCl
        fLwsIe8APyXCAMRmUX1Enbw=
X-Google-Smtp-Source: ABdhPJzSDOt7Q0ZnX992AHd0kocOr6gDD1XYqIyIMWqlE2by3SnePNrxig5nvR2yNG24sH3nX/tMag==
X-Received: by 2002:a05:600c:1498:: with SMTP id c24mr2763657wmh.78.1643281298792;
        Thu, 27 Jan 2022 03:01:38 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id o10sm2198275wri.19.2022.01.27.03.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 03:01:38 -0800 (PST)
Message-ID: <b56c8855-df66-4e6d-6bc8-01cd06dd0feb@gmail.com>
Date:   Thu, 27 Jan 2022 11:01:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren <newren@gmail.com>, Glen Choo <chooglen@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
 <4cdb1e15-31d8-7fa4-b1f3-b43498685e13@gmail.com>
 <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/2022 17:53, Eric Sunshine wrote:
> On Wed, Jan 26, 2022 at 6:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 25/01/2022 23:59, Elijah Newren wrote:
>>> There's nothing wrong with running checkout from a subdirectory.  It
>>> is unfortunate that setup.c auto-discovers both the git directory and
>>> the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
>>> the case of a non-main worktree; it's not particularly friendly for
>>> subcommands.  Of course, it's also unfortunate that sequencer still
>>> forks subprocesses other than those requested by a user with e.g.
>>> --exec.
>>>
>>> But, anyway, I've got a patch that I'll send as soon as it passes CI
>>> (https://github.com/git/git/pull/1205).
>>
>> The patch hasn't come through to me on the mailing list yet, but it
>> looks good. I thought we set both GIT_DIR and GIT_WORK_TREE when we were
>> in a non-main worktree but obviously we don't. Eric do you happen to
>> know if that is intentional?
> 
> As far as I know, there is no reason to set GIT_DIR and GIT_WORK_TREE,
> in general, when in a linked worktree since each worktree has its own
> .git file ("gitfile") which tells Git commands where the repository is
> and signals that that directory itself (which contains the .git file)
> is indeed a Git worktree.

Oh of course I should have thought of that. Now I'm wondering why we're 
exporting GIT_DIR - I should go and read the code for myself.

Thanks

Phillip
