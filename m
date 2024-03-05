Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C85822E
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640660; cv=none; b=O1NH7NcuUGFnhgsZn6iaLOf834o7H/aDXKTlnuog5NxvXHLs4e/AlKZuHIIX14yXaPcsC8M6kiBMTMqMVUIn8F8+AdEEX9ojckYpvMRDL3uk2XvMh4VB0XH08DsJTNLlndGJ8rYw3z+BybRtgXHdiuBnZmZ0pBqsPCAQ8uGLQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640660; c=relaxed/simple;
	bh=sGYp3ESrv+lpjW0M0jZC4DIxemgRfLT0wzYCmSyOgvs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agwkrcueHvqKMkqxcZ8TVfZbdab9L59QQqHemyMPXfGx9uc5TsPULBbTt6W3govnKtsHdbzEIE2+/ZeVM+ThsbozQKQuCA4O+1q/6cvic1MqTh4E7btOCadanGP18JSfDe73ASpn9N5sXFkXm9fEH4ZqV0+wJ1jPtP27gm7xxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ECENV5Yr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fACEZdZ4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ECENV5Yr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fACEZdZ4"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 892A21380135
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:10:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 05 Mar 2024 07:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640657; x=1709727057; bh=FzFUaMxD1y
	/mEY2V/1VLCmC+Bp2qUip/ggSWIK2AxYU=; b=ECENV5YrR5h3Mjm5mLDpp1t4zV
	y1oOYd41yt0zti6OUYK223LD3chDWrvyifPnqY+C9QbmVaji3eDOM1VzUQQ2ksBM
	DTvNZVd3flJ0QsKAo3X85ttlnvTxGgX1/3/4ffGzcIDBRBUjYILpZOUpN4T34uqk
	9c+rSVUF3pH/SJFziUjisLgLAKvg+Hb+qTXiC28D79R9Cyyw8mSCC3F/DCrtfY4v
	nR/tJ3JEiPm/N1kXYQ2oR171jntCu9VesUDcQeIgNlbEEb1vWRg0nJ3YnOaXCJMr
	W/hJeiqHJ0hrwNQz8SF+UKr98DXHgionk7OeENCOyyabeLwNTgT6TRWUo+Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640657; x=1709727057; bh=FzFUaMxD1y/mEY2V/1VLCmC+Bp2q
	Uip/ggSWIK2AxYU=; b=fACEZdZ4+nSDwwcwnaYgl3unmgKHWecOeYU/bUH4IEX6
	R6/pNwrYrGTgTnyAleJ9ED559cGwz6pyP09WNL8mtj6ntYRUDl0TXfErqy2XVORr
	6jLS7NCSdILL4/i2/WhVP9Dq4Q/KnrlgZoVxCY81ynPmN1NifMUxdVkfHvJPtCYi
	rlBlBuD/7TmkmpyizFZ1g8guoZnjCgzWN+OzRau9F8e4mEObsbl6rlflw4iRUqTV
	wWYK11lSNdfyX7SChiLl06bp4vfdfiSNrDqVxrCUuEa/8X1BCqLNcS5B7wWhRpAJ
	0fgkTMPSJUIf9F6s4+pkeFAEZa6qLOjbklwWOKOFDw==
X-ME-Sender: <xms:0QvnZZF2ZRffo6AuoIE-RxY9TUU4viEQJAt_Xuup9RruQYsMIJGFVA>
    <xme:0QvnZeXdW3LSIJnNQQFOqNoU6ABkiHqVQSbmk4sX0CdzKEMtIVS9CXxwj7FtSRgwY
    2lta4zvZUQHhKP7ug>
X-ME-Received: <xmr:0QvnZbKQ9VZ0uzwAbrX30nBjpgRvYGL7EY8k4kURof9leZXrSPjQ3dwXOHbw_G8gXBvyjPJ2OiOFzjXA7EERI93VcunEx7eRZDaSnVldB9HDneA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0QvnZfHziasTQga1BZQPN2JfNH7zw2aDF4iICPMFYcHmxMc_SMyl3A>
    <xmx:0QvnZfUnVxfA7SKww8Eh-oGZchhG5It4yXQyhkzyp1eT4IWCmQ_qHA>
    <xmx:0QvnZaO9xAr21uNygFVGCbBRokKe5A9AD9XIJeoHlts_zcsrDNZ_nw>
    <xmx:0QvnZWcsd9f3Na91jO4GPCsF54Tk5a1DDdhsTC5FpJ5odEdygEOK6Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:10:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 816a5683 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:30 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:10:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] refs/reftable: reload correct stack when creating reflog
 iter
Message-ID: <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kyrneev6oXUbgIvc"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--Kyrneev6oXUbgIvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating a new reflog iterator, we first have to reload the stack
that the iterator is being created. This is done so that any concurrent
writes to the stack are reflected. But `reflog_iterator_for_stack()`
always reloads the main stack, which is wrong.

Fix this and reload the correct stack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 249a618b5a..f04be942ac 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1682,7 +1682,7 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
 	if (ret)
 		goto done;
=20
-	ret =3D reftable_stack_reload(refs->main_stack);
+	ret =3D reftable_stack_reload(stack);
 	if (ret < 0)
 		goto done;
=20
--=20
2.44.0


--Kyrneev6oXUbgIvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC84ACgkQVbJhu7ck
PpTiXg//fW/tdLipmcJIV8uZ8jZKqW0EXyMcewHH8u7+2XxAdHXlj+QtHWNnA5uh
BixFW3GgoEpYRDI8lKYtHD8u4mytZdW5C/XYU2N2/aShD45EM72ezMGFVSn8es4F
jcdVp+Q2Kgb7SANzblVVX/G7fq4/ZevksoDN3lYXW5TB1++54+B56b9s6mEuP5Ek
EG0gyhxf+KsjS4yq9iGynKso91iog0Sq3aZuLgH/JCdZQbDQk95xkLSyPaDFU6q6
NuRbp8ik0aZ2Nk1ZH8BVQTLthyOXUEWUuEKyeFy3kMfcsfPrytyu+aElpdvcca8j
+TG4z+wdgA7GN4DuQ+5KdcEoYDU3lRyKWr7Gg5pRw+yGSvkmPM5gqwpaYMRXSMMk
FXWfN7aHP66NkeU+flQemcit52flmCNhS9UMQNHpImS+/FxNxmC+J8HRcoeCmMtX
oSWjg854GVY114sdeV37XMDXgIekKtgELBj+unLag6EqMYwD1d+4UhdadqBCsScO
wi8IHL/a0FTPj/lYVIfOVR/PryFscmaceksb/h1fZ0JDePGNGQHSmplWT+mApDWK
aM5Z01SnGXMGdZQ1PwWGGsfqIMFpzpRRHZPTAkUHeuU1WLJAaBjB/DrpyWHQjwVS
O03FxU7/4H6kl0ndyyYbyPxb0txAWAe2SgbHmr3fyXhHZHGz4l4=
=vzb+
-----END PGP SIGNATURE-----

--Kyrneev6oXUbgIvc--
