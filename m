Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCA18800F
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102569; cv=none; b=Ug6FSAmZlVj2o6fbdfJhUc0SjX0hpN6UZvHmc3DFS/UBopl44SZJbZxZlOQMrwEioXFVIigqSVCPVK988nx2+quURc7vfA6kQRRDRKBpb4yGDqhQOGNky0ALYLyvHOLZYd+B7h8mW9WzqYeV4DhJ1ZHboABeQgUkRtiWsqWqJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102569; c=relaxed/simple;
	bh=xD9eN/spuTe11VT7QXfNzc4lWQw7RJ28zbj9cvczjaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWvZaYWCrON1mZgCSUMqtpcuMANVxM95YiFi+qcTVHCqLqPCglHM3fVf3R2Y+6q/BY1E7cPx/c/4Li8zI5RKltv71MwhU46wR1wwSF8rZ08EZ8NXqEKmYOEn26gNVMHjRNwRcUrc5Q9FOgrs3eSQNEqrpgPKR7FUnaWr1Abqx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jORXIaDh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WqbHXSdL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jORXIaDh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WqbHXSdL"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2C10A138FE27;
	Thu,  8 Aug 2024 03:36:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Aug 2024 03:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102564; x=1723188964; bh=lHHSFJrKQt
	I193Np657IeanxxPtYm+VPv/+5ErtfG+Y=; b=jORXIaDh67G0eJkfHtk6O6v/f1
	Y5m8eP0O+KnZA+UnWwjBMAaIB9kNm/aXXv2YJDYxMB3Fxl7r09T+grcl6yHWE4jE
	1NViisAeAW8xXmXoouGAYkYt1+twNu1UuiHnyGrvilfnVQZ7JQY12Kdfo/wx8EUq
	Zjeni21u14GMMaWnPSOkEatoX54v40hF1wDGXPj4kKIechZ9+mGKrE4VbE2chzxz
	4KFVBjtD/52RHhTYxlmWjk5m7Gi1Tm/TrtjQLdWNgTqvDuML4p+4mHK9sIDitpAz
	E6us7qFSUhiBq7E1KQOHBc9jIjoxKXdcXKGxhsaTBhYnnMTsqursNGGrsHwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102564; x=1723188964; bh=lHHSFJrKQtI193Np657IeanxxPtY
	m+VPv/+5ErtfG+Y=; b=WqbHXSdLX5FMmW8dfaqK5y2/5LgxMmMS8E3V/euO9cKZ
	Nju3vYZSCFXa73wmJxwGD9dRMshTbO467NzAZYLtG0Ljo5iCBA5g85UYrLh6JvqG
	z+6pOjfkF5EvqvqLmSROvSYUGWQJa1zfUoDHXY9sbX/TB0Evziqm4sKOKIAFkQ3K
	0zUa8vbxWJlkffCjCthF7r2LDDTCS1DEj1ywQ+VKpoxgBHnynZOUzjePmZCF7C2o
	Hrnk3hkuez3e7DqFTfC0ZrVhnO3StpT8bIV7xgGi7I93RiRcKeddkYPN7TSEmhP+
	Mf6wSOskKc5Xvp2lYKKovYDUiZNLGIhb/HaWVHJCKQ==
X-ME-Sender: <xms:ZHW0ZqXdawKt043O3gSr9yFE6c_Wdn6cAzPt2oGMV_cgUXajy0eiWg>
    <xme:ZHW0Zmm5IaMbAY3ItsntrDVzC1SdiruLN3rPuMpa4iX2C8ttKrNpNayOtTQq1y_lz
    tskK8TU-93SOtRUJA>
X-ME-Received: <xmr:ZHW0ZuafHLSCwZxkpx1GHx7gWqKWaty7aDL77WR24dSqmRQhk4v3qqbRyWDGxfzBETtzWy7v-PwZhc5sGQzXpBL245CL3ZshQO1cYBaBG_sT2yJL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhlrghnugesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:ZHW0ZhUlxIgFQ8SpZdKFuPOIzxPRxr7CyFcGZim64Mm8Yud7tnH-xQ>
    <xmx:ZHW0ZklsdBaBq3JLbsQ1VPGkC8NLvKiJos4x9H636CLPBPuMU84TUg>
    <xmx:ZHW0ZmdNDsuvM2a45_qTDr2180OO7F1EZIHZRcgXVJmSR4t7TCQIdA>
    <xmx:ZHW0ZmEQM25NbfuofZG4Ap8je_jAY-cke3wYiqtyEAL1BDO7qmCI-A>
    <xmx:ZHW0ZlDqt90-a4M--kHnxdx2lAlFtRxJZzRdskmg6UG0bWeQFwo0h0-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:36:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ea47cb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:56 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:36:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] object: fix leaking packfiles when closing object
 store
Message-ID: <d05737c75f0e027e2134ec5ace1899aff2bc97ab.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sNkvRM3ClpY15STL"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--sNkvRM3ClpY15STL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `raw_object_store_clear()`, we close and free several
resources associated with the object store. Part of that is to close and
free all the packfiles, which is handled by `close_object_store()`.

That function really only ends up closing the packfiles though, but it
doesn't free them. And in fact it can't, as that function is being
called via `run_command()` when `close_object_store =3D 1`, which is done
e.g. when we execute git-maintenance(1). At that point, other structures
may still have references on those packfiles, and thus we cannot free
them here. So while it is in fact intentional that we really only close
them, the result is a memory leak because `raw_object_store_clear()`
does not free them, either.

Fix the leak by freeing the packfiles in `raw_object_store_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object.c                               | 9 +++++++++
 t/t7424-submodule-mixed-ref-formats.sh | 1 +
 2 files changed, 10 insertions(+)

diff --git a/object.c b/object.c
index 0c0fcb76c0..d756c7f2ea 100644
--- a/object.c
+++ b/object.c
@@ -614,6 +614,15 @@ void raw_object_store_clear(struct raw_object_store *o)
=20
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
+
+	/*
+	 * `close_object_store()` only closes the packfiles, but doesn't free
+	 * them. We thus have to do this manually.
+	 */
+	for (struct packed_git *p =3D o->packed_git, *next; p; p =3D next) {
+		next =3D p->next;
+		free(p);
+	}
 	o->packed_git =3D NULL;
=20
 	hashmap_clear(&o->pack_map);
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
index 559713b607..b43ef2ba67 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'submodules handle mixed ref storage formats'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_ref_format () {
--=20
2.46.0.46.g406f326d27.dirty


--sNkvRM3ClpY15STL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dV8ACgkQVbJhu7ck
PpRgqBAAoOeEbIdI1LxiTfyFv7eoq0BqgR1RTvxOL6S/gBA9H8hJ1r9JdUUbbYx6
WTDNojzzYvnv7r9x7xXfvTYEiukAo16r/AKksoWqlQIL8eDKfpZh8tClBIqSaCUy
6O9AtDejs6rYvpWkyhKHNgLZy6uFKdaU2+9j37pXfaM/G2D08dw+285J3RJrgfcO
LIjpSFfKXcPgVinuI7c6fp7i5+SGcoc+/C8CMBvF08ik3nOwLKAL/Yu1tO+M0Wli
GPHjJW+s+Es/JRJc+5hcV+BgVIQqxgvBDwF9LB16Ki/IxGlbreWd81DLPNsOSfSu
duXRh7rfEtf0kk5gLM5VLhBokPk78LYOjEnQSqJAwKoemsOkiGUXQ07A9LIEqJzA
WNUU/Le71tJnEnSy8qgyeyW9/6DcOdDn143foEarIyiv6lc47tifRZsnQFoP9spa
tHqtGLaqRJObwGNTnnbyVRixI7i/5U0fMhB13TQ2XoUaTKi7u5T3MvPE6fKMpP3I
WbYNKIKKqpn5KAuPmmOufzuzhPFABJhOxO462346Wzz9einUoVXGSSKXhEDi1nQ0
aT8f+x2IwzKC2IjbTkU+N8Kp/wU3flMotSE/RjoLqx8vfuTfrstGD39PgzX/Ql1P
CpCzvAT7Mry9YiOmfRYDHXdcBDy/cNRIy05C7di7PA2UoDIpUTU=
=0QDY
-----END PGP SIGNATURE-----

--sNkvRM3ClpY15STL--
