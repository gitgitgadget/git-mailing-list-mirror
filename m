Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4C27F010
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334300; cv=none; b=fkLuu+ezeJLUBnKoEQqMfgkOdJSALsw3PWB0pYPCMoObx/Tho+6tNDyFrLNeGbyrgNUeJrZ5QmZncZTVakwSz5VRS7fW3Azrij1unzXNFFgB0phLl1YKOOZF8tGe2TwAoK/JzzQnvDy/mBlg7fZvP/Ek+WGkjv/ny9bT+FUPx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334300; c=relaxed/simple;
	bh=ZGU8Qup26GtalYHjTOyhrH+rosIMixBsdcqctbCiPsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVDCton4/OhzXmGzDpDcUmtdRlz2afQIM/b/7g1vGv776uoWzzUKpSt0+VHtSBnL5x1aEYjR9u/+PZ7HcYwFMGWGW9aaVFGLazdGGlxu1a11HMOWcDdBPW343U94ek1ucTjhBTk7kiGVXUvEAcizjiPyuBQ6aMJKc5ghY/rAx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nWCYGm2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xb1cBj7Q; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nWCYGm2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xb1cBj7Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 546247A00C3;
	Wed,  1 Oct 2025 11:58:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Oct 2025 11:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334298;
	 x=1759420698; bh=RDbIdZqf4SH6GYywf06d7mz2m6s0uY24GBl0re7yLDk=; b=
	nWCYGm2FS2C9g5s32jygNbcohBUjozq2PImcg8lEMrCqlKJtipY4MTHCGlkQ7cYO
	ngWUlAf7/IPuN2BgzpNdCKPsFazbFEWRnt3is3nzuebYJ2fVPhWDHuaBqyIWQD2I
	1tJjzNxeFFNurcDwZMHYq1l2oCEcSfldZRUueStLgMgCZiPh30IRi1vpBu5uAs0Q
	6M9z2t6NT+G7dsWBeg1NbWm2rMR/mDoA0diQFAn+oUIx4NFlLhWIsEMtB7VwL+Rg
	dcEgn9uVMZVFgE0IeSv6RxSU46LW06AwIlIBrJaqQs6OqHq5IvqceBOAmyaMyvYh
	IsGz4rBssvOPh/Gnhhtmew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334298; x=
	1759420698; bh=RDbIdZqf4SH6GYywf06d7mz2m6s0uY24GBl0re7yLDk=; b=X
	b1cBj7QwVzJYbwKBBmaGGzHTz96HpP57HlNethGq4olplwNCZvlzoV/JqYVzQ8gO
	stnuZwmA4Mk0LZDDyLGgq+8ySnaXjta+3D43fWQaDYPPoo7flFw3W0NL5wF3RGRa
	5egEzMY/kCj2DCIDLI2ACm6DfNDvJNWyEt46RJaeFylkJ2yAyRtAzWxy3pN3Iybx
	Q0XTnlwh4GZebd6rReV+4YRC7/+eIs4LE5SLpw1MOrJoq6FuRrX4pDpsD14nX4Ro
	BVWLseG/CsWrnGTWUh+UaFvMXfU3DoOCj0Ss6w+A63CiqCJGb7TGhGUuOpYH/bqx
	8vdxVkwH9gtYPIPNlbfhQ==
X-ME-Sender: <xms:mk_daPAbLbudii6jdM56mv44PugGMYcP3P0UK4KXt15UZZ1_zg01KA>
    <xme:mk_daEmA96jRuQiCb0_P5mPQmDxq6MKUqHl1TJe2M7ZjG1qRl9yCs5zpQqwAB-_Q8
    oGiomc2JgW5fDywQVi4S1IEsFdCUl8VpxGtw8wYOdKBevSQEEYU>
X-ME-Received: <xmr:mk_daAzze3M4xM3fKquvHqCofg0ykNuOtuYMEDp4ju4rff-wkZ2peNreDrUG3UdlqllZjIxVEYMgMdBWQvwTSm5t9jy0kSGJ6sVhqzCrZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgr
    vhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:mk_daORhHHQC27OsjmWLSCnDi9TXynnHHZE9O-TtTakedy8aAy48Dg>
    <xmx:mk_daI8Udw4eYQKlTyCwZnDgLXwrvj4_-aFxaGlVz7VEfAByAELf2w>
    <xmx:mk_daMs4uPvTzlUyjJqWZ7PPh74Vy_EvWHcA-vj-Lgwi3HdbLEC8dw>
    <xmx:mk_daAPhXZjYAYj6Wf0GIo8sBXsdpDR19s9s47UWOh0kMGPDTX3s9A>
    <xmx:mk_daLFogiLIhmuzKeea5KQG9eb2RI29CJb59anfcrOIeHZvEVXhmmu1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:58:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3aa7a2f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:58:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:36 +0200
Subject: [PATCH v4 10/12] add-patch: add support for in-memory index
 patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-10-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
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
index 9c0f3b23ef..fac82c3886 100644
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
 
@@ -437,7 +441,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->index_file);
 }
 
 static int parse_range(const char **p,
@@ -1861,7 +1865,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1872,9 +1876,11 @@ static int patch_update_file(struct add_p_state *s,
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
@@ -1887,6 +1893,8 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 {
 	struct add_p_state s = {
 		.r = r,
+		.index = r->index,
+		.index_file = r->index_file,
 		.answer = STRBUF_INIT,
 		.buf = STRBUF_INIT,
 		.plain = STRBUF_INIT,
@@ -1945,3 +1953,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
index a4a05d9d14..901c42fd7b 100644
--- a/add-patch.h
+++ b/add-patch.h
@@ -3,6 +3,7 @@
 
 #include "color.h"
 
+struct index_state;
 struct pathspec;
 struct repository;
 
@@ -53,4 +54,11 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
2.51.0.700.g236ee7b076.dirty

