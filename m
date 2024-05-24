Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0C2C694
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545668; cv=none; b=RPA2QAzV2UJylcQIeTjRleu6tp/w1dCo4msd1R8Om3RVFlgku8gxSGaV6yXIy9uJLaX6a7dMDwu5YxBD1AXXKGZQvCePWWUntVeYLPDnbg4UJlAxMxiSS0NdYO4qV0v43JszSd7Fw01bDO40pwZpmTIMnUuucIjRP/lKGd2BoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545668; c=relaxed/simple;
	bh=Q0lLG0g3rszM3vwXFjPqawSw14jj6jk05rbhzkY7ZlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVh6RL084DBOjP85huTpnsjYXMV7PJ2r1NTPxS58XX4VHINsb+pfXolZF6RhFQy00OyEUvHrGnOEqq+S5Ca3b/PNJL1VyGX4+m3lJgdJJRER7UQ19Qewth2bmU078C3MxHAWyfsd/TykOPB/LaGwm2n7qRtenvIQSZIqyt0h4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LJbYVoW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1o1KzSi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LJbYVoW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1o1KzSi"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 123A8138010A;
	Fri, 24 May 2024 06:14:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 24 May 2024 06:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545665; x=1716632065; bh=LAdqwUF6bI
	ajEZqPnjSxN7L9HcWnyDVhN/jxBrB83gw=; b=LJbYVoW82OXmVMyNjfDdPEd/gE
	xpivvyXgunERj0FvMClsxfx6Fh1jSP6rKCCjLhJT6xR4jxsiEhbHEEvHmHYqP0k7
	gOLP7ijB0SYqU3ehXfIYOo71cqY8TM04IuZ38zBdgXKjcz7/mU/RcAKvbdrLTYo9
	HHZAJMh2cj2x2HDZ2rQOA8YIb6P4ABUfKC/arMa28hrYu7yv+7kyVfhLllpVDvu0
	Q2ypr+2bPDp1YKBDhiMk1s3CAcLYloCn4ZYaVx03z0BKjRW8itYw7Mhs5YhDvHr2
	GHNpoDjg4hwaeL4lzoLhWo8mYE/q2dukEsjqrGGY6rWGyJrKDYA7oI2chgzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545665; x=1716632065; bh=LAdqwUF6bIajEZqPnjSxN7L9HcWn
	yDVhN/jxBrB83gw=; b=P1o1KzSixukA6VxjETFSN6lAD9FLQwvpwqtybjRaMAcL
	3AWkgJsNYgXqO7Z+Vn0XVM3yzWT9bWP0DxcEbu9JoNfsItZn+uCnfH3fnqd80w5t
	XgBU0DQ7OdQzTbBEmoYYxfPXKFXAsLO7ksTSa1oTn5ph2cS54uWxsLQSu9EGnAIf
	RrtDvMPPC7BbRGbX+MgWlmfuttV3DcmC4hq76ckclfsufbVVJUFRYYh3vAUG8efJ
	XwGGQn7qHMJnAPatvrWZj/W8S1BvJg0DUhPtMFwzFCcLstMvtCxv7to7jambsMKd
	mLz7wdGHuhxZ3T6oAp+RFmTo+SvJUgIExpsMihQhCQ==
X-ME-Sender: <xms:gGhQZouEtzUn_-5LIhwmC8cSafv5ymBW2kKTBeaio_QACR8eeZZYhA>
    <xme:gGhQZldtUsKeGB8pwbg72INPLAjKESkfTmyTtzPtnuAVsXsmKizD3_uBbvLdtSUyF
    bju0Bn2zxPKKoCWXQ>
X-ME-Received: <xmr:gGhQZjwQ6QD3ytC50q15fKNBQW_QBfFQgNg_jAiio00QyoKHxUq0qtOWcVUSXszoxEC7u1KG0gnw6jI68seetzU4FDCDDI2zquuaY02iUN57twE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gGhQZrM9BQx0KOWuJbHQMey5ibvWmamBxvEcldJplderIv9WdQJpbg>
    <xmx:gGhQZo_b8Spc0QsRQKmQhhhstWkWlNu9mKRnrxFKVHYJboLzgJp7rg>
    <xmx:gGhQZjWS934ePU2bjl8i9AhMy03YgFPS2fI_HctVcQ2YH-WjoG0hAQ>
    <xmx:gGhQZhdwPq5TOQLmFsT48Zs3T-9cyvnGBUJy22Lk7cNg_axysdltCQ>
    <xmx:gWhQZnYpChRqUszIRTcjmC7Q_9_VON9Us7o4SPrGu-ZlsljeO13Xhb6B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad597688 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:19 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] refs: ref storage format migrations
Message-ID: <cover.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vPNhrq4IFA7395tC"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--vPNhrq4IFA7395tC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series implements support for migrating between ref storage
formats in a repository via a new `git refs migrate` command. The scope
of this command is currently limited to repositories without worktrees
and reflogs. Furthermore, the user needs to make sure that there are no
concurrent writes.

Changes compared to v1:

  - Improve commit messages.

  - Mention that `--dry-run` mode will print the path to the migrated
    directory to stdout.

  - Mention that the repository should be deregistered from maintenance
    before running the migration.

Thanks!

Patrick

Patrick Steinhardt (9):
  setup: unset ref storage when reinitializing repository version
  refs: convert ref storage format to an enum
  refs: pass storage format to `ref_store_init()` explicitly
  refs: allow to skip creation of reflog entries
  refs/files: refactor `add_pseudoref_and_head_entries()`
  refs/files: extract function to iterate through root refs
  refs: implement removal of ref storages
  refs: implement logic to migrate between ref storage formats
  builtin/refs: new command to migrate ref storage formats

 .gitignore                 |   1 +
 Documentation/git-refs.txt |  62 +++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/clone.c            |   2 +-
 builtin/init-db.c          |   2 +-
 builtin/refs.c             |  75 +++++++++
 git.c                      |   1 +
 refs.c                     | 319 +++++++++++++++++++++++++++++++++++--
 refs.h                     |  41 ++++-
 refs/files-backend.c       | 121 ++++++++++++--
 refs/packed-backend.c      |  15 ++
 refs/refs-internal.h       |   7 +
 refs/reftable-backend.c    |  37 ++++-
 repository.c               |   3 +-
 repository.h               |  10 +-
 setup.c                    |  10 +-
 setup.h                    |   9 +-
 t/helper/test-ref-store.c  |   1 +
 t/t1460-refs-migrate.sh    | 243 ++++++++++++++++++++++++++++
 20 files changed, 916 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/git-refs.txt
 create mode 100644 builtin/refs.c
 create mode 100755 t/t1460-refs-migrate.sh

Range-diff against v1:
 1:  8b11127daf =3D  1:  8b11127daf setup: unset ref storage when reinitial=
izing repository version
 2:  25f740f395 =3D  2:  25f740f395 refs: convert ref storage format to an =
enum
 3:  6e7b9764f6 =3D  3:  6e7b9764f6 refs: pass storage format to `ref_store=
_init()` explicitly
 4:  03f4ac6ee7 =3D  4:  03f4ac6ee7 refs: allow to skip creation of reflog =
entries
 5:  71f31fe66c =3D  5:  71f31fe66c refs/files: refactor `add_pseudoref_and=
_head_entries()`
 6:  6b696690ca =3D  6:  6b696690ca refs/files: extract function to iterate=
 through root refs
 7:  b758c419c6 =3D  7:  b758c419c6 refs: implement removal of ref storages
 8:  4e0edda6d3 !  8:  4d3eb5ea89 refs: implement logic to migrate between =
ref storage formats
    @@ Commit message
         whole repository. Add the logic to do so.
    =20
         The implementation is generic and works with arbitrary ref storage
    -    formats because we only use. It does have a few limitations though:
    +    formats so that a backend does not need to implement any migration
    +    logic. It does have a few limitations though:
    =20
           - We do not migrate repositories with worktrees, because worktre=
es
             have separate ref storages. It makes the overall affair more c=
omplex
    @@ Commit message
    =20
         In other words, this version is a minimum viable product for migra=
ting a
         repository's ref storage format. It works alright for bare repos, =
which
    -    typically have neither worktrees nor reflogs. But it will not work=
 for
    -    many other repositories without some preparations. These limitatio=
ns are
    -    not set into stone though, and ideally we will eventually address =
them
    -    over time.
    +    often have neither worktrees nor reflogs. But it will not work for=
 many
    +    other repositories without some preparations. These limitations ar=
e not
    +    set into stone though, and ideally we will eventually address them=
 over
    +    time.
    =20
         The logic is not yet used by anything, and thus there are no tests=
 for
         it. Those will be added in the next commit.
 9:  2ebcc0db65 !  9:  0df17a51b4 builtin/refs: new command to migrate ref =
storage formats
    @@ Documentation/git-refs.txt (new)
     +--dry-run::
     +	Perform the migration, but do not modify the repository. The migrated
     +	refs will be written into a separate directory that can be inspected
    -+	separately. This can be used to double check that the migration works
    -+	as expected before doing performing the actual migration.
    ++	separately. The name of the directory will be reported on stdout. Th=
is
    ++	can be used to double check that the migration works as expected doi=
ng
    ++	performing the actual migration.
     +
     +KNOWN LIMITATIONS
     +-----------------
    @@ Documentation/git-refs.txt (new)
     +
     +* There is no way to block concurrent writes to the repository during=
 an
     +  ongoing migration. Concurrent writes can lead to an inconsistent mi=
grated
    -+  state. Users are expected to block writes on a higher level.
    ++  state. Users are expected to block writes on a higher level. If your
    ++  repository is registered for scheduled maintenance, it is recommend=
ed to
    ++  unregister it first with git-maintenance(1).
     +
     +These limitations may eventually be lifted.
     +
--=20
2.45.1.216.g4365c6fcf9.dirty


--vPNhrq4IFA7395tC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaHsACgkQVbJhu7ck
PpRD5BAApHAj8vMZ5SSedY7h/C4K/87jO8kEkkw8y7Qqqbu4WpbtAl1KuGiKMTUj
bx7BktNZmNV6FbfPLFudTX1VNjBEf6GkEFBwFyES0mCfUzamTHsn+YxDvA5+InQw
pptwMIR3ZFF3daw32DadZHJQ7Sd2pZc/nqnua5VZJk7fyhD3NeIEIGSMHWWml5Ti
ELwkON0fDdIfpD07ZLQreZiDsnjOdSJXTYgaKRZuP81tjmX1+2hgUtPOO9k++oHu
qwZoph6HMVwcIMSz8fkwHa9+8N/KSuhKoGKmuSv/3+/XK0Bh+SzhPEhQQ6DBpFOR
YqGC1rLVxFfT2gdm2dnnffldjCvM//H+N6EjU7HA7JOvtw3YJdKcQMzWQKyDXsJw
UN0ToLU7/BPGBXyVyqerpW2YW64c5x2tk3xXbQTK8hZntfVe/J1HT/O4YiUcaur2
Q6oOagv568mCS3TQNA/TZN5e03hkGbmrh1Y8VU8OjlXJbgtkJm2pfogQa2g5IqyK
tPzEYze5kRG4jLDrS8JZlkN7AtlhkWeppCUDSI6LT0ceJLWOSYCTa75Xb9HzaM6O
ydFTiXVntlZBgsAmoE86kPmHZzKu++coKYU5H5dXpTfUBNQZ8n5aNnZsAJmb6jdu
7KuL12xx8w8rZFg7YMBiE3/JiTnbl9TlfsRycRJE9MCk4u11w40=
=e9sB
-----END PGP SIGNATURE-----

--vPNhrq4IFA7395tC--
