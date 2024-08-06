Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACB1BD50E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934855; cv=none; b=WxQxUs6eRoan+3FCwOdxgkib2FOoqS+cLP5qwUQgZKNgqBKOp2qkdXdHt+WJpvXGo15TEwZK2YkmbCp5cj50wruszYM+I4wUXAoWQChgRpiZHpk2rv9vdzQQFAYObtL+WfsLfxI51h8VKFn+EBis8Nmy+bo8t8DUvzD3kDAcSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934855; c=relaxed/simple;
	bh=gKLwYZSkELKU+tnijwxsdRSOfKdj7UQTzsM/uLATG7M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMISUxIEcwrJkYI3DiIXjedmdPE/g+I4y4DfGGKVEjrOt1JOEjZxyTi5oCfcznQwRcC6NmkhrTJKUXGWHo0knrmM2hZH/s88S79M0x8kAJ1NlNJafif37ToUrc55iCEmoHQhIsPY5FQS3FyWHOj7NGge/gvtHWsLqpNmskT1L7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nd+VmA9f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U4waNSEI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nd+VmA9f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U4waNSEI"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id E6E77138FCB9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 05:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934852; x=1723021252; bh=EtPZGOlke/
	IbqPMbOKin9UQ7Xy0Beew9/4awibZAz1E=; b=nd+VmA9fo9jdxP4jPQ4nN+j4Tf
	Zs3aliZ9G1leLk6v8XYBgcw0GwyfX4N7nr1KYIPC90vSARwo3nDJkjRFJ2Qnz3a8
	U8nZPbpgNZNgclqv+XYRtEPSomAMs8AJ7DeklFqGgAOcXHGyd5+unSw3ZKccjy1w
	TAX+gpCynHj/pS0BJ7ku9MiaCNKdOwTKFknHITUZascjEf4oh1vQJiC/6O6SFghg
	Qt91TinUd61ceIJq40TsqF70Wa6WVv1+q8nCAXw7Hvbf/uBt8HhFGXGJcAgfsCH6
	HvWMy/41cQbW10vsZ9azpoq4Zf0mUbS8eXo02egypGOAXQfZehEunPBZCy6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934852; x=1723021252; bh=EtPZGOlke/IbqPMbOKin9UQ7Xy0B
	eew9/4awibZAz1E=; b=U4waNSEIM4+Bxta6E+NWD2zzYhGiZ3Glt811yenhpF72
	onKeazAmAUR2KQuZhD28yu8nrt3LRtyilRtSGOWsNpPlkmmYJnVy1lnfwyS25nff
	SSeQT0RV7DNoudKJW7a58BNgAq9gOVEaSw2ldiZL3ruCbF6BVFKJaztxo2DbGnZd
	5sU6SaG246iqneYg5J4U0IKvv6MldTHorlfIF6a0Vom+EAZajc4osVtk3zShGIZR
	6vCBQSvM1lQ1+D7D3pNTqvW1zGleCf/J2NsgwfECPvvuAJdcr1WZubG9ZfN2GfEd
	dHwCovflIhCIG8lor888vVdAXVyWFu03wkVBzoZf3w==
X-ME-Sender: <xms:ROaxZpoFPgFX1qrEwtXKzelDFxrpPyH61P911D2abaP7XfaFVkpN7w>
    <xme:ROaxZrraXj4YGnOH8ofhMyx-2e3NQTJGxfosRtJTztsiLwm4ojPQ-5nm8prPp-a8t
    rCVPJ3U1KI1eK1Vdw>
X-ME-Received: <xmr:ROaxZmOVvq1F-YFGaJHIPvqQZpb9QiUtFf3QOqK9uwiDlB46c1iUkGxbg_koYVp_Lcy9ISBxLelt5d7C0egfKsGgIyGTejZaiUAhiIQ9gxYR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ROaxZk75gwptxzK-d-LmHFuUl3K_-zj1Tcv2Kit5PK6uyAHBCy7yAA>
    <xmx:ROaxZo7-WMAo4ueU8MFmIR2WG0bSFFK_Ik4ua2ztFAzOYSqxqFDGHA>
    <xmx:ROaxZsiSZipwmfuf_LjhvNUPdLZnCLd_nmsEOZRwgXoBJfWNXA7Oow>
    <xmx:ROaxZq7AiWhlav8Z7Eu-gj0C5BIGmSMmPvxVLTNbq3AH4UsMtA_FFA>
    <xmx:ROaxZmSgd-ip-012cjFwVELF3oGwZXXVi8I0xlZMsdpUcC-LMiTerMTm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd1dcc40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:49 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/22] unpack-trees: clear index when not propagating it
Message-ID: <1f8553fd4343c10a9d2ed2f9bb54937c1cc407c0.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4l/Uf1BAi+6FxTA3"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--4l/Uf1BAi+6FxTA3
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
2.46.0.dirty


--4l/Uf1BAi+6FxTA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5kAACgkQVbJhu7ck
PpTmgg//ezj23uNuG9vhDaUwRAVZnTn/qU45tMX53NbZTxdG8MNYzP32Fo4YwNgG
HBGJi2kFGI3dPunFfyFMN7yhGXIiupVY/1aWWrZNDJUDO9GPZZKNq4jjN0XVS3pQ
/FXnhNvOReCVVhdf0OqYO+OFPr1191EhbdRynohtfQdrYDEyffxcuXgWVUqLNTmo
yB/53VFAiQ/ZhaebXmZp1oL9e6V6gsOW3TglavIukUs/0OpTSLF3u0Ol3a0nzMIY
iTfpwgDTNDD3EzcEiHpXTjPhoqG3tCi9v/WqijmL6B2KrMjKRCfyL7yYrYTIqmvy
Gpku4jVqf0YDP/t0dVjIRPIC1HEaDEcJjAcNyWlRGIxRqXvZV/J1QGZs8OjB91hQ
iKTWGxzCx2AoIPLIg70NPzVBsoB6ClkG/fdM/oalquyfjVrW7rP6cXQgATtzvGl1
3pHnC/pHDKoSJ36C4BT5IVkSRay/2kLg/9POY0WNTuSVoLApgL+xTD/HgN7JHoP0
HfTXPu2CJoIQt28rGE7ieSuSvbQYC0kvwcb3LA96aJGsY7cig2DfJynET1GoPomw
ay7BMl6zenOizwoCda1Q60KjeW9mnGIObTHuS6BI7l8RH9C8kUWPpefaXE9YTG9H
D47XWygjIzTuG2Y7wVj1GGDUmmV7kg6C53dBAbpH3nwJYa8YXLk=
=4UU5
-----END PGP SIGNATURE-----

--4l/Uf1BAi+6FxTA3--
