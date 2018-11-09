Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BC51F453
	for <e@80x24.org>; Fri,  9 Nov 2018 09:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeKITOD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:14:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKITOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:14:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id q5-v6so640101pgv.0
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 01:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pbW3Bs6lS91QK+iX9E92EpBHbc+GfvB9V3GDNSazrts=;
        b=LgM4se+1xnjF5sjk/ZUnvHzX/pzQZpq9RxOFnX8NLPuTNsC/a9kB0+0rT3EBUNM33E
         6+kxgG0yCP73xwOWXvgyuOIeyTWk3u4gfmOpVEpIhJIOpYGfnXbfD9AkW4CyZpVLO+lv
         ciXYOpi47f9zvXmJiO8eh+YcikWOoc/2sCYTMX5K4KFYAKf3rhGeLTivQLSVCeOeCLI9
         a++R0KaPzjFizo4mXCe80WkTyEOvao7YcVPtwL1V1WpLISQ1vkohNFAP+yndYlWFRAn9
         DMJdlF2f2SwkeEHDODH5CjXhVATOwmJNdgnCVwAn3dJmo9WkDdwopwuMlWZeqwKSvDPE
         K0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pbW3Bs6lS91QK+iX9E92EpBHbc+GfvB9V3GDNSazrts=;
        b=sDTPJfLd9rV/A1sYQyIS2OJPWfSFeFkNCr4vR9DKeFfHvlGNkrKYf1fjzH5pIUlpTE
         khQjTawaQuNUnD853h9dlKs4RcmJFCQQfiX3lk+05PkN9AnLUXU4yvxqaEDtjmWhOepj
         XazBWp+pjoas1U5GFl7lh7Sjed5Iiytn7Wc/x994+M03kVGnS+js1gl10z/8lNFMUVdB
         MR5niSHT+877CiinPK2WD+nosWehVDKFyjyRPGAwyAdYLaMtJXZs3HnXZjKopFk0R1A9
         ydXqT3xkKOVSgbyaNaY4agjpK2w9LZV7f3ljOibWruuHjbdPmwqkMLtsQqlmBstByNhs
         AOYA==
X-Gm-Message-State: AGRZ1gJV8j5QavY/k+suaWTMOAvbg/QuliBvfj51Zjl1GTeLeGWH9KDa
        W4b049GOKc7tS9UOOUiwUzTB9R2D
X-Google-Smtp-Source: AJdET5cU/9Hk2FVJsli1OzyMYcERdEfh7zFAIK2AYcf8Ap8CBn6qxORmwECZT6vqL2x1SH9OHeGkzA==
X-Received: by 2002:a63:5664:: with SMTP id g36mr6738108pgm.313.1541756058554;
        Fri, 09 Nov 2018 01:34:18 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id w63-v6sm6086936pgw.60.2018.11.09.01.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:34:17 -0800 (PST)
Date:   Fri, 09 Nov 2018 01:34:17 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 09:34:13 GMT
Message-Id: <64597fe827021383ab68cfb247de61fcf104a961.1541756054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.72.git.gitgitgadget@gmail.com>
References: <pull.72.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] rebase: consolidate clean-up code before leaving
 reset_head()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The same clean-up code is repeated quite a few times; Let's DRY up the
code some.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..6f6d7de156 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -569,16 +569,13 @@ static int reset_head(struct object_id *oid, const char *action,
 	}
 
 	if (!fill_tree_descriptor(&desc, oid)) {
-		error(_("failed to find tree of %s"), oid_to_hex(oid));
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		return -1;
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
 	}
 
 	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		return -1;
+		ret = -1;
+		goto leave_reset_head;
 	}
 
 	tree = parse_tree_indirect(oid);
@@ -586,10 +583,9 @@ static int reset_head(struct object_id *oid, const char *action,
 
 	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
 		ret = error(_("could not write index"));
-	free((void *)desc.buffer);
 
 	if (ret)
-		return ret;
+		goto leave_reset_head;
 
 	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
 	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
@@ -622,7 +618,10 @@ static int reset_head(struct object_id *oid, const char *action,
 					 UPDATE_REFS_MSG_ON_ERR);
 	}
 
+leave_reset_head:
 	strbuf_release(&msg);
+	rollback_lock_file(&lock);
+	free((void *)desc.buffer);
 	return ret;
 }
 
-- 
gitgitgadget

