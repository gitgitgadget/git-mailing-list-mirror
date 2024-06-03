Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F0127E07
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407545; cv=none; b=RbUX07u68WAmAyow0kiKtWivM3l9G1ERgTkNhJKDJVZ9oI4DQfC+cIYZ0GsdtCNsNeLsc9DbRIzzWubjJCRqOO5SiihWAa4JMRwFglJQFVktvLsAD9lLetmXKz5iYL8fw+EDht+sna3T1KyZwFCWbpvqQLuiYku9BQgL7HLgh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407545; c=relaxed/simple;
	bh=P74hxd6h+DUp9dvQyuuE7dtpS7yTjNEnxLdI6YmcQCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLi6+Fv7hzzH9I6UJxYVfGuHWtWuL6YAwDZhhskdwlx6a11ra5O4YRVVKl4dzZcyQiLmZowo/ldWTkKVa3rNQJ44uUO7znZvpUCrE2L/OYZ4I2v14g8Ghd7a0RpS9Wzv6YbSWw5otuLaV5HHLKydI6+HP2GkdrqEHSbM/tBhyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i7+lNhdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gmmvyt0h; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i7+lNhdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gmmvyt0h"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 008301800099;
	Mon,  3 Jun 2024 05:39:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407541; x=1717493941; bh=wgl9v/Q+hK
	lOqDCQPF4Fc1swChze14Op6tHehir24Y0=; b=i7+lNhdAU1NDvwisLaEcZimB7i
	mde8SeegMvrkvzStQwSx7Cg0yEsTxcC4pSA/dl9x6qIk2i/lhQiMcH2RAfyRCtb5
	RlAhGHZffKYvSkEfbk9r/LuVCTz2q5aDMzZkW5OaQPI9fSLAm30/e4qQ37aCMK6u
	7l0xvNYstvG1dEe+5XUUpkjQcQrVwG1kawrxS265yqetVPMrTPpuYZZG2zrwQqR8
	8Jyynw7EeKCiPeFu2PHLSveJREAf3AceTkA//jcflKiqr7fGK0w4/pAYomrBMH1L
	+ujPQVr3gLlE5B4VwQ8gIxlfTrhLPcfrcv0Jfg0B4XDjmL2DMX0kmzaNkKaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407541; x=1717493941; bh=wgl9v/Q+hKlOqDCQPF4Fc1swChze
	14Op6tHehir24Y0=; b=Gmmvyt0h46IaqTsHjam1R5uJI7umGVLtHjiI77GXInF0
	1Vzi/95CwVRZaBpjlwtwBYu1PijlHozmzP60QptaQQfOOZHIIOYO6F26xCJbXk16
	yawDxc2mUqZDVkbcz6qy4aJorfMvcmGy1GrNmbZhDqOPTNAlBtbtVO5mc/OXYPGV
	itqH9PT7tI5MccAkUYBjBA8bzGlpGAOtdcj20g09h4pfaeqReq6nQllwtM9DlbWe
	vWQcVOHVR8IMbccuH6vH8VitJ8qI5WdiSC0UgZ62vQkqzXKvkl7UoKNZ4Keor/Vc
	Oae/l3Jb721ZNEhS1Cp5M4u8ZJnYDFMLtBLHghydZw==
X-ME-Sender: <xms:NY9dZtEPKbYIkhnThR0ixhRFe46-20i1oCpu5iAXXiCwxplWj8scxQ>
    <xme:NY9dZiWeU45HhRCGJI-JGy-B3OxRprqvmG_Pj1hzaH-dMm_k_D54qPv340j2v1nSi
    aejA3mCq13FumHZdg>
X-ME-Received: <xmr:NY9dZvLrK5FAGaw0UpyZ-jE6NXaVGMoGaCxnLa2VR3OtntSdIv08mXymE6NviBTjkZmSziek6NXIhuV_uUTzERPsXhyZo8KPIbcfX4evJAMNCaSd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeegueefgfeuffethfeileetffejteetke
    eiheduleehgffftddugfekgfekuefgvdenucffohhmrghinhepmhgrkhdruggvvhdpuhhp
    uggrthgvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrnhgvfienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:NY9dZjFOqunTPUOWfMgha8H3jogSC9Lc4HGHtY6kMeFHS6DvrofR1g>
    <xmx:NY9dZjUVM08ic4xEzA3TtfhnYtrT5e8k6xXIyTMCilmFubSEOQqTfg>
    <xmx:NY9dZuNBkKGkT0FZcaTrPEw_NVEGWNkpFPDrqQ11NojQOsCzbzavNA>
    <xmx:NY9dZi2Rf29uTDoIdXigfz8P8WtdTZg6QSaYYm48pBHFH1KkbyNLPg>
    <xmx:NY9dZuTg-9SSeJiDDCg2MpSPNcIdw4BJWnlYQPDZph1kms4exezj6J-n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e78ba905 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:38:34 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:38:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/27] Compile with `-Wwrite-strings`
Message-ID: <cover.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="91ftYtjsnL2qvkab"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--91ftYtjsnL2qvkab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that prepares the Git
codebase to compile with `-Wwrite-strings`. This compiler warning
changes the type of string constants from `char []` to `const char []`,
which helps to identify cases where we may accidentally write to or free
such constants.

Changes compared to v2:

  - I have split up the second patch into multiple patches. This was
    done so that we can have a deeper look at the respective sites that
    need adjustment.

  - I dropped the local string arrays that I used in v2 and instead now
    use string constants with casts in some places where we expect that
    those should never be written to. This has the benefit that we would
    segfault in case that expectation is violated, instead of silently
    allowing a write to those local arrays.

  - I adapted multiple commit messages to not only mention freeing of
    string constants, but also that writing to string constants is
    illegal.

Due to the split-up patch the range-diff got quite messy and was barely
readable anymore. I thus included an interdiff instead, which should be
way easier to read.

I realize that this patch series has grown quite large. Please let me
know in case I shall split it up into multiple patch series.

Patrick

Patrick Steinhardt (27):
  global: improve const correctness when assigning string constants
  global: convert intentionally-leaking config strings to consts
  refs/reftable: stop micro-optimizing refname allocations on copy
  reftable: cast away constness when assigning constants to records
  refspec: remove global tag refspec structure
  builtin/remote: cast away constness in `get_head_names()`
  diff: cast string constant in `fill_textconv()`
  line-log: stop assigning string constant to file parent buffer
  line-log: always allocate the output prefix
  entry: refactor how we remove items for delayed checkouts
  ident: add casts for fallback name and GECOS
  object-file: mark cached object buffers as const
  object-file: make `buf` parameter of `index_mem()` a constant
  pretty: add casts for decoration option pointers
  compat/win32: fix const-correctness with string constants
  http: do not assign string constant to non-const field
  parse-options: cast long name for OPTION_ALIAS
  send-pack: always allocate receive status
  remote-curl: avoid assigning string constant to non-const variable
  revision: always store allocated strings in output encoding
  mailmap: always store allocated strings in mailmap blob
  imap-send: drop global `imap_server_conf` variable
  imap-send: fix leaking memory in `imap_server_conf`
  builtin/rebase: do not assign default backend to non-constant field
  builtin/rebase: always store allocated string in `options.strategy`
  builtin/merge: always store allocated strings in `pull_twohead`
  config.mak.dev: enable `-Wwrite-strings` warning

 builtin/bisect.c             |   3 +-
 builtin/blame.c              |   2 +-
 builtin/bugreport.c          |   2 +-
 builtin/check-ignore.c       |   4 +-
 builtin/clone.c              |  14 ++--
 builtin/commit.c             |   6 +-
 builtin/diagnose.c           |   2 +-
 builtin/fetch.c              |  11 ++-
 builtin/log.c                |   2 +-
 builtin/mailsplit.c          |   4 +-
 builtin/merge.c              |  18 +++--
 builtin/pull.c               |  52 +++++++-------
 builtin/rebase.c             |  81 ++++++++++++----------
 builtin/receive-pack.c       |   4 +-
 builtin/remote.c             |  12 ++--
 builtin/revert.c             |   2 +-
 builtin/send-pack.c          |   2 +
 compat/basename.c            |  18 ++++-
 compat/mingw.c               |  28 ++++----
 compat/regex/regcomp.c       |   2 +-
 compat/winansi.c             |   2 +-
 config.mak.dev               |   1 +
 diff.c                       |   6 +-
 diffcore-rename.c            |   6 +-
 entry.c                      |  14 ++--
 fmt-merge-msg.c              |   2 +-
 fsck.c                       |   2 +-
 fsck.h                       |   2 +-
 gpg-interface.c              |   6 +-
 http-backend.c               |   2 +-
 http.c                       |   5 +-
 ident.c                      |   4 +-
 imap-send.c                  | 130 ++++++++++++++++++++---------------
 line-log.c                   |  22 +++---
 mailmap.c                    |   2 +-
 merge-ll.c                   |  11 ++-
 object-file.c                |  23 ++++---
 parse-options.h              |   2 +-
 pretty.c                     |   6 +-
 refs.c                       |   2 +-
 refs.h                       |   2 +-
 refs/reftable-backend.c      |  28 ++++----
 refspec.c                    |  13 ----
 refspec.h                    |   1 -
 reftable/basics.c            |  15 ++--
 reftable/basics.h            |   4 +-
 reftable/basics_test.c       |   4 +-
 reftable/block_test.c        |   2 +-
 reftable/merged_test.c       |  44 ++++++------
 reftable/readwrite_test.c    |  32 ++++-----
 reftable/record.c            |   6 +-
 reftable/stack.c             |  10 +--
 reftable/stack_test.c        |  56 +++++++--------
 remote-curl.c                |  53 +++++++-------
 revision.c                   |   3 +-
 run-command.c                |   2 +-
 send-pack.c                  |   2 +-
 t/helper/test-hashmap.c      |   3 +-
 t/helper/test-json-writer.c  |  10 +--
 t/helper/test-regex.c        |   4 +-
 t/helper/test-rot13-filter.c |   5 +-
 t/t3900-i18n-commit.sh       |   1 +
 t/t3901-i18n-patch.sh        |   1 +
 t/unit-tests/t-strbuf.c      |  10 +--
 trailer.c                    |   2 +-
 userdiff.c                   |  10 +--
 userdiff.h                   |  12 ++--
 wt-status.c                  |   2 +-
 68 files changed, 470 insertions(+), 386 deletions(-)

Interdiff against v2:
diff --git a/builtin/remote.c b/builtin/remote.c
index 0324a5d48d..b44f580b8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -493,13 +493,13 @@ static int get_head_names(const struct ref *remote_re=
fs, struct ref_states *stat
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
-	struct refspec_item refspec;
-	char refspec_str[] =3D "refs/heads/*";
+	struct refspec_item refspec =3D {
+		.force =3D 0,
+		.pattern =3D 1,
+		.src =3D (char *) "refs/heads/*",
+		.dst =3D (char *) "refs/heads/*",
+	};
=20
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.force =3D 0;
-	refspec.pattern =3D 1;
-	refspec.src =3D refspec.dst =3D refspec_str;
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -508,7 +508,6 @@ static int get_head_names(const struct ref *remote_refs=
, struct ref_states *stat
=20
 	free_refs(fetch_map);
 	free_refs(matches);
-
 	return 0;
 }
=20
diff --git a/compat/basename.c b/compat/basename.c
index c3c9d65fac..5aa320306b 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,11 +1,6 @@
 #include "../git-compat-util.h"
 #include "../strbuf.h"
=20
-/*
- * Both basename(3P) and dirname(3P) are mis-specified because they return=
 a
- * non-constant pointer even though it is specified that they may return a
- * pointer to internal memory. This variable here is a result of that.
- */
 static char current_directory[] =3D ".";
=20
 /* Adapted from libiberty's basename.c.  */
@@ -17,7 +12,13 @@ char *gitbasename (char *path)
 		skip_dos_drive_prefix(&path);
=20
 	if (!path || !*path)
-		return current_directory;
+		/*
+		 * basename(3P) is mis-specified because it returns a
+		 * non-constant pointer even though it is specified to return a
+		 * pointer to internal memory at times. The cast is a result of
+		 * that.
+		 */
+		return (char *) "";
=20
 	for (base =3D path; *path; path++) {
 		if (!is_dir_sep(*path))
@@ -40,12 +41,14 @@ char *gitdirname(char *path)
 	char *p =3D path, *slash =3D NULL, c;
 	int dos_drive_prefix;
=20
-	/*
-	 * Same here, dirname(3P) is broken because it returns a non-constant
-	 * pointer that may point to internal memory.
-	 */
 	if (!p)
-		return current_directory;
+		/*
+		 * dirname(3P) is mis-specified because it returns a
+		 * non-constant pointer even though it is specified to return a
+		 * pointer to internal memory at times. The cast is a result of
+		 * that.
+		 */
+		return (char *) "";
=20
 	if ((dos_drive_prefix =3D skip_dos_drive_prefix(&p)) && !*p)
 		goto dot;
diff --git a/compat/mingw.c b/compat/mingw.c
index 60f0986f76..d378cd04cb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2257,7 +2257,6 @@ struct passwd *getpwuid(int uid)
 {
 	static unsigned initialized;
 	static char user_name[100];
-	static char unknown[] =3D "unknown";
 	static struct passwd *p;
 	wchar_t buf[100];
 	DWORD len;
@@ -2280,7 +2279,11 @@ struct passwd *getpwuid(int uid)
 	p->pw_name =3D user_name;
 	p->pw_gecos =3D get_extended_user_info(NameDisplay);
 	if (!p->pw_gecos)
-		p->pw_gecos =3D unknown;
+		/*
+		 * Data returned by getpwuid(3P) is treated as internal and
+		 * must never be written to or freed.
+		 */
+		p->pw_gecos =3D (char *) "unknown";
 	p->pw_dir =3D NULL;
=20
 	initialized =3D 1;
diff --git a/diff.c b/diff.c
index 1439a5a01d..cecda216cf 100644
--- a/diff.c
+++ b/diff.c
@@ -7231,12 +7231,11 @@ size_t fill_textconv(struct repository *r,
 		     struct diff_filespec *df,
 		     char **outbuf)
 {
-	static char empty_str[] =3D "";
 	size_t size;
=20
 	if (!driver) {
 		if (!DIFF_FILE_VALID(df)) {
-			*outbuf =3D empty_str;
+			*outbuf =3D (char *) "";
 			return 0;
 		}
 		if (diff_populate_filespec(r, df, NULL))
diff --git a/entry.c b/entry.c
index 2fc06ac90c..f291d8eee6 100644
--- a/entry.c
+++ b/entry.c
@@ -167,6 +167,11 @@ static int remove_available_paths(struct string_list_i=
tem *item, void *cb_data)
 	return !available;
 }
=20
+static int string_is_not_null(struct string_list_item *item, void *data UN=
USED)
+{
+	return !!item->string;
+}
+
 int finish_delayed_checkout(struct checkout *state, int show_progress)
 {
 	int errs =3D 0;
@@ -175,7 +180,6 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 	struct string_list_item *filter, *path;
 	struct progress *progress =3D NULL;
 	struct delayed_checkout *dco =3D state->delayed_checkout;
-	char empty_str[] =3D "";
=20
 	if (!state->delayed_checkout)
 		return errs;
@@ -190,7 +194,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
 				errs =3D 1;
-				filter->string =3D empty_str;
+				filter->string =3D NULL;
 				continue;
 			}
 			if (available_paths.nr <=3D 0) {
@@ -200,7 +204,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
 				 */
-				filter->string =3D empty_str;
+				filter->string =3D NULL;
 				continue;
 			}
=20
@@ -226,7 +230,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
-					filter->string =3D empty_str;
+					filter->string =3D NULL;
 					continue;
 				}
 				ce =3D index_file_exists(state->istate, path->string,
@@ -240,7 +244,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					errs =3D 1;
 			}
 		}
-		string_list_remove_empty_items(&dco->filters, 0);
+
+		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
 	}
 	stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
diff --git a/ident.c b/ident.c
index df7aa42802..caf41fb2a9 100644
--- a/ident.c
+++ b/ident.c
@@ -46,14 +46,9 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	pw =3D getpwuid(getuid());
 	if (!pw) {
 		static struct passwd fallback;
-		static char fallback_name[] =3D "unknown";
+		fallback.pw_name =3D (char *) "unknown";
 #ifndef NO_GECOS_IN_PWENT
-		static char fallback_gcos[] =3D "Unknown";
-#endif
-
-		fallback.pw_name =3D fallback_name;
-#ifndef NO_GECOS_IN_PWENT
-		fallback.pw_gecos =3D fallback_gcos;
+		fallback.pw_gecos =3D (char *) "Unknown";
 #endif
 		pw =3D &fallback;
 		if (is_bogus)
diff --git a/line-log.c b/line-log.c
index 9a298209d0..67c80b39a0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1036,7 +1036,7 @@ static int process_diff_filepair(struct rev_info *rev,
 	struct range_set tmp;
 	struct diff_ranges diff;
 	mmfile_t file_parent, file_target;
-	char empty_str[] =3D "";
+	char *parent_data_to_free =3D NULL;
=20
 	assert(pair->two->path);
 	while (rg) {
@@ -1061,7 +1061,7 @@ static int process_diff_filepair(struct rev_info *rev,
 		file_parent.ptr =3D pair->one->data;
 		file_parent.size =3D pair->one->size;
 	} else {
-		file_parent.ptr =3D empty_str;
+		file_parent.ptr =3D parent_data_to_free =3D xstrdup("");
 		file_parent.size =3D 0;
 	}
=20
@@ -1080,6 +1080,7 @@ static int process_diff_filepair(struct rev_info *rev,
=20
 	diff_ranges_release(&diff);
=20
+	free(parent_data_to_free);
 	return ((*diff_out)->parent.nr > 0);
 }
=20
diff --git a/object-file.c b/object-file.c
index 46ea00ac46..b5b5a59dc6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -277,18 +277,17 @@ int hash_algo_by_length(int len)
 static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
-	void *buf;
+	const void *buf;
 	unsigned long size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
=20
-static char empty_tree_buf[] =3D "";
 static struct cached_object empty_tree =3D {
 	.oid =3D {
 		.hash =3D EMPTY_TREE_SHA1_BIN_LITERAL,
 	},
 	.type =3D OBJ_TREE,
-	.buf =3D empty_tree_buf,
+	.buf =3D "",
 };
=20
 static struct cached_object *find_cached_object(const struct object_id *oi=
d)
@@ -1779,6 +1778,10 @@ int pretend_object_file(void *buf, unsigned long len=
, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
+	char *co_buf;
+
+	co_buf =3D xmalloc(len);
+	memcpy(co_buf, buf, len);
=20
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUIC=
K | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
@@ -1788,8 +1791,7 @@ int pretend_object_file(void *buf, unsigned long len,=
 enum object_type type,
 	co =3D &cached_objects[cached_object_nr++];
 	co->size =3D len;
 	co->type =3D type;
-	co->buf =3D xmalloc(len);
-	memcpy(co->buf, buf, len);
+	co->buf =3D co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
 }
diff --git a/pretty.c b/pretty.c
index 1a0030b32a..1df9d635fb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1583,10 +1583,9 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 		return 1;
 	case 'D':
 		{
-			char empty_str[] =3D "";
 			const struct decoration_options opts =3D {
-				.prefix =3D empty_str,
-				.suffix =3D empty_str,
+				.prefix =3D (char *) "",
+				.suffix =3D (char *) "",
 			};
=20
 			format_decorations(sb, commit, c->auto_color, &opts);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1908e74dea..e77faa2b9d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1285,7 +1285,6 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	struct strbuf errbuf =3D STRBUF_INIT;
 	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
 	const char *committer_info;
-	char head[] =3D "HEAD";
 	int ret;
=20
 	committer_info =3D git_committer_info(0);
@@ -1341,10 +1340,10 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	 * old reference.
 	 */
 	refs[0] =3D old_ref;
-	refs[0].refname =3D (char *)arg->newname;
+	refs[0].refname =3D xstrdup(arg->newname);
 	refs[0].update_index =3D creation_ts;
 	if (arg->delete_old) {
-		refs[1].refname =3D (char *)arg->oldname;
+		refs[1].refname =3D xstrdup(arg->oldname);
 		refs[1].value_type =3D REFTABLE_REF_DELETION;
 		refs[1].update_index =3D deletion_ts;
 	}
@@ -1367,7 +1366,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
 			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1388,7 +1387,13 @@ static int write_copy_table(struct reftable_writer *=
writer, void *cb_data)
 		if (append_head_reflog) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			logs[logs_nr] =3D logs[logs_nr - 1];
-			logs[logs_nr].refname =3D head;
+			logs[logs_nr].refname =3D xstrdup("HEAD");
+			logs[logs_nr].value.update.name =3D
+				xstrdup(logs[logs_nr].value.update.name);
+			logs[logs_nr].value.update.email =3D
+				xstrdup(logs[logs_nr].value.update.email);
+			logs[logs_nr].value.update.message =3D
+				xstrdup(logs[logs_nr].value.update.message);
 			logs_nr++;
 		}
 	}
@@ -1399,7 +1404,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-	logs[logs_nr].refname =3D (char *)arg->newname;
+	logs[logs_nr].refname =3D xstrdup(arg->newname);
 	logs[logs_nr].update_index =3D creation_ts;
 	logs[logs_nr].value.update.message =3D
 		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1431,7 +1436,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		 */
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr] =3D old_log;
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs_nr++;
=20
 		/*
@@ -1440,7 +1445,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		if (arg->delete_old) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-			logs[logs_nr].refname =3D (char *)arg->oldname;
+			logs[logs_nr].refname =3D xstrdup(arg->oldname);
 			logs[logs_nr].value_type =3D REFTABLE_LOG_DELETION;
 			logs[logs_nr].update_index =3D old_log.update_index;
 			logs_nr++;
@@ -1463,13 +1468,11 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	reftable_iterator_destroy(&it);
 	string_list_clear(&skip, 0);
 	strbuf_release(&errbuf);
-	for (i =3D 0; i < logs_nr; i++) {
-		if (logs[i].refname =3D=3D head)
-			continue;
-		logs[i].refname =3D NULL;
+	for (i =3D 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	free(logs);
+	for (i =3D 0; i < ARRAY_SIZE(refs); i++)
+		reftable_ref_record_release(&refs[i]);
 	reftable_ref_record_release(&old_ref);
 	reftable_log_record_release(&old_log);
 	return ret;
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
index 23fab22eb1..13bc761817 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -58,8 +58,7 @@ static void test_binsearch(void)
=20
 static void test_names_length(void)
 {
-	char a[] =3D "a", b[] =3D "b";
-	char *names[] =3D { a, b, NULL };
+	const char *names[] =3D { "a", "b", NULL };
 	EXPECT(names_length(names) =3D=3D 2);
 }
=20
diff --git a/reftable/block_test.c b/reftable/block_test.c
index d5967b214d..90aecd5a7c 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -19,7 +19,7 @@ license that can be found in the LICENSE file or at
 static void test_block_read_write(void)
 {
 	const int header_off =3D 21; /* random */
-	char *names[30], empty_str[] =3D "";
+	char *names[30];
 	const int N =3D ARRAY_SIZE(names);
 	const int block_size =3D 1024;
 	struct reftable_block block =3D { NULL };
@@ -42,7 +42,7 @@ static void test_block_read_write(void)
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
=20
-	rec.u.ref.refname =3D empty_str;
+	rec.u.ref.refname =3D (char *) "";
 	rec.u.ref.value_type =3D REFTABLE_REF_DELETION;
 	n =3D block_writer_add(&bw, &rec);
 	EXPECT(n =3D=3D REFTABLE_API_ERROR);
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index fd5a065e42..6d1159d12d 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -123,15 +123,14 @@ static void readers_destroy(struct reftable_reader **=
readers, size_t n)
=20
 static void test_merged_between(void)
 {
-	char a[] =3D "a", b[] =3D "b";
 	struct reftable_ref_record r1[] =3D { {
-		.refname =3D b,
+		.refname =3D (char *) "b",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D { 1, 2, 3, 0 },
 	} };
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D a,
+		.refname =3D (char *) "a",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
@@ -164,41 +163,40 @@ static void test_merged_between(void)
=20
 static void test_merged(void)
 {
-	char a[] =3D "a", b[] =3D "b", c[] =3D "c", d[] =3D "d";
 	struct reftable_ref_record r1[] =3D {
 		{
-			.refname =3D a,
+			.refname =3D (char *) "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D b,
+			.refname =3D (char *) "b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D c,
+			.refname =3D (char *) "c",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		}
 	};
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D a,
+		.refname =3D (char *) "a",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
 	struct reftable_ref_record r3[] =3D {
 		{
-			.refname =3D c,
+			.refname =3D (char *) "c",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 2 },
 		},
 		{
-			.refname =3D d,
+			.refname =3D (char *) "d",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
@@ -291,52 +289,48 @@ merged_table_from_log_records(struct reftable_log_rec=
ord **logs,
=20
 static void test_merged_logs(void)
 {
-	char a[] =3D "a";
-	char name[] =3D "jane doe", email[] =3D "jane@invalid";
-	char message1[] =3D "message1", message2[] =3D "message2";
-	char message3[] =3D "message3";
 	struct reftable_log_record r1[] =3D {
 		{
-			.refname =3D a,
+			.refname =3D (char *) "a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 2 },
 				/* deletion */
-				.name =3D name,
-				.email =3D email,
-				.message =3D message2,
+				.name =3D (char *) "jane doe",
+				.email =3D (char *) "jane@invalid",
+				.message =3D (char *) "message2",
 			}
 		},
 		{
-			.refname =3D a,
+			.refname =3D (char *) "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D name,
-				.email =3D email,
-				.message =3D message1,
+				.name =3D (char *) "jane doe",
+				.email =3D (char *) "jane@invalid",
+				.message =3D (char *) "message1",
 			}
 		},
 	};
 	struct reftable_log_record r2[] =3D {
 		{
-			.refname =3D a,
+			.refname =3D (char *) "a",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.new_hash =3D { 3 },
-				.name =3D name,
-				.email =3D email,
-				.message =3D message3,
+				.name =3D (char *) "jane doe",
+				.email =3D (char *) "jane@invalid",
+				.message =3D (char *) "message3",
 			}
 		},
 	};
 	struct reftable_log_record r3[] =3D {
 		{
-			.refname =3D a,
+			.refname =3D (char *) "a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_DELETION,
 		},
@@ -406,13 +400,13 @@ static void test_merged_logs(void)
=20
 static void test_default_write_opts(void)
 {
-	char master[] =3D "master";
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+
 	struct reftable_ref_record rec =3D {
-		.refname =3D master,
+		.refname =3D (char *) "master",
 		.update_index =3D 1,
 	};
 	int err;
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 064d693111..c55019232b 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -56,7 +56,6 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 	int i =3D 0, n;
 	struct reftable_log_record log =3D { NULL };
 	const struct reftable_stats *stats =3D NULL;
-	char message[] =3D "message";
=20
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
=20
@@ -87,7 +86,7 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 		log.update_index =3D update_index;
 		log.value_type =3D REFTABLE_LOG_UPDATE;
 		set_test_hash(log.value.update.new_hash, i);
-		log.value.update.message =3D message;
+		log.value.update.message =3D (char *) "message";
=20
 		n =3D reftable_writer_add_log(w, &log);
 		EXPECT(n =3D=3D 0);
@@ -112,28 +111,23 @@ static void write_table(char ***names, struct strbuf =
*buf, int N,
=20
 static void test_log_buffer_size(void)
 {
-	char refname[] =3D "refs/heads/master";
-	char name[] =3D "Han-Wen Hienhuys";
-	char email[] =3D "hanwen@google.com";
-	char message[] =3D "commit: 9\n";
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_write_options opts =3D {
 		.block_size =3D 4096,
 	};
 	int err;
 	int i;
-	struct reftable_log_record log =3D {
-		.refname =3D refname,
-		.update_index =3D 0xa,
-		.value_type =3D REFTABLE_LOG_UPDATE,
-		.value.update =3D {
-			.name =3D name,
-			.email =3D email,
-			.tz_offset =3D 100,
-			.time =3D 0x5e430672,
-			.message =3D message,
-		},
-	};
+	struct reftable_log_record
+		log =3D { .refname =3D (char *) "refs/heads/master",
+			.update_index =3D 0xa,
+			.value_type =3D REFTABLE_LOG_UPDATE,
+			.value =3D { .update =3D {
+					   .name =3D (char *) "Han-Wen Nienhuys",
+					   .email =3D (char *) "hanwen@google.com",
+					   .tz_offset =3D 100,
+					   .time =3D 0x5e430672,
+					   .message =3D (char *) "commit: 9\n",
+				   } } };
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
=20
@@ -155,9 +149,6 @@ static void test_log_buffer_size(void)
=20
 static void test_log_overflow(void)
 {
-	char refname[] =3D "refs/heads/master";
-	char name[] =3D "Han-Wen Hienhuys";
-	char email[] =3D "hanwen@google.com";
 	struct strbuf buf =3D STRBUF_INIT;
 	char msg[256] =3D { 0 };
 	struct reftable_write_options opts =3D {
@@ -165,15 +156,15 @@ static void test_log_overflow(void)
 	};
 	int err;
 	struct reftable_log_record log =3D {
-		.refname =3D refname,
+		.refname =3D (char *) "refs/heads/master",
 		.update_index =3D 0xa,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D name,
-				.email =3D email,
+				.name =3D (char *) "Han-Wen Nienhuys",
+				.email =3D (char *) "hanwen@google.com",
 				.tz_offset =3D 100,
 				.time =3D 0x5e430672,
 				.message =3D msg,
@@ -299,20 +290,17 @@ static void test_log_zlib_corruption(void)
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	const struct reftable_stats *stats =3D NULL;
-	char refname[] =3D "refname";
-	char name[] =3D "My Name";
-	char email[] =3D "myname@invalid";
 	char message[100] =3D { 0 };
 	int err, i, n;
 	struct reftable_log_record log =3D {
-		.refname =3D refname,
+		.refname =3D (char *) "refname",
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.new_hash =3D { 1 },
 				.old_hash =3D { 2 },
-				.name =3D name,
-				.email =3D email,
+				.name =3D (char *) "My Name",
+				.email =3D (char *) "myname@invalid",
 				.message =3D message,
 			},
 		},
@@ -739,9 +727,8 @@ static void test_write_empty_key(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-	char refname[] =3D "";
 	struct reftable_ref_record ref =3D {
-		.refname =3D refname,
+		.refname =3D (char *) "",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_DELETION,
 	};
@@ -763,21 +750,20 @@ static void test_write_key_order(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-	char a[] =3D "a", b[] =3D "b", target[] =3D "target";
 	struct reftable_ref_record refs[2] =3D {
 		{
-			.refname =3D b,
+			.refname =3D (char *) "b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D target,
+				.symref =3D (char *) "target",
 			},
 		}, {
-			.refname =3D a,
+			.refname =3D (char *) "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D target,
+				.symref =3D (char *) "target",
 			},
 		}
 	};
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
index c6d88e6ea8..4abf92636d 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -116,14 +116,13 @@ static void test_parse_names(void)
=20
 static void test_names_equal(void)
 {
-	char a[] =3D "a", b[] =3D "b", c[] =3D "c", d[] =3D "d";
-	char *abc[] =3D { a, b, c, NULL };
-	char *abd[] =3D { a, b, d, NULL };
-	char *ab[] =3D { a, b, NULL };
-
-	EXPECT(names_equal(abc, abc));
-	EXPECT(!names_equal(abc, abd));
-	EXPECT(!names_equal(abc, ab));
+	const char *a[] =3D { "a", "b", "c", NULL };
+	const char *b[] =3D { "a", "b", "d", NULL };
+	const char *c[] =3D { "a", "b", NULL };
+
+	EXPECT(names_equal(a, a));
+	EXPECT(!names_equal(a, b));
+	EXPECT(!names_equal(a, c));
 }
=20
 static int write_test_ref(struct reftable_writer *wr, void *arg)
@@ -156,12 +155,11 @@ static void test_reftable_stack_add_one(void)
 	};
 	struct reftable_stack *st =3D NULL;
 	int err;
-	char head[] =3D "HEAD", master[] =3D "master";
 	struct reftable_ref_record ref =3D {
-		.refname =3D head,
+		.refname =3D (char *) "HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D master,
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record dest =3D { NULL };
 	struct stat stat_result =3D { 0 };
@@ -217,18 +215,17 @@ static void test_reftable_stack_uptodate(void)
 	char *dir =3D get_tmp_dir(__LINE__);
=20
 	int err;
-	char head[] =3D "HEAD", branch2[] =3D "branch2", master[] =3D "master";
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D head,
+		.refname =3D (char *) "HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D master,
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D branch2,
+		.refname =3D (char *) "branch2",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D master,
+		.value.symref =3D (char *) "master",
 	};
=20
=20
@@ -265,12 +262,12 @@ static void test_reftable_stack_transaction_api(void)
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_addition *add =3D NULL;
-	char head[] =3D "HEAD", master[] =3D "master";
+
 	struct reftable_ref_record ref =3D {
-		.refname =3D head,
+		.refname =3D (char *) "HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D master,
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record dest =3D { NULL };
=20
@@ -313,11 +310,10 @@ static void test_reftable_stack_transaction_api_perfo=
rms_auto_compaction(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
-		char master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D master,
+			.value.symref =3D (char *) "master",
 		};
 		char name[100];
=20
@@ -359,9 +355,8 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
=20
 static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 {
-	char master[] =3D "refs/meads/master";
 	struct reftable_ref_record ref =3D {
-		.refname =3D master,
+		.refname =3D (char *) "refs/heads/master",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D {0x01},
@@ -409,21 +404,21 @@ static int write_error(struct reftable_writer *wr, vo=
id *arg)
 static void test_reftable_stack_update_index_check(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
+
 	struct reftable_write_options cfg =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
-	char name1[] =3D "name1", name2[] =3D "name2", master[] =3D "master";
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D name1,
+		.refname =3D (char *) "name1",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D master,
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D name2,
+		.refname =3D (char *) "name2",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D master,
+		.value.symref =3D (char *) "master",
 	};
=20
 	err =3D reftable_new_stack(&st, dir, cfg);
@@ -565,12 +560,8 @@ static void test_reftable_stack_log_normalize(void)
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-	char branch[] =3D "branch";
-	char onetwomessage[] =3D "one\ntwo";
-	char onemessage[] =3D "one";
-	char twomessage[] =3D "two\n";
 	struct reftable_log_record input =3D {
-		.refname =3D branch,
+		.refname =3D (char *) "branch",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
@@ -591,11 +582,11 @@ static void test_reftable_stack_log_normalize(void)
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
=20
-	input.value.update.message =3D onetwomessage;
+	input.value.update.message =3D (char *) "one\ntwo";
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT(err =3D=3D REFTABLE_API_ERROR);
=20
-	input.value.update.message =3D onemessage;
+	input.value.update.message =3D (char *) "one";
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
=20
@@ -603,7 +594,7 @@ static void test_reftable_stack_log_normalize(void)
 	EXPECT_ERR(err);
 	EXPECT(0 =3D=3D strcmp(dest.value.update.message, "one\n"));
=20
-	input.value.update.message =3D twomessage;
+	input.value.update.message =3D (char *) "two\n";
 	arg.update_index =3D 2;
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
@@ -700,14 +691,15 @@ static void test_reftable_stack_tombstone(void)
 static void test_reftable_stack_hash_id(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
+
 	struct reftable_write_options cfg =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
-	char master[] =3D "master", target[] =3D "target";
+
 	struct reftable_ref_record ref =3D {
-		.refname =3D master,
+		.refname =3D (char *) "master",
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D target,
+		.value.symref =3D (char *) "target",
 		.update_index =3D 1,
 	};
 	struct reftable_write_options cfg32 =3D { .hash_id =3D GIT_SHA256_FORMAT_=
ID };
@@ -882,12 +874,12 @@ static void test_reftable_stack_auto_compaction(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
-		char name[100], master[] =3D "master";
+		char name[100];
 		struct reftable_ref_record ref =3D {
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D master,
+			.value.symref =3D (char *) "master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -918,11 +910,10 @@ static void test_reftable_stack_add_performs_auto_com=
paction(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
-		char master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D master,
+			.value.symref =3D (char *) "master",
 		};
=20
 		/*
@@ -968,12 +959,12 @@ static void test_reftable_stack_compaction_concurrent=
(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
-		char name[100], master[] =3D "master";
+		char name[100];
 		struct reftable_ref_record ref =3D {
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D master,
+			.value.symref =3D (char *) "master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -1018,12 +1009,12 @@ static void test_reftable_stack_compaction_concurre=
nt_clean(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
-		char name[100], master[] =3D "master";
+		char name[100];
 		struct reftable_ref_record ref =3D {
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D master,
+			.value.symref =3D (char *) "master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--91ftYtjsnL2qvkab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjy8ACgkQVbJhu7ck
PpSRqA//X+1/Cad+S3bFnl4kaz8ms2Fd52b+GibZkAx3ajTqwByRcB5qfSSfAnaF
9N/hdYZpeS0Gc3AxuzOqDHvBqaUoeEnoYNo/EfqkM1wPmNi9d1l13U+WjCSLB0p5
P5Ev0fwUe3LzlpWtHhl0FEYYgcB1gLpqzD3syWdW6/hhHx2AdiSlDzpaFfGZO0JE
zpBxsM2U9zhW2bxCE0I6bmo/IrLgx01j6O+lXJp5qxrnlHzBJ9e6ALwdv6dTPhU2
T/jRJTPWs6sGmU1AGYwGJMI4K9t+uDzqtCimFJu7ValxaDlQFUD9ik8daFWwa4kk
VJvDUZpC82MuVK1WR/Ap3e3EjGYMAfUe8/l6fKrWopHwWTo6kpm1UhmoNEmB85WY
zZabXFajTn1dapakBShA1eKKt3pV0jM4HK2dpbUnzie6EVHiPgdhUal/LvetmCCD
jbPfqm7LMyUJGzXSp+kwe5hQ8rbkc2TbOpRecxySe5lOFeKASTSxPlPxU8TbbRX3
HRr2D0IcDudWehEgz2sf+LjR4B5POauJgpNQYnFQ4jJxrqkYg512rqQHmE1qe5Z9
Q5ZHLQbM3TzOs/q+tXqrY00WXb65TSRRIV96yvZRZtfQFHJUPRfPRnzzPAYcOKRx
iO24zcEJ9Y7c2FmLrkOEw883LQxVdV0+FNbSHQzOIvcWtlrKzp4=
=5IX1
-----END PGP SIGNATURE-----

--91ftYtjsnL2qvkab--
