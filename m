Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E7720401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdFUSQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:16:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34916 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdFUSQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:16:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so32165197pfs.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=s+mN+86hC5R4Kl5bFVedAbwc+Z1XN/ijJYFEERWEnG8=;
        b=SVCwsbYwSKu73PFMf4NAU0KKyVA/xa33ZTbapzQjfu0J+TsVh9BeLPH/5wQaw+J7bu
         weW7eBVoPRWV31R7K1D2q+J498ydL2WqNODy6TXk3gzXg1UiqPgkrWfOGLP482tbPUVf
         dRLGxcBUKWqTxsyqArc06ibrid2IEF87fh3m8JwXDGd8o4Vbpl27h/MMi+svINz9aDR7
         uSNyo5qCnbWZ+ehk6kAUCMdwBdUlHiqalpImnlpOrsoqhcvDDhE5RH2ndZzinT6/NfEA
         OH1AsCv5JRZUIEw+Qf49WJKXbOXKl0KlhabO0tsamntRYsPpJovrGcWjdTTO6echmL+Y
         ZdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=s+mN+86hC5R4Kl5bFVedAbwc+Z1XN/ijJYFEERWEnG8=;
        b=Q1VTRSXQpGHEgC+dFfQ1bHczCs97gD80tRTjwJFMl0BOdMyTErHf3VF/8q34w3gYfF
         RZ3yHJP/n5CX7lhmw7RKHb/7NN2vpAd2lPfVM8P/bRQH2jgur3KiQynnND8pmsWy4Oew
         NKlaq2mqg+wZ6sH0jDQDzihOHrpGIbnKXCmcwULo0lafqtwwgbX9yBa7EGZ+sgpRk5/s
         6cZ9LmUDwLm7lIWMovO0ILjJHHn6EAYGoGRlSxS5n5x/EuJ7QNL5aCp4fscrE9zCmYNr
         7sQ1PMe+EF2rb2LVq88kGyszxNq4dBzne1CXUeSP8LcSz7xNBHiKIKbzgX91uUNYfJXN
         4U/g==
X-Gm-Message-State: AKS2vOyi5YFPj/Gj3D3St3gP8Zo3nfCaUhiH3iOBhydY4IcH88SJzu4n
        YyHgb8veSudQXw==
X-Received: by 10.84.128.67 with SMTP id 61mr44504046pla.246.1498068986584;
        Wed, 21 Jun 2017 11:16:26 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id 75sm7178171pfk.113.2017.06.21.11.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:16:25 -0700 (PDT)
Message-ID: <1498068974.32360.9.camel@gmail.com>
Subject: [PATCH/FINAL] status: contextually notify user about an initial
 commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org
Date:   Wed, 21 Jun 2017 23:46:14 +0530
In-Reply-To: <87fuet8kbs.fsf@gmail.com>
References: <1498012463.1487.2.camel@gmail.com>
         <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
         <1498055714.20886.1.camel@gmail.com> <87fuet8kbs.fsf@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing message, "Initial commit", makes sense for the commit template
notifying users that it's their initial commit, but is confusing when
merely checking the status of a fresh repository (or orphan branch)
without having any commits yet.

Change the output of "status" to say "No commits yet" when "git
status" is run on a fresh repo (or orphan branch), while retaining the
current "Initial commit" message displayed in the template that's
displayed in the editor when the initial commit is being authored.

Correspondingly change the output of "short status" to "No commits yet
on " when "git status -sb" is run on a fresh repo (or orphan branch).

A few alternatives considered were,

 * Waiting for initial commit
 * Your current branch does not have any commits
 * Current branch waiting for initial commit

The most succint one among the alternatives was chosen.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Change(s): 
 * Added the corresponding change to short status that was
   missing in the previous patch.
 * Fixed broken tests


 Note: This is my last attempt to try sending patches using my
 email client in case this one is also line wrapped, please let
 me so that I could avoid sending through my email-client altogether.

 I'm trying this because I forgot to turn off line wrapping in my 
 email-client while sending previous patches. Hope it works!

 builtin/commit.c  |  1 +
 t/t7501-commit.sh |  2 +-
 t/t7508-status.sh | 30 ++++++++++++++++++++++++++++++
 wt-status.c       |  7 +++++--
 wt-status.h       |  1 +
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..3d614a2ac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1648,6 +1648,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0b6da7ae1..fa61b1a4e 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -18,7 +18,7 @@ test_expect_success 'initial status' '
 	echo bongo bongo >file &&
 	git add file &&
 	git status >actual &&
-	test_i18ngrep "Initial commit" actual
+	test_i18ngrep "No commits yet" actual
 '
 
 test_expect_success 'fail initial amend' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 5edcc6edf..db709048c 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1499,4 +1499,34 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success '"No commits yet" should be noted in status output' '
+	git checkout --orphan empty-branch-1 &&
+	git status >output &&
+	test_i18ngrep "No commits yet" output
+'
+
+test_expect_success '"No commits yet" should not be noted in status output' '
+	git checkout --orphan empty-branch-2 &&
+	test_commit test-commit-1 &&
+	git status >output &&
+	test_i18ngrep ! "No commits yet" output
+'
+
+test_expect_success '"Initial commit" should be noted in commit template' '
+	git checkout --orphan empty-branch-3 &&
+	touch to_be_committed_1 &&
+	git add to_be_committed_1 &&
+	git commit --dry-run >output &&
+	test_i18ngrep "Initial commit" output
+'
+
+test_expect_success '"Initial commit" should not be noted in commit template' '
+	git checkout --orphan empty-branch-4 &&
+	test_commit test-commit-2 &&
+	touch to_be_committed_2 &&
+	git add to_be_committed_2 &&
+	git commit --dry-run >output &&
+	test_i18ngrep ! "Initial commit" output
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 068de38b5..c711ef86e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1578,7 +1578,10 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
@@ -1748,7 +1751,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 #define LABEL(string) (s->no_gettext ? (string) : _(string))
 
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, LABEL(N_("Initial commit on ")));
+		color_fprintf(s->fp, header_color, LABEL(N_("No commits yet on ")));
 
 	if (!strcmp(s->branch, "HEAD")) {
 		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
diff --git a/wt-status.h b/wt-status.h
index 8a3864783..2389f0839 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int commit_template;
 	int show_branch;
 	int hints;
 
-- 
2.11.0
