Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D8F1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeCYNqd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44999 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753321AbeCYNqb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id u46so16309502wrc.11
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H+f3Lxas5B6dqsrKR9kTHrkh+SCq9TFDXyFJs8Fn9yU=;
        b=l7gALrNoc/UY3YPQh1PEIjmOm0lbuQ0Kuq/h5s1FE6Kzppi1p7SrjK+mobnWtw7gAt
         JSTObBLRzzVFnYYwp10NkI3otjVmCV7eF2KIU49AU4Oov08nglOfr+/eGbbhUF9QVqf1
         vrbeqYIUoVk+Fr52Ho4EAerqTr+yOm3aG/l6xqiNaHHr4p3ShYWNe1tOKy6WyjBOMVVi
         Mv8rFRy+b0EevbgvfOwexEGAn1wdh9W3s+KTniM0wmmtJeT/tniIYD6PWJpx4r8SK0qZ
         IYg34wAu8alAyJ0zP2XYWHqg2qHNUE4LZCEvBm39eBgfDJuOIVfIJaKR+GzVYbhGAttQ
         Pp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H+f3Lxas5B6dqsrKR9kTHrkh+SCq9TFDXyFJs8Fn9yU=;
        b=QgqKY9VSf054tMlI81N62UoZL6HAXyGd7Pmm2q3Z2cupNVRt66PSUcsuQ8ytSARKJF
         6xle3s09x3WwtF1BsMoIHnjmNzdMW1VgSAhjPFg0KyHdMK6KsjUxt0A9fcYGufoD2zDf
         S7z0cEoYbsWD8RT0TVix45RCXoJEBlFhT1BfTDvbeOHpH1oVKA1B6b0MujOVTsG0Agj1
         lUrNsWdOCO9MfOBtonKz7JMDQb5tRVQkUe1XhBZQitcVu07yGo7bZ5mbumvfNHWGGrxa
         bBHAu6ZllLsleiK9AKxtn7uOrljrzZlnN5KARIJdCuXXi3gXZDiPLOcQnnWD3dteMDyU
         79vg==
X-Gm-Message-State: AElRT7HdskXtzvMlebvehl5WBs6SHX5+PntH7SkuLrdUbmZiHXWlQ/Mm
        xIIs7DOTMERuCVIMRzDEg0NSvGnQ
X-Google-Smtp-Source: AG47ELsGkseIp6sDj1XFSET6bel8rA6ftoYzrT1C2LRA9n6LtF28yUOQs8UEil2VIZbI3g7IWS20Ew==
X-Received: by 10.223.160.241 with SMTP id n46mr27437614wrn.280.1521985589836;
        Sun, 25 Mar 2018 06:46:29 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k11sm14479521wmi.35.2018.03.25.06.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:29 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 1/6] worktree: improve message when creating a new worktree
Date:   Sun, 25 Mar 2018 14:49:42 +0100
Message-Id: <20180325134947.25828-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
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
the 'git reset --hard' call quiet, and printing the message directly
from the builtin command instead.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..535734cc7f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -303,8 +303,6 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
-
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
@@ -320,10 +318,19 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	fprintf(stderr, _("new worktree HEAD is now at %s"),
+		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+
+	strbuf_reset(&sb);
+	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+	if (sb.len > 0)
+		fprintf(stderr, " %s", sb.buf);
+	fputc('\n', stderr);
+
 	if (opts->checkout) {
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
-		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
-- 
2.16.1.77.g8685934aa2

