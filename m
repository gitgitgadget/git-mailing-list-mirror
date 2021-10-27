Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B609610A3
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbhJ0MHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbhJ0MG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E0C061224
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v127so2367294wme.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=63o3P4q1ZFH6Z3d6V3ABrwdZeiLXPkyAw8esWLYB2Wc=;
        b=qXjttTT8x2fu0YX7Zyh5LECrRuVPY8qIN9LvMg/euOU6NLXScCzUsSpU0sBn4Xo3Lu
         dY0zaCJdM1tDv+U0sUlx7RQpF9KiJkRMvYy4IA3xBNAtoDANAYLG+KkPgGmXJBKdt0/y
         gjU93KcuRdfJqTGbQ2WITHXTTT8SJb1xLnM6uZzNsyTcIyQ+7SCIwBrnNyekONkyDsTr
         8e3Ume9DKj1jDODXPQn4Jx/mgx5CUL+YYJPXcvGPJB8Vbd+IVi4V6BjkavG/+S1Hhhc9
         pSqGpVG/oD2YAtBAlyo8pUX1aitN2btNhbYJF3EtpaSJLJ+uxrJMjZ60GpCAnB2Gh5Eg
         nlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=63o3P4q1ZFH6Z3d6V3ABrwdZeiLXPkyAw8esWLYB2Wc=;
        b=t5fPyAo9AAVCcj3VADPdmFJQ20+cmvfMveE/AK7bhYGqDiHcfjdnIKN3Dz1eXBjIRN
         5MOFAV9ceIyOqDRXrWWn/iAdlR7ZPyliS8cReGvG5jn8n6GMVIowuvjcoF3tEaklIwGf
         9daTLbtej9cGpFcqUGqwZVFB72UCosVwi2Ol+aVnq8OQ42/6+MA659DGt5HwgW68RMZ6
         8EfUSfH/74Pig9tm369gJxz0t/3Uep8GbJNH+c6kdfObh1AHQQ56OJvWxcuc7VN6L/SB
         D7j5tuLympkWn/NwVxKkaTPFgiBgpG4qHrzQJHsBnhpJdjAeWp8z37A1XE7CccvIHC+I
         kkXQ==
X-Gm-Message-State: AOAM5309gsbE2c8F6J1MqEe01xcrQaf0WKCvhKkk6ZEvunWAptzb/Nd6
        TZwQuGs63+PETqZ/6fZjXzeHwqqx3kk=
X-Google-Smtp-Source: ABdhPJxmQAWEp0PHLrYjMKt7JmpM1Reoo53YoQatYY4UG9OsUEvgnX4MvGtkddgMznUHrgEDnkP5mA==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr5382711wmj.91.1635336269699;
        Wed, 27 Oct 2021 05:04:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm511363wrv.4.2021.10.27.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:29 -0700 (PDT)
Message-Id: <2717ff500d2ebf82179f89c90d690718221e9fa8.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:13 +0000
Subject: [PATCH v3 06/15] diff --color-moved: avoid false short line matches
 and bad zerba coloring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When marking moved lines it is possible for a block of potential
matched lines to extend past a change in sign when there is a sequence
of added lines whose text matches the text of a sequence of deleted
and added lines. Most of the time either `match` will be NULL or
`pmb_advance_or_null()` will fail when the loop encounters a change of
sign but there are corner cases where `match` is non-NULL and
`pmb_advance_or_null()` successfully advances the moved block despite
the change in sign.

One consequence of this is highlighting a short line as moved when it
should not be. For example

-moved line  # Correctly highlighted as moved
+short line  # Wrongly highlighted as moved
 context
+moved line  # Correctly highlighted as moved
+short line
 context
-short line

The other consequence is coloring a moved addition following a moved
deletion in the wrong color. In the example below the first "+moved
line 3" should be highlighted as newMoved not newMovedAlternate.

-moved line 1 # Correctly highlighted as oldMoved
-moved line 2 # Correctly highlighted as oldMovedAlternate
+moved line 3 # Wrongly highlighted as newMovedAlternate
 context      # Everything else is highlighted correctly
+moved line 2
+moved line 3
 context
+moved line 1
-moved line 3

These false matches are more likely when using --color-moved-ws with
the exception of --color-moved-ws=allow-indentation-change which ties
the sign of the current whitespace delta to the sign of the line to
avoid this problem. The fix is to check that the sign of the new line
being matched is the same as the sign of the line that started the
block of potential matches.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 17 ++++++----
 t/t4015-diff-whitespace.sh | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 53f0df75329..efba2789354 100644
--- a/diff.c
+++ b/diff.c
@@ -1176,7 +1176,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
 	int n, flipped_block = 0, block_length = 0;
-	enum diff_symbol last_symbol = 0;
+	enum diff_symbol moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
@@ -1202,7 +1202,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			flipped_block = 0;
 		}
 
-		if (!match) {
+		if (pmb_nr && (!match || l->s != moved_symbol)) {
 			int i;
 
 			if (!adjust_last_block(o, n, block_length) &&
@@ -1219,12 +1219,13 @@ static void mark_color_as_moved(struct diff_options *o,
 			pmb_nr = 0;
 			block_length = 0;
 			flipped_block = 0;
-			last_symbol = l->s;
+		}
+		if (!match) {
+			moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
 			continue;
 		}
 
 		if (o->color_moved == COLOR_MOVED_PLAIN) {
-			last_symbol = l->s;
 			l->flags |= DIFF_SYMBOL_MOVED_LINE;
 			continue;
 		}
@@ -1251,11 +1252,16 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb, &pmb_alloc,
 							    &pmb_nr);
 
-			if (contiguous && pmb_nr && last_symbol == l->s)
+			if (contiguous && pmb_nr && moved_symbol == l->s)
 				flipped_block = (flipped_block + 1) % 2;
 			else
 				flipped_block = 0;
 
+			if (pmb_nr)
+				moved_symbol = l->s;
+			else
+				moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
+
 			block_length = 0;
 		}
 
@@ -1265,7 +1271,6 @@ static void mark_color_as_moved(struct diff_options *o,
 			if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
 				l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 		}
-		last_symbol = l->s;
 	}
 	adjust_last_block(o, n, block_length);
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 4e0fd76c6c5..15782c879d2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1514,6 +1514,71 @@ test_expect_success 'zebra alternate color is only used when necessary' '
 	test_cmp expected actual
 '
 
+test_expect_success 'short lines of opposite sign do not get marked as moved' '
+	cat >old.txt <<-\EOF &&
+	this line should be marked as moved
+	unchanged
+	unchanged
+	unchanged
+	unchanged
+	too short
+	this line should be marked as oldMoved newMoved
+	this line should be marked as oldMovedAlternate newMoved
+	unchanged 1
+	unchanged 2
+	unchanged 3
+	unchanged 4
+	this line should be marked as oldMoved newMoved/newMovedAlternate
+	EOF
+	cat >new.txt <<-\EOF &&
+	too short
+	unchanged
+	unchanged
+	this line should be marked as moved
+	too short
+	unchanged
+	unchanged
+	this line should be marked as oldMoved newMoved/newMovedAlternate
+	unchanged 1
+	unchanged 2
+	this line should be marked as oldMovedAlternate newMoved
+	this line should be marked as oldMoved newMoved/newMovedAlternate
+	unchanged 3
+	this line should be marked as oldMoved newMoved
+	unchanged 4
+	EOF
+	test_expect_code 1 git diff --no-index --color --color-moved=zebra \
+		old.txt new.txt >output && cat output &&
+	grep -v index output | test_decode_color >actual &&
+	cat >expect <<-\EOF &&
+	<BOLD>diff --git a/old.txt b/new.txt<RESET>
+	<BOLD>--- a/old.txt<RESET>
+	<BOLD>+++ b/new.txt<RESET>
+	<CYAN>@@ -1,13 +1,15 @@<RESET>
+	<BOLD;MAGENTA>-this line should be marked as moved<RESET>
+	<GREEN>+<RESET><GREEN>too short<RESET>
+	 unchanged<RESET>
+	 unchanged<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as moved<RESET>
+	<GREEN>+<RESET><GREEN>too short<RESET>
+	 unchanged<RESET>
+	 unchanged<RESET>
+	<RED>-too short<RESET>
+	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved<RESET>
+	<BOLD;BLUE>-this line should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
+	 unchanged 1<RESET>
+	 unchanged 2<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
+	 unchanged 3<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved newMoved<RESET>
+	 unchanged 4<RESET>
+	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMoved "magenta" &&
 	test_config color.diff.newMoved "cyan" &&
-- 
gitgitgadget

