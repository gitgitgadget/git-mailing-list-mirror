Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A6CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 20:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjISU1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjISU1c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 16:27:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F2BA
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 13:27:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A7B4B320094C;
        Tue, 19 Sep 2023 16:27:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 19 Sep 2023 16:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1695155245; x=1695241645; bh=qJQE/WIKciBP9YjPUvzmMBfMu
        7BE8HwIoVd3+5A+Br8=; b=Vt2vjOAutYuRkgJvJ9X+5ldwRemAxfV9SNDODUz1O
        AehTQA/mqIL4A4Qg7zXPZlYtce8mAFBVx/KSjm5U/aNi2IRHKAVySMY4fPjoJP/a
        T5qq2TJrg5mdBGcF0+LApP5r2yzStKz5UjsmNmzNiA42MjfVhoDnjtuGoAvLdXvE
        HjJbtuHmhsZgdSMTx67LduDtyaCUPvZuUIG+2JwfnPUKNIVakNSX0mZuH9N2AONH
        K6JIbmEks2aYL0oWwjsCTt9cNn+5m0GOVuoZoOmeVMIcX+TKdV/b+BVkiC3wOESb
        hdnbNVMGn7iqzJiTrOquhmTkOYU1rYSVvPaUnrIlMGg5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695155245; x=1695241645; bh=qJQE/WIKciBP9YjPUvzmMBfMu7BE8HwIoVd
        3+5A+Br8=; b=Z3Sa/i8vb7A4WpIvGLApXlQgLbkZRplfl4zn9QssbK4c350uZ3n
        2Ieyl25xLxXIUHInTNpxRurde2T9VNRISsurNNUGoVRDm6l8EPZPxQzznVKjsjgw
        TGvxgIE6w6rncCb0zuLlvHYHP0+IpgJLwZHCH5HsUNMhm5eZsDvk3OqwSH78hlse
        124bZK6KZ8vzxj5HQ9U+Re8fPszMhQo9lyvGOfulwY/nJ9kHKwekLJnvEGdZ4C7Y
        I0gOCDaUZSCVv7iV5LzSuxl0Vyu8GA/8gtzBAlnasIjqi64JSdKwASHs4cEstnpD
        mnSSW5L/zHHOcJzg/JOuzgKN1cm081anY0A==
X-ME-Sender: <xms:LQQKZdZmzZ5WRKONELr2Uf5pD4ydjH01j2RmJovksDPzStVUyLoctY8>
    <xme:LQQKZUYpF9GHWinCI5AmudchF9crrtJfqcZtbsnofPQ8Rwy3CPir9C2iRgTak0ZZg
    DiauwWa-gfASgiXsQ>
X-ME-Received: <xmr:LQQKZf_O2Y1ybNyJCiBI8w17Bo6c2bEGK8qNFBY6uFSxbIjfcpeXYvVFwQmUXh4pvwc55CkHEr5hUm6QxcAYlZX49irI2sSg7nZ9RQ9UJLHXJuBD2N79BmqUGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddv
    leegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:LQQKZbqorU8n_ToND_saZ-mdCmMMjeIn_jmVwNAhLTQuG4v7H67TmQ>
    <xmx:LQQKZYq3QwZPrvNWs3rGrtAKyL694tvNIvxW8edjgPdbKQr_M2oleA>
    <xmx:LQQKZRS-2eGD7rLSgwk6OGorauDN-ryway9MktJrnVLpd6AO_XSvsw>
    <xmx:LQQKZRk-qgYYXihjnPqFUGCJXuwq4AmIgHiuyiYuGbDFmhtTA8UNiQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 16:27:23 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 1/1] range-diff: treat notes like `log`
Date:   Tue, 19 Sep 2023 22:26:50 +0200
Message-ID: <6e114271a2e7d2323193bd58bb307f60101942ce.1695154855.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695154855.git.code@khaugsbakk.name>
References: <cover.1695144790.git.code@khaugsbakk.name> <cover.1695154855.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `range-diff` shows the default notes if no notes-related
arguments are given. This is also how `log` behaves. But unlike
`range-diff`, `log` does *not* show the default notes if
`--notes=<custom>` are given. In other words, this:

    git log --notes=custom

is equivalent to this:

    git log --no-notes --notes=custom

While:

    git range-diff --notes=custom

acts like this:

    git log --notes --notes-custom

This can’t be how the user expects `range-diff` to behave given that the
man page for `range-diff` under `--[no-]notes[=<ref>]` says:

> This flag is passed to the `git log` program (see git-log(1)) that
> generates the patches.

This behavior also affects `format-patch` since it uses `range-diff` for
the cover letter. Unlike `log`, though, `format-patch` is not supposed
to show the default notes if no notes-related arguments are given.[1]
But this promise is broken when the range-diff happens to have something
to say about the changes to the default notes, since that will be shown
in the cover letter.

Remedy this by introducing `--show-notes-by-default` that `range-diff` can
use to tell the `log` subprocess what to do.

§ Authors

• Fix by Johannes
• Tests by Kristoffer

† 1: See e.g. 66b2ed09c2 (Fix "log" family not to be too agressive about
    showing notes, 2010-01-20).

Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/pretty-options.txt |  4 ++++
 range-diff.c                     |  2 +-
 revision.c                       |  7 +++++++
 revision.h                       |  1 +
 t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index dc685be363a..335395b727f 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -87,6 +87,10 @@ being displayed. Examples: "--notes=foo" will show only notes from
 	"--notes --notes=foo --no-notes --notes=bar" will only show notes
 	from "refs/notes/bar".
 
+--show-notes-by-default::
+	Show the default notes unless options for displaying specific
+	notes are given.
+
 --show-notes[=<ref>]::
 --[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
diff --git a/range-diff.c b/range-diff.c
index ca5493984a5..c45b6d849cb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -60,7 +60,7 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--output-indicator-context=#",
 		     "--no-abbrev-commit",
 		     "--pretty=medium",
-		     "--notes",
+		     "--show-notes-by-default",
 		     NULL);
 	strvec_push(&cp.args, range);
 	if (other_arg)
diff --git a/revision.c b/revision.c
index 2f4c53ea207..49d385257ac 100644
--- a/revision.c
+++ b/revision.c
@@ -2484,6 +2484,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->break_bar = xstrdup(optarg);
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
+	} else if (!strcmp(arg, "--show-notes-by-default")) {
+		revs->show_notes_by_default = 1;
 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
 		   skip_prefix(arg, "--notes=", &optarg)) {
 		if (starts_with(arg, "--show-notes=") &&
@@ -3054,6 +3056,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 
+	if (!revs->show_notes_given && revs->show_notes_by_default) {
+		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
+		revs->show_notes_given = 1;
+	}
+
 	return left;
 }
 
diff --git a/revision.h b/revision.h
index 82ab400139d..50091bbd13f 100644
--- a/revision.h
+++ b/revision.h
@@ -253,6 +253,7 @@ struct rev_info {
 			shown_dashes:1,
 			show_merge:1,
 			show_notes_given:1,
+			show_notes_by_default:1,
 			show_signature:1,
 			pretty_given:1,
 			abbrev_commit:1,
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index b5f4d6a6530..b33afa1c6aa 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -662,6 +662,20 @@ test_expect_success 'range-diff with multiple --notes' '
 	test_cmp expect actual
 '
 
+# `range-diff` should act like `log` with regards to notes
+test_expect_success 'range-diff with --notes=custom does not show default notes' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	git notes --ref=custom add -m "topic note" topic &&
+	git notes --ref=custom add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	test_when_finished git notes --ref=custom remove topic unmodified &&
+	git range-diff --notes=custom main..topic main..unmodified \
+		>actual &&
+	! grep "## Notes ##" actual &&
+	grep "## Notes (custom) ##" actual
+'
+
 test_expect_success 'format-patch --range-diff does not compare notes by default' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
@@ -679,6 +693,20 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 	! grep "note" 0000-*
 '
 
+test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
+	git notes add -m "topic note" topic &&
+	git notes --ref=custom add -m "topic note (custom)" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	test_when_finished git notes --ref=custom remove topic unmodified &&
+	git format-patch --notes=custom --cover-letter --range-diff=$prev \
+		main..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	grep "## Notes (custom) ##" 0000-* &&
+	! grep "## Notes ##" 0000-*
+'
+
 test_expect_success 'format-patch --range-diff with --no-notes' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-- 
2.42.0

