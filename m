Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D302C7EE37
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFKSRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFKSRR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:17:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB49FB
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:17:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EA2F032001E9;
        Sun, 11 Jun 2023 14:17:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 11 Jun 2023 14:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1686507435; x=1686593835; bh=gtvvA5pJl82a/GnOaWOqxgtVG
        IPouol7cbFF5nKhJ1k=; b=hp3KR1F9y17KUU0hRvd89AH2xex9RcIofeVzPyM4V
        CIsVzMKzlgSDaokdNZrepy+lwpfY6M3kZ1K+nPJrWM+UlakHQN2NC/sWaQO/fv3f
        NCwVif5aZ6WVds65/9KWekKWmYJdL8F8f6iCxcoiBGP3hc6kbD3ocVIeuW3Dg7hP
        9jsIKBdu5RUM6RgGSzE2LcK3UFvLptL9n/uDge75+fJ+SrhnTJarWkm+8cwjzt2b
        4+aos/8QnDpLLJkJJNMYkugzxHEWL8Ux3tPgbvGFgWI/oWZIBCdQ46Rz8OG2eFXM
        AQSAdkTCvKFgLBUZWO7d2rYpqZgW8qbPSMTlHhY6MxOpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686507435; x=1686593835; bh=gtvvA5pJl82a/GnOaWOqxgtVGIPouol7cbF
        F5nKhJ1k=; b=PL2T8auaqI3X4nr61xUun11/i588ruGzIlwrHHfmk1pO89tWa6w
        vcb9iJDiHoa5BHAu2dCJ6TfA5KuE1LQQC1dTwNd5KkKNNZB7A4XNK4L4Nq8rf/Lk
        WzLP0Lwrlm6H0/7D49OK4uFFp1H8FqOTx7Np/L4mdJg2nDUWfFAFs9gmadHssiQQ
        ezG7qPFaLciCAnqAaK5AUnhdcc2adZVUDWMi3OAeLoakznIQ4LcRDhXydOKSQ7uo
        L3IsT23Bl+AsASP+H0wm6Xy2ZMNz3w/42jDCVAtV52aF8vUM3c+mOeBaBbh9MsVL
        Sn4zOGRiFxDMnQlv4K6osST1WNbPi9Ce2OA==
X-ME-Sender: <xms:qw-GZOjSPoGbYqHgZqIGa2REkR5rF4lr2R0OhzVwwuEC6KeKr8bR-S8>
    <xme:qw-GZPBYEl9fk3LPf_pnktCHnw9OaDzes0vyO5Bs98j5hogABzmlRu4Zza4sbHqfu
    BbzgPUosGyx1Xe22g>
X-ME-Received: <xmr:qw-GZGHWVwupS2GiL5W_5Oj54QOUbjAa1jtXmCc2S5dg55OhvMle92unT33tts050mmtUcs9bLab6Z8333UVOx3vOkVaDt7EIJw09R-aH7RhBwOypFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddv
    leegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:qw-GZHTZUMNkbG__PoUeDpDxqAQQKDrSxZpM_HDASymYW9YtWqh9RQ>
    <xmx:qw-GZLyS_hdxJED_9EpvN0U0ent1qKsV7_XyzJEQIqbrxLzuP_j2ow>
    <xmx:qw-GZF7-b71Nj54_V8hTlhYCR5U2L7ZU2pNcIUMqyYjj_LwwLSiD3w>
    <xmx:qw-GZL-RqgVZcbUqR8OKq0qk3S1c8z-Zv_yJDmArFgrK_XWQWv9HGQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jun 2023 14:17:14 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 1/3] range-diff: treat notes like `log`
Date:   Sun, 11 Jun 2023 20:15:54 +0200
Message-ID: <6a4fe606cfae91ac9d0a69fef772bc56a507ef7d.1686505920.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686505920.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name> <cover.1686505920.git.code@khaugsbakk.name>
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
man page for `range diff` under `--[no-]notes[=<ref>]` says:

> This flag is passed to the git log program (see git-log(1)) that
> generates the patches.

This behavior also affects `format-patch` since it uses `range-diff` for
the cover letter. Unlike `log`, though, `format-patch` is not supposed
to show the default notes if no notes-related arguments are given.[1]
But this promise is broken when the range-diff happens to have something
to say about the changes to the default notes, since that will be shown
in the cover letter.

Remedy this by co-opting the `--standard-notes` option which has been
deprecated since ab18b2c0df[2] and which is currently only documented in
`pretty-options`.

† 1: See e.g. 66b2ed09c2 (Fix "log" family not to be too agressive about
    showing notes, 2010-01-20).
† 2: log/pretty-options: Document --[no-]notes and deprecate old notes
    options, 2011-03-30

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 range-diff.c          |  2 +-
 revision.c            |  7 +++++--
 t/t3206-range-diff.sh | 28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 6a704e6f47..2c92af337f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -59,7 +59,7 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--output-indicator-context=#",
 		     "--no-abbrev-commit",
 		     "--pretty=medium",
-		     "--notes",
+		     "--standard-notes",
 		     NULL);
 	strvec_push(&cp.args, range);
 	if (other_arg)
diff --git a/revision.c b/revision.c
index b33cc1d106..a0ab7fb784 100644
--- a/revision.c
+++ b/revision.c
@@ -2524,8 +2524,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		disable_display_notes(&revs->notes_opt, &revs->show_notes);
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--standard-notes")) {
-		revs->show_notes_given = 1;
-		revs->notes_opt.use_default_notes = 1;
+		disable_display_notes(&revs->notes_opt, &revs->show_notes);
+		revs->show_notes_given = 0;
+		enable_default_display_notes(&revs->notes_opt,
+					     &revs->show_notes);
+		revs->notes_opt.use_default_notes = -1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
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
2.41.0

