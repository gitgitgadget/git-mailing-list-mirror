Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E705BC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhLIKeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhLIKd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD2C061A32
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t18so8796944wrg.11
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IQqFcygNNGO8TgTlsU7pdOOW17PYUaCsqLVpjC9Nw7w=;
        b=Q3A8AGMtAjEwLa6j0KXpth+PizSggT5CKX6FoR/XeCKhyp7gp8hgjoeZLadkF4lmAu
         bQQti262MDGo/ZnXvLydQtsAw1oUVw+Uaxupe7e8Pylx8jpKxWL9xTu3xCq7LOOfm9Ut
         YdMAs//xVbd5kslgF2vXvb7hpRJfKldMpkeL6vIeXr27fQjrkzSFJ1SRz+1kO2VyahVy
         HHZwrQbsFzJR3knrn9lPhaCQM67AF8g+Fs7y8Q+2NLp+veXMhjlEZiximOJsul2JJx/O
         3b1FXUlbPjocIFW7lMDjWauOPos++A0mDGf7EY2DxZZapkeX4sU769vB8E65FxEck/w4
         hluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IQqFcygNNGO8TgTlsU7pdOOW17PYUaCsqLVpjC9Nw7w=;
        b=aBpERic3oaX7eawtg9uz90fOKUOv+DEeFTmt8T+wzlox1IJt2SqlHHe5hryOlb2zMy
         Y0KRoo27KdA+KLxc0/JFaNwfLjbqiiv1dETDyykMMZjxMsmuSUwryGLw9K1JSCaFR5MN
         ZBv8groMSu+vQeRMUb7g0847OFLIvPCxy/3bb4Q6SqPf251ONfwZt6zoiIxV17Tjjzhn
         oBGgzRoqemSzZLwHQ/TBv974ecrMs+BCJsq5qy9B8kqNDN3MPyB6oC3T3gxBc7Mj8JIF
         +wExpKiSCMbRkaeSYVGbgiNt1h0GhMKIe5oibx5YN4EHNtF5/AQlO/ye2++D0gvrx6zB
         MIsg==
X-Gm-Message-State: AOAM532kBnBmeq2XyfAMO7PgMAhNq/eiQ69WEdW3B2Ol/AB4G42ZIx2s
        PgdiECf7N9tDe4LeOH9+swIBCw0JFpI=
X-Google-Smtp-Source: ABdhPJxx+al7+3DaoGy5Pb/pOn5oK8hDgMuYZb44Cp0jmJlQKPzPsGkSsIgvZv0Asfk6tbgL3K5HKA==
X-Received: by 2002:adf:8165:: with SMTP id 92mr5779994wrm.199.1639045822620;
        Thu, 09 Dec 2021 02:30:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm6436261wmq.20.2021.12.09.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:22 -0800 (PST)
Message-Id: <3e769bab78cdef61be4b3e06dbe15445f1983a1f.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:07 +0000
Subject: [PATCH v5 13/15] diff --color-moved-ws=allow-indentation-change:
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

