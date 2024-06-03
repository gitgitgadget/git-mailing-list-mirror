Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7A127E33
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407548; cv=none; b=IpzdcicN6zHkfK+pgGCU3JHvSFFHE6gbRnyscUlSsmVtGTd1pZuQ3VfDXxyo1kGX42qp9I5vlfito013yiPPhMMY4LKsv+uoDTK9oP47O7mYOSp6ZB5WHoR+qACflBOv/0ljdFfdBDd0Qw+wJQlXkCc2jSOkYV0OSDTZoeruhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407548; c=relaxed/simple;
	bh=t1Asl7pMNc2sQllsrtJla4Q6WIB+FIEqR5eP3XIyhX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4wUR/b4rFBOdTXJFt0k5QoBB5zlXgRXDSq3N/zO0pPSZjd6+rZ4v5OeyfpC5vvxG8UNJh4QhAZFmGV9y8bSNi9xzA8pwolHfQDsHYSD6wj78IQreQrU5tL7mPO7myHIutV/z74DdbxAbVykaxX9jXa7AePigABrv42o+9lfN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ogqmRX+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijV7RY3M; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ogqmRX+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijV7RY3M"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 137C118000F6;
	Mon,  3 Jun 2024 05:39:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407544; x=1717493944; bh=XnwgmBIN23
	abKsG6YQ50R5l3wz4gIcenu+wvQm1vNaw=; b=ogqmRX+MIU1iw+TZl/i+x2l0Rf
	VgF2xju4b77ilc55HnJvCDNG3zAa2o5P5keJmCjwES3tTb2V6UGe2ps8ZEmfSvoA
	co/Fr9eiZOsraV9+kqau38z6nzBit/wiTERv5tKCr80B4JYShiu/fyQxcI1Tl0/b
	OxcaDT4HcHKxkkEnNQja7ftvKOs5AUjuaUDLz+Uu9jN+4We7w0W/v3rO5gNyGm7N
	Joo9VVxCd0n/sdUP5hr90RQrvig8SjT9lj6rQr07ZBerpTtgp4B7wf0NOBY6zBGJ
	HbsOMH6xyzEfN5QtcOSuzaDciWgYnHuRd3VmOjTpSYrx0UciEhJ4QKFAVGsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407544; x=1717493944; bh=XnwgmBIN23abKsG6YQ50R5l3wz4g
	Icenu+wvQm1vNaw=; b=ijV7RY3MjtQ+bHQUmvOh8560SFqv6jj5/NEF30P3Wh+8
	x9pLIsRNk6TYwOU39BN1x1vJ6PtDXbCT26Ol/3IthEYHf12HbxTr6PfRmCwX931y
	tC75OzL6kpc1gHLz33Tys//t+3NUCzyNaj3S+sWxcw0WQ79jk8mVFRt8fARye8xM
	fDBAnh//DLrCv21iIddOGerzLuFmJjSnBFO3V2RV0Ik68EpMuOvp8ziP9mtolt8s
	ZyST6uqMXAwpvcK4PIsN9gklY1bBNEaJ7oGvId45ttixicRvshIU8mW9ky4h5bau
	6Hbd0GtSSE+tOqdv+QE66yRuSBdHHenPPXMNE/8HwA==
X-ME-Sender: <xms:OI9dZiBej-6blBFt6gwwzfj0rS_r4wAW2rkBLTJktgRiiTn-3AmmSw>
    <xme:OI9dZsjvES8I1NK-rpeQyeO104968oFp5UaMXWAb4sqkffNy6KETvLkwt0wiXC7Xd
    FZFiY2E4Xc1Vlbwkw>
X-ME-Received: <xmr:OI9dZlkg0Zukc6ywZDS2YE9WwmxboIken031XLgxFelqyWHpuTQJyOdchgMlkB0fGiXfcAiFRdM_1VDpZTxSslKwIkFXcSAQm3m5qtU0oiwG3dZL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OI9dZgwoCoBLFkKqnPBBOLTGiwcgJ1YIbw9vZwJz_tBbXkQzQvYgLQ>
    <xmx:OI9dZnSZoTNVad6y19f0vN8VekWANnUjNHhLi5bvP6c2Gkg231g7kQ>
    <xmx:OI9dZrYqg7tc8J54LdIr4EZUzJJK_x2n2qQip_u9FiHClkUVEmhA0Q>
    <xmx:OI9dZgRFnlWFHHRtq73vp1UU66RXq404ZmgAdHeNHUzhmcnsK-TALA>
    <xmx:OI9dZhfxZb_yRqHAzp13upUrrKvGuOzbQlqKfTyiT4vgAiVVduEy64q9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ec71bf64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:38:39 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/27] global: improve const correctness when assigning
 string constants
Message-ID: <e01fde88fe35d6da358af5689320db50750c29dc.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dOmlz/s7kXoYPLSG"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--dOmlz/s7kXoYPLSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to enable `-Wwrite-strings`, which changes the type of
string constants to `const char[]`. Fix various sites where we assign
such constants to non-const variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bisect.c             |  3 ++-
 builtin/blame.c              |  2 +-
 builtin/bugreport.c          |  2 +-
 builtin/check-ignore.c       |  4 +--
 builtin/clone.c              |  6 ++---
 builtin/commit.c             |  6 ++---
 builtin/diagnose.c           |  2 +-
 builtin/log.c                |  2 +-
 builtin/mailsplit.c          |  4 +--
 builtin/pull.c               | 52 ++++++++++++++++++------------------
 builtin/receive-pack.c       |  4 +--
 builtin/revert.c             |  2 +-
 compat/regex/regcomp.c       |  2 +-
 diff.c                       |  4 +--
 diffcore-rename.c            |  6 ++---
 fmt-merge-msg.c              |  2 +-
 fsck.c                       |  2 +-
 fsck.h                       |  2 +-
 gpg-interface.c              |  2 +-
 http-backend.c               |  2 +-
 imap-send.c                  |  6 ++---
 pretty.c                     |  2 +-
 refs.c                       |  2 +-
 refs.h                       |  2 +-
 reftable/basics.c            | 15 +++++------
 reftable/basics.h            |  4 +--
 reftable/basics_test.c       |  4 +--
 reftable/record.c            |  6 ++---
 reftable/stack.c             | 10 ++++---
 reftable/stack_test.c        |  8 +++---
 run-command.c                |  2 +-
 t/helper/test-hashmap.c      |  3 ++-
 t/helper/test-json-writer.c  | 10 +++----
 t/helper/test-regex.c        |  4 +--
 t/helper/test-rot13-filter.c |  5 ++--
 t/unit-tests/t-strbuf.c      | 10 ++++---
 trailer.c                    |  2 +-
 wt-status.c                  |  2 +-
 38 files changed, 106 insertions(+), 102 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index a58432b9d9..dabce9b542 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -262,7 +262,8 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
=20
-static void log_commit(FILE *fp, char *fmt, const char *state,
+static void log_commit(FILE *fp,
+		       const char *fmt, const char *state,
 		       struct commit *commit)
 {
 	struct pretty_print_context pp =3D {0};
diff --git a/builtin/blame.c b/builtin/blame.c
index 838cd476be..98c7629b6a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -134,7 +134,7 @@ static void get_ac_line(const char *inbuf, const char *=
what,
 {
 	struct ident_split ident;
 	size_t len, maillen, namelen;
-	char *tmp, *endp;
+	const char *tmp, *endp;
 	const char *namebuf, *mailbuf;
=20
 	tmp =3D strstr(inbuf, what);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 25f860a0d9..b3cc77af53 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -107,7 +107,7 @@ int cmd_bugreport(int argc, const char **argv, const ch=
ar *prefix)
 	struct tm tm;
 	enum diagnose_mode diagnose =3D DIAGNOSE_NONE;
 	char *option_output =3D NULL;
-	char *option_suffix =3D "%Y-%m-%d-%H%M";
+	const char *option_suffix =3D "%Y-%m-%d-%H%M";
 	const char *user_relative_path =3D NULL;
 	char *prefixed_filename;
 	size_t output_path_len;
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 6c43430ec4..2bda6a1d46 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -35,8 +35,8 @@ static const struct option check_ignore_options[] =3D {
=20
 static void output_pattern(const char *path, struct path_pattern *pattern)
 {
-	char *bang  =3D (pattern && pattern->flags & PATTERN_FLAG_NEGATIVE)  ? "!=
" : "";
-	char *slash =3D (pattern && pattern->flags & PATTERN_FLAG_MUSTBEDIR) ? "/=
" : "";
+	const char *bang  =3D (pattern && pattern->flags & PATTERN_FLAG_NEGATIVE)=
  ? "!" : "";
+	const char *slash =3D (pattern && pattern->flags & PATTERN_FLAG_MUSTBEDIR=
) ? "/" : "";
 	if (!nul_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
diff --git a/builtin/clone.c b/builtin/clone.c
index 23993b905b..92ab7d7165 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -71,7 +71,7 @@ static char *option_branch =3D NULL;
 static struct string_list option_not =3D STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
 static const char *ref_format;
-static char *option_upload_pack =3D "git-upload-pack";
+static const char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress =3D -1;
 static int option_sparse_checkout;
@@ -177,8 +177,8 @@ static struct option builtin_clone_options[] =3D {
=20
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
-	static char *suffix[] =3D { "/.git", "", ".git/.git", ".git" };
-	static char *bundle_suffix[] =3D { ".bundle", "" };
+	static const char *suffix[] =3D { "/.git", "", ".git/.git", ".git" };
+	static const char *bundle_suffix[] =3D { ".bundle", "" };
 	size_t baselen =3D path->len;
 	struct stat st;
 	int i;
diff --git a/builtin/commit.c b/builtin/commit.c
index f53e7e86ff..75c741173e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,7 +113,7 @@ static char *template_file;
  * the commit message and/or authorship.
  */
 static const char *author_message, *author_message_buffer;
-static char *edit_message, *use_message;
+static const char *edit_message, *use_message;
 static char *fixup_message, *fixup_commit, *squash_message;
 static const char *fixup_prefix;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
@@ -121,8 +121,8 @@ static int edit_flag =3D -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorsh=
ip;
 static int config_commit_verbose =3D -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
-static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ign=
ored_arg;
-static char *sign_commit, *pathspec_from_file;
+static const char *untracked_files_arg, *force_date, *ignore_submodule_arg=
, *ignored_arg;
+static const char *sign_commit, *pathspec_from_file;
 static struct strvec trailer_args =3D STRVEC_INIT;
=20
 /*
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 4f22eb2b55..4857a4395b 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -18,7 +18,7 @@ int cmd_diagnose(int argc, const char **argv, const char =
*prefix)
 	struct tm tm;
 	enum diagnose_mode mode =3D DIAGNOSE_STATS;
 	char *option_output =3D NULL;
-	char *option_suffix =3D "%Y-%m-%d-%H%M";
+	const char *option_suffix =3D "%Y-%m-%d-%H%M";
 	char *prefixed_filename;
=20
 	const struct option diagnose_options[] =3D {
diff --git a/builtin/log.c b/builtin/log.c
index 78a247d8a9..b8846a9458 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1283,7 +1283,7 @@ static void get_patch_ids(struct rev_info *rev, struc=
t patch_ids *ids)
 	o2->flags =3D flags2;
 }
=20
-static void gen_message_id(struct rev_info *info, char *base)
+static void gen_message_id(struct rev_info *info, const char *base)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 3af9ddb8ae..fe6dbc5d05 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -113,8 +113,8 @@ static int populate_maildir_list(struct string_list *li=
st, const char *path)
 	DIR *dir;
 	struct dirent *dent;
 	char *name =3D NULL;
-	char *subs[] =3D { "cur", "new", NULL };
-	char **sub;
+	const char *subs[] =3D { "cur", "new", NULL };
+	const char **sub;
 	int ret =3D -1;
=20
 	for (sub =3D subs; *sub; ++sub) {
diff --git a/builtin/pull.c b/builtin/pull.c
index d622202bce..2d0429f14f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -71,48 +71,48 @@ static const char * const pull_usage[] =3D {
=20
 /* Shared options */
 static int opt_verbosity;
-static char *opt_progress;
+static const char *opt_progress;
 static int recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_cli =3D RECURSE_SUBMODULES_DEFAULT;
=20
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase =3D -1;
-static char *opt_diffstat;
-static char *opt_log;
-static char *opt_signoff;
-static char *opt_squash;
-static char *opt_commit;
-static char *opt_edit;
-static char *cleanup_arg;
-static char *opt_ff;
-static char *opt_verify_signatures;
-static char *opt_verify;
+static const char *opt_diffstat;
+static const char *opt_log;
+static const char *opt_signoff;
+static const char *opt_squash;
+static const char *opt_commit;
+static const char *opt_edit;
+static const char *cleanup_arg;
+static const char *opt_ff;
+static const char *opt_verify_signatures;
+static const char *opt_verify;
 static int opt_autostash =3D -1;
 static int config_autostash;
 static int check_trust_level =3D 1;
 static struct strvec opt_strategies =3D STRVEC_INIT;
 static struct strvec opt_strategy_opts =3D STRVEC_INIT;
-static char *opt_gpg_sign;
+static const char *opt_gpg_sign;
 static int opt_allow_unrelated_histories;
=20
 /* Options passed to git-fetch */
-static char *opt_all;
-static char *opt_append;
-static char *opt_upload_pack;
+static const char *opt_all;
+static const char *opt_append;
+static const char *opt_upload_pack;
 static int opt_force;
-static char *opt_tags;
-static char *opt_prune;
-static char *max_children;
+static const char *opt_tags;
+static const char *opt_prune;
+static const char *max_children;
 static int opt_dry_run;
-static char *opt_keep;
-static char *opt_depth;
-static char *opt_unshallow;
-static char *opt_update_shallow;
-static char *opt_refmap;
-static char *opt_ipv4;
-static char *opt_ipv6;
+static const char *opt_keep;
+static const char *opt_depth;
+static const char *opt_unshallow;
+static const char *opt_update_shallow;
+static const char *opt_refmap;
+static const char *opt_ipv4;
+static const char *opt_ipv6;
 static int opt_show_forced_updates =3D -1;
-static char *set_upstream;
+static const char *set_upstream;
 static struct strvec opt_fetch =3D STRVEC_INIT;
=20
 static struct option pull_options[] =3D {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 01c1f04ece..c8d12ee0a7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1249,7 +1249,7 @@ static int run_proc_receive_hook(struct command *comm=
ands,
 	return code;
 }
=20
-static char *refuse_unconfigured_deny_msg =3D
+static const char *refuse_unconfigured_deny_msg =3D
 	N_("By default, updating the current branch in a non-bare repository\n"
 	   "is denied, because it will make the index and work tree inconsistent\=
n"
 	   "with what you pushed, and will require 'git reset --hard' to match\n"
@@ -1269,7 +1269,7 @@ static void refuse_unconfigured_deny(void)
 	rp_error("%s", _(refuse_unconfigured_deny_msg));
 }
=20
-static char *refuse_unconfigured_deny_delete_current_msg =3D
+static const char *refuse_unconfigured_deny_delete_current_msg =3D
 	N_("By default, deleting the current branch is denied, because the next\n"
 	   "'git clone' won't result in any file checked out, causing confusion.\=
n"
 	   "\n"
diff --git a/builtin/revert.c b/builtin/revert.c
index 53935d2c68..7bf2b4e11d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -179,7 +179,7 @@ static int run_sequencer(int argc, const char **argv, c=
onst char *prefix,
=20
 	/* Check for incompatible command line arguments */
 	if (cmd) {
-		char *this_operation;
+		const char *this_operation;
 		if (cmd =3D=3D 'q')
 			this_operation =3D "--quit";
 		else if (cmd =3D=3D 'c')
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 2bc0f1187a..6c5d455e92 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -848,7 +848,7 @@ init_dfa (re_dfa_t *dfa, size_t pat_len)
 {
   unsigned int table_size;
 #ifndef _LIBC
-  char *codeset_name;
+  const char *codeset_name;
 #endif
=20
   memset (dfa, '\0', sizeof (re_dfa_t));
diff --git a/diff.c b/diff.c
index e70301df76..ffd867ef6c 100644
--- a/diff.c
+++ b/diff.c
@@ -3764,7 +3764,7 @@ static void builtin_diff(const char *name_a,
 	return;
 }
=20
-static char *get_compact_summary(const struct diff_filepair *p, int is_ren=
amed)
+static const char *get_compact_summary(const struct diff_filepair *p, int =
is_renamed)
 {
 	if (!is_renamed) {
 		if (p->status =3D=3D DIFF_STATUS_ADDED) {
@@ -4076,7 +4076,7 @@ static int reuse_worktree_file(struct index_state *is=
tate,
 static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	char *dirty =3D "";
+	const char *dirty =3D "";
=20
 	/* Are we looking at the work tree? */
 	if (s->dirty_submodule)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac7..0e1adb87df 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -406,7 +406,7 @@ static const char *get_highest_rename_path(struct strin=
tmap *counts)
 	return highest_destination_dir;
 }
=20
-static char *UNKNOWN_DIR =3D "/";  /* placeholder -- short, illegal direct=
ory */
+static const char *UNKNOWN_DIR =3D "/";  /* placeholder -- short, illegal =
directory */
=20
 static int dir_rename_already_determinable(struct strintmap *counts)
 {
@@ -429,8 +429,8 @@ static int dir_rename_already_determinable(struct strin=
tmap *counts)
 }
=20
 static void increment_count(struct dir_rename_info *info,
-			    char *old_dir,
-			    char *new_dir)
+			    const char *old_dir,
+			    const char *new_dir)
 {
 	struct strintmap *counts;
 	struct strmap_entry *e;
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 7d144b803a..5af63ab5ab 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -447,7 +447,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 				const char *current_branch)
 {
 	int i =3D 0;
-	char *sep =3D "";
+	const char *sep =3D "";
=20
 	strbuf_addstr(out, "Merge ");
 	for (i =3D 0; i < srcs.nr; i++) {
diff --git a/fsck.c b/fsck.c
index 7dff41413e..61cd48aa25 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1231,7 +1231,7 @@ int fsck_object(struct object *obj, void *data, unsig=
ned long size,
 }
=20
 int fsck_buffer(const struct object_id *oid, enum object_type type,
-		void *data, unsigned long size,
+		const void *data, unsigned long size,
 		struct fsck_options *options)
 {
 	if (type =3D=3D OBJ_BLOB)
diff --git a/fsck.h b/fsck.h
index 17fa2dda5d..4f0c4e6479 100644
--- a/fsck.h
+++ b/fsck.h
@@ -202,7 +202,7 @@ int fsck_object(struct object *obj, void *data, unsigne=
d long size,
  * struct.
  */
 int fsck_buffer(const struct object_id *oid, enum object_type,
-		void *data, unsigned long size,
+		const void *data, unsigned long size,
 		struct fsck_options *options);
=20
 /*
diff --git a/gpg-interface.c b/gpg-interface.c
index 5193223714..71a9382a61 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -727,7 +727,7 @@ static int git_gpg_config(const char *var, const char *=
value,
 			  void *cb UNUSED)
 {
 	struct gpg_format *fmt =3D NULL;
-	char *fmtname =3D NULL;
+	const char *fmtname =3D NULL;
 	char *trust;
 	int ret;
=20
diff --git a/http-backend.c b/http-backend.c
index 5b65287ac9..5b4dca65ed 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -753,7 +753,7 @@ static int bad_request(struct strbuf *hdr, const struct=
 service_cmd *c)
=20
 int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
-	char *method =3D getenv("REQUEST_METHOD");
+	const char *method =3D getenv("REQUEST_METHOD");
 	const char *proto_header;
 	char *dir;
 	struct service_cmd *cmd =3D NULL;
diff --git a/imap-send.c b/imap-send.c
index a5d1510180..8b723b34a5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1215,9 +1215,9 @@ static int imap_store_msg(struct imap_store *ctx, str=
uct strbuf *msg)
 static void wrap_in_html(struct strbuf *msg)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	static char *content_type =3D "Content-Type: text/html;\n";
-	static char *pre_open =3D "<pre>\n";
-	static char *pre_close =3D "</pre>\n";
+	static const char *content_type =3D "Content-Type: text/html;\n";
+	static const char *pre_open =3D "<pre>\n";
+	static const char *pre_close =3D "</pre>\n";
 	const char *body =3D strstr(msg->buf, "\n\n");
=20
 	if (!body)
diff --git a/pretty.c b/pretty.c
index 22a81506b7..ec05db5655 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1325,7 +1325,7 @@ int format_set_trailers_options(struct process_traile=
r_options *opts,
 static size_t parse_describe_args(const char *start, struct strvec *args)
 {
 	struct {
-		char *name;
+		const char *name;
 		enum {
 			DESCRIBE_ARG_BOOL,
 			DESCRIBE_ARG_INTEGER,
diff --git a/refs.c b/refs.c
index 8260c27cde..292e8d947e 100644
--- a/refs.c
+++ b/refs.c
@@ -159,7 +159,7 @@ void update_ref_namespace(enum ref_namespace namespace,=
 char *ref)
 {
 	struct ref_namespace_info *info =3D &ref_namespace[namespace];
 	if (info->ref_updated)
-		free(info->ref);
+		free((char *)info->ref);
 	info->ref =3D ref;
 	info->ref_updated =3D 1;
 }
diff --git a/refs.h b/refs.h
index 34568ee1fb..923f751d18 100644
--- a/refs.h
+++ b/refs.h
@@ -975,7 +975,7 @@ struct ref_store *get_worktree_ref_store(const struct w=
orktree *wt);
  */
=20
 struct ref_namespace_info {
-	char *ref;
+	const char *ref;
 	enum decoration_type decoration;
=20
 	/*
diff --git a/reftable/basics.c b/reftable/basics.c
index fea711db7e..0058619ca6 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -67,9 +67,9 @@ void free_names(char **a)
 	reftable_free(a);
 }
=20
-size_t names_length(char **names)
+size_t names_length(const char **names)
 {
-	char **p =3D names;
+	const char **p =3D names;
 	while (*p)
 		p++;
 	return p - names;
@@ -102,15 +102,12 @@ void parse_names(char *buf, int size, char ***namesp)
 	*namesp =3D names;
 }
=20
-int names_equal(char **a, char **b)
+int names_equal(const char **a, const char **b)
 {
-	int i =3D 0;
-	for (; a[i] && b[i]; i++) {
-		if (strcmp(a[i], b[i])) {
+	size_t i =3D 0;
+	for (; a[i] && b[i]; i++)
+		if (strcmp(a[i], b[i]))
 			return 0;
-		}
-	}
-
 	return a[i] =3D=3D b[i];
 }
=20
diff --git a/reftable/basics.h b/reftable/basics.h
index 523ecd5307..c8fec68d4e 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -42,10 +42,10 @@ void free_names(char **a);
 void parse_names(char *buf, int size, char ***namesp);
=20
 /* compares two NULL-terminated arrays of strings. */
-int names_equal(char **a, char **b);
+int names_equal(const char **a, const char **b);
=20
 /* returns the array size of a NULL-terminated array of strings. */
-size_t names_length(char **names);
+size_t names_length(const char **names);
=20
 /* Allocation routines; they invoke the functions set through
  * reftable_set_alloc() */
diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index 997c4d9e01..13bc761817 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -58,8 +58,8 @@ static void test_binsearch(void)
=20
 static void test_names_length(void)
 {
-	char *a[] =3D { "a", "b", NULL };
-	EXPECT(names_length(a) =3D=3D 2);
+	const char *names[] =3D { "a", "b", NULL };
+	EXPECT(names_length(names) =3D=3D 2);
 }
=20
 static void test_parse_names_normal(void)
diff --git a/reftable/record.c b/reftable/record.c
index 5506f3e913..a2cba5ef74 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -116,7 +116,7 @@ static int decode_string(struct strbuf *dest, struct st=
ring_view in)
 	return start_len - in.len;
 }
=20
-static int encode_string(char *str, struct string_view s)
+static int encode_string(const char *str, struct string_view s)
 {
 	struct string_view start =3D s;
 	int l =3D strlen(str);
@@ -969,9 +969,9 @@ static int reftable_log_record_decode(void *rec, struct=
 strbuf key,
 	return REFTABLE_FORMAT_ERROR;
 }
=20
-static int null_streq(char *a, char *b)
+static int null_streq(const char *a, const char *b)
 {
-	char *empty =3D "";
+	const char *empty =3D "";
 	if (!a)
 		a =3D empty;
=20
diff --git a/reftable/stack.c b/reftable/stack.c
index a59ebe038d..09549c51c9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -204,7 +204,8 @@ static struct reftable_reader **stack_copy_readers(stru=
ct reftable_stack *st,
 	return cur;
 }
=20
-static int reftable_stack_reload_once(struct reftable_stack *st, char **na=
mes,
+static int reftable_stack_reload_once(struct reftable_stack *st,
+				      const char **names,
 				      int reuse_open)
 {
 	size_t cur_len =3D !st->merged ? 0 : st->merged->stack_len;
@@ -222,7 +223,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
=20
 	while (*names) {
 		struct reftable_reader *rd =3D NULL;
-		char *name =3D *names++;
+		const char *name =3D *names++;
=20
 		/* this is linear; we assume compaction keeps the number of
 		   tables under control so this is not quadratic. */
@@ -354,7 +355,7 @@ static int reftable_stack_reload_maybe_reuse(struct ref=
table_stack *st,
 				goto out;
 		}
=20
-		err =3D reftable_stack_reload_once(st, names, reuse_open);
+		err =3D reftable_stack_reload_once(st, (const char **) names, reuse_open=
);
 		if (!err)
 			break;
 		if (err !=3D REFTABLE_NOT_EXIST_ERROR)
@@ -368,7 +369,8 @@ static int reftable_stack_reload_maybe_reuse(struct ref=
table_stack *st,
 		err =3D read_lines(st->list_file, &names_after);
 		if (err < 0)
 			goto out;
-		if (names_equal(names_after, names)) {
+		if (names_equal((const char **) names_after,
+				(const char **) names)) {
 			err =3D REFTABLE_NOT_EXIST_ERROR;
 			goto out;
 		}
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7889f818d1..07d89b45da 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -83,7 +83,7 @@ static void test_read_file(void)
 	char out[1024] =3D "line1\n\nline2\nline3";
 	int n, err;
 	char **names =3D NULL;
-	char *want[] =3D { "line1", "line2", "line3" };
+	const char *want[] =3D { "line1", "line2", "line3" };
 	int i =3D 0;
=20
 	EXPECT(fd > 0);
@@ -116,9 +116,9 @@ static void test_parse_names(void)
=20
 static void test_names_equal(void)
 {
-	char *a[] =3D { "a", "b", "c", NULL };
-	char *b[] =3D { "a", "b", "d", NULL };
-	char *c[] =3D { "a", "b", NULL };
+	const char *a[] =3D { "a", "b", "c", NULL };
+	const char *b[] =3D { "a", "b", "d", NULL };
+	const char *c[] =3D { "a", "b", NULL };
=20
 	EXPECT(names_equal(a, a));
 	EXPECT(!names_equal(a, b));
diff --git a/run-command.c b/run-command.c
index 1b821042b4..7600531fb6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -663,7 +663,7 @@ int start_command(struct child_process *cmd)
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
 	int failed_errno;
-	char *str;
+	const char *str;
=20
 	/*
 	 * In case of errors we must keep the promise to close FDs
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 0eb0b3d49c..2912899558 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -36,7 +36,8 @@ static int test_entry_cmp(const void *cmp_data,
 }
=20
 static struct test_entry *alloc_test_entry(unsigned int hash,
-					   char *key, char *value)
+					   const char *key,
+					   const char *value)
 {
 	size_t klen =3D strlen(key);
 	size_t vlen =3D strlen(value);
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index afe393f597..ed52eb76bf 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -174,7 +174,7 @@ static void make_arr4(int pretty)
 	jw_end(&arr4);
 }
=20
-static char *expect_nest1 =3D
+static const char *expect_nest1 =3D
 	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]=
}";
=20
 static struct json_writer nest1 =3D JSON_WRITER_INIT;
@@ -195,10 +195,10 @@ static void make_nest1(int pretty)
 	jw_release(&arr1);
 }
=20
-static char *expect_inline1 =3D
+static const char *expect_inline1 =3D
 	"{\"obj1\":{\"a\":\"abc\",\"b\":42,\"c\":true},\"arr1\":[\"abc\",42,true]=
}";
=20
-static char *pretty_inline1 =3D
+static const char *pretty_inline1 =3D
 	("{\n"
 	 "  \"obj1\": {\n"
 	 "    \"a\": \"abc\",\n"
@@ -236,10 +236,10 @@ static void make_inline1(int pretty)
 	jw_end(&inline1);
 }
=20
-static char *expect_inline2 =3D
+static const char *expect_inline2 =3D
 	"[[1,2],[3,4],{\"a\":\"abc\"}]";
=20
-static char *pretty_inline2 =3D
+static const char *pretty_inline2 =3D
 	("[\n"
 	 "  [\n"
 	 "    1,\n"
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 80042eafc2..366bd70976 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -20,8 +20,8 @@ static struct reg_flag reg_flags[] =3D {
=20
 static int test_regex_bug(void)
 {
-	char *pat =3D "[^=3D{} \t]+";
-	char *str =3D "=3D{}\nfred";
+	const char *pat =3D "[^=3D{} \t]+";
+	const char *str =3D "=3D{}\nfred";
 	regex_t r;
 	regmatch_t m[1];
=20
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index f8d564c622..7e1d9e0ee4 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -136,7 +136,7 @@ static void free_delay_entries(void)
 	strmap_clear(&delay, 0);
 }
=20
-static void add_delay_entry(char *pathname, int count, int requested)
+static void add_delay_entry(const char *pathname, int count, int requested)
 {
 	struct delay_entry *entry =3D xcalloc(1, sizeof(*entry));
 	entry->count =3D count;
@@ -189,7 +189,8 @@ static void reply_list_available_blobs_cmd(void)
 static void command_loop(void)
 {
 	for (;;) {
-		char *buf, *output;
+		char *buf;
+		const char *output;
 		char *pathname;
 		struct delay_entry *entry;
 		struct strbuf input =3D STRBUF_INIT;
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index de434a4441..6027dafef7 100644
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -2,7 +2,8 @@
 #include "strbuf.h"
=20
 /* wrapper that supplies tests with an empty, initialized strbuf */
-static void setup(void (*f)(struct strbuf*, void*), void *data)
+static void setup(void (*f)(struct strbuf*, const void*),
+		  const void *data)
 {
 	struct strbuf buf =3D STRBUF_INIT;
=20
@@ -13,7 +14,8 @@ static void setup(void (*f)(struct strbuf*, void*), void =
*data)
 }
=20
 /* wrapper that supplies tests with a populated, initialized strbuf */
-static void setup_populated(void (*f)(struct strbuf*, void*), char *init_s=
tr, void *data)
+static void setup_populated(void (*f)(struct strbuf*, const void*),
+			    const char *init_str, const void *data)
 {
 	struct strbuf buf =3D STRBUF_INIT;
=20
@@ -64,7 +66,7 @@ static void t_dynamic_init(void)
 	strbuf_release(&buf);
 }
=20
-static void t_addch(struct strbuf *buf, void *data)
+static void t_addch(struct strbuf *buf, const void *data)
 {
 	const char *p_ch =3D data;
 	const char ch =3D *p_ch;
@@ -83,7 +85,7 @@ static void t_addch(struct strbuf *buf, void *data)
 	check_char(buf->buf[buf->len], =3D=3D, '\0');
 }
=20
-static void t_addstr(struct strbuf *buf, void *data)
+static void t_addstr(struct strbuf *buf, const void *data)
 {
 	const char *text =3D data;
 	size_t len =3D strlen(text);
diff --git a/trailer.c b/trailer.c
index 2bcb9ba8f7..72e5136c73 100644
--- a/trailer.c
+++ b/trailer.c
@@ -63,7 +63,7 @@ struct arg_item {
=20
 static LIST_HEAD(conf_head);
=20
-static char *separators =3D ":";
+static const char *separators =3D ":";
=20
 static int configured;
=20
diff --git a/wt-status.c b/wt-status.c
index ff4be071ca..7912545e4e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2408,7 +2408,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 		int mode;
 		struct object_id oid;
 	} stages[3];
-	char *key;
+	const char *key;
 	char submodule_token[5];
 	char unmerged_prefix =3D 'u';
 	char eol_char =3D s->null_termination ? '\0' : '\n';
--=20
2.45.1.410.g58bac47f8e.dirty


--dOmlz/s7kXoYPLSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjzQACgkQVbJhu7ck
PpRzgRAAiqEDI/2dg/HRYHbagQNwQ/g9eg21c53o1ogO0fTPF8m2wNYo6Ulb+mxe
bkoXQZLpbB1XndzdQfTtMQyV5BRoJ56WvegoOimTs+oAdX+siKnOMCGw8eyKY252
y/0W7SCi5hfCK66o9iM9m4skzFjnH66vVpGRkAhlGr8pUsGevjZ/DvyLhQr4e2xo
Q9i49bPx8imU0bBeSRhE6ZvFvQXy99jTk+o1CR7uMNl81yxfWUJ1iCEQpPHaAV84
H26F4SRsGMQgPTI336MMUBNIvYTaBlouSB1RhTaUDnA7Ut/FaZcXdFymAodv8h1H
fQsAI3EaKe95Z97kIp75KTQhHqPVwBMrU7yUTd6YB7DobDqClrXMUuUszY63ebf9
q2ORAZPs/BtUpWQSGc7vmtWuL4B63ciejrmqZCyO2A0okM1rkgcJF/hq6VVBIcfH
mR0irD2ImMounA+YSt9AtVwTfl2xeVNJ0BtUc3Sw7t31/J91/pEMYUDi3uPQopfz
gGyAg2zgX+XB03eXdqwr/iRcjYupA/ZukcQPEk4m66HmJFAh4BHm2/hhEuuxOlpK
Yxii4IlZ5tCa06hbTuoc2W7tM99U2exZyQR41OC9Nkp6phev8ac+aUSeYpkMC20k
hkwzvkfJpCq2wo717X35rEZlAyDTVqxciwb12fb+Ep6jQBTFlgg=
=4g3v
-----END PGP SIGNATURE-----

--dOmlz/s7kXoYPLSG--
