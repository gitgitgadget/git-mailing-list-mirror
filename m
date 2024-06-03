Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1C85953
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408076; cv=none; b=bR8xxsDZK30zNMdKIQo00Dbc/33WNUM7NZloCD9ngc4wnHQsio09z5eDwsGnQ1FJ+3bTdJqOCnpipb3PThSmr3Vku7KH+/C82oAXM8qjIFjD5s7HusOprz3ae0JVpZzVl3tPD4R6JGFQXuUrGUsldTyNg/nwV1LFkLb20WA1v2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408076; c=relaxed/simple;
	bh=z4YaWrItZixTF7g2I0+QOw1Zz2UxAAVvasATrHvvBUE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwm41Ha/v5nyWfC2Ha7dPQGPrYx+1DrHeKOmJG2jQU8yH8rek07CBdX2rASMnn6Cstl8w9flu6Yu16IghOXjB7J3+ChlAp9zgUQ7PUJg2FRaTTeVeRQQtrjT4h0hXzKM/eDTCHHQ2I2eaxVcMtSzaNpgpvU5xFEq41+VFOPyEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ecXPVil2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RO9y0Cgy; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ecXPVil2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RO9y0Cgy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9F8D91C000EF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408074; x=1717494474; bh=7KmsbepYpO
	SJJ6nNDhvD6jACJv/UEs6piV+9REYphok=; b=ecXPVil2rcFhLPprU6Gwk0QI7l
	hRl0a810D0U99X3jVYbdmSg9KHj1QtdQrBd7hNs98PdlNF3ueVNr3IxXFJOy0nt5
	ey0m3hNx5bEmMg+ZDxbZ2sUHlYGznlBONDyzA3S+LH8G++0QtNYlcqARlN0MVpcV
	JxtNYZHSvknWAX1Ks7sF/43RZLdaZT8qE94DYNleVhW93pDgE0JFrIv+UeeLm/H0
	dG9t3Zg2lQ6I2FMc8wFe/Hi5zPBJtjLTQRPxIlgu83E1AsD1TeTyoEdA6wu6xl22
	KtK/LwoOeYZL7eYKJCjzq9xH+u0ZNd60DmOkocPVkd2a7eh6jg3CSFu/vPgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408074; x=1717494474; bh=7KmsbepYpOSJJ6nNDhvD6jACJv/U
	Es6piV+9REYphok=; b=RO9y0Cgy2Qu67NXdpnDifk87qlclxCYEhljJOTBPx+sX
	knianrWb5vxi+vOtfV+fN54tzM4WQgLlejY1jBWiePvC2q6q1IRb5gwm4k5SP2Dh
	/HvmufKJu3G2jlmMs+UDLWvJ9CZZfX93xqqtEFxBrh9pepHW61/UqDQ9Hj5I3eBE
	rYPMP1XTA9kWZRa9QybxvMveL7mh9mHS523E71nJNiHW2ZqzkpQ5lUHUG9VKQYS9
	PQoC1HJ9ZnwyLtA6lXSwaRcmfbJo5PNHdSFC8VibavawXrcGA+r0rw6UrsCtQPw8
	3OpQxSN6OiicuPoGXTC4i2ruTpd7XOt9iaQq/QRJPQ==
X-ME-Sender: <xms:SpFdZmIRQann6_7T4PlckgDbjKriQg2ZH_DO_4gJ8kBombrA3cRs9w>
    <xme:SpFdZuKOoND9hglLtzUMsdVANNGz9DscUlFa02iqujcA73U9hVTzDUeKrZn_Q2goI
    xlzhlvSk4hZppF2kg>
X-ME-Received: <xmr:SpFdZms6dMDoZn5ODqkwuWW_hAEiEVJXSqIzeTIfQDIwIKxrPFcvqLb5DkoyviULFzqfj4GXBBQKaq-wxewQm6M4PbnEq0HkM51n6gVuzaHJWhfn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SpFdZrZtgEfMTqG3XNjXrbTfra_93zRisVk5uVmKPVMX6dNiMjPGig>
    <xmx:SpFdZtb-Swg_ASOyTUQDwXsDwuGi4UTAOqawTzkqZdJAhbWJ96-Mkg>
    <xmx:SpFdZnBhftGZ9hBn3G7VchLsZna9L0p3WZsfYo8DBRTibWpDszdNIg>
    <xmx:SpFdZjauNySF3OaXbA2AAOm2jAtONr2EKisVvlSiY-DWUo6SlmTT0g>
    <xmx:SpFdZsw5V_zUK-QctWQkcLhzWgYHHEqs0xTS4vUeO0ghC4gnmQXPbkkf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1e9bf068 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:28 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/29] config: fix leaking "core.notesref" variable
Message-ID: <cff6303ce1ce8e921adfae3eada216eca71b2c29.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y0Vdg0d3PfcLmAJi"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--y0Vdg0d3PfcLmAJi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The variable used to track the "core.notesref" config is not getting
freed before we assign to it and thus leaks. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c                            | 1 +
 t/t3308-notes-merge.sh              | 1 +
 t/t3309-notes-merge-auto-resolve.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/config.c b/config.c
index abce05b774..742175c130 100644
--- a/config.c
+++ b/config.c
@@ -1565,6 +1565,7 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 	if (!strcmp(var, "core.notesref")) {
 		if (!value)
 			return config_error_nonbool(var);
+		free(notes_ref_name);
 		notes_ref_name =3D xstrdup(value);
 		return 0;
 	}
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 202702be1a..e1d05ff6bc 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test merging of notes trees'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto=
-resolve.sh
index 9bd5dbf341..f55277f499 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test notes merging with auto-resolving strategies'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Set up a notes merge scenario with all kinds of potential conflicts
--=20
2.45.1.410.g58bac47f8e.dirty


--y0Vdg0d3PfcLmAJi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkUYACgkQVbJhu7ck
PpTKTQ/9HcnaJcEeLm6Ui0jZ/8qKle4H0XIe/CtNTeiM0qWRH0oXYxRHYjpyEu6/
frpTsTLr5jVGsJawi8hITsd9L6ZtgkdIzPxgv5l3oiB41GL5fkgLW3GX54i2yFGm
q2+2/8hDgN+l3g2jlSMIw4Cy1pU+zFm6IQT6hBSM4DvImDLsEFp6n11Sxpsjh3h7
8SlBym0niliAL0fmJyoUPqEHr/Gn87KMuanvqqPo+17/E6krU85aoLT3EJwLxYlq
Cu/yHmjoJmVNR9BPp95HmB7OvTgD///UJ/K8sFeMC/hHS6Ai3+kOKt/1ISJd+Mth
4qUKH+KKHsm+yK8xwNgOStOQOgGUJ2/OlzuNVGuxecq4qhsEGvdR8xW1685Qz6jY
JMkPj6BcFQBHnE5Cknw/OXusQB+1WmydUW9F9DJ6MwXhBqTzGBtZnftZHoGbhVSu
Pb9fPH5/PEM3XSCKawf3aCj6cAMtMJXltb0mO4bT/AkgCq5k7wRzw7AW97oHUKFW
tj7eXZIIPYAabIHk4ERLepz5TbKfCM8BbQB4Wwc37jWqUJ8In+7U8RG3hBu5SuXJ
HW4OQXFMA6amcDpJxGCN9aSZAtNm39HpsF0KHK76IoW4Q+ioTCr506wYS6f/Q4Da
syOZBKAJU04Imwb+dGc+0mDwcZy/PKYd7sjBiYjhTfeXaCikk/4=
=z8UM
-----END PGP SIGNATURE-----

--y0Vdg0d3PfcLmAJi--
