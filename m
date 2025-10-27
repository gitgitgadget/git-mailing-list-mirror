Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE612FA0CC
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564873; cv=none; b=QToPtQai/gN3r7dIh7GzflyxxuFIspbu9Rmk81lt2aQlh31vlilneAbnlWZwSZWXyIsDiYT4vFliIVsAF6aZsf8fidB0r45EAGd1yckfPg9iW7bKYe5lzqx65tYRphQhc/TfkW/eghQQWWsi0Vg0cvG7YcrgN6UYEgVt9+LDgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564873; c=relaxed/simple;
	bh=fArddO2nSElE18tZ7cXQ+9eFb+23ytnCxfSeWxyOVt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuT4WErVC14H/AfBiS4nfL424JDliPmvnu6WYZu/avTupr1rFmZ3S8tBKABBlJEav6n8r17FNEx0V4OaFSNACvOf6b5OpyrUUgQQhA8TTyyRYM4Wh6jNC3TIDIRVprJBy6/2LRXnuZWcVze69SNhOW72nX5ab4ccmb7zVSfnCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KGgr0aE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUS9OPpw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KGgr0aE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUS9OPpw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B3EFCEC0329;
	Mon, 27 Oct 2025 07:34:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 07:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564870;
	 x=1761651270; bh=2PD47up70JyY30N21WNo3zx3OMaxuH6cXpU8GPh0g28=; b=
	KGgr0aE0wsSFYizYkJVpWNu0Z9/AT1i8VRxC4LrWsr03sBzeDWW4ytJ1MawQSud6
	6JiIGRPUW9nQ8Au8nqim3VLsjt9FNERxvTWRqjzLj8iFmIl2AfI/2KQhqhrcbAgb
	uKWphggsvdUqInFiS6SXgcp/GM1CvnI36kSv2f3ItZmYxTIeZ4eX4oVxvxD8kSvi
	xbjk/WRzxhRUFiUESxDDtVVav5JZuMKAPVZzs6CaAC+KOM6cXUncPguIeeOHwsVb
	gAoaHw420aWtpmVFsPxbBYqqSqT8n1SWxHvkiI5qPUYnLhqH9ZV4aJrr/+WxZ/45
	ogzGjrmsthdEjvz4+cxSZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564870; x=
	1761651270; bh=2PD47up70JyY30N21WNo3zx3OMaxuH6cXpU8GPh0g28=; b=G
	US9OPpwv2EVhFm/ZnSg/d9Cklab3OQ2P2kh7EaPZXQ2VYThTInSxwnhZ8BI7/LoX
	KzHWDSUoy+REXEqhbpk3++Kp004jjdyTYPa/lybjSZTNTVJlJ3avr9JttLP0no8v
	D12I7x7JsbEUclzQb/0iQmBos/UAMb0jSyaPeutGoRp/5XXkCGKCAHXFkwcj9MN9
	hQpumO0XSZB8tOBWbxuzrYX/dq/ubWY6Ppwo6enuLpZ5TKWpKceFayKQcwdQM2YD
	TbQkrbFA9elg1+q35ljMx5A1HR161bBgTGiE64h5euOOnMm5LGRzODlyGHcP3ZEj
	ORza6aQBMUchGuhn6xnCw==
X-ME-Sender: <xms:xlj_aOLlQXoE4waFsBCqFsrSdmdjP3FMq5x8XSKL7b-12zJKs5TUsA>
    <xme:xlj_aIvNo11Sa2wR5heCqtTX1aOfRWJGJ67OHV-3qu4KS9MxTOwBDkRgFr_PGuM6x
    hPfFhU1B2DLbIUEKs5Y9ZAj_tlFqyMGOan5ivzu_BdeM-Wo8AcG6w>
X-ME-Received: <xmr:xlj_aCU7q5Y5Yy6nnPKG-u0BR6K8AhEyz9wQqfuBHtH_B4pV22ls1HXryhGqHQA3ncQKMpJCY5qIPpZcuHmFGaXPpd0uXz5JCmgy4-4_gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghn
    ohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hr
X-ME-Proxy: <xmx:xlj_aDgitKfShRbUGCyX5FZCyW02xruHvWzKa42i9uecWg4HMYQHWw>
    <xmx:xlj_aKoRkds7u4wPv5nUQ_IURWeMJ0CqnVH5RrCJgmxJuHmsacHgZQ>
    <xmx:xlj_aJH3_JgxB9DbfRCFuy0Go7gTQq6l7G_kL_jB9zypnIyFtPcMtg>
    <xmx:xlj_aP6q1CpYOpDxYJAMj7GkJxWKdKhMmbjlpFMSKLDeLEl3K6jGsA>
    <xmx:xlj_aBFgOMdWZ956jJK3hJWRjmKiQtBqjkJhhYaGJX8J5hPO6PzQS86z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e8c4db7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:57 +0100
Subject: [PATCH v6 09/11] add-patch: add support for in-memory index
 patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-9-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
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
 add-patch.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 add-patch.h |   8 +++++
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 790c848e799..9c1688bd5a0 100644
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
@@ -1904,7 +1908,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1915,9 +1919,11 @@ static int patch_update_file(struct add_p_state *s,
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
@@ -1930,6 +1936,8 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 {
 	struct add_p_state s = {
 		.r = r,
+		.index = r->index,
+		.index_file = r->index_file,
 		.answer = STRBUF_INIT,
 		.buf = STRBUF_INIT,
 		.plain = STRBUF_INIT,
@@ -1988,3 +1996,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
index a4a05d9d145..901c42fd7b6 100644
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
2.51.1.930.gacf6e81ea2.dirty

