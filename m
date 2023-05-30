Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CAC7EE29
	for <git@archiver.kernel.org>; Tue, 30 May 2023 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjE3Kn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 06:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjE3KnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 06:43:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D810A
        for <git@vger.kernel.org>; Tue, 30 May 2023 03:43:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0735332009A8;
        Tue, 30 May 2023 06:43:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 06:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685443384; x=1685529784; bh=zI595bwsUrXYP0OA5gM3811g8
        LmNmKetkv2It6CRCyw=; b=vO921ars5dfWp9Ah6R6Qict3pyGj+KIovtOKeqxzL
        XXec6AMpC7b+An68ctwKkkmMuRWeY9vRMDPc1dDl/LVe/tOEh8Zonrm3UtiPfoNB
        ChIFfEKGdcSZRAKSetiRFeimFXs92udG9iOCcKd9Ofa3s1jOnWD5+Y2ZiMsQb9w6
        e/pZc9a3F5GWdb9VvfT4hirtVNAr6vhO7IETqB+PiGDY4hAaW923QZNAzbvhBXMH
        OZnRrP3PkhWwIgqOO6aNn6dQfd8H755PQcXwUZlrm23b2pxhnQe4UDuSM/VzZr1k
        FKY01nwtqCOzqmEdoT/9u1QB+gAUB0xIdwqQxVVAzE1DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685443384; x=1685529784; bh=zI595bwsUrXYP0OA5gM3811g8LmNmKetkv2
        It6CRCyw=; b=dh7N4fHJ5rv5IjT6rgDefmw6815b8qEM6213KzOasy+h8i3AiyT
        cwDcA4xmYVKv8U666n9L7KtDAGCW9QqOje3KYxOJ4Zev+5yspdTGxaAfgaN4DTiy
        Gqun6vC7f9pf1q2OSyi7M1NoehGK7JXw7yRVlH5bVMqjpa/2948GFHdZzsaiD/Gf
        CzDXRyz4too6kniBXLEX/N45vh9mfx9PXMbcGxwtQI/3iDFtklm8T+lOvmgASjrx
        LP2ZqihCoGA2SHyCkWmIR+sWhDkSfyYGqbZvHKCentthm7H5X2JT/nycM0A500s1
        zg4ORN/b8OlQvnzm/8JHVr0wZzgonXgiYKQ==
X-ME-Sender: <xms:ONN1ZKfkZW3581ZxBk_Jw_FOC5ssO3KZZafkqI9we1rDUEVSvNSUUCg>
    <xme:ONN1ZEOBugNhBbPefNOT8jX29IpG8XycCoMWy_Ak8KXg3XRVCe_oqtiO0-VhU3wCh
    UZNBaHbwK37LGmHBQ>
X-ME-Received: <xmr:ONN1ZLiTr2FMshcom92y3jsN3Q8T7XrrEPoZoXks4fTGNh8GYRacX5e1ru4Ch-Jl-JUjoUfnxM3rjWaY7fni_ua3in5f1AXwdl3qMYj2F2r3i51p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ONN1ZH-h_Fi0Uc1WRTysGqyk8Ge-c9m9_P2djTFEsEwUFE1LgOAwcA>
    <xmx:ONN1ZGuhABzp8UJJvw9QahtOpL1-SMKVF1Zp8CEmpJC50WJfjs3nZw>
    <xmx:ONN1ZOF41ZaxM0_bjcBHblfowwZz2FfU6inxIn00ZnIYdfp7e4537Q>
    <xmx:ONN1ZKK5xSQjNZguXgUnTNGmPsqIkwXAuJ_89m1-ZKirypdJV6aktw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:43:03 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [RFC PATCH 1/3] range-diff: treat notes like `log`
Date:   Tue, 30 May 2023 12:41:29 +0200
Message-ID: <8cc8eddfced1b64156008f7f923c430981d472af.1685441207.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <cover.1685441207.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name>
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
2.41.0.rc2

