Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A1CCA0FE4
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbjIAQUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjIAQUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:20:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368DE7E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:20:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6953A5C01A9;
        Fri,  1 Sep 2023 12:20:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Sep 2023 12:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1693585234; x=1693671634; bh=J/Ond6t+3UF/y7cn+UcZ/6FNR
        zJOnH/O/yzPscbOMd4=; b=TJEc+s4nsYiOQqPiL9WQ2AOYNyOUjFYxzH3YYj0RH
        3+iaVSzwx9f9eADSpSS5KzAVe0rmZDXaJQE8IhLMyqvfX/PeSQXRS/TZQS7JgOG5
        PihoyIuRUAG/ADUv89x1iLwQmNloPlh5M0/XR32cknCJjMJ0o63AsYYXGVskOwz+
        RdELQ3qXqgBdobPQPwlUdZNUGoxnzpTwoz/ETzKRw6Ngftj9pwbTpS6vDuoz2m4V
        6PazP34/D7MMdvDEI7k3NmtGt1GkgYQDZCP4rPD8LXbEogKeP1oehgONZlscDV0/
        YKGqzZUBeObMNmyeCEfhk9i0z1Ck4fG6iaj1kU4Z8cJhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693585234; x=1693671634; bh=J/Ond6t+3UF/y7cn+UcZ/6FNRzJOnH/O/yz
        PscbOMd4=; b=Tv9ErCg35rglh+mnWy+8QTNrSjVUSHUjL0e6saPY/Owa7TcEomf
        Luixtda0xqj9dhVii4K/n+D6lmOaYQBlVa8XC9jLdln1fqSZBvXBaPfEZq3/gt+O
        MWgCwepso8LxRFklqHUXrjQJ0+hjtV2C8Ijh8fpqOlgtKQ0ZTXxBx00rATp8NgI2
        OezrSOLQJWzXCXraDrU0S3ggiYQvp96i0Fty1huuORaU1WkCF0br8XLlKf4M7B3B
        Mzh3EoT3aBHLwH6GLSYB6aJE7krp4MFpAUE3r2daT4wapQEBAeYJputDxKZptW4K
        1f5NbiscJrqNhm7Rxg0lhsl6x/u3TZsAWVg==
X-ME-Sender: <xms:Ug_yZIm2aaJvTLNxjh_zzxiUf2qURsF3N9BvRWyvVQIXCCMXJgqVjvg>
    <xme:Ug_yZH3qQ32gqUI_5yNQTLmuZKN9wDr5YCkuHRkQFZ1bkSTUwXn0vyk2VcUCWvoml
    Vd5eplHQLlz2QQTaA>
X-ME-Received: <xmr:Ug_yZGp9M-N99NsZ8FAYp-12hhmOSEsq-400Ble4Zrilsaguh9TBkUxdvFi-0UmVowawLoBiwVjgk6EDRZLirJBrnpiW0Nydwj6entvIwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Ug_yZEkONc6xx_GHVLke-OWoHQ4lGd88dNltvK5i9uFXAKadpEeVJA>
    <xmx:Ug_yZG1v_Cwxxzt5cI7pHFSkvC8DWEctMnn570-DdvwnC2mJOFZyaA>
    <xmx:Ug_yZLv7-bI2wzLLARuqSTgWdx3xA5x3RzAH26xeiybkMU81jrZLkQ>
    <xmx:Ug_yZLz9QcIc58dIKAKBHfhSXyI8yN3X_Np_ma_rpdOrVDMAdEGG5Q>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Sep 2023 12:20:33 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 1/3] range-diff: treat notes like `log`
Date:   Fri,  1 Sep 2023 18:19:00 +0200
Message-ID: <e9a59108311369d8197b9870a8810d5283ec124f.1693584310.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693584310.git.code@khaugsbakk.name>
References: <cover.1686505920.git.code@khaugsbakk.name> <cover.1693584310.git.code@khaugsbakk.name>
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
index 2e86063491..f070e4a4ce 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -60,7 +60,7 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--output-indicator-context=#",
 		     "--no-abbrev-commit",
 		     "--pretty=medium",
-		     "--notes",
+		     "--standard-notes",
 		     NULL);
 	strvec_push(&cp.args, range);
 	if (other_arg)
diff --git a/revision.c b/revision.c
index 2f4c53ea20..64aebc014b 100644
--- a/revision.c
+++ b/revision.c
@@ -2495,8 +2495,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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

