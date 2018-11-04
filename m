Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B046E1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 18:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeKED0Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 22:26:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33485 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbeKED0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 22:26:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so4556979lfc.0
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DoxHnj1muRh6PMuvNuRCSl85cWgOIW7kZTfAXGrAtA=;
        b=SPdUf6lYou3fBypBdO+4JJPAMIfmTQNyDauMhh559aQTCfSnU+PNLyWR5oqlUArjw6
         t+Xro+Dn2RSKx7IhH4eW/MH1vjXFoqJ5BJCjCI66vsbkt4wQ/ERmByyzPyTcV2zRcgQC
         sgo6vPw7BO9OsXfx5xH7Bi20Xn8IgVfbhpjO3TIdwW2XAS7pPU5L1rHEHrxFu2k5A/NX
         FrdJ46QddiPmTXEAKejc2GdLY2GB9bOXjHfwyFEv6bieFl40iZxTnEczl+Vvl86jkATc
         OYahfNbiR/7H+skhsbOoRgdNu490ufx93t9EZ/TuvYRkHnjaZZm3sU1HEksdLEr7VLqv
         B2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DoxHnj1muRh6PMuvNuRCSl85cWgOIW7kZTfAXGrAtA=;
        b=IRLgu0Y46EHd0DknF7+ub/jHcTS16qQIDQhI8A72PPK7TU+D98OhFkjMhXMvVnMTkT
         Qp7/+djI8b1AnPnUUbh8RhfYZRZqxb3WBR+PzAlB4jLqpUttjQI+jwN4VbcfQ/YQwLYt
         u2B07kFAae7RKaHerLBbSM9LCQKGSN1DYe+PA7FrkomxMAi/LwEwyLKa8YilNrIYGFdB
         wvDtk9YyXwFuCO61yjEnzk1NlEMQrBE1TAanxqQryyPHqo5atyJE6n119m62sjidvxX/
         5qv/Ktfu0xF3O/OKTs26H0z8pmX4XyP8wiig1BZuztGxRkOhTHVgCnH4TknrDxAq5SJV
         Tchg==
X-Gm-Message-State: AGRZ1gIM1QO0MBV7AFYpECA8O/NM9B45Ar7NdAv/VMhhnXrMAtQJIO3L
        W1wX73MRPsR7KsMegsol0Vo=
X-Google-Smtp-Source: AJdET5ffE8LrKMpp4dfZSkZxLZdV+51u3ONnGg+tA84hyQF2N+MAUg/CWOrP68pjKlszly4hcjzBpg==
X-Received: by 2002:a19:1365:: with SMTP id j98mr10516172lfi.55.1541355031545;
        Sun, 04 Nov 2018 10:10:31 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n77sm1106858lfn.92.2018.11.04.10.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 10:10:30 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: [PATCH/RFC v2] sequencer.c: record revert/cherry-pick commit with trailer lines
Date:   Sun,  4 Nov 2018 19:10:26 +0100
Message-Id: <20181104181026.8451-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181104072253.12357-1-pclouds@gmail.com>
References: <20181104072253.12357-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit is reverted (or cherry-picked with -x) we add an English
sentence recording that commit id in the new commit message. Make
these real trailer lines instead so that they are more friendly to
parsers (especially "git interpret-trailers").

A reverted commit will have a new trailer

    Revert: <commit-id>

Similarly a cherry-picked commit with -x will have

    Cherry-picked-from: <commit-id>

When reverting or cherry picking a merge, the reverted/cherry-picked
branch will be shown using extended SHA-1 syntax, e.g.

    Revert: <commit-id>~2

Since we're not producing the old lines "This reverts commit ..." and
"(cherry picked from commit .." anymore, scripts that look for these
lines will need to be updated to handle both. Fresh new history could
just rely on git-interpret-trailers instead.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 adds the third syntax "~2" and renames Cherry-Pick: to
 Cherry-picked-from: and acknowledge the problem with breaking
 scripts. I don't have a pretty solution for that though.

 Documentation/git-cherry-pick.txt |  5 ++---
 sequencer.c                       | 33 +++++++++++++++++--------------
 t/t3510-cherry-pick-sequence.sh   | 12 +++++------
 t/t3511-cherry-pick-x.sh          | 26 ++++++++++++------------
 4 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..54e73e74c0 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -58,9 +58,8 @@ OPTIONS
 	message prior to committing.
 
 -x::
-	When recording the commit, append a line that says
-	"(cherry picked from commit ...)" to the original commit
-	message in order to indicate which commit this change was
+	When recording the commit, append "Cherry-picked-from:" trailer line
+	recording the commit name which commit this change was
 	cherry-picked from.  This is done only for cherry
 	picks without conflicts.  Do not use this option if
 	you are cherry-picking from your private branch because
diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..f804406b68 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,7 +36,6 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 const char sign_off_header[] = "Signed-off-by: ";
-static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
 
@@ -1669,7 +1668,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res, unborn = 0, allow, parent_id = -1;
 
 	if (opts->no_commit) {
 		/*
@@ -1716,6 +1715,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			return error(_("commit %s does not have parent %d"),
 				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
+		parent_id = cnt;
 	} else if (0 < opts->mainline)
 		return error(_("mainline was specified but commit %s is not a merge."),
 			oid_to_hex(&commit->object.oid));
@@ -1758,16 +1758,15 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		strbuf_addstr(&msgbuf, "Revert \"");
-		strbuf_addstr(&msgbuf, msg.subject);
-		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
-		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-
-		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
-		}
-		strbuf_addstr(&msgbuf, ".\n");
+		strbuf_addf(&msgbuf, "Revert \"%s\"\n\n", msg.subject);
+
+		if (parent_id != -1)
+			strbuf_addf(&msgbuf, "Revert: %s~%d\n",
+				    oid_to_hex(&commit->object.oid),
+				    parent_id);
+		else
+			strbuf_addf(&msgbuf, "Revert: %s\n",
+				    oid_to_hex(&commit->object.oid));
 	} else {
 		const char *p;
 
@@ -1784,9 +1783,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_complete_line(&msgbuf);
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-			strbuf_addstr(&msgbuf, ")\n");
+			if (parent_id != -1)
+				strbuf_addf(&msgbuf, "Cherry-picked-from: %s~%d\n",
+					    oid_to_hex(&commit->object.oid),
+					    parent_id);
+			else
+				strbuf_addf(&msgbuf, "Cherry-picked-from: %s\n",
+					    oid_to_hex(&commit->object.oid));
 		}
 		if (!is_fixup(command))
 			author = get_author(msg.message);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c84eeefdc9..504423ec20 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -390,10 +390,10 @@ test_expect_success '--continue respects opts' '
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	! grep "cherry picked from" initial_msg &&
-	grep "cherry picked from" unrelatedpick_msg &&
-	grep "cherry picked from" picked_msg &&
-	grep "cherry picked from" anotherpick_msg
+	! grep "Cherry-picked-from:" initial_msg &&
+	grep "Cherry-picked-from: " unrelatedpick_msg &&
+	grep "Cherry-picked-from: " picked_msg &&
+	grep "Cherry-picked-from: " anotherpick_msg
 '
 
 test_expect_success '--continue of single-pick respects -x' '
@@ -404,7 +404,7 @@ test_expect_success '--continue of single-pick respects -x' '
 	git cherry-pick --continue &&
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD >msg &&
-	grep "cherry picked from" msg
+	grep "Cherry-picked-from:" msg
 '
 
 test_expect_success '--continue respects -x in first commit in multi-pick' '
@@ -416,7 +416,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD^ >msg &&
 	picked=$(git rev-parse --verify picked) &&
-	grep "cherry picked from.*$picked" msg
+	grep "Cherry-picked-from: $picked" msg
 '
 
 test_expect_failure '--signoff is automatically propagated to resolved conflict' '
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9888bf34b9..798fdaf8da 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -32,7 +32,7 @@ mesg_with_footer_sob="$mesg_with_footer
 Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 
 mesg_with_cherry_footer="$mesg_with_footer_sob
-(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+Cherry-picked-from: da39a3ee5e6b4b0d3255bfef95601890afd80709
 Tested-by: C.U. Thor <cuthor@example.com>"
 
 mesg_unclean="$mesg_one_line
@@ -81,7 +81,7 @@ test_expect_success 'cherry-pick -x inserts blank line after one line subject' '
 	cat <<-EOF >expect &&
 		$mesg_one_line
 
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
@@ -129,7 +129,7 @@ test_expect_success 'cherry-pick -x inserts blank line when conforming footer no
 	cat <<-EOF >expect &&
 		$mesg_no_footer
 
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
@@ -154,7 +154,7 @@ test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer
 	cat <<-EOF >expect &&
 		$mesg_no_footer
 
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -178,7 +178,7 @@ test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match commi
 	git cherry-pick -x -s mesg-with-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -201,7 +201,7 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
 	git cherry-pick -x -s mesg-with-footer-sob &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer_sob
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -215,7 +215,7 @@ test_expect_success 'cherry-pick -x handles commits with no NL at end of message
 	git cherry-pick -x $sha1 &&
 	git log -1 --pretty=format:%B >actual &&
 
-	printf "\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	printf "\nCherry-picked-from: %s\n" $sha1 >>msg &&
 	test_cmp msg actual
 '
 
@@ -226,7 +226,7 @@ test_expect_success 'cherry-pick -x handles commits with no footer and no NL at
 	git cherry-pick -x $sha1 &&
 	git log -1 --pretty=format:%B >actual &&
 
-	printf "\n\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	printf "\n\nCherry-picked-from: %s\n" $sha1 >>msg &&
 	test_cmp msg actual
 '
 
@@ -252,19 +252,19 @@ test_expect_success 'cherry-pick -s handles commits with no footer and no NL at
 	test_cmp msg actual
 '
 
-test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -x treats "Cherry-picked-from:" line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -s treats "Cherry-picked-from:" line as part of footer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
@@ -275,13 +275,13 @@ test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -x -s treats "Cherry-picked-from:..." line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
-		(cherry picked from commit $sha1)
+		Cherry-picked-from: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
-- 
2.19.1.1005.gac84295441

