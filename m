Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34542F12DA
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758945; cv=none; b=grnS8T+6CMRSXORUoxVr7xzv/dWogIAk11QKB50oPNoPRIzLHQJGbEeyW9byfjhUF5V7WKOu8AsLCrbkKoO/7M0b/0CrJrGYRYOiYwrgHsdsxD9nH6q86AzmusChYr1I3uAGB/NL6rCprWlkpNZOLmN1Ta5UB35rFPOGzCdrS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758945; c=relaxed/simple;
	bh=Q4VnrOz9GbmFUBXxbo/JkvUD2mLqlE+imjVBRgTFoY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNtpVKyHik9Xsb1gpgcf+IVCAX8o9idxwWdIag4ldKRM/CpdGkmGoox0toGHYSLqWuX1aRFrIheuLKqoU+C+PXQCMG3SQ3OWknyY5ivzgEI+kvx7LeyymYO/zkp/QXmb4ziGHbUGWingMT+fohk2P8gF4zWE33LZ3/xdaoy+5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MzClvJpZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBoWDgi4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MzClvJpZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBoWDgi4"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16A2514001B8;
	Wed,  3 Dec 2025 05:49:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 03 Dec 2025 05:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758943;
	 x=1764845343; bh=wqIHzjcIuCUUBMwbRgxFHXhDhsPu4pv+WHQDCbDB/0Q=; b=
	MzClvJpZpNIO3YGyjS9Gq6/wBZCiLWMEDf2+TCpBEis5TW/JEislA+6K6uQx20aA
	Y2VA+CpDe0wq0hqJtN1+qOONlmgIGF1Rp1vhfx8aru847+0ciDkJ/8uoaPoTv26w
	upr+7zO1fwy/cX2HltcrOdq2AQTJEQh2o3jS9mR+2FQnjZBWIF+9yCQbL9aB8GYP
	K9v0/yPT3N9Oe/5wXEwkaNbaZfPUBExBBYNgJpghq8JdAFf0W9jidg2m5P+CeBAj
	bfXykxQ4X/3MMDd80bhI8MFnFddZHlxpOb9za9+zTEPMPtN9EXI/ITsCxqXDai4R
	5dVa3wnRH+dWHmlontYuvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758943; x=
	1764845343; bh=wqIHzjcIuCUUBMwbRgxFHXhDhsPu4pv+WHQDCbDB/0Q=; b=T
	BoWDgi4GGWpj3XrMBpqHN9y676iyfWLScf/C1KkyGlQ/E/npvV6Pvy4tGUknOFh3
	uYdft1H9pw+MwsgbICXVS0iC+V9DaGuRvsisdxGvpojZewy+5SSii4yLc8WN1OsS
	Fkba0vVSwR2jh2LLlK5MMJI2F9FSGwTkeskv2HuRYaDQTCH09RWzV9A8xBvT7T2n
	ipWaUVnD9LqQFaVOmnwqRq5xZ921WtQeYtkLuNZRjxzW4PD+7qycz2fcbwEezYRt
	OgrnWfNXquEZVF1bFlxJi2e4qxUjVDEYDH/JwAQj90GfLB+dU0Qyhn4U/pvalurX
	vh49ELolCq8Lk7OeiyqaA==
X-ME-Sender: <xms:nhUwaZVNtweH24dtbXVnez_GH9wH8g6_0amgCHLdQfiA0r10XL_ijA>
    <xme:nhUwacLGz-Yg0jMMayBnNj7XP2RkMr7zEgwq7lNfQCoRxBvhspSxg8oZ2rzx24e2i
    Bno2hu5icsdkE0ZLUQYj_IRnxmEHLXh1X83Khl93PfE-IVltX571w>
X-ME-Received: <xmr:nhUwaZDB__DjHUsZX7a0RLvgvmUhAItBB8QGzSItIovOE6y89Jru6_9MSbLv9BTglFrJtpdeASspEH162VWs-iV7Xn9i9ed4SRvEWgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fghfdtvedvkeetgeeutedvlefggfejtdekgfeutdevheehvefhteeigffgleevieenucff
    ohhmrghinheptghfghdrhhgvlhhpnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghn
    rdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtph
    htthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:nhUwacd_GcN6zQH6Qpze9tdzQ2HUEKX6ssHW32qPTZ0O4laICv_RVQ>
    <xmx:nhUwaY1hnNk1swg5WbT2GsnU48IrMgEtWvTE1D66dGYdHxaguUPUOw>
    <xmx:nhUwaTjt12xpcc49_PRmvwfjcVSf4_CN6oDS-NusJM84aN3q-8wBkA>
    <xmx:nhUwaRlNt1-joVxpP4NGgpDdUhLGkGdhp0f0nW1tk0itDLt2jGbYEg>
    <xmx:nxUwaSDYn2QfZRf2iyLWSUoQleJwx5w7Aa6xcX4TjcYotB8rrS2AASyD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:49:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3781834 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:49:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:35 +0100
Subject: [PATCH v7 08/12] add-patch: remove dependency on "add-interactive"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-8-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
 add-patch.c | 70 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 6797d2f690..2780738153 100644
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
@@ -408,7 +408,7 @@ static void add_p_state_clear(struct add_p_state *s)
 	for (i = 0; i < s->file_diff_nr; i++)
 		free(s->file_diff[i].hunk);
 	free(s->file_diff);
-	clear_add_i_state(&s->s);
+	interactive_config_clear(&s->cfg);
 }
 
 __attribute__((format (printf, 2, 3)))
@@ -417,9 +417,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.cfg.error_color, stdout);
+	fputs(s->cfg.error_color, stdout);
 	vprintf(fmt, args);
-	puts(s->s.cfg.reset_color_interactive);
+	puts(s->cfg.reset_color_interactive);
 	va_end(args);
 }
 
@@ -437,7 +437,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
 }
 
 static int parse_range(const char **p,
@@ -542,12 +542,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
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
@@ -576,9 +576,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	strbuf_complete_line(plain);
 
-	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
+	if (want_color_fd(1, s->cfg.use_color_diff)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
-		const char *diff_filter = s->s.cfg.interactive_diff_filter;
+		const char *diff_filter = s->cfg.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
@@ -811,7 +811,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				   hunk->colored_end - hunk->colored_start);
 			return;
 		} else {
-			strbuf_addstr(out, s->s.cfg.fraginfo_color);
+			strbuf_addstr(out, s->cfg.fraginfo_color);
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
@@ -833,7 +833,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
+			strbuf_addf(out, "%s\n", s->cfg.reset_color_diff);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1222,12 +1222,12 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 
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
@@ -1356,7 +1356,7 @@ static int run_apply_check(struct add_p_state *s,
 
 static int read_single_character(struct add_p_state *s)
 {
-	if (s->s.cfg.use_single_key) {
+	if (s->cfg.use_single_key) {
 		int res = read_key_without_echo(&s->answer);
 		printf("%s\n", res == EOF ? "" : s->answer.buf);
 		return res;
@@ -1370,7 +1370,7 @@ static int read_single_character(struct add_p_state *s)
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
-		color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prompt));
+		color_fprintf(stdout, s->cfg.prompt_color, "%s", _(prompt));
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
@@ -1678,15 +1678,15 @@ static int patch_update_file(struct add_p_state *s,
 		else
 			prompt_mode_type = PROMPT_HUNK;
 
-		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.cfg.prompt_color,
+		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->cfg.prompt_color,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 		       s->buf.buf);
-		if (*s->s.cfg.reset_color_interactive)
-			fputs(s->s.cfg.reset_color_interactive, stdout);
+		if (*s->cfg.reset_color_interactive)
+			fputs(s->cfg.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF) {
 			quit = 1;
@@ -1849,7 +1849,7 @@ static int patch_update_file(struct add_p_state *s,
 				err(s, _("Sorry, cannot split this hunk"));
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
-				color_fprintf_ln(stdout, s->s.cfg.header_color,
+				color_fprintf_ln(stdout, s->cfg.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
@@ -1867,7 +1867,7 @@ static int patch_update_file(struct add_p_state *s,
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-			color_fprintf(stdout, s->s.cfg.help_color, "%s",
+			color_fprintf(stdout, s->cfg.help_color, "%s",
 				      _(s->mode->help_patch_text));
 
 			/*
@@ -1885,7 +1885,7 @@ static int patch_update_file(struct add_p_state *s,
 				if (*p != '?' && !strchr(s->buf.buf, *p))
 					continue;
 
-				color_fprintf_ln(stdout, s->s.cfg.help_color,
+				color_fprintf_ln(stdout, s->cfg.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
 		} else {
@@ -1905,7 +1905,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->s.r->index);
+		discard_index(s->r->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1916,8 +1916,8 @@ static int patch_update_file(struct add_p_state *s,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+		if (repo_read_index(s->r) >= 0)
+			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
 	}
 
@@ -1930,11 +1930,15 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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

-- 
2.52.0.239.gd5f0c6e74e.dirty

