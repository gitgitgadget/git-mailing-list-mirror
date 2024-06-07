Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112A29CE1
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742264; cv=none; b=LRep+qmawNnttVwc+72cyf5fl9nlbVFRMaHAo2Q9YCEBv/yqi6LmCz2sYEJqwHd/sZmdg8kiBuOFdGfQ4hPdQwtGqG48Pd1aWgxpVt+cgRHvJEk0curFII4icyhblIDC/3zIkU4PB0Txux/eV8NQ42xhplYglyN2mtapX60p6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742264; c=relaxed/simple;
	bh=R8rcusY01eXcyL56BGTaG6GueT3TDzrEEYmVdz3Lys0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF1YKd2r3ZVoA9iaPzRx2vQVg9UEVLTAcXUj7g7iK5/DumBqnZieHZhETHpD9dLpNAHOWsRXTduJl3dhDp9gXhPwXsd8+b5XNxj/KwWuwU49yrTBj8sDeDH2Pz1e4/jYr2Owii64H7zI4vE6j4HvXqwiKx/qgI8oLvKu5LYPNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H1J1G5oB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NV3SEh2D; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H1J1G5oB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NV3SEh2D"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A0A2911401F9;
	Fri,  7 Jun 2024 02:37:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742260; x=1717828660; bh=bDyxpkqG+U
	jE53r1G3qCfv1Z7lPKzOBunFJua/QhJAQ=; b=H1J1G5oBzGHrxIpdZM7LXJABNn
	uHe9yI+NwRkZ2UI7HzCJ52lLG+DIWvh60A19LjLFiJkEQljsGxBadAP+p3UkgEi9
	TuePzcUe/NdiH5twEFKgVZZKQmA6bNa+WzwqvrsHIyhhoabRnDMz2RgTOiEYXUQu
	U+oGB5GF7T9+4+5q5EX0B+z6cDwen6l6fDvViG8vFyonGVt++MyvOSuZ5x4kXW1V
	/WuQTGQchokWf0SHHxFJxpCPw24EQ6jnSOFs6EGiWt37lYaGKTNvj4Awr47PEZ/9
	43XFVSBwbzslXQ718d9olygphXCXENH0wAxeDA51h1Xekda9UtVmH4ij7wWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742260; x=1717828660; bh=bDyxpkqG+UjE53r1G3qCfv1Z7lPK
	zOBunFJua/QhJAQ=; b=NV3SEh2DXiVjaMxdDKwLrlW2O+3lNMf5/z/Yvn1dW6c5
	frMCXd3h86F9eOvqagv0vXP0w4OtnF88NkUhTnnQv6vgMaC1nkVsfQcId7dsYmDj
	qlNdKN2bGGT0zIk/sJSukZKPsbk3UKl+dZobc4Vi4B2wHZe+OlyTc2BW57JGP23q
	hFM3pTpeLRALfB9i1VCEkELBU+pNHnWraNyUdMzxGt4KiRY8B+XKN1hFf5v1Lqur
	fxMwbXY6aC9nlge+z73BcnbNoZaF4afc4M1v4waxB90iXHDh74k7bFEG4wEQ+Bqf
	1PudMHFWDH+bYMhSoI4EHfHlDlZZNwUjjjPZPeahnQ==
X-ME-Sender: <xms:tKpiZiGL5oXt5SbKfaeeQMsM4CKIz9Vyg8apKugD9ZCYW5oaaoR6Bg>
    <xme:tKpiZjX_ikyGiXZegJmUUit-6iR-RNeQlqro380Lg_k1rvXNE8ZC2Vr466dxqOvfO
    o4wB4Y3Zsj5o34KOw>
X-ME-Received: <xmr:tKpiZsKftKq1abnYUgiO77lGP1QIlEEd_1pCFMxIHiH217HS18uPCQR9N1DYBNPWZrSyXNIQXQtBULeNFPq5d5v6R3ZpNPWaqRC2NwbnbcLrjWGm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedtkeefgeeiiedugfdvgeeffffgtdehgeefieetffekleetgeffvdfhveejudej
    tdenucffohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tKpiZsG9K76NwHxWDzFymsR9szsBzoPkNoKilYwxOBQsKCe_VnpJtQ>
    <xmx:tKpiZoX1Ss0meqSxFO_zC6hC0HtRT-TbDWKLgwZ7mU3TZXXPVTkoWA>
    <xmx:tKpiZvOjAu8dhcFaH7AEkkl98l7MgF8pzzukN0QKHzc5tG9rNBbmYA>
    <xmx:tKpiZv2xDXSmZQrJtnu38Qrvt3qbujPKCqNKAcIHfIlG_vgOIm8E_A>
    <xmx:tKpiZmyj0qg_9yxjxpyu7tn4EPzBlWOa84MnOs4YOnqXubUvbn48JmGS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:37:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7ec95149 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:37:35 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:37:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 00/27] Compile with `-Wwrite-strings`
Message-ID: <cover.1717740365.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k34eGlmZDX0jAifQ"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--k34eGlmZDX0jAifQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is v6 of my patch series that starts to compile our codebase with
`-Wwrite-strings`. This warning turns the type of string constants from
`char []` to `const char []` and should thus help us to detect cases
where we may accidentally write to or free such a string constant.

The only change is in patch 12, where we now allocate a buffer later in
time to avoid a useless allocation and the need for a call to free.

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
 object-file.c                |  22 +++---
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
 68 files changed, 444 insertions(+), 367 deletions(-)

Range-diff against v5:
 1:  e01fde88fe =3D  1:  ba50d96081 global: improve const correctness when =
assigning string constants
 2:  92cb0b28c6 =3D  2:  4769bdb893 global: convert intentionally-leaking c=
onfig strings to consts
 3:  379145478c =3D  3:  90613bd582 refs/reftable: stop micro-optimizing re=
fname allocations on copy
 4:  d0a2a2f6c5 =3D  4:  b126783ba3 reftable: cast away constness when assi=
gning constants to records
 5:  ead27d3d97 =3D  5:  d10566e0a9 refspec: remove global tag refspec stru=
cture
 6:  7cb5df9182 =3D  6:  e9b8f9eaef builtin/remote: cast away constness in =
`get_head_names()`
 7:  6e631a9ea4 =3D  7:  8ea984128d diff: cast string constant in `fill_tex=
tconv()`
 8:  ac164651a3 =3D  8:  777b93a89a line-log: stop assigning string constan=
t to file parent buffer
 9:  b717af02f0 =3D  9:  527533540e line-log: always allocate the output pr=
efix
10:  b46dd3210d =3D 10:  4d0b8dcbaf entry: refactor how we remove items for=
 delayed checkouts
11:  030dbd0288 =3D 11:  0d36b6e5d7 ident: add casts for fallback name and =
GECOS
12:  5cd014c22c ! 12:  bfd632fea7 object-file: mark cached object buffers a=
s const
    @@ object-file.c: int pretend_object_file(void *buf, unsigned long len,=
 enum object
      {
      	struct cached_object *co;
     +	char *co_buf;
    -+
    -+	co_buf =3D xmalloc(len);
    -+	memcpy(co_buf, buf, len);
     =20
      	hash_object_file(the_hash_algo, buf, len, type, oid);
      	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO=
_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
    --	    find_cached_object(oid))
    -+	    find_cached_object(oid)) {
    -+		free(co_buf);
    - 		return 0;
    -+	}
    - 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc=
);
    +@@ object-file.c: int pretend_object_file(void *buf, unsigned long len=
, enum object_type type,
      	co =3D &cached_objects[cached_object_nr++];
      	co->size =3D len;
      	co->type =3D type;
     -	co->buf =3D xmalloc(len);
     -	memcpy(co->buf, buf, len);
    ++	co_buf =3D xmalloc(len);
    ++	memcpy(co_buf, buf, len);
     +	co->buf =3D co_buf;
      	oidcpy(&co->oid, oid);
      	return 0;
13:  69d904ddce =3D 13:  4770470a84 object-file: make `buf` parameter of `i=
ndex_mem()` a constant
14:  ed8f07aa59 =3D 14:  02e79d030b pretty: add casts for decoration option=
 pointers
15:  5953ae1dac =3D 15:  57402de20a compat/win32: fix const-correctness wit=
h string constants
16:  c80f6eff8c =3D 16:  71c83468f1 http: do not assign string constant to =
non-const field
17:  3afd012a88 =3D 17:  f3e02df0ca parse-options: cast long name for OPTIO=
N_ALIAS
18:  527755b648 =3D 18:  a46708b898 send-pack: always allocate receive stat=
us
19:  4598592d2f =3D 19:  99c88897be remote-curl: avoid assigning string con=
stant to non-const variable
20:  38fcea2845 =3D 20:  03556233d6 revision: always store allocated string=
s in output encoding
21:  f990bbeb85 =3D 21:  2bb96449e2 mailmap: always store allocated strings=
 in mailmap blob
22:  fff2379832 =3D 22:  8059e013a1 imap-send: drop global `imap_server_con=
f` variable
23:  9ab84e459a =3D 23:  04c9cfd34d imap-send: fix leaking memory in `imap_=
server_conf`
24:  81c69da2e8 =3D 24:  b2b4a01a2e builtin/rebase: do not assign default b=
ackend to non-constant field
25:  6819bf6116 =3D 25:  09980d211b builtin/rebase: always store allocated =
string in `options.strategy`
26:  a1d2149429 =3D 26:  d5dc1453f2 builtin/merge: always store allocated s=
trings in `pull_twohead`
27:  c714b67199 =3D 27:  2c051d1fe6 config.mak.dev: enable `-Wwrite-strings=
` warning
--=20
2.45.2.436.gcd77e87115.dirty


--k34eGlmZDX0jAifQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqq0ACgkQVbJhu7ck
PpR/lw//T8txOsDkBUPZUCokmjqNwGjeittVB6iOinGz4kWx0Qo8El/FxTs3xL+x
/8b+275pJhFpBPheapkoWwRx6T+vQb+fj5HMOjPkAPppJftvNXjPzIQaE2zstb7P
bN/pXYX9pM8fnAFQj8sBt0uoXREuWbo8cQLHUliRaTEH2YO/R1hcZ7Y34XngpMjR
ak/zpS6EJzz4XcDmyn2oRm/8qBtHeitWvPHoQt1HG8mp8rJCqo81BQ01c3c5I1mS
E3s64VO0AiZJArSW7lf21pUsf/G398JPL2P22RG7tdx5JSOH6k7QUnX9AKTxThbY
XtVA5mnJfrti71svSw/NgWcVQe2oOLFrKqzyitmVz9OSkhOi7hk3n3oQKGboTIWU
GAFTVw6QdH9D57ZLsb24VZ9hXozIrJaU0TCu3gMyizM8s0FnCRDP2xUjeH29DjEz
94SKQ/hhXYfJ0/7X28oefk5/1Q9Jc+5zrGiiRFx9T0D5zKddrhTONHvh5X6R0/lK
dCQXwgAv9tc19SwbvjTuBz17vc3CZEURAtxCOm/Mxg5ASOVI8dFnOiq4O8UnBIlM
EKLXeaqbkBCcWwxgEMvEFa12snD8y8yicfnSZCNHR3zMsCyChUrobeTCsNvpb3jK
7p6I0YDxFpKdYbBNyydQplKBo5xoY2r6fGPURSp1lXcbwpKdUpQ=
=oW02
-----END PGP SIGNATURE-----

--k34eGlmZDX0jAifQ--
