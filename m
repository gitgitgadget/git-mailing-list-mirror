Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01581F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeAEUVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:21:31 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34313 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeAEUV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:21:26 -0500
Received: by mail-it0-f67.google.com with SMTP id m11so5531415iti.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r4MeYFmUWCsqzoE2grVVb7i8+KNONv9V/wqBWU4DGyw=;
        b=qVN8XgsqknyYgPJaIyd4SSLwR4brXtY46YKvGbL/o9g5y2CSamu+M34ojRTkFZ4Sz6
         gv4jQEyG0OQE7dL25/Du6A0/3mxkfXB2HG01U/wbdA71zBYVLv7Dc91PJ5YPkMJf/asU
         rRmowrqT0Hw9ZjFmOUOMcbJNOZg6zIiYu5zf17S6IA8eugFkCc3/CgrOqaeFY2kFPeU4
         LKCHPVZfin8iV9ZOZ3BEgoYxijqTDST7w0DpkvV6ckYLDPspXa0UktYQhTN35z70DVlS
         Utu1tDFfrut8JlAStuw5XEhBHG3pB2utk647v9f7qMBwk4OTr98cdbDloEg28hdOjt3f
         BDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r4MeYFmUWCsqzoE2grVVb7i8+KNONv9V/wqBWU4DGyw=;
        b=YPfDV0QG/X5WlShCVnzpupnLQbUvAlBhoFbVoEPttsSlEoDzYlHnC1p9x7WeSdpNH2
         rInM7ki00yh5RcPiDoHPJY2P6gkuJ2zp2J69cTOTIqlyqeFeZngAwdjONcQc1sPtXr8I
         My8Li2RRMV2ZIq3xr/MPR8ib8wsYPqENeRxA9ok7CKFGDaoptvdOOjj1LWgkZ/f8AMip
         LKHPCvpBVALs+6m2J5v1YETqVZFulZYRk8No7S7+HKLZDZJBYSmF4u67kryCi1sMz5rF
         NiJc0stU/Wf/bg/mJf1txjKOIKDKhrlUXRgn4jSwDuhEsnPLDRsagaCPu/g16Dxon56V
         PagQ==
X-Gm-Message-State: AKGB3mL6CJQiDcMM69puKvmfp/vSA+wE2q57sAp0lxIEI3dWWdYYoehs
        oYl7KHMCwBn7xc+JAUIgRyo=
X-Google-Smtp-Source: ACJfBovze8Z7dKi64E4yIMRHvSSFVL+TYbhEogKCEes0LXUlAZdig0QQzjQhqpetfVMyYWHnYQSF5g==
X-Received: by 10.36.245.72 with SMTP id k69mr4315641ith.45.1515183685483;
        Fri, 05 Jan 2018 12:21:25 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id p68sm3876894itc.26.2018.01.05.12.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:21:25 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] merge-recursive: add explanation for src_entry and dst_entry
Date:   Fri,  5 Jan 2018 12:20:01 -0800
Message-Id: <20180105202001.24218-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202001.24218-1-newren@gmail.com>
References: <20180105202001.24218-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I have to walk through the debugger and inspect the values found in
here in order to figure out their meaning, despite having known these
things inside and out some years back, then they probably need a comment
for the casual reader to explain their purpose.

Reviewed-By: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 98c84e73d..d78853d5e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -513,6 +513,25 @@ static void record_df_conflict_files(struct merge_options *o,
 
 struct rename {
 	struct diff_filepair *pair;
+	/*
+	 * Purpose of src_entry and dst_entry:
+	 *
+	 * If 'before' is renamed to 'after' then src_entry will contain
+	 * the versions of 'before' from the merge_base, HEAD, and MERGE in
+	 * stages 1, 2, and 3; dst_entry will contain the respective
+	 * versions of 'after' in corresponding locations.  Thus, we have a
+	 * total of six modes and oids, though some will be null.  (Stage 0
+	 * is ignored; we're interested in handling conflicts.)
+	 *
+	 * Since we don't turn on break-rewrites by default, neither
+	 * src_entry nor dst_entry can have all three of their stages have
+	 * non-null oids, meaning at most four of the six will be non-null.
+	 * Also, since this is a rename, both src_entry and dst_entry will
+	 * have at least one non-null oid, meaning at least two will be
+	 * non-null.  Of the six oids, a typical rename will have three be
+	 * non-null.  Only two implies a rename/delete, and four implies a
+	 * rename/add.
+	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
 	unsigned processed:1;
-- 
2.14.2

