Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92722027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbdE3Rcw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:52 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34532 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdE3Rbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:40 -0400
Received: by mail-pf0-f177.google.com with SMTP id 9so78323782pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqYeMLIwOYrbnffrYuCz/QKW1xmLebsZoXRqCHEu7FQ=;
        b=Ow5aruT40HV/i0yuR4RUPnltwOr5ilaZsDgfvKPOB+NspM2K9FkxdXUiZuW3t71Wje
         Tj8LGCq6hJ8u2vPBLL+ke6w1gb3HiQZi6YJqQP3k7pPFDR8QPan7ZZ4eBM/SWbGVlxuW
         OixYCmNKJdByI8Ex7sPa/7iVVRjBrrCWPjdkM1sBGPsQmvdeywcjHxDp1UmDo732Ei24
         7FncOracMRzANvh2oaJ1hSfE5SgcnzUWTSMbF5ksEOfoBuw4/TRdbya1DULH9lyjodnj
         /GqA9JgbXyWV1DlnkNRFlbp6tKmNiUiiWL2PKqUmc02FerNBuVBTsGJeylsoLAMTyX+V
         Zo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqYeMLIwOYrbnffrYuCz/QKW1xmLebsZoXRqCHEu7FQ=;
        b=iV/YaxlTwTAEKjx3HzBuAd0CfLSM9qdw78ILw4EmzgdtmSUrgtHltoRCMmJk/1JEnJ
         LXhCfUqm+2DQyBOXRh1RiNSHOD+wmZOa3gOT217ESw5OFTGbWY/n1O1Ugb+G4tTfzcHF
         fTDXRoRDnpaDcRIC3ws8mOVNOj5XAjI5o+ERNvH+qbVXRkPSivANkiBPjKh9WhirSVyB
         NNxr3rCZkRlvBYs4SjfD8luextUxOqNtypTV+Won51jYTS3PRZqmp8y0IjP9I2CkKfDi
         zzpiq8VBOrq8UgI+ft8DScCGcDC5teLQUE2hXpPQjr/TNBRnwUezZt+A+3VBC0okFZHY
         AGDg==
X-Gm-Message-State: AODbwcChg2NbooKA3OGlyvepAdKB+Q5Ly6q03K/piiRSOB8mSSNigT3N
        YqTuJBPO2j9hFnXfxa+2ZA==
X-Received: by 10.98.8.19 with SMTP id c19mr24110958pfd.91.1496165499312;
        Tue, 30 May 2017 10:31:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 16/33] diff: finish conversion for prepare_temp_file to struct object_id
Date:   Tue, 30 May 2017 10:30:52 -0700
Message-Id: <20170530173109.54904-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 084c8b2d0..a8ceeb024 100644
--- a/diff.c
+++ b/diff.c
@@ -3030,13 +3030,13 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			/* we can borrow from the file in the work tree */
 			temp->name = name;
 			if (!one->oid_valid)
-				sha1_to_hex_r(temp->hex, null_sha1);
+				oid_to_hex_r(temp->hex, &null_oid);
 			else
 				oid_to_hex_r(temp->hex, &one->oid);
 			/* Even though we may sometimes borrow the
 			 * contents from the work tree, we always want
 			 * one->mode.  mode is trustworthy even when
-			 * !(one->sha1_valid), as long as
+			 * !(one->oid_valid), as long as
 			 * DIFF_FILE_VALID(one).
 			 */
 			xsnprintf(temp->mode, sizeof(temp->mode), "%06o", one->mode);
-- 
2.13.0.219.gdb65acc882-goog

