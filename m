Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180121E1A33
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453604; cv=none; b=GKAkx8kzxNyDVenawMXkdxsoFKkjyPmS6okEcPMu51rk3Y65YzmEODyzccgl1YQOSNUKCpdZMK9lwGOvVC/id60ZeyOr1E+pv96qTzkRR6csf7SfL3FHV2pG6Qo+UPjPqruh2P+vyxX9BeFDiXTLdTTf9ZKiWMNmXYKajA69ncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453604; c=relaxed/simple;
	bh=ZWGBWFZxP2aa9T4InGjaQ4kWgALrgT1ox455DZvJiXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOctkp/k8Qqdh3JvdNEukxUrzJn45KqNnK3CSF9d6i/i8qRCHG+8ztxMZxBk1lJP24S+AGtagF/ASJL9LHjMdLdWVFBr4nuplIm1hGx9F+9Mhe8ij3hv99f1pfNuflYUU9LDOAkBqMKbl2GIadxbSJxgvff6gScbcsDotNXeHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OZEiEzyA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSPSfLWq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OZEiEzyA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSPSfLWq"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DD587A0160;
	Mon,  2 Mar 2026 07:13:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 07:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453602;
	 x=1772540002; bh=86e8BZAxhGhVfQTVzyNvu+Ubcsj4LPooi8Uvps8FoJI=; b=
	OZEiEzyAxBGLfd23hNHX/WD5nL2FouJIylJrCXOGifpjRKnTbNmG+HTTDkrUT4t/
	QnWCTvq6j+M50wXLmD8r4zl6tqAp6tQHlyXPrB7bOhfqI5vXZetRFkSGnOkUZ+nf
	plnu0NmXuGg23M0Ds15tN25cJ6vgcsga9GRHyfXFE0PexHmX9iPCjjc543vUzS8g
	5r2e8u9OKMUk8CXGKXAye7j/mAHc3kYb7OzRLRa6yIUQHYpcMTiWY+FqriDFABYp
	ITSrbJyxSnoe1mVNK1aEDUc+Q9fBHknY5XjmQOCq0MQg3rftx4gfW6TUgXWxMBt5
	VFJvHPBxt85pQ+/NP81Wvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453602; x=
	1772540002; bh=86e8BZAxhGhVfQTVzyNvu+Ubcsj4LPooi8Uvps8FoJI=; b=h
	SPSfLWqY3x5wf33OBcQx6ZWvpZDJzc1hslfxG9AYttqPNwhD/8hZgpa6mZou9zJN
	dIgeC0XcxfPm6fx9bDDlBQhvPY3FGIpNkBoHj/X2q8NM2UocYbOcagFicPYm3tTK
	UFD8MkLn4Gu70M8CYkB7LZnyyk9/TOB1A/ZinozoLWNPA/BPJuhoUPryyEn+X6j0
	i0FT3nXeo5W+3bUchh8aeWwdyn99TeWdY39hIGpJ+Fs/PR/IE1hkV/EBMcX93D8b
	KBn6pWWWYxUcoewUw+1GYPIyujU5Rnra+gSvz2DBaZwRCH3KID3oSFXGWPYJvowD
	psVNQQ+X//TnNegwvQbjA==
X-ME-Sender: <xms:4n6lad7GNjGRekVrFjLnJLpodPem2LH-yJ4yi1f6jvBvA5IXta0y5A>
    <xme:4n6laQ7AOdydqKHG7lGR9YAp2ERFv-QRNHFjTUTcFg1_0dznZVoXYsco0TdmiPHxL
    aOscZerjRWZo5X-l5Y-_YO5FQgkU_uMG1rMQv6LIegSmGMcOK0NVQ>
X-ME-Received: <xmr:4n6laSFQVAx8SyS9tU41jw3YB9r9w99yO5g-ebdMZ21AFyFFFyg_FkEOaPDRyk0UqupOd8XeNYBqjL_oZNWBuYBEyPU9sfM2PHX1ud1RZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeluedujeevudfgjeffgfeltdettdduffejhefhgeevueetgeffgeekvedvhffhheen
    ucffohhmrghinheptghfghdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4n6laRQNKqRM6xXMl7H-VSjN-k6F0KvfL0pKH57r38fbFYRzdghh5A>
    <xmx:4n6laTsH3v1vNGwNqlCtx0bjLrU1zpGPM2RM_2OaXQ-l23kJBL5GXA>
    <xmx:4n6laYwBBAQo4da84ToVKhLzcstuP8S1MnGAL9AuGUT543NsulEh4Q>
    <xmx:4n6laV4jvf_-9wbPJL7KmXED7Gqo-AQv97kETpMt3mrGk-0Prg38MA>
    <xmx:4n6labp_BkpEXPHmJLYSTdNeat_9hsrnNmNl7hZqTOr-qzo1bkGJsrnM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f0cc7e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:08 +0100
Subject: [PATCH 4/8] add-patch: add support for in-memory index patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-4-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

With `run_add_p()` callers have the ability to apply changes from a
specific revision to a repository's index. This infra supports several
different modes, like for example applying changes to the index,
working tree or both.

One feature that is missing though is the ability to apply changes to an
in-memory index different from the repository's index. Add a new
function `run_add_p_index()` to plug this gap.

This new function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 add-patch.h |   8 ++++
 2 files changed, 132 insertions(+), 25 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 4f089c82d0..b4dc7d2293 100644
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
 
@@ -438,7 +442,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->index_file);
 }
 
 static int parse_range(const char **p,
@@ -1559,7 +1563,7 @@ static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					s->mode->is_reverse);
@@ -1570,9 +1574,11 @@ static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
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
 
 }
@@ -1996,18 +2002,51 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 	return patch_update_resp;
 }
 
+static int run_add_p_common(struct add_p_state *state,
+			    const struct pathspec *ps)
+{
+	size_t binary_count = 0;
+	size_t i;
+
+	if (parse_diff(state, ps) < 0)
+		return -1;
+
+	for (i = 0; i < state->file_diff_nr;) {
+		if (state->file_diff[i].binary && !state->file_diff[i].hunk_nr) {
+			binary_count++;
+			i++;
+			continue;
+		}
+		if ((i = patch_update_file(state, i)) == state->file_diff_nr)
+			break;
+	}
+
+	if (!state->cfg.auto_advance)
+		for (i = 0; i < state->file_diff_nr; i++)
+			apply_patch(state, state->file_diff + i);
+
+	if (state->file_diff_nr == 0)
+		err(state, _("No changes."));
+	else if (binary_count == state->file_diff_nr)
+		err(state, _("Only binary files changed."));
+
+	return 0;
+}
+
 int run_add_p(struct repository *r, enum add_p_mode mode,
 	      struct interactive_options *opts, const char *revision,
 	      const struct pathspec *ps)
 {
 	struct add_p_state s = {
 		.r = r,
+		.index = r->index,
+		.index_file = r->index_file,
 		.answer = STRBUF_INIT,
 		.buf = STRBUF_INIT,
 		.plain = STRBUF_INIT,
 		.colored = STRBUF_INIT,
 	};
-	size_t i, binary_count = 0;
+	int ret;
 
 	interactive_config_init(&s.cfg, r, opts);
 
@@ -2040,30 +2079,90 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (repo_read_index(r) < 0 ||
 	    (!s.mode->index_only &&
 	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
-					  NULL, NULL, NULL) < 0) ||
-	    parse_diff(&s, ps) < 0) {
-		add_p_state_clear(&s);
-		return -1;
+					  NULL, NULL, NULL) < 0)) {
+		ret = -1;
+		goto out;
 	}
 
-	for (i = 0; i < s.file_diff_nr;) {
-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
-			binary_count++;
-			i++;
-			continue;
-		}
-		 if ((i = patch_update_file(&s, i)) == s.file_diff_nr)
-			break;
-    }
-	if (!s.cfg.auto_advance)
-		for (i = 0; i < s.file_diff_nr; i++)
-			apply_patch(&s, s.file_diff + i);
+	ret = run_add_p_common(&s, ps);
+	if (ret < 0)
+		goto out;
 
-	if (s.file_diff_nr == 0)
-		err(&s, _("No changes."));
-	else if (binary_count == s.file_diff_nr)
-		err(&s, _("Only binary files changed."));
+	ret = 0;
 
+out:
 	add_p_state_clear(&s);
-	return 0;
+	return ret;
+}
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
+	char parent_tree_oid[GIT_MAX_HEXSZ + 1];
+	struct commit *commit;
+	int ret;
+
+	interactive_config_init(&s.cfg, r, opts);
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
+	mode.diff_cmd[0] = "diff-tree";
+	mode.diff_cmd[1] = "-r";
+	mode.diff_cmd[2] = parent_tree_oid;
+
+	ret = run_add_p_common(&s, ps);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	add_p_state_clear(&s);
+	return ret;
 }
diff --git a/add-patch.h b/add-patch.h
index e6868c60a2..cf2a31a40f 100644
--- a/add-patch.h
+++ b/add-patch.h
@@ -3,6 +3,7 @@
 
 #include "color.h"
 
+struct index_state;
 struct pathspec;
 struct repository;
 
@@ -56,4 +57,11 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
2.53.0.697.g625c4fb2da.dirty

