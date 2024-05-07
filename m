Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E653E49E
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057571; cv=none; b=dkexwRmIZokPefb/gw2B5437n0/t0W/UEeD2k8WDgD3IrMBN4ksWsDPN+8IebA7y9VjZMqdm8rsBV51BS5/Qc42fdWytyhIOXIi9no42XIc2ifFCkxLHgQnZdyyDfltKd5gR6EwL1Ox8O2taj7fP1uZRfRAUB4rkTHG/fyfZV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057571; c=relaxed/simple;
	bh=VSF5SZ6Jks1EnXhckAINyqBC0EL+meHRqpQqFjF/e4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoodcquWYLHTKr3VQfrjk5WhZP5FGWw2wC2GuZv4SDe2mf/67j8USmx03mI4daNZUWk8IgC9mj+RNgCoHuLQOEEMNBye8uCPjDvtOQgVNUqwPOypAkuwt2uqKvUYSYWphd0sdp3kpNFUW2sCQNkdDkKnmkmtYxAZNd8LMDsiCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ej/+v46T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTQG4xkb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ej/+v46T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTQG4xkb"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9AB66138026C;
	Tue,  7 May 2024 00:52:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 May 2024 00:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057568; x=1715143968; bh=P6u60eRrrI
	4cELpP/9uV09Dg+oURJOypwDGB+V8Is74=; b=Ej/+v46TmF64GIC83UegZH6dVs
	jtQhfjhJhFja7u5ve8D+9MZvRonY1gKXGNXDRwyrb7cVEI7yprAPy17GoaXxxmZU
	WDrfN4y4vnwwPQKeZwr5T7Q1V7HLgGLcla6/KH4iSnCdo+KSi03w6n1lu0cqhtQi
	PAhGaaszatmh9uShsyqRR76HP53o9/xs8EzTXDJ5rRrWOI+9+WqkzmSOmkqCu/ql
	YeN6iSXh+As7Kna9w1fukRxALUYPyEokNGto1AGZ35+U7XqSw+rKdaLKq9i/dJCe
	sMOx2+fcAcwnq2zX6vo+tdFEa/eOVwnDJhWxCa+SVYQ9sqp3WA3BwuKDfKyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057568; x=1715143968; bh=P6u60eRrrI4cELpP/9uV09Dg+oUR
	JOypwDGB+V8Is74=; b=eTQG4xkb1UtXLJrPlAS4jIl1VMJIJ4FvQQfwDLgzDXrq
	Wl+ft2TxoK5Q20p5oLkuSgHmSO+y7oqKAU/arKn3Q91B1Wjou2e71h2oAgbGY29n
	BJsVHxJXMR1vzgkyhHqrk5Ww5/xpES5rnQxzxtFoYdez3RGxbL3nwJ75Vmx6S4/8
	mUSwf1kzGJmaoSMRBJ02VpFCXGlJoqDSGaHmAtyQxI1XcQ7dVriEyNL68s6ffqDT
	KKPfzBa82Cq6q+vqKjHaCmxCJakcTraRK2KmCGy43XEDyryxaT6JuyO+EKUcQZoa
	mYGDKq4V5ud3BdNyjJsIKMTxsrPinv+hPcEw+FXjPw==
X-ME-Sender: <xms:oLM5Zq-D_IbtxfUsg7AoUGq9Cf4GmxjEUaJlM6fHxDc2j51PGyqGJg>
    <xme:oLM5ZqtnHcex1OFYQgZs2WTJMbreei6fXoZN8OXuTgQXVTYIQgl6NPE6RDSSEcrHm
    K3t4YegyGuAJ0p6oA>
X-ME-Received: <xmr:oLM5ZgAerQWnNBM1kEu3Nfykm_x3Odq5Z-1Elm4hZcN5qUXgMpVewO2EB844oZETMo4LXTmTcEl9u0kEy52-qDYcPOMsx9MSfXpSx397oSqpaI4RSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeigedvtdeufeetffekkeejueehffdujefhteeuueffheetvedtvdejveekfedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:oLM5ZicyjeByN3xA9xrIM9y0zL5HwVb9Gum_Tsw3l6VvCmTRaYfi6A>
    <xmx:oLM5ZvMoZcGGb0MCwvPTcwUdGNJMgxWTBhFDs7joPuhC0lsn4jmhWg>
    <xmx:oLM5ZsldxzXzQsneDWGbXoO8nyP49iUxokIs8uB9cFgxly5Zh4-8bw>
    <xmx:oLM5ZhsWDzpzlDQ75_IFpl-iJMeCPVxsehxYfHr7VW6zGoPR6xsKdQ>
    <xmx:oLM5ZkothSaLIxDoSKKnQac0CfZOlslv-wF-j5OTdJV9kkxIQ3DJzVGl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:52:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a25650a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:52:37 +0000 (UTC)
Date: Tue, 7 May 2024 06:52:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 00/13] Stop relying on SHA1 fallback for `the_hash_algo`
Message-ID: <cover.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ALXbDY7Gh2RP4etk"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--ALXbDY7Gh2RP4etk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that stops relying on the
SHA1 fallback configured for `the_hash_algo`. Instead, any callers that
access `the_hash_algo` without it being initialized will now crash hard.
This is designed to catch various subtle bugs going forward.

The only change compared to v3 of this patch series is a rebase on top
of the following two topics:

  - ps/the-index-is-no-more, which causes a conflict in the final patch.

  - jc/no-default-attr-tree-in-bare, which causes a conflict in the
    fourth patch.

Interestingly, the range diff does not surface the second resolved
conflict. This is because the context is actually the same, but when
applying the patch in question you would get a conflict. To aid with
this I decided to generate patches with `--unified=3D4`, which surfaces
the previously-conflicting hunk in `compute_default_attr_source()`.

Patrick

Patrick Steinhardt (13):
  path: harden validation of HEAD with non-standard hashes
  path: move `validate_headref()` to its only user
  parse-options-cb: only abbreviate hashes when hash algo is known
  attr: don't recompute default attribute source
  attr: fix BUG() when parsing attrs outside of repo
  remote-curl: fix parsing of detached SHA256 heads
  builtin/rev-parse: allow shortening to more than 40 hex characters
  builtin/blame: don't access potentially unitialized `the_hash_algo`
  builtin/bundle: abort "verify" early when there is no repository
  builtin/diff: explicitly set hash algo when there is no repo
  builtin/shortlog: don't set up revisions without repo
  oss-fuzz/commit-graph: set up hash algorithm
  repository: stop setting SHA1 as the default object hash

 attr.c                       | 31 +++++++++++++++------
 builtin/blame.c              |  5 ++--
 builtin/bundle.c             |  5 ++++
 builtin/diff.c               |  9 ++++++
 builtin/rev-parse.c          |  5 ++--
 builtin/shortlog.c           |  2 +-
 oss-fuzz/fuzz-commit-graph.c |  1 +
 parse-options-cb.c           |  3 +-
 path.c                       | 53 ------------------------------------
 path.h                       |  1 -
 remote-curl.c                | 19 ++++++++++++-
 repository.c                 | 20 --------------
 setup.c                      | 53 ++++++++++++++++++++++++++++++++++++
 t/t0003-attributes.sh        | 15 ++++++++++
 t/t0040-parse-options.sh     | 17 ++++++++++++
 t/t1500-rev-parse.sh         |  6 ++++
 t/t5550-http-fetch-dumb.sh   | 15 ++++++++++
 17 files changed, 168 insertions(+), 92 deletions(-)

Range-diff against v3:
 1:  5134f35cda =3D  1:  5ee372c2d8 path: harden validation of HEAD with no=
n-standard hashes
 2:  589b6a99ef =3D  2:  ece0ab94a8 path: move `validate_headref()` to its =
only user
 3:  9a63c445d2 =3D  3:  1a0859eaf1 parse-options-cb: only abbreviate hashe=
s when hash algo is known
 4:  929bacbfce =3D  4:  1204a34216 attr: don't recompute default attribute=
 source
 5:  8f20aec1ee =3D  5:  f098ce9690 attr: fix BUG() when parsing attrs outs=
ide of repo
 6:  53439067a1 =3D  6:  e8876052ad remote-curl: fix parsing of detached SH=
A256 heads
 7:  1f74960760 =3D  7:  6116030310 builtin/rev-parse: allow shortening to =
more than 40 hex characters
 8:  2d985abca1 =3D  8:  872ded113e builtin/blame: don't access potentially=
 unitialized `the_hash_algo`
 9:  f3b23d28aa =3D  9:  5b4a21d2ce builtin/bundle: abort "verify" early wh=
en there is no repository
10:  7577b6b96c =3D 10:  e7254ae757 builtin/diff: explicitly set hash algo =
when there is no repo
11:  509c79d1d3 =3D 11:  c21b15ba17 builtin/shortlog: don't set up revision=
s without repo
12:  660f976129 =3D 12:  f37beb0e89 oss-fuzz/commit-graph: set up hash algo=
rithm
13:  95909c2da5 ! 13:  950b08bc78 repository: stop setting SHA1 as the defa=
ult object hash
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## repository.c ##
    -@@ repository.c: void initialize_the_repository(void)
    - 	the_repo.parsed_objects =3D parsed_object_pool_new();
    -=20
    - 	index_state_init(&the_index, the_repository);
    +@@ repository.c: void initialize_repository(struct repository *repo)
    + 	repo->parsed_objects =3D parsed_object_pool_new();
    + 	ALLOC_ARRAY(repo->index, 1);
    + 	index_state_init(repo->index, repo);
     -
    --	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
    +-	/*
    +-	 * Unfortunately, we need to keep this hack around for the time bein=
g:
    +-	 *
    +-	 *   - Not setting up the hash algorithm for `the_repository` leads =
to
    +-	 *     crashes because `the_hash_algo` is a macro that expands to
    +-	 *     `the_repository->hash_algo`. So if Git commands try to access
    +-	 *     `the_hash_algo` without a Git directory we crash.
    +-	 *
    +-	 *   - Setting up the hash algorithm to be SHA1 by default breaks ot=
her
    +-	 *     commands when running with SHA256.
    +-	 *
    +-	 * This is another point in case why having global state is a bad id=
ea.
    +-	 * Eventually, we should remove this hack and stop setting the hash
    +-	 * algorithm in this function altogether. Instead, it should only ev=
er
    +-	 * be set via our repository setup procedures. But that requires more
    +-	 * work.
    +-	 */
    +-	if (repo =3D=3D the_repository)
    +-		repo_set_hash_algo(repo, GIT_HASH_SHA1);
      }
     =20
      static void expand_base_dir(char **out, const char *in,
--=20
2.45.0


--ALXbDY7Gh2RP4etk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s5kACgkQVbJhu7ck
PpSljBAAkP+5D+6wjsg9V9luwq0MFwr82mDyZ+MzNLGaGV5YfWml5xoy4bE6JbUj
/XRzBFkNM3l6rDhFpKzCC/zAt8DHfjHmU5+lW6lHVI6wF/VjJpVtWtvGPU1PpD1x
xSshcnUrnNwJ3RqQ4wr/7uamMnBUDD2xECRvInq5lONIxnXo8LB4XrYaHe2S4hSJ
I00hwnkxdxvBVsApyZMhp5eoDSpdsu/cRBbS1x/7speSySq/bihGyJY+cj6PNTr0
EbRcXHgsQj5IUg/hfg04DLyukLitV00A4wIqsN+mPwKfnETiPuzJRM/6bTLtuKug
3FUM0sGr/tdZ0ie3+Wifp/kztWYyVV61p/+IQNKjKB49wSDluuu8UHpT4btrXBUL
qUl/9+7TTXa+PPw9ivQxx1NJHVPQt8EUi5Tv63khnEuFicIhASLirLVZCygboCJ+
FYeKEMW7cwsfUmyntFy+2F71eVAQT1SK5cAWV3qsJufWJ9wqgL85mWzkNuOeoLW6
SirzcJRgjtGURYEj6HNfnw+GWe4R8EDko3EihHquUmwyhVp4dfM4Aj+47dWP6dVu
5dWgYQfqxAPRIsvGtf+py0lJRcLls/gGX82EFL+Qp5aGZmsNyeusR+fUg/9JQ1cl
FWKu47fYHR9SV0YGyk3G4JiMS6+g8HXUY3DMWaPxIZI6PMBuQdw=
=yMR2
-----END PGP SIGNATURE-----

--ALXbDY7Gh2RP4etk--
