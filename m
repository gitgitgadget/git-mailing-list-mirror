Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE1BECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiIAPYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIAPY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:24:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988586077
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:24:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 72so17778649pfx.9
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=OaQYkpvnooLd44EaN+WYDega2dX/c5wc+48a2IlSBrE=;
        b=UZH0SWenPdH+YpNk03x3pxgOIshykCzgJFNzbbIxMphgXs6L3bi1rUaZg0ThC26bWN
         kFi52s6tH471iXK254kGUhF4wEeR9PVK3RTMA0SfXgWfibtlvl1IF8DisI6SwnIV4aBK
         SEu3lIigoDYolcSeaxHkfKhZNxnHbKQlLKHZKt173CmYivJoxMzOfVQdHM0txv4zMP00
         M44kStK2TGm7OE5o/Ne1voOcP/Zn3AehNxGLrpkLnCCxTxp45swVopBy5/wgB3JJv4wB
         dmhnae+HQeChqrxAhVmbW9AZmHjfYKIP0a4dZsAujJCIXMzmGNqf5YqaW2Vlkfnrd/5I
         qW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=OaQYkpvnooLd44EaN+WYDega2dX/c5wc+48a2IlSBrE=;
        b=M8dFaQvYAtjQqR0v1eKvhiLkgPV9zGSMk538mQpdFED1LoOj+3tNg7A4e7wj/3BGgt
         gLuPEZf841Ddn2JZ9py2KBF+dCP+ire0BvQZk2vV/z1oJ4t6rhX8Bs8r0xyhq725jsLf
         J9lvD0BeJBGkg4tskCTdnbj9FI5+afxRxmLRcyZak5eMKr/yOA3CWaIK+U/udYl0BCvj
         JYkI3r/YBGUmLhgVfL5XWFV+gXTihZucypihDuPPAEdUa0tA++Wp3pjLhyITTfUh57u9
         30UdnB/hGfn+COPnfvNg8ZQikmjaUi/LU5+W1S1QfWZ8yxKylouNvFR9Bc1DNvXqdRnE
         N+7Q==
X-Gm-Message-State: ACgBeo2+j3AGrW/AniSEcBjSPJ76pjUu5YDTWNkl1qX1mCPRzER1ui4r
        XGmC9Y6NdcounKBwgDRk8BPyx5JQGtg=
X-Google-Smtp-Source: AA6agR4ect1rQjgj1KXl1r8MCKqiDVmZgNBOe2ckW1XM5kMqCSX7fdeufL5rSt5tUXqyn0RTczKVJg==
X-Received: by 2002:a63:c149:0:b0:42b:96de:1e31 with SMTP id p9-20020a63c149000000b0042b96de1e31mr21445233pgi.369.1662045867760;
        Thu, 01 Sep 2022 08:24:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b00537ab89c66csm13886204pfb.143.2022.09.01.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:24:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/3] Output fixes for --remerge-diff
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <xmqqv8q7dhh4.fsf@gitster.g>
        <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
Date:   Thu, 01 Sep 2022 08:24:26 -0700
In-Reply-To: <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
        (Elijah Newren's message of "Wed, 31 Aug 2022 20:47:58 -0700")
Message-ID: <xmqqo7vzce39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Aug 31, 2022 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > Philippe Blain found and reported a couple issues with the output of
>> > --remerge-diff[1]. After digging in, I think one of them actually counts as
>> > two separate issues, so here's a series with three patches to fix these
>> > issues. Each includes testcases to keep us from regressing.
>>
>> Including this to 'seen' seems to break the leaks-check CI job X-<.
>>
>> https://github.com/git/git/runs/8124648321?check_suite_focus=true
>
> That's...surprising.  Any chance of a mis-merge?
>
> I ask for two reasons:
>   * This series, built on main, passed the leaks-check job.

Ah, that.

Yes, I did rebase it to 'maint' to be nice to our users as this is
not a new feature development but a bugfix or two.

This is why I hate the leak-check CI job (yes, I do help maintain
all parts of the tree, but it does not mean I have to love every bit
of the codebase, and this is one of the things I love to hate).

Instead of saying "subcommand X with feature Y? It ought to be clean
so complain if leak checker find something. subcommand Z? It is
known to be unclean, so do not bother", it says "In this test in
entirety, we currently happen to use only the ones that are clean"
and penalizes developers who wants to use an unclean tool merely for
checking.  The approach is fundamentally flawed and does not play
well with multiple integration branches, just like we saw here.
