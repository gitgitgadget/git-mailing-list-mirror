Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16032E6A0
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056188; cv=none; b=KESx2YzyiUjHCO1Kv/wBgwgBgf+v436FqpNnx0X5MugqW4ueS7gb5Y6Qj2mswsgjHYf8E1P7YON2OVEavpMSe/OHY4nxM+waN1z58nLTn62FoZ5FGWYfrcKYJ8A672PUOtrMH1kCohg7D82X6x7dwNlGza6k1nOzashHR9u9Zf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056188; c=relaxed/simple;
	bh=x8wQlzszdVFlRh2XsAtBG5jOeM8YDik90R9WDPCevlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRwqCrb5qC7Zh5fSgnAdnOnqgz6zXGtFdeBXkwRwplJb+b4EvIArxqeh73+UX2ai6WwJXQujRXNXN5Ny1v2ENB9ho3d2uDERvoz0hqQQJ1BeulgH7bTbQN3ayf1uD/SPfz4VYFIYO2Wy73jr0tmNlzonaYgHPkYhLBNlzP/ydBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzzdD+c/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMxlpu4/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzzdD+c/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMxlpu4/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57D5114000C5;
	Tue, 21 Oct 2025 10:16:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 10:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056186;
	 x=1761142586; bh=KyicF50Df40f8MNmmfSuKadHQvq7kbmoXAHwV7kybo4=; b=
	hzzdD+c/6nqa5/E5l7SSubB6e9Rk0y1May+UikRCs0v5xffI1XiBk7D6A/Tg2va+
	DJOHDXAWCAsj0jFOQaM474Kh+JWKUz7njw7PeU6fOTidlB01oUgFDjF1xJ273wUG
	PKLe1k2Vddta299fg0+Wos1I3q46Du0UhVPHdH3TCQRrKijYrQutkb/S4ZIUyzfC
	UGZIbOpCFDJ0SO6VdS0+okV1Dg0FDNkulVAVdAXqjp01k0SKMUwOXLwTNwQMahLi
	lFtigDJYE8l+9k5iGm/4UriM7wMSprlXAO7Lf0e1brPfBpz3VPP42hyZ+xsTwnVV
	7k6ZWvklakHD8pJIPd+vwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056186; x=
	1761142586; bh=KyicF50Df40f8MNmmfSuKadHQvq7kbmoXAHwV7kybo4=; b=F
	Mxlpu4/DqEmDV2q5Ta513ud/IXND7es6kkUUos0R/iDNx8rQe7H/rFBmRsY+lDEG
	/I1+vbzUrpaND6C++i41tXxHT8PDd/xJMjKrgkftkjWmF6x2coJaRX8gjcVwyHJc
	uK9Zh7oIXUiDbeEAql3ri5H4ABbW6u2aYPE7VoIfBqBxCcg+/OYO+gf7oRLgsFgS
	6cvvnkNyALZp+FRCYYvQE26mIdLZ8Vpe8DvemHop5qaGU0Ji/HUc22WQR4Zp999U
	QWtud56T+UOXl3hGDD9BCXdVpyrY0UNXqIwCMBSagIlptSHy1R1R4g+mk00p1LDW
	VE3ztzHAZdyJmStrU/pBg==
X-ME-Sender: <xms:upX3aHLDApFFV1_xP0pZOBGNVphvYhPLxKl5F4N_lZaMM9juqn9a2g>
    <xme:upX3aNuDkXWD-VtPsWyPvZXj7JLqd89pYRpRpKPLCx6lblbZHmi-sP6pEBfzmhzzo
    HaLmzz1doL1C_Znhm7E2HSMQflWkPSxJ1QxIDDUNu3plBEzSEfFuA>
X-ME-Received: <xmr:upX3aDW7bcpB64HpeMSk7lCuDcPQpy1WjnS2b9A6to7efhfckQlG82Pq8fBlsei8UArj0GB0fBznnm2DSQzluP8SH4_9lHRLufyHDjLrcVfAIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhorhhgrghn
    ohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hr
X-ME-Proxy: <xmx:upX3aAgJU19N3k7zT1Stp6P3GkbU3TCBHFgri5EGlvsIoRv4MJfHNQ>
    <xmx:upX3aDo4WPV7WH_4Tx2v8095-xWWIhDc99NzZpJeuaUdobXZ8_VX6g>
    <xmx:upX3aOHCLewA5uzSxKMCZ9hS0l_Ldf0BK8aagjJd7g9sBxfpOFCUpw>
    <xmx:upX3aA4cBTue-fcQlsPhw2tLFLfw2MFldVrj2PMvNNXrvctkNpzRIQ>
    <xmx:upX3aOE-1oU3M3ZP5Sq-F9FuIqMXuRJzWpXmtdoNy404FgygRQh8ZxJH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f817585 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:58 +0200
Subject: [PATCH v5 10/12] add-patch: add support for in-memory index
 patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-10-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
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
index 362726c962d..b8d46d54a2e 100644
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
@@ -1903,7 +1907,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->r->index);
+		discard_index(s->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1914,9 +1918,11 @@ static int patch_update_file(struct add_p_state *s,
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
@@ -1929,6 +1935,8 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 {
 	struct add_p_state s = {
 		.r = r,
+		.index = r->index,
+		.index_file = r->index_file,
 		.answer = STRBUF_INIT,
 		.buf = STRBUF_INIT,
 		.plain = STRBUF_INIT,
@@ -1987,3 +1995,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
2.51.1.851.g4ebd6896fd.dirty

