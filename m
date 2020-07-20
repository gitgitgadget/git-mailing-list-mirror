Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B95C433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2492520709
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfDyrVsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgGTRy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgGTRy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:54:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B2C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 10:54:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z8so289151pje.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bs82D9NW4hogpe1ZxqFjHtiRXtg+BTmmfUoA821p770=;
        b=VfDyrVsFBDTrSFZpMl9aYshfN19sJ4H4oeUKuLegystBK8QTWtb8lamhrV0twX+St5
         75bbYkYAsTmaRdWvEP1FcAMhTu9bSBy1euDFOblDZIAvKlItDmSQNcdguzgHyUSekGKh
         l53oy/2woT7dN+K6BphsjqA0k08Eh0QSeHyOj9a5GusiXAZIj6WxKg4qlJ00Massn65N
         dH8638lMbJSK9hz9VVRXjYF1sWrMcwKhLxSJfphzaDl5XbWpJPs4nb/poPAOdFirkep3
         RKLScTwDcno8oO5IlmnJAgatp7RiMQApisKdYmcSy6Kvj+2xubDkAvmWpXxH3cd8cr6S
         rlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bs82D9NW4hogpe1ZxqFjHtiRXtg+BTmmfUoA821p770=;
        b=Qv2LAGKMH2IXyC38SYojrrqOTioPHNEYkMpinIc+3WHozKbu0zPCo/DERbvpR2hCSe
         8N43sKUNPfOZ3eUswgbiQEzCMe/F3Qg5iaczKpGE0g8bAF/V/r4VZ5SUDl7XB1C6faUo
         ShrgexcGyO1tluhMu5WbNvz5vt0Vg1LI69O+ZxX4tlxJfDWN8tlTj1UgQYtX7EfaSTQ+
         N+x8+Ov13qZH9qpXFR/6aGhJl8l0gN9YQvrJuaorVkyS3mPOIeAaHlEvjCQExTTdpjEI
         JjElAieQlpJlToVnSIN3PlMuPcG53UrhKjWL/hKcA4Lf39teQD2d3+TKspxvTu6qbwZM
         /Cow==
X-Gm-Message-State: AOAM533j0lttVq4uj7VgytYdyOPjiUi4UVIdwPrS1dJHqzgLMrz1qNbL
        /ygK4JhtmikiLL4C4WQqJdZ3pCXnCvOHvWraKcvr
X-Google-Smtp-Source: ABdhPJyBmaaevJiBrEKCLR0pFWcMvjAdPpwha4JwI1SGKa3Ah//hkCO2dra+MHfE9ir8MFLqVT2YIDI2rX4RiaIKjWPt
X-Received: by 2002:a65:6416:: with SMTP id a22mr18847774pgv.392.1595267695289;
 Mon, 20 Jul 2020 10:54:55 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:54:49 -0700
In-Reply-To: <439C1CC1-50BB-4EA1-A8F0-04D66CA430AE@gmail.com>
Message-Id: <20200720175449.1727314-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <439C1CC1-50BB-4EA1-A8F0-04D66CA430AE@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: Re: Pushing tag from a partial clone
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sluongng@gmail.com
Cc:     stolee@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I just freshly compiled from 'next' branch:
> 
> 	> git version
> 	git version 2.28.0.rc1.139.gd6b33fda9d
> 
> And the problem still occurring:
> 	> mkdir scalar
> 	> cd scalar
> 	> git init
> 	Initialized empty Git repository in /Users/sluongngoc/work/booking/core/scalar/.git/
> 	# use my own fork here so that i have push permission
> 	> git remote add origin git@github.com:sluongng/scalar.git
> 	> git sparse-checkout init --cone
> 	> git fetch --filter=tree:0 --no-tags --prune origin 4ba6c1c090e6e5a413e3ac2fc094205bd78f761e
> 	remote: Enumerating objects: 2553, done.
> 	remote: Total 2553 (delta 0), reused 0 (delta 0), pack-reused 2553
> 	Receiving objects: 100% (2553/2553), 957.85 KiB | 1.06 MiB/s, done.
> 	Resolving deltas: 100% (74/74), done.
> 	From github.com:sluongng/scalar
> 	 * branch            4ba6c1c090e6e5a413e3ac2fc094205bd78f761e -> FETCH_HEAD
> 	> git tag -a test-tag -m 'test tag message' 4ba6c1c090e6e5a413e3ac2fc094205bd78f761e
> 	> git push origin refs/tags/test-tag:refs/tags/test-tag
> 	...<download start>

Thanks for the reproduction steps. Is 4ba6c1c advertised as a ref by the
remote? If not, what is probably happening is that the client doesn't
realize that the server already has 4ba6c1c, so the client needs to
fetch 4ba6c1c's objects to send it to the server.

I am planning to see if I can add batch prefetching to pack-objects to
reduce the severity of similar situations (just one batch prefetch instead
of many one-by-one fetches), although that would work better with a blob
filter instead of a tree filter.
