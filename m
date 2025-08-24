Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088B2D661D
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057448; cv=none; b=N60MOaMgTjc+L7D/h3WxqCbImfrh4mUvzbC5ERZxcNF+WPG8GXu+6dZYCZ2etc3HIENEi/39VlBgtkfRRWOojgrtl3dnQ3EG2AqEb01dZUVaV52rnyusnqGbjO0s1S64XVHvJn8XGJqSPKXsfg/hdDZqnL56obY11FUbp88IBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057448; c=relaxed/simple;
	bh=Ps0YlrJFDcDUegcgQeSB5OvEUT49XIDxuJWzLOjU01k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvcPGJ21xI+7wsEq0iQBU49ekgQTnot8SbfCIsGqIsOkH3SOQTDKbNzMf+FdE71A/BKB17WjhJ2QN03FrHtsrgJ4HHqNbcsjyVDRk6unwKZ4gr+lvXxfLw0jUUion4FSagcOvirGwxuDrtWwFc+yqt8/z1YSK6fPy4i9ce4Rosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHWRCYXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N41xcrDZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHWRCYXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N41xcrDZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D9AD71D000BD;
	Sun, 24 Aug 2025 13:44:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 13:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057445;
	 x=1756143845; bh=uEV0b2IxdouL8K5+9Tm7h6i3/RihuQd4ueklFsu2AZE=; b=
	fHWRCYXfXFi4/H0kFlXjpEAxpEbxQymhTuwwShuwf0vRUomvElcx6GUZ3oqH7big
	MXvqgPm10QvWb1u1ye2JGIhu0151TO7omOmprH2vSwcz2Vu4cWQrSpUu+btXNs+B
	+wd+kYMRXG0TKmCi3y6ybqhGpUVe0tvv2w3U3I5OOHb2xOKLsUqRpHy+D0VtzMNk
	Si+iptCVRm0YpK96k6GJ8QdleHycs1uaMaSXasdXffyKszOAD9d4Stp1jdKKFdnw
	+CVp1nJddUcpLgHvgLvXWuZJptWPspFYgzUH4++BH/4wGaOzfiMl1FvzwkZmQPzr
	UukvIkO+yH9yE0EjXmKPxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057445; x=
	1756143845; bh=uEV0b2IxdouL8K5+9Tm7h6i3/RihuQd4ueklFsu2AZE=; b=N
	41xcrDZw6A7iYJtMtACWI0J3RZBWMrwwe2KVhEsMaFGZhAhAz3GgCQgTvkrUdvHN
	q1SQKEj4vRXmdI9SXlke3zUQXu0Lq19AHy5jkDPo2BkDQMRyeFo15Qy2yIQZ9YvA
	lamOqVlLGYqrsqppVt+0s9V+E97LpVrk+ev/rSiDAohVzd2lOhnN4PunS47NXYVR
	wL7bXthURTcS+bJ/0vif+MWgjeJU87w+iNXtIyP4On7ew7Xhgf6Sb0aj9AY0hfww
	hFVbYCyTA0S5bHAOjQNKEBugQk/h2tn8dFzQPFsQh/Wexfz+6pMC5KoK1xWD/ok5
	pwJG90v2wJ3F1lWh9eSCw==
X-ME-Sender: <xms:ZU-raEknKweKnVT8piIm1K5HhFgy2qozYG1dmcHeTFLTbtg-bVfmfw>
    <xme:ZU-raBYsO0NdP76hQHGtxD49KtDIwr0p3q8Q3jyITqzFCETdJXJqTZ7RWNpurCeZm
    9vIpja9ygM_YMhmLQ>
X-ME-Received: <xmr:ZU-raJH3xBClXiXWSdVGNnPdxeFOQxhVyqxb4awwDcPpK1jKVBaIJeMX-7A4d2zzcDIdqA6eksP5l_mYdTZi_PHetns3sRsnS5cnJfFS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    hrthhinhhvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZU-raCKDqlmYkh-S-iOqVLPZ900_-B50yhiVwNC1kpjGVWkHjoSy_w>
    <xmx:ZU-raEPBDxF_MJiT46dufcDBl94bORMaO4mVtzhhTDoWZkND-zBjaA>
    <xmx:ZU-raCnX9SJYA81r8p5CrnJmHz20UCfb1l00j-H-VFTS0o-29QOMGg>
    <xmx:ZU-raI5tMDhYCmdf3lpU2UR_ad51c6HWD_PxGSLKn0V8iThoZ_zcJA>
    <xmx:ZU-raPT5_83pRuu9z6rceXhou2X7DZLr0dDbOshY6SHRSoUcTI5Diy4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:44:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1e631ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:44:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:26 +0200
Subject: [PATCH RFC v2 13/16] add-patch: add support for in-memory index
 patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-13-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

With `run_add_p()` callers have the ability to apply changes from a
specific revision to a repository's index. This infra supports several
different modes, like for example applying changes to the index,
worktree or both.

One feature that is missing though is the ability to apply changes to an
in-memory index different from the repository's index. Add a new
function `run_add_p_index()` to plug this gap.

This new function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 add-patch.h |   8 +++++
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 1bcbc91de9..2a72c7b931 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -4,11 +4,13 @@
 #include "git-compat-util.h"
 #include "add-patch.h"
 #include "advice.h"
+#include "commit.h"
 #include "config.h"
 #include "diff.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hex.h"
 #include "object-name.h"
 #include "pager.h"
 #include "read-cache-ll.h"
@@ -263,6 +265,8 @@ struct hunk {
 
 struct add_p_state {
 	struct repository *r;
+	struct index_state *index;
+	const char *index_file;
 	struct interactive_config cfg;
 	struct strbuf answer, buf;
 
@@ -414,7 +418,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->index_file);
 }
 
 static int parse_range(const char **p,
@@ -1838,7 +1842,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1849,9 +1853,11 @@ static int patch_update_file(struct add_p_state *s,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (repo_read_index(s->r) >= 0)
+		if (read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
+		    s->index == s->r->index) {
 			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
+		}
 	}
 
 	putchar('\n');
@@ -1864,6 +1870,8 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 {
 	struct add_p_state s = {
 		.r = r,
+		.index = r->index,
+		.index_file = r->index_file,
 		.answer = STRBUF_INIT,
 		.buf = STRBUF_INIT,
 		.plain = STRBUF_INIT,
@@ -1922,3 +1930,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	add_p_state_clear(&s);
 	return 0;
 }
+
+int run_add_p_index(struct repository *r,
+		    struct index_state *index,
+		    const char *index_file,
+		    struct interactive_options *opts,
+		    const char *revision,
+		    const struct pathspec *ps)
+{
+	struct patch_mode mode = {
+		.apply_args = { "--cached", NULL },
+		.apply_check_args = { "--cached", NULL },
+		.prompt_mode = {
+			N_("Stage mode change [y,n,q,a,d%s,?]? "),
+			N_("Stage deletion [y,n,q,a,d%s,?]? "),
+			N_("Stage addition [y,n,q,a,d%s,?]? "),
+			N_("Stage this hunk [y,n,q,a,d%s,?]? ")
+		},
+		.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+				     "will immediately be marked for staging."),
+		.help_patch_text =
+			N_("y - stage this hunk\n"
+			   "n - do not stage this hunk\n"
+			   "q - quit; do not stage this hunk or any of the remaining "
+				"ones\n"
+			   "a - stage this hunk and all later hunks in the file\n"
+			   "d - do not stage this hunk or any of the later hunks in "
+				"the file\n"),
+		.index_only = 1,
+	};
+	struct add_p_state s = {
+		.r = r,
+		.index = index,
+		.index_file = index_file,
+		.answer = STRBUF_INIT,
+		.buf = STRBUF_INIT,
+		.plain = STRBUF_INIT,
+		.colored = STRBUF_INIT,
+		.mode = &mode,
+		.revision = revision,
+	};
+	struct strbuf parent_revision = STRBUF_INIT;
+	char parent_tree_oid[GIT_MAX_HEXSZ + 1];
+	size_t binary_count = 0;
+	struct commit *commit;
+	int ret;
+
+	commit = lookup_commit_reference_by_name(revision);
+	if (!commit) {
+		err(&s, _("Revision does not refer to a commit"));
+		ret = -1;
+		goto out;
+	}
+
+	if (commit->parents)
+		oid_to_hex_r(parent_tree_oid, get_commit_tree_oid(commit->parents->item));
+	else
+		oid_to_hex_r(parent_tree_oid, r->hash_algo->empty_tree);
+
+	strbuf_addf(&parent_revision, "%s~", revision);
+	mode.diff_cmd[0] = "diff-tree";
+	mode.diff_cmd[1] = "-r";
+	mode.diff_cmd[2] = parent_tree_oid;
+
+	interactive_config_init(&s.cfg, r, opts);
+
+	if (parse_diff(&s, ps) < 0) {
+		ret = -1;
+		goto out;
+	}
+
+	for (size_t i = 0; i < s.file_diff_nr; i++) {
+		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
+			binary_count++;
+		else if (patch_update_file(&s, s.file_diff + i))
+			break;
+	}
+
+	if (s.file_diff_nr == 0) {
+		err(&s, _("No changes."));
+		ret = -1;
+		goto out;
+	}
+
+	if (binary_count == s.file_diff_nr) {
+		err(&s, _("Only binary files changed."));
+		ret = -1;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&parent_revision);
+	add_p_state_clear(&s);
+	return ret;
+}
diff --git a/add-patch.h b/add-patch.h
index 51c0d7bce9..d0edfec936 100644
--- a/add-patch.h
+++ b/add-patch.h
@@ -3,6 +3,7 @@
 
 #include "color.h"
 
+struct index_state;
 struct pathspec;
 struct repository;
 
@@ -50,4 +51,11 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	      struct interactive_options *opts, const char *revision,
 	      const struct pathspec *ps);
 
+int run_add_p_index(struct repository *r,
+		    struct index_state *index,
+		    const char *index_file,
+		    struct interactive_options *opts,
+		    const char *revision,
+		    const struct pathspec *ps);
+
 #endif

-- 
2.51.0.308.g032396e0da.dirty

