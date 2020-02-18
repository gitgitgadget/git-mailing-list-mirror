Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E501C34035
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A0220658
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjESk/I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBRInq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:43:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37881 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgBRInq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 03:43:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so1896235wme.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 00:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HT7tmc540gseKiwvUt6jUrTaTUao9bFKkYBl/VlqWhE=;
        b=PjESk/I6fhRbrer5oVn9isXmI3Q1tTM7opI7FGBv1RE4BQdikSQtsrYC7Cfu8qQC0d
         4OyWniII6BBL7CmO5gKdDdUqYLpPDuyhGtLcy7zYfpFBGco58hFXc5nT3Jb8i0WU3UI6
         vM6HkUR/APItCNXir8qYJCeOwgVUuRzmfaE1H0/NsWMpn2inZoZ8EJGVtuyYCekGuSkf
         etTYFxwIpWBgJdo+0yaNZl5uob79xB9FaXxXRKyH7GGIs0/i3e3XuCsorbUQBAzjYeXJ
         gqh+tjGo9oyCaV+a+N+AeJ50lQlU2Tu8Q1Ihzdt5H/qlHCY9Rb2qp87ZmZqBWdGqSNrt
         ZExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HT7tmc540gseKiwvUt6jUrTaTUao9bFKkYBl/VlqWhE=;
        b=p7ej1DdcfT3HSoQ5K8q4hcQt1C/DlwfE/Oulj7HWIya5OGt978hE+RVyZsaZ4Hyvf+
         2vOOplZ9jfUA7gL+G2gPj8DNeDI5bx81QkW1O8tFea14cnL8eMr4GdLA/V4HAy7N+akY
         1Y67YP4e2vWUlj4aeeGGHwC60MGF7ljyBxTLbTRHS+Z2yohS6tHrtu6GNVnZlozHGrLv
         tlbNGJtPtltppsH6NayhFP9H9UjvTmqyyk6ln3p3Hv/cPSL6Z7buJfIP8yYpUBmJIjjY
         1cwdgdzEujYPVj4FOciwIL1uSYX+Mpv7llgFJBJ/dVLbxkL7ChwYjLmBHUmRk7x90LrM
         DU0Q==
X-Gm-Message-State: APjAAAWDkCUiVQbjhz8e1k6c9+g7uCIflgff6oGeFSovznzydyGxP5em
        FnvOic+3WynOg57mlizp28VsNt/i
X-Google-Smtp-Source: APXvYqzxQz7fVcPeWDlpiJR9tfw/4KxkwpJLmw25CUt/dZtIOhsZqJu8mCmAeAD+Q7fEb6Q2nJVVFw==
X-Received: by 2002:a1c:6246:: with SMTP id w67mr1734025wmb.141.1582015424203;
        Tue, 18 Feb 2020 00:43:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm5032610wrq.67.2020.02.18.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:43:43 -0800 (PST)
Message-Id: <e132e0f4e006926cd2fe61713a1e482080712cbc.1582015420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 08:43:38 +0000
Subject: [PATCH v6 3/5] refs: document how ref_iterator_advance_fn should
 handle symrefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb7..1d7a4852209 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also dereference
+ * the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

