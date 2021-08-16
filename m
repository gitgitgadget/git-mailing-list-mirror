Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C0C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FA66023B
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhHPUDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhHPUC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:02:59 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8233C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:02:27 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id o3-20020a170902778300b0012d888ce2efso7942022pll.10
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LrN56TAGbahG61/kq/4HRkCYTjpixPrFjsR/XxPhNQQ=;
        b=JZY+azBSdFsolI9z+UHZS75xxKYAvtR/4NixbRlWQIijyAcHYK/55S7LrJEl/P6phg
         mTK1oFDQ6u9HTfxp9Ruc09HhzADWcemyr8rcO+uENxpW9mUOrgKVQIfMljYm+gRDngN3
         4/jgzob7DzsZ+bevKAU8xE+WE+3O+GJRWFIgewVSVJSF8SzPWULLFQL1B2TomsIA52ln
         Zt0nWNeIpEMSdEDE61xHBu97CPC2JAjIUTQHDXp0oONimQc8TxIihwccynfMQL5kqFXt
         hu9tOUfMZufLjh3odBhlWF2vk69fJUv/I5sNB0rWBWV3H6CcQDyy8mtQ7TKaUM0JNivS
         3ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LrN56TAGbahG61/kq/4HRkCYTjpixPrFjsR/XxPhNQQ=;
        b=En3DgXM5ez3Jj/kXJWAXzKuonu8ddnLo9D9N5rKgcUMv2VDifd0RVcS27LkOqjQeuo
         V+po3uJ8wQyJ3cy2An+52DDstVDuMax96Pk96lO8w8zcVEWZieVvUpI0D/qeoZAsdF71
         cQBwccoZeGlNzxG0ksKuEycPdTc2pUiO6BmSQSn8PQZC/bLKvbgcAZZDm3GXN0TUD9G+
         ic4qKlcXnhcOG7fbiRTRpzx6TqFdNdrulEpiA47ECkpjJE9QxMYlzEJPCTrIFL0HsxdD
         YTSMeE3ziKCRAjqrrVRJObckwY5zOP0wUsobfymB1LLkfot5L8Zv4UjHPH2KuXkrTDSn
         ymXw==
X-Gm-Message-State: AOAM531jsVNr997qEf7zNKmRBLYbk0N4pNPUHP9qZS75cX/aOSzu3AP/
        AwgnP1UcCLGihas39uVYup2Rnla9IQ3pRRVIexIw
X-Google-Smtp-Source: ABdhPJwJ4zHGXwTRRSqX4ROZ4dIZYMWKfWKTUFwmb541a3gPZRf4wfNkTyjGJ2FAlvTMpFTJBWxZ8Z/4e6rqMDnH/OLO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f242:b029:12d:1fbb:aa12 with
 SMTP id j2-20020a170902f242b029012d1fbbaa12mr411632plc.3.1629144147354; Mon,
 16 Aug 2021 13:02:27 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:02:25 -0700
In-Reply-To: <CAHd-oW7nv-Y_QmhA2gcX5GoWxus88inmbcXQ5kPiSRLBdhtoUw@mail.gmail.com>
Message-Id: <20210816200225.1637935-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAHd-oW7nv-Y_QmhA2gcX5GoWxus88inmbcXQ5kPiSRLBdhtoUw@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matheus.bernardino@usp.br
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> /*
>  * NEEDSWORK: repo_read_gitmodules() might call
>  * add_to_alternates_memory() via config_from_gitmodules(). This
>  * operation causes a race condition with concurrent object readings
>  * performed by the worker threads. That's why we need obj_read_lock()
>  * here. It should be removed once it's no longer necessary to add the
>  * subrepo's odbs to the in-memory alternates list.
>  */
> obj_read_lock();
> repo_read_gitmodules(subrepo, 0);
> 
> Back when I wrote this comment, my conclusion was that the alternates
> mechanics were the only thread-unsafe object-reading operations in
> repo_read_gitmodules()'s call chains. So once the add-to-alternates
> mechanics were gone, we could also remove the lock.
> 
> But with further inspection now, I see that this is not really the
> case. For example, we have a few global variables in packfile.c
> collecting some statistics (pack_mmap_calls, pack_open_windows, etc.)
> which are updated on obj readings from both the_repository *and*
> submodules. So I no longer think its safe to remove the
> obj_read_lock() protection here, as the NEEDSWORK comment suggests,
> even if we are not using the alternates list anymore.
> 
> Do you want to remove this comment in your patchset? I can also send a
> follow-up patch explaining this situation and removing the comment
> (but not the locking), if you prefer.

I think you can make the patch yourself - the comment change you
describe seems unrelated to this patch set.

> Ok. Like in grep_submodule(), this should no longer add the submodule
> ODB to the alternates list, so this call is now mostly used as a
> fallback and also for testing.
> 
> To see if we are indeed testing this add-to-alternates case, I
> reverted the change that made the code read from the submodule instead
> of the_repository:
> 
> diff --git a/config.c b/config.c
> index a85c12e6cc..cd37a9dcd9 100644
> --- a/config.c
> +++ b/config.c
> @@ -1805,7 +1805,7 @@ int git_config_from_blob_oid(config_fn_t fn,
>         unsigned long size;
>         int ret;
> 
> -       buf = repo_read_object_file(repo, oid, &type, &size);
> +       buf = read_object_file(oid, &type, &size);
> 
> Then, I ran t7814-grep-recurse-submodules.sh , where you've added the
> GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1 envvar. This correctly
> produced the following error:
> 
> BUG: submodule.c:205: register_all_submodule_odb_as_alternates() called
> [...]
> not ok 23 - grep --recurse-submodules with submodules without
> .gitmodules in the working tree
> 
> Nice! So the change made by this patch is covered by test 23. I think
> it would be nice to mention that in this patch's message.

Thanks for checking this. I'll mention this in the commit message.
