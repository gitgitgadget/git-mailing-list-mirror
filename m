Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADEC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 10:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1974220791
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 10:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBCqQ3gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgIDKFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIDKFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 06:05:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F41C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 03:05:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so5542645wme.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=88OjMXMQmn0TYD7ht06J7Xr5DIkfa0UkgOUEvKkGQjk=;
        b=hBCqQ3gZcTfpfk56v6w3pBAUA1qo/a/vHhj3iK1mBb5jhIPSLL+i0GbMk0cYpLKHx4
         vg8mkGfxQv5x9yfBo+0Q8HAj5e7MC3MsF+nXETEzFpDPDM3BdwPd0JUMN33K5xvzZanp
         QdaFp260bKAmE9lHxRjSCBzW2QweRIwXiOvgts/a3Z+wAq0AvyiMWkxuhFZHLZt5OFa8
         S07mFsNEDZQNz1UXf0ovItsrVzZlz4h7Y1bwVZiB1serBxfG2RqS8uGBcD8IeUlWto95
         WWjM8cfsVgrF+ww7jOKnqlkliK39DR4yT2siBF1PakoUR75pJDyAqDBd9ED8Kvv9WXox
         +BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88OjMXMQmn0TYD7ht06J7Xr5DIkfa0UkgOUEvKkGQjk=;
        b=L5PMew2cYDJgkmDMw3ZnqXEPNrUkf6+jZY3AnO0UtpuHgrb8WR0FWtRur+JM+RtXEB
         esESepDGjBJbGkkSlzsGlRoc5VlRcl3StH5aLknkrylLelVrTewIc4DIjkT5oCYfCCfo
         qmeZzWsX02IbTDXrdtNaiJLYAfgpDQr26LAi838pyB35AWL+rQtCzqCfA9M+CKcYQCjK
         ODM0yx9fMnELrQrg6MYxNgegayY/Odz07GhnTnx/sZzcRxsnij5icXuiHSnw0AdIEJ7h
         XCTU8uel0Ak2eBDcSn5fJmlWL58a6EM+c6nMbcui2XwZ2ChzGxY9qCREaHbttjJ3CswH
         vr+Q==
X-Gm-Message-State: AOAM531CYKR9cIxYJCIDfpFGb+OAbikQ2n3VIHhR5IZis0CplXu/8HaT
        nnZZksipcwwjkyLX+W0BmVnzRynymyY=
X-Google-Smtp-Source: ABdhPJwJL3cWvxgzAyQyZ2HU/6NkMjMA7eYR77HVNffA1ETXb1XZvGQdTGyMNWTHuixeh18HS6iXdQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr6668960wmb.84.1599213951594;
        Fri, 04 Sep 2020 03:05:51 -0700 (PDT)
Received: from [192.168.1.201] (31.35.7.51.dyn.plus.net. [51.7.35.31])
        by smtp.googlemail.com with ESMTPSA id f6sm14059044wme.32.2020.09.04.03.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 03:05:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
To:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
Message-ID: <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
Date:   Fri, 4 Sep 2020 11:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/2020 22:03, Raymond E. Pasco wrote:
> On Mon Aug 24, 2020 at 1:28 PM EDT, Phillip Wood wrote:
>> The patch I was referring to is 2c8bd8471a ("checkout -p: handle new
>> files correctly", 2020-05-27)
>>
>> I tested seen at 3981657b13 ("Merge branch 'rp/apply-cached-doc' into
>> seen", 2020-08-21). I was using the C version of 'add -p' which is
>> opt-in at the moment by setting add.interactive.usebuiltin=true in your
>> config (or with git -c). I hope that helps, I'm going off line now for
>> 10-14 days
> 
> Indeed, this works and restores my workflow (although it errors out if I
> don't manually edit the range information, which isn't necessary with
> diffs to existing files). It's a bit unsatisfying as it stands, but
> perhaps there are patches I can write.
> 
> No need to reply, enjoy your vacation!

Thanks, it was really good to get a change of scene. The patch below
fixes the hunk editing for new files in the C version of `add -p` if
anyone wants to try it out. I haven't looked at fixing the perl
version yet - dscho what are your plans for switching over to the C
version?

Best Wishes

Phillip

---- >8 ----
From b0df1953308f8de5224a2d99d435f93cc4093a17 Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Wed, 2 Sep 2020 15:25:55 +0100
Subject: [PATCH] add -p: fix editing of intent-to-add paths

A popular way of partially staging a new file is to run `git add -N
<path>` and then use the hunk editing of `git add -p` to select the
part of the file that the user wishes to stage. Since
85953a3187 ("diff-files --raw: show correct post-image of
intent-to-add files", 2020-07-01) this has stopped working as
intent-to-add paths are now show as new files rather than changes to
an empty blob and `git apply` refused to apply a creation patch for a
path that was marked as intent-to-add. 7cfde3fa0f ("apply: allow "new
file" patches on i-t-a entries", 2020-08-06) fixed the problem with
apply but it still wasn't possible to edit the added hunk properly.

2c8bd8471a ("checkout -p: handle new files correctly", 2020-05-27)
had previously changed `add -p` to handle new files but it did not
implement patch editing correctly. The perl version simply forbade
editing and the C version opened the editor with the full diff rather
that just the hunk which meant that the user had to edit the hunk
header manually to get it to work.

This patch only fixes the C version to correctly edit new file
patches. To test the C version the tests must be run with
GIT_TEST_ADD_I_USE_BUILTIN=1. It is best viewed with 
--color-moved-ws=allow-indentation-change

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reported-by: Thomas Sullivan <tom@msbit.com.au>
---
 add-patch.c                | 83 +++++++++++++++++++++-----------------
 t/t3701-add-interactive.sh | 44 +++++++++++++++++++-
 2 files changed, 89 insertions(+), 38 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f67b304a55..209a63e4f2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -451,7 +451,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	pend = p + plain->len;
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
-		const char *deleted = NULL, *added = NULL, *mode_change = NULL;
+		const char *mode_change = NULL;
 
 		if (!eol)
 			eol = pend;
@@ -470,12 +470,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		} else if (p == plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
-		else if (file_diff->deleted || file_diff->added)
-			; /* keep the rest of the file in a single "hunk" */
-		else if (starts_with(p, "@@ ") ||
-			 (hunk == &file_diff->head &&
-			  (skip_prefix(p, "deleted file", &deleted) ||
-			   skip_prefix(p, "new file", &added)))) {
+		else if (starts_with(p, "@@ ")) {
 			if (marker == '-' || marker == '+')
 				/*
 				 * Should not happen; previous hunk did not end
@@ -493,18 +488,20 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			if (colored)
 				hunk->colored_start = colored_p - colored->buf;
 
-			if (deleted)
-				file_diff->deleted = 1;
-			else if (added)
-				file_diff->added = 1;
-			else if (parse_hunk_header(s, hunk) < 0)
+			if (parse_hunk_header(s, hunk) < 0)
 				return -1;
 
 			/*
 			 * Start counting into how many hunks this one can be
 			 * split
 			 */
 			marker = *p;
+		} else if (hunk == &file_diff->head &&
+			   starts_with(p, "new file")) {
+			file_diff->added = 1;
+		} else if (hunk == &file_diff->head &&
+			   starts_with(p, "deleted file")) {
+			file_diff->deleted = 1;
 		} else if (hunk == &file_diff->head &&
 			   skip_prefix(p, "old mode ", &mode_change) &&
 			   is_octal(mode_change, eol - mode_change)) {
@@ -1358,39 +1355,46 @@ static int patch_update_file(struct add_p_state *s,
 	int colored = !!s->colored.len, quit = 0;
 	enum prompt_mode_type prompt_mode_type;
 
-	if (!file_diff->hunk_nr)
+	/* Empty added and deleted files have no hunks */
+	if (!file_diff->hunk_nr && !file_diff->added && !file_diff->deleted)
 		return 0;
 
 	strbuf_reset(&s->buf);
 	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
-		if (hunk_index >= file_diff->hunk_nr)
-			hunk_index = 0;
-		hunk = file_diff->hunk + hunk_index;
+		if (file_diff->hunk_nr) {
+			if (hunk_index >= file_diff->hunk_nr)
+				hunk_index = 0;
+			hunk = file_diff->hunk + hunk_index;
 
-		undecided_previous = -1;
-		for (i = hunk_index - 1; i >= 0; i--)
-			if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
-				undecided_previous = i;
-				break;
-			}
+			undecided_previous = -1;
+			for (i = hunk_index - 1; i >= 0; i--)
+				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
+					undecided_previous = i;
+					break;
+				}
 
-		undecided_next = -1;
-		for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
-			if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
-				undecided_next = i;
-				break;
-			}
+			undecided_next = -1;
+			for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
+				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
+					undecided_next = i;
+					break;
+				}
 
-		/* Everything decided? */
-		if (undecided_previous < 0 && undecided_next < 0 &&
-		    hunk->use != UNDECIDED_HUNK)
-			break;
+			/* Everything decided? */
+			if (undecided_previous < 0 && undecided_next < 0 &&
+			    hunk->use != UNDECIDED_HUNK)
+				break;
 
-		strbuf_reset(&s->buf);
-		render_hunk(s, hunk, 0, colored, &s->buf);
-		fputs(s->buf.buf, stdout);
+			strbuf_reset(&s->buf);
+			render_hunk(s, hunk, 0, colored, &s->buf);
+			fputs(s->buf.buf, stdout);
+		} else {
+			hunk = &file_diff->head;
+			undecided_next = -1;
+			undecided_previous = -1;
+		}
 
 		strbuf_reset(&s->buf);
 		if (undecided_previous >= 0)
@@ -1421,7 +1425,9 @@ static int patch_update_file(struct add_p_state *s,
 		color_fprintf(stdout, s->s.prompt_color,
 			      "(%"PRIuMAX"/%"PRIuMAX") ",
 			      (uintmax_t)hunk_index + 1,
-			      (uintmax_t)file_diff->hunk_nr);
+			      (uintmax_t)(file_diff->hunk_nr
+						? file_diff->hunk_nr
+						: 1));
 		color_fprintf(stdout, s->s.prompt_color,
 			      _(s->mode->prompt_mode[prompt_mode_type]),
 			      s->buf.buf);
@@ -1601,14 +1607,17 @@ static int patch_update_file(struct add_p_state *s,
 						 "%.*s", (int)(eol - p), p);
 			}
 		}
+		if (!file_diff->hunk_nr)
+			break;
 	}
 
 	/* Any hunk to be used? */
 	for (i = 0; i < file_diff->hunk_nr; i++)
 		if (file_diff->hunk[i].use == USE_HUNK)
 			break;
 
-	if (i < file_diff->hunk_nr) {
+	if (i < file_diff->hunk_nr ||
+	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
 		/* At least one hunk selected: apply */
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fb73a847cb..49d597979a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -47,7 +47,11 @@ test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
 	echo more >>file &&
-	echo lines >>file
+	echo lines >>file &&
+	if test -n "$GIT_TEST_ADD_I_USE_BUILTIN"
+	then
+		test_set_prereq BUILTIN_ADD_I
+	fi
 '
 test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
@@ -814,6 +818,44 @@ test_expect_success 'checkout -p works with pathological context lines' '
 	test_cmp expect a
 '
 
+# This should be called from a subshell as it sets a temporary editor
+setup_new_file() {
+	write_script new-file-editor.sh <<-\EOF &&
+	sed /^#/d "$1" >patch &&
+	sed /^+c/d patch >"$1"
+	EOF
+	test_set_editor "$(pwd)/new-file-editor.sh" &&
+	test_write_lines a b c d e f >new-file &&
+	test_write_lines a b d e f >new-file-expect &&
+	test_write_lines "@@ -0,0 +1,6 @@" +a +b +c +d +e +f >patch-expect
+}
+
+test_expect_success BUILTIN_ADD_I 'add -N followed by add -p patch editing' '
+	git reset --hard &&
+	(
+		setup_new_file &&
+		git add -N new-file &&
+		test_write_lines e n q | git add -p &&
+		git cat-file blob :new-file >actual &&
+		test_cmp new-file-expect actual &&
+		test_cmp patch-expect patch
+	)
+'
+
+test_expect_success BUILTIN_ADD_I 'checkout -p patch editing of added file' '
+	git reset --hard &&
+	(
+		setup_new_file &&
+		git add new-file &&
+		git commit -m "add new file" &&
+		git rm new-file &&
+		git commit -m "remove new file" &&
+		test_write_lines e n q | git checkout -p HEAD^ &&
+		test_cmp new-file-expect new-file &&
+		test_cmp patch-expect patch
+	)
+'
+
 test_expect_success 'show help from add--helper' '
 	git reset --hard &&
 	cat >expect <<-EOF &&
-- 
2.25.1.551.gd3318bf0d3.dirty
