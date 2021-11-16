Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CEC4167B
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300CC61B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhKPJxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhKPJws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47023C061208
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so10137291wrr.8
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IQqFcygNNGO8TgTlsU7pdOOW17PYUaCsqLVpjC9Nw7w=;
        b=NW5quiKFJQu/ZvSkO0pTmvqPuUE+wun6HyQ7d8IyzMaGEZ1YiLDBN8AZ2/2Jwysrnz
         4vVlm3Vsg31UEkLRAuRljTuACTyBNu1CYWnuL3UbGzz8f4PjS/ft4YJ1gJKtdM9PGPG6
         +Uhs1dhqyOux7spu5ZPCfhMME/nOagUtCqT4eF7aCl4cd/ryWncEJY4VWuuCi+ZRXTmw
         OyVKQWoSUdLBK+cVk/gwgwQpT4ZEIahQWfMz+tCIyjDgQpKL3rwqp/tQsLnl6JALwbZ5
         AGOS6TW4flcO8wLutdE1Ysjgc3dwB6WnjS1kkCZXboFn2M6I2yCFaWrCj9K3bV3+HHHt
         nPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IQqFcygNNGO8TgTlsU7pdOOW17PYUaCsqLVpjC9Nw7w=;
        b=TIdJ7T7NDTR7bamwyHV8w/ssPFE59eK49Q+HVflIDfN2LSnVeOdLS78Mj/QdSp2zGF
         OYF7TyrK4F8H/+SxX1I6KAcm2C4nP+FZD30l9JNdKQX/IeLgSCEQmUO5hop69au3UIHT
         EBITtSNe1muhu+kjb7QGzt+lAA4K9YOMWS2Q5GjrxmMCi3khIUvhdsk8MJJUj/DRqwR2
         30QJLx2keDO/UiTUnQ47mj2e0FMaiw6xqaJkDk6do+rF4aEkFjmK5zx86fzSjHL7aS2C
         uOxGM6tpX1MB1Nv3TggsrW5Bf2LTOXCwNPqLu4gUD/IFNhHORNyV7SM2Q+ZZDMqIaEAC
         dDyg==
X-Gm-Message-State: AOAM530rX9zqHxteiTZXfC/DHjsUttG5vl2MP0Yxjr4Au9gbz8pONKaw
        9m89Tsl4ib+/TYeZJO+vek9hrA/R02A=
X-Google-Smtp-Source: ABdhPJziFcZjSL3gN2ZM0LbrT4WWmtGw8+zW8i3OoFGuIHmqV2z9WbXva3oTOLsnVFcrj/OgwuvLpg==
X-Received: by 2002:adf:ce0e:: with SMTP id p14mr7474233wrn.423.1637056189692;
        Tue, 16 Nov 2021 01:49:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm20365536wrs.59.2021.11.16.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:49 -0800 (PST)
Message-Id: <6ec94134aaf6f6114adc5984722f99acb359ac56.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:36 +0000
Subject: [PATCH v4 13/15] diff --color-moved-ws=allow-indentation-change:
 improve hash lookups
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

As libxdiff does not have a whitespace flag to ignore the indentation
the code for --color-moved-ws=allow-indentation-change uses
XDF_IGNORE_WHITESPACE and then filters out any hash lookups where
there are non-indentation changes. This filtering is inefficient as
we have to perform another string comparison.

By using the offset data that we have already computed to skip the
indentation we can avoid using XDF_IGNORE_WHITESPACE and safely remove
the extra checks which improves the performance by 11% and paves the
way for the elimination of string comparisons in the next commit.

This change slightly increases the run time of other --color-moved
modes. This could be avoided by using different comparison functions
for the different modes but after the next two commits there is no
measurable benefit in doing so.

There is a change in behavior for lines that begin with a form-feed or
vertical-tab character. Since b46054b374 ("xdiff: use
git-compat-util", 2019-04-11) xdiff does not treat '\f' or '\v' as
whitespace characters. This means that lines starting with those
characters are never considered to be blank and never match a line
that does not start with the same character. After this patch a line
matching "^[\f\v\r]*[ \t]*$" is considered to be blank by
--color-moved-ws=allow-indentation-change and lines beginning
"^[\f\v\r]*[ \t]*" can match another line if the suffixes match. This
changes the output of git show for d18f76dccf ("compat/regex: use the
regex engine from gawk for compat", 2010-08-17) as some lines in the
pre-image before a moved block that contain '\f' are now considered
moved as well as they match a blank line before the moved lines in the
post-image. This commit updates one of the tests to reflect this
change.

Test                                                                  HEAD^             HEAD
--------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.33+0.05)   0.38(0.33+0.05)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.86(0.82+0.04)   0.88(0.84+0.04)  +2.3%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.97(0.94+0.03)   0.86(0.81+0.05) -11.3%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16(1.07+0.09)   1.16(1.06+0.09)  +0.0%
4002.5: log --color-moved --no-color-moved-ws                         1.32(1.26+0.06)   1.33(1.27+0.05)  +0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.35(1.29+0.06)   1.33(1.24+0.08)  -1.5%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 65 +++++++++++---------------------------
 t/t4015-diff-whitespace.sh | 22 ++++++-------
 2 files changed, 30 insertions(+), 57 deletions(-)

diff --git a/diff.c b/diff.c
index ffbe09937bc..2085c063675 100644
--- a/diff.c
+++ b/diff.c
@@ -850,28 +850,15 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 }
 
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
-			    const struct emitted_diff_symbol *b,
-			    int *out)
-{
-	int a_len = a->len,
-	    b_len = b->len,
-	    a_off = a->indent_off,
-	    a_width = a->indent_width,
-	    b_off = b->indent_off,
+			    const struct emitted_diff_symbol *b)
+{
+	int a_width = a->indent_width,
 	    b_width = b->indent_width;
 
-	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
-		*out = INDENT_BLANKLINE;
-		return 1;
-	}
-
-	if (a_len - a_off != b_len - b_off ||
-	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
-		return 0;
-
-	*out = a_width - b_width;
+	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
+		return INDENT_BLANKLINE;
 
-	return 1;
+	return a_width - b_width;
 }
 
 static int cmp_in_block_with_wsd(const struct moved_entry *cur,
@@ -916,26 +903,17 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			   const void *keydata)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
-	const struct moved_entry *a, *b;
+	const struct emitted_diff_symbol *a, *b;
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
-	a = container_of(eptr, const struct moved_entry, ent);
-	b = container_of(entry_or_key, const struct moved_entry, ent);
+	a = container_of(eptr, const struct moved_entry, ent)->es;
+	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
 
-	if (diffopt->color_moved_ws_handling &
-	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-		/*
-		 * As there is not specific white space config given,
-		 * we'd need to check for a new block, so ignore all
-		 * white space. The setup of the white space
-		 * configuration for the next block is done else where
-		 */
-		flags |= XDF_IGNORE_WHITESPACE;
-
-	return !xdiff_compare_lines(a->es->line, a->es->len,
-				    b->es->line, b->es->len,
-				    flags);
+	return !xdiff_compare_lines(a->line + a->indent_off,
+				    a->len - a->indent_off,
+				    b->line + b->indent_off,
+				    b->len - b->indent_off, flags);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -944,7 +922,8 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
-	unsigned int hash = xdiff_hash_string(l->line, l->len, flags);
+	unsigned int hash = xdiff_hash_string(l->line + l->indent_off,
+					      l->len - l->indent_off, flags);
 
 	hashmap_entry_init(&ret->ent, hash);
 	ret->es = l;
@@ -1036,13 +1015,11 @@ static void fill_potential_moved_blocks(struct diff_options *o,
 	hashmap_for_each_entry_from(hm, match, ent) {
 		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 		if (o->color_moved_ws_handling &
-		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
-			if (compute_ws_delta(l, match->es, &(pmb[pmb_nr]).wsd))
-				pmb[pmb_nr++].match = match;
-		} else {
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			pmb[pmb_nr].wsd = compute_ws_delta(l, match->es);
+		else
 			pmb[pmb_nr].wsd = 0;
-			pmb[pmb_nr++].match = match;
-		}
+		pmb[pmb_nr++].match = match;
 	}
 
 	*pmb_p = pmb;
@@ -6276,10 +6253,6 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			if (o->color_moved_ws_handling &
-			    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-				o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
-
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
 			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 15782c879d2..50d0cf486be 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2206,10 +2206,10 @@ EMPTY=''
 test_expect_success 'compare mixed whitespace delta across moved blocks' '
 
 	git reset --hard &&
-	tr Q_ "\t " <<-EOF >text.txt &&
-	${EMPTY}
-	____too short without
-	${EMPTY}
+	tr "^|Q_" "\f\v\t " <<-EOF >text.txt &&
+	^__
+	|____too short without
+	^
 	___being grouped across blank line
 	${EMPTY}
 	context
@@ -2228,7 +2228,7 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	git add text.txt &&
 	git commit -m "add text.txt" &&
 
-	tr Q_ "\t " <<-EOF >text.txt &&
+	tr "^|Q_" "\f\v\t " <<-EOF >text.txt &&
 	context
 	lines
 	to
@@ -2239,7 +2239,7 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	${EMPTY}
 	QQtoo short without
 	${EMPTY}
-	Q_______being grouped across blank line
+	^Q_______being grouped across blank line
 	${EMPTY}
 	Q_QThese two lines have had their
 	indentation reduced by four spaces
@@ -2251,16 +2251,16 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 		-c core.whitespace=space-before-tab \
 		diff --color --color-moved --ws-error-highlight=all \
 		--color-moved-ws=allow-indentation-change >actual.raw &&
-	grep -v "index" actual.raw | test_decode_color >actual &&
+	grep -v "index" actual.raw | tr "\f\v" "^|" | test_decode_color >actual &&
 
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
 	<BOLD>--- a/text.txt<RESET>
 	<BOLD>+++ b/text.txt<RESET>
 	<CYAN>@@ -1,16 +1,16 @@<RESET>
-	<BOLD;MAGENTA>-<RESET>
-	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    too short without<RESET>
-	<BOLD;MAGENTA>-<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>^<RESET><BRED>  <RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>|    too short without<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>^<RESET>
 	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>   being grouped across blank line<RESET>
 	<BOLD;MAGENTA>-<RESET>
 	 <RESET>context<RESET>
@@ -2280,7 +2280,7 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	<BOLD;YELLOW>+<RESET>
 	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>too short without<RESET>
 	<BOLD;YELLOW>+<RESET>
-	<BOLD;YELLOW>+<RESET>	<BOLD;YELLOW>       being grouped across blank line<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>^	       being grouped across blank line<RESET>
 	<BOLD;YELLOW>+<RESET>
 	<BOLD;CYAN>+<RESET>	<BRED> <RESET>	<BOLD;CYAN>These two lines have had their<RESET>
 	<BOLD;CYAN>+<RESET><BOLD;CYAN>indentation reduced by four spaces<RESET>
-- 
gitgitgadget

