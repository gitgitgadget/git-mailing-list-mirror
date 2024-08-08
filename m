Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6218CC0C
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122350; cv=none; b=qHCIUKxYPOGFy9bb9xPuIUk8POSV4GTFI9xxafHCdMxZBXEEkBTLBlyb9/m6F4+QCYUsm5Lfvp9NvMKhuclPyQvgRJ3ko6WtYfiUfIAZkw6AzLP6mDmhtTHIIcK2kghI29FRlZEOeGwycFLbMEwsfuEhcdRz+ZkYkED7CM+p2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122350; c=relaxed/simple;
	bh=AGewfgi60MmoZT02SLkTpw8s5FliFb7W/Oad5/iC6hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgVdskALJmlQiFvuPIAwH0jELTKiapY0lBbZtkEdsBV48ql6wEFbM5jrbPVicIqla4wKtAMHMhBtQqK6yFsXVrl5+NUpk8Dflq1yRaEsIACL+kYUFAaatr4lvYq+jBexfizAiC29H0QscpA7mAfrw8oCoh8r3RzA9ClSXVZIotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JUaz8wWW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cW7vr108; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JUaz8wWW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cW7vr108"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 38F1F138FC7C;
	Thu,  8 Aug 2024 09:05:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 09:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122348; x=1723208748; bh=vAvDZLuY5B
	O1FtNiA+PmUiAn64uI7BlvdmRdVCfVJEs=; b=JUaz8wWWu+PxDhE50XYSi2I2d2
	H624TCwoTkEonVy9bwickVX0/HgEaWfT2TNnj5zodAYNcgYGIj0EoYiQLq6grx3k
	2xT5uxtNgxuK5E31dT9GL6pNUpLlfnxdxsLATaekAUxrH5kdAOzinFPw7rBbr0rH
	j7rPDIK1Vl7d2Mpt5BBFAy+1UWJMIP5U7pqjzL/bRARm79SpD6gzbC9oIBW3amTQ
	xnp+aTZ2ig6CtKghGeux/zSRTOL+lI9u8fMl87mrer2NQcZFN/6UcZFOWogSZIDs
	7r7DPNr+KShCF/7DpjuSez+4pNqz2XY6S23+dP2RfhxWkTs3e6wQKySXeLrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122348; x=1723208748; bh=vAvDZLuY5BO1FtNiA+PmUiAn64uI
	7BlvdmRdVCfVJEs=; b=cW7vr108dXmHXRjgXOqB+eWsM571z9A+b4LuqdyK4fl/
	t7Xz7x1Fh6iw0LbL8uFMuzQ/UzWUrqVeq9cGmPeM9lGZWGy2cxt3gHLzsaSozwSw
	rzRbV51FFKljgLkdLie9W8krEd/rueprmPopS0tFc7yY+2x4Zl+K/Rgx28hTNfBo
	EUuEvIRcFTeCFdL22z/CGp6xwR5ZXi51QWxaMyULvvV2AsWxmKyqb1IE4nYa0cvw
	aBZSis2jLR7vDDKGXpjk6a7urFfIBZM01U/QzKmpmI4i3PPB+2rYQj/SGdJgs3R8
	X6R61cOR+zyoWv5NcWztgwpJkpwPAOPercqRWA8bLQ==
X-ME-Sender: <xms:rMK0ZkDObmFghUPAntuBRquZjZN6HJ3KcU2eIu-9wnw1tzWGu7gekA>
    <xme:rMK0ZmhtcfS5O1rqjg5Tm-MJMaDwN6TZRe2SPr2YnVC8RUbWUnFrIj9kdOhHB3JZW
    Og9j2jInOacv86G2g>
X-ME-Received: <xmr:rMK0Znld1_8cGvynWBWrndaS_QBAO9Ru6fRs3L-sF8TxwgypHlWfmoDJYVD6BrnEANfkmRf97UZbO3X1l1ILXY30xsExjYggBlMhV0Y4NAp8flaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rMK0ZqzuHMsk3F7FERBgub50Q9KkdL9FFsm46HIH0mljED4BAU99oA>
    <xmx:rMK0ZpTrk-TQRO4u1yXwP8Va-rztoJPb2Bi5x72rMoIS1HERXimFsA>
    <xmx:rMK0Zlbi-D3z1F4Atf9VQCGDciFxIUQEdojtFEOSdmfw3ab8nUCZ3g>
    <xmx:rMK0ZiQ0N6xUdwjqFK0MsSnKB4DnGXb3Pr-od2sU6MHWkwUcoOjKOA>
    <xmx:rMK0Zrf8vpfWbWbMhoUnVxHD3xvf16F-Tf8VmNmCX5dZ-4UJn0D8xTOv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 234510b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:40 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 16/22] unpack-trees: clear index when not propagating it
Message-ID: <2755023742e33da6e420638ea1bc90cd31150407.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r6oC3OrNK8gmMTl5"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--r6oC3OrNK8gmMTl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When provided a pointer to a destination index, then `unpack_trees()`
will end up copying its `o->internal.result` index into the provided
pointer. In those cases it is thus not necessary to free the index, as
we have transferred ownership of it.

There are cases though where we do not end up transferring ownership of
the memory, but `clear_unpack_trees_porcelain()` will never discard the
index in that case and thus cause a memory leak. And right now it cannot
do so in the first place because we have no indicator of whether we did
or didn't transfer ownership of the index.

Adapt the code to zero out the index in case we transfer its ownership.
Like this, we can now unconditionally discard the index when being asked
to clear the `unpack_trees_options`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3705-add-sparse-checkout.sh | 1 +
 unpack-trees.c                 | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2bade9e804..6ae45a788d 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git add in sparse checked out working trees'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 SPARSE_ENTRY_BLOB=3D""
diff --git a/unpack-trees.c b/unpack-trees.c
index 7dc884fafd..9a55cb6204 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -210,6 +210,7 @@ void clear_unpack_trees_porcelain(struct unpack_trees_o=
ptions *opts)
 {
 	strvec_clear(&opts->internal.msgs_to_free);
 	memset(opts->internal.msgs, 0, sizeof(opts->internal.msgs));
+	discard_index(&opts->internal.result);
 }
=20
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry=
 *ce,
@@ -2082,6 +2083,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, s=
truct unpack_trees_options
 		o->internal.result.updated_workdir =3D 1;
 		discard_index(o->dst_index);
 		*o->dst_index =3D o->internal.result;
+		memset(&o->internal.result, 0, sizeof(o->internal.result));
 	} else {
 		discard_index(&o->internal.result);
 	}
--=20
2.46.0.46.g406f326d27.dirty


--r6oC3OrNK8gmMTl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wqgACgkQVbJhu7ck
PpTFqxAArAdIm2sPT4pQ9yPCh9zUywv90Yvu5wRlk1z0FjdLVnxBgr2hrdwP9So+
B+WqzlE5iKd3v9nDsVdyzIje3h+FlVDY4KbSUiKU5AxKbOaRLp90JKUbvU3Lh5BD
sxtPReOnMpHkHaqWul1X/Qm7XwVKuELwl4nBiSlMRSTgKqfDupdR1Wbb9B+P3Qa8
nqlaaTeThv0WRIb7o/v0ToS+OvmxZJr8S+DWPgpS6v1DSRILVGqT1D9lPNe2g+JB
9JhjsOxihdtLlviDsf89d3Zem8QJPqghw4MTca7oAI17N0cVY5HqXnWHDrAZv+8d
01WXc3qaRhcPE0gzOKiT+p0KHl6QnyyMm6BouiK3Gzlk1Po3Sn0IdzajaCVdCeYh
h/iCEZTueAZ/uU2hx1jG1zyrVK5ngGLX1Xl32As97dUdg2lq9MZeZ/gIGQfkMGPW
X+BAaireyEIFoxqXprOIzb3AENBRl/h2qAFc9jZmjzs1nwHNMggm3ufy+cnqVxFP
KSpNDAV67iZN9SxgktI6w81Re+scIfwtJ2M3fOTov4aMu1mnwhAtROZxpQWitOhV
qBQonPpW0LJ45tvpBFVzUgBW+NKIP63/RmB0lhsjJpKxGGwnzW5nUiwGe38pC1Xu
YuyBnfau+OMnh1LIbpkdu+ZV1AMm3sfutmtLHBhxt+Lv3BwxSYk=
=gnhs
-----END PGP SIGNATURE-----

--r6oC3OrNK8gmMTl5--
