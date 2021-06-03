Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEE6C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EF5613E6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCCfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:35:51 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50077 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:35:51 -0400
Received: by mail-qk1-f202.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso3186847qka.16
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sexLMqYaeDA7TbP7Cs6qXd9GtG/InPgcUdENPCrg4cI=;
        b=Y59vqEmHyouQI9+PPZiXtWnHv5Vyt+lPV6f8Y5CoHRh76pO03vBtf93wTVnFazz9nb
         3709cq2TTJ5UnCCxg00TH1CPmTYa+JomuC3RQxBfOPioEzMoJEOPLoJS2Hoe2Uo7bg/o
         B5XdNeSXyRmsW84EAyNc0RXXbovZCANP3C3zBZzAiTSPCiczXri1UOhNqnRNbhm0VIVJ
         SEQpO07DArJWYJO0TamoGZvWCvJbS0qLdFUykGqWYfQy8q+gMTa3iLP/HBDkWuJELNsz
         X1qhImqV9ewAWOMAHmK6v9TsYGulb+m8BAwfN2XgaAufK8PI6YUsEDs/uOYaA3tWAQYL
         G/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sexLMqYaeDA7TbP7Cs6qXd9GtG/InPgcUdENPCrg4cI=;
        b=JG+6UZ0ZczU7o4m4u3Is65zgMU55KBo64223bhEaZpsNaA0VYodsdwBui9AB2m6joO
         qLZGugIoM+cZeR0doCHec0GKQ3XyThq3bt6PXESGiiGsT7MDGBVFI1zc91eTxazqGtZY
         F8ywb4Ib7OD7v737+oRn3e7mlJXOyTZT/HlUiME7YePZ+HTTOv72rMTEPXFi1T/rrmM4
         HToBY28mTDMlUdD4KKnMmuvu/PRCubDGa1YcUia6hxIeui1OrqUpJGfdYQcu1vN3Gt+H
         yL1xS9XRt0A4AIFdrKzXn6qAXOZSU2Lvb5M6AGy3ms//aFYbtkx9gZmsBRLrLbGjTJz+
         naQA==
X-Gm-Message-State: AOAM530BlKNgZl0T7IaQEtevsCDoZ0eVIN7XPfgwBO8t4Lntlx9+FK3f
        CvCY0WfmGJhHP4QzbZyxnx8i/k5Bjs/++EbpS3hT
X-Google-Smtp-Source: ABdhPJw/hinp+m0NrTCZkeZQYIWPSdEGAXsS35xiU0l736egGf9HZ3YalwEvpDes6J7nqJP75FkL+B4jH/dMj0ZZWWUm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4dcb:: with SMTP id
 cw11mr6207109qvb.54.1622687586866; Wed, 02 Jun 2021 19:33:06 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:33:04 -0700
In-Reply-To: <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
Message-Id: <20210603023304.344682-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 2/8] refs/files-backend: stop setting errno from lock_ref_oid_basic
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Errno is a global variable written by almost all system calls, and therefore it
> is hard to reason about its state. It's also useless for user-visible errors, as
> it leaves no place to report the offending file and/or syscall.

I don't think this paragraph is useful.

> For the copy/rename support, calls to lock_ref_oid_basic() in this file are
> followed by:
> 
> * lock_ref_oid_basic (copy/rename rollback error path)
> 
> * write_ref_to_lockfile (both in the rollback path and the success path of
>   copy/rename)
> 
> These calls do not inspect the incoming errno. As they perform I/O, they can
> clobber errno. For this reason, callers cannot reliably observe the errno that
> lock_ref_oid_basic() generated, so it is unsound for programmatic use.
> 
> For files_create_symref() and files_reflog_expire(), grepping over callers
> showed no callers inspecting errno.

This is probably written more clearly as follows:

 No call to the static function lock_ref_oid_basic() is immediately
 followed by an errno check, so stopping setting errno is safe. But as a
 sanity check, lock_ref_oid_basic() is used in these functions:
 - files_copy_or_rename_ref() - here, calls are followed by error() (which
   performs I/O) or write_ref_to_lockfile() (which calls parse_object() which
   may perform I/O)
 - files_create_symref() - here, calls are followed by error() or
   create_symref_locked() (which performs I/O and does not inspect
   errno)
 - files_reflog_expire() - here, calls are followed by error() or
   refs_reflog_exists() (which calls a function in a vtable that is not
   documented to use and/or preserve errno)

 So it is safe to stop setting errno in lock_ref_oid_basic().

The diff itself looks good.
