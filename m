Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF00C352A2
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1DD218AC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoUFqRCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBFW4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:56:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46670 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBFW4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 17:56:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so346095wrl.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fpn6hCrJlQcifPaFjwglcZbzUR3UF156xucJLSb/KRs=;
        b=CoUFqRCSlprPyzBPsMR16uvRxOG3D3oIgZb0OvtpvJJE7LWbY7RB6UxoolApi0teN/
         ieGBDk+DXaSa61SCMbOSGnQd5Q3x67wNyTbOJHOLTB91QGGSq5y4tbo77jmroQaUDMlZ
         7T1rNANyBiXSd0bFwDlIn9SuctABpgIvtRKGojs/p5iZD9tOPvM2TGnWgqX0bIp6qQ44
         Ak+H+kw8oN9ydCKDlj+gf2VA5JKIiOdxD7HBkJUEL2zXUoRe0prx07wjsgaB2/cgamOF
         oomNALGwOTXhrt60CHFTISpf6xux7O8s0rStW6vGaWiq78zylnsAhfSkBLImx3/LyJKR
         SfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fpn6hCrJlQcifPaFjwglcZbzUR3UF156xucJLSb/KRs=;
        b=P7HgAqXXHUqiZrHd14UBlIEFAOPtEgv3RFNDUE/04+hgoa9WOUbQ+gol8U1uOIALA5
         ug/eEJpkx7QOkBoFCkHW2MzBuyZL/vBlrJ946nYPfsj0pBm1nayOkPONxyeRQBW2fttK
         h7jG++dpBOFdNRJa4UG8FVP8EkC4Agqw3QIYSkGRA6PSEo4M5kw270GqPbV6+DkV7TNz
         GBx3fASfOs1sAfMpvPLhHMt+K+PtN74PYY+3LjhAoT+jCMqqSjChzLHp/vuuyPlN9Koj
         oqY6yq2oKEZD3+0qDTQdcDRAniTWICnzWsPpUpJQaIXW00tv5FEd9Coil9JiebzlRyOb
         zrCw==
X-Gm-Message-State: APjAAAUBHYSo1Yz44a2CvD/rmk8VtLAE5UPfz+lMjds8r2LscgYmkE0c
        fU8LEtI4MYqqkVLgorsvIjzX0e/o
X-Google-Smtp-Source: APXvYqznhfwjaGuR0/MzRYz0BE0iDGQfFFI3uc9F2gkvhSlRy9QoQ7fE64sEgyTbREns7oQbmFcxrA==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr280593wrx.403.1581029759011;
        Thu, 06 Feb 2020 14:55:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm885708wrx.94.2020.02.06.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:55:58 -0800 (PST)
Message-Id: <c00403c94dec866dd3aa3c128d866217efb767ff.1581029756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
        <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 22:55:52 +0000
Subject: [PATCH v4 1/5] refs.h: clarify reflog iteration order
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

