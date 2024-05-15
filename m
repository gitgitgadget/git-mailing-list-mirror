Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE33FB89
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755301; cv=none; b=Olt1lJyFoVJg9K7EPoa8sdNTR7vIjOM0xmWBtvgqna9RUpkMw/XLgtGLhbSc7LSyorTtnTkD93owDIp6RO3xJDcprukjPxS3Kge0SRYUK2Q4oqfuGZEwzHGs2pqJu+voDKAOXHA17o7ytCbEOazo2k7q51cOSj+RHcr4mjSNkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755301; c=relaxed/simple;
	bh=2p5n6KGdwpbh203GjPRHnYINZSbfidUxY4Ww4hPQTTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVvM7L67yp/VY/SDggOKrK7iCA8+GVHobC3mYjwB+ttOYl7QAGxf1W1IEtE/5NWYD6L//yY/ZrMN/thT7H/U51rLunlZB/xErpo/tiIJXatJnFOJl5hhZCABlI0UX7IH7OlDOnjyZavdf6ita48E0QupLpoEvCb/OuFc+0yeteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TTCnKF7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJidnPmt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TTCnKF7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJidnPmt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BBF5C1380222;
	Wed, 15 May 2024 02:41:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755298; x=1715841698; bh=Y1CUYKqmuj
	kDjMavU40Jy8r7ntYd6ZuYGCLGc7dgVs0=; b=TTCnKF7CJLtTcFYIuM7Cg5EzKD
	rg4V1BGalXsQ4mPWOIUXpc1/zdulkK14cKll7NcvlWU69mR9oBHr4hFxgk+y6SnJ
	bIPdcgkBsijLWmwPgUKVUaD9Nh3Tq47Dj67/9PGQnvZrQAig3mq5uXx4FftKBmQW
	kgiezGdC3d+SUgJaLCl0P4Iy1bRFVfnNI4TQcKbW90vZvSVE8MgqT2KOqIAhX/FZ
	q6zSwJeoBr8JGjNP/mxhPsILerr3lk6A3cSoIMPx7td4Nz1ZeBKTDAMP0NFi9Fyl
	EXlRj2wxBFMsqM8/NGZbygdnfBhe0rxqP8GDFPyMxN1lUvz5QusGZ+BgnisQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755298; x=1715841698; bh=Y1CUYKqmujkDjMavU40Jy8r7ntYd
	6ZuYGCLGc7dgVs0=; b=dJidnPmtSzH83JashgrYQMszmAeocTh8jT+w1UxziCTq
	Ef+lxQ+GWJ2ZBan6aclN308hSP2/cANSCy2b0+m3mLhxOFKr0bS6g7rqRfnQA8i6
	SkQd7E41JL0QcoPy+L1y1Pe5FtY1QjqDxAFZyoV0jGhCx7BWvmIRfQHDhHAIRrVu
	Ga4UBQ1afItU8WarLzWvPENLi/yQB3fYc/vQRY7hNASFyo1nEsSFSWyl1P7Kq0CY
	fa3HqZVW+KLzzY+nbfiLXZZC8PiAqY1jkZVxnt2jKfUy2l+PmXEC+KN2uLo92jEV
	u2o20ryT8xy6jlUtVHGDR0Bf6iF/APBPlXqqGbt5Pw==
X-ME-Sender: <xms:IllEZiq4yVN8Bn13uZ71BNAlQX7KmD40RwRyw9pnJCKVvOFngjko9w>
    <xme:IllEZgpCB2Oq54SsNrgqCtq_T3iejKTjmEE-kIeaXoD_2TLc6axK6qeRUqcSbDQUI
    Pl7WdSC5J2GfLOR7Q>
X-ME-Received: <xmr:IllEZnNyBDRz69N_BxeunyP-IG6JZngDjDAk6mQbIIAb7Ns-ZT3-cXpr6AJy-BQR6RF9nE9OYOPe4MTyM2D100JAMu0NhZWRkuNXDLtcW2ApP8z9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeelgfeitdffkedvteffgeduuedvffdtffehteefleffvedvffehvdffgeelgeeg
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IllEZh55n6VZqN2OJgqniKR02xLBwCW0fQLsESSmZKBFCHZx4Vl-BA>
    <xmx:IllEZh5Ko7PigAnKbjyFgvXc8AJUV-KYYLTRjuy6JEZItLIJOEb84Q>
    <xmx:IllEZhgfrAmBPiGChAroKbqoRmipG94YgXLE5HoE18v1XEQR8zJZqw>
    <xmx:IllEZr5e9q4tAHUZAfwbnFLnoLIwta2CSqEP1emqFckm9e8IWgRSNA>
    <xmx:IllEZk3HAZtE7EeEAZwoxEnMnOOGnaBXuuEia46P5EDVeqMDVqLhWYgG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:41:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 979650c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:13 +0000 (UTC)
Date: Wed, 15 May 2024 08:41:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/21] builtin/config: remove global state
Message-ID: <cover.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O547eMZcW1vMKddp"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--O547eMZcW1vMKddp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that removes global state
=66rom "builtin/config.c".

There is only a single change compared to v2, namely another set of
memory leak fixes for patch 9. I have double and triple checked now that
this does address all the leaks, and all the CI leak jobs (well, all
jobs in fact [1]) do pass now. Sorry for the noise and not doing this
properly in v2!

[1]: https://gitlab.com/gitlab-org/git/-/pipelines/1291267388

Patrick

Patrick Steinhardt (21):
  builtin/config: stop printing full usage on misuse
  builtin/config: move legacy mode into its own function
  builtin/config: move subcommand options into `cmd_config()`
  builtin/config: move legacy options into `cmd_config()`
  builtin/config: move actions into `cmd_config_actions()`
  builtin/config: check for writeability after source is set up
  config: make the config source const
  builtin/config: refactor functions to have common exit paths
  builtin/config: move location options into local variables
  builtin/config: move display options into local variables
  builtin/config: move type options into display options
  builtin/config: move default value into display options
  builtin/config: move `respect_includes_opt` into location options
  builtin/config: convert `do_not_match` to a local variable
  builtin/config: convert `value_pattern` to a local variable
  builtin/config: convert `regexp` to a local variable
  builtin/config: convert `key_regexp` to a local variable
  builtin/config: convert `key` to a local variable
  builtin/config: track "fixed value" option via flags only
  builtin/config: convert flags to a local variable
  builtin/config: pass data between callbacks via local variables

 builtin/config.c  | 970 ++++++++++++++++++++++++++--------------------
 config.c          |   4 +-
 config.h          |   2 +-
 t/t1300-config.sh |   9 +-
 4 files changed, 552 insertions(+), 433 deletions(-)

Range-diff against v2:
 1:  0ba7628126 =3D  1:  32380a12fd builtin/config: stop printing full usag=
e on misuse
 2:  663e1f74f8 =3D  2:  8b07b280a9 builtin/config: move legacy mode into i=
ts own function
 3:  1239c151d0 =3D  3:  b1de0ff74d builtin/config: move subcommand options=
 into `cmd_config()`
 4:  82964510c5 =3D  4:  1a0c6a8384 builtin/config: move legacy options int=
o `cmd_config()`
 5:  0a6ecae2cc =3D  5:  4950ddcecd builtin/config: move actions into `cmd_=
config_actions()`
 6:  7ab99a27c1 =3D  6:  6de9097fb2 builtin/config: check for writeability =
after source is set up
 7:  1460d3a36c =3D  7:  24053f8f4f config: make the config source const
 8:  018ed0226b =3D  8:  9dc1d00f71 builtin/config: refactor functions to h=
ave common exit paths
 9:  b5d43b6f85 !  9:  2ede4a204b builtin/config: move location options int=
o local variables
    @@ builtin/config.c: static const char *const builtin_config_edit_usage=
[] =3D {
     +struct config_location_options {
     +	struct git_config_source source;
     +	struct config_options options;
    ++	char *file_to_free;
     +	int use_global_config;
     +	int use_system_config;
     +	int use_local_config;
    @@ builtin/config.c: static char *default_user_config(void)
     -	    use_worktree_config +
     -	    !!given_config_source.file + !!given_config_source.blob > 1) {
     +	if (!opts->source.file)
    -+		opts->source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
    -+	else
    -+		opts->source.file =3D xstrdup(opts->source.file);
    ++		opts->source.file =3D opts->file_to_free =3D
    ++			xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
     +
     +	if (opts->use_global_config + opts->use_system_config +
     +	    opts->use_local_config + opts->use_worktree_config +
    @@ builtin/config.c: static char *default_user_config(void)
     -		given_config_source.file =3D git_global_config();
     -		if (!given_config_source.file)
     +	if (opts->use_global_config) {
    -+		opts->source.file =3D git_global_config();
    ++		opts->source.file =3D opts->file_to_free =3D git_global_config();
     +		if (!opts->source.file)
      			/*
      			 * It is unknown if HOME/.gitconfig exists, so
    @@ builtin/config.c: static void handle_config_location(const char *pre=
fix)
     -	} else if (use_worktree_config) {
     +		opts->source.scope =3D CONFIG_SCOPE_GLOBAL;
     +	} else if (opts->use_system_config) {
    -+		opts->source.file =3D xstrdup_or_null(git_system_config());
    ++		opts->source.file =3D opts->file_to_free =3D git_system_config();
     +		opts->source.scope =3D CONFIG_SCOPE_SYSTEM;
     +	} else if (opts->use_local_config) {
    -+		opts->source.file =3D xstrdup_or_null(git_pathdup("config"));
    ++		opts->source.file =3D opts->file_to_free =3D git_pathdup("config");
     +		opts->source.scope =3D CONFIG_SCOPE_LOCAL;
     +	} else if (opts->use_worktree_config) {
      		struct worktree **worktrees =3D get_worktrees();
      		if (the_repository->repository_format_worktree_config)
     -			given_config_source.file =3D git_pathdup("config.worktree");
    -+			opts->source.file =3D git_pathdup("config.worktree");
    ++			opts->source.file =3D opts->file_to_free =3D
    ++				git_pathdup("config.worktree");
      		else if (worktrees[0] && worktrees[1])
      			die(_("--worktree cannot be used with multiple "
      			      "working trees unless the config\n"
    @@ builtin/config.c: static void handle_config_location(const char *pre=
fix)
      		else
     -			given_config_source.file =3D git_pathdup("config");
     -		given_config_source.scope =3D CONFIG_SCOPE_LOCAL;
    -+			opts->source.file =3D git_pathdup("config");
    ++			opts->source.file =3D opts->file_to_free =3D
    ++				git_pathdup("config");
     +		opts->source.scope =3D CONFIG_SCOPE_LOCAL;
      		free_worktrees(worktrees);
     -	} else if (given_config_source.file) {
    @@ builtin/config.c: static void handle_config_location(const char *pre=
fix)
     -		given_config_source.scope =3D CONFIG_SCOPE_COMMAND;
     +	} else if (opts->source.file) {
     +		if (!is_absolute_path(opts->source.file) && prefix)
    -+			opts->source.file =3D
    ++			opts->source.file =3D opts->file_to_free =3D
     +				prefix_filename(prefix, opts->source.file);
     +		opts->source.scope =3D CONFIG_SCOPE_COMMAND;
     +	} else if (opts->source.blob) {
    @@ builtin/config.c: static void handle_config_location(const char *pre=
fix)
     =20
     +static void location_options_release(struct config_location_options *=
opts)
     +{
    -+	free((char *) opts->source.file);
    ++	free(opts->file_to_free);
     +}
     +
      static void handle_nul(void) {
10:  d66e14af30 ! 10:  4d157942e6 builtin/config: move display options into=
 local variables
    @@ builtin/config.c: static int get_urlmatch(const struct config_locati=
on_options *
      			      &matched->kvi);
      		fwrite(buf.buf, 1, buf.len, stdout);
     @@ builtin/config.c: static void location_options_release(struct confi=
g_location_options *opts)
    - 	free((char *) opts->source.file);
    + 	free(opts->file_to_free);
      }
     =20
     -static void handle_nul(void) {
11:  63436c3416 =3D 11:  5579371ad1 builtin/config: move type options into =
display options
12:  106b8ac8a2 =3D 12:  05a072d5d1 builtin/config: move default value into=
 display options
13:  8a6b555b58 =3D 13:  15d45ef7d4 builtin/config: move `respect_includes_=
opt` into location options
14:  0dd22bf51a =3D 14:  a729286cc5 builtin/config: convert `do_not_match` =
to a local variable
15:  b656951f0c =3D 15:  821bc68212 builtin/config: convert `value_pattern`=
 to a local variable
16:  b56a07bda0 =3D 16:  bac242caf0 builtin/config: convert `regexp` to a l=
ocal variable
17:  323cb05120 =3D 17:  746bdf8733 builtin/config: convert `key_regexp` to=
 a local variable
18:  e972e63be8 =3D 18:  f1f390f499 builtin/config: convert `key` to a loca=
l variable
19:  d83c3d085e =3D 19:  e4dbb4707e builtin/config: track "fixed value" opt=
ion via flags only
20:  294bcd96a4 =3D 20:  abe33015b7 builtin/config: convert flags to a loca=
l variable
21:  0496b958e2 =3D 21:  a5cb075fcd builtin/config: pass data between callb=
acks via local variables
--=20
2.45.GIT


--O547eMZcW1vMKddp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWRwACgkQVbJhu7ck
PpRSHBAAhU2OY3oHB+UkxHXcjdlIxZ6Y7qKeR2iuTR2R4ErmO8TAI5LP/M4oedIG
5g5nm/QKEOdItLqFVNHLhmB1FmqifbPbOMMlSSe3awwbJG06l1lBrgQvCxUTyXVr
/BKrUhfmjBgXGJqKmIt4eQZlUYLScydIqVnxFPgS/V6BU8zTXcF+/6glNvgpHPoP
WR6lh8aRLHDeccl5KL3QvM161bnulst8eKEkthXqRFiCs4dMJBqsFZBimXD6mP3t
KrfSFZUxWv2k4JndvKBrHrRaqtvkdsfih4CMzjQeTMT/8HbAmgxmpHCDaIY1Tp99
sGVLwpszQxlzU4MCNPImdPRVOGKxzryjrpkICEERvRmxHY6rdxg23bQhbP8BFSBS
2tefJRHqzD414uSZFARnjX9TyO81EDodcLLdP/lKP/DhqQRsfs0bUr/S32oWmj8H
CZVa6EI6qtkSezYX9b86fdWpXsuL9mYbsaWysW7Ycn4unMJfggm1PMW9Yjq4GgaB
764DkRnuAug5HfAGljt0J8ftK+AmhR16qmwtwGUbLHbiJGpbo1XHicXPHmRlqQMp
18D+rbYwBZ71Rom5Q4JajpZnMYK+C5ND7+ivXHy+cLW3XtQ71NCF3dEWcf4Gy0G4
sdG21K/TLI3c8P+f3dCICUnMhG4Wm+0Q+tC66vfq2IlSth2id0M=
=LN8A
-----END PGP SIGNATURE-----

--O547eMZcW1vMKddp--
