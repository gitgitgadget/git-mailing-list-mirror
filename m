Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F11C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542532080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMu91nYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgDAL3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbgDAL3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id cf14so29162564edb.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=qMu91nYOcrHNf6yHAY5W7ykYB3SL5i/+8HgywbPZ8VVJsYfmqdL47DOhZu1ltKlRQf
         E/lIzs6m1NhXiT8OB18osR0SDtHFrak2GomClpKNJHozhMUJurCD4jKuMdf6CKARcNqf
         HrIM+JrSKMVONrC3jpBrOTMvdE97c8p6bRlGaS+r9fXlmDS7tu6RrT6LZ3T/ZCkNllrp
         KMcbDIBc124Crt1ohbOqsqZ+xqWHgTvVU9m/yyUHMFQuQ5Iw9XolTErTFOEoMCI/yxAT
         A7Mraf1xfgMHAkUehLaatV6g1VkA+DN6DhRyBnKqJR3sstGLUPTKY7aCoyLWjJLOu+ur
         j9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=oIssjxh579Urv8parUaiU1bp8CzCsLCyYJzJvHyff+Qr0OpoJ3n0yocQPCdzptgwNG
         sO9hglkVU+68mpOTXmMBDDxlsjQ/qNrZX6ZfRBsFpngjF24kr5Lo336V+Pa09Bde0npQ
         +v7B0NkyffgOaaD65NiIeLR89JHojFbo93P7mOoLzXir+qHo17OKLAJRf2UgrrLRkpxT
         RCuS5T8sIlvpVyWSi2YRtvTTekYcdze5GKsyBau96wU5sXM6DShTREephXAF9Q+snYnC
         Q7eRSDhdN9BNectmz1ZSDLL/OsK2l5AVwwlLhM6lArZYRqN5oYdua0EWLoe0hOIrXYSX
         vMKA==
X-Gm-Message-State: ANhLgQ2GE8HCPo06v+HNpfAHlGirrmDuC7RXPjZ5bT9h2GqLqJhQXpvm
        is+CaHc63lh8/DsONQLs4U1WsnIx
X-Google-Smtp-Source: ADFU+vtEDYg/4Iu3vhUVtL6GvGrgFKQuMxeuowkfdpCfFoIyrlGfgkeKvFOYtg+dFb6J2UPfXQVSYg==
X-Received: by 2002:a17:906:d8b0:: with SMTP id qc16mr8390160ejb.64.1585740541529;
        Wed, 01 Apr 2020 04:29:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm478201ejx.15.2020.04.01.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:29:01 -0700 (PDT)
Message-Id: <05634d26dd56d1435a32ef2a188210cd3cdc88cd.1585740538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:50 +0000
Subject: [PATCH v8 1/9] refs.h: clarify reflog iteration order
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
 refs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 545029c6d80..87c9ec921b9 100644
--- a/refs.h
+++ b/refs.h
@@ -444,18 +444,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/* Iterate over reflog entries. */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate in over reflog entries, oldest entry first. */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* Call a function for each reflog entry, oldest entry first. */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
-- 
gitgitgadget

