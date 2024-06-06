Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064E2E639
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669674; cv=none; b=myOp12Sf+gEpoj4/1W8joJ6vVzt91x0sY+G7HBKAHuSci9bH98xL2edWlbDMfk8my+8yQcPsCNMz9dqxrDdnb+MjFrLeoS7fmekvBPxvXH7FGbqS/BeNPFJ/iq6wkN3r0NK7OT/ujpCDQNFTJ6YDWHo5Keftu9KGSVR6xTazUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669674; c=relaxed/simple;
	bh=abVeX9FAgb8LMTCNKOQMyhgSGbYwiqkW1j7zKgN6eqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNjyRKK/mE8IWfIU9mf+1k5ItKwPRbCWQg1eTYtWjde7yQa2wdjvQMMCktL2gFOCN4BaTCsdA2a+LMknPuMhOubfYDfpZaMrDwQLowENWdqO5+IOq1Jj5ly/Vgeq/TrXYTnzbZRRPjX+MVPP7tTan8BBB56dIVAJmsUq8L9b6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GOz5MoQJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRu4ePNM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GOz5MoQJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRu4ePNM"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2B96A11401AD;
	Thu,  6 Jun 2024 06:27:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 06:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669671; x=1717756071; bh=DvKOVuohD7
	k2FtXkSJuWzInTX1LFq9R9u5lJslsT9As=; b=GOz5MoQJxaF+kVlwPc+A82TUxl
	EXiZWMbm3W5PY3UHneBrB6VV8BEgdGILFwnDh4jqCotSFJpFejCfOCbtJ3h4YbzM
	6N4AYkLHGVhzjKaIr7mxiSHj5vvHAfRnuvBwHpntgr41vwJGzWfu69pmWPtKgU4r
	TyoCVRbQfzGYzkTU3+Mkk/T/SZ9ZaPY9ZeUtjJXAVFvDmsh9YGV4b1Xfmdy9AvLf
	paf7SBiB1sJJq5pkvnzmbJiwn0bNm4bZRiWExnubsd5BJT7U1+NIBHA4luZy1s5V
	XAcidmzZHXXpPsDS1BHff4z/gpXxZVT7WI44qUNnk6e4k4w1aFrPzfvPUZZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669671; x=1717756071; bh=DvKOVuohD7k2FtXkSJuWzInTX1LF
	q9R9u5lJslsT9As=; b=cRu4ePNMTEPsQ7fVibx2kst5w51cYgWh1XgDrEP1tsYl
	LbMJRfFM1snWvmTWbCoWqBiUCAXXkTQT/PTzdpCn0GBqQUfNJ5E1o3OBJD688n2W
	931o0gJs5zQj6ZqOUVo9IhARNDmdSn3XYhoYW0RTn+vMq9fmfFQYl5TJo6GVfJTu
	AlLXKYRkINGcTg1lpEbSGV3vGfImLOSoEQTugnCnu4AUY4kRSkfN1f+NkcLX0urU
	LQ4mzX4Wd1B8G2PJoLFc7DiH/Vtxb1JOAxxxVhyNfhm0wIlrBH9v5XLe/8tDtp62
	P9h2nVDWGoGkJx02cfGh2EWpmoEd1Yu+dySjic6Fyw==
X-ME-Sender: <xms:Jo9hZjE6uGVpe1SDmijaOCp7C-Fch_AALRZg6ZlCbTg7knZjLKF-Lg>
    <xme:Jo9hZgXp2j4aJIV5_dJMkg9zh6JlDt0VtK8xk5wLZTHlaKtE76L7TXchy3v1tsmwe
    In5ANuECvjgAicCQw>
X-ME-Received: <xmr:Jo9hZlINjI41wZV5StUILCtOKjLk1h3KetcaopN-m11vnqtIS03v6quytzhxctj7qIrtvqAt4_gOpsRrG93rgyCBdmr1NwbR7UMsoC26X1R6xoMT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdekfeegieeiudfgvdegfeffgfdtheegfeeiteffkeelteegffdvhfevjedujedt
    necuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Jo9hZhHEFC6_2gCJSIwCexaYTT_WuOU9Ht1G7-RFQs78ZhTKWNnLTQ>
    <xmx:J49hZpWF7gDaIxTUes2B5K-0tg19fAZw-kMEZfzQB2IGdYo7KqsknQ>
    <xmx:J49hZsNa1Y0rVe0m8QOsjXwuhOdYSEAiQNN0BS2fCbdewO0XXDtEbg>
    <xmx:J49hZo1oxEsyGhwoYuSvxQXxB7c1VyIySG4qTM3AkkLTSSbD_-hrnw>
    <xmx:J49hZvybk8Vys5IGkTCcnyoHT5RQm3FP8XSspRRB3sqIU34mR1ya6JTi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:27:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3120b308 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:17 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:27:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 00/27] Compile with `-Wwrite-strings`
Message-ID: <cover.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t/dD/x7iSgUiAeAL"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--t/dD/x7iSgUiAeAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another version of my patch series that prepares our code base
to compile with `-Wwrite-strings`. The effect of that warning is to turn
string constants from type `char []` to `const char []` so that we can
detect more readily when something may accidentally try to write to or
free a constant.

Changes compared to v5:

  - Plug a memory leak in `pretend_object_file()`.

  - Drop `rebase_options_init()` in favor of `REBASE_OPTIONS_INIT`.

Thanks!

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
 builtin/rebase.c             |  39 ++++++-----
 builtin/receive-pack.c       |   4 +-
 builtin/remote.c             |  12 ++--
 builtin/revert.c             |   2 +-
 builtin/send-pack.c          |   2 +
 compat/basename.c            |  16 ++++-
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
 object-file.c                |  27 +++++---
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
 68 files changed, 448 insertions(+), 368 deletions(-)

Range-diff against v4:
 1:  e01fde88fe =3D  1:  e01fde88fe global: improve const correctness when =
assigning string constants
 2:  92cb0b28c6 =3D  2:  92cb0b28c6 global: convert intentionally-leaking c=
onfig strings to consts
 3:  379145478c =3D  3:  379145478c refs/reftable: stop micro-optimizing re=
fname allocations on copy
 4:  d0a2a2f6c5 =3D  4:  d0a2a2f6c5 reftable: cast away constness when assi=
gning constants to records
 5:  ead27d3d97 =3D  5:  ead27d3d97 refspec: remove global tag refspec stru=
cture
 6:  7cb5df9182 =3D  6:  7cb5df9182 builtin/remote: cast away constness in =
`get_head_names()`
 7:  6e631a9ea4 =3D  7:  6e631a9ea4 diff: cast string constant in `fill_tex=
tconv()`
 8:  ac164651a3 =3D  8:  ac164651a3 line-log: stop assigning string constan=
t to file parent buffer
 9:  b717af02f0 =3D  9:  b717af02f0 line-log: always allocate the output pr=
efix
10:  b46dd3210d =3D 10:  b46dd3210d entry: refactor how we remove items for=
 delayed checkouts
11:  030dbd0288 =3D 11:  030dbd0288 ident: add casts for fallback name and =
GECOS
12:  ecca8e973d ! 12:  5cd014c22c object-file: mark cached object buffers a=
s const
    @@ object-file.c: int pretend_object_file(void *buf, unsigned long len,=
 enum object
     =20
      	hash_object_file(the_hash_algo, buf, len, type, oid);
      	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO=
_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
    -@@ object-file.c: int pretend_object_file(void *buf, unsigned long len=
, enum object_type type,
    +-	    find_cached_object(oid))
    ++	    find_cached_object(oid)) {
    ++		free(co_buf);
    + 		return 0;
    ++	}
    + 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc=
);
      	co =3D &cached_objects[cached_object_nr++];
      	co->size =3D len;
      	co->type =3D type;
13:  62f0e47f94 =3D 13:  69d904ddce object-file: make `buf` parameter of `i=
ndex_mem()` a constant
14:  e057ead2b4 =3D 14:  ed8f07aa59 pretty: add casts for decoration option=
 pointers
15:  06b6120d26 =3D 15:  5953ae1dac compat/win32: fix const-correctness wit=
h string constants
16:  a8ef39d73d =3D 16:  c80f6eff8c http: do not assign string constant to =
non-const field
17:  9d596a07c5 =3D 17:  3afd012a88 parse-options: cast long name for OPTIO=
N_ALIAS
18:  4019b532f9 =3D 18:  527755b648 send-pack: always allocate receive stat=
us
19:  f2f1ada143 =3D 19:  4598592d2f remote-curl: avoid assigning string con=
stant to non-const variable
20:  27660b908c =3D 20:  38fcea2845 revision: always store allocated string=
s in output encoding
21:  ef43c1b18f =3D 21:  f990bbeb85 mailmap: always store allocated strings=
 in mailmap blob
22:  0a69ce4b44 =3D 22:  fff2379832 imap-send: drop global `imap_server_con=
f` variable
23:  9ccafd286b =3D 23:  9ab84e459a imap-send: fix leaking memory in `imap_=
server_conf`
24:  e19457d20c ! 24:  81c69da2e8 builtin/rebase: do not assign default bac=
kend to non-constant field
    @@ Commit message
    =20
         The `struct rebase_options::default_backend` field is a non-consta=
nt
         string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
    -    Refactor the code to initialize and release options via two functi=
ons
    -    `rebase_options_init()` and `rebase_options_release()`. Like this,=
 we
    -    can easily adapt the former funnction to use `xstrdup()` on the de=
fault
    -    value without hiding it away in a macro.
    +    Fix this by using `xstrdup()` to assign the variable and introduce=
 a new
    +    function `rebase_options_release()` that releases memory held by t=
he
    +    structure, including the newly-allocated variable.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: struct rebase_options {
    - 	int config_update_refs;
    - };
    -=20
    --#define REBASE_OPTIONS_INIT {			  	\
    --		.type =3D REBASE_UNSPECIFIED,	  	\
    --		.empty =3D EMPTY_UNSPECIFIED,	  	\
    --		.keep_empty =3D 1,			\
    + 		.type =3D REBASE_UNSPECIFIED,	  	\
    + 		.empty =3D EMPTY_UNSPECIFIED,	  	\
    + 		.keep_empty =3D 1,			\
     -		.default_backend =3D "merge",	  	\
    --		.flags =3D REBASE_NO_QUIET, 		\
    --		.git_am_opts =3D STRVEC_INIT,		\
    --		.exec =3D STRING_LIST_INIT_NODUP,		\
    --		.git_format_patch_opt =3D STRBUF_INIT,	\
    --		.fork_point =3D -1,			\
    --		.reapply_cherry_picks =3D -1,             \
    --		.allow_empty_message =3D 1,               \
    --		.autosquash =3D -1,                       \
    --		.rebase_merges =3D -1,                    \
    --		.config_rebase_merges =3D -1,             \
    --		.update_refs =3D -1,                      \
    --		.config_update_refs =3D -1,               \
    --		.strategy_opts =3D STRING_LIST_INIT_NODUP,\
    --	}
    -+static void rebase_options_init(struct rebase_options *opts)
    -+{
    -+	memset(opts, 0, sizeof(*opts));
    -+	opts->type =3D REBASE_UNSPECIFIED;
    -+	opts->empty =3D EMPTY_UNSPECIFIED;
    -+	opts->default_backend =3D xstrdup("merge");
    -+	opts->keep_empty =3D 1;
    -+	opts->flags =3D REBASE_NO_QUIET;
    -+	strvec_init(&opts->git_am_opts);
    -+	string_list_init_nodup(&opts->exec);
    -+	strbuf_init(&opts->git_format_patch_opt, 0);
    -+	opts->fork_point =3D -1;
    -+	opts->reapply_cherry_picks =3D -1;
    -+	opts->allow_empty_message =3D 1;
    -+	opts->autosquash =3D -1;
    -+	opts->rebase_merges =3D -1;
    -+	opts->config_rebase_merges =3D -1;
    -+	opts->update_refs =3D -1;
    -+	opts->config_update_refs =3D -1;
    -+	string_list_init_nodup(&opts->strategy_opts);
    -+}
    -+
    ++		.default_backend =3D xstrdup("merge"),  	\
    + 		.flags =3D REBASE_NO_QUIET, 		\
    + 		.git_am_opts =3D STRVEC_INIT,		\
    + 		.exec =3D STRING_LIST_INIT_NODUP,		\
    +@@ builtin/rebase.c: struct rebase_options {
    + 		.strategy_opts =3D STRING_LIST_INIT_NODUP,\
    + 	}
    +=20
     +static void rebase_options_release(struct rebase_options *opts)
     +{
     +	free(opts->default_backend);
    @@ builtin/rebase.c: struct rebase_options {
     +	string_list_clear(&opts->strategy_opts, 0);
     +	strbuf_release(&opts->git_format_patch_opt);
     +}
    -=20
    ++
      static struct replay_opts get_replay_opts(const struct rebase_options=
 *opts)
      {
    + 	struct replay_opts replay =3D REPLAY_OPTS_INIT;
     @@ builtin/rebase.c: static int rebase_config(const char *var, const c=
har *value,
      	}
     =20
    @@ builtin/rebase.c: static int rebase_config(const char *var, const ch=
ar *value,
      		return git_config_string(&opts->default_backend, var, value);
      	}
     =20
    -@@ builtin/rebase.c: static int check_exec_cmd(const char *cmd)
    -=20
    - int cmd_rebase(int argc, const char **argv, const char *prefix)
    - {
    --	struct rebase_options options =3D REBASE_OPTIONS_INIT;
    -+	struct rebase_options options;
    - 	const char *branch_name;
    - 	int ret, flags, total_argc, in_progress =3D 0;
    - 	int keep_base =3D 0;
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    - 	};
    - 	int i;
    -=20
    -+	rebase_options_init(&options);
    -+
    - 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
    - 		usage_with_options(builtin_rebase_usage,
    - 				   builtin_rebase_options);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
      cleanup:
      	strbuf_release(&buf);
25:  f548241960 ! 25:  6819bf6116 builtin/rebase: always store allocated st=
ring in `options.strategy`
    @@ Commit message
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
      {
    - 	struct rebase_options options;
    + 	struct rebase_options options =3D REBASE_OPTIONS_INIT;
      	const char *branch_name;
     +	const char *strategy_opt =3D NULL;
      	int ret, flags, total_argc, in_progress =3D 0;
26:  78ac075644 =3D 26:  a1d2149429 builtin/merge: always store allocated s=
trings in `pull_twohead`
27:  0cd4ce07d8 =3D 27:  c714b67199 config.mak.dev: enable `-Wwrite-strings=
` warning
--=20
2.45.2.409.g7b0defb391.dirty


--t/dD/x7iSgUiAeAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhjyEACgkQVbJhu7ck
PpRowA/+Ms70dJgw7RWGcNDKGZDnlLNf7LBtwaLnSIL7ZoVm/pMWkbnOHB3yUkj3
RTBKlWhKZ4nKhS3bLDTnG4mqZhiJ5P6U0h6md1E5krF0nJ7TjDYYg302cFlgdMYw
h6dOuKH/1WeAWZzZod4jFCSz7wEY3FeE506H/hTWpOFuTIx3RFLMbwoW30zGI/PU
bErEPQPzhg2QTxZtcoebdM8aZ3ouiin5C8styMpgO9op4z5bc9cUaIjRcnhvHfjZ
CSX/nKtTVtTSZK62VTYfqZSc1iDoqb4B2ZiC41pkmoKURJ2ftsgm5W1YxozWlZgA
8KA6ehsQuZfmcmRiae4KUfOUTJIHqeU4bWD00r2xTijflSYEJbEzEqIVOBPIlaq1
QTFmBNcOhKUOHMd1HEIDJmyJSPvQ5O9zxQ87j7/bjvmmS9i/Je+G8pY3dcwlzafM
G+Qw9UpbLx1BSdbZDWNrlIM2U+884AOIfRnhpgOCL3nQDJkmqPYSBaneqZLS8b/H
TTrIz3bq0u6PNvAlwALGMJhXbLuBc6XJnoUqO/Y5JOZC3I+dOVXHmpBeL+GHV8Xp
kZWl9QDb6hsb8dE3N6KeRU9+D90KVu8AY6eMao4Q7cYmgrfoEg2ALk26pvk0SkTe
0fU64ySpaq8nEep6d6K7ZiHhESVrdSqhCRTRR1JVyRvzedI/ZV4=
=q6rs
-----END PGP SIGNATURE-----

--t/dD/x7iSgUiAeAL--
