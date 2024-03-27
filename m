Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BA3418B
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529196; cv=none; b=Bsr51qqZVVG9SZjK9lVelCLJ2193lqvCzzsaB9WjT7/KEX+meaVwc8iFGKBqaSINini73o5gi2NLDDR5p8RU3jsFIrQH4asOHThNNDp7f855UBu2bsIocYuKs+D7T30tigfS7GCQXWFuyOcZzx642JIhS92x8A2E2j5nHemnSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529196; c=relaxed/simple;
	bh=BuSBGGbGoFsSV8KSdx2bY8joA0YYjEuMpD3ySWeE/WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4j9UnbVmt/HZX5tfZWbmUhSpspVflavxbLsPC4GfF1TJWkPT3SvgWw74WPN9hpzkwGjgKz2eLSguMHH4shsBWW5LliLYZrFIFxpWOhpvw27SHS2c2lcN6aD9psN6JIbAjTkBABtCRY0DA8uRBlm7N4K5/sBIlw8BjIudZOoA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LhB7Am3K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MrWP5ETi; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LhB7Am3K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrWP5ETi"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C801D1140111;
	Wed, 27 Mar 2024 04:46:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 27 Mar 2024 04:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529193; x=1711615593; bh=e76GNnmVxT
	pUVXc8YYFJplLjsRBs0vXhnZ1y3w4VLTc=; b=LhB7Am3Kpph6FBGEnojQdfuxuw
	OemknIN0xsCPQ8HyDvkfmYUq+eZbyloHmb/jXhJpuDaF4f3KfRlALmeGKtT7gx9V
	IPDon4IHOlhLDaJlk3iEIFNejbK7W5uwAhtQemoYti+ktuARZq0/hMFb8EegryXT
	DJCYolYy4zI84o3SvOVd3POnICe0tnJQjjHt7IPszzkRSMbBHxxh15VFNPP7QsJ5
	UG1vIm6/XI6NdenuWT3VNlGCWJb5MU+Pk+f5FPCyhvYTNkjjzZ86UhjvXPHN2TDM
	m54ngu+78c2SZU9bRZI7TYa2Ffuq47TMuySyN6reE4go6KETk2nTL56dIHSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529193; x=1711615593; bh=e76GNnmVxTpUVXc8YYFJplLjsRBs
	0vXhnZ1y3w4VLTc=; b=MrWP5ETiZg2bwm3+jZmT56Qf74RjHe7IaQd6JmJjNsG3
	wLLDXNbi1aVojxhJyqGnTL40k6dNrZVpVQm8tA/++YNP4bR02niKX9KTAksNV8P3
	89A05gkf3HfsPoMDOXzB4SMnD9zC+48Bf3qpK0xrSfYQIJ4at/25nuNA/++T0llF
	6UK+8t7cjWf7bwjtcu72lKuZ1fJ5nRhsW1gSIi0f/wk38nlCNF1gAh3OMO5wRUaU
	Z04eGHp1vGgq5YtetUgAbUmVB0bC4NzMDhi1MA5rmam4VMjXdfxl3Awt57+77qSq
	teQIn+D9r4YIIAlVo82aTt/PNeLtp0E9xZUbGRu2FA==
X-ME-Sender: <xms:6dwDZsDOAUhx6gQMfhAEp1q4rWr6qEDuAQ4_dY-COU1jycDVhVxTFw>
    <xme:6dwDZuije6mDwK7p7yIlj_2AH1recQkeZCMFL_6A6XZ8rxCKW1HHAzZ8Ww8lTxsu2
    Dr9JcY8hy-1iO2wzw>
X-ME-Received: <xmr:6dwDZvmRJ4BIf0aqBP9fy6ETCC5QFcbsGAz6b_8i9Grqe-mt-7hx8U8Tfh1mnfEWupAEP78LYkrhTspYlq-Q4TQ8PwPIGNGB0ilUAUSDlN-JDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6dwDZixJbuLeoFk4ffSy1spBhPH0ItB-_2W1BSR_eX_51SVIgvDlgA>
    <xmx:6dwDZhR0hlf_bHOR13kucFAitP2VmhaUMtb03HS1LRDYZOWJ9Hp8bg>
    <xmx:6dwDZtYA4OvXQHSvdQrhlULV4WPcH-lZkI8_5FBxhTWK9OuHV8oGMA>
    <xmx:6dwDZqQwBnupmuKSj2R1_YfiXbWcBTom3MN04eVpE2zGzmZJrQMp7A>
    <xmx:6dwDZiT4NTe7UKp4ZYc_jsUJZUUfdb0KxyE7KqjslcX5NO_cxWqxRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9389027d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:18 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/13] builtin/config: pull out function to handle `--null`
Message-ID: <95f661f267ddd55a387b1c5ef078cbad639fd95d.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IcAGNsXQJiIauMRc"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--IcAGNsXQJiIauMRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pull out function to handle the `--null` option, which we are about to
reuse in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 693df32526..ce2d3fecd4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -697,6 +697,14 @@ static void handle_config_location(const char *prefix)
 	}
 }
=20
+static void handle_nul(void) {
+	if (end_nul) {
+		term =3D '\0';
+		delim =3D '\n';
+		key_delim =3D '\n';
+	}
+}
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -758,12 +766,7 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	handle_config_location(prefix);
-
-	if (end_nul) {
-		term =3D '\0';
-		delim =3D '\n';
-		key_delim =3D '\n';
-	}
+	handle_nul();
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
--=20
2.44.GIT


--IcAGNsXQJiIauMRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3OUACgkQVbJhu7ck
PpQSCQ/9GIpSoxbQg4XWnYIRPxs7WZhsL/9ykuJeRVF2LaQkGezl63c5lypprhGg
XQONABbTylWuvXe31n7Wjxw3vHp0B8CLMQ17qOblZIgYdszGfIad7/QL74lVKsxD
Gb9ebYb3Kt2PTRt2IMNhWconPXu+grBrcNslh6qrKno4bPHwXBZrxlJgFR7FE/Pi
1H3S8kfhhcwpnFuqkBNUEzxDMaVv9aDVgZfWXVsTOGnbdt3SUscisnbgc/m4zAGd
v3MAmVTQwbDhx80kXI+e9VnoIbF6n6NCU1+EgqGojrabIYPVuDYQ4XBwxR0MQ5S3
1m00qE8X0qlGEB8sE4/fUR3UPddaam+kn50OhLGF4Kax7UqKhSxeM5lQHV1EDbXt
hOM8Q28Nf9ug9sfP3E0y94bvtWjm7hKz20HTICWv0rD4sj09/etn/0GMzhlZeKiD
bOBV1owpiSFGXdySM5BN7mrgHcNT7M2ne1j8kvSZn8nqTlhx4sPEfdjw+zfr2rHk
g9tPwfY1yLvWCoaFrp/egFJagmUZUdoiE0ceay+TR3NvTPb4Ve6kwcIBa5w00lT1
PKIVDv3da1dkYPK/nBMlmPMNW/8Wm5gqkAK09zM6l7QLKORlBdJ7E2ue4aYLhyAo
w6OtDgjVqrwGDCoA9AkFUVRYLRMTR0ERsKlJfHlu2ooi5CTcHZ8=
=xZtU
-----END PGP SIGNATURE-----

--IcAGNsXQJiIauMRc--
