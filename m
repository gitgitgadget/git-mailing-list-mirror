Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C81CAA5
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632694; cv=none; b=MwvwHyoCuIvjan530JADFFx8es88OMQCuZ1GCTrZmA9GUv00HG3TiVt6Rr+17tqKrdpuDmYWOIXS6St/I261f3TszSabzksO3itS4mQ8lzPAOvSbc0N+t354KvfUjvpl66rYA1TxiivsFdQaTUQCeK7+JXBztgAB/m798aZDGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632694; c=relaxed/simple;
	bh=eRsXI7POe3YDJLkLEcuwC4KqOEa7ya0am3sQDZ5jfcs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L63p5J+jNLm2cqr2xfVG+2IMsQoAv0AF5gIw4sGt5D4jHx+A7petIAqDi1IL0+b0aIUncaO5YrjHlQbsah4REtadwiPRWA+tWNxPY/u+SibTbpLbl2RcRWAEHPcgD5J1AxQzJ0edgRoV7t1usq/1gv5dIi4Ja/URS/OeVcQP/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W8xIKtGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOlZv0fp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W8xIKtGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOlZv0fp"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id F3F9C13803AC
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:51:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 02:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1714632691; x=1714719091; bh=0+NhPIM7cRurHU3mgdEnMhvdRzrsqwEO
	cSnrfYNnu3w=; b=W8xIKtGezojzr2/TT6h9WS3oig3AfsEvRBihGzG4FpMzr8S+
	S17Guz6F80EwxsfDSoxqqxhQgxrLlUeaUlOde4zOIl5AUdseWlrNHZsqfIRZgU4k
	MNVywGQR+P/7N8uTSskIkclq1/pZ27zZtRoQ4gCj15IxxK3xfbuhQzTynq2vIANR
	MCN7RrvQ/406vMLCpC2cAdEJazfkOtFDpX2ip21LtKQk0BCVwYRYhlipDosavMR9
	eFQtxxmmwz5KowMUE3wJJqgUvDc2u6Bdl83IngkUxCsVHENnhpNSIdhaFYIdbi2n
	R4AHoF0gAX5rTpWeRkZrjNYG7h44KmwanankIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1714632691; x=1714719091; bh=0+NhPIM7cRurHU3mgdEnMhvdRzrsqwEOcSn
	rfYNnu3w=; b=SOlZv0fpe6zLEcvbT7ISInx7WisZ48DrKcWshyV1JSe7e+SgtiQ
	Lj1fwP6Yvzp9g0I9svV4pWlW31qJd6QUPBK8KwWhVqeysYzXpAQ2q377Ay39VEl9
	QqYvizAbfbaQs82ae5Vissth2KwrFHgtPzxKTyEh2MLbnZaC1guNqL+zCcGw1CTK
	+Siq9aukGUgdnhFkIAjnvmTBWVA5U5Vu6dm6jwLfsOe/UnnkbLi+sONL5LwNe8Lx
	IY29K3lOZWxaMZXmERVVFTwQBr58cLYon6DD0BJvZEB1YsCpCuxVWYOqbG8kU4/t
	T4VZlzics7i0g+90DItawwDY+olzG9KWjEg==
X-ME-Sender: <xms:8zczZsZX7xrw22isIhMbrZVqMTb7DP9mGAr7shACU1ndot2jL45cNQ>
    <xme:8zczZnZfQmdpiDE0i5SDSlV-I6dnkcYxuJCiQd2R9MkQbjkdolmE8jQYlyo3efRj-
    xe_ZdGMsEVklm-ymw>
X-ME-Received: <xmr:8zczZm8BL-UFcAcmYGBBUrAGBGcshaGf3JIODWamW_qpsLlK1FQCczN0O5gMuLwrli8w5MLZydzj9CMnoL7OiEvuP48fAhVrDkQOAZ0PzHlu74U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgf
    dvvdefudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:8zczZmrChKnIwfUpv4kYKoJzwJ-0o_K8JjRMX0Di3RHydeT8m0ZRCA>
    <xmx:8zczZnrHLdZGZKsocR5maqXF_sokS41Hv2t3OUuVkDjBneKuzXllCg>
    <xmx:8zczZkQnFIR-_O1ka0ynbobHSBnNr6AYt0-1AssadZAX3N5Z_bJjbg>
    <xmx:8zczZnphKfV8HhbZCdd8mioHoUdgZhBzXZ_oVn23-0Jd8QqbFJvOaA>
    <xmx:8zczZgDxhVkSyPGFi8twMJvTqAAHaqbTa9QRrCTQa9jCqKMOP5jo6UAA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:51:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4ccabf0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:04 +0000 (UTC)
Date: Thu, 2 May 2024 08:51:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/11] reftable: expose write options as config
Message-ID: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mc7ZNruhXXkCjrek"
Content-Disposition: inline


--mc7ZNruhXXkCjrek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the reftable format has some flexibility with regards to how exactly it
writes the respective tables:

  - The block size allows you to control how large each block is
    supposed to be. The bigger the block, the more records you can fit
    into it.

  - Restart intervals control how often a restart point is written that
    breaks prefix compression. The lower the interval, the less disk
    space savings you get.

  - Object indices can be enabled or disabled. These are optional and
    Git doesn't use them right now, so disabling them may be a sensible
    thing to do if you want to save some disk space.

  - The geometric factor controls when we compact tables during auto
    compaction.

This patch series exposes all of these via a new set of configs so that
they can be tweaked by the user as-needed. It's not expected that those
are really of much importance for the "normal" user -- the defaults
should be good enough. But for edge cases (huge repos with millions of
refs) and for hosting providers these knobs can be helpful.

This patch series applies on top of d4cc1ec35f (Start the 2.46 cycle,
2024-04-30).

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
 refs/reftable-backend.c           |  46 ++++-
 reftable/block.h                  |   2 +-
 reftable/dump.c                   |  12 +-
 reftable/merged_test.c            |   6 +-
 reftable/reader.c                 |  63 +++++++
 reftable/readwrite_test.c         |  26 +--
 reftable/refname_test.c           |   2 +-
 reftable/reftable-reader.h        |   2 +
 reftable/reftable-stack.h         |   2 +-
 reftable/reftable-writer.h        |  10 +-
 reftable/stack.c                  |  56 +++---
 reftable/stack.h                  |   5 +-
 reftable/stack_test.c             | 118 ++++++------
 reftable/writer.c                 |  20 +--
 t/t0613-reftable-write-options.sh | 286 ++++++++++++++++++++++++++++++
 17 files changed, 577 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/config/reftable.txt
 create mode 100755 t/t0613-reftable-write-options.sh


base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
--=20
2.45.0


--mc7ZNruhXXkCjrek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzN+8ACgkQVbJhu7ck
PpQ8pA/9GGXHhevcsdUeTdalLFEiKR9rRHvYrXJmsCdEzi4IG4IxIc3E63QNrTNR
VZ+Bbf+6lWOz97EFJi/FWQRk2S1LhWzk49U+L4EiSkcEr7XM/rk8fIMxAoFtG346
GmRnBtLzOclEqw3+wItVkTlizMIX1QX92F/ocrLpIWSf/iIwRAPMWPReOlbe3DeW
6C+aMi/EslzZAHIZIvxtmBVKdRoRBrpDgEUzTA8HaDxlcp4Pp15CZD1kRLdQaKcs
Hs3Cq2Hh9fOwYSfemLYPcFslE1FcPYMIvVYecotvBrzFod4Zl6ZZFMQ7+O7C40Vb
zzX16FHkYaGIq7asC+fGo/BW7UT3/TnVJlgYkt4vAXeQ60G4eo/HVUrJIEjukKVK
ycqut7ZKJo1jCJJ3AjtQFZI3oO7Wm9fE6hvkhwQcxpli7NmjU56jou3JvljXOvjy
hinjPQhaHW01ypyRW+zaI0n7eMXZiALw8LkJldnPcUoShVHsmE8llcqgA32NuYjE
xWkPrUxBDw53/R2X220OW23D48mAuS6EucHSkAM7OBsK93+XyYLWZGu00gpG5VjQ
4k2sobxnlXuwgDrYBg3canQmyoCoo6K9bJrnL5N51mbd62Lk4TkAhXqaWzwNeiQ3
Pvaq+ufVhW7WZ0KGhkBPtUasOUQSHL4MFpQzpyF60C4FzlSnEaE=
=T4D0
-----END PGP SIGNATURE-----

--mc7ZNruhXXkCjrek--
