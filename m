Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2710C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiARTtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiARTtL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 14:49:11 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DDDC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 11:49:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k1-20020a63d841000000b003417384b156so85423pgj.13
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=+a7uAl6hP8GT7iOqPZifApfuDyk7CHkwdMr1S2Mw2qA=;
        b=knMwlYTc0V8Egz8kvU9gvrGq9H4RAA5lAEC/pTNxbgPVDZSrYDUzTKNi+s2bfePzgF
         BgeXktixvhBPONvwZPEvhEnbO28K05LxUIiQK4y1/9e4IXONH9qtJcLXsekkWIi4fMUL
         56lYs7hzTEDRlVEMxM3VEX2xCY20oieJ0Z+Jt6LJInSjqP1QW1FFo0nk1zBVMOg7twho
         VMKmt0+RqDKS6TzTnOjp1iWqdvi51O6woQfQBLieX8iPDEPrAKW3djTdz+bB9XbAaOvD
         ZGzQVLdWZ2dBayPFG5t6KRQ2GfTcMp4fc1CbV7nkPomZiwCtOxFar/BWQ3z7xivoO7zX
         NgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=+a7uAl6hP8GT7iOqPZifApfuDyk7CHkwdMr1S2Mw2qA=;
        b=fxdg0/MxfwQGGrP3dW78uMd/+oNdFQb+otrfSdnQFNrqm6xyRj3G0WsE/btc8YtK8k
         yYhAFbzRVO08ORA6PQO87Lh9UIc2zSsUwT2EtJx7Qfv1CZ7/vvn19C2bG5cWdCf94var
         adODdpuGvNQIqvfqWNmLc34Jg6MPnWjZWT7Mp4s0GcX9XZH2iEaAacjFvPffEbP33Z1k
         6DcrqYjdigXUpPAJtu1YR+1mYXgoD5l61YrwBaG6/+6wgpSH2KvItIj+5OBuF/2XJ7rH
         9Rif0IjWbrBIegKl+FZ3IcYtXOPMGUkoLYplEZKVJt1UYViBuCgtszVs6G5p5EFXGs6F
         IYOA==
X-Gm-Message-State: AOAM531gezuKfqxNJEVqGKO1lcq0itn78tbZ0/x1HajRp9CH4K1gFIh9
        iRr+hQhGsJTHO129YNEfbv1VddCJiEwkOw==
X-Google-Smtp-Source: ABdhPJwmOQYMrwy5hEtuD09uhY3p3P/H8e2D7VnbGz9Ai/unmmF7xwxlQ5HZz2xtduphR84p4BDTPNGLGx9CpQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1bc3:: with SMTP id
 oa3mr117141pjb.131.1642535351336; Tue, 18 Jan 2022 11:49:11 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:49:09 -0800
In-Reply-To: <220118.86a6ftowx3.gmgdl@evledraar.gmail.com>
Message-Id: <kl6ltue0ygcq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqy23h4nss.fsf@gitster.g> <220118.86a6ftowx3.gmgdl@evledraar.gmail.com>
Subject: Re: ab/config-based-hooks-2 (was: What's cooking in git.git (Jan
 2022, #04; Fri, 14))
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jan 14 2022, Junio C Hamano wrote:
>
>> * ab/config-based-hooks-2 (2022-01-07) 17 commits
>>  - run-command: remove old run_hook_{le,ve}() hook API
>>  - receive-pack: convert push-to-checkout hook to hook.h
>>  - read-cache: convert post-index-change to use hook.h
>>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>>  - git-p4: use 'git hook' to run hooks
>>  - send-email: use 'git hook run' for 'sendemail-validate'
>>  - git hook run: add an --ignore-missing flag
>>  - hooks: convert worktree 'post-checkout' hook to hook library
>>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>>  - merge: convert post-merge to use hook.h
>>  - am: convert applypatch-msg to use hook.h
>>  - rebase: convert pre-rebase to use hook.h
>>  - hook API: add a run_hooks_l() wrapper
>>  - am: convert {pre,post}-applypatch to use hook.h
>>  - gc: use hook library for pre-auto-gc hook
>>  - hook API: add a run_hooks() wrapper
>>  - hook: add 'run' subcommand
>>
>>  More "config-based hooks".
>>
>>  Will merge to 'next', with minor nits?
>>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
>
> I'd really like that, if you're OK with it.
>
> I.e. I could re-roll it, but those comments are relatively minor, and in
> any case will be addressed eventually by subsequent to-be-submitted
> parts of the hook.[ch] API conversion.
>
> So unless Emily or Glen have strong objections I think it makes sense to
> mark it for 'next'. Thanks!

No strong objections from me :) The minor comments can be cleaned up,
and some might presumably become obsolete later?
