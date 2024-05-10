Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275E130E39
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336964; cv=none; b=C77w5DBRpMpu4NIZoqIhIfaNISb5MUFPOP0aa7/TavopkEFiZqbCvcqpEy1SJNiSuVrg1M/kTPtQ7o82AxTTeqnSyZzAZ6Dwy02th79jc+LGp424pMrj4DZWtfiKnl8U5TCXSVUWz+UPoLMWO5RH9G3fI+IBvi1oNYHGB0/RPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336964; c=relaxed/simple;
	bh=Yx2YscV5IgRaiTte99WnzOz/HZX02ZYjR+1xNyo4EYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNSw0bIlHNFXPUG7MgZqMRNKbMpb7xRhyb5uqLW9evdoY1WBn2VRCp+w8/Hhpy9TiG3pXQBfnEkKrIw4Xdors4JVYuzzbThwiMYnxEBuxSNiFCWiEx5PM2RzicV/XLPRjT5L+QbDIHh7yVe2l33XVAGeBLFu2coOO+izOyl+R2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tVKraaO8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbi0VZMB; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tVKraaO8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbi0VZMB"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6726C1800080;
	Fri, 10 May 2024 06:29:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336961; x=1715423361; bh=2CAc3SycAV
	NrHFLhSgYqYrxR9KKDe9OULagz0I+O+HQ=; b=tVKraaO8H9YCu7qwfwT43tR8AS
	7xGu/UNcx4qto9+PyA11wBWg03xAyMx0iFKq9NflhO/5nhODID+cROJXDyAfjJcb
	8p8ArVyeR72VoPyVYFUrcRigu+MN1pxYWpRGfw8i8q/r/H9Gkvn73/RTwIfg1Jy7
	ww4VClDWm3yrjwAPLQaHM24FKv2Yy3u9H3Uf5bChJCzi8ONpfLeWiB80zuBmBKVt
	YAO/tV27zbzOSDl+xdQU5BSrJFkrq2CUt1CGbvmrs1byPH38PJCu0MxCkCTe1zRX
	J7TzHc4JOKJKjL4Xd/CxEkpTgedoZgn4Rymx6XJHk0EbqPNlxnkM+SMdc73g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336961; x=1715423361; bh=2CAc3SycAVNrHFLhSgYqYrxR9KKD
	e9OULagz0I+O+HQ=; b=bbi0VZMBxyeblFZtmChTfX8Sg53iQq9Cax66fPhwqiCk
	3FnQotVdnaMyHl2BeqIMHpkL9Mrpsgtlqq1HxgmgBtRTvROkbDdaTzNK7rHZFNju
	jm9wOcOIc/60xiy0KdR7bR817zTiZE3xBacyzu+5R7QbkmomEC9tdznznQLLLtbM
	RsnvLHZJgHbYqMuhK8GpNChged0UYJYSu9q5FMpS5PFJ5LDQT16thZYIENGJP3zD
	ZjqhDI59C8WgPInQoAAbW1rM4YA0I18fZqRx7ez27t2RFADnjvCw5xNcEQZfmJlj
	EDoS9UBC+VuDOIZ92gT9Za9CXHaJ1gcC+kQlJ9PkMw==
X-ME-Sender: <xms:APc9ZmEjPeUQKiK4spVDDSZJNguApcQ_jDvHXcaE-YFqE0zl8ANouQ>
    <xme:APc9ZnVSM4wjc5M0_8hCbt9QWjehBcDUvyhVGPXiVtZ7p5waAcAgzkMgzczGArt8a
    ifdobMvnM-534lJAg>
X-ME-Received: <xmr:APc9ZgKSKz8KMScGjvj2lNH2MK2mrmKVzbgRRXJs5exT7tcFna73E8azhGdUXevwj8N5rvCLtJU16KRC6TdIOPzK4T8QBskhCALvdj4AeJaOPcou3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:APc9ZgFjdqXk5qw73W719o_pF0E2wYAttfpV7zbpZcRR5kdSd7uvfA>
    <xmx:APc9ZsXRii-8nCDPSo_uBx2vcPrDv8Ez8XmqfoTd0jqKZNzJgC9x7w>
    <xmx:APc9ZjPrFK8VZapTruUk8jV2qMq-cxc6qHghHdAAqRw8klKCfQAw3A>
    <xmx:APc9Zj2I2dblu9TSpApKTK3OTL6-6vND3nV1je4MWYpYpXxhbuifEw>
    <xmx:Afc9ZjRkziArMvBFPwrO8yLxCO-AGTnFBK426TMUDVezVyUGf3JmfFNz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 54dcc9d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:05 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/11] reftable: expose write options as config
Message-ID: <cover.1715336797.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S86ak+urJoymJpz6"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--S86ak+urJoymJpz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that exposes various
options of the reftable writer via Git configuration.

Changes compared to v1:

  - Drop unneeded return statements.

  - Move default geometric factor into "constants.h".

  - Fix a typo in a commit message.

Thanks!

Patrick

Patrick Steinhardt (11):
  reftable: consistently refer to `reftable_write_options` as `opts`
  reftable: consistently pass write opts as value
  reftable/writer: drop static variable used to initialize strbuf
  reftable/writer: improve error when passed an invalid block size
  reftable/dump: support dumping a table's block structure
  refs/reftable: allow configuring block size
  reftable: use `uint16_t` to track restart interval
  refs/reftable: allow configuring restart interval
  refs/reftable: allow disabling writing the object index
  reftable: make the compaction factor configurable
  refs/reftable: allow configuring geometric factor

 Documentation/config.txt          |   2 +
 Documentation/config/reftable.txt |  49 +++++
 refs/reftable-backend.c           |  43 ++++-
 reftable/block.h                  |   2 +-
 reftable/constants.h              |   1 +
 reftable/dump.c                   |  12 +-
 reftable/merged_test.c            |   6 +-
 reftable/reader.c                 |  63 +++++++
 reftable/readwrite_test.c         |  26 +--
 reftable/refname_test.c           |   2 +-
 reftable/reftable-reader.h        |   2 +
 reftable/reftable-stack.h         |   2 +-
 reftable/reftable-writer.h        |  10 +-
 reftable/stack.c                  |  57 +++---
 reftable/stack.h                  |   5 +-
 reftable/stack_test.c             | 118 ++++++------
 reftable/writer.c                 |  20 +--
 t/t0613-reftable-write-options.sh | 286 ++++++++++++++++++++++++++++++
 18 files changed, 576 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/config/reftable.txt
 create mode 100755 t/t0613-reftable-write-options.sh

Range-diff against v1:
 1:  47cee6e25e =3D  1:  7efa566306 reftable: consistently refer to `reftab=
le_write_options` as `opts`
 2:  d8a0764e87 =3D  2:  e6f8fc09c2 reftable: consistently pass write opts =
as value
 3:  c040f81fba =3D  3:  aa2903e3e5 reftable/writer: drop static variable u=
sed to initialize strbuf
 4:  ef79bb1b7b =3D  4:  5e7cbb7b19 reftable/writer: improve error when pas=
sed an invalid block size
 5:  4d4407d4a4 =3D  5:  ed1c150d90 reftable/dump: support dumping a table'=
s block structure
 6:  b4e4db5735 !  6:  be5bdc6dc1 refs/reftable: allow configuring block si=
ze
    @@ refs/reftable-backend.c: static int read_ref_without_reload(struct r=
eftable_stac
     +		if (block_size > 16777215)
     +			die("reftable block size cannot exceed 16MB");
     +		opts->block_size =3D block_size;
    -+		return 0;
     +	}
     +
     +	return 0;
 7:  79d9e07ca9 =3D  7:  05e8d1df2d reftable: use `uint16_t` to track resta=
rt interval
 8:  653ec4dfa5 !  8:  bc0bf65553 refs/reftable: allow configuring restart =
interval
    @@ Documentation/config/reftable.txt: readers during access.
    =20
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_config(const char *=
var, const char *value,
    + 		if (block_size > 16777215)
      			die("reftable block size cannot exceed 16MB");
      		opts->block_size =3D block_size;
    - 		return 0;
     +	} else if (!strcmp(var, "reftable.restartinterval")) {
     +		unsigned long restart_interval =3D git_config_ulong(var, value, ctx=
->kvi);
     +		if (restart_interval > UINT16_MAX)
     +			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
     +		opts->restart_interval =3D restart_interval;
    -+		return 0;
      	}
     =20
      	return 0;
 9:  6f2c481acc !  9:  6bc240fd0c refs/reftable: allow disabling writing th=
e object index
    @@ Documentation/config/reftable.txt: A maximum of `65535` restart poin=
ts per block
    =20
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_config(const char *=
var, const char *value,
    + 		if (restart_interval > UINT16_MAX)
      			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
      		opts->restart_interval =3D restart_interval;
    - 		return 0;
     +	} else if (!strcmp(var, "reftable.indexobjects")) {
     +		opts->skip_index_objects =3D !git_config_bool(var, value);
    -+		return 0;
      	}
     =20
      	return 0;
10:  30e2e33479 ! 10:  9d4c1f0340 reftable: make the compaction factor conf=
igurable
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## reftable/constants.h ##
    +@@ reftable/constants.h: license that can be found in the LICENSE file=
 or at
    +=20
    + #define MAX_RESTARTS ((1 << 16) - 1)
    + #define DEFAULT_BLOCK_SIZE 4096
    ++#define DEFAULT_GEOMETRIC_FACTOR 2
    +=20
    + #endif
    +
      ## reftable/reftable-writer.h ##
     @@ reftable/reftable-writer.h: struct reftable_write_options {
     =20
    @@ reftable/reftable-writer.h: struct reftable_write_options {
      /* reftable_block_stats holds statistics for a single block type */
    =20
      ## reftable/stack.c ##
    +@@ reftable/stack.c: license that can be found in the LICENSE file or =
at
    +=20
    + #include "../write-or-die.h"
    + #include "system.h"
    ++#include "constants.h"
    + #include "merged.h"
    + #include "reader.h"
    + #include "refname.h"
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      	return s->end - s->start;
      }
    @@ reftable/stack.c: static int segment_size(struct segment *s)
      	size_t i;
     =20
     +	if (!factor)
    -+		factor =3D 2;
    ++		factor =3D DEFAULT_GEOMETRIC_FACTOR;
     +
      	/*
      	 * If there are no tables or only a single one then we don't have to
11:  861f2e72d9 ! 11:  e1282e53fb refs/reftable: allow configuring geometri=
c factor
    @@ Documentation/config/reftable.txt: reftable.indexObjects::
      The default value is `true`.
     +
     +reftable.geometricFactor::
    -+	Whenever the reftable backend appends a new table to the table it
    ++	Whenever the reftable backend appends a new table to the stack, it
     +	performs auto compaction to ensure that there is only a handful of
     +	tables. The backend does this by ensuring that tables form a geometr=
ic
     +	sequence regarding the respective sizes of each table.
    @@ Documentation/config/reftable.txt: reftable.indexObjects::
    =20
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_config(const char *=
var, const char *value,
    + 		opts->restart_interval =3D restart_interval;
      	} else if (!strcmp(var, "reftable.indexobjects")) {
      		opts->skip_index_objects =3D !git_config_bool(var, value);
    - 		return 0;
     +	} else if (!strcmp(var, "reftable.geometricfactor")) {
     +		unsigned long factor =3D git_config_ulong(var, value, ctx->kvi);
     +		if (factor > UINT8_MAX)

base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
--=20
2.45.0


--S86ak+urJoymJpz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99vsACgkQVbJhu7ck
PpRIaxAAllvqDzzL3BcWG46nU4ba1u+4xSj/JgL906ad/xzat/s1zefBvdEklp8X
8dC6bTIG++Xd3x6Z5j82Zl61gDjVbx3A7CVKvYCaodZbyeg9iGBC7qXsk8l74ar/
LIUcj2Kd3CYBqDqs4+aZ9mQTiqpwy+H2XBZpjiPP2Q6+ebbesk8oW8ySbfDB6RMa
16ghOUOOqNKaj7jOirJD/VQE7MCv2fn+x6VGvEoN70gTF2gnUCwXPgr8trmYtrMq
iiTtTlR7YHyHfgCHQfF4ZdCbIHq/YGt/uIIAGjDTuWyn/FqbBbSkQ0//XzZe7PXk
8hNIJxTQsqE2FPUxlwZ3pZEQqZv4KkNOfJ+TCCJ/EYYNu7POab1QSF7U4L5OOw6A
IGJfcvgVWT3oaIsPNffwaR2IIb9zXT8kh1fLQF1JNsXApxdG9EzJdDNlCTv7XywS
oDErJ2nwzSYCGqjbBCC+2qRJ/LH4T5uf9cmVws2fUEoc1zZz3Umczmlrs/dOfigW
aPO18dFUbBUmCGbk6On4VAEkDhGPUNy1qZhtoZ7PIeA8JkMPIkx0eepcrgqsLjFi
tByAemx2TzP/ZCGhAQbwvX3prbksvmFYupmi8p4ZJEtTmZJ0cFdGL6RbyL86pXel
ZQD5q9GRoXjBCBDMujCmFiQqXDwrFFdfyTpvLP7R57PRC4lpuaw=
=3UJV
-----END PGP SIGNATURE-----

--S86ak+urJoymJpz6--
