Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C0820282
	for <e@80x24.org>; Sat, 17 Jun 2017 22:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbdFQWcN (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 18:32:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35709 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753797AbdFQWcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 18:32:07 -0400
Received: by mail-it0-f66.google.com with SMTP id f20so8373852itb.2
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XmJdwU53esBA7YaKS2qDbdTV1la6ApQl283TLh7SGG8=;
        b=GhghOsrEzEzH5OQ7nb8REWNNF8yz3oOeNLr2OAhPW62UyqAoLYJ32e8IpoD23pH0EG
         gzI5G8RprzA8qFcZHm5OupO6USdQJfOD4locI2vjeHgUjOYnmpDiU4aeE3LmVU3LLrfC
         Y5sNACGe0W9giAhTrWPPzgo3Dtqtmuy+CyBkO9e6r7hAdRGembmQN0oMDRUnLBLxRBbW
         qo1GtgE39Mx5FtE9FkHV99zUtWFirr450eXpm+CU0apPo2k4dH781P8hpGAmrWf+/VVX
         5rVbebSm9eHdH+0kMdG7VErt9HS0NrMXRwTsejiGvdMFwGc/jTuOLNrTJVLEoGpO7jrH
         w3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XmJdwU53esBA7YaKS2qDbdTV1la6ApQl283TLh7SGG8=;
        b=Q4LkU6MByKMGzZqy0huBD2xgii1Mxxk916O2qvgKHlhFma7eDAMrrbnl5weFtxITHE
         4O5/RM++fmdkNVvB9UtQWTCoELicQ1teDcJCXVV2rVnIxtCkAMcbYxS0s3KGxF6r9m7v
         dv6fDc1bxrZCa94eRCxxJCS8+GRPpMSOyNDt2+4GOMCstRdb92gkth9FfKQX0yVgwn6f
         0MXh7rqlRbYFmKsMFUhR01v0laKMOszytO45x7TUPOaZYH6ObjnByVx8xDDN8hxwJVlY
         9RbajhQKe4NEuCq8SiFaD258rhYxRzcZ6WajRykJhVUxV5nmD12bkVHYSQ8R/FG//olM
         uFLg==
X-Gm-Message-State: AKS2vOwt19QgXJ4AFFBTC9ZDuy96J1Yv3P98kFjZ+exxYJCYKXgf56s6
        e9zjyiAtX6+FLpQT/hg=
X-Received: by 10.36.158.193 with SMTP id p184mr15911210itd.66.1497738721715;
        Sat, 17 Jun 2017 15:32:01 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 33sm929589iog.26.2017.06.17.15.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 15:32:01 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 2/3] status: add optional stash count information
Date:   Sat, 17 Jun 2017 18:30:51 -0400
Message-Id: <20170617223052.6580-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170617223052.6580-1-liambeguin@gmail.com>
References: <20170616043050.29192-1-liambeguin@gmail.com>
 <20170617223052.6580-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce '--show-stash' and its configuration option 'status.showStash'
to allow git-status to show information about currently stashed entries.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config.txt     |  5 +++++
 Documentation/git-status.txt |  3 +++
 builtin/commit.c             |  6 ++++++
 t/t7508-status.sh            | 32 ++++++++++++++++++++++++++++++++
 wt-status.c                  | 24 ++++++++++++++++++++++++
 wt-status.h                  |  1 +
 6 files changed, 71 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 23b807065d92..e83b0f641574 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2992,6 +2992,11 @@ status.displayCommentPrefix::
 	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
 	Defaults to false.
 
+status.showStash::
+	If set to true, linkgit:git-status[1] will display the number of
+	entries currently stashed away.
+	Defaults to false.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d70abc6afe3a..d47f198f15cd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,6 +32,9 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
+--show-stash::
+	Show the number of entries currently stashed away.
+
 --porcelain[=<version>]::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
diff --git a/builtin/commit.c b/builtin/commit.c
index ef52457effc1..c089fb87e363 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1295,6 +1295,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.showstash")) {
+		s->show_stash = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
@@ -1343,6 +1347,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOL('b', "branch", &s.show_branch,
 			 N_("show branch information")),
+		OPT_BOOL(0, "show-stash", &s.show_stash,
+			 N_("show stash information")),
 		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
 		  N_("version"), N_("machine-readable output"),
 		  PARSE_OPT_OPTARG, opt_parse_porcelain },
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 79427840a4fa..7121a550c7ce 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1608,4 +1608,36 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'show stash info with "--show-stash"' '
+	git reset --hard &&
+	git stash clear &&
+	echo 1 >file &&
+	git add file &&
+	git stash &&
+	git status >expected_default &&
+	git status --show-stash >expected_with_stash &&
+	test_i18ngrep "^Your stash currently has 1 entry$" expected_with_stash
+'
+
+test_expect_success 'no stash info with "--show-stash --no-show-stash"' '
+	git status --show-stash --no-show-stash >expected_without_stash &&
+	test_cmp expected_default expected_without_stash
+'
+
+test_expect_success '"status.showStash=false" weaker than "--show-stash"' '
+	git -c status.showStash=false status --show-stash >actual &&
+	test_cmp expected_with_stash actual
+'
+
+test_expect_success '"status.showStash=true" weaker than "--no-show-stash"' '
+	git -c status.showStash=true status --no-show-stash >actual &&
+	test_cmp expected_without_stash actual
+'
+
+test_expect_success 'no additionnal info if no stash entries' '
+	git stash clear &&
+	git -c status.showStash=true status >actual &&
+	test_cmp expected_without_stash actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index bf651f16fae8..7992a73902ae 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -137,6 +137,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
+	s->show_stash = 0;
 	s->display_comment_prefix = 0;
 }
 
@@ -801,6 +802,27 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 	wt_longstatus_print_trailer(s);
 }
 
+static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
+			    const char *email, timestamp_t timestamp, int tz,
+			    const char *message, void *cb_data)
+{
+	int *c = cb_data;
+	(*c)++;
+	return 0;
+}
+
+static void wt_longstatus_print_stash_summary(struct wt_status *s)
+{
+	int stash_count = 0;
+
+	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
+	if (stash_count > 0)
+		status_printf_ln(s, GIT_COLOR_NORMAL,
+				 Q_("Your stash currently has %d entry",
+				    "Your stash currently has %d entries", stash_count),
+				 stash_count);
+}
+
 static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
@@ -1642,6 +1664,8 @@ static void wt_longstatus_print(struct wt_status *s)
 		} else
 			printf(_("nothing to commit, working tree clean\n"));
 	}
+	if(s->show_stash)
+		wt_longstatus_print_stash_summary(s);
 }
 
 static void wt_shortstatus_unmerged(struct string_list_item *it,
diff --git a/wt-status.h b/wt-status.h
index 8a3864783b03..d8ae2e590daf 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,6 +77,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int show_stash;
 	int hints;
 
 	enum wt_status_format status_format;
-- 
2.9.4

