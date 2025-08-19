Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE4322C87
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600996; cv=none; b=h324x3EKtEvUvl4+DOSKYuaaUJxdwflmy6eoMIRsAuwlxXfvgXuO/d8T2UOX7gV1I4+lxQH7sDx9xGub6vuHC+zHmNZEE0TNcj41QYtZ9zSigpJUmyFATh2J50WBtbBQ3ZcmDChrKI3N1LPtQmZNMo7vAhD0M48BFJTlEZB6SEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600996; c=relaxed/simple;
	bh=5h6bkPW5X0MknNDFjGZtdQrGkoR5m9l2GEkt0O53kWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKLk00qvDQlzw4UKlb8GUpfxqyB0BGM6E5s8xtToWAl+WQr3q4ipNNI5EX28ow9RHBK0zXZylbMa7PGU+cIa1BjTUaYn6b1MfI54Bll/rWuzWAf8le65vqQj+XVG5UgB1Tm1W2MzQlpf01TO3u2erJ5Ls8JNZq+d590PLeyzrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mDf+WvGh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIpzKF53; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mDf+WvGh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIpzKF53"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DFE6A1D0020B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 06:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600993;
	 x=1755687393; bh=SCyYqiRyZkQ/ed3Yapgwig8+xL+l8/vz1wxQT3VkLyk=; b=
	mDf+WvGhQQZvMS+AYL19tNgVaL1tiMV9/pr0DSpZkvYIefutGLhdh38Aonc8tUux
	+RPDlp5+nJFH5TDZveyUStKEVMfYtg68O/PGUUpFDeICpBMlnOXhe0nXIjamJI0F
	ElJa+cSXbUHbAMFRX9783zUVYlHQpqlYFF8SJK5zUgkSrMLHJw5rip1VD5t9bX9/
	FTWfyXzo3zOyt+795ghyX5fAhN+knv71BEU/wiEPvPXEEVAOu6RewO8ku1+fpYcP
	Syk7/CMqhsMGh/E1qHop6gAKeeOo0ceftLgNGG6+89L//4WpEnDIIZ6VSGwHuwFo
	ilPAIKGma7p6//XKCOSWYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600993; x=
	1755687393; bh=SCyYqiRyZkQ/ed3Yapgwig8+xL+l8/vz1wxQT3VkLyk=; b=k
	IpzKF53ER4QSaAvlVfnxaINOC8SdqCoJ0rfLMic7SZClDj+DSspCf/CRdCzgGi4i
	23SfdUVkqy3be+wuTTmrkw0TzD2+z748BOh1JDyPasd4+GnPXN/P/U2XnhPTTgHa
	DvhelaSSaE0zYjPlc5vsSBgmGuQYt5pIqdkl1uC0Ty/QXeE7XfQrxaEkIE8/Chfu
	RqGxmkUAfd7h3FN0mGpUeqQc1kfKRoPeR2n3z8WR5OENQiDrieUd7XBsCk0t3BUX
	xPNkpAOYAMlhoLx5S8jjSCU6t5BQYDZH2deo47T9hTGuSkcbvdzaXq2LZ7ny57+n
	eGdkIoFeBPyilUKHIO7mQ==
X-ME-Sender: <xms:YVikaJYSYV03hBLlPbpgiV8b8_ITJg_ccGhPa6TwDB01PKyMKU2Gew>
    <xme:YVikaCYZcqt48iDQQCHXUJYqP3lSSP7xNcJh--1YwYLCfKTwiQsq0g9he8cDWzpug
    3TTlU1oE773wdSJTw>
X-ME-Received: <xmr:YVikaFVaqg09M2yDYgvXUQWJl5ynfpgAX_lpseozoO9Aj0xiTNnX6xXjY6CYk2G5G9ucrjPeMcqIyfxqU_a6hF7f4T_7SSJBi-us3Q6AH4gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:YVikaJ3JMXwgivKxut1hWJ4h7jiSqOcQgOP2KsKbxWRYzLUVyMol5A>
    <xmx:YVikaMbSvGAA1iC5PJpFEEKGB6wysr7LlVl4Y9QcubmYVLAR2W-XKQ>
    <xmx:YVikaMqrSue4MK_kjuyT_vgbAaLKxj59-EuTbxXYZOry3nnlmtIyqg>
    <xmx:YVikaIpA7vP5kq7kmPjXPrhz790-C4q37J3IRIvJrsreAT8ATMzLWg>
    <xmx:YVikaMyPhvk9VhiDbN2JpzoxovVyyyabVPXsoB-h3BTla0pVsLOs8Iie>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f01b293c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:56:06 +0200
Subject: [PATCH RFC 10/11] add-patch: add support for in-memory index
 patching
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-10-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
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
 add-patch.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 add-patch.h |   8 +++++
 2 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 1bcbc91de9..adef20c02b 100644
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
@@ -1849,9 +1853,12 @@ static int patch_update_file(struct add_p_state *s,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (repo_read_index(s->r) >= 0)
+		read_index_from(s->index, s->index_file, s->r->gitdir);
+		if (read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
+		    s->index == s->r->index) {
 			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
+		}
 	}
 
 	putchar('\n');
@@ -1864,6 +1871,8 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 {
 	struct add_p_state s = {
 		.r = r,
+		.index = r->index,
+		.index_file = r->index_file,
 		.answer = STRBUF_INIT,
 		.buf = STRBUF_INIT,
 		.plain = STRBUF_INIT,
@@ -1922,3 +1931,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
2.51.0.261.g7ce5a0a67e.dirty

