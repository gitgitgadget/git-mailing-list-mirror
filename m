Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B756153597
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742292; cv=none; b=s9mOvwZ8k9wDzKhj9EW6m/ZMsrGs/zRKeyKhiQ084TCUBbhgUA6kkxPcc6CgKuzfEBkpNKJ9tJ9Z6ZB4v6xf0u83bV0RvEijc7t7RP3uYPN0gzPdv5296BwxQWFR4No4kghKU1lseKwBtPdqIldK1lsDCDl3NlBt4Kh+DKJe0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742292; c=relaxed/simple;
	bh=mBD1yV5v6Qc01ynM9b4M9vwnyK63Ju1P4fBJWALtzhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4gPN2sDug7ZXtxpAaZt7lq+C3xiLHczpaTH1sf3Lit+Hc+jEmFcgoGMqRVTaMuH/zy47igAjQyBC9w8k1JIWn4n0Z+4lWsyQMdMSmorp4OJ2jUSyZSpmYKTbDx4ppJPR7Nk4q9dRLdE4Cn0eWCTjHidLzDW2TSv6tOmi4lVbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cfn3E5Z/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jkeuaerh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cfn3E5Z/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkeuaerh"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8C29D138020E;
	Fri,  7 Jun 2024 02:38:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 02:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742290; x=1717828690; bh=4q4PWfLJjs
	6+kd+eCY602TSkbi/6kT2IoiPLXb63WPw=; b=cfn3E5Z/C9hsun5xEphCpz8WAf
	1+PZvJkbBtmUIBrKSNfZZDzZq3C5vh3ic1wZjq0+CvymwfFri2nfpv7NyVILQoxi
	tBMhUmSn8VlM3Ucu9/Zne1sHrnOBt/UIQ3Ie9gCv0GCuz9sUhw1f4h+Kw7i30zNe
	xmiFI/T1dVS7XVllSFLG9naVOVfxASHMJrt6LmC2oVTnxxqsuzBchWc9h2rNVK52
	kDZfCM6YZgI69jP0TrDPxlJ78z7kiNnXoU6CZd6tew1kI7zRtvAJ3GxP+EhxunuU
	eyp/q6/C+VDpExvuIk49PMCKpnPYW4/mIlDmBnTCJHPShHFTdjo8+kg04XWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742290; x=1717828690; bh=4q4PWfLJjs6+kd+eCY602TSkbi/6
	kT2IoiPLXb63WPw=; b=jkeuaerhWHkwzQvwAPTBmY3MkvgOAxmqk+K6L5qiKEez
	IevppAtg/iYIgjYPBno61cWomVh0QItkWypNz1YNCJ3Br4ZlLkc/dVs00KylD1ny
	7wrifBz5ko+VE3awW9LK4kgTGyQ1TpQPWj3m1A3DlVBGY2a+KNl+bc6d+L3Gb2R9
	ubmaNRYUEpjkETsvn8erk8kqV6PxXVKPiDvTqh0CzF6vSiC/tcPOmW4jeO6TG84H
	lu57SeTDMv1Owy6pylUYqwLl4NJzIIhT34m3mkKI2Rd/YOdd3wDJdJbFHxW6h4F3
	+5pvk3b8Ztg2y/0FQKHEgUL9EgKwoV7ZMVsTy+USQA==
X-ME-Sender: <xms:0qpiZp2HfiFSGuROjtV5x7RwO1AMR_llt-04GRCpvrru5n455UihTQ>
    <xme:0qpiZgHoaGOGX7rlKv8ZsA0I1Tcycik3EfH1gXbZAduw1eOKd4htS0i9TITnwCdqO
    OELdKzOgPzL1J4Zpw>
X-ME-Received: <xmr:0qpiZp4GaEoABnQbziHQy5wVjTc51D4wCKn3eXG81sosBDH8ni9JWCsYMzjdZy0emmVlFR_OHJ0qpp6l3jmHfDMHTGeB_FSQ_c-OfyQ74sL-lz0->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:0qpiZm0xyIYcYtW3NQ6lFscj9c0YSlueDAq01bC6LlEUP9oUlQ7M_Q>
    <xmx:0qpiZsG9ZJKrIsgc0zc2orQz-qY-1MrMCUxsYe6DTp2KPmLzQwIL3Q>
    <xmx:0qpiZn_NMqS4FCnaWRnK4rgkcxyPF2TXl03afEbRD4OqwIfeAykDeA>
    <xmx:0qpiZpkq85Ox1P1KHhMz1s7vuSrAt79aoDOAnxdS81rVhSC-j7A84A>
    <xmx:0qpiZogT3J22GktkZIbGVrppKijpy6A1PYxtIj66uJ4R5wGkB6I6e2QT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de38106f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:08 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 07/27] diff: cast string constant in `fill_textconv()`
Message-ID: <8ea984128d8aab8af08ba4f4be94452227672b4c.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tyYpUgNOJ5abOa+F"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--tyYpUgNOJ5abOa+F
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
2.45.2.436.gcd77e87115.dirty


--tyYpUgNOJ5abOa+F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqs0ACgkQVbJhu7ck
PpRgZA/+JPVVOjxfFp05g20+wWUdoe6nKvJ4S0JTCoCgjkiGh6tzYp0LDUinJi5t
RL6b9QyX709uwMcjyVaaTEiNnXBYIaoIPRE+KXaDQ+a9aiSBtOK0iRNcBtny6RK9
zbkv/jFN+cMNdMRcjXg4knZzmS61zoVen6jhC00nPmJXg4F84Ouf+rUA8YLKDaOU
ZbUGxh2c7T4ybY4/CAFMMoveDCxji/MMxYn8nUjig85NllW37s9bVGUTocGlT06Q
KQ+gVtB+bxCKKw0y2/68WnPQIe64QaH5GBgoag/jS9azOZl2kGkQTIyNi5TKEiIo
xdpcL1Y0j5Lxqs5RfYD4Y+iWardPjiP72tDbv2Iq8Nqu//F9fWGvdaqQLrwbsHKS
k5bQgvh9RKgBZ9zWmk6FrDbyCFZL06EWIejATt756UZLAPtigqXeFFJRMQg4c+S4
ZY/xDLptT3OnN/puQCmdwM+wN05MIjzH3dA3/D9+kc1vL4YrH+AffADLu4ULQDEK
wsIlCGxLG4LpxmSWMgnngbfY6gpZMQ0WNC4Re845u1u60Tq/xPnwBju/BaE/82fk
NkEshoy0wMzqbFyx3mf7RT489labgLViQEs1Wo5Jn89sNG14AKqmfBuYb4+6Ky6u
1RtLm1BDg3YV8p+ymIifMppbQEYargwFNK/jpMEivI4SvlHD6ok=
=DLy7
-----END PGP SIGNATURE-----

--tyYpUgNOJ5abOa+F--
