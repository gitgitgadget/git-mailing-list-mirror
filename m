Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13715364924
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453602; cv=none; b=NKC8OW2Z6zHha5oQuxcfmfeZ+1e8KdXpweuwVVuJR7dcPpWwYrNKZmVTl1UtZVjvVIDYh4anMYcv1mHeV4ZPpX30phWgg5J+M+wmu1Jww5zc9doDRnEA7bojIBHP3PGSF1aVxiDEJ+1D2Wg2wlYUDbAcMVvmyabPI7g7PTPy0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453602; c=relaxed/simple;
	bh=IAEIBkHP3kB16uWbXiCcEcw8ze7b71rVSJJYiz5MPWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/1fO57j+XF+kwgMBcj3FKdxP16CH4wgtrQu4Xa4syqbTYzcD51l3mOmY/eo5sp+RtRTPdTgXgJW7NaWb/tqKsFeVwAVJgFuFhamzFsGVcYez631XWCPFdZ6YmtDB3hleVUEr2GL2/hoHEQpzQVGZpU65Ks/PHFZgWZhDe8DSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EqFtefji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rgp+R2Xa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EqFtefji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rgp+R2Xa"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 670E37A0132;
	Mon,  2 Mar 2026 07:13:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 07:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453600;
	 x=1772540000; bh=TF93RgAv4mAPwYMF1v+JB/mAt7pS9mHeDNZQF/L1CAg=; b=
	EqFtefjikWWTjiiIFPVna32m8y2Jq7v3qwc098qOfZWJPu/kSokIB7p4fDRRtRcg
	UfiJOuGieZ2ggeqiL0EtEKhUcwcJiTw2hxnFgEQFpui+SokLarEHzHuV8atSEsJH
	uFldB1jRawLDHYNFQqK9BTal8NaUyA4vE5lT9Vk2RK9jy3HyGLZx/5ToB8+mk+7W
	g9Ej/2rFuVttkR3aobB/x8M+5re72jPGUysKa+2o3sVor6noh8IpUURLwfMBVKAj
	RarwJxBXZ6vECQVdi1roUpO3Y58JDLLzNr1QuQPINUzjKe8rzp9HIjN54DMA6M9H
	fgube611qtOvoiUdEebTXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453600; x=
	1772540000; bh=TF93RgAv4mAPwYMF1v+JB/mAt7pS9mHeDNZQF/L1CAg=; b=r
	gp+R2Xaz8aoo7mcXdgUrkrwSo4cwxC9MHAWE8t7QTbFGiGRINcWQukolhN12s11S
	KNgtKImAJh9EmUMrwQBwLM9xwuSZGhPkvOqtQ4Ud2tS/gU1k1lumVa5Vy2ckpv05
	Xiuw/Avh/KQiZjJ/zz4Kv25PHOPpyo9WDJ5ZJrE9/+6v2XISqSfLp/ihMQ41K6dE
	fZsP1skTnrvGoFNHe4yCXgT/vJfur+o92HA0c/Sjs5xVY8+1ny98Ru/KU8tg7Fv3
	i07eeRZmM17xWNfOrQbVHbQ/JWNF0uuAjJ/9ywmH3MrxcdFOYZ5/u7J/PU1esP+0
	wKwqJ4OZT+IM9i92u7xCQ==
X-ME-Sender: <xms:4H6labd4Vd4Lpne94KNcO_LQtebMRtH6JKC-EtVEitPd1EKLJH17aQ>
    <xme:4H6laXNvIEj0KuFhIEM_Neo-6J2pLne2oOk2rpnhP-qMVXLfZeWS6ADCFVb7E8gS6
    BiMX_htKHVvScHILUVTDRD61o7DVkTMoGW86GGxBWKjP9ya79Xd3g>
X-ME-Received: <xmr:4H6laSK8PYZhqk1KBOZjEo9KqMNgDpNY2cZrZBl9rj2rSAREP3U-Kqr5YLhZKJWxpTvEAhOPvetuF2c17HccFyQEOk0czDBWl7OOh6SDQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeevleegffeigfeffeejhfejfeelvdehiedvgffffeethedtfedvheefieekhfeitden
    ucffohhmrghinheptghfghdrrghuthhopdgtfhhgrdhhvghlphenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:4H6laYHvgbLPp-EZ8ZHS8laglBX6KMMC37nTqNfS-E-w3wpUCUUC5A>
    <xmx:4H6laaRdM1GIGxgMSMBK0fCMdocGXNcbYoFja-2ODZq_WAiEHc6hEQ>
    <xmx:4H6laUEiyOFTWybLgxOxuAanHvxmkXoGLcKKa4y0VxTXc3j3itVYzA>
    <xmx:4H6laW-ufb4MhZWHDq1tqbcarlapERdJnRluo7vlbd93NCxupa1c2Q>
    <xmx:4H6laSPnepHyNYrcNx-d7Sn-AXMor3ckMl7p2bmNixzc65Anlf-A6YbZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9c7ac4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:07 +0100
Subject: [PATCH 3/8] add-patch: remove dependency on "add-interactive"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-3-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

With the preceding commit we have split out interactive configuration
that is used by both "git add -p" and "git add -i". But we still
initialize that configuration in the "add -p" subsystem by calling
`init_add_i_state()`, even though we only do so to initialize the
interactive configuration as well as a repository pointer.

Stop doing so and instead store and initialize the interactive
configuration in `struct add_p_state` directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c | 88 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 756143eb84..4f089c82d0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -2,7 +2,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "add-interactive.h"
 #include "add-patch.h"
 #include "advice.h"
 #include "config.h"
@@ -263,7 +262,8 @@ struct hunk {
 };
 
 struct add_p_state {
-	struct add_i_state s;
+	struct repository *r;
+	struct interactive_config cfg;
 	struct strbuf answer, buf;
 
 	/* parsed diff */
@@ -409,7 +409,7 @@ static void add_p_state_clear(struct add_p_state *s)
 	for (i = 0; i < s->file_diff_nr; i++)
 		free(s->file_diff[i].hunk);
 	free(s->file_diff);
-	clear_add_i_state(&s->s);
+	interactive_config_clear(&s->cfg);
 }
 
 __attribute__((format (printf, 2, 3)))
@@ -418,9 +418,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.cfg.error_color, stdout);
+	fputs(s->cfg.error_color, stdout);
 	vprintf(fmt, args);
-	puts(s->s.cfg.reset_color_interactive);
+	puts(s->cfg.reset_color_interactive);
 	va_end(args);
 }
 
@@ -438,7 +438,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
 }
 
 static int parse_range(const char **p,
@@ -543,12 +543,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
-	if (s->s.cfg.context != -1)
-		strvec_pushf(&args, "--unified=%i", s->s.cfg.context);
-	if (s->s.cfg.interhunkcontext != -1)
-		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.cfg.interhunkcontext);
-	if (s->s.cfg.interactive_diff_algorithm)
-		strvec_pushf(&args, "--diff-algorithm=%s", s->s.cfg.interactive_diff_algorithm);
+	if (s->cfg.context != -1)
+		strvec_pushf(&args, "--unified=%i", s->cfg.context);
+	if (s->cfg.interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", s->cfg.interhunkcontext);
+	if (s->cfg.interactive_diff_algorithm)
+		strvec_pushf(&args, "--diff-algorithm=%s", s->cfg.interactive_diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
@@ -577,9 +577,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	strbuf_complete_line(plain);
 
-	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
+	if (want_color_fd(1, s->cfg.use_color_diff)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
-		const char *diff_filter = s->s.cfg.interactive_diff_filter;
+		const char *diff_filter = s->cfg.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
@@ -812,7 +812,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				   hunk->colored_end - hunk->colored_start);
 			return;
 		} else {
-			strbuf_addstr(out, s->s.cfg.fraginfo_color);
+			strbuf_addstr(out, s->cfg.fraginfo_color);
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
@@ -834,7 +834,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
+			strbuf_addf(out, "%s\n", s->cfg.reset_color_diff);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1223,12 +1223,12 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 
 		strbuf_addstr(&s->colored,
 			      plain[current] == '-' ?
-			      s->s.cfg.file_old_color :
+			      s->cfg.file_old_color :
 			      plain[current] == '+' ?
-			      s->s.cfg.file_new_color :
-			      s->s.cfg.context_color);
+			      s->cfg.file_new_color :
+			      s->cfg.context_color);
 		strbuf_add(&s->colored, plain + current, eol - current);
-		strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
+		strbuf_addstr(&s->colored, s->cfg.reset_color_diff);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
@@ -1357,7 +1357,7 @@ static int run_apply_check(struct add_p_state *s,
 
 static int read_single_character(struct add_p_state *s)
 {
-	if (s->s.cfg.use_single_key) {
+	if (s->cfg.use_single_key) {
 		int res = read_key_without_echo(&s->answer);
 		printf("%s\n", res == EOF ? "" : s->answer.buf);
 		return res;
@@ -1371,7 +1371,7 @@ static int read_single_character(struct add_p_state *s)
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
-		color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prompt));
+		color_fprintf(stdout, s->cfg.prompt_color, "%s", _(prompt));
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
@@ -1559,7 +1559,7 @@ static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->s.r->index);
+		discard_index(s->r->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					s->mode->is_reverse);
@@ -1570,9 +1570,9 @@ static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
 					NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
-							1, NULL, NULL, NULL);
+		if (repo_read_index(s->r) >= 0)
+			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
+						     1, NULL, NULL, NULL);
 	}
 
 }
@@ -1660,7 +1660,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
 		    hunk->use != UNDECIDED_HUNK) {
-				if (!s->s.cfg.auto_advance)
+				if (!s->cfg.auto_advance)
 					all_decided = 1;
 				else {
 					patch_update_resp++;
@@ -1714,11 +1714,11 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
-			if (!s->s.cfg.auto_advance && s->file_diff_nr > 1) {
+			if (!s->cfg.auto_advance && s->file_diff_nr > 1) {
 				permitted |= ALLOW_GOTO_NEXT_FILE;
 				strbuf_addstr(&s->buf, ",>");
 			}
-			if (!s->s.cfg.auto_advance && s->file_diff_nr > 1) {
+			if (!s->cfg.auto_advance && s->file_diff_nr > 1) {
 				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
 				strbuf_addstr(&s->buf, ",<");
 			}
@@ -1733,7 +1733,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		else
 			prompt_mode_type = PROMPT_HUNK;
 
-		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.cfg.prompt_color,
+		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->cfg.prompt_color,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
@@ -1746,8 +1746,8 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 			hunk_use_decision, s->buf.buf);
-		if (*s->s.cfg.reset_color_interactive)
-			fputs(s->s.cfg.reset_color_interactive, stdout);
+		if (*s->cfg.reset_color_interactive)
+			fputs(s->cfg.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF) {
 			patch_update_resp = s->file_diff_nr;
@@ -1798,7 +1798,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		} else if (ch == 'q') {
 			patch_update_resp = s->file_diff_nr;
 			break;
-		} else if (!s->s.cfg.auto_advance && s->answer.buf[0] == '>') {
+		} else if (!s->cfg.auto_advance && s->answer.buf[0] == '>') {
 			if (permitted & ALLOW_GOTO_NEXT_FILE) {
 				if (patch_update_resp == s->file_diff_nr - 1)
 					patch_update_resp = 0;
@@ -1809,7 +1809,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				err(s, _("No next file"));
 				continue;
 			}
-		} else if (!s->s.cfg.auto_advance && s->answer.buf[0] == '<') {
+		} else if (!s->cfg.auto_advance && s->answer.buf[0] == '<') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
 				if (patch_update_resp == 0)
 					patch_update_resp = s->file_diff_nr - 1;
@@ -1932,7 +1932,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				err(s, _("Sorry, cannot split this hunk"));
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
-				color_fprintf_ln(stdout, s->s.cfg.header_color,
+				color_fprintf_ln(stdout, s->cfg.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
@@ -1950,7 +1950,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-			color_fprintf(stdout, s->s.cfg.help_color, "%s",
+			color_fprintf(stdout, s->cfg.help_color, "%s",
 				      _(s->mode->help_patch_text));
 
 			/*
@@ -1974,13 +1974,13 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 						if (file_diff->hunk[i].use == SKIP_HUNK)
 							skipped += 1;
 					}
-					color_fprintf_ln(stdout, s->s.cfg.help_color, _(p),
+					color_fprintf_ln(stdout, s->cfg.help_color, _(p),
 							 total, used, skipped);
 				}
 				if (*p != '?' && !strchr(s->buf.buf, *p))
 					continue;
 
-				color_fprintf_ln(stdout, s->s.cfg.help_color,
+				color_fprintf_ln(stdout, s->cfg.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
 		} else {
@@ -1989,7 +1989,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 	}
 
-	if (s->s.cfg.auto_advance)
+	if (s->cfg.auto_advance)
 		apply_patch(s, file_diff);
 
 	putchar('\n');
@@ -2001,11 +2001,15 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	      const struct pathspec *ps)
 {
 	struct add_p_state s = {
-		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+		.r = r,
+		.answer = STRBUF_INIT,
+		.buf = STRBUF_INIT,
+		.plain = STRBUF_INIT,
+		.colored = STRBUF_INIT,
 	};
 	size_t i, binary_count = 0;
 
-	init_add_i_state(&s.s, r, opts);
+	interactive_config_init(&s.cfg, r, opts);
 
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
@@ -2051,7 +2055,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		 if ((i = patch_update_file(&s, i)) == s.file_diff_nr)
 			break;
     }
-	if (!s.s.cfg.auto_advance)
+	if (!s.cfg.auto_advance)
 		for (i = 0; i < s.file_diff_nr; i++)
 			apply_patch(&s, s.file_diff + i);
 

-- 
2.53.0.697.g625c4fb2da.dirty

