Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EDCE79AA
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 18:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjISSGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjISSGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 14:06:19 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A697BC
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:06:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0142E320069B;
        Tue, 19 Sep 2023 14:06:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 19 Sep 2023 14:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1695146770; x=1695233170; bh=h2EiliZuIjb6TFRKCZZOy89DE
        celXtI5sy0HAkLJSqc=; b=oX0S94SiWZ66LQIQ3YujkjOO61k6JTq0+gcALM7eC
        +BGUZMp68KC3yE7vu8bR6HJcUTJs0yNvedRBnGH1I4tjTFkH5w1RVOhaXryXc47V
        JkGf7oYpuf2DmFyPh1Stx0lFx0i7IRdp62ZNlC0ehYvsbMVOxh47F1jo6+eYF6ik
        s9GWUL3taz167k5ks3jEq+QvDlClkBO6J37Q3KOQZak4KvxsYUzfgiTFRmXLfboA
        Y8jaja/6nCTYjwcuXVW7T/L2cJJ9Znxi1PxI1r7ZtDeWicptcVwwB1YMe4aVRd/v
        3y+0/C4QZw7XGT8bChZor1rqqHlvSDNTZdiOVyscJB7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695146770; x=1695233170; bh=h2EiliZuIjb6TFRKCZZOy89DEcelXtI5sy0
        HAkLJSqc=; b=duDYrUXgFFceDjipebIoGQMBFOLa9itrx6nxljNeBCyhEyukDCF
        gOnlhpwp23CkaH+wfmDA25D76F3oWXkQC5S44ZTBE7OsesekRGogN/+gtA9xBZpW
        jg4d+RbrEJDJTUMa7ZuUN82ewfXloAq7drj/dfs6LDM6PpwBuM5HbnjBbONY3FoJ
        9U7Oy+/cCoVjmSFzcgJ4x+9f+NDid6MgK7gKAQk2PCe03ZU2nEU1sWIeQRmj7Vqa
        lQBS9GSpKS4EcAav4Xvjkl8srGPvooDYGgqKAn2SWNlC+o9XjjR8/qYRQgjEIVgu
        jNu4+JrgFafN2EoXYnTspIIJvP4ceN7lrdg==
X-ME-Sender: <xms:EuMJZbwUWdDdSzMAhHHsJcwsO2gcR2s6-8kuDPjO48G530gHKFRpVOc>
    <xme:EuMJZTTY1CuCGVAjEoR58iGtRmwMNffGMEx5EpYUIUD8Uz6Y5kWhbLtn8ugP4F_VM
    3ISfxGBdv602fABiA>
X-ME-Received: <xmr:EuMJZVUeL0N_VXNgd2IsqDCPuEFky-9dxi19WaTtWsYKOndjMmyzpiy8iZl4MHxbZsQVM3bzwJKszPgWr5eyMlKmabWJbM1JzgTRv3Hjng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:EuMJZVi0j-GPseqIznPYTRTTwS0N-kePlat_9xin6ZZhrpmg0DS4CA>
    <xmx:EuMJZdCdmvPDdmkuJy4kPEvvjp1PvB_DRwrqhd_PyHXzHIfY68KVaA>
    <xmx:EuMJZeKtRP8A2yGef2oA8fuMNvg0hRuo_j9rm6Nxr_WBWfhOETSfsA>
    <xmx:EuMJZY9NRDd0YNKe_xo-7T-sb-JSIJWiLfb2bxCRgz9nyGEsN3Brsg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 14:06:08 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 1/1] range-diff: treat notes like `log`
Date:   Tue, 19 Sep 2023 20:05:32 +0200
Message-ID: <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695144790.git.code@khaugsbakk.name>
References: <cover.1694383247.git.code@khaugsbakk.name> <cover.1695144790.git.code@khaugsbakk.name>
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

§ Root cause

8cf51561d1e (range-diff: fix a crash in parsing git-log output,
2020-04-15) added `--notes` in order to deal with a side-effect of
`--pretty=medium`:

> To fix this explicitly set the output format of the internally executed
> `git log` with `--pretty=medium`. Because that cancels `--notes`, add
> explicitly `--notes` at the end.

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
index dc685be363..dcd501ee50 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -59,6 +59,10 @@ message by 4 spaces (i.e.  'medium', which is the default, 'full',
 and 'fuller').
 
 ifndef::git-rev-list[]
+--show-notes-by-default::
+	Show the default notes (see `--notes`) unless subsequent arguments
+	are used to display specific notes.
+
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
diff --git a/range-diff.c b/range-diff.c
index 2e86063491..56f6870ff9 100644
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
index 2f4c53ea20..49d385257a 100644
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
index 82ab400139..50091bbd13 100644
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
index b5f4d6a653..b33afa1c6a 100755
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

