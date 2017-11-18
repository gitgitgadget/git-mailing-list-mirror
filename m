Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E272201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424353AbdKRR2A (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:28:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45930 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424344AbdKRR16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:27:58 -0500
Received: by mail-pf0-f193.google.com with SMTP id 17so4205364pfn.12
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=meB8D9Z3HDxzyUuxHPCDI5ZXzU/hotefFXzZ6nzAUZ8=;
        b=jDsCEOusK7Jy6A8ByOW0lBEXV0ZjGhQS6XVvctpJ5EZLrLcD08RcLYd08+zZoOfZ4A
         HiL+P0exNr7v8FpvJCFzrOylc7x+ehxmgLtCIq+MyVilsTxIO687qhWB4qfMZbjnksNQ
         KQY+pm75r2l2Wh4EAV4YlzTcviYKsg3KYILYOnLuvGBMFVJFyLLVQ/WSyKPo4Vn4VZzJ
         fV8bmGNsEO+3BUzoJ7+U2W6tcHF91QwQ09rgNwUBlj0s75w5yBBhdxZ9fI823tJwT54v
         kJSHbX3t3VaetmJDpW3Rg14skLHbPQvc5pxnj0I00Xyl/c+1ufvbA7xho1vDLBsl7+8p
         eGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=meB8D9Z3HDxzyUuxHPCDI5ZXzU/hotefFXzZ6nzAUZ8=;
        b=DGU4FH5XUfjV98r+H0Wq65eAC3mKaRIQzrDaPFCzFirld7hdIGEY0Ue5gSyjPgJ/me
         qbIcEmqrXHJBSSuPi4RO9f4fDkL7I2+pv8+vFWQiL9rTQ+4gMT3CfH+xSjRVvxIKS4V6
         S2eF5oq3p7blP5iM3uzxmocM6DJ4U3adbc6+W408/ZJQjS6UaJ2BML0oP8gIr7NMa5Cq
         PdjZIyV3trGzb0m+gk/vxEzM+N4Ll3vgLneSUo4RbH6KdIm0yKyw1G80d0/KgnWb7MjF
         /zG5U/4XBb1zbfwHAtkwssojBhzQ1sOurK38HMRQWxQz14UaAuzKwCUBqitHDL5k8/bp
         SezQ==
X-Gm-Message-State: AJaThX6n/OcZXo4HUK7uiStI+vhb6BytKlvKoBaEPO0E1hFoFILLPWZS
        7iG6br+tpFvCTYlAdI85WEib5RiA
X-Google-Smtp-Source: AGs4zMZkPZnJ4XxPMkBydsLhoIIo1S129VtS4RRGp9qrOTz+A6vYIc8j+ygD0xNZDP8gSPETUgpURQ==
X-Received: by 10.98.7.149 with SMTP id 21mr5938422pfh.14.1511026078002;
        Sat, 18 Nov 2017 09:27:58 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id d12sm10479749pgt.16.2017.11.18.09.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 09:27:57 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/4] branch: group related arguments of create_branch()
Date:   Sat, 18 Nov 2017 22:56:46 +0530
Message-Id: <20171118172648.17918-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
In-Reply-To: <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

39bd6f726 (Allow checkout -B <current-branch> to update the current
branch, 2011-11-26) added 'clobber_head' (now, 'clobber_head_ok')
"before" 'track' as 'track' was closely related 'clobber_head' for
the purpose the commit wanted to achieve. Looking from the perspective
of how the arguments are used it turns out that 'clobber_head' is
more related to 'force' than it is to 'track'.

So, re-order the arguments to keep the related arguments close
to each other.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 branch.c           | 2 +-
 branch.h           | 9 +++++----
 builtin/branch.c   | 2 +-
 builtin/checkout.c | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 3e8d2f93f..bd607ae97 100644
--- a/branch.c
+++ b/branch.c
@@ -228,7 +228,7 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head_ok,
+		   int force, int clobber_head_ok, int reflog,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
diff --git a/branch.h b/branch.h
index cb6411f84..f66536a10 100644
--- a/branch.h
+++ b/branch.h
@@ -13,19 +13,20 @@
  *
  *   - force enables overwriting an existing (non-head) branch
  *
- *   - reflog creates a reflog for the branch
- *
  *   - clobber_head_ok allows the currently checked out (hence existing)
  *     branch to be overwritten; without 'force', it has no effect.
  *
+ *   - reflog creates a reflog for the branch
+ *
  *   - quiet suppresses tracking information
  *
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
+ *
  */
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog,
-		   int clobber_head_ok, int quiet, enum branch_track track);
+		   int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track);
 
 /*
  * Validates that the requested branch may be created, returning the
diff --git a/builtin/branch.c b/builtin/branch.c
index 33fd5fcfd..4edef5baa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -806,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
-			      force, reflog, 0, quiet, track);
+			      force, 0, reflog, quiet, track);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d8bcc383..6068f8d8c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -640,8 +640,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		else
 			create_branch(opts->new_branch, new->name,
 				      opts->new_branch_force ? 1 : 0,
-				      opts->new_branch_log,
 				      opts->new_branch_force ? 1 : 0,
+				      opts->new_branch_log,
 				      opts->quiet,
 				      opts->track);
 		new->name = opts->new_branch;
-- 
2.15.0.291.g0d8980c5d

