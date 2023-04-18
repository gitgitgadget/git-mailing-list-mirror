Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD6C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjDROC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDROC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:02:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA74C26AE
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:02:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so5246305e9.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681826544; x=1684418544;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zO+TcyKm0oodlZYYAgG+BXxWcrwB1Splf4IYYEQaWoI=;
        b=suj3Pit4olsTGmEgY5QRFRPFgVO+GGT4fP7gB0Y+ly6DRGySLhRhGz68P1ZgfN/gzo
         V8E6AwQE86R1dvRV7OE3cEYG2zj3OXctMzA5VFWiVUCTyyKmMZrYtPdOTovs4unLwNjK
         6PuGGDPWuvsaMvhHJpBd8ETHsd6nfVmB5M3q5+w1D2gbNk7EMUhiDjrudoC5ag6X198F
         QVPlf1pSMdmsc4jka5PvVTKHdemaJ9UzKPS1uQ3IupUYTvYa601Gmr9lBpJS5Rt+phyX
         DMqvFM2tI0Nhc6Sl0opvsJUJGT7SGAl9kXnSov4uKH3n4RmEb/AOtvcGejzCFbO9ywcD
         ko9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681826544; x=1684418544;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO+TcyKm0oodlZYYAgG+BXxWcrwB1Splf4IYYEQaWoI=;
        b=a3wYdygq9XyEeTMYMyTb0v+72ovr2s/mv3la65R5BdudAtzAtLYnlJ0MEyvWqMnncA
         ikspBeFRdC9ZatfAwzu8RYVfCCbKs/7/lct5Fe2BVtLuAzpwSDxLo6Vdr4s1W/5EATWv
         UfYWDv1SC440kgVrPZraPQtHncJu4rrJhyuszLxsu8ALfd60AljFGgvUXshOHRh8kj/T
         IWp2CtGRZBGTUaEBiq3Az/TlTUvGUU55UiHamthc4Vdzl+E+4aM92rp8LCWIvxPClmXp
         PE8tBns2qyaP7KfZhYEmBBQWXLvdXkOhe5Pk5poSUUWbtAPR5yC8LVU92q6uySIoN638
         79ug==
X-Gm-Message-State: AAQBX9cWJPCNnpQ/sevZOmpelLGL7K8swtpEbqR5PJfRSEd3qJUXHEen
        1T54BKQwYJrPMtEjXWEegvWfiezavCo=
X-Google-Smtp-Source: AKy350ZvAdlnqEeIB5wZit/fITtWMmC0VgNNYlxjEim5lJIi7sDBtL/5nxk3xApFnhRW1MKML32PDg==
X-Received: by 2002:a5d:50c7:0:b0:2ef:b9cb:51b0 with SMTP id f7-20020a5d50c7000000b002efb9cb51b0mr1770227wrt.34.1681826543933;
        Tue, 18 Apr 2023 07:02:23 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4d8b000000b002c7066a6f77sm13159958wru.31.2023.04.18.07.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:02:10 -0700 (PDT)
Message-ID: <788c85f0-1381-4d37-cb23-dd67f26a5b6a@gmail.com>
Date:   Tue, 18 Apr 2023 15:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git rebase no longer defaults to upstream after force push
Content-Language: en-US
To:     Erik Cervin Edin <erik@cervined.in>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik

Thanks for reporting this, unfortunately without knowing more about your 
config settings it is hard to tell what is happening here.

On 18/04/2023 10:17, Erik Cervin Edin wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
 >
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>    git init --bare foo.git && git clone foo.git/ foo && cd foo
>    touch bar && git add bar && git commit -m init
>    git push -u

This sets the upstream branch for main to origin/main, (assuming 
push.default allows pushing without specifying a refspec)

>    git switch -c a

Here you create a new branch, whether switch sets an upstream for it 
depends on the value of branch.autoSetupMerge. The default is not to set 
an upstream branch in this case. If you have set branch.autoSetupMerge 
to "always" then the upstream branch will be "main", if 
branch.autoSetupMerge is set to "inherit" then the upstream branch will 
be "origin/main". What does branch -vv show?

>    seq 1 3 > bar && git add bar && git commit -m 1
>    git push

What happens here depends on push.default, branch.autoSetupMerge and 
push.autoSetupRemote. If switch did not set an upstream branch then push 
will if you have push.autoSetupRemote enabled.

>    seq 11 13 > bar && git add bar && git commit -m 2
>    git rebase -ir # Works like git rebase -ir @{upstream}
>    git push --force origin main:a
>    git rebase -ir # No longer works like git rebase -ir @{upstream}

Without knowing what the upstream branch is it is hard to say what is 
going on here.

Best Wishes

Phillip

> What did you expect to happen? (Expected behavior)
> 
> After force pushing, I still expected the rebase to work like git
> rebase -ir @{upstream}.
> 
> What happened instead? (Actual behavior)
> 
> The rebase defaults to a commit other than that of the tip of the
> upstream branch.
> 
> What's different between what you expected and what actually happened?
> 
> Instead of behaving like git rebase @{upstream}, the rebase seems to
> default to rebasing on-top of the old upstream.
> 
> git rebase -ir result in a todo like this:
> 
> l onto
> 
> t onto
> p f1cfbff 2023-04-18    2
> 
> Compared to git rebase -ir @{upstream} which results in a todo like this:
> 
> l onto
> 
> t onto
> p 01e3c92 2023-04-18    1
> p f1cfbff 2023-04-18    2
> 
> Anything else you want to add:
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.40.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27
> 02:56:13 UTC 2023 x86_64
> compiler info: gnuc: 11.3
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]
> 
