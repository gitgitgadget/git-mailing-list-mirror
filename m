Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02972C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E405661B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhKPJxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhKPJwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:43 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE38C061767
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so1890704wmz.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=63o3P4q1ZFH6Z3d6V3ABrwdZeiLXPkyAw8esWLYB2Wc=;
        b=C4R6nUb4DF6LdSPLsW8rl/G8ooIFEorTBiIfOfAmpHrFPL7AXCJzRdjuEv5R5m9Yaw
         l4bRO8F7GL5Tzju20jzNlSto1ndAdHuJbGeh6c1w5pyOLuqfDRIEOmphydu/7fT9ARp2
         YQnjBKMoC1YytXOQeXlkRWWL2ucTf55F9zR6ND0fNvsf0SjhaGLOCqYR0946PGjE67ip
         aE/S/tshw72/UBMGvcaQbv0+YXTOjU84656PFaDauu1f1ekU6wjC52uKMXTsXYfymQ9O
         2rHJBNTs/tWCwXYxkHRf+iVXrLz1CpsdhEecbV5zZ9UAonsgpQ9ZDx4n1Ia1TXj282sj
         J5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=63o3P4q1ZFH6Z3d6V3ABrwdZeiLXPkyAw8esWLYB2Wc=;
        b=i/ali8+ECCQOfhdfeF8tfSIyag7wWs8BpcBeTjcIVBQT2yDzWLYgD8tScqBzVXFby6
         8zYrHJgKyFnkjXJO9nJkpm94rvMdvKcW2PzEgm1UXPN2a+zbdRg/uXvlakE2SDPTPT1Y
         h7Mlir1Ea4qPNxfj/0I1lZKwZqf5kTb2e48ncJh+XIlUqynu9E7N2fwqFRr8bl0sq54/
         hvsWC6n4NHGqan0LKRajGQQqNdrZJazbA81xjb7ra/n7Fj3DvYJImRi4r1E9yTN1Kdj4
         NkSoV22TA5FjitfaciYFC9KbDdjpPNJdq3VnqDvPSI2T60pYy662wR4Hk1OAIa0lEGQb
         Vngg==
X-Gm-Message-State: AOAM532dGuGqpOfzqAxksjUP+8zfBXYBpdHaTVNWvaMsaSqwolQ/6Pwf
        RgZNmmVvNQOoKJGYYd9TJKYUu97wyoM=
X-Google-Smtp-Source: ABdhPJzK3ZbVvbfV9VJFwhNdWFTCiBAzyk+kJ3VLLb7r5tDNJKn/rLtp5nlENbnB728xOhbpvZX16A==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr67995856wmi.145.1637056184910;
        Tue, 16 Nov 2021 01:49:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p62sm1873911wmp.10.2021.11.16.01.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:44 -0800 (PST)
Message-Id: <10b11526206d3b515ba08ac80ccf09ecb7a03420.1637056178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:29 +0000
Subject: [PATCH v4 06/15] diff --color-moved: avoid false short line matches
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

