Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13EC4BA0A
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38D6206E6
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHuhrmTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBZItv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:49:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37847 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgBZItv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 03:49:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so2799776edr.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=QHuhrmTFrQ884Sw/bdjOL8YJLE7cKCyRDpueat0kw29RPoPRskGC8ZVDOnRCMNBn89
         kfl2hNbIHMDF9m/Zg46ILlV4Y5CfExJtMAfhJSkKDBubXH2S4zDlTOFYbpSSy/vcKe4U
         m+HakXKnzPpXLKcW1dHOMAOeKnK02EZysoG5ebh+uZzvzIFW64hqxOk7NHilfXphMTA9
         oR2o5wsOkZzKtP5Q2KIg3Ed+ipEmIW0qdLSFblxsMv6iv1bL7jK2VtG1BwncyE7Yy2TI
         dTQ0VgHRu9qE9fIsScMqbL16z/yh7SBw9Ba3Wj5IrmeZHzQOiDn0KDaIvaFCISYOG05H
         8hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=X0Tilm0sLRB61rQGS7lK3Sh8nSzMMxGomO6cjkTbC6qv59ZavO3HmlpH0uLLwfMmD2
         ooXz8Jgl0ALuDWEKfhlICfEEOrF4HOvRaE0wAaJHmv4agdaAnrbapIdtnOAqGKwv+3WK
         weubiiNMw1RU+Zyy8pXkDf7HgRxONQ8PzRfxKgdi1srlGFinax9aOCb8p1dAPzRLJNgk
         9I/1gLE565ienGpt5eWHmbeTnnkCtCVfPIxp44HFpNzrj6zG1WvGkmfpfGjS8ZIAtxQF
         yYass/SI13sJdgVB8fHwBe72uVg0lagL6rphqV15aIh7S0SvNH0Fk87U6rD6FdcBMxlo
         c0Iw==
X-Gm-Message-State: APjAAAUr7QVv8gWPci0VWUVoDjvGH8K+ND20sQHuIKQBsnDyFUnNfZy5
        g8Rg0Pa9cUxXP038jcW3/OnZ0rVK
X-Google-Smtp-Source: APXvYqxG7w944afpLosWVcOiU0ZagHijS5P/zAGThBDJnRfaYafTAEkBfymOwCERmJpfjtc19xQA1A==
X-Received: by 2002:aa7:c68f:: with SMTP id n15mr3574720edq.112.1582706989282;
        Wed, 26 Feb 2020 00:49:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be18sm57012edb.19.2020.02.26.00.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:49:48 -0800 (PST)
Message-Id: <b1e44bc431e93f201dd2071f8acfc8ca8c77a271.1582706986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 08:49:41 +0000
Subject: [PATCH v7 1/6] refs.h: clarify reflog iteration order
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

