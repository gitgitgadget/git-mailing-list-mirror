Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAABC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DB822AAF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbhAKJzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 04:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAKJzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 04:55:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDBC061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 01:54:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n26so23807168eju.6
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8cyTmuTw/bGjSykys6P5zKSkq8rA2CgNrGmoDxznKM=;
        b=g0Zsy9NIs7ihwP4aHdMEWF7s6jgOPN52n+z1BSq+lG1/f1DeXF9K3pfzDYCGWVdKxr
         uXSFBSWfRk1pIvhZ7GsWM4L//mFu69D5X3YWdFs505SNWgU+gqzqvwzcs0t2Npf8vPTa
         t+y+gaFHu4A4HMdTvoMcHQlSgzR3EVopqXdzfL2T9S9KuxEy0iyvLrkpCqobU0jgiL/K
         ytXNFm2fTmvHg/KqDkNSyNmIhxH+Ch4XY9vgjFo/WQaBE1z9gsNF3z/dqzGXBDHdK6Nr
         IaqPQ2qz8dFS0GuE3eDPBOLabsaZLmnMCGlcYOadrPsBqoEj9+IQDtpJVPYeF5m57U8d
         guoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8cyTmuTw/bGjSykys6P5zKSkq8rA2CgNrGmoDxznKM=;
        b=SkhGCMz2gpR3PesMnJlc0sTIlot7eP7zfqEdvaNZeYj8TZtLy3tHm8shzMzbmt14FQ
         2QopdQX/9j3ceex7oNYu5XlTQmNwNBo83J2bU22X7FzAW6X9bKWERCLssTZSfAbSmLql
         zVPDDMrLyN68Ov5MLSVXsnsYPLFvMzcJu07HL4e0ChnPPZ/inFZlokM/mPVpCivG+VVw
         EjIJ0n9rteNny8Ul24DtNlxwIvVTFXCS8BIOZQWnmCaSm8xFaxKRwaeIH3bz1LHLz8AZ
         4qGmkwICikC31+8p4aXH6fmPJJK2eacxzGeXUmlHdWzAaEv022NY5cvx8+vwIfjHtDfc
         He2Q==
X-Gm-Message-State: AOAM531uQkgGgfh4CK24ZD4jzmKVBi1QUxtHh/Vu7cpK3BrmH+TE8gbF
        cXk8ZI+A6M3kqqPrn6dy+xtbZuvRsi9dnzlMxQM=
X-Google-Smtp-Source: ABdhPJyQettU2OEIFI+pvjXxxG11H9U8bxk4tRF3ckOfcmIl3ABFXomCsf7XDcSe6QPMV33kD9GWUXQ7kNp7zvR6tuc=
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr10356981ejc.216.1610358869610;
 Mon, 11 Jan 2021 01:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20210109162440.GM31701@sync>
In-Reply-To: <20210109162440.GM31701@sync>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Jan 2021 10:54:18 +0100
Message-ID: <CAP8UFD3qt4xr4S1BgjPU-vm4qsb=+1JWc=LR_p1CUzTKaAcAoA@mail.gmail.com>
Subject: Re: rev-list with multiple commits sharing same patch-id
To:     Arnaud Morin <arnaud.morin@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jan 9, 2021 at 5:29 PM Arnaud Morin <arnaud.morin@gmail.com> wrote:

> I am struggling with a rev-list command, hope someone can give me a
> clue on what is going on.

[...]

> However, when using git rev-list to perform a symmetric difference, git
> is giving me a commit ID:
> $ git rev-list --left-right --cherry-pick B...master
> >dbf86d8aafc897a25a3093139b4237a62395041e

It looks like a bug. You might want to check the following test file
and let us know if a similar case is tested in it, or not:

t6007-rev-list-cherry-pick-file.sh

If not, it might be a good idea to add one using 'test_expect_failure'
instead of 'test_expect_success' to document the failure.

Thanks,
Christian.


> Note that this commit is not empty
> $ git show dbf86d8aafc897a25a3093139b4237a62395041e --stat
> commit dbf86d8aafc897a25a3093139b4237a62395041e (origin/master, master)
> Author: Arnaud Morin <hidden@mail>
> Date:   Sat Jan 9 10:30:10 2021 +0100
>
>     remove line2 and add line4 (bis)
>
>  a | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
>
> So, from git rev-list perspective, there is a diff.
>
> After digging a little bit, the thing is that this commit is having the
> following patch-id:
> $ git show dbf86d8aafc897a25a3093139b4237a62395041e | git patch-id
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
>
> Which is also already existing in an other commit:
> $ for c in $(git rev-list HEAD) ; do git show $c |git patch-id |grep 20f4ace68e80a751b07d78a27c94e83d6c5314bc; done
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc 8969d3fa9159730fd3b23199873bfb26e3d20027
>
> So, is it normal that rev-list is not able to figure out that a commit
> is existing in both branch when 2 commits share the same patch-id?
>
> Is there any way to prevent rev-list from showing this commit?
>
> Thanks for your help.
>
>
> PS. I have uploaded my test repo here:
> https://gitlab.com/arnaudmorin/git-rev-list
>
>
> --
> Arnaud Morin
>
