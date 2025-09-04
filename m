Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C130DD06
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996101; cv=none; b=j88x5zhGwQRG9w8S6T0iFX3iYaSQbZUvtsAVpCSMVJSoyK94c8tjkxF/CChHPMg56hxUTL1Leew39unU6SSpntTm7+rqSwJhVHICAX+ftUA/NFj9jIUKdKSbtGwbqnRBCZqsHoMZsIJth6gNALAZsP02atWCxtdG7Va5ECZtkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996101; c=relaxed/simple;
	bh=+4Be1AIXXTGnhInlVV0YhrvT3iQMb8bUyUiMtYgvI/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmB3bv6DBeLSZJhbykGFDkGkS6qQDcUMCevMM/08Lkg5FvtOCmzyNhD5N05etk5JVmX/7RxuX8iYkVzEi27HBrnK4DsqfW/JwuyNabsCEtczD55FUqd/efSMoox49Mgxs9Gk6v/csADpIq9ARBMYcZJPBfAbjlM7TDynyXXZnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SPms/nuF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=URbNCllI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SPms/nuF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="URbNCllI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B72731D00294;
	Thu,  4 Sep 2025 10:28:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996098;
	 x=1757082498; bh=dTbOx8jubMu3Qee3b36ys7qxRiZlvQmNmsOXnP7/9g0=; b=
	SPms/nuFMyLzEkRZYOoQzAsm8nJZz/WO9UOYsDI270tRJlar+HPwX6UkeV6aTPcX
	EgJHNgUy/5ChXPX3p5Kr9dYz+/+VUL8ahk1/UWkBs6hFfKH96Cf7b8C2rVf9NsJs
	Wr7z9hDr4P5qrWyB3I90L5v7Ly3W4VZilyY4DzOCG2hvGOyNjMa6Wt9EO5LeyEPS
	tDPJAAl8qQ4gFDYZnGemfXhtrowtBSADlU4xdTaxsrLNm3YjvaJpXZBgdsItv9SM
	/3QyoHDAzjxWXa2ql57Y5p5Wzx+24fTPOLHM6TBVMJgWGaMBve9xGMlw/AThND5q
	3rkOKj+elh3CuNSjScfMrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996098; x=
	1757082498; bh=dTbOx8jubMu3Qee3b36ys7qxRiZlvQmNmsOXnP7/9g0=; b=U
	RbNCllIMdkCvTA6gT/JP49UjJgj9UgWoeYdUhQlBLx7K6cbZbt/PAoU0ntpUSp76
	R0NzfWk/qOuPm0u38WNPsfSB5uxWLRZuHi1Q/736WTXTe+xRbR45NcyG2C7ez2yU
	3xCyWvOmvFNj+APuW26K5GX2y381jnoyMcy6/IZcvrT2pZXNEb15Dkl/R9lmtbZZ
	rYUBLIF3ommCiDDbEi/YNqC/cs3h1GspqzL7jcvT7awRLNyS51Orpje8WUET0pXp
	VEOfXu841/aWjjJfaJyA8qecF4+kvMkAMFLWP/qk9qSqhBieKBCmMtzV3d2N9T3P
	Qa50kO9018yHOfiVpTnNg==
X-ME-Sender: <xms:AqK5aHuvBk5B5ozzj5D0FSTGUGh0Z2x9LI0GRb4E0_jdAfi6IpVDSA>
    <xme:AqK5aGAVKZVb3gkVL8bFm7O1scwc33YoNiOK-DU6wHQrbKABZXdH0gvHfY7Ap3EhS
    8Y7oB79k6ezDmcTmg>
X-ME-Received: <xmr:AqK5aBPI4e5IRdaMva00YkitD2k5qy4ET09xdhNk0B0HQ0Wv6OuLzTQlVeXl5pzMJu5gbeVziKvj9jfjPaptqNkWilrgMS8xZWK2OqV5-hHP2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fghfdtvedvkeetgeeutedvlefggfejtdekgfeutdevheehvefhteeigffgleevieenucff
    ohhmrghinheptghfghdrhhgvlhhpnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AqK5aHwWHMMvUe9lc0nTActravgsroE3fVUqAXK0pndIuOlsPUSxoA>
    <xmx:AqK5aJVaxuMn3Vs-eWk5b6JHmb9896MUHh4HIMS6Lk5R129CFstOQw>
    <xmx:AqK5aBPLDFzjaXlMgoJk8OnGV_GlXVRFNNnQLTRP4KpCg2cDQxpbMw>
    <xmx:AqK5aDCE0u0VXDpjlm_xPOIC7SUZuCWMPafwz-c7X5gIBTlRZjT6hA>
    <xmx:AqK5aD6qbuycfK2ITxX6ZJoh21nMf5063fg32Qwy_wNRDoA1MUmWXjMD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 060d7310 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:43 +0200
Subject: [PATCH RFC v3 13/18] add-patch: remove dependency on
 "add-interactive" subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-13-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

With the preceding commit we have split out interactive configuration
that is used by both "git add -p" and "git add -i". But we still
initialize that configuration in the "add -p" subsystem by calling
`init_add_i_state()`, even though we only do so to initialize the
interactive configuration as well as a repository pointer.

Stop doing so and instead store and initialize the interactive
configuration in `struct add_p_state` directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c | 68 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 45bc254e0c..1bcbc91de9 100644
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
@@ -385,7 +385,7 @@ static void add_p_state_clear(struct add_p_state *s)
 	for (i = 0; i < s->file_diff_nr; i++)
 		free(s->file_diff[i].hunk);
 	free(s->file_diff);
-	clear_add_i_state(&s->s);
+	interactive_config_clear(&s->cfg);
 }
 
 __attribute__((format (printf, 2, 3)))
@@ -394,9 +394,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.cfg.error_color, stdout);
+	fputs(s->cfg.error_color, stdout);
 	vprintf(fmt, args);
-	puts(s->s.cfg.reset_color);
+	puts(s->cfg.reset_color);
 	va_end(args);
 }
 
@@ -414,7 +414,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
 }
 
 static int parse_range(const char **p,
@@ -519,12 +519,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
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
@@ -555,7 +555,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 	if (want_color_fd(1, -1)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
-		const char *diff_filter = s->s.cfg.interactive_diff_filter;
+		const char *diff_filter = s->cfg.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
@@ -788,7 +788,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				   hunk->colored_end - hunk->colored_start);
 			return;
 		} else {
-			strbuf_addstr(out, s->s.cfg.fraginfo_color);
+			strbuf_addstr(out, s->cfg.fraginfo_color);
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
@@ -810,7 +810,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", s->s.cfg.reset_color);
+			strbuf_addf(out, "%s\n", s->cfg.reset_color);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1198,12 +1198,12 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 
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
-		strbuf_addstr(&s->colored, s->s.cfg.reset_color);
+		strbuf_addstr(&s->colored, s->cfg.reset_color);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
@@ -1322,7 +1322,7 @@ static int run_apply_check(struct add_p_state *s,
 
 static int read_single_character(struct add_p_state *s)
 {
-	if (s->s.cfg.use_single_key) {
+	if (s->cfg.use_single_key) {
 		int res = read_key_without_echo(&s->answer);
 		printf("%s\n", res == EOF ? "" : s->answer.buf);
 		return res;
@@ -1336,7 +1336,7 @@ static int read_single_character(struct add_p_state *s)
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
-		color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prompt));
+		color_fprintf(stdout, s->cfg.prompt_color, "%s", _(prompt));
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
@@ -1617,15 +1617,15 @@ static int patch_update_file(struct add_p_state *s,
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
-		if (*s->s.cfg.reset_color)
-			fputs(s->s.cfg.reset_color, stdout);
+		if (*s->cfg.reset_color)
+			fputs(s->cfg.reset_color, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			break;
@@ -1782,7 +1782,7 @@ static int patch_update_file(struct add_p_state *s,
 				err(s, _("Sorry, cannot split this hunk"));
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
-				color_fprintf_ln(stdout, s->s.cfg.header_color,
+				color_fprintf_ln(stdout, s->cfg.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
@@ -1800,7 +1800,7 @@ static int patch_update_file(struct add_p_state *s,
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-			color_fprintf(stdout, s->s.cfg.help_color, "%s",
+			color_fprintf(stdout, s->cfg.help_color, "%s",
 				      _(s->mode->help_patch_text));
 
 			/*
@@ -1818,7 +1818,7 @@ static int patch_update_file(struct add_p_state *s,
 				if (*p != '?' && !strchr(s->buf.buf, *p))
 					continue;
 
-				color_fprintf_ln(stdout, s->s.cfg.help_color,
+				color_fprintf_ln(stdout, s->cfg.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
 		} else {
@@ -1838,7 +1838,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->s.r->index);
+		discard_index(s->r->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1849,8 +1849,8 @@ static int patch_update_file(struct add_p_state *s,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+		if (repo_read_index(s->r) >= 0)
+			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
 	}
 
@@ -1863,11 +1863,15 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
2.51.0.417.g1ba7204a04.dirty

