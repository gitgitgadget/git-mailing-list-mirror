Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D762C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089A263223
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhKPJw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhKPJwl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6DEC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y196so16303485wmc.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4TWTb1oFbv2Cyih2NY/IJNJz+zwyZHn49m5PcWSyTQM=;
        b=LMV+og0J+BxW/fq/xzBOKvE7vAz3NaDdx/fiWuuC+4iZD7Nj5q6DXjAHKPf09rEith
         F1y2cx9wy6CnROZuE4wOz0vE67GzgJQiYEVab7OpxLQ4RAOHyyFhVqoEEvd79Z3dAwF1
         7vZ5KmRmBXoU9mh6JMVloNDAecf+CskM+84n7YLzzHIFptWJ6O2KM3iqCXg3BPHjef+X
         xPhaavwYvdG15UTy5WfPJGVzJQIfJ0PMCLAsmDAWBRmfnVcJ11xNTddGhaN+TgQipx54
         XsidEnm0edAFwkYNi9/vxh/9vT/HBqXM5/Nd/kmiRM0GU+0D31tEIo2pe1dB6VwOrRPM
         MJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4TWTb1oFbv2Cyih2NY/IJNJz+zwyZHn49m5PcWSyTQM=;
        b=Ao/Is07L+HjwgIaok6kpGaCk5ds34UlT4tq85vC8QSmoDdp5Eb4HkiRdfhfk4YtIqN
         b/+YsPS/XJwCafMfAfLRYuZDCK8NHD/D0dWrNAFLdOgzuym9v1dZuhr9Dz8DAKbcgJmI
         WBAJaOVvN2KJjfUL+hGLZHlqjHo2RM1nlPfL6oMUhb8K6CWQIzx5U+Fy/HFbQCHWjxaF
         Buj+sd5MFXYCA3t3U1QXjvQ0ceVdpstX3Pn0oKfV1fISACf+7Q2QAz/9Tx2eqlfcXYaj
         JeTyZD6FZLiwv9kWUYPguB8Yk3v04F5iPKxMFilX17GWi1ddSM5EdA765nJBgqEaGw4e
         s8KA==
X-Gm-Message-State: AOAM5317tC8IGGkcFSxd2LQouN4wd9VZvm0R1tdY3osV57vPU7dNXZZN
        V8WSI93BQqKhbgzWmM+x7227KcfIH+U=
X-Google-Smtp-Source: ABdhPJxDZcnl8RuNmW4wEcj7VLt83MWKESvMVEUXdXGtJNOFJMZAbK/DGJkIiGWmUny7p9F5ihoQ/Q==
X-Received: by 2002:a1c:1b48:: with SMTP id b69mr6050481wmb.103.1637056183485;
        Tue, 16 Nov 2021 01:49:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm19111697wre.32.2021.11.16.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:43 -0800 (PST)
Message-Id: <9ca71db61ae92d99fceba112593999596b65cd4c.1637056178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:27 +0000
Subject: [PATCH v4 04/15] diff --color-moved: rewind when discarding pmb
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

diff --color-moved colors the two sides of the diff separately. It
walks through the diff and tries to find matches on the other side of
the diff for the current line. When it finds one or more matches it
starts a "potential moved block" (pmb) and marks the current line as
moved. Then as it walks through the diff it only looks for matches for
the current line in the lines following those in the pmb. When none of
the lines in the pmb match it checks how long the match is and if it
is too short it unmarks the lines as matched and goes back to finding
all the lines that match the current line. As the process of finding
matching lines restarts from the end of the block that was too short
it is possible to miss the start of a matching block on on side but
not the other. In the test added here "-two" would not be colored as
moved but "+two" would be.

Fix this by rewinding the current line when we reach the end of a
block that is too short. This is quadratic in the length of the
discarded block. While the discarded blocks are quite short on a large
diff this still has a significant impact on the performance of
--color-moved-ws=allow-indentation-change. The following commits
optimize the performance of the --color-moved machinery which
mitigates the performance impact of this commit. After the
optimization this commit has a negligible impact on performance.

Test                                                                  HEAD^               HEAD
-----------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)    0.39 (0.34+0.04)  +2.6%
4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.76+0.03)    0.86 (0.82+0.04)  +7.5%
4002.3: diff --color-moved-ws=allow-indentation-change large change  14.22(14.17+0.04)   19.01(18.93+0.05) +33.7%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16 (1.06+0.09)    1.16 (1.07+0.07)  +0.0%
4002.5: log --color-moved --no-color-moved-ws                         1.31 (1.22+0.09)    1.32 (1.22+0.09)  +0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.61+0.09)    1.72 (1.63+0.08)  +0.6%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 28 ++++++++++++++++++-----
 t/t4015-diff-whitespace.sh | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 09af94e018c..1e1b5127d15 100644
--- a/diff.c
+++ b/diff.c
@@ -1205,7 +1205,15 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (!match) {
 			int i;
 
-			adjust_last_block(o, n, block_length);
+			if (!adjust_last_block(o, n, block_length) &&
+			    block_length > 1) {
+				/*
+				 * Rewind in case there is another match
+				 * starting at the second line of the block
+				 */
+				match = NULL;
+				n -= block_length;
+			}
 			for(i = 0; i < pmb_nr; i++)
 				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
@@ -1230,10 +1238,20 @@ static void mark_color_as_moved(struct diff_options *o,
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
 		if (pmb_nr == 0) {
-			fill_potential_moved_blocks(
-				o, hm, match, l, &pmb, &pmb_alloc, &pmb_nr);
-			if (adjust_last_block(o, n, block_length) &&
-			    pmb_nr && last_symbol != l->s)
+			int contiguous = adjust_last_block(o, n, block_length);
+
+			if (!contiguous && block_length > 1)
+				/*
+				 * Rewind in case there is another match
+				 * starting at the second line of the block
+				 */
+				n -= block_length;
+			else
+				fill_potential_moved_blocks(o, hm, match, l,
+							    &pmb, &pmb_alloc,
+							    &pmb_nr);
+
+			if (contiguous && pmb_nr && last_symbol != l->s)
 				flipped_block = (flipped_block + 1) % 2;
 			else
 				flipped_block = 0;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2c13b62d3c6..308dc136596 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1833,6 +1833,52 @@ test_expect_success '--color-moved treats adjacent blocks as separate for MIN_AL
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved rewinds for MIN_ALNUM_COUNT' '
+	git reset --hard &&
+	test_write_lines >file \
+		A B C one two three four five six seven D E F G H I J &&
+	git add file &&
+	test_write_lines >file \
+		one two A B C D E F G H I J two three four five six seven &&
+	git diff --color-moved=zebra -- file &&
+
+	git diff --color-moved=zebra --color -- file >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/file b/file<RESET>
+	<BOLD>--- a/file<RESET>
+	<BOLD>+++ b/file<RESET>
+	<CYAN>@@ -1,13 +1,8 @@<RESET>
+	<GREEN>+<RESET><GREEN>one<RESET>
+	<GREEN>+<RESET><GREEN>two<RESET>
+	 A<RESET>
+	 B<RESET>
+	 C<RESET>
+	<RED>-one<RESET>
+	<BOLD;MAGENTA>-two<RESET>
+	<BOLD;MAGENTA>-three<RESET>
+	<BOLD;MAGENTA>-four<RESET>
+	<BOLD;MAGENTA>-five<RESET>
+	<BOLD;MAGENTA>-six<RESET>
+	<BOLD;MAGENTA>-seven<RESET>
+	 D<RESET>
+	 E<RESET>
+	 F<RESET>
+	<CYAN>@@ -15,3 +10,9 @@<RESET> <RESET>G<RESET>
+	 H<RESET>
+	 I<RESET>
+	 J<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>two<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>three<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>four<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>five<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>six<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>seven<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
-- 
gitgitgadget

