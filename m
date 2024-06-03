Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEB83A18
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407608; cv=none; b=YQuHHflFIJHdB5SiXEex8jL9FyVtJZlGu4iZpL3Yqog5E8AG+lPeQtjy3f1nZxyu8RSkt3JkrU1OUtzfSTUpZdP6bd+EfK55KAu6xE0fUHKvyROVXSNmqHjN+pK50Ox4BUYo27VwylmjtqhMNOUD0oW7BxMJqOGif91bU2fPp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407608; c=relaxed/simple;
	bh=rDolCkU/1RHVGKBe5J1LK4/pfPcX28tUeojKvRFqYts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPXDjU864hTjW8nCzg716KlZwGvYee+lFUAgTwY/P5rJH6LT2kkHfylwFjdjUSYWv1SZGRwpJp6UFTRKP3ciVd1IVCBt5QPy+YJgn5ot+IzCMsN/VCeMUZ76p0HyYqSdlLc65D/mekAr1A5oVGtUDVobAkVzdRzgov+bORxwflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EkUA/J6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EOgxQELX; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EkUA/J6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOgxQELX"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 13125180009D;
	Mon,  3 Jun 2024 05:40:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407605; x=1717494005; bh=mZ0c0GUxD/
	dnbUgUJ+kbmEi4QYl/MhYLClQO17fv1ZY=; b=EkUA/J6dO93EZSvfYA/l1CVtIl
	QsfysnV0BoamTThts0cAgZ3CxcsTutM55ux41Phtjoaqtm+DIPhAvpmPhmk9xLQT
	jlDpsiS0bWluP3RecY0vYzb6kgdm5g4nvnrILKttaaqA4oFwkIA4dertjPW3m5ae
	Kko3lmzoVuSJJGD4VslzU4T7Lq+IQ4X5GWgRN3OroJoUQ5BO8S5EkVxWcMhZEbmX
	Bm4owQ5/xb9DEGp1WU7ErUVLRwBiF++6j9n5mKiDv15Ymeh6YMEcURletkj6GnIF
	6+qOIqKEoMDay8JKT1n9Pl/iF9Lgcb7/kjNAmYb06MoFSsuebNsiMCj4thVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407605; x=1717494005; bh=mZ0c0GUxD/dnbUgUJ+kbmEi4QYl/
	MhYLClQO17fv1ZY=; b=EOgxQELXqUcKgjaksR+NEUx18aTUi2ZYjvwZJvLyKG+5
	XI1AZFkPSeAM6WIjOp8zEuRM4CS47MakxZRw5hjUXe2MvqM2tN/uqsszofsD98o2
	oATPln70rhn6Too/y8oqVRUoMaoq8S9knuoFqw6t77h9Weh6+RX+Jyq9igjtPs2k
	GgrQyjxvhQuB83OO4dDSGvnwUmMhZcZyMm39su6bGfSnYqgFnzaV4Sc+pmLiYpId
	9977UFaFqPBTw3I2vWPWbMJhusCT5up6uxJ1FxGfTIQQnwya2P5kMi0xYGbRzTjR
	k7bNxanIxHzFdkJp3xKnrcMfOV2JRlThDY3Smx1C1A==
X-ME-Sender: <xms:dY9dZg79IInB7BmvvtxHr65S8lOfsRwPnwrGsc_OWX6nAUzv0LRWDQ>
    <xme:dY9dZh5vRLucBcaUMT-Yy6puXsXKEtl-qgd81SCWPdj2Wb9q9FJiTDY8bFUvU27Xs
    tgUZxTG0XKrRUVQqg>
X-ME-Received: <xmr:dY9dZvebAKMhHyufMGyDOgN2X0KkQI5iNx1NGm0M0LsLcz-6_X3HiFI9p5oUMWiY2RTznogVGtiaIw53jD_jBtKb8dTc-viwvPAxcAKiROuLVLUZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dY9dZlK--TGi8mBJ33M_Sk03RHOGHsz6yhbS5eZPkzgoajSbSELWRg>
    <xmx:dY9dZkJ5L3QRVVO2xDuwGWET2bce5Pq2cUDTPQ4O5cmyCrCRmCEo9w>
    <xmx:dY9dZmyJ5qSSaVEyWzusm0PDezZBT8oYtoshjKb5GYg9TBgsO5ggeQ>
    <xmx:dY9dZoIczR8s_QS57QwKLagHfDNCX8B-CYBZp_6QVfDKMd5JkQe0Lg>
    <xmx:dY9dZo0wVkfW9W32haRYOTQ0HQrPCRAFfHcQUupgMfjxSnLCE94nVawF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9c79041e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:40 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/27] pretty: add casts for decoration option pointers
Message-ID: <4d95abe9ccd41f97733995c06ba41ebeef584ac9.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bBD0LvuJUmKKaks"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--6bBD0LvuJUmKKaks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct decoration_options` have a prefix and suffix field which are
both non-constant, but we assign a constant pointer to them. This is
safe to do because we pass them to `format_decorations()`, which never
modifies these pointers, and then immediately discard the structure. Add
explicit casts to avoid compilation warnings with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index ec05db5655..1df9d635fb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1584,8 +1584,8 @@ static size_t format_commit_one(struct strbuf *sb, /*=
 in UTF-8 */
 	case 'D':
 		{
 			const struct decoration_options opts =3D {
-				.prefix =3D "",
-				.suffix =3D ""
+				.prefix =3D (char *) "",
+				.suffix =3D (char *) "",
 			};
=20
 			format_decorations(sb, commit, c->auto_color, &opts);
--=20
2.45.1.410.g58bac47f8e.dirty


--6bBD0LvuJUmKKaks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj3EACgkQVbJhu7ck
PpQcIQ//QE6Rd3kpUaOOo8+fjr4/x5yp2KcgUYbyk1scvje72/YqbeJOUROJHE9b
qbyq4aNEvEMaRsF8Agd4Capreio/vTRmLt/lmPapCNd9OpnePbaDjZyVHPPkEdIE
MTOh3mYEZgozeVeeJIGc8HIzgx61CKmUbbh6eKBTph0PozuthwFyPEqSlmXd/pG9
KFzEHgksspaQrigKBjFB34tALpGSAN7h42CkJgDvcPnwQ8xrr+FzixxayPudxyUI
LsKy39/VTcmL3iprW/0X4l5ENlIKKrjR1Fo6Bv+Ik+yMw7R7O8tHohQPESpHPT8Y
Y3O0/WihN+n5jWej/rt/4FYOyaXuDaEIFBzbGi48trhz70OYKWQ/Nfo99EBkpmmI
VOjM/g/IQDggRCQfnb2KjW5hkO0+/WVyYq3O8i2g1xckdpLzADSB601iyc/0mf4L
ryczH37A9XB6vJzoT0Odp2VNqzCJ07k0NP6NvCX0MDUzVsBwqEMEfusNFpNnozNI
xIU/3G0mOs95OVPQJtxFjF/foV63k4xBN8K5IFxJHhHIqQ08WFpmn6mYDNYjuw7S
OAsEXEqSxoLFsMGsOYB0yKJrC2Ta8cQJ7qG8u1HQomXs3Mw+V75SsLDbbqhBZGSf
RDpOX17N8cytsKlxnpDadZOb+FwHoyyDRto7Frkyn2Uc3S7NW8k=
=Ptw7
-----END PGP SIGNATURE-----

--6bBD0LvuJUmKKaks--
