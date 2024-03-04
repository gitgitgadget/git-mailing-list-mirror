Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56B46AD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550649; cv=none; b=RgUspT+Im6BDgRB1+IMtrqzoXiDOELoAFl9AesiwFs+3wFGeKPBO7sfjENZcaAmn16bdavZweqUhrGvNF14+m36kKmQr29DZNc1d7ECYjOVbatXM3mpokbneVp/B7rmC1lLCikUR5MUQ+vCWOElBP5/0wJ8ow8yrrqF1VsdvABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550649; c=relaxed/simple;
	bh=vBLWNnQ3zVq0pBl3VB7JQcgvvZxPYFkOVPq/SEEasQI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vm5hfx5fguMBzmUNhOg6q0SGULaSyuZS3RnyrxT2yiEg92MUWKS/UQR+as8y8mQJCersNC68/WjQxZaI42jx0BsUsIo12e0coDNhkrAvhp7SLytZ1iVK5kQMY2dTa1Y1Svwq1tQrasNCUw5gOUh1BdZmyvRfMxj4DznRCoIm3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VF0Nb7Tb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rcVt4qlW; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VF0Nb7Tb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rcVt4qlW"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id CBF0232004AE
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:10:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Mar 2024 06:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1709550646; x=1709637046; bh=hWblm13STG0vz13hLWs+yMpD37nbz8VN
	nsIyZ8mqScE=; b=VF0Nb7TbWXhL2WlpFWjhjJ/9ultiFRHUGC7zLC/Cl2u1PY/t
	UhbUZrhQ8evZt0eQyLukwoGtPsNw4TJ+bUIp+zo+lA0v65xEw0bX8vXoOxWmzcqn
	y6jj/9M07RpjhkzO3yQBP3LA59PRyBdTwBTDDD1G3/R5Aw0T0DL1VXA+cQZJoqym
	fBKQcpjQyCS74FPwWorDuzWOIOymUV1zDTVF7df/EpA0k9Ci2+RqSVxzXmgmR/x+
	7TE8Fx+V8Q98Dt37HfdievYWh0c0KSAxBr3xlMgmOKmcskGTfh9D1zoU0Xp0lZGA
	NTseEVjfLaGN76a/iov2S5kPUoZ0kxLlbQY2mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709550646; x=1709637046; bh=hWblm13STG0vz13hLWs+yMpD37nbz8VNnsI
	yZ8mqScE=; b=rcVt4qlWFPMV6mwwO9vi141UrCrbGf5WCxFx+rxCTAKr/f2ScqT
	nOqxx8RGj/bPVx2C31JojyYAOpU0gqOntPeyUE8dPgIgZ/QEiB8YeGs+nwLDGwBF
	SfavXvZySuTMvTxW+gv+DhusCpXyiCinUvjXtlA+vAu4TdBnrtcZ+S0m/d1XxEgT
	UkNWA00VsYNCD6gQXyttLT24Bj/++cy6oVJsDTydeQgIg8+X7K0vsB0iQfFq1Kvm
	L065naiELkltSJLh6rfcMNV0vWXqI472rabm+mKd9eFxLHR/FajQ3yoVIFc5CbgB
	Y6F5DPZ0YVSWjv2+rhDTpBpuu3CvTGuoSkw==
X-ME-Sender: <xms:NqzlZaKVx0ZMnYvfZbj8PaDz4tTFAre-7tDZgbLrsjIu5SQailT-lA>
    <xme:NqzlZSJeuCgVcWKXkL6H6J2SatmPNkYXDRJLFfbuzOM_v6DtOY4DUmC2-PR4pxkcg
    LaIIulG6jud6yHlaQ>
X-ME-Received: <xmr:NqzlZav4yjWTsA2qGSmVnWWnDS0FX2eJqbAGa9o1XLE2cMkgz8MOmR8O2mCsYHxCxHfvpgBOlezPP9uzrk6kdbKdPDUyVx8WrkcRjnIDBumPuYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NqzlZfbuXA9xmq6GUEjx7YGGotaAmjgGLcmR3iLNbi-keP55IPQjGQ>
    <xmx:NqzlZRaHTuRlUjVV5rUtmKy8Nd5jWSX_ZX0ohVpMrU6RSR1THxuJqg>
    <xmx:NqzlZbDk-99aza7vGFrJS8j6TRoJr_-Qmr3mvbAO8gwacVQ8C1rUkA>
    <xmx:NqzlZSBgoE0B4P7y7FbkrYokgCa_yQzRwnoMxlMm6JMprD-H3u8ejg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Mar 2024 06:10:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 789f7751 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Mar 2024 11:06:18 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:10:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/4] reftable/stack: register temporary files
Message-ID: <cover.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ETzFmgQDU7QpqIRV"
Content-Disposition: inline


--ETzFmgQDU7QpqIRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when writing to a reftable stack there are several kinds of temporary
files that we have to write. For one this is the new table, second the
new "tables.list.lock" file. We do not register all of these with the
tempfiles subsystem though, which can have the consequence that
interrupted writes may leave those files behind.

This patch series addresses those cases for three cases:

  - Newly written tables.

  - Newly compacted tables.

  - Pending "tables.list.lock" during compaction.

The end result should be more robust regarding interruption and leave
left cruft behind.

Patrick

Patrick Steinhardt (4):
  lockfile: report when rollback fails
  reftable/stack: register new tables as tempfiles
  reftable/stack: register lockfiles during compaction
  reftable/stack: register compacted tables as tempfiles

 lockfile.h        |   4 +-
 reftable/stack.c  | 329 ++++++++++++++++++++++------------------------
 reftable/system.h |   2 +
 tempfile.c        |  21 +--
 tempfile.h        |   2 +-
 5 files changed, 177 insertions(+), 181 deletions(-)

--=20
2.44.0


--ETzFmgQDU7QpqIRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlrDAACgkQVbJhu7ck
PpRuNg/+IRPaPphuAOGvoI47h6mrviviVhTKMUIKEXebPJF/J5vKNQUMNgnYtdnT
x8r8CCsuADDjQWThNAu7PM1f9c1ZWzyW7AIr5HX8m7X8uEmL+ruWZlCqFM1GLUu8
zrJRgj0yAifMT3peg5jeFSxppimMYYq+1bNpO8yJktTLVc9MG+uyHrJ9c9Z1RA8B
wh/N+f3b4dlL3T3oXrLMgNkjg/TcNF32ss17SQtUVSmvwE0bpap9KPOzRQ7yDEd0
w+hRLkrTqZVY7Zeb99kD3zHVLM2NSiAcvglnwQr2ajXQ5j+EYVPgfjkg51jixVxW
lB/BL1rVU2Luq5DirGoZRfpbSM+2cdzzO6ODLdrQjVQv0Xkm0SNaslotG7qT2tMd
Z0VConv2Y/HamErsSOE7ODqXsTOyjTLyhX/FIXFxa1hHdI+NnLCpwAE25wLsluwO
tUsMm3M+0/WWpciY+aVLY7RedggyIHLhfBTZZbpQVha2+SS+8PJ2dE+iIZ9BlQ30
TvbG+UZJrZAUG2YvRFgjjRLmOigoyAxwCS3pdHUJcivmLRUeAy+cXpnELie8oulN
uYlzILLe1r01G/OZkF20rP4MrRqSHPQ7I/NLyL/78jx0cnq+JqMnOxJA/KPXJ5OV
1es5TEZ+0mKRIr879/HWPM4FAKfsCpopQWsWFnotlXKkpIKKSe0=
=JU34
-----END PGP SIGNATURE-----

--ETzFmgQDU7QpqIRV--
