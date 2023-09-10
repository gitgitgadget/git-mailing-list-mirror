Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085CEE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjIJWHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjIJWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 18:07:11 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC5138
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 15:07:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CC68D5C00D0;
        Sun, 10 Sep 2023 18:07:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 10 Sep 2023 18:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694383626; x=1694470026; bh=a8RwLCV2BXq1BM664JU7okomX
        4IBNSQENFJoBG56U8w=; b=IMahWWnKbgJ4wC1Z9oR1OEPuPK4ZnYGWupmn7/0na
        3o0nLeLD62Q5LV/NxrpBiLopzeznqqrWtkOqzweqhA+HnC7fifJrfEXNhBILdoXW
        6jPmbZ+hivcxOP8Jw3GILPUjLAeIaCeS6UfdHzShyArCXu4g91u5Y0D50BdwE1W6
        WJK4JimVvZRJ5y6x+k+lqIwdb4H/z2AfGNVd0fzW1SIFRoXAUg7Osm89zTu1qCwe
        MjZXSFdv/oPSzq3NNjezeXglFyUvFmuzU8a3aPRl7MtledV9noGU6UdY5MrpmfRA
        93WRwLdJWAke0Z70E3dja3mzWKw5N9cOEg9wPhy5b762g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694383626; x=1694470026; bh=a8RwLCV2BXq1BM664JU7okomX4IBNSQENFJ
        oBG56U8w=; b=toBqoiDuGPnE7uJiTCX87VTRkHADxCGDWiqkvz1DE0MUp7fJ2Wf
        t5pUQrh2dPW0WwCZB2Pa+Qg/+vARll5K3yJttrCm9S0XaOuI0Zz0Bl3Z+8Fm4B/N
        X9V+1VYIcoMwg0HQNGVtTBk5NqTl5N8iWPJ0e0mwCV40U3s8OmyWcPOWi2bMuheA
        EqumbVGJDVPFtt2+qeLQ8U/7+0SWajl/ch/BGTjGVcjXBzIkoDsWZSdxq4Dqj2Gw
        UuoL/h1EC2R+Hu7sPE3XSEZErYPYtCJ/3PFz75ABFAYkAPYTEm8VmyXP4ZXwNyVz
        qXGb6NUqhmHan2VFoq3FahA+2ONlVC9zVrA==
X-ME-Sender: <xms:Cj7-ZDHqfnKUBTGhZbtiNrMCuCI5AN07kmOQ_yAFrdh9XQqt1rWeTNE>
    <xme:Cj7-ZAXZk3Es5eRR76qmzA6k0lzh0hG6sgblbktpkpbaFx9lUtCxM4cQh6SaVuUXl
    HndPg0izw0tEiPdPA>
X-ME-Received: <xmr:Cj7-ZFI96o7yVEmdXxSso66mfwmeIUwkRnRnf7xOrMsdkSscyJQjd6xBNurNzoFvILdV_oL0b6RbqCc6jPqD_sVk7WW38h6pzC23_xV6GWS1-VzroL5aEFJgbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Cj7-ZBE0TzVIVpdKehJuP0JyiZwLP_Cg6xBlpoldFeH49KXRiIKbrg>
    <xmx:Cj7-ZJU1cNWGH0fYXQYzwDKlVvjDNcC7Ob60hDEfDUwqBR2LEPKJPQ>
    <xmx:Cj7-ZMNKLc2m5jnkHP4-j4_qV2Zt6WFuMO89miU4aLcaqTj0tDOOww>
    <xmx:Cj7-ZPzLmt4A2urdFhiD6fwd7VKmDcJya24kU132lUvPUexHIEFGeA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Sep 2023 18:07:04 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 1/1] range-diff: treat notes like `log`
Date:   Mon, 11 Sep 2023 00:06:23 +0200
Message-ID: <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694383247.git.code@khaugsbakk.name>
References: <cover.1693584310.git.code@khaugsbakk.name> <cover.1694383247.git.code@khaugsbakk.name>
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

Remedy this by only conditionally passing in `--notes` to `range-diff`.

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
 range-diff.c          | 13 +++++++++++--
 t/t3206-range-diff.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 2e86063491..fbb81a92cc 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -41,12 +41,20 @@ static int read_patches(const char *range, struct string_list *list,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
 	struct patch_util *util = NULL;
-	int in_header = 1;
+	int i, implicit_notes_arg = 1, in_header = 1;
 	char *line, *current_filename = NULL;
 	ssize_t len;
 	size_t size;
 	int ret = -1;
 
+	for (i = 0; other_arg && i < other_arg->nr; i++)
+		if (!strcmp(other_arg->v[i], "--notes") ||
+		    starts_with(other_arg->v[i], "--notes=") ||
+		    !strcmp(other_arg->v[i], "--no-notes")) {
+			implicit_notes_arg = 0;
+			break;
+		}
+
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
 		     "--no-prefix", "--submodule=short",
@@ -60,8 +68,9 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--output-indicator-context=#",
 		     "--no-abbrev-commit",
 		     "--pretty=medium",
-		     "--notes",
 		     NULL);
+	if (implicit_notes_arg)
+		     strvec_push(&cp.args, "--notes");
 	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
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

