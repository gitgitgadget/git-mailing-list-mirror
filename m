Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F98F1F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeELIAp (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40348 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeELIAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id p85-v6so11044519lfg.7
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/z5srrKU6Y9i9ISzsjRSPOgBIEy/hDDl+91e+Icrk0=;
        b=c2s+m3DDuThtMtgKU7V+9F8MNlG/9/A0Fikao+TmmP1FckZm/h5ubTeIeDZiGtRM5q
         yX+LJMVjnb5fE55Pf/CR6cT1d0h6u34XHMRwAODFYrVbga1R5pASuDgDohfigsIxJTkw
         YBWxFpq1sOZER8yaCTRUEH7ln/8nK8tXF16zmICCS6lDZDf0PMqDBfRgBY1TwUHspIW5
         Tq7iRuFc5ZZcuIynIKX1DxSiwv6NNIDwzwfSV4Ac0LHrhoqOEKDMVH8d95xSs2TotHVD
         Ctl3gioh+yssftCxRwY7fDDEtHuFlwn4nfYzFULjqpq8EM1FMipF5dDrSXP0hwAlMO7J
         salA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/z5srrKU6Y9i9ISzsjRSPOgBIEy/hDDl+91e+Icrk0=;
        b=aP3ISBZMsQ7cJHPB0Nm5UusJi0ivdAHSDSzKW3PyNiWVYR51MzNRUs7pRJD/UkWNHN
         44mnNjndUNiEvAjQAuUTkqe66K76cKdx2azFVMsClCv/bUela6SPwVf3Z6OWnppE5ttq
         Sgzfgxhn/iy30KCovv1y1i0NfNdy3KjWtgEiYgboUh2TDnZ9Y2QHZO+OBN28dDDbYqi0
         PBleU19wSF5VybU2kTL5Dpej6x5a3l5REGbufy8RRDKa/sVCuhDwb/m3Ld2Jf2AvrZLs
         koaTWaMBMzhkdsj6D77SrxynkTbvoM7zFm+BCf9A6dZ3FtodDeot+7N84zIDtVDq6EcQ
         zLKg==
X-Gm-Message-State: ALKqPwf22e/eSRt7GnDctyObf3zvyLT1K/C+4/A/8NDjB2vbVhIcJDZ6
        6Nwz/GBVy8q8hgSQhzu2AYLURg==
X-Google-Smtp-Source: AB8JxZoGVYdcEwiaUTiBlQ3IqqIb+BpSqt2/yXW83U3JuZ3lgN/8Vk47UGU5uVkyXP7zx9uvv3sEkw==
X-Received: by 2002:a2e:8350:: with SMTP id l16-v6mr516522ljh.28.1526112036011;
        Sat, 12 May 2018 01:00:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/12] sequencer.c: use commit-slab to mark seen commits
Date:   Sat, 12 May 2018 10:00:20 +0200
Message-Id: <20180512080028.29611-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4ce5120e77..5993ffe060 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "commit-slab.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3160,6 +3161,7 @@ static enum check_level get_missing_commit_check_level(void)
 	return CHECK_IGNORE;
 }
 
+define_commit_slab(commit_seen, int);
 /*
  * Check if the user dropped some commits by mistake
  * Behaviour determined by rebase.missingCommitsCheck.
@@ -3173,6 +3175,9 @@ int check_todo_list(void)
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
 	int advise_to_edit_todo = 0, res = 0, i;
+	struct commit_seen commit_seen;
+
+	init_commit_seen(&commit_seen);
 
 	strbuf_addstr(&todo_file, rebase_path_todo());
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
@@ -3189,7 +3194,7 @@ int check_todo_list(void)
 	for (i = 0; i < todo_list.nr; i++) {
 		struct commit *commit = todo_list.items[i].commit;
 		if (commit)
-			commit->util = (void *)1;
+			*commit_seen_at(&commit_seen, commit) = 1;
 	}
 
 	todo_list_release(&todo_list);
@@ -3205,11 +3210,11 @@ int check_todo_list(void)
 	for (i = todo_list.nr - 1; i >= 0; i--) {
 		struct todo_item *item = todo_list.items + i;
 		struct commit *commit = item->commit;
-		if (commit && !commit->util) {
+		if (commit && !*commit_seen_at(&commit_seen, commit)) {
 			strbuf_addf(&missing, " - %s %.*s\n",
 				    short_commit_name(commit),
 				    item->arg_len, item->arg);
-			commit->util = (void *)1;
+			*commit_seen_at(&commit_seen, commit) = 1;
 		}
 	}
 
@@ -3235,6 +3240,7 @@ int check_todo_list(void)
 		"The possible behaviours are: ignore, warn, error.\n\n"));
 
 leave_check:
+	clear_commit_seen(&commit_seen);
 	strbuf_release(&todo_file);
 	todo_list_release(&todo_list);
 
-- 
2.17.0.705.g3525833791

