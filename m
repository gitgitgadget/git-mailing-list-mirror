Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492942F12A9
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758948; cv=none; b=dANmSwlI35MAw0w8cOHhab0wNEWTfWHd9n79uYy27Exk99neLfq2UgxexALX3h8/3EpIRvWGfUS+111GwaEGX/DHNIn102sayOG2A1QMk5XILFpdMsTvXWjGKIY30Ii4xvkp1cmABkOMwEP3JPCijyGmfiQS0uWgvO6EdYMINnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758948; c=relaxed/simple;
	bh=galifMtmuzW+nws3g8bdZ46gDfW0GTk7KQA6D7QL4m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2A2phrnzHSAa69asCleI6LB+ZmbCqVE3fZ/UWp5AJyjRScO2phZYJIGgVjOUs/PP7NsnvbGFrUb+JaG4y4tj2gJp9iRo5fOQpHrncqX/NrTtbh0bmEi5qynUmTa/XfgBz+1gibNNui8QGNlOILssAmADODFILsd1WVXS7H5we4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M50mGhc5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izjiVsAz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M50mGhc5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="izjiVsAz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F2F7EC0549;
	Wed,  3 Dec 2025 05:49:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 05:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758945;
	 x=1764845345; bh=rt0wjhIUclTKTQtBDc2dxMQY5ggqvhLUbpKkxR533/Y=; b=
	M50mGhc5WKTTZ0yaTjlYowIIcpL+qqs3ER0D1hBwd68YxQHxAtHgoDkFJvc7f65l
	GaCrPpB3mXlOvmq3zZwJGTFuQMrLEdvoLiuCkGNi/3dyNGwKSO10+2s4eh2htigl
	AEDl1bUvDADduhElpW88QdUivn3SZ8RubXLJSdtQvQkUPdzpKoz5Sll7+TnSYUAe
	5XZHFQtO06Dya4QHveIwlWDgzx1veljwLNuUx+nr9yfjgUyeab1VQOLS1Ir4bX+w
	R4zJdiqfP5/HrRKzHSLbDnnruI7D2tWw+GxdytkONW3xaoAiFLGbZ26D4l+NYtjf
	3qaikfg3rmCSAbR7rVdOkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758945; x=
	1764845345; bh=rt0wjhIUclTKTQtBDc2dxMQY5ggqvhLUbpKkxR533/Y=; b=i
	zjiVsAzpCSnDNrKd3gkL5JKhiEb6PyUP+pwwnWsM034LJ1hZPwDcmN5IwgQpj5gY
	vOMXtB7hLQnwFA8ABZLIVP1kvQmwUfRE8DZE9FtgYK5C9Dk9HhS+rdwRXVMS7rwq
	JntG3nuQLHWg4uiR5RwQSzzarEm+mGz2UNrBhn51imvSH/efcMrGIOAWjbH6xTKC
	n3b9H1/VqEZpCnBnfnr42hdvbfSwyf+eomCBVki8pcs7DGQPjO0ahd0x5HUX6mHh
	btTx8kis4dLKqcMhEr/IeKx0HwC/3zk9x3l3ZikdqFb8ZGNTxUG2NB3MJfD/qENx
	ebVO6B0MA86Rd681iKZlg==
X-ME-Sender: <xms:oRUwaaaq6YWcn97t4KyPOALgj2Qmza0gRNrryAfaGDkpV95NPtHWtw>
    <xme:oRUwaaSh9L8HOOFZjsQ-PS5OHIxd43yp__y9FjkfB-vkMwK1IxsbN6nQmrd32hm7V
    mw_Szmi70RLIXC0Lr-E4VTvq4bOL8fMZ0z70MftZpNUzjZC4RZknA>
X-ME-Received: <xmr:oRUwaUvgHs1l882jRg3BngpSqoR-ZT4uQwKrPgTL9VgZ44eTqYIpGHmmwwcMbFAy3ZJer4cIqBci1QmScsukglRGr005yTwuZ8WChaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhii
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oRUwacERTWRMXmOMpksLYmHKDdahT4UrKYW0tnm9-ZvAuw7DpFLB5w>
    <xmx:oRUwaVyrUcBQqekelhTn67FbW3pjzH-xllbjJALqq6UazxRb5IYp2w>
    <xmx:oRUwaW2akcyNFbfgWWvMXHHjEn8S4BkONABFls_poGCJkYDvYRlM_A>
    <xmx:oRUwaVqVBEV8ijkzAaCSqH3CYcfbIu3mT0zwOiYIe6IdoR5gFUbatA>
    <xmx:oRUwaX9GjLgURa-5MVhWjVpbn0njzDlzTjMgZfQkMuMsRGw9x4j4lbEk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:49:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 189b244d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:49:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:36 +0100
Subject: [PATCH v7 09/12] add-patch: add support for in-memory index
 patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-9-9e9f849bfd0e@pks.im>
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
 add-patch.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 add-patch.h |   8 ++++
 2 files changed, 128 insertions(+), 19 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2780738153..31d82a3e22 100644
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
@@ -47,7 +49,7 @@ static struct patch_mode patch_mode_add = {
 		N_("Stage mode change [y,n,q,a,d%s,?]? "),
 		N_("Stage deletion [y,n,q,a,d%s,?]? "),
 		N_("Stage addition [y,n,q,a,d%s,?]? "),
-		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
+		N_("Stage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for staging."),
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
@@ -1905,7 +1909,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1916,27 +1920,54 @@ static int patch_update_file(struct add_p_state *s,
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
 	return quit;
 }
 
+static int run_add_p_common(struct add_p_state *state,
+			    const struct pathspec *ps)
+{
+	size_t binary_count = 0;
+
+	if (parse_diff(state, ps) < 0)
+		return -1;
+
+	for (size_t i = 0; i < state->file_diff_nr; i++) {
+		if (state->file_diff[i].binary && !state->file_diff[i].hunk_nr)
+			binary_count++;
+		else if (patch_update_file(state, state->file_diff + i))
+			break;
+	}
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
 
@@ -1969,23 +2000,93 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
 
-	for (i = 0; i < s.file_diff_nr; i++)
-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
-			binary_count++;
-		else if (patch_update_file(&s, s.file_diff + i))
-			break;
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
+	struct strbuf parent_revision = STRBUF_INIT;
+	char parent_tree_oid[GIT_MAX_HEXSZ + 1];
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
+	ret = run_add_p_common(&s, ps);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	strbuf_release(&parent_revision);
+	add_p_state_clear(&s);
+	return ret;
 }
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
2.52.0.239.gd5f0c6e74e.dirty

