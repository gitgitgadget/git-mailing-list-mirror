Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67D194AF4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669704; cv=none; b=o2rqWshLxbmIjzqjiL+jr75CYQkKc6tJ0UNZkrV6rZF/mlZkKGQrkBdbGsnkejs9udoKakfUHdZ/1FrJe7B4sp7evzHl6MtxGCzLKgKUMZmPMXwZl0ACgNjsbtJ09Fie/rBmkSGFMGBGpIYO2WUPyVzju4TXAojumItP0c1CMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669704; c=relaxed/simple;
	bh=mjJtdrpnPq0jn+Hsh+X/oszp9UAGw8L0bqzKp5Lld/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQu3Cb4smkQjZDw33/A6cqom+eIOakRxHpLNULr+b51HNz9wysP07tMWwuSJNVzWOQE15ANiC2iC0pa7lEMUNITsQ46I37t4cvtEckBgHz31+cxQWQu6T4VoD1+BAvBN7gxglkwtHUodYcKGY/EjlV/9iNL02kA37KFivHXuEC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PD8yeuQx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXyPO2rF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PD8yeuQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXyPO2rF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B88361140138;
	Thu,  6 Jun 2024 06:28:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669701; x=1717756101; bh=a3/cE6CrmL
	y6mm0EMKp6w0OJoQOslWTR4oyK/ltBVyw=; b=PD8yeuQxwRhZ1AqCS0cvQ/l9wO
	xfFbHRXZ+aDIxt0A40RICGTngoXlW2f7TMJ2HRhusDBS2EH56fHfWBwWrCsGayFx
	/LpJ5KLlwkYszWT+DvQ2CrQtEwh1LoBDNdPij8XjQtne2jF3/gSCX+4knK2++Eo5
	ZfLAHI3SHeeN4Jsse/+Zy5Ww1uf9kgQUmEQ9OfA4y4kj0/7ep9Xcd4PPGhdmKU88
	WDjLa7e9SXcC5kG+xgs/SleFP+oUXqIFB57b9LHbdtTVt1Qogd5UyQmVwSJT0d00
	ibgYHb0FOr/VQ8n6JZVig74f0uu24AmODmYhjGVi4ESMRYOWxZQcrLnm6VEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669701; x=1717756101; bh=a3/cE6CrmLy6mm0EMKp6w0OJoQOs
	lWTR4oyK/ltBVyw=; b=SXyPO2rFI84ETU2NwYlg2NFTBoBo2ztZtljlTDp0DAYI
	7hZHv1tzTiEK0cT77nEaWoFZFVHx66rSZ0u1pYfoQo2vf/lEnxmVj0lPhRMvnxaW
	vmhUNrVhT75Ce3iQtehDCKQKe9BCATe8HqiOR1xXWPPBLVqfcGK3Q2X8V5gQtZfb
	5qeAXAGy9/bL8mEZv7cbaavz2YLCGMSXsm/p8JfN7g81VFW3D2llaXLqnZVxcXjl
	WuUs6h6DNL+ji3RPPUaN+2z+iWU4R3zA7B7QIHZRI9KNjtFRTjTxL4aYWmUxTo7n
	WRGvbFsAfRra+yelbG6w4mcsRFJr1UbmDOJj1L9XLg==
X-ME-Sender: <xms:RY9hZmz_9pZeDDQ2xIbSC6Cfv-BczSqX9yYSpBG4-1i3Mgcwx2Fqdg>
    <xme:RY9hZiTlK5gyrUpByyVv8rs9G7p0D3IO0AAIN5W6QDPzkdiyeyqQpipkGpqLOD2yA
    drwWuY1XJl0ORt0YQ>
X-ME-Received: <xmr:RY9hZoVAH6ckkW07MQaOhJhDugff3sLhSazX5FwDfLG0M5Fkci6DNEy7rrXunS5OF-Qv_lHz-tmGPePDaAX6KkxxkZr8bJE-iinWr5Q7PCB-3bi1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:RY9hZshixVFXnvSq2x7QJdBCFkOIjqiY24BMENrKOvGK5ptBfqkXTQ>
    <xmx:RY9hZoCDbuRRUJhZyMAfOxeFTff8FEKK_f4Jj8aCT6tdJu1xCrkXKg>
    <xmx:RY9hZtKZGUg87lAWxKiDswLm_1ULwHEcRs2LhaiMY1gYMQbG5aBFsw>
    <xmx:RY9hZvC7Tg_UNoYEjousTT3KU_UO5HxEzxyqJ3e-I-ALTtnVHxf_6g>
    <xmx:RY9hZr_YgW68VsufC5qwBpGQdwlikxCcb7TchyIcGfSGa19Rx6d6SCqT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 714c7b2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:50 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 07/27] diff: cast string constant in `fill_textconv()`
Message-ID: <6e631a9ea46aa563d197f4a057698a0af53ad50f.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cc37i13HYIXZuaYf"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--Cc37i13HYIXZuaYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `fill_textconv()` function is responsible for converting an input
file with a textconv driver, which is then passed to the caller. Weirdly
though, the function also handles the case where there is no textconv
driver at all. In that case, it will return either the contents of the
populated filespec, or an empty string if the filespec is invalid.

These two cases have differing memory ownership semantics. When there is
a textconv driver, then the result is an allocated string. Otherwise,
the result is either a string constant or owned by the filespec struct.
All callers are in fact aware of this weirdness and only end up freeing
the output buffer when they had a textconv driver.

Ideally, we'd split up this interface to only perform the conversion via
the textconv driver, and BUG in case the caller didn't provide one. This
would make memory ownership semantics much more straight forward. For
now though, let's simply cast the empty string constant to `char *` to
avoid a warning with `-Wwrite-strings`. This is equivalent to the same
cast that we already have in `fill_mmfile()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ffd867ef6c..cecda216cf 100644
--- a/diff.c
+++ b/diff.c
@@ -7235,7 +7235,7 @@ size_t fill_textconv(struct repository *r,
=20
 	if (!driver) {
 		if (!DIFF_FILE_VALID(df)) {
-			*outbuf =3D "";
+			*outbuf =3D (char *) "";
 			return 0;
 		}
 		if (diff_populate_filespec(r, df, NULL))
--=20
2.45.2.409.g7b0defb391.dirty


--Cc37i13HYIXZuaYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj0EACgkQVbJhu7ck
PpRRFRAAhMBo914+p2+PFvAs/9zkAVc+VQdHOdKx9bn59BQZe1rmeAabz3T8u+nw
MchhNHq6c6eSK1PsaJWBf0Ck2KgaIMH3P65jPKz2lgYrJ2qIHJufsU0DVZ4kSuBv
Y8Bp4prM3dDfGBeiS8pMNPWYplj/WkgR4z1zSkHCmBUMdS9hulp2WwC5F6RGMMwm
hU8Yazo+ClI4hbPCSB31fZjDLI37dx/qLbQMedQlYiWmVE3tLjBYoU4o7BAZfgAT
T+M8HZeRvjEgFqELSk661eCdX3m0o9c2/sg/Q/d0XRl/lpUyHOPT63y637EtZger
YJoG+MeGD930WJWcWKp/v9pezvV9O0JXoXIPskGd0fZ61FzL4WdJWuXoz7AYlC/U
/Ce5i0lbHcV609FHa4D0RdKk9NkKJzBDAWt6zjYwCDl4/XWZYSmTFkN7eE06Q9B6
Pv0znmupZS9uFz06RsY9nKA7sON/0wdx0zUwDkL378gcJbhsp9oCf4czHsjXapf+
aewxRHZA3w+e6pqg3BXCKx17ZW7cv8m8m/lDp5+v57PpmTG3SYlSeMSazJdDFoYb
efhGEjOqtdjV+sphLEcnOq6Yju4E9uZMYtE0OqxNUd6wQk7kv86WyAFL9TahzX9Z
JAwXHdD0VdojLoOZUDmg4OSRhselNuNV7znHKXbhSfo4EFKwe7g=
=ZosL
-----END PGP SIGNATURE-----

--Cc37i13HYIXZuaYf--
