Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FEC2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 15:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbcIOPAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:00:32 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:60081 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751613AbcIOPAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:00:31 -0400
Received: (qmail 26708 invoked from network); 15 Sep 2016 15:00:28 -0000
Received: (qmail 16200 invoked from network); 15 Sep 2016 15:00:28 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 15 Sep 2016 15:00:23 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/14] i18n: blame: mark error messages for translation
Date:   Thu, 15 Sep 2016 14:58:58 +0000
Message-Id: <1473951548-31733-4-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark error messages for translation passed to die() function.
Change "Cannot" to lowercase following the usual style.

Reflect changes to test by using test_i18ngrep.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/blame.c               | 18 ++++++++++--------
 t/t8003-blame-corner-cases.sh |  4 ++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a5bbf91..27aea79 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2601,7 +2601,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
 		if (show_progress > 0)
-			die("--progress can't be used with --incremental or porcelain formats");
+			die(_("--progress can't be used with --incremental or porcelain formats"));
 		show_progress = 0;
 	} else if (show_progress < 0)
 		show_progress = isatty(2);
@@ -2727,7 +2727,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		sb.commits.compare = compare_commits_by_commit_date;
 	}
 	else if (contents_from)
-		die("--contents and --reverse do not blend well.");
+		die(_("--contents and --reverse do not blend well."));
 	else {
 		final_commit_name = prepare_initial(&sb);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
@@ -2747,12 +2747,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		add_pending_object(&revs, &(sb.final->object), ":");
 	}
 	else if (contents_from)
-		die("Cannot use --contents with final commit object name");
+		die(_("cannot use --contents with final commit object name"));
 
 	if (reverse && revs.first_parent_only) {
 		final_commit = find_single_final(sb.revs, NULL);
 		if (!final_commit)
-			die("--reverse and --first-parent together require specified latest commit");
+			die(_("--reverse and --first-parent together require specified latest commit"));
 	}
 
 	/*
@@ -2779,7 +2779,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		}
 
 		if (oidcmp(&c->object.oid, &sb.final->object.oid))
-			die("--reverse --first-parent together require range along first-parent chain");
+			die(_("--reverse --first-parent together require range along first-parent chain"));
 	}
 
 	if (is_null_oid(&sb.final->object.oid)) {
@@ -2790,7 +2790,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	else {
 		o = get_origin(&sb, sb.final, path);
 		if (fill_blob_sha1_and_mode(o))
-			die("no such path %s in %s", path, final_commit_name);
+			die(_("no such path %s in %s"), path, final_commit_name);
 
 		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
 		    textconv_object(path, o->mode, o->blob_sha1, 1, (char **) &sb.final_buf,
@@ -2801,7 +2801,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 						      &sb.final_buf_size);
 
 		if (!sb.final_buf)
-			die("Cannot read blob %s for path %s",
+			die(_("cannot read blob %s for path %s"),
 			    sha1_to_hex(o->blob_sha1),
 			    path);
 	}
@@ -2820,7 +2820,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
 		if (lno < top || ((lno || bottom) && lno < bottom))
-			die("file %s has only %lu lines", path, lno);
+			die(Q_("file %s has only %lu line",
+			       "file %s has only %lu lines",
+			       lno), path, lno);
 		if (bottom < 1)
 			bottom = 1;
 		if (top < 1)
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index e48370d..661f9d4 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -212,12 +212,12 @@ EOF
 
 test_expect_success 'blame -L with invalid start' '
 	test_must_fail git blame -L5 tres 2>errors &&
-	grep "has only 2 lines" errors
+	test_i18ngrep "has only 2 lines" errors
 '
 
 test_expect_success 'blame -L with invalid end' '
 	test_must_fail git blame -L1,5 tres 2>errors &&
-	grep "has only 2 lines" errors
+	test_i18ngrep "has only 2 lines" errors
 '
 
 test_expect_success 'blame parses <end> part of -L' '
-- 
2.7.4

