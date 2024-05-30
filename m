Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6B1E515
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073441; cv=none; b=tcyabJeRbZRWrlHn2aU0/HEaUnnaADohp8ZkbbNODrm6SE6+IVkwhNndKq96eaBKPf0BdedEN8hwqXkXMhsZVzbQ05PuEl19mwkQhZPR8lcOC97s3Enu6o9amNMkK5k/IeyLo0z9PveBZKsruiqMh8ILSVEfvy/0pF5Cka9KN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073441; c=relaxed/simple;
	bh=7k/JnLrBpSMYXLtHRIaRLM/fb1E5rvm4VZU3MlMVCtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFSzdhiXm7KPfRB5OsduPoxU8PVEAkd/wFUkxKboc5YNC4mYCon7mbtIuKqbqJ2G+z7R5h3gNgSibRD9f5Zpfn6PhROu6sBqgX5Xzu9YGqEVbZVrPK0PCmkp/8lt4f20F+Nu6yI2XxdCPgCrh0A1biHr83qnSpZEeF2x+zRs5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IARf3tuc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JElG52jf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IARf3tuc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JElG52jf"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CB9FD1140156;
	Thu, 30 May 2024 08:50:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 May 2024 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073436; x=1717159836; bh=5f/tQjAxx4
	wRisO3uaeX7F3E5J8cDIKHztbTrvQ/YlY=; b=IARf3tucO3W/2DFLtVYWXdmVZL
	r9wRt3obPayIE1kmtuobe7HN9ZFAlU+CDDguTDU8+iw0g7ev5FbPnaP+/hH1+yR9
	UJt/vXCAf4AX7G3CrjkGzFhsjTbb/rKt5q59Lo7XYmY/GgnWqeoGSSSTocUJkEui
	yz6SIXEX4uJ7je8FRd7R/pm0YtpQI25H2La9qo3212MR0TA9qxvFgnjW4mKg91hX
	FuWKsNkbQzu9Nmvj26FZXjUHOmWqNxbxEAk4/IHi2WcEA16Bkhmk3BJ6s+x3tBCb
	FAhJdDuf3Cwm7LFnqQDYCNeRyieaMxcbV4t5isCtVBzOXybORDr08aHknqtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073436; x=1717159836; bh=5f/tQjAxx4wRisO3uaeX7F3E5J8c
	DIKHztbTrvQ/YlY=; b=JElG52jfAp0hbCnm3XH+OKa1aXqHewAwZIescK4Xe9B/
	UhJ4p9xvbCHhYa6qGHWS/dYsbEaYlSJZRaVC+MmjnjeOrfpag6mJu1qjDj3jhBIZ
	s+47IWWwXVIPaj8od0mxmWuXZFm39TO1RXFUFOa/Tzk6Pf/03wjH1R7Kx0p0WEsF
	YAJFU4Usj3//PCS2WGoxJCOUl9nv+VZTWfFK3vbOyM9l9egCnepJRCc2Z9SoDNFP
	omAT0EzNfdrRH56W2QiKQpOkTHcEi7EJ/7Wxul+lG0r7pjsC58hYw1/VKtUd+5vH
	wzfylNcbHq6jCpktxemEdIlJfuNCfXcipIlipZ+3dw==
X-ME-Sender: <xms:HHZYZnfGarl19geZq39vpOiTwj-2wDoY8Ok9SB-6NaS3ywwcJCa_SQ>
    <xme:HHZYZtOGb1BXcAQC7uALZs6WV-Wdp7P0pyNZnpxo7LQy90HVjeWZ13Xro1KJ6Rwx2
    eLjPJZ7crQuo2e9fw>
X-ME-Received: <xmr:HHZYZghSgq4WtAfFgoVDa_Dp6yA3JPf_wbzKZilYeWUMXMCOt2P5Cyh3Lf570zW_PtQlyJwzMZAfXFFZGPXC5fQpPCQXVRRk1XxdevlGWw-_ULujJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefguedufedtvdefkedvgfektddvgeekud
    duffeiteelkeeuveektddvueevudelkeenucffohhmrghinhepmhgrkhdruggvvhdpuhhp
    uggrthgvrdhnvgifpdhsthhrrghtvghghigpohhpthhsrdhnrhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HHZYZo-JczehntBwXrvy7sqCPqwJzn1Sub834e8v_uVjMwyID-tb3g>
    <xmx:HHZYZjvQ33eyVna7XnUEK1C95FEqzlHFVHnZrblCLsKqO8SyAmFAeQ>
    <xmx:HHZYZnFHq8BTwGiVhn7KDzhRHOd1oaVtXa-V8JyOGyuJyhpdgbUIlQ>
    <xmx:HHZYZqOC5jecFjAXguagZ99_W8wRrbebIOzdH5UttVU1NMjGiBi0EQ>
    <xmx:HHZYZjLKcJ8iQzS2TKjolt5Qi-OuqZhR11QKdz52_OA_iTCmY_SP0C73>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:50:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9b2c5096 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:16 +0000 (UTC)
Date: Thu, 30 May 2024 14:50:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/19] Compile with `-Wwrite-strings`
Message-ID: <cover.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lUkarZj6jpie2M75"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--lUkarZj6jpie2M75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that prepares our code
base to compile with `-Wwrite-strings`. This warning will convert the
type of string constants from `char []` to `const char[]` so that it
becomes harder to for example write to or free such constants by
accident.

Changes compared to v2:

  - Merged the reftable-specific test into the second patch. Instead of
    adding casts, we now allocate the required strings on the stack.

  - Apply a micro-optimization to "remote-curl.c" that was suggested by
    Junio.

  - Restore the `nongit_ok` variable in "imap-send.c". It's somewhat
    concerning that we do not have test coverage for git-imap-send(1) at
    all. But it might be a bit more involved as we do not have any IMAP
    test infra, to the best of my knowledge.

  - Rework the patch to "builtin/rebase.c". It is now split into two
    patches. The first patch reworks initialization of the rebase
    options so that the defaults are still self-contained in a single
    place. And the second patch refactors how we set up the merge
    strategy.

Thanks!

Patrick

Patrick Steinhardt (19):
  global: improve const correctness when assigning string constants
  global: assign non-const strings as required
  global: convert intentionally-leaking config strings to consts
  compat/win32: fix const-correctness with string constants
  refspec: remove global tag refspec structure
  http: do not assign string constant to non-const field
  line-log: always allocate the output prefix
  object-file: make `buf` parameter of `index_mem()` a constant
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
 builtin/remote.c             |   3 +-
 builtin/revert.c             |   2 +-
 builtin/send-pack.c          |   2 +
 compat/basename.c            |  15 +++-
 compat/mingw.c               |  25 +++----
 compat/regex/regcomp.c       |   2 +-
 compat/winansi.c             |   2 +-
 config.mak.dev               |   1 +
 diff.c                       |   7 +-
 diffcore-rename.c            |   6 +-
 entry.c                      |   7 +-
 fmt-merge-msg.c              |   2 +-
 fsck.c                       |   2 +-
 fsck.h                       |   2 +-
 gpg-interface.c              |   6 +-
 http-backend.c               |   2 +-
 http.c                       |   5 +-
 ident.c                      |   9 ++-
 imap-send.c                  | 130 ++++++++++++++++++++---------------
 line-log.c                   |  21 +++---
 mailmap.c                    |   2 +-
 merge-ll.c                   |  11 ++-
 object-file.c                |  17 ++---
 parse-options.h              |   2 +-
 pretty.c                     |   7 +-
 refs.c                       |   2 +-
 refs.h                       |   2 +-
 refs/reftable-backend.c      |   5 +-
 refspec.c                    |  13 ----
 refspec.h                    |   1 -
 reftable/basics_test.c       |   5 +-
 reftable/block_test.c        |   4 +-
 reftable/merged_test.c       |  52 +++++++-------
 reftable/readwrite_test.c    |  60 +++++++++-------
 reftable/record.c            |   6 +-
 reftable/stack_test.c        |  87 ++++++++++++-----------
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
 65 files changed, 479 insertions(+), 373 deletions(-)

Range-diff against v1:
 1:  25c31e550f =3D  1:  25c31e550f global: improve const correctness when =
assigning string constants
 5:  dc5d85257e !  2:  3430bcc09b reftable: improve const correctness when =
assigning string constants
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    reftable: improve const correctness when assigning string constants
    +    global: assign non-const strings as required
    =20
    -    There are many cases in the reftable tests where we assign string
    -    constants to non-const fields. This is harmless because we know th=
at
    -    those fields are only used for reading access, but will break once=
 we
    -    enable `-Wwrite-strings`. Add explicit casts to prepare for this.
    +    There are several cases where we initialize non-const fields with =
string
    +    constants. This is invalid and will cause warnings once we enable =
the
    +    `-Wwrite-strings` warning. Adapt those cases to instead use string
    +    arrays.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## builtin/remote.c ##
    +@@ builtin/remote.c: static int get_head_names(const struct ref *remot=
e_refs, struct ref_states *stat
    + 	struct ref *ref, *matches;
    + 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
    + 	struct refspec_item refspec;
    ++	char refspec_str[] =3D "refs/heads/*";
    +=20
    + 	memset(&refspec, 0, sizeof(refspec));
    + 	refspec.force =3D 0;
    + 	refspec.pattern =3D 1;
    +-	refspec.src =3D refspec.dst =3D "refs/heads/*";
    ++	refspec.src =3D refspec.dst =3D refspec_str;
    + 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
    + 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
    + 				    fetch_map, 1);
    +
    + ## diff.c ##
    +@@ diff.c: size_t fill_textconv(struct repository *r,
    + 		     struct diff_filespec *df,
    + 		     char **outbuf)
    + {
    ++	static char empty_str[] =3D "";
    + 	size_t size;
    +=20
    + 	if (!driver) {
    + 		if (!DIFF_FILE_VALID(df)) {
    +-			*outbuf =3D "";
    ++			*outbuf =3D empty_str;
    + 			return 0;
    + 		}
    + 		if (diff_populate_filespec(r, df, NULL))
    +
    + ## entry.c ##
    +@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    + 	struct string_list_item *filter, *path;
    + 	struct progress *progress =3D NULL;
    + 	struct delayed_checkout *dco =3D state->delayed_checkout;
    ++	char empty_str[] =3D "";
    +=20
    + 	if (!state->delayed_checkout)
    + 		return errs;
    +@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    + 			if (!async_query_available_blobs(filter->string, &available_paths)=
) {
    + 				/* Filter reported an error */
    + 				errs =3D 1;
    +-				filter->string =3D "";
    ++				filter->string =3D empty_str;
    + 				continue;
    + 			}
    + 			if (available_paths.nr <=3D 0) {
    +@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    + 				 * filter from the list (see
    + 				 * "string_list_remove_empty_items" call below).
    + 				 */
    +-				filter->string =3D "";
    ++				filter->string =3D empty_str;
    + 				continue;
    + 			}
    +=20
    +@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    + 					 * Do not ask the filter for available blobs,
    + 					 * again, as the filter is likely buggy.
    + 					 */
    +-					filter->string =3D "";
    ++					filter->string =3D empty_str;
    + 					continue;
    + 				}
    + 				ce =3D index_file_exists(state->istate, path->string,
    +
    + ## ident.c ##
    +@@ ident.c: static struct passwd *xgetpwuid_self(int *is_bogus)
    + 	pw =3D getpwuid(getuid());
    + 	if (!pw) {
    + 		static struct passwd fallback;
    +-		fallback.pw_name =3D "unknown";
    ++		static char fallback_name[] =3D "unknown";
    + #ifndef NO_GECOS_IN_PWENT
    +-		fallback.pw_gecos =3D "Unknown";
    ++		static char fallback_gcos[] =3D "Unknown";
    ++#endif
    ++
    ++		fallback.pw_name =3D fallback_name;
    ++#ifndef NO_GECOS_IN_PWENT
    ++		fallback.pw_gecos =3D fallback_gcos;
    + #endif
    + 		pw =3D &fallback;
    + 		if (is_bogus)
    +
    + ## line-log.c ##
    +@@ line-log.c: static int process_diff_filepair(struct rev_info *rev,
    + 	struct range_set tmp;
    + 	struct diff_ranges diff;
    + 	mmfile_t file_parent, file_target;
    ++	char empty_str[] =3D "";
    +=20
    + 	assert(pair->two->path);
    + 	while (rg) {
    +@@ line-log.c: static int process_diff_filepair(struct rev_info *rev,
    + 		file_parent.ptr =3D pair->one->data;
    + 		file_parent.size =3D pair->one->size;
    + 	} else {
    +-		file_parent.ptr =3D "";
    ++		file_parent.ptr =3D empty_str;
    + 		file_parent.size =3D 0;
    + 	}
    +=20
    +
    + ## object-file.c ##
    +@@ object-file.c: static struct cached_object {
    + } *cached_objects;
    + static int cached_object_nr, cached_object_alloc;
    +=20
    ++static char empty_tree_buf[] =3D "";
    + static struct cached_object empty_tree =3D {
    + 	.oid =3D {
    + 		.hash =3D EMPTY_TREE_SHA1_BIN_LITERAL,
    + 	},
    + 	.type =3D OBJ_TREE,
    +-	.buf =3D "",
    ++	.buf =3D empty_tree_buf,
    + };
    +=20
    + static struct cached_object *find_cached_object(const struct object_i=
d *oid)
    +
    + ## pretty.c ##
    +@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in =
UTF-8 */
    + 		return 1;
    + 	case 'D':
    + 		{
    ++			char empty_str[] =3D "";
    + 			const struct decoration_options opts =3D {
    +-				.prefix =3D "",
    +-				.suffix =3D ""
    ++				.prefix =3D empty_str,
    ++				.suffix =3D empty_str,
    + 			};
    +=20
    + 			format_decorations(sb, commit, c->auto_color, &opts);
    +
    + ## refs/reftable-backend.c ##
    +@@ refs/reftable-backend.c: static int write_copy_table(struct reftabl=
e_writer *writer, void *cb_data)
    + 	struct strbuf errbuf =3D STRBUF_INIT;
    + 	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
    + 	const char *committer_info;
    ++	char head[] =3D "HEAD";
    + 	int ret;
    +=20
    + 	committer_info =3D git_committer_info(0);
    +@@ refs/reftable-backend.c: static int write_copy_table(struct reftabl=
e_writer *writer, void *cb_data)
    + 		if (append_head_reflog) {
    + 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
    + 			logs[logs_nr] =3D logs[logs_nr - 1];
    +-			logs[logs_nr].refname =3D "HEAD";
    ++			logs[logs_nr].refname =3D head;
    + 			logs_nr++;
    + 		}
    + 	}
    +@@ refs/reftable-backend.c: static int write_copy_table(struct reftabl=
e_writer *writer, void *cb_data)
    + 	string_list_clear(&skip, 0);
    + 	strbuf_release(&errbuf);
    + 	for (i =3D 0; i < logs_nr; i++) {
    +-		if (!strcmp(logs[i].refname, "HEAD"))
    ++		if (logs[i].refname =3D=3D head)
    + 			continue;
    + 		logs[i].refname =3D NULL;
    + 		reftable_log_record_release(&logs[i]);
    +
      ## reftable/basics_test.c ##
     @@ reftable/basics_test.c: static void test_binsearch(void)
     =20
    @@ reftable/basics_test.c: static void test_binsearch(void)
      {
     -	char *a[] =3D { "a", "b", NULL };
     -	EXPECT(names_length(a) =3D=3D 2);
    -+	char *names[] =3D { (char *)"a", (char *)"b", NULL };
    ++	char a[] =3D "a", b[] =3D "b";
    ++	char *names[] =3D { a, b, NULL };
     +	EXPECT(names_length(names) =3D=3D 2);
      }
     =20
      static void test_parse_names_normal(void)
    =20
      ## reftable/block_test.c ##
    +@@ reftable/block_test.c: license that can be found in the LICENSE fil=
e or at
    + static void test_block_read_write(void)
    + {
    + 	const int header_off =3D 21; /* random */
    +-	char *names[30];
    ++	char *names[30], empty_str[] =3D "";
    + 	const int N =3D ARRAY_SIZE(names);
    + 	const int block_size =3D 1024;
    + 	struct reftable_block block =3D { NULL };
     @@ reftable/block_test.c: static void test_block_read_write(void)
      	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
      			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
     =20
     -	rec.u.ref.refname =3D "";
    -+	rec.u.ref.refname =3D (char *)"";
    ++	rec.u.ref.refname =3D empty_str;
      	rec.u.ref.value_type =3D REFTABLE_REF_DELETION;
      	n =3D block_writer_add(&bw, &rec);
      	EXPECT(n =3D=3D REFTABLE_API_ERROR);
    =20
      ## reftable/merged_test.c ##
     @@ reftable/merged_test.c: static void readers_destroy(struct reftable=
_reader **readers, size_t n)
    +=20
      static void test_merged_between(void)
      {
    ++	char a[] =3D "a", b[] =3D "b";
      	struct reftable_ref_record r1[] =3D { {
     -		.refname =3D "b",
    -+		.refname =3D (char *)"b",
    ++		.refname =3D b,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_VAL1,
      		.value.val1 =3D { 1, 2, 3, 0 },
      	} };
      	struct reftable_ref_record r2[] =3D { {
     -		.refname =3D "a",
    -+		.refname =3D (char *)"a",
    ++		.refname =3D a,
      		.update_index =3D 2,
      		.value_type =3D REFTABLE_REF_DELETION,
      	} };
    -@@ reftable/merged_test.c: static void test_merged(void)
    +@@ reftable/merged_test.c: static void test_merged_between(void)
    +=20
    + static void test_merged(void)
      {
    ++	char a[] =3D "a", b[] =3D "b", c[] =3D "c", d[] =3D "d";
      	struct reftable_ref_record r1[] =3D {
      		{
     -			.refname =3D "a",
    -+			.refname =3D (char *)"a",
    ++			.refname =3D a,
      			.update_index =3D 1,
      			.value_type =3D REFTABLE_REF_VAL1,
      			.value.val1 =3D { 1 },
      		},
      		{
     -			.refname =3D "b",
    -+			.refname =3D (char *)"b",
    ++			.refname =3D b,
      			.update_index =3D 1,
      			.value_type =3D REFTABLE_REF_VAL1,
      			.value.val1 =3D { 1 },
      		},
      		{
     -			.refname =3D "c",
    -+			.refname =3D (char *)"c",
    ++			.refname =3D c,
      			.update_index =3D 1,
      			.value_type =3D REFTABLE_REF_VAL1,
      			.value.val1 =3D { 1 },
    @@ reftable/merged_test.c: static void test_merged(void)
      	};
      	struct reftable_ref_record r2[] =3D { {
     -		.refname =3D "a",
    -+		.refname =3D (char *)"a",
    ++		.refname =3D a,
      		.update_index =3D 2,
      		.value_type =3D REFTABLE_REF_DELETION,
      	} };
      	struct reftable_ref_record r3[] =3D {
      		{
     -			.refname =3D "c",
    -+			.refname =3D (char *)"c",
    ++			.refname =3D c,
      			.update_index =3D 3,
      			.value_type =3D REFTABLE_REF_VAL1,
      			.value.val1 =3D { 2 },
      		},
      		{
     -			.refname =3D "d",
    -+			.refname =3D (char *)"d",
    ++			.refname =3D d,
      			.update_index =3D 3,
      			.value_type =3D REFTABLE_REF_VAL1,
      			.value.val1 =3D { 1 },
    -@@ reftable/merged_test.c: static void test_merged_logs(void)
    +@@ reftable/merged_test.c: merged_table_from_log_records(struct reftab=
le_log_record **logs,
    +=20
    + static void test_merged_logs(void)
      {
    ++	char a[] =3D "a";
    ++	char name[] =3D "jane doe", email[] =3D "jane@invalid";
    ++	char message1[] =3D "message1", message2[] =3D "message2";
    ++	char message3[] =3D "message3";
      	struct reftable_log_record r1[] =3D {
      		{
     -			.refname =3D "a",
    -+			.refname =3D (char *)"a",
    ++			.refname =3D a,
      			.update_index =3D 2,
      			.value_type =3D REFTABLE_LOG_UPDATE,
      			.value.update =3D {
    @@ reftable/merged_test.c: static void test_merged_logs(void)
     -				.name =3D "jane doe",
     -				.email =3D "jane@invalid",
     -				.message =3D "message2",
    -+				.name =3D (char *)"jane doe",
    -+				.email =3D (char *)"jane@invalid",
    -+				.message =3D (char *)"message2",
    ++				.name =3D name,
    ++				.email =3D email,
    ++				.message =3D message2,
      			}
      		},
      		{
     -			.refname =3D "a",
    -+			.refname =3D (char *)"a",
    ++			.refname =3D a,
      			.update_index =3D 1,
      			.value_type =3D REFTABLE_LOG_UPDATE,
      			.value.update =3D {
    @@ reftable/merged_test.c: static void test_merged_logs(void)
     -				.name =3D "jane doe",
     -				.email =3D "jane@invalid",
     -				.message =3D "message1",
    -+				.name =3D (char *)"jane doe",
    -+				.email =3D (char *)"jane@invalid",
    -+				.message =3D (char *)"message1",
    ++				.name =3D name,
    ++				.email =3D email,
    ++				.message =3D message1,
      			}
      		},
      	};
      	struct reftable_log_record r2[] =3D {
      		{
     -			.refname =3D "a",
    -+			.refname =3D (char *)"a",
    ++			.refname =3D a,
      			.update_index =3D 3,
      			.value_type =3D REFTABLE_LOG_UPDATE,
      			.value.update =3D {
    @@ reftable/merged_test.c: static void test_merged_logs(void)
     -				.name =3D "jane doe",
     -				.email =3D "jane@invalid",
     -				.message =3D "message3",
    -+				.name =3D (char *)"jane doe",
    -+				.email =3D (char *)"jane@invalid",
    -+				.message =3D (char *)"message3",
    ++				.name =3D name,
    ++				.email =3D email,
    ++				.message =3D message3,
      			}
      		},
      	};
      	struct reftable_log_record r3[] =3D {
      		{
     -			.refname =3D "a",
    -+			.refname =3D (char *)"a",
    ++			.refname =3D a,
      			.update_index =3D 2,
      			.value_type =3D REFTABLE_LOG_DELETION,
      		},
    -@@ reftable/merged_test.c: static void test_default_write_opts(void)
    +@@ reftable/merged_test.c: static void test_merged_logs(void)
    +=20
    + static void test_default_write_opts(void)
    + {
    ++	char master[] =3D "master";
    + 	struct reftable_write_options opts =3D { 0 };
      	struct strbuf buf =3D STRBUF_INIT;
      	struct reftable_writer *w =3D
      		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
     -
      	struct reftable_ref_record rec =3D {
     -		.refname =3D "master",
    -+		.refname =3D (char *)"master",
    ++		.refname =3D master,
      		.update_index =3D 1,
      	};
      	int err;
    =20
      ## reftable/readwrite_test.c ##
    +@@ reftable/readwrite_test.c: static void write_table(char ***names, s=
truct strbuf *buf, int N,
    + 	int i =3D 0, n;
    + 	struct reftable_log_record log =3D { NULL };
    + 	const struct reftable_stats *stats =3D NULL;
    ++	char message[] =3D "message";
    +=20
    + 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
    +=20
     @@ reftable/readwrite_test.c: static void write_table(char ***names, s=
truct strbuf *buf, int N,
      		log.update_index =3D update_index;
      		log.value_type =3D REFTABLE_LOG_UPDATE;
      		set_test_hash(log.value.update.new_hash, i);
     -		log.value.update.message =3D "message";
    -+		log.value.update.message =3D (char *)"message";
    ++		log.value.update.message =3D message;
     =20
      		n =3D reftable_writer_add_log(w, &log);
      		EXPECT(n =3D=3D 0);
    -@@ reftable/readwrite_test.c: static void test_log_buffer_size(void)
    +@@ reftable/readwrite_test.c: static void write_table(char ***names, s=
truct strbuf *buf, int N,
    +=20
    + static void test_log_buffer_size(void)
    + {
    ++	char refname[] =3D "refs/heads/master";
    ++	char name[] =3D "Han-Wen Hienhuys";
    ++	char email[] =3D "hanwen@google.com";
    ++	char message[] =3D "commit: 9\n";
    + 	struct strbuf buf =3D STRBUF_INIT;
    + 	struct reftable_write_options opts =3D {
    + 		.block_size =3D 4096,
      	};
      	int err;
      	int i;
    @@ reftable/readwrite_test.c: static void test_log_buffer_size(void)
     -					   .message =3D "commit: 9\n",
     -				   } } };
     +	struct reftable_log_record log =3D {
    -+		.refname =3D (char *)"refs/heads/master",
    ++		.refname =3D refname,
     +		.update_index =3D 0xa,
     +		.value_type =3D REFTABLE_LOG_UPDATE,
     +		.value.update =3D {
    -+			.name =3D (char *)"Han-Wen Nienhuys",
    -+			.email =3D (char *)"hanwen@google.com",
    ++			.name =3D name,
    ++			.email =3D email,
     +			.tz_offset =3D 100,
     +			.time =3D 0x5e430672,
    -+			.message =3D (char *)"commit: 9\n",
    ++			.message =3D message,
     +		},
     +	};
      	struct reftable_writer *w =3D
      		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
     =20
    +@@ reftable/readwrite_test.c: static void test_log_buffer_size(void)
    +=20
    + static void test_log_overflow(void)
    + {
    ++	char refname[] =3D "refs/heads/master";
    ++	char name[] =3D "Han-Wen Hienhuys";
    ++	char email[] =3D "hanwen@google.com";
    + 	struct strbuf buf =3D STRBUF_INIT;
    + 	char msg[256] =3D { 0 };
    + 	struct reftable_write_options opts =3D {
     @@ reftable/readwrite_test.c: static void test_log_overflow(void)
      	};
      	int err;
      	struct reftable_log_record log =3D {
     -		.refname =3D "refs/heads/master",
    -+		.refname =3D (char *)"refs/heads/master",
    ++		.refname =3D refname,
      		.update_index =3D 0xa,
      		.value_type =3D REFTABLE_LOG_UPDATE,
      		.value =3D {
    @@ reftable/readwrite_test.c: static void test_log_overflow(void)
      				.new_hash =3D { 2 },
     -				.name =3D "Han-Wen Nienhuys",
     -				.email =3D "hanwen@google.com",
    -+				.name =3D (char *)"Han-Wen Nienhuys",
    -+				.email =3D (char *)"hanwen@google.com",
    ++				.name =3D name,
    ++				.email =3D email,
      				.tz_offset =3D 100,
      				.time =3D 0x5e430672,
      				.message =3D msg,
     @@ reftable/readwrite_test.c: static void test_log_zlib_corruption(voi=
d)
    + 	struct reftable_writer *w =3D
    + 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    + 	const struct reftable_stats *stats =3D NULL;
    ++	char refname[] =3D "refname";
    ++	char name[] =3D "My Name";
    ++	char email[] =3D "myname@invalid";
      	char message[100] =3D { 0 };
      	int err, i, n;
      	struct reftable_log_record log =3D {
     -		.refname =3D "refname",
    -+		.refname =3D (char *)"refname",
    ++		.refname =3D refname,
      		.value_type =3D REFTABLE_LOG_UPDATE,
      		.value =3D {
      			.update =3D {
    @@ reftable/readwrite_test.c: static void test_log_zlib_corruption(void)
      				.old_hash =3D { 2 },
     -				.name =3D "My Name",
     -				.email =3D "myname@invalid",
    -+				.name =3D (char *)"My Name",
    -+				.email =3D (char *)"myname@invalid",
    ++				.name =3D name,
    ++				.email =3D email,
      				.message =3D message,
      			},
      		},
     @@ reftable/readwrite_test.c: static void test_write_empty_key(void)
    + 	struct strbuf buf =3D STRBUF_INIT;
      	struct reftable_writer *w =3D
      		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    ++	char refname[] =3D "";
      	struct reftable_ref_record ref =3D {
     -		.refname =3D "",
    -+		.refname =3D (char *)"",
    ++		.refname =3D refname,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_DELETION,
      	};
     @@ reftable/readwrite_test.c: static void test_write_key_order(void)
    + 	struct strbuf buf =3D STRBUF_INIT;
    + 	struct reftable_writer *w =3D
      		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    ++	char a[] =3D "a", b[] =3D "b", target[] =3D "target";
      	struct reftable_ref_record refs[2] =3D {
      		{
     -			.refname =3D "b",
    -+			.refname =3D (char *)"b",
    ++			.refname =3D b,
      			.update_index =3D 1,
      			.value_type =3D REFTABLE_REF_SYMREF,
      			.value =3D {
     -				.symref =3D "target",
    -+				.symref =3D (char *)"target",
    ++				.symref =3D target,
      			},
      		}, {
     -			.refname =3D "a",
    -+			.refname =3D (char *)"a",
    ++			.refname =3D a,
      			.update_index =3D 1,
      			.value_type =3D REFTABLE_REF_SYMREF,
      			.value =3D {
     -				.symref =3D "target",
    -+				.symref =3D (char *)"target",
    ++				.symref =3D target,
      			},
      		}
      	};
    @@ reftable/stack_test.c: static void test_parse_names(void)
     =20
      static int write_test_ref(struct reftable_writer *wr, void *arg)
     @@ reftable/stack_test.c: static void test_reftable_stack_add_one(void)
    + 	};
      	struct reftable_stack *st =3D NULL;
      	int err;
    ++	char head[] =3D "HEAD", master[] =3D "master";
      	struct reftable_ref_record ref =3D {
     -		.refname =3D "HEAD",
    -+		.refname =3D (char *)"HEAD",
    ++		.refname =3D head,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "master",
    -+		.value.symref =3D (char *)"master",
    ++		.value.symref =3D master,
      	};
      	struct reftable_ref_record dest =3D { NULL };
      	struct stat stat_result =3D { 0 };
     @@ reftable/stack_test.c: static void test_reftable_stack_uptodate(voi=
d)
    + 	char *dir =3D get_tmp_dir(__LINE__);
     =20
      	int err;
    ++	char head[] =3D "HEAD", branch2[] =3D "branch2", master[] =3D "maste=
r";
      	struct reftable_ref_record ref1 =3D {
     -		.refname =3D "HEAD",
    -+		.refname =3D (char *)"HEAD",
    ++		.refname =3D head,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "master",
    -+		.value.symref =3D (char *)"master",
    ++		.value.symref =3D master,
      	};
      	struct reftable_ref_record ref2 =3D {
     -		.refname =3D "branch2",
    -+		.refname =3D (char *)"branch2",
    ++		.refname =3D branch2,
      		.update_index =3D 2,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "master",
    -+		.value.symref =3D (char *)"master",
    ++		.value.symref =3D master,
      	};
     =20
     =20
     @@ reftable/stack_test.c: static void test_reftable_stack_transaction_=
api(void)
    + 	struct reftable_stack *st =3D NULL;
    + 	int err;
      	struct reftable_addition *add =3D NULL;
    -=20
    +-
    ++	char head[] =3D "HEAD", master[] =3D "master";
      	struct reftable_ref_record ref =3D {
     -		.refname =3D "HEAD",
    -+		.refname =3D (char *)"HEAD",
    ++		.refname =3D head,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "master",
    -+		.value.symref =3D (char *)"master",
    ++		.value.symref =3D master,
      	};
      	struct reftable_ref_record dest =3D { NULL };
     =20
     @@ reftable/stack_test.c: static void test_reftable_stack_transaction_=
api_performs_auto_compaction(void)
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i <=3D n; i++) {
    ++		char master[] =3D "master";
      		struct reftable_ref_record ref =3D {
      			.update_index =3D reftable_stack_next_update_index(st),
      			.value_type =3D REFTABLE_REF_SYMREF,
     -			.value.symref =3D "master",
    -+			.value.symref =3D (char *)"master",
    ++			.value.symref =3D master,
      		};
      		char name[100];
     =20
     @@ reftable/stack_test.c: static void test_reftable_stack_transaction_=
api_performs_auto_compaction(void)
    +=20
      static void test_reftable_stack_auto_compaction_fails_gracefully(void)
      {
    ++	char master[] =3D "refs/meads/master";
      	struct reftable_ref_record ref =3D {
     -		.refname =3D "refs/heads/master",
    -+		.refname =3D (char *)"refs/heads/master",
    ++		.refname =3D master,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_VAL1,
      		.value.val1 =3D {0x01},
    -@@ reftable/stack_test.c: static void test_reftable_stack_update_index=
_check(void)
    +@@ reftable/stack_test.c: static int write_error(struct reftable_write=
r *wr, void *arg)
    + static void test_reftable_stack_update_index_check(void)
    + {
    + 	char *dir =3D get_tmp_dir(__LINE__);
    +-
    + 	struct reftable_write_options cfg =3D { 0 };
      	struct reftable_stack *st =3D NULL;
      	int err;
    ++	char name1[] =3D "name1", name2[] =3D "name2", master[] =3D "master";
      	struct reftable_ref_record ref1 =3D {
     -		.refname =3D "name1",
    -+		.refname =3D (char *)"name1",
    ++		.refname =3D name1,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "master",
    -+		.value.symref =3D (char *)"master",
    ++		.value.symref =3D master,
      	};
      	struct reftable_ref_record ref2 =3D {
     -		.refname =3D "name2",
    -+		.refname =3D (char *)"name2",
    ++		.refname =3D name2,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "master",
    -+		.value.symref =3D (char *)"master",
    ++		.value.symref =3D master,
      	};
     =20
      	err =3D reftable_new_stack(&st, dir, cfg);
     @@ reftable/stack_test.c: static void test_reftable_stack_log_normaliz=
e(void)
    + 	};
      	struct reftable_stack *st =3D NULL;
      	char *dir =3D get_tmp_dir(__LINE__);
    ++	char branch[] =3D "branch";
    ++	char onetwomessage[] =3D "one\ntwo";
    ++	char onemessage[] =3D "one";
    ++	char twomessage[] =3D "two\n";
      	struct reftable_log_record input =3D {
     -		.refname =3D "branch",
    -+		.refname =3D (char *)"branch",
    ++		.refname =3D branch,
      		.update_index =3D 1,
      		.value_type =3D REFTABLE_LOG_UPDATE,
      		.value =3D {
    @@ reftable/stack_test.c: static void test_reftable_stack_log_normalize=
(void)
      	EXPECT_ERR(err);
     =20
     -	input.value.update.message =3D "one\ntwo";
    -+	input.value.update.message =3D (char *)"one\ntwo";
    ++	input.value.update.message =3D onetwomessage;
      	err =3D reftable_stack_add(st, &write_test_log, &arg);
      	EXPECT(err =3D=3D REFTABLE_API_ERROR);
     =20
     -	input.value.update.message =3D "one";
    -+	input.value.update.message =3D (char *)"one";
    ++	input.value.update.message =3D onemessage;
      	err =3D reftable_stack_add(st, &write_test_log, &arg);
      	EXPECT_ERR(err);
     =20
    @@ reftable/stack_test.c: static void test_reftable_stack_log_normalize=
(void)
      	EXPECT(0 =3D=3D strcmp(dest.value.update.message, "one\n"));
     =20
     -	input.value.update.message =3D "two\n";
    -+	input.value.update.message =3D (char *)"two\n";
    ++	input.value.update.message =3D twomessage;
      	arg.update_index =3D 2;
      	err =3D reftable_stack_add(st, &write_test_log, &arg);
      	EXPECT_ERR(err);
    -@@ reftable/stack_test.c: static void test_reftable_stack_hash_id(void)
    +@@ reftable/stack_test.c: static void test_reftable_stack_tombstone(vo=
id)
    + static void test_reftable_stack_hash_id(void)
    + {
    + 	char *dir =3D get_tmp_dir(__LINE__);
    +-
    + 	struct reftable_write_options cfg =3D { 0 };
    + 	struct reftable_stack *st =3D NULL;
      	int err;
    -=20
    +-
    ++	char master[] =3D "master", target[] =3D "target";
      	struct reftable_ref_record ref =3D {
     -		.refname =3D "master",
    -+		.refname =3D (char *)"master",
    ++		.refname =3D master,
      		.value_type =3D REFTABLE_REF_SYMREF,
     -		.value.symref =3D "target",
    -+		.value.symref =3D (char *)"target",
    ++		.value.symref =3D target,
      		.update_index =3D 1,
      	};
      	struct reftable_write_options cfg32 =3D { .hash_id =3D GIT_SHA256_FO=
RMAT_ID };
     @@ reftable/stack_test.c: static void test_reftable_stack_auto_compact=
ion(void)
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +-		char name[100];
    ++		char name[100], master[] =3D "master";
    + 		struct reftable_ref_record ref =3D {
      			.refname =3D name,
      			.update_index =3D reftable_stack_next_update_index(st),
      			.value_type =3D REFTABLE_REF_SYMREF,
     -			.value.symref =3D "master",
    -+			.value.symref =3D (char *)"master",
    ++			.value.symref =3D master,
      		};
      		snprintf(name, sizeof(name), "branch%04d", i);
     =20
     @@ reftable/stack_test.c: static void test_reftable_stack_add_performs=
_auto_compaction(void)
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i <=3D n; i++) {
    ++		char master[] =3D "master";
      		struct reftable_ref_record ref =3D {
      			.update_index =3D reftable_stack_next_update_index(st),
      			.value_type =3D REFTABLE_REF_SYMREF,
     -			.value.symref =3D "master",
    -+			.value.symref =3D (char *)"master",
    ++			.value.symref =3D master,
      		};
     =20
      		/*
     @@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent(void)
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +-		char name[100];
    ++		char name[100], master[] =3D "master";
    + 		struct reftable_ref_record ref =3D {
      			.refname =3D name,
      			.update_index =3D reftable_stack_next_update_index(st1),
      			.value_type =3D REFTABLE_REF_SYMREF,
     -			.value.symref =3D "master",
    -+			.value.symref =3D (char *)"master",
    ++			.value.symref =3D master,
      		};
      		snprintf(name, sizeof(name), "branch%04d", i);
     =20
     @@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent_clean(void)
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +-		char name[100];
    ++		char name[100], master[] =3D "master";
    + 		struct reftable_ref_record ref =3D {
      			.refname =3D name,
      			.update_index =3D reftable_stack_next_update_index(st1),
      			.value_type =3D REFTABLE_REF_SYMREF,
     -			.value.symref =3D "master",
    -+			.value.symref =3D (char *)"master",
    ++			.value.symref =3D master,
      		};
      		snprintf(name, sizeof(name), "branch%04d", i);
     =20
 3:  8f3decbb76 !  3:  8b71dfa208 global: convert intentionally-leaking con=
fig strings to consts
    @@ Commit message
             configured via `diff.<driver>.*` to add additional drivers. Ag=
ain,
             these have a global lifetime and are never free'd.
    =20
    -    All of these are intentionally kept alive and never free'd. Let's =
mark
    -    the respective fields as `const char *` and cast away the constnes=
s when
    -    assigning those values.
    +    All of these are intentionally kept alive and never free'd. Furthe=
rmore,
    +    all of these are being assigned both string constants in some plac=
es,
    +    and allocated strings in other places. This will cause warnings on=
ce we
    +    enable `-Wwrite-strings`, so let's mark the respective fields as `=
const
    +    char *` and cast away the constness when assigning those values.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 4:  ba50e49f86 =3D  4:  961b3357d5 compat/win32: fix const-correctness wit=
h string constants
 6:  0eaa73c109 =3D  5:  b73a45133b refspec: remove global tag refspec stru=
cture
 7:  03b13c449b =3D  6:  6da87a0905 http: do not assign string constant to =
non-const field
 8:  699eeae92c =3D  7:  3da7df97a5 line-log: always allocate the output pr=
efix
 9:  6cbb8444a6 =3D  8:  e5d14a5173 object-file: make `buf` parameter of `i=
ndex_mem()` a constant
10:  c07b27bbb4 =3D  9:  dd40c7464d parse-options: cast long name for OPTIO=
N_ALIAS
11:  3cd28ae38c =3D 10:  462502127d send-pack: always allocate receive stat=
us
12:  00b4a7dbbc ! 11:  884fbe1da5 remote-curl: avoid assigning string const=
ant to non-const variable
    @@ remote-curl.c: int cmd_main(int argc, const char **argv)
     =20
      		} else if (skip_prefix(buf.buf, "option ", &arg)) {
     -			char *value =3D strchr(arg, ' ');
    -+			const char *value =3D strchr(arg, ' ');
    -+			size_t arglen;
    ++			const char *value =3D strchrnul(arg, ' ');
    ++			size_t arglen =3D value - arg;
      			int result;
     =20
     -			if (value)
     -				*value++ =3D '\0';
    --			else
    -+			if (value) {
    -+				arglen =3D value - arg;
    -+				value++;
    -+			} else {
    -+				arglen =3D strlen(arg);
    ++			if (*value)
    ++				value++; /* skip over SP */
    + 			else
      				value =3D "true";
    -+			}
     =20
     -			result =3D set_option(arg, value);
     +			result =3D set_option(arg, arglen, value);
13:  68a7d24e4a =3D 12:  502380c2ca revision: always store allocated string=
s in output encoding
14:  0e393fa6a7 =3D 13:  ffacdc3779 mailmap: always store allocated strings=
 in mailmap blob
15:  18ba9f7b3b =3D 14:  c0fce9b87e imap-send: drop global `imap_server_con=
f` variable
16:  357d69fa8b ! 15:  e0a5b83f0e imap-send: fix leaking memory in `imap_se=
rver_conf`
    @@ Commit message
         `struct imap_server_conf`. Fix this by creating a common exit path=
 where
         we can free resources.
    =20
    -    While at it, drop the unused variables `imap_server_conf::name` and
    -    `nongit_ok`.
    +    While at it, drop the unused member `imap_server_conf::name`.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ imap-send.c: static int git_imap_config(const char *var, const char =
*val,
      	return 0;
      }
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
    - 	};
      	struct strbuf all_msgs =3D STRBUF_INIT;
      	int total;
    --	int nongit_ok;
    + 	int nongit_ok;
     +	int ret;
     =20
    --	setup_git_directory_gently(&nongit_ok);
    -+	setup_git_directory_gently(NULL);
    + 	setup_git_directory_gently(&nongit_ok);
      	git_config(git_imap_config, &server);
    -=20
    - 	argc =3D parse_options(argc, (const char **)argv, "", imap_send_opti=
ons, imap_send_usage, 0);
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
     =20
      	if (!server.folder) {
 2:  51ee5660a1 ! 16:  36a7b0a4b0 global: assign non-const strings as requi=
red
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    global: assign non-const strings as required
    +    builtin/rebase: do not assign default backend to non-constant field
    =20
    -    There are several cases where we initialize non-const fields with =
string
    -    constants. This is invalid and will cause warnings once we enable =
the
    -    `-Wwrite-strings` warning. Adapt those cases to instead use string
    -    arrays.
    +    The `struct rebase_options::default_backend` field is a non-consta=
nt
    +    string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
    +    Refactor the code to initialize and release options via two functi=
ons
    +    `rebase_options_init()` and `rebase_options_release()`. Like this,=
 we
    +    can easily adapt the former funnction to use `xstrdup()` on the de=
fault
    +    value without hiding it away in a macro.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## builtin/remote.c ##
    -@@ builtin/remote.c: static int get_head_names(const struct ref *remot=
e_refs, struct ref_states *stat
    - 	struct ref *ref, *matches;
    - 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
    - 	struct refspec_item refspec;
    -+	char refspec_str[] =3D "refs/heads/*";
    -=20
    - 	memset(&refspec, 0, sizeof(refspec));
    - 	refspec.force =3D 0;
    - 	refspec.pattern =3D 1;
    --	refspec.src =3D refspec.dst =3D "refs/heads/*";
    -+	refspec.src =3D refspec.dst =3D refspec_str;
    - 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
    - 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
    - 				    fetch_map, 1);
    -
    - ## diff.c ##
    -@@ diff.c: size_t fill_textconv(struct repository *r,
    - 		     struct diff_filespec *df,
    - 		     char **outbuf)
    - {
    -+	static char empty_str[] =3D "";
    - 	size_t size;
    -=20
    - 	if (!driver) {
    - 		if (!DIFF_FILE_VALID(df)) {
    --			*outbuf =3D "";
    -+			*outbuf =3D empty_str;
    - 			return 0;
    - 		}
    - 		if (diff_populate_filespec(r, df, NULL))
    -
    - ## entry.c ##
    -@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    - 	struct string_list_item *filter, *path;
    - 	struct progress *progress =3D NULL;
    - 	struct delayed_checkout *dco =3D state->delayed_checkout;
    -+	char empty_str[] =3D "";
    -=20
    - 	if (!state->delayed_checkout)
    - 		return errs;
    -@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    - 			if (!async_query_available_blobs(filter->string, &available_paths)=
) {
    - 				/* Filter reported an error */
    - 				errs =3D 1;
    --				filter->string =3D "";
    -+				filter->string =3D empty_str;
    - 				continue;
    - 			}
    - 			if (available_paths.nr <=3D 0) {
    -@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    - 				 * filter from the list (see
    - 				 * "string_list_remove_empty_items" call below).
    - 				 */
    --				filter->string =3D "";
    -+				filter->string =3D empty_str;
    - 				continue;
    - 			}
    + ## builtin/rebase.c ##
    +@@ builtin/rebase.c: struct rebase_options {
    + 	int config_update_refs;
    + };
     =20
    -@@ entry.c: int finish_delayed_checkout(struct checkout *state, int sh=
ow_progress)
    - 					 * Do not ask the filter for available blobs,
    - 					 * again, as the filter is likely buggy.
    - 					 */
    --					filter->string =3D "";
    -+					filter->string =3D empty_str;
    - 					continue;
    - 				}
    - 				ce =3D index_file_exists(state->istate, path->string,
    -
    - ## ident.c ##
    -@@ ident.c: static struct passwd *xgetpwuid_self(int *is_bogus)
    - 	pw =3D getpwuid(getuid());
    - 	if (!pw) {
    - 		static struct passwd fallback;
    --		fallback.pw_name =3D "unknown";
    -+		static char fallback_name[] =3D "unknown";
    - #ifndef NO_GECOS_IN_PWENT
    --		fallback.pw_gecos =3D "Unknown";
    -+		static char fallback_gcos[] =3D "Unknown";
    -+#endif
    +-#define REBASE_OPTIONS_INIT {			  	\
    +-		.type =3D REBASE_UNSPECIFIED,	  	\
    +-		.empty =3D EMPTY_UNSPECIFIED,	  	\
    +-		.keep_empty =3D 1,			\
    +-		.default_backend =3D "merge",	  	\
    +-		.flags =3D REBASE_NO_QUIET, 		\
    +-		.git_am_opts =3D STRVEC_INIT,		\
    +-		.exec =3D STRING_LIST_INIT_NODUP,		\
    +-		.git_format_patch_opt =3D STRBUF_INIT,	\
    +-		.fork_point =3D -1,			\
    +-		.reapply_cherry_picks =3D -1,             \
    +-		.allow_empty_message =3D 1,               \
    +-		.autosquash =3D -1,                       \
    +-		.rebase_merges =3D -1,                    \
    +-		.config_rebase_merges =3D -1,             \
    +-		.update_refs =3D -1,                      \
    +-		.config_update_refs =3D -1,               \
    +-		.strategy_opts =3D STRING_LIST_INIT_NODUP,\
    +-	}
    ++static void rebase_options_init(struct rebase_options *opts)
    ++{
    ++	memset(opts, 0, sizeof(*opts));
    ++	opts->type =3D REBASE_UNSPECIFIED;
    ++	opts->empty =3D EMPTY_UNSPECIFIED;
    ++	opts->default_backend =3D xstrdup("merge");
    ++	opts->keep_empty =3D 1;
    ++	opts->flags =3D REBASE_NO_QUIET;
    ++	strvec_init(&opts->git_am_opts);
    ++	string_list_init_nodup(&opts->exec);
    ++	strbuf_init(&opts->git_format_patch_opt, 0);
    ++	opts->fork_point =3D -1;
    ++	opts->reapply_cherry_picks =3D -1;
    ++	opts->allow_empty_message =3D 1;
    ++	opts->autosquash =3D -1;
    ++	opts->rebase_merges =3D -1;
    ++	opts->config_rebase_merges =3D -1;
    ++	opts->update_refs =3D -1;
    ++	opts->config_update_refs =3D -1;
    ++	string_list_init_nodup(&opts->strategy_opts);
    ++}
     +
    -+		fallback.pw_name =3D fallback_name;
    -+#ifndef NO_GECOS_IN_PWENT
    -+		fallback.pw_gecos =3D fallback_gcos;
    - #endif
    - 		pw =3D &fallback;
    - 		if (is_bogus)
    -
    - ## line-log.c ##
    -@@ line-log.c: static int process_diff_filepair(struct rev_info *rev,
    - 	struct range_set tmp;
    - 	struct diff_ranges diff;
    - 	mmfile_t file_parent, file_target;
    -+	char empty_str[] =3D "";
    ++static void rebase_options_release(struct rebase_options *opts)
    ++{
    ++	free(opts->default_backend);
    ++	free(opts->reflog_action);
    ++	free(opts->head_name);
    ++	strvec_clear(&opts->git_am_opts);
    ++	free(opts->gpg_sign_opt);
    ++	string_list_clear(&opts->exec, 0);
    ++	free(opts->strategy);
    ++	string_list_clear(&opts->strategy_opts, 0);
    ++	strbuf_release(&opts->git_format_patch_opt);
    ++}
     =20
    - 	assert(pair->two->path);
    - 	while (rg) {
    -@@ line-log.c: static int process_diff_filepair(struct rev_info *rev,
    - 		file_parent.ptr =3D pair->one->data;
    - 		file_parent.size =3D pair->one->size;
    - 	} else {
    --		file_parent.ptr =3D "";
    -+		file_parent.ptr =3D empty_str;
    - 		file_parent.size =3D 0;
    + static struct replay_opts get_replay_opts(const struct rebase_options=
 *opts)
    + {
    +@@ builtin/rebase.c: static int rebase_config(const char *var, const c=
har *value,
      	}
     =20
    -
    - ## object-file.c ##
    -@@ object-file.c: static struct cached_object {
    - } *cached_objects;
    - static int cached_object_nr, cached_object_alloc;
    -=20
    -+static char empty_tree_buf[] =3D "";
    - static struct cached_object empty_tree =3D {
    - 	.oid =3D {
    - 		.hash =3D EMPTY_TREE_SHA1_BIN_LITERAL,
    - 	},
    - 	.type =3D OBJ_TREE,
    --	.buf =3D "",
    -+	.buf =3D empty_tree_buf,
    - };
    + 	if (!strcmp(var, "rebase.backend")) {
    ++		FREE_AND_NULL(opts->default_backend);
    + 		return git_config_string(&opts->default_backend, var, value);
    + 	}
     =20
    - static struct cached_object *find_cached_object(const struct object_i=
d *oid)
    -
    - ## pretty.c ##
    -@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in =
UTF-8 */
    - 		return 1;
    - 	case 'D':
    - 		{
    -+			char empty_str[] =3D "";
    - 			const struct decoration_options opts =3D {
    --				.prefix =3D "",
    --				.suffix =3D ""
    -+				.prefix =3D empty_str,
    -+				.suffix =3D empty_str,
    - 			};
    +@@ builtin/rebase.c: static int check_exec_cmd(const char *cmd)
     =20
    - 			format_decorations(sb, commit, c->auto_color, &opts);
    -
    - ## refs/reftable-backend.c ##
    -@@ refs/reftable-backend.c: static int write_copy_table(struct reftabl=
e_writer *writer, void *cb_data)
    - 	struct strbuf errbuf =3D STRBUF_INIT;
    - 	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
    - 	const char *committer_info;
    -+	char head[] =3D "HEAD";
    - 	int ret;
    + int cmd_rebase(int argc, const char **argv, const char *prefix)
    + {
    +-	struct rebase_options options =3D REBASE_OPTIONS_INIT;
    ++	struct rebase_options options;
    + 	const char *branch_name;
    + 	int ret, flags, total_argc, in_progress =3D 0;
    + 	int keep_base =3D 0;
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    + 	};
    + 	int i;
     =20
    - 	committer_info =3D git_committer_info(0);
    -@@ refs/reftable-backend.c: static int write_copy_table(struct reftabl=
e_writer *writer, void *cb_data)
    - 		if (append_head_reflog) {
    - 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
    - 			logs[logs_nr] =3D logs[logs_nr - 1];
    --			logs[logs_nr].refname =3D "HEAD";
    -+			logs[logs_nr].refname =3D head;
    - 			logs_nr++;
    - 		}
    - 	}
    -@@ refs/reftable-backend.c: static int write_copy_table(struct reftabl=
e_writer *writer, void *cb_data)
    - 	string_list_clear(&skip, 0);
    - 	strbuf_release(&errbuf);
    - 	for (i =3D 0; i < logs_nr; i++) {
    --		if (!strcmp(logs[i].refname, "HEAD"))
    -+		if (logs[i].refname =3D=3D head)
    - 			continue;
    - 		logs[i].refname =3D NULL;
    - 		reftable_log_record_release(&logs[i]);
    ++	rebase_options_init(&options);
    ++
    + 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
    + 		usage_with_options(builtin_rebase_usage,
    + 				   builtin_rebase_options);
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    + cleanup:
    + 	strbuf_release(&buf);
    + 	strbuf_release(&revisions);
    +-	free(options.reflog_action);
    +-	free(options.head_name);
    +-	strvec_clear(&options.git_am_opts);
    +-	free(options.gpg_sign_opt);
    +-	string_list_clear(&options.exec, 0);
    +-	free(options.strategy);
    +-	string_list_clear(&options.strategy_opts, 0);
    +-	strbuf_release(&options.git_format_patch_opt);
    ++	rebase_options_release(&options);
    + 	free(squash_onto_name);
    + 	free(keep_base_onto_name);
    + 	return !!ret;
17:  16d3d28243 ! 17:  3552ab9748 builtin/rebase: adapt code to not assign =
string constants to non-const
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    builtin/rebase: adapt code to not assign string constants to non-c=
onst
    +    builtin/rebase: always store allocated string in `options.strategy`
    =20
    -    When computing the rebase strategy we temporarily assign a string
    -    constant to `options.strategy` before we call `xstrdup()` on it.
    -    Furthermore, the default backend is being assigned a string consta=
nt via
    -    `REBASE_OPTIONS_INIT`. Both of these will cause warnings once we e=
nable
    -    `-Wwrite-strings`.
    +    The `struct rebase_options::strategy` field is a `char *`, but we =
do end
    +    up assigning string constants to it in two cases:
    =20
    -    Adapt the code such that we only store allocated strings in those
    -    variables.
    +      - When being passed a `--strategy=3D` option via the command lin=
e.
    +
    +      - When being passed a strategy option via `--strategy-option=3D`=
, but
    +        not a strategy.
    +
    +    This will cause warnings once we enable `-Wwrite-strings`.
    +
    +    Ideally, we'd just convert the field to be a `const char *`. But w=
e also
    +    assign to this field via the GIT_TEST_MERGE_ALGORITHM envvar, whic=
h we
    +    have to strdup(3P) into it.
    +
    +    Instead, refactor the code to make sure that we only ever assign
    +    allocated strings to this field.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/rebase.c ##
    -@@ builtin/rebase.c: struct rebase_options {
    - 		.type =3D REBASE_UNSPECIFIED,	  	\
    - 		.empty =3D EMPTY_UNSPECIFIED,	  	\
    - 		.keep_empty =3D 1,			\
    --		.default_backend =3D "merge",	  	\
    - 		.flags =3D REBASE_NO_QUIET, 		\
    - 		.git_am_opts =3D STRVEC_INIT,		\
    - 		.exec =3D STRING_LIST_INIT_NODUP,		\
    -@@ builtin/rebase.c: static int rebase_config(const char *var, const c=
har *value,
    - 	}
    -=20
    - 	if (!strcmp(var, "rebase.backend")) {
    -+		FREE_AND_NULL(opts->default_backend);
    - 		return git_config_string(&opts->default_backend, var, value);
    - 	}
    -=20
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    + {
    + 	struct rebase_options options;
    + 	const char *branch_name;
    ++	const char *strategy_opt =3D NULL;
    + 	int ret, flags, total_argc, in_progress =3D 0;
    + 	int keep_base =3D 0;
    + 	int ok_to_skip_pre_rebase =3D 0;
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    + 			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
    + 		OPT_BOOL(0, "fork-point", &options.fork_point,
    + 			 N_("use 'merge-base --fork-point' to refine upstream")),
    +-		OPT_STRING('s', "strategy", &options.strategy,
    ++		OPT_STRING('s', "strategy", &strategy_opt,
    + 			   N_("strategy"), N_("use the given merge strategy")),
    + 		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
    + 				N_("option"),
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    + 		}
      	}
     =20
    - 	if (options.strategy_opts.nr && !options.strategy)
    +-	if (options.strategy_opts.nr && !options.strategy)
     -		options.strategy =3D "ort";
     -
     -	if (options.strategy) {
     -		options.strategy =3D xstrdup(options.strategy);
    ++	if (strategy_opt)
    ++		options.strategy =3D xstrdup(strategy_opt);
    ++	else if (options.strategy_opts.nr && !options.strategy)
     +		options.strategy =3D xstrdup("ort");
    -+	else
    -+		options.strategy =3D xstrdup_or_null(options.strategy);
     +	if (options.strategy)
      		imply_merge(&options, "--strategy");
     -	}
     =20
      	if (options.root && !options.onto_name)
      		imply_merge(&options, "--root without --onto");
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    - 	}
    -=20
    - 	if (options.type =3D=3D REBASE_UNSPECIFIED) {
    --		if (!strcmp(options.default_backend, "merge"))
    -+		if (!options.default_backend)
    -+			options.type =3D REBASE_MERGE;
    -+		else if (!strcmp(options.default_backend, "merge"))
    - 			options.type =3D REBASE_MERGE;
    - 		else if (!strcmp(options.default_backend, "apply"))
    - 			options.type =3D REBASE_APPLY;
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    - cleanup:
    - 	strbuf_release(&buf);
    - 	strbuf_release(&revisions);
    -+	free(options.default_backend);
    - 	free(options.reflog_action);
    - 	free(options.head_name);
    - 	strvec_clear(&options.git_am_opts);
18:  129482dbaa =3D 18:  bf854b3979 builtin/merge: always store allocated s=
trings in `pull_twohead`
19:  37e7aaed97 =3D 19:  9b9d57ae84 config.mak.dev: enable `-Wwrite-strings=
` warning
--=20
2.45.1.313.g3a57aa566a.dirty


--lUkarZj6jpie2M75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdhEACgkQVbJhu7ck
PpQr3BAAio33CyIcWdQRlIjMXEynKG8bh70zoLm+Nh8cj5re7vFLQL6MfHGPcRZT
ZySrWDgaIaBB0aDHHaZ2H3QNJu7pIdHvWeqp3bjBLdXI8K2D0Bixjv6Vn3X041rG
49q93mExZ+QjIImor/wVlujZV22JK7kioebc+Nht5IVrSE2pZdzGaZWgbnd9NF1B
Me1h7eauIhWVjUbHJC27QmN8hE/wgdPEOhEBsaBEb1SfbXifIh0sH9bUNNTjsDeM
+HOGYZu//ItGwTbzrTFRw/qvFA0FVJjtPkKOtFxMgb1pyZQFE22Lg7bE0wMdMFAa
tAp2z722S2XZ1O25BpgeDAhK8rJ/vauAvIYf19DxIwp/mt/2QQcvsulfj7Vo8r48
EXcsyPCrkUtEZebZLXG1XhbQ9bvjslvSmWHprfpVj82MWg+Y9Rwf7hlL3dS35beJ
7XJUM4iZD8VpaQpTKd9nIMceDH0R1aYgT5/sA493y7q+3uPS12hXQ9wy0iNP3qNw
iwxJ/Ky9rexNEY7DWea4OIb1C1McrgE6GnzEdTE8c0KNNU1EgZKmUeSFxBokJwvt
uJOccKbxXmgv8u5/Td2zbGUoHJx51b6I8yGl8YVdVLlWoQHZDUwP6O01RkSEnvRb
4Eiiko8bSLs23Yk2REoqoqlMTlS0oHasLQhzFP2KQ0WiJ2Jbaao=
=WF3P
-----END PGP SIGNATURE-----

--lUkarZj6jpie2M75--
