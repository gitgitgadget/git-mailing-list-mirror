Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9FB1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeCaPOx (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:14:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46957 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbeCaPOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1so10085324wrj.13
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0Yw0WgU/1dMMY4C+ZIkjFvGe2Li8nDXFfJ4AykGQJM=;
        b=DrxzaDMtOFwTh3pCGSrD2YRCTAOB47Jax1KNQL/S6KnMDqcsYxxh5gk0Iv0vL4gxse
         p0cUUBWhdKR4AM4iffb0XEKVAVGlQ2mB+l+jJ1xCeKJmDVoMAvpWUvO0gmkRaurKbD9k
         1fxJTxlOX2P0cK8YUD4NUlGpsrWYmN/xFgQqHJnzeNQx5y8uRL28YDV81XgcCneOB2xY
         Lj3/xRuj6Q24n5S2jOPDL6kC42f/b17mB1nMBGsdyVyP8cFo0j7pWB8my0CKWEnSC37Y
         j++VT6WNystwMvLMPE0GC/GG8m/WwdXKEpKtkeSsMSiqMK8SdORIx0sba0GjoG8PVMet
         Q+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0Yw0WgU/1dMMY4C+ZIkjFvGe2Li8nDXFfJ4AykGQJM=;
        b=iyljWIKnXZMaYX9R6M3SNkuJykNUSt3KKcwqyeQnQN4SH+osqdQRl2lpibPH9V8YtK
         w04mzrhywKKXVdE0pUmGvDYrwAQMcy76eCFcxA63saeTq8RUqFn3hOlbyNDgf0s5zIWI
         1jVTYPslt3yuc8Ony9s97S9iPhs4hs+xObKv7BPmKtmNkLe6mO9934VQjp3kyIWFaaSm
         FV6ARw23ffJG1gox6DMVAG8d2D8sI19y+KR+NXCDF1RmC+ql4Dus8kU+ExEOajCNgxzM
         sW2fQHeuCgYXM9H1QlQ0nr6QVMaGnUJzktyq3ftvMpkkSiSTgvTBAOMbP2pA0aJM2Vjb
         A/RQ==
X-Gm-Message-State: AElRT7Hjg8tFgNbe9qeGxmvibtsm8JFo4/NjtKzni6ATa/hO0Jr4RxeU
        D4AGc/TKJAEdmS3QNb2/8USfuhH3
X-Google-Smtp-Source: AIpwx48VpOxRQIaFyC1Pp9TnbF7OUjInIrc4Y6J55uGv4PwXIae0C1aLhlmjbcFoNwndak50WAWU6g==
X-Received: by 10.223.132.103 with SMTP id 94mr2019401wrf.275.1522509288769;
        Sat, 31 Mar 2018 08:14:48 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f2sm5206883wre.31.2018.03.31.08.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 3/6] worktree: improve message when creating a new worktree
Date:   Sat, 31 Mar 2018 16:18:01 +0100
Message-Id: <20180331151804.30380-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' produces output like the following, when
'--no-checkout' is not given:

    Preparing foo (identifier foo)
    HEAD is now at 26da330922 <title>

where the first line is written to stderr, and the second line coming
from 'git reset --hard' is written to stdout, even though both lines are
supposed to tell the user what has happened.  In addition to someone not
familiar with 'git worktree', this might seem as if the current HEAD was
modified, not the HEAD in the new working tree.

If the '--no-checkout' flag is given, the output of 'git worktree add'
is just:

    Preparing foo (identifier foo)

even though the HEAD is set to a commit, which is just not checked out.

The identifier is also not particularly relevant for the user at the
moment, as it's only used internally to distinguish between different
worktrees that have the same $(basename <path>).

Fix these inconsistencies, and no longer show the identifier by making
the 'git reset --hard' call not print the "HEAD is now at ..." line
using the newly introduced flag from the previous commit, and printing
the message directly from the builtin command instead.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4d96a21a45..cc94325886 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -301,8 +301,6 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
-
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
@@ -322,12 +320,22 @@ static int add_worktree(const char *path, const char *refname,
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
 		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		argv_array_push(&cp.args, "--no-show-new-head-line");
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
 	}
 
+	fprintf(stderr, _("New worktree HEAD is now at %s"),
+		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+
+	strbuf_reset(&sb);
+	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+	if (sb.len > 0)
+		fprintf(stderr, " %s", sb.buf);
+	fputc('\n', stderr);
+
 	is_junk = 0;
 	FREE_AND_NULL(junk_work_tree);
 	FREE_AND_NULL(junk_git_dir);
-- 
2.16.1.78.ga2082135d8

