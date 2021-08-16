Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09BDC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C335460F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 14:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhHPOd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhHPOd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 10:33:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269B3C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 07:32:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x7so27522948ljn.10
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud9L98uopeXmITveoPDd3hIZZ4u4aXGFVOcbCOqv8hw=;
        b=htK8pLdInEdOV2l27+5A8jkh9+hnvypQjjn7xh6zwc4Gi39IdvRMimhlyRA2fjqozc
         nU2UznMryF3s8c4cHti5NPPsYjjw304zzLsmdeqNVgadnJN4rkDAZdEupBkmj0+jiJVM
         sau7O0pBdTviWnw6X20lTq76kbUaVHhQcWW+fL1yXbeBK4AV4Xm7ASx7G1nQxZSxFo7e
         UryYDsDi8BsTZ6/NXLr2scq1pevPZnocG4/S7i7RBCjUHcFej6Sd6vmmnZmOYRDU7My9
         /zruZllTq/6aut1JJi3rnipwfjGUiVYCTy6NWgHyYLsW8QuN49Kj0CtSgPM5yVlaFoCu
         avhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud9L98uopeXmITveoPDd3hIZZ4u4aXGFVOcbCOqv8hw=;
        b=E31xf7vO+46+ogI9V1pt/iCWtt5MLcEv4OoQXPpD2aGbDMdaKilgby3NRPZQiqh2iB
         ymmXvV/wIQcJ/ZJfom4R38qyQux8MsngRjaG/bP+p7HLz7BRLlIreuLLJf3Tj8nTFtNl
         unF9ofcA1A2U3ELmo6l+E1H+sd84GJ2M7GyY0DfPmWT0X2ObJ2gYzL2Qcn0ecyQF35TE
         P1tyqJNuAtUfBHjWOpmJsT4F6a4Oqj6K5gzDfH4eBf9LFQTA6DhzZEQGaqYrk0ZpnduK
         QzZCHOwxD+cMkMs7cY3uBdnprP3C7XOfizHPPs8CPnlvKEln8AXGTzHQc748lFu3/AbN
         rqpg==
X-Gm-Message-State: AOAM531bBFAffuZIe981r7B8qQ35Ir0lf5Gt4xXNfPzNVeqQjH0ECtB3
        EUPVqg5+O52Ep0DJJt/uL5y/Kx688fclQuemJUMbRg==
X-Google-Smtp-Source: ABdhPJyvw5EDNBBqFMk9IKpTbXzREVjMH2GgCWxDi796Bj1a4gjW9KAR7eWf0u5Kedt0YWoHh62MZlnsWgiJJlbQWOE=
X-Received: by 2002:a2e:b894:: with SMTP id r20mr2667912ljp.291.1629124374443;
 Mon, 16 Aug 2021 07:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1628888668.git.jonathantanmy@google.com> <94db10a4e5943d689113693c64633ddffa5508cc.1628888668.git.jonathantanmy@google.com>
In-Reply-To: <94db10a4e5943d689113693c64633ddffa5508cc.1628888668.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Aug 2021 11:32:43 -0300
Message-ID: <CAHd-oW7nv-Y_QmhA2gcX5GoWxus88inmbcXQ5kPiSRLBdhtoUw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When reading the config of a submodule, if reading from a blob, read
> using an explicitly specified repository instead of by adding the
> submodule's ODB as an alternate and then reading an object from
> the_repository.

Great!

At first, I thought this would also allow us to remove another
NEEDSWORK comment in grep_submodule(), together with a lock
protection:

/*
 * NEEDSWORK: repo_read_gitmodules() might call
 * add_to_alternates_memory() via config_from_gitmodules(). This
 * operation causes a race condition with concurrent object readings
 * performed by the worker threads. That's why we need obj_read_lock()
 * here. It should be removed once it's no longer necessary to add the
 * subrepo's odbs to the in-memory alternates list.
 */
obj_read_lock();
repo_read_gitmodules(subrepo, 0);

Back when I wrote this comment, my conclusion was that the alternates
mechanics were the only thread-unsafe object-reading operations in
repo_read_gitmodules()'s call chains. So once the add-to-alternates
mechanics were gone, we could also remove the lock.

But with further inspection now, I see that this is not really the
case. For example, we have a few global variables in packfile.c
collecting some statistics (pack_mmap_calls, pack_open_windows, etc.)
which are updated on obj readings from both the_repository *and*
submodules. So I no longer think its safe to remove the
obj_read_lock() protection here, as the NEEDSWORK comment suggests,
even if we are not using the alternates list anymore.

Do you want to remove this comment in your patchset? I can also send a
follow-up patch explaining this situation and removing the comment
(but not the locking), if you prefer.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
[...]
> diff --git a/submodule-config.c b/submodule-config.c
> index 2026120fb3..f95344028b 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -649,9 +649,10 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
>                         config_source.file = file;
>                 } else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
>                            repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
> +                       config_source.repo = repo;
>                         config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
>                         if (repo != the_repository)
> -                               add_to_alternates_memory(repo->objects->odb->path);
> +                               add_submodule_odb_by_path(repo->objects->odb->path);

Ok. Like in grep_submodule(), this should no longer add the submodule
ODB to the alternates list, so this call is now mostly used as a
fallback and also for testing.

To see if we are indeed testing this add-to-alternates case, I
reverted the change that made the code read from the submodule instead
of the_repository:

diff --git a/config.c b/config.c
index a85c12e6cc..cd37a9dcd9 100644
--- a/config.c
+++ b/config.c
@@ -1805,7 +1805,7 @@ int git_config_from_blob_oid(config_fn_t fn,
        unsigned long size;
        int ret;

-       buf = repo_read_object_file(repo, oid, &type, &size);
+       buf = read_object_file(oid, &type, &size);

Then, I ran t7814-grep-recurse-submodules.sh , where you've added the
GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1 envvar. This correctly
produced the following error:

BUG: submodule.c:205: register_all_submodule_odb_as_alternates() called
[...]
not ok 23 - grep --recurse-submodules with submodules without
.gitmodules in the working tree

Nice! So the change made by this patch is covered by test 23. I think
it would be nice to mention that in this patch's message.
