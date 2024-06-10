Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04A22619
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002451; cv=none; b=GG73leabwN3SLj0LRMsTxZtXbXOTdf4exKQKgAq0obJrjoYTwADHK5CqUv3JqAOWkm0UOhLZTIrH5m1XU7ywgAc6CAjIKi5QOGPw7np60RkgrvCqcA5J+gdchCmlxbqPRfbrr+t7rncoMCsXzwwYpm8B/KOz4XtmFe+jB3C2oGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002451; c=relaxed/simple;
	bh=wryDd27yd7P8IE/E3eOWGxhi2qrztCabPQWf6Gi17TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rieuoMRJDihrESxdmA4ryx6RAvDDl7n/aLL1AG2V2PX/BbPeurcy2mkx2wWJXI5xwXv421NumX1nvGoWrwse4hC5a36Tusfx1s7VNB8QN1uTzzvKc79AyiEwXhGmCYHyllPfbjrkpr2kzjKxopNXhh1IxytDR1tgAhkKTT1mzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RIerGwIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DoTufvic; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RIerGwIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoTufvic"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id B1D2F1800189;
	Mon, 10 Jun 2024 02:54:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 10 Jun 2024 02:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718002448; x=1718088848; bh=T5oPRMuZJ6
	AxsO88bqUqsxxz1P0x6s+MrQwA08UN7Jc=; b=RIerGwIET1pt7W//qjIHvMlhhx
	NaNm78FKnCxBL4QG1uUW4Xv3OMGABLpor35J1dGtxVOK3c66wKhRc5zsfEHN8bCB
	65h3PLt9KDbNvsOz5zV0FSa6fr6yc+8KZ4cldSuHT5MicmzighCcEqjSMw7tRp4C
	vlAJP3o4TUGBdu14RsyvWtfaNA3TVZmPjM5ibkNIlJqXka8kWrLp3c75PVAc4GuI
	Jonn1SOVIdBvp0IXymWlnuEp+RSt4Z/8OwqUSN+fmcX+AjWvIEtzVSW+Vn1DkENM
	D6/d45k3Ev47685aLtk5aROspKOsYNKfdqkycdLXi5+8udZAOvcKMDq9XJvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718002448; x=1718088848; bh=T5oPRMuZJ6AxsO88bqUqsxxz1P0x
	6s+MrQwA08UN7Jc=; b=DoTufvicVvgU6aYorv3iMsuqSP4Xkr8H2eb1lcXlaLYu
	tyDaOaV4lCro1E+lnUxVSTvGTPsowzXPMLMDW4rvxtz0hXPK3c9sLs+7umYs2luD
	hfsOlXDNcuk8l4yHwiDxjgf6Wgd8QCeyAaLad3N6Ws1LPA7FLCuJbN1R1wAkI7JU
	8s2kyx8EyfZ14/Sz1ZbKj9zyvJyjR7xCu2/3fWNc0rL8yNwwMxKkZ/rHYPVte93B
	PJgtAOi3n+G0ZVBluNR2FkWfTuva14HIGnk0VEcXZU2UNDmr+fdQmi1OF/g8//SZ
	uDdSLGVaoKrSp09cLOo473mzwHm2kUjpVFzSwbJ+3Q==
X-ME-Sender: <xms:EKNmZlq5qtMl62Sa1dcb-QoFS9brHUDUnRki7OGGJAHfINu_1tCDFg>
    <xme:EKNmZnrjJbVn5D-BATqvNND7bUgjOd6IT4FCMPTSC3eohjUbZeZ891y4KfHjQK6--
    7c5vqdrT6no8RY0fw>
X-ME-Received: <xmr:EKNmZiPPWaO-cDfRmgxuuRQeDU5M_XixljarhOgwUWKoUNrzeWf-WuyoXtVqzRO3GqOCfyEVlPEmSwsi9H51tDRs177LZU9PpbSNrbBrFsSNvCLW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EKNmZg4QftDlx4PplU3d3TWPvS9ZU-WQ9F5DkpFP5_Kr34xKwqkz-g>
    <xmx:EKNmZk4uRTXlnDgw-JVFeMb6_sschs-ot2Hgv4Db0jahYvyKtnMHLA>
    <xmx:EKNmZohn3aqpKR8qISSpbhjPiQ0lPC0e_XU2k8W5fnxMnDs0kT8igQ>
    <xmx:EKNmZm7WRn_5CigDNPvLMVD5Gm7Ku_02cohzA9obdTkAJUDmph8QbA>
    <xmx:EKNmZik2KN4tqYds6kfYlyF-0m0wB8XO4dUJ3fLMnTgtIYN7FwPcPMay>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 02:54:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4616e4cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 06:53:58 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:54:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 2/7] refs: specify error for regular refs with
 `old_target`
Message-ID: <ZmajCzuQftZlmlmS@tanuki>
References: <20240605102958.716432-1-knayak@gitlab.com>
 <20240607133304.2333280-1-knayak@gitlab.com>
 <20240607133304.2333280-3-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9owGQvgCSS0J8+zd"
Content-Disposition: inline
In-Reply-To: <20240607133304.2333280-3-knayak@gitlab.com>


--9owGQvgCSS0J8+zd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 03:32:59PM +0200, Karthik Nayak wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 194e74eb4d..fc57c9d220 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2491,14 +2491,16 @@ static int lock_ref_for_update(struct files_ref_s=
tore *refs,
> =20
>  		/*
>  		 * Even if the ref is a regular ref, if `old_target` is set, we
> -		 * check the referent value. Ideally `old_target` should only
> -		 * be set for symrefs, but we're strict about its usage.
> +		 * fail with an error.
>  		 */
>  		if (update->old_target) {
> -			if (ref_update_check_old_target(referent.buf, update, err)) {
> -				ret =3D TRANSACTION_GENERIC_ERROR;
> -				goto out;
> -			}
> +			strbuf_addf(err, _("cannot lock ref '%s': "
> +					   "expected symref with target '%s': "
> +					   "but is a regular ref"),
> +				    ref_update_original_update_refname(update),
> +				    update->old_target);
> +			ret =3D TRANSACTION_GENERIC_ERROR;
> +			goto out;

Shouldn't the second colon be a comma? "expected symref, but is a
regular ref" reads way more natural to me than "expected symref: but is
a regular ref".

Other than that this series looks good to me now, thanks!

Patrick

--9owGQvgCSS0J8+zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmowoACgkQVbJhu7ck
PpTDPg//U9wCE96wTMJsJ0ikieX0rIcBPqxTufF25DNXbEEtlIVjg0C2J2U17hLQ
hMU7+xHTw2fwa2fQPAW2sbR+K1WQGLCtZcEwcdgbVMTRc6HZxrkFsg2RcMKfIlHS
K9Mu/zLDGJs0DJ6AA6AEOArmD5J6WWoddgxytsUD11yn3MVTLA6TW7SQ4hgDCZrZ
p65+O6o2B68SF5YGxsNqA98SAjOD55GWBtG6Nb3X1xiPpmpGmNC9L0yJGJBSgSlK
0LrOFmagWeKDWhmwU/SFQajp/TRjGJ++5v5FO08NfY+PMwozxibUepIF+gVJ7jy1
Smsp6JZBvCsYxLYiVByGTo0nntQAGnnFf/KTUgxx9BTJ2i4THxIskuX2elPzy1EQ
knq/Gn7EMgQLkOrRAxNaNr3klBl5NYsMb0In/+M1q8T5HKWcdAj2EwlARfvgpCtB
HZKT98Dm6v5Jev/jBmRWz328rzKxIwVkZoIzi2h2r75Glv8ayGKuzMbn+gaIfvhd
RXtwKk4EP6WytdL7/eysvrFV72KAWIqN1ndaIoS4j7E5aQs+RBkRaAqMXo8US5ua
CtSRik0r8SgoLqY+R5xKQItTnNozzEPzN0RlpYyZLTVvpeg5kPmYPfBJFpUBljE/
XarEbXbfWoUJzjInC9p79YMUv9JtpMCUuY5nTXs/D/5mkVhBnnE=
=Q1FV
-----END PGP SIGNATURE-----

--9owGQvgCSS0J8+zd--
