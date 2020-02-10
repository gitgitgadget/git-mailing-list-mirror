Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6989FC352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3AB20714
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qugttrnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgBJOOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:14:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBJOOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:14:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so495527wmb.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fpn6hCrJlQcifPaFjwglcZbzUR3UF156xucJLSb/KRs=;
        b=qugttrnEvlaIj8JFPM1ACtgvoYf4OZLtaUwNRtDtlP+ZRBIqoXpacD2SsCA4QJhy9G
         OetyDr54ja1+AvUC4d0G7nR1abKgiHTlswcfYu82nRiVmoayFkoRoUPayt3ss1SqNZ3L
         lvy7moK3VEngtUeCY+XqSJajAyB9hUaFAdWou+C2e3hgavvuZRI6/Ppong0n+ohvJnaH
         3QXOUkWL9PmFRLSX97ISUQIIRhWBDDyaEiL+REECRokiFqVC6tdmIxEXOOp7XUJ1FUt1
         O5NSAdCNEQhKl1qvlhQ/arnVxciNpAN0CesgmxmAQ9mQ0y/uqZLQDQHrGtAOHk6q5+5v
         B2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fpn6hCrJlQcifPaFjwglcZbzUR3UF156xucJLSb/KRs=;
        b=fSs1rgN4IucSHP6UT1rSDUl5SHqarZv0JKCKf/LYawoejzDhbTTxHL3NR7xblFtPMg
         aRU2n8gQ578YNY9Z8vCLGmUGhybjiTgLKqi6YBl/RbT4Hh7VIOLUXsecv8Fnq2Gllo7a
         +tKMgYAyOHdt7ElGCNpCdI6/QhzX4mNBj+cdUYuHkoE/vNFnyMvjtt53BrEMNwBS6/Gg
         YpxCmgbl7urV/dcTGPBSE7eM8U1moPts6QHMv5J6PuIF3TGGj6srqkVoODVNav8k7C1Q
         VODkRkVNkhJ1OLe8XpkEkKq/voE6FdMoTPU2SlxPzVmyYcexHEZa+TSq1pDemzfpUbhf
         YNTg==
X-Gm-Message-State: APjAAAVrDtyIxt5NSJxO3UfEf42joIY9njNLOwVUYxFMQirNr8hJao6+
        RbEoNnLJdbgJW+AGfr2CEzKgYiy7
X-Google-Smtp-Source: APXvYqyY00zvtUj0e3vPFjEU3lXSR4z5gZqcUedLenT80vWNj+4Q/Y9Hj/Lc3qbNA/cE/me2pOdB2A==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr16273839wma.171.1581344062418;
        Mon, 10 Feb 2020 06:14:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm756750wmi.0.2020.02.10.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:14:21 -0800 (PST)
Message-Id: <c00403c94dec866dd3aa3c128d866217efb767ff.1581344060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
References: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
        <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:14:16 +0000
Subject: [PATCH v5 1/5] refs.h: clarify reflog iteration order
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
index 545029c6d8..87c9ec921b 100644
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

