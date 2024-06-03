Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8185948
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407014; cv=none; b=cEWAWs5C2JdOE4g4ihDqisDVAkNFVpTYZcxVd8R3rp/ebzSCV+rbkjlNmaImzl0OzTW0CuCN5UW+3cZxoV1IrJ8P4Qia7YanNt0Nv8GG9LN0L0LKjmcASe2ZpAwc8wguFeimnmFiCn3d9YIOg8c3gxWB3hiKMO3l8CdkUXSJ+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407014; c=relaxed/simple;
	bh=HJDAsUsXspOprXqywmeYgQvLf+VMPLTU338LAJNd81A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnZ7HwVTpphgYk3zX4gXDSYJRUn1LXlqDTp0EIak048TSPw2VOgmsJ0OJmjomuxwiyhNVR10WK1YtlTeBr77B+rZVzG3U4FmMqrVhAuKJk9sD2+HwwEenEYOkCX3ROveopvUDi5vNE2Ct3RQeuSO1oVnFREdPNYKWAmHnvbWQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l0ezMD2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xgo3Y3+A; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l0ezMD2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xgo3Y3+A"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1E13E1800101;
	Mon,  3 Jun 2024 05:30:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407010; x=1717493410; bh=nRayQMP5fK
	bawe8Mtbtz+59UPgeVBMgdisOXiiTTF00=; b=l0ezMD2oLpYNptwnDuq9pnnVgt
	BaJgwGarn5rBgFG0pHiiRJ+N+ji5tNpxHRHrARrY3R3bl27fi9K49C6CkYq9Sw1t
	NufFpDHHflPevxPZlTWTCjuk/AG2P9WbYPWP8rnFut3uHwztspFlsKmYWrA4hoTB
	D/ib+ySyp0wSP0z/FT83XFZkR+/H5Kt2b+0ZKXvD/l0ihT+tLnqGYc8duALFXsf/
	g8cvkbDGUQXghefWM4o3njQY5DfafHTdK1IfA7A5RFhHtcsd+jqkE6g8XfMJuVX9
	YqQoDgi+RoDcOP8nfCvoMk0zmM5dkud1kC2pvO7+x9MKojVnW1eAEcYnQStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407010; x=1717493410; bh=nRayQMP5fKbawe8Mtbtz+59UPgeV
	BMgdisOXiiTTF00=; b=Xgo3Y3+A2GxzWjUjd2kBx8/iyK1vKeoO0jXBWFiFZp8X
	x8XINtTwheX1ayIoLccUVT4N4ULc/Yj3WyUIa50iv+nB0MMNvTvjNFfp2fNsZ26e
	d3jlLg6YwDIi//Hmp14H39rOa4maNvpZM9QScDonfxs5/iuphJCFCiy6oUSluyL5
	ICZSM1CDppclCzXcL/CkuWdCeF+u2k3UcgoG2K8hLwxruve0ADuvXlop+tzkBGCC
	qUg68CeWqISOsKBXLp9iPcWeX2is4pwLgDRd/1ZqjRsrCTWF/hA6nIg/8WlfYvkU
	H/bC0rcbT75OPKQRQPx0mj/9KV0HCuVwO21vV4zH7A==
X-ME-Sender: <xms:Io1dZt7S3nR2RWzfZQ5uJbTMNBcI3XOq1HuBNlngPUCnxCsq_z0OTg>
    <xme:Io1dZq5Y8SReNn48AhFa5luyXayqyFP28bkdQlYhtO-C2c9qTSUTYweU8IMg-6bCx
    wNmrsIOVNWSnBtFrA>
X-ME-Received: <xmr:Io1dZkduNyx0u3IlAcV7fgenbu8cO1uveEXKgWapGK1ZdM55usg_FZ6Rimhz5M_Hrh9b1Ym22A8mdCtX8tWb1V1s_RH0UPpTYLRKcv-c8svUStL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Io1dZmIqBSHPMaJaH-eJU-b9k5NhSGLAUYf26THYo_NFy-u_n64nHw>
    <xmx:Io1dZhLc4v13TTQdfIMMTATFS_4lphA2NYd1wU1w4vRtqHf5opctAg>
    <xmx:Io1dZvx7zug2o4MT4bNUxWEXShW7QqE_O7bKWuhYCHpjnwQQVAIRxg>
    <xmx:Io1dZtLDPOpu8XdhEd4zak_6KWkLHZpITnFw0j1Xo4kWoaht2C3Miw>
    <xmx:Io1dZvgtdDOoEZk-el9d6bo7cts98rjWFoA6FhmcgxVabuj5veUWVMeH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 440e938e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:29:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 00/12] refs: ref storage migrations
Message-ID: <cover.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yMQNY/jkmMWAtQFH"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--yMQNY/jkmMWAtQFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that implements the logic
to migrate between ref storage formats.

Changes compared to v3:

  - Add missing entry in "command-list.txt".

  - Adapt manpage so that relevant data can be extracted from it.

Thanks!

Patrick

Patrick Steinhardt (12):
  setup: unset ref storage when reinitializing repository version
  refs: convert ref storage format to an enum
  refs: pass storage format to `ref_store_init()` explicitly
  refs: allow to skip creation of reflog entries
  refs/files: refactor `add_pseudoref_and_head_entries()`
  refs/files: extract function to iterate through root refs
  refs/files: fix NULL pointer deref when releasing ref store
  reftable: inline `merged_table_release()`
  worktree: don't store main worktree twice
  refs: implement removal of ref storages
  refs: implement logic to migrate between ref storage formats
  builtin/refs: new command to migrate ref storage formats

 .gitignore                 |   1 +
 Documentation/git-refs.txt |  61 +++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/clone.c            |   2 +-
 builtin/init-db.c          |   2 +-
 builtin/refs.c             |  75 ++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 refs.c                     | 340 +++++++++++++++++++++++++++++++++++--
 refs.h                     |  41 ++++-
 refs/files-backend.c       | 123 ++++++++++++--
 refs/packed-backend.c      |  15 ++
 refs/ref-cache.c           |   2 +
 refs/refs-internal.h       |   7 +
 refs/reftable-backend.c    |  55 +++++-
 reftable/merged.c          |  12 +-
 reftable/merged.h          |   2 -
 reftable/stack.c           |   8 +-
 repository.c               |   3 +-
 repository.h               |  10 +-
 setup.c                    |  10 +-
 setup.h                    |   9 +-
 t/helper/test-ref-store.c  |   1 +
 t/t1460-refs-migrate.sh    | 243 ++++++++++++++++++++++++++
 worktree.c                 |  29 ++--
 26 files changed, 974 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/git-refs.txt
 create mode 100644 builtin/refs.c
 create mode 100755 t/t1460-refs-migrate.sh

Range-diff against v3:
 1:  afb705f6a0 =3D  1:  afb705f6a0 setup: unset ref storage when reinitial=
izing repository version
 2:  7989e82dcd =3D  2:  7989e82dcd refs: convert ref storage format to an =
enum
 3:  7d1a86292c =3D  3:  7d1a86292c refs: pass storage format to `ref_store=
_init()` explicitly
 4:  d0539b7456 =3D  4:  d0539b7456 refs: allow to skip creation of reflog =
entries
 5:  7f9ce5af2e =3D  5:  7f9ce5af2e refs/files: refactor `add_pseudoref_and=
_head_entries()`
 6:  f7577a0ab3 =3D  6:  f7577a0ab3 refs/files: extract function to iterate=
 through root refs
 7:  56baa798fb =3D  7:  56baa798fb refs/files: fix NULL pointer deref when=
 releasing ref store
 8:  c7e8ab40b5 =3D  8:  c7e8ab40b5 reftable: inline `merged_table_release(=
)`
 9:  7a89aae515 =3D  9:  7a89aae515 worktree: don't store main worktree twi=
ce
10:  f9d9420cf9 =3D 10:  f9d9420cf9 refs: implement removal of ref storages
11:  1f26051eff =3D 11:  1f26051eff refs: implement logic to migrate betwee=
n ref storage formats
12:  d832414d1f ! 12:  83cb3f8c96 builtin/refs: new command to migrate ref =
storage formats
    @@ Documentation/git-refs.txt (new)
     +
     +NAME
     +----
    -+
     +git-refs - Low-level access to refs
     +
    ++
     +SYNOPSIS
     +--------
    -+
     +[verse]
     +'git refs migrate' --ref-format=3D<format> [--dry-run]
     +
    @@ builtin/refs.c (new)
     +	return fn(argc, argv, prefix);
     +}
    =20
    + ## command-list.txt ##
    +@@ command-list.txt: git-read-tree                           plumbingm=
anipulators
    + git-rebase                              mainporcelain           histo=
ry
    + git-receive-pack                        synchelpers
    + git-reflog                              ancillarymanipulators        =
   complete
    ++git-refs                                ancillarymanipulators        =
   complete
    + git-remote                              ancillarymanipulators        =
   complete
    + git-repack                              ancillarymanipulators        =
   complete
    + git-replace                             ancillarymanipulators        =
   complete
    +
      ## git.c ##
     @@ git.c: static struct cmd_struct commands[] =3D {
      	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
--=20
2.45.1.410.g58bac47f8e.dirty


--yMQNY/jkmMWAtQFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjR0ACgkQVbJhu7ck
PpRdFQ/+KZ/WTaOXueON1bDS130Pmv+uhR8h7FCf0YaAV4TKdWDesASYO7ZmM6ZA
vxxeHDhrnzK9ehyQ++tIMXG7pjGcoEv0aqApeoItcps7okWvBCMkd8sk8HgiVrir
rOvUT8vBDXCVO/yrYIJ/0ZZBhPbxQ78t4zH0igydPW13PdtEpACk/RtdpOPCJxX1
wlGHVZkS8dPGq5HEt3ETO8Igekx4JhQn/NR2n1HstW9oyanWYDDMsVJTumdmVnLc
yCxRbtPMSS7qBDnCMzq5BDHapvPI/uslL2G07GXPPwTwkPzx8sxDP0hLuHEWZeOj
OrC37l6DEu2F8UXOqfaFH655ERoPtiTkGCC7TA9wuKnYzaQ/Z4BvUZopdOZmbfL/
b3jfrbyi5JVgd6Op9L9F8DfAyXwzTs/y2cygCe8AtLlq74+CLr6fQxzjGHNFp3qq
xZ5UaJAJxyHLR9wDLbE4aRnf7YcXOE8IDcBpyz/XWpnawYjKYJZSp+PMQhhTi7jr
VRkwY8j8HTJFmvEqa3m96f8HUJXXI2O+XSjWT/TrmMUXjHqbmJ+nkI40b0IlpDr5
yKrjknddxK/5msIvxkBTwmmAOp6x1NlsoZELOVz4vhyPFbanxXfq5gs5VckZfv8q
rdb0IDlaJxvbO9X1cSqiiyrNXkm5nbjV5u0tPHpm5MtH4L7FMdM=
=7Fao
-----END PGP SIGNATURE-----

--yMQNY/jkmMWAtQFH--
