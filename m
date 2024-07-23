Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19949153800
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743541; cv=none; b=mU/yH5UGSp6KmwOL8FxbgQBNIpaa023XIDqqf0IbaxVarR+k6zAw5MqaZ3G2spqK3rjshmwIvLQbVrje2I5AFAwtuvJMq36LmhfRq1HNTVvYaB7lgb2kKRvaZ5MbtRKfDUK9eRpVeGUQnxyDVTTjU1ljoBdOpTvCCbYSmjgbWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743541; c=relaxed/simple;
	bh=IoR51Pu0Rw4UPSbpXeZdEh5Yatzck2YWkLoGQweREQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ixtwpne0LPopFIhkmPmPhD6ccVy4/78BWrFizXiVOe28GcEttwAO4n1W6FCeTcUM1Y9XDUYl70+Cg4oW5x6LdWC5IKTZKwao1AvBZtTJxMTeR6MECHTtVjiHPei+WH+42ArITyiZjyyCRwUvQgAFkF1fGRnkCRanmbSKUbtIhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iEim2Doj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvn7G3j3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iEim2Doj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvn7G3j3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 39CFE1380533
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Jul 2024 10:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1721743538; x=1721829938; bh=Sl7oGHG2QzLJK/yKLip1uerYHKJalqRy
	yLe6pR8O0b8=; b=iEim2DojKtkrAMzrdq5Hm3oYnY3rLRtO16XCATGHtrrQLxuY
	tYzhwEiJOX12AZvVAFYoU8Scbu/a10T0mn/QFJ/Xv4eqFBnU0g4LODHnt1i6ptH8
	YWucwFsbCEVJpU78x9ZqP5oTN09VVLn8XEYTXDUEztK4EBW9OEaKlA/DyekoSdCZ
	nHOd8O9qOTVQJ71ZLVzgKEqD4HFPt+GDS8VlJrztNJseNpuzUWJHS9ytInlUuFRW
	7rmtoeSm+NsvoD2/cOwaF9rO1mIssxS7jv6fQLHFYhAFJwqQsVQ3VrG97b0nk+Ne
	Zqtqqg8TPWtgDIOqe9XGIHJQqdRMR6CJm9aqUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1721743538; x=1721829938; bh=Sl7oGHG2QzLJK/yKLip1uerYHKJalqRyyLe
	6pR8O0b8=; b=mvn7G3j3SLPQxXk1HbwSEtMGxWMHXm9yTeKp5kw3n2C3m0WuAhO
	PoI6q5CcRgNuMm4TUZQrhkDjqXKMXtqDerYZdOe+vw0fxI5iTtMlqY4Qw2RuFr8R
	hQO97Mf3o4nbYEoFeEFaykh5Y2Z3GYag8axXc+ZQF8FY4fspEy8yxYda7vA0yXk5
	Pt4T+mAQKlvNKVpzdk9eskmDo/GlLAI9+ygxZrk0Jv/JdIoDrdqAL4FL9GAqwavo
	eYoBF7wcz6hIDg9uaMdjSGwr/DEa9FBG94CocBa+gpEFx3vE6m1yKYUYVUuIxbxo
	5PSBMT6JSnqfgBttxYoCGxiHMNDji1QHhTw==
X-ME-Sender: <xms:srifZg04aOvncE8EL9l3VGBSqsmgZ2kokbCL5Bro7-_7TERL8MO4BA>
    <xme:srifZrGnrRfaD-K7FZJmKDC832vPzXOUMwf1J77nEgk0_yj4-exR4G-w6CNzVyVO8
    uT890sz496AfDnZRQ>
X-ME-Received: <xmr:srifZo7EJSaQ8iZP86h2YvzLe1wd9-SX41B77N7467d_gpunEVE7Q5lE2tD3svay5-bassITEDG5WLhaf5H9BQoMRIBULD16TvPo3xY0QPyuPu9R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:srifZp2wd8hKdYalSA8SugMPIYv08eurKeuIbUDSugSvTAYwZgK9vA>
    <xmx:srifZjEFoxb6irBrgvhuB0w4DGTZk8ONJsZqgaqnqMzzaj-HfJb_pQ>
    <xmx:srifZi_YJeKQtwdUBqbNGF3S5b8ubfeSdnrS2aP7XB5tbCGXAc2OMw>
    <xmx:srifZonXSMpEGA0wx2JFmRZN130n8-unOLSHjMIDL7_DQFQRQblcvA>
    <xmx:srifZpNSJ1PPipPnKDp-ZGzQnl5Nv3nq-7Ad-fd3rLIMQ12SFYaA_NY6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 870dec30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 23 Jul 2024 14:04:21 +0000 (UTC)
Date: Tue, 23 Jul 2024 16:05:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/3] Improvements for Perforce tests
Message-ID: <cover.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wGRxu801V8zG/qpd"
Content-Disposition: inline


--wGRxu801V8zG/qpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I was recently trying to figure out whether the Perforce tests are
memory-leak free, but noticed that the tests don't run at all on my
machine because I have a newer version of Perforce than our CI. And
because the on-disk depot format has changed since r21, tests are
broken.

This small series adapts tests to work with both r21 and r23, updates
the version of Perforce used in CI and then ultimately marks all of the
Perforce tests as memory-leak free.

Thanks!

Patrick

Patrick Steinhardt (3):
  t98xx: fix Perforce tests with p4d r23 and newer
  ci: update Perforce version to r23.2
  t98xx: mark Perforce tests as memory-leak free

 ci/install-dependencies.sh                  |  2 +-
 t/t9800-git-p4-basic.sh                     | 14 ++++++++++++--
 t/t9801-git-p4-branch.sh                    |  1 +
 t/t9802-git-p4-filetype.sh                  | 16 +++++++++++++---
 t/t9803-git-p4-shell-metachars.sh           |  1 +
 t/t9804-git-p4-label.sh                     |  1 +
 t/t9805-git-p4-skip-submit-edit.sh          |  1 +
 t/t9806-git-p4-options.sh                   |  1 +
 t/t9808-git-p4-chdir.sh                     |  1 +
 t/t9809-git-p4-client-view.sh               |  1 +
 t/t9810-git-p4-rcs.sh                       |  1 +
 t/t9811-git-p4-label-import.sh              |  1 +
 t/t9812-git-p4-wildcards.sh                 |  1 +
 t/t9813-git-p4-preserve-users.sh            |  1 +
 t/t9814-git-p4-rename.sh                    |  1 +
 t/t9815-git-p4-submit-fail.sh               |  1 +
 t/t9816-git-p4-locked.sh                    |  1 +
 t/t9817-git-p4-exclude.sh                   |  1 +
 t/t9818-git-p4-block.sh                     |  1 +
 t/t9819-git-p4-case-folding.sh              |  1 +
 t/t9820-git-p4-editor-handling.sh           |  1 +
 t/t9821-git-p4-path-variations.sh           |  1 +
 t/t9822-git-p4-path-encoding.sh             |  1 +
 t/t9823-git-p4-mock-lfs.sh                  |  1 +
 t/t9825-git-p4-handle-utf16-without-bom.sh  | 19 ++++++++++++++++---
 t/t9826-git-p4-keep-empty-commits.sh        |  1 +
 t/t9827-git-p4-change-filetype.sh           |  1 +
 t/t9828-git-p4-map-user.sh                  |  1 +
 t/t9829-git-p4-jobs.sh                      |  1 +
 t/t9830-git-p4-symlink-dir.sh               |  1 +
 t/t9831-git-p4-triggers.sh                  |  1 +
 t/t9832-unshelve.sh                         |  1 +
 t/t9833-errors.sh                           |  1 +
 t/t9834-git-p4-file-dir-bug.sh              |  1 +
 t/t9835-git-p4-metadata-encoding-python2.sh |  1 +
 t/t9836-git-p4-metadata-encoding-python3.sh |  1 +
 36 files changed, 74 insertions(+), 9 deletions(-)

--=20
2.46.0.rc1.dirty


--wGRxu801V8zG/qpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafuKwACgkQVbJhu7ck
PpSIJQ//ZPARkVK15Qx5PqNgPKi3jQqShGxmqnWUHZYvGRQqcT2VL8o2kvm0amlg
0ZyPLchF5EwimycEditKC0oj9nT4Nc7Cd9wa19RSWGL4++mDxKjRRCZhtMxQ1w/t
w2g/bMP5evEuNdJl3lKkavHCuTaY3zDWqgg9P3Ldv/XJvO8+TJh71bL0MSw0ACBO
mBVMyC8wMkWDRDiPngITQyAfJzniWqAcziHEYVNX010GOcMQ+1Bn587RkLKq6e71
XOytrLygAnqzLjEaO6Jggf+uTfS6N7SrtZpvlbILbvBccZ1SWD/DZJ4oNwRJLGZ7
tNL9NjLB+nzVBytAvu3iy7AGAiRUrPfubfMECSMBJm458jgbuZe86sAFZa/V879U
ej252XuA8ANMSwtEXI9zHzaUIGyNQ9lDwee2U4IELJaSJ8aEQ1Ml3qYuWzVoWcyD
pibKJtBNY6m2aUulPBzz9yCuuXXVnCANkc6rljejdj2GdngESmdp6pRNXIXxP5op
LDGFZocdXUbp3hIosrDaq5MvvF76h5vak1NDhZ1gt90PY2P2bKVJepa+mifgiRHC
6hasJRR8dGhmH1kVaVMLUv56t8u5CF1bpjIMHuhMQUZ84UjDt7s/eSAFNQJ/w/uG
WLokMDAF24/FnS2tYKir3KVKGmTPek6hOWIuygGxrU0UiZJ6W3w=
=bbNB
-----END PGP SIGNATURE-----

--wGRxu801V8zG/qpd--
