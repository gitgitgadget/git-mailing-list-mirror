Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EAEC33CAF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2350921D7E
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQZVXqNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAWTlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:41:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33323 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWTlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:41:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so4524317wrq.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YFhfrmiz1MnC+KIqE9EAXW0EFA0b04wlw/SNyc4qGWA=;
        b=AQZVXqNZGK8MeUYWE6l7+54a8wV9gZLsOxBL5i6Kl8/4dRp5DunCf8u1kZN/UOSlgC
         t1nH5n6SyObTiHRCwt0xEg3/K6xauhyJbpbHgKic+zt8+jEZafe/P12bLWUgnM47LBLA
         nZpEWQ0VrT2H5aubWRznS3TmsRPI7wn1ifNe88dkutK+6uPcHub2QzWAsAO/Lgwukw3b
         bJF2BJnpGuWicwJryKE15kWpqxeIO5+rB8vqoq0a6ej8SCO69NS2gWMHKLnTeBUsSrzp
         yZCu5zr3TlOG7J+ca8UqMXt8ilKcwHfpOb2KMrl0eu7yj97N6W0b008EyhDqfGw25xbp
         x16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YFhfrmiz1MnC+KIqE9EAXW0EFA0b04wlw/SNyc4qGWA=;
        b=tMV/rRK82jAQJujCtYZuvROLQ2p6EOQCqfNtbM70WYuj67/Vgok3krzb377b64j5Jz
         i3+XljrlJUdyD9QlIwk0pQ25WF4RQEY63eAAnqx80ljvxgLEPQ6whMOOJ/Hpe8YDGX0T
         GnuwoXGo+ekENWhk95y1XGcediNLbXoorHXbc8llk6k8vtNpNIP+NwFiWAq1Nufs2tT3
         KmZxMz4SJbaRancCyis+QlPPznFKBoOlEVtuOupMRzUbB6hmfGMYgpdYUw4DjApJrXQ7
         OjcuXKv+T8tQS6ONkxnJnp3KSLtJ8JIvpYT5pQOZAFzmDK5+cEsj6zrN6JyghFWRsoYm
         C0uA==
X-Gm-Message-State: APjAAAVMpBFKFk2107wVDB/50oLreMj9Tg4RKBdUNpSaRywV1VyxB+2H
        ueagy3A1MMj+CP1AhUmb3Lg8LOvL
X-Google-Smtp-Source: APXvYqw6GoPR/cXFW5zlNpSDRzEL+RbSEroru+zW/H7hbdtZsCO0ulORUAVK36XdKOiqasOyjalPHA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr20340940wrc.175.1579808482912;
        Thu, 23 Jan 2020 11:41:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm3949488wmb.1.2020.01.23.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:41:22 -0800 (PST)
Message-Id: <1a01e0b1b5057fb34e4d8ca78d906925ee9141b5.1579808479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.git.1579808479.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 19:41:17 +0000
Subject: [PATCH 3/5] Document how ref iterators and symrefs interact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@xs4all.nl>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Change-Id: Ie3ee63c52254c000ef712986246ca28f312b4301
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb..fc18b12340 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -269,6 +269,9 @@ int refs_rename_ref_available(struct ref_store *refs,
  * to the next entry, ref_iterator_advance() aborts the iteration,
  * frees the ref_iterator, and returns ITER_ERROR.
  *
+ * Ref iterators cannot return symref targets, so symbolic refs must be
+ * dereferenced during the iteration.
+ *
  * The reference currently being looked at can be peeled by calling
  * ref_iterator_peel(). This function is often faster than peel_ref(),
  * so it should be preferred when iterating over references.
-- 
gitgitgadget

