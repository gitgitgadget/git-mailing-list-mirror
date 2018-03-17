Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F39F1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeCQWFu (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:05:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52995 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCQWFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:05:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id t3so9070414wmc.2
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pYu6hI56bGIKaNrwbHqVzsqwZR4dR2EN/mDFi9ddKO4=;
        b=tTjr4Z9Xu9tzviALzDAlUpU5GGCWrhepO0rOJ10ZhvpXED81zYatv9YgT+hPgj/Qrc
         CONQOc78548+q2CGaIow0+OrjSdv3JRt6HZV6i6GXHkRpHHzG5tBFYr2uzcF9pXKnsT+
         P0VwUe3f5QDHYCfz3gA44JV78klTIHg6x7UCFIqzBqXRegwwnHauf5DHhFnrD5l29HvJ
         nqx1hg9Pd32a0/iKvPR04CrGaSCgXIUioMZbSy7G1nHhXXYFtqXXhTe5k7ZRNEJbonFJ
         TtfFnswfJiVlcdCDaMSEl8SYbj9NGCoDroBwZcYQDp5iAmSAQW2XVVPWe/MBRmRcRR2b
         LjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pYu6hI56bGIKaNrwbHqVzsqwZR4dR2EN/mDFi9ddKO4=;
        b=pINhcfsI/PSD0N08jWnBcsQkXxJD54U6rZaPzZNt4wnfipPLN+s5AJzLAF6RSqvu+Q
         7ckXIYXA0xT4u8Y41jv+SUGcSxyUVHqHKdJKRA20+WhAPD2MyLFY32EeW8N1A4sA+Dyo
         ZmZViCjW2DJUgW7knKt4KEuDzkUimbeBDrFEMfMG5zYSDI7RRob72ZzEYnKEu6zlJpD9
         TV57GfpLOIApE9gqsH4rzt6UbAA1Vw6mKTW1lYs3l4mp2oAav+ERcbXKSfe91GQFKpw4
         oGxQSWLjVugpSJwJgpX5ELKpbFZWISJr/h+NmHthP2S/6ABc/DM9L1a2sQcpR8BZenaT
         jjoA==
X-Gm-Message-State: AElRT7FGbqXjDMpjJOmZG8009gimg7D4f5iqXJwv8Bci/QvdzNU1fYVX
        b3nJr1kWVq9WQntRudbfuOsue1PP
X-Google-Smtp-Source: AG47ELvqMdEmhLQ5lOg86mN8hzUI0Ttdl+onDrFabzQpyLt8u+FC+6JISDnSTRX3wxDRZuQQ7XQ7og==
X-Received: by 10.28.214.194 with SMTP id n185mr5271835wmg.73.1521324346494;
        Sat, 17 Mar 2018 15:05:46 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u34sm170542wrc.45.2018.03.17.15.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:05:45 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/4] worktree: improve message when creating a new worktree
Date:   Sat, 17 Mar 2018 22:08:27 +0000
Message-Id: <20180317220830.30963-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317220830.30963-1-t.gummerer@gmail.com>
References: <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180317220830.30963-1-t.gummerer@gmail.com>
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
index 7cef5b120b..e5d04f0b4b 100644
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
 
+	fprintf(stderr, _("worktree HEAD is now at %s"),
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
2.17.0.rc0.231.g781580f06

