Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33967C2BC11
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED5F20768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YvxDGrZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgIHTuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgIHTsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3FFC061755
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z4so296007pgv.13
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ry72nq/EUH4Rk0BO36bkS99fiyeR6f5AcpPVuS3np3Y=;
        b=YvxDGrZtoHqS/H7dThzOdMHV56/v52uivwgD68R7zk8J3QZB8sIEAsOWGCwkt4dk9S
         cWH+1Ug44CVK05Hnj/8Qy8ksWQscDsck70W+tQq+R/14xrVDycVJKmTqXviL26iRKvzB
         5dVB6vBsVU9paCa5gTLMY1dBekaPkYyor+Yz5LSCwSfroAZh4ZVMeWUoLorFssmL+5ol
         jjonhNJVnbebMpk2c2C7Og3bBIHF6ZUbAPZLDnhZOEMOq8ZQcl0mvm+oKY2AUkEBxCHh
         RB96D5F/S2Z09SnJNcorl/QXtBHe2K2/vAI69uzkXHLGF7G8oJoogiAS0cCvSdm80nfO
         ueNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ry72nq/EUH4Rk0BO36bkS99fiyeR6f5AcpPVuS3np3Y=;
        b=Wq+KaqNDWnNvCehuZjTV5FIH/X9ymGEPmUEg0JHgq82DepJHOnKKaiKdjZKZIIog/z
         x2kfyNbkSLASTtWUdzieMzc212vrPJMs4g1imqNKsQksBiauZttu+u/y7bh866GDwu2n
         F5bArPSjWMtOMtakpRgNj0FNQDEpb8eam8P225anDdQUXwNTR93HO7jRveH2ZtN91jp/
         lmK2aZHUUO7lbwYYYEOtKmwqjzsTnTLzkdjRFbpkP8y1PtmjHvm7Dmi9rPFYquGXyAfG
         XXw3S4w5819c0jp/H352eSch9gmqh1sDGOfY4OWyLYBTCBreyHgJQ02+sVoiNg++/b1h
         rsHw==
X-Gm-Message-State: AOAM530WeNZOjGp5E+fEspoCBS2qTo0wcGKW35lYb+OCdkuKtW5Uxl0d
        xAYQWim6/ypcRqUbWY3+24gsu7J8m1o6LtJwNYCuCATwqrOAELtu7xPWWUefvIwYWdYvHHHCVQW
        PbQDBUZ2Tttz4fLEWFsVQU4JcgBd5h3OIgcHoTF5+VbvakyjAQhDAf+IqDY0R3g6eZTAyDvfqTq
        1d
X-Google-Smtp-Source: ABdhPJw/Q3SapVnD/nhuRx0iOnYtid99Qu3gnCSZ7d+fN90f+U7WRbfnDvRns3XaqRTZh6bG5jUR32A9KDNl+QEA8wRT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8817:: with SMTP id
 s23mr401585pjn.158.1599594522255; Tue, 08 Sep 2020 12:48:42 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:28 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <cover.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 0/7] Better threaded delta resolution in index-pack
 (another try)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From What's Cooking [1]:

> * jt/threaded-index-pack (2020-08-27) 9 commits
>  - builtin/index-pack.c: fix some sparse warnings
>  - fixup! index-pack: make quantum of work smaller
>  - index-pack: make quantum of work smaller
>  - index-pack: make resolve_delta() assume base data
>  - index-pack: calculate {ref,ofs}_{first,last} early
>  - index-pack: remove redundant child field
>  - index-pack: unify threaded and unthreaded code
>  - index-pack: remove redundant parameter
>  - Documentation: deltaBaseCacheLimit is per-thread
> 
>  "git index-pack" learned to resolve deltified objects with greater
>  parallelism.
> 
>  Expecting the final reroll.
>  cf. https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-08-31#l82

Here's the reroll.

[1] https://lore.kernel.org/git/xmqqk0xa8rvn.fsf@gitster.c.googlers.com/

Jonathan Tan (7):
  Documentation: deltaBaseCacheLimit is per-thread
  index-pack: remove redundant parameter
  index-pack: unify threaded and unthreaded code
  index-pack: remove redundant child field
  index-pack: calculate {ref,ofs}_{first,last} early
  index-pack: make resolve_delta() assume base data
  index-pack: make quantum of work smaller

 Documentation/config/core.txt |   2 +-
 builtin/index-pack.c          | 456 +++++++++++++++++++---------------
 2 files changed, 251 insertions(+), 207 deletions(-)

-- 
2.28.0.526.ge36021eeef-goog

