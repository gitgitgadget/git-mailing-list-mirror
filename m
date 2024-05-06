Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE945948
	for <git@vger.kernel.org>; Mon,  6 May 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978081; cv=none; b=P8Vg0tfuTEsH5XGzSsM5eNP0SXOd+p+dpX1iOwcuYrXqs3K2ffSOdMMaB57HadsHSqAoqFB3+35Sh3TkkiMi2oR2iqE5fxHIRtIdKiyL+v+S010iBMAILALlHPRXHOhkfflFftnPv5Z5MwStnrt3bPs4fxj51SPCb2GttDKA5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978081; c=relaxed/simple;
	bh=8nGtWuiJ0P1H9Va1e4ui2LwXe1t9TFUabTandhR+HWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkFJS62JrS/sZHWHvTT2EabjggcjYUo3rh45FgpgN/w3Y6Nd9FZtn6o1QrvPQqisECc5XdUUH4DcNv+17Aykr7llx70RRN16GwfcRyPYtsBZcz/k76PgllVwWgpYBV+ALjNaLZOwTiLvHTDTBh7f47BBtonLctMEGiUHYWfDAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iTHGwa/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TK2cgY+s; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iTHGwa/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TK2cgY+s"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id F1C311C000AE;
	Mon,  6 May 2024 02:47:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 06 May 2024 02:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714978078; x=1715064478; bh=8nGtWuiJ0P
	1H9Va1e4ui2LwXe1t9TFUabTandhR+HWk=; b=iTHGwa/hGmyd1LpzDuj8pSG8+m
	UUfFt23fBDGsPV+ruKBH6X+T7G4fKoGczfqTOehFJuEPl1a7WHo5TqlqSnMRiNmR
	Z6aA0JGWepRmQdV2rrHxIoey28SnqQxOMX06GnQx/0X1Xh/cCNPZps8mR4dtPRZf
	asvidreKphtlqFgsBpcgxfbbmnsYWLAKd6IjPXlUxVxQSGYJJMCJXPT7u74qunwe
	yxKT+GtZwUJXkDdfr0OxnyKigjYXhY6fsxDeB/GKcMvZNCuErwrPtPkgwwigOM6A
	tvCFfkY0oYOrN1g8zZoeToTnFlbhUl9dh11yxLg92mmYGlQu3vd/jT4EhkIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714978078; x=1715064478; bh=8nGtWuiJ0P1H9Va1e4ui2LwXe1t9
	TFUabTandhR+HWk=; b=TK2cgY+s7lOjqdOSpH0zAWL12Gm6ZLTFBzw7UNC/uetu
	WK4Xb9mReolD9iaW7zAwA2ZgXmChkIFcuGVwHW9hnDZdHGHpiziNJLcKuzs4LmTQ
	pbayqRdvKV3dSSVovlohJIwQ9+hfDvLK6RvgJVXVEjKczjrRoeV8YSP9DGy7I/6P
	Xo8zdPGOe+tcuz1a4t1YvxW0j2D7rljdw9/DVjHxfx5Z5kqdoUSB6uLwMsflGZ/l
	DMP/Q9vhfVYRKuMyq7ajnViIoS/DcDRFvGYc2vs5CHukLw/W7b/TB8uCuza5kfBc
	6XvX9DecnugH9V6yRYYiYAJESLYmBVb7rrL6a+rNhg==
X-ME-Sender: <xms:Hn04ZmtprwpOv4CXhXf7bWIkiiQX9sdeosJOVTlXPxhgs5bPlPe9IA>
    <xme:Hn04ZrcgAGYeUChjKnCX4bbMHXhG4as71_CIiIGsS-WUQeVVMpfKdQu1rZmbLkGJC
    AsRFnxgxXaHVR0dSw>
X-ME-Received: <xmr:Hn04Zhywhl2ThYVQo3LNAdSj5fVVWAyCkdUcRQkN6wy7iMpatjJK-pfHrnWuOVcU6Ln7P8-HYJ1trm9ds1Qq1JmbdF3OU0PbD5KF6Q7e4KHfpmvj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Hn04ZhOQRbsSfuIRflIOwbnLev4QF69jASMZn9buvcu8bKJV5ioHpg>
    <xmx:Hn04Zm8u18NEphD-TlEJmMXC5KbS_JSxIE-dOItIN_yxhDC-1Nxs9Q>
    <xmx:Hn04ZpUbkUdxmvaXR2kMgkiGgOnEvmI4QRtVmfntf4ALJpSmf-TtiQ>
    <xmx:Hn04Zvctiu1yeLR6A7PYK16KmWkKBeUd5zJwFmUZkQFySfiCy3zvsA>
    <xmx:Hn04ZtZ-B8cOd0ksIwtYMO9GCdQcYWI_RYFYg_gN3z98LmSE8nLVIiPI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 02:47:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b1991243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 06:47:50 +0000 (UTC)
Date: Mon, 6 May 2024 08:47:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ivan Tse <ivan.tse1@gmail.com>
Subject: Re: [PATCH v3] refs: return conflict error when checking packed refs
Message-ID: <Zjh9GlzhJRcS1ZGG@tanuki>
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
 <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FIK6COAExe5z0vyG"
Content-Disposition: inline
In-Reply-To: <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>


--FIK6COAExe5z0vyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2024 at 03:04:08AM +0000, Ivan Tse via GitGitGadget wrote:
> From: Ivan Tse <ivan.tse1@gmail.com>
>=20
> The TRANSACTION_NAME_CONFLICT error code refers to a failure to create a
> ref due to a name conflict with another ref. An example of this is a
> directory/file conflict such as ref names A/B and A.
>=20
> "git fetch" uses this error code to more accurately describe the error
> by recommending to the user that they try running "git remote prune" to
> remove any old refs that are deleted by the remote which would clear up
> any directory/file conflicts.
>=20
> This helpful error message is not displayed when the conflicted ref is
> stored in packed refs. This change fixes this by ensuring error return
> code consistency in `lock_raw_ref`.
>=20
> Signed-off-by: Ivan Tse <ivan.tse1@gmail.com>

This version looks good to me, thanks!

Patrick

--FIK6COAExe5z0vyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4fRkACgkQVbJhu7ck
PpR9QxAAqUpSvBRXOretVhCz889eCrkMykLi8bvYgnze/syCVeaHJXGXzTpIM/3W
5Wj3ajGkf9chF2B8VK4Vm9wiwSPMBLP76+DhDBLaRccofZsOnqZ5zXnJldCZyNHj
rWcc0+m6r1yA+qjqljXmE+afxRGydys0EEESllqcECYIf+C6Z1WYrVqOYLq+nRXw
xhQzh/PrwvFwdGheNOZMBfK8Epqvc7QOVlPRHM2PPa0oFH+KawqClTTBarEAHCgk
g3T2+CPe9App1+r8wES7laSBaIJWVW9fEuAWz1pGjb4jyEhMTwRNbq/QnArv2lG5
nVGinGaSSzzWa6bZ9UKUh6z/ckCM2JJxq7SCA5SXbj2suExKK88O1uFPDYjT8gyU
/I4u7CzlK+KscCe4MTr1LWoka5OWs/TxgwBZ4xgNMqyy11OVxVfPhezMLh20/2u+
btxj2h4vivnuc9dEbpkIP9CuDSuR2nkNtHPHQLYl3ZRHN7HWVdSK3hoX5nOu9adz
UPgLU4JmaPTyq3142mVYFLed96WHlHF1sPcwmtqrsbGXvC4tyve3KSHkrhD9zdMY
cR0saGaI7/GqxMV6d4rrNnOi4we5gHZPy5z0zIdi/Toe+NP3+mVooXYVmCN+GCDs
jsR9ACYA8UAL3odPoJKeb1reqZSuKAj49xmirhB9+NWP8U57IN0=
=scKe
-----END PGP SIGNATURE-----

--FIK6COAExe5z0vyG--
