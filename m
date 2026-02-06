Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59B2D7D3A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393366; cv=none; b=Hq12ojnbaUYz6MFBxctLxukDruILe6xu9fvCzUGWCCZUJgNA2c+d5cxSGHKLV2m+wiPQbXqQljRx5mWBRvLR84zI8u0uDHTBQ08aQb8WG0WP4glIRzIw+1hH3Ea9C1E2XWVft+QkP511uxEY8BEEfcZXE+rDQ3bveuM+eVtzB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393366; c=relaxed/simple;
	bh=qmsIJYq8t+5EJXxEwqWROJyIsLI+DEtKJbHb73uq4KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxw+G6sYhSz//fu4cdqISWDZ1Cmt6AwYAIyETtYzUXnTbB1zrMAp4aHZxsoZW3iYx0tL4X602fDeDsJ4BjSU8GuN9Qas962oze1WIj7Q0OccAWDzXKTSvZf+SNsV8AKtq2mAGbFIbwzAyoWZj5YqCG/XNaZZo8naYM6z5Rf+oLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr8gIgL3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr8gIgL3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so24275315e9.2
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393364; x=1770998164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPezk/hQPGcwxxjbe09BfXBAtuNoOJ0CzrP3WyMRqdA=;
        b=lr8gIgL3Hrki8l+t0n1JvixoX/40hjeQdTlKo/rMARwzOoy/BvvEDm+rFeFgubdu1L
         LNsqY8pGOa6S3CxCZMBG0CToBmyw5qMdd1WCGUUWNpgvM0+Qov88Ezdf1dJ9OqHH7BeI
         DOlhU5Et5Qp3kZUfcH5wAU0kKnFy/iay1cKWzr9DnGWIU+otnH2wskIJsGCPRxkQh7IA
         Linj5a8DWPAA+vseLGhAzRzN64Su4Wp2SS/9g1eQaQ6o1AdrTqaqeVvEdIGAMR/gXJnq
         hw3XcNuqSbikBqOJE/xPdaYxOnKXtPVPVbkcYUGW9ifXS8ExxJ22LVQJZq4HxGqR3WSM
         oJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393364; x=1770998164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPezk/hQPGcwxxjbe09BfXBAtuNoOJ0CzrP3WyMRqdA=;
        b=w1YOBnPD5gf48iU0Y++rkVY5j5HYlkn7e6lIFl3ks90rLD22fXGExfQ/UowB12k0Wr
         M6Q482W7ekU1iN5fvjCcPgrtV2AXaU7uHJhXoDybLtShPaCK/396vjmPzEDrVxNJfrXR
         HDfedetUU6kfiNHl+WedpsDtZ4R+8FIFUPiz9B//Zv2Pb35X5ixwacgPB8UMGqqqad5F
         UvuHsi0MPKRix2mFM9/Ir5IMFIrN0r4ftTNu4EIbnpXw4N7GO200B5oISPKzpubUPtUO
         9rpAMB+aVYtEWp1UHWoh3XQZWKukutsVvBy9KvydCBKjQU0PgcJstDSusIbOT+ZRvozw
         X9PA==
X-Gm-Message-State: AOJu0YzDbPv0lusUtoDSUA+ZwcUGlOklG9loryQrmgh82FMtMatCu8nK
	3hY5KTmF/JRCNkralScY50mFDoYjjA739k5mM0Wh0VUxPQJBCeuCHfmIPjJaLXsfv38=
X-Gm-Gg: AZuq6aJWfU2/qu61yRMseTNy2S1mdxGz3sNiYJIGe7Y93xlGxwNieN5Fm811G6tAiCz
	bwrmEaUcdftytRh2XxJVo3+xVGE3gcQc4awN6V3F4+KyNDRbtSvCNkBPoxFFX3/+6MVMikNWZwn
	pDfzjfSfE8g/i+aaHfXdQkhckBjHrd2dJCF75/5uLxYPrhmmBn/8McX4o3gs32AZHxB4f2K+yR+
	7UyZfukoF2IclvNPRGO3C9D+c8RFlUY857q7tzk2/C0tifvEUjkwWvapJMgaxITw6lT8IPfLVx+
	PN7dkFvOB5nWue2xffwpqtRhVNSjJ2P/zHiS6C4v2WTsc52jytfCmDtODT2+RbzAHNm7F3FqlLT
	6JCBlkXjU/utUMsqKoBsoKQhhEXGlOX/uxL8DlcfKX9gjaCfsVwJr04yzxNRdyR+v8nScoSq4ax
	EwgxtM/hpr7Lo8yxJWDaj2
X-Received: by 2002:a05:600c:3590:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-48320236b01mr50963225e9.30.1770393364069;
        Fri, 06 Feb 2026 07:56:04 -0800 (PST)
Received: from localhost ([102.91.81.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ed9sm6658198f8f.5.2026.02.06.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:56:03 -0800 (PST)
Date: Fri, 6 Feb 2026 16:56:14 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/3] add-patch: Allow interfile navigation when selecting
 hunks
Message-ID: <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770390576.git.abrahamadekunle50@gmail.com>

After deciding on all hunks in a file, the interactive session
advances automatically to the next file if there is another,
or the process ends.

Now using the `--rework-with-file` flag with `--patch` the process does not
advance automatically. A user can choose to go to the next file by pressing
'>' or the previous file by pressing '<', before or after deciding on all
hunks in the current file.

After all hunks have been decided in a file, a prompt appears,
which allow the user to still rework with the file by applying
the options available in the permit set for that hunk, and
after all the decisions, the user presses 'q' to submit.

This feature is enabled by passing the `--rework-with-file` flag
to `--patch` option of the subcommands add, stash, reset,
and checkout

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 95 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 15 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..2bd839f17e 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1418,6 +1418,8 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "e - manually edit the current hunk\n"
    "p - print the current hunk\n"
    "P - print the current hunk using the pager\n"
+   "> - go to the next file\n"
+   "< - go to the previous file\n"
    "? - print help\n");
 
 static size_t dec_mod(size_t a, size_t m)
@@ -1430,6 +1432,12 @@ static size_t inc_mod(size_t a, size_t m)
 	return a < m - 1 ? a + 1 : 0;
 }
 
+enum patch_update_response {
+	NEXT_FILE = 0,
+	QUIT,
+	PREVIOUS_FILE,
+};
+
 static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 {
 	for (size_t i = 0; i < file_diff->hunk_nr; i++) {
@@ -1441,7 +1449,7 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 	return false;
 }
 
-static int patch_update_file(struct add_p_state *s,
+static enum patch_update_response patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
 	size_t hunk_index = 0;
@@ -1449,12 +1457,14 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0, use_pager = 0;
+	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
+	int all_decided = 0;
+	enum patch_update_response ret = NEXT_FILE;
 
 	/* Empty added files have no hunks */
 	if (!file_diff->hunk_nr && !file_diff->added)
-		return 0;
+		return NEXT_FILE;
 
 	strbuf_reset(&s->buf);
 	render_diff_header(s, file_diff, colored, &s->buf);
@@ -1467,7 +1477,9 @@ static int patch_update_file(struct add_p_state *s,
 			ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
 			ALLOW_SEARCH_AND_GOTO = 1 << 4,
 			ALLOW_SPLIT = 1 << 5,
-			ALLOW_EDIT = 1 << 6
+			ALLOW_EDIT = 1 << 6,
+			ALLOW_GOTO_PREVIOUS_FILE = 1 << 7,
+			ALLOW_GOTO_NEXT_FILE = 1 << 8
 		} permitted = 0;
 
 		if (hunk_index >= file_diff->hunk_nr)
@@ -1498,9 +1510,12 @@ static int patch_update_file(struct add_p_state *s,
 
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
-		    hunk->use != UNDECIDED_HUNK)
-			break;
-
+		    hunk->use != UNDECIDED_HUNK) {
+				if (s->s.no_auto_advance)
+					all_decided = 1;
+				else
+					break;
+			}
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
@@ -1548,6 +1563,14 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
+			if (s->s.no_auto_advance && s->file_diff_nr > 1) {
+				permitted |= ALLOW_GOTO_NEXT_FILE;
+				strbuf_addstr(&s->buf, ",>");
+			}
+			if (s->s.no_auto_advance && s->file_diff_nr > 1) {
+				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
+				strbuf_addstr(&s->buf, ",<");
+			}
 			strbuf_addstr(&s->buf, ",p,P");
 		}
 		if (file_diff->deleted)
@@ -1566,11 +1589,14 @@ static int patch_update_file(struct add_p_state *s,
 						: 1));
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 		       s->buf.buf);
+		if (s->s.no_auto_advance && all_decided)
+			printf(_("\n%s All hunks decided. What now? "),
+				s->s.prompt_color);
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF) {
-			quit = 1;
+			ret = QUIT;
 			break;
 		}
 
@@ -1616,9 +1642,26 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = SKIP_HUNK;
 			}
 		} else if (ch == 'q') {
-			quit = 1;
+			ret = QUIT;
 			break;
-		} else if (s->answer.buf[0] == 'K') {
+		} else if (s->s.no_auto_advance && s->answer.buf[0] == '>') {
+			if (permitted & ALLOW_GOTO_NEXT_FILE) {
+				ret = NEXT_FILE;
+				break;
+			} else {
+				err(s, _("No next file"));
+				continue;
+			}
+		} else if (s->s.no_auto_advance && s->answer.buf[0] == '<') {
+			if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
+				ret = PREVIOUS_FILE;
+				break;
+			} else {
+				err(s, _("No previous file"));
+				continue;
+			}
+		}
+		else if (s->answer.buf[0] == 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
 				hunk_index = dec_mod(hunk_index,
 						     file_diff->hunk_nr);
@@ -1803,7 +1846,7 @@ static int patch_update_file(struct add_p_state *s,
 	}
 
 	putchar('\n');
-	return quit;
+	return ret;
 }
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
@@ -1814,6 +1857,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	size_t i, binary_count = 0;
+	enum patch_update_response ret;
 
 	init_add_i_state(&s.s, r, o);
 
@@ -1852,11 +1896,32 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		return -1;
 	}
 
-	for (i = 0; i < s.file_diff_nr; i++)
-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
+	for (i = 0; i < s.file_diff_nr;) {
+		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
 			binary_count++;
-		else if (patch_update_file(&s, s.file_diff + i))
-			break;
+			i++;
+			continue;
+		}
+		else {
+			ret = patch_update_file(&s, s.file_diff + i);
+			if (ret == NEXT_FILE) {
+				if (s.s.no_auto_advance && i == s.file_diff_nr - 1)
+					i = 0;
+				else
+					i++;
+				continue;
+			}
+			if (ret == QUIT)
+				break;
+			if (s.s.no_auto_advance && ret == PREVIOUS_FILE) {
+				if (i == 0)
+					i = s.file_diff_nr - 1;
+				else
+					i--;
+				continue;
+			}
+		}
+    }
 
 	if (s.file_diff_nr == 0)
 		err(&s, _("No changes."));
-- 
2.39.5 (Apple Git-154)

