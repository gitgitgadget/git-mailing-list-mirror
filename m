Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B260145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504617; cv=none; b=EB4rfJxtowH4I+HMnNm6JMdP5qCsAdarRVfEXHObUV/8ClmisO9DlkE9Q3qK/eRQq0XsOG9H1keOWLTz27IYl2YYCXRczbfKj9UedILaYXU3mj9sbWM/BxrWzwDLpyUE0z+xmCwVfy9fX0yaOO6hz1B1zIZvQfi2UV/ACT8bMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504617; c=relaxed/simple;
	bh=xMj7O7GIhxTKmUgSduztaApochuuJntz3ndkquso5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK0ObfHAL5EshHwKe//ztrFxsU+8gjXguAz8pp9jDm9oluC6uBgzu4TtblpEvPPoN/RbLpFpZuHhs33MgT3VVD6YHaPbSTXrjHSM1Ff8BL6vy3GmrfMv+DgOLlhZlUPvn4690a4VJnBxkL9ye5NhzJepRhllFYldP6KQo4b+Y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jOPhm2Fy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFoxvvlE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jOPhm2Fy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFoxvvlE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id A69391380157;
	Tue,  4 Jun 2024 08:36:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 08:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504614; x=1717591014; bh=26PFkAs14H
	R8FbRuUbUpOftc51YwWNodHWqn1E8rTnY=; b=jOPhm2FynU9xv7jBfeTQiobaEY
	Y4KnNF4mhmrIQY7iZBZq6nELT1PkYFpSPW56EqkZbCSny/lUsURH1A5agNzNRdjQ
	uKJuBb/Z0iMD2xCtzR2G9BmJlfnPT6ogcgP9qzxkSAraGWSMmoQsWk7nf6YERh8A
	jX4argAHFl0UAoU0zhDgKTcQI8I7urSW2mHvuiN+nv+phyT7yzNuilA8qqubXKHE
	ABknT4dWlKMQlOcbXUOxmBX2ekqFLAGl6tf6qtltvzXyX2O3R7yspD8Ay1TOkRxS
	17Z3hK1p86VnfWa81xzw6hiBF24ilSRVKVPVyWAXHQ/02CGWnsdIDjthh1hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504614; x=1717591014; bh=26PFkAs14HR8FbRuUbUpOftc51Yw
	WNodHWqn1E8rTnY=; b=XFoxvvlEZYFkvSBb9qbIBNZ9pTfZ1fJym6HhbRgwUqkl
	awIMHykTW8uAsPFHY4AR5YdKKlBSdHptVuzl9oV3IEHbY12DxMZ9V6fryZi4Wf2R
	Rdi9BdIkZAI6gy7Ndjr3bHmQZEU7WF4YP8Fs4DLfa5b8mvQCD3THcSzjNiXnYku+
	akUvwejaZSF0XsxRriO7p4UeLE6ZAofjjGkHSWd7vf9CphDgAL1UDb8wXavw1HsS
	vYYiyuETWxMreAzRxNPRDoeZXJx6l5fvw0qJsil1ZNCassJRJy4YNF9/5cXdKaqJ
	7iWB758wJm+5iskmnt5rWThV+8pnsDUJjHB28FS9vw==
X-ME-Sender: <xms:ZgpfZjzxIpZJDiOmiLCcp78K_Coed_qCHHBQP5XdAI9aGNDvVwvSfg>
    <xme:ZgpfZrS64gRwUIas8aDPQv8hZnyU5EOMQJ3bJC8v-QOMHFrkrOFr_ADg7ZcyM5g0p
    3G4rXIoNBa7_IJrZw>
X-ME-Received: <xmr:ZgpfZtWOl_URRv4p6gmniIbfKXgHGU1Pjs4x7xBsCL0jo7RIsSSPWOaHSEWwKKNS-ty0vI6-PWj0b5vfP2RBzQ-GUcOI--5uRoZibjhs0ceNTk7X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdekfeegieeiudfgvdegfeffgfdtheegfeeiteffkeelteegffdvhfevjedujedt
    necuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ZgpfZtiaGmPAsS8IWHw0acCGnwDPk54rUIgfwtUdxEhrwjWQYe8kQg>
    <xmx:ZgpfZlDC1WSBlQAOgNwDg8FhoDqAWBGXVN9paAMTsISy7Q4JZlbQFw>
    <xmx:ZgpfZmI4Pv4qfGnHQWTvFdnn7ptLJdPs2arskP8UhHEVjxkUDrOsSQ>
    <xmx:ZgpfZkCfG5CS2SF0TyiUplVPfPk3aYkGu0hdYijLM-84CK2RZVxs8g>
    <xmx:ZgpfZg_WqdTKbRVlgBwDtbel2PZWy0RIkET8A0stxBiliLfqQL22rqWe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:36:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1ad3025f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:26 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:36:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 00/27] Compile with `-Wwrite-strings`
Message-ID: <cover.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ij068NsybJfffPyB"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--Ij068NsybJfffPyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another minor reroll of my patch series that prepares the code
base to compile with `-Wwrite-strings`.

There are only some small changes compared to v3:

  - Fix typos in some commit messages.

  - Fix accidental conversion of "." to "" in basename/dirname
    compatibility code. Also, remove the unused variable.

Thanks for your reviews!

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
 68 files changed, 468 insertions(+), 386 deletions(-)

Range-diff against v3:
 1:  e01fde88fe =3D  1:  e01fde88fe global: improve const correctness when =
assigning string constants
 2:  92cb0b28c6 =3D  2:  92cb0b28c6 global: convert intentionally-leaking c=
onfig strings to consts
 3:  085d90c8b6 !  3:  379145478c refs/reftable: stop micro-optimizing refn=
ame allocations on copy
    @@ Commit message
         refs/reftable: stop micro-optimizing refname allocations on copy
    =20
         When copying refs, we execute `write_copy_table()` to write the new
    -    table. As the names arge given to use via `arg->newname` and
    +    table. As the names are given to us via `arg->newname` and
         `arg->oldname`, respectively, we optimize away some allocations by
    -    assigning those fields to the reftable records we are about to wri=
te.
    -    This requires us to cast the input to `char *` pointers as they ar=
e in
    -    fact constant strings. Later on, we then unset the refname for all=
 of
    -    the records before calling `reftable_log_record_release()` on them.
    +    assigning those fields to the reftable records we are about to wri=
te
    +    directly, without duplicating them. This requires us to cast the i=
nput
    +    to `char *` pointers as they are in fact constant strings. Later o=
n, we
    +    then unset the refname for all of the records before calling
    +    `reftable_log_record_release()` on them.
    =20
         We also do this when assigning the "HEAD" constant, but here we do=
 not
         cast because its type is `char[]` by default. It's about to be tur=
ned
 4:  8692d9d9af =3D  4:  d0a2a2f6c5 reftable: cast away constness when assi=
gning constants to records
 5:  db4d062014 !  5:  ead27d3d97 refspec: remove global tag refspec struct=
ure
    @@ Commit message
         refspec: remove global tag refspec structure
    =20
         We have a global tag refspec structure that is used by both git-cl=
one(1)
    -    and git-fetch(1). Initialization fo the structure will break once =
we
    +    and git-fetch(1). Initialization of the structure will break once =
we
         enable `-Wwrite-strings`, even though the breakage is harmless. Wh=
ile we
         could just add casts, the structure isn't really required in the f=
irst
         place as we can simply initialize the structures at the respective
 6:  6a3c8d351e =3D  6:  7cb5df9182 builtin/remote: cast away constness in =
`get_head_names()`
 7:  750429472a =3D  7:  6e631a9ea4 diff: cast string constant in `fill_tex=
tconv()`
 8:  cc8fa1896d =3D  8:  ac164651a3 line-log: stop assigning string constan=
t to file parent buffer
 9:  03dbdd235b =3D  9:  b717af02f0 line-log: always allocate the output pr=
efix
10:  6fcb7d6685 =3D 10:  b46dd3210d entry: refactor how we remove items for=
 delayed checkouts
11:  81e20a7bb8 =3D 11:  030dbd0288 ident: add casts for fallback name and =
GECOS
12:  384b4c8967 =3D 12:  ecca8e973d object-file: mark cached object buffers=
 as const
13:  a1e8e77641 =3D 13:  62f0e47f94 object-file: make `buf` parameter of `i=
ndex_mem()` a constant
14:  4d95abe9cc =3D 14:  e057ead2b4 pretty: add casts for decoration option=
 pointers
15:  3d92528125 ! 15:  06b6120d26 compat/win32: fix const-correctness with =
string constants
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## compat/basename.c ##
    -@@
    - #include "../git-compat-util.h"
    - #include "../strbuf.h"
    -=20
    -+static char current_directory[] =3D ".";
    -+
    - /* Adapted from libiberty's basename.c.  */
    - char *gitbasename (char *path)
    - {
     @@ compat/basename.c: char *gitbasename (char *path)
      		skip_dos_drive_prefix(&path);
     =20
    @@ compat/basename.c: char *gitbasename (char *path)
     +		 * pointer to internal memory at times. The cast is a result of
     +		 * that.
     +		 */
    -+		return (char *) "";
    ++		return (char *) ".";
     =20
      	for (base =3D path; *path; path++) {
      		if (!is_dir_sep(*path))
    @@ compat/basename.c: char *gitdirname(char *path)
     +		 * pointer to internal memory at times. The cast is a result of
     +		 * that.
     +		 */
    -+		return (char *) "";
    ++		return (char *) ".";
     =20
      	if ((dos_drive_prefix =3D skip_dos_drive_prefix(&p)) && !*p)
      		goto dot;
16:  8a98078439 =3D 16:  a8ef39d73d http: do not assign string constant to =
non-const field
17:  26c4c76c86 =3D 17:  9d596a07c5 parse-options: cast long name for OPTIO=
N_ALIAS
18:  e3227bd3f3 =3D 18:  4019b532f9 send-pack: always allocate receive stat=
us
19:  af82e49682 =3D 19:  f2f1ada143 remote-curl: avoid assigning string con=
stant to non-const variable
20:  077f10d0dc =3D 20:  27660b908c revision: always store allocated string=
s in output encoding
21:  fb240598b4 =3D 21:  ef43c1b18f mailmap: always store allocated strings=
 in mailmap blob
22:  291030faa7 =3D 22:  0a69ce4b44 imap-send: drop global `imap_server_con=
f` variable
23:  9b376a313f =3D 23:  9ccafd286b imap-send: fix leaking memory in `imap_=
server_conf`
24:  0a84d66e68 =3D 24:  e19457d20c builtin/rebase: do not assign default b=
ackend to non-constant field
25:  5c8bee3695 =3D 25:  f548241960 builtin/rebase: always store allocated =
string in `options.strategy`
26:  84c0149c8f =3D 26:  78ac075644 builtin/merge: always store allocated s=
trings in `pull_twohead`
27:  3427547134 =3D 27:  0cd4ce07d8 config.mak.dev: enable `-Wwrite-strings=
` warning
--=20
2.45.1.410.g58bac47f8e.dirty


--Ij068NsybJfffPyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCmEACgkQVbJhu7ck
PpRVhQ//ZeJ6A3pDZtASzfDDqc2nL2BEVmZOvbENkVGicYQsKdI8syh+YPqaVFlS
Wm5TuZ5ewBahOdMXZ2axtIG4QELiIji9+8+O8TJPImL2k1edKhNCHY01p8f+t3uf
l2JPdzIImY7wTzQRdI3exIleHVck0NZ9IwS8ZprNe9PrUaRCEkADB84VDmkzEklJ
xGAEqWOa8YA8k/r8wl99b3Bj+jfmL+4n5/bv5lgGwigcxFDeRtUdugvgdMxnt7D1
Oh0wEA7UiIih3kjjk/VJ/NKYCDBWTciErhzx2ERGOd/MOCuOhubv5QcZkVKfmpdV
lYCXW0c7dtoClEEQDk2vhqt6vv6oHkNUooFgPsRPQgVmZi+bH/HPBlVoN2TsFPox
VZi6Vfy9JnL9I18u3/foji/cc99A/E5mIqpbu7L95aVEJpMtuzzhnf7/4XDXm/xI
Aq+vqy4bzNVybfQ/jjIIzR/a9/yXy9s/QHv5s+PT9cWvrvO4xwawCq88skc91sOm
AAK1nlR50NmmkdjRElk4bPF7u0gkLTlFK11tA/wli436kKsKR3Gzu2W/SJU2tlSZ
ZXg7vRIdC4ydX9V5I7ulbgDC126furstaMC/5jTy09Fqo0FPCbJkoqBvAd+NskjB
oUoZPjzP/mfd3lGpPdEsedSJOYzunjsEFVKu1aHUYKu+thgKd6I=
=BuyV
-----END PGP SIGNATURE-----

--Ij068NsybJfffPyB--
