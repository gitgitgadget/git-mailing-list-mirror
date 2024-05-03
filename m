Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0788848D
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714718311; cv=none; b=iJ0v5bHbxmEPL0IGlfIxb6rr+S4BG50Y5Tqn4tLyL1C++rmbl5n7E/tV6mecEdjhHxioLwFexkoouUo2pbpZf+mspEMC+m9f9V2+TfghjurGxaNbNn+lmKvvaHqUwsj1X9oJxpNwjGQtRyoLf2YjfktXPkacWeiUq8ueOCYETlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714718311; c=relaxed/simple;
	bh=68L+/0aDvmkqi2w+3jenSCysDsvMM3c8Yb9SEgOtf0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYzjHLLslqGArRR65wiD6oFbut3YOdy56TN2s59+iUR4pbXQSu/8JNORoHL9orNG/MCtD0Fg2nPh5ns3dCrCYFc9yGKtdJGPba3l6Cdg11VyRTxnd5Z7TvliTx49EZM3Xq7RnI/MbAT36RI477eF9TfVKrXWCHxXQeaRbjfxLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KmBq/Ikx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=abPxSygs; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KmBq/Ikx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abPxSygs"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D474B1C000F1;
	Fri,  3 May 2024 02:38:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 May 2024 02:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714718308; x=1714804708; bh=IFN2Ef+Rho
	flCUVjRQ2vZdKq9h+DAGkZEJzHArjc9TQ=; b=KmBq/IkxmXEdhGe8ZQ52r9iETw
	FPknKSRZTZ6Ad22H8417m2OExRoOiOiuYeMQUaQucvnSEPaZr0LF5ILOtb3yYPYf
	3fQVZFwOGGQ5YZvi+2h+Mj5nxx88ZmaP/SQ4wDwtEQlfPdM+w48oYZd40zqjKmtV
	OLvAl++sNwPG19er+FhSHfjVBCNSl/9Nry+vhspTasZotaQORWwXfq+DwM1AMW38
	ZQqrkZ8UO6NjnIb850weLr77/t4VYrNO4txpFWYGcw96uPsyNXq3teLQyLfpHaIM
	gxY5XslgTf+gWQW8qkX7lVJ22U7l+Y7rIDXJHFxHQwcm6XXWIZGgm16wkwHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714718308; x=1714804708; bh=IFN2Ef+RhoflCUVjRQ2vZdKq9h+D
	AGkZEJzHArjc9TQ=; b=abPxSygsPCCjVLFE2L/2+QEpzWPW1O3liAjNFaL8rqy1
	sIKkOM+HblIVmk62fl7k0A6g7I2amNCVALi86uoGd3WkPC4NuPAsHqysL9oJh5iK
	JYC763mIb3UjCW70+FM2bZpCXah1ffg8U09LN613C/1uLm0cfZNbX4fp3Obye/h4
	rIWnoNzVm9Xfqo06o+8oDuFWmgufHv/8NdP/cNWs3fuek33gEJtlqPzBc60nunbp
	HRaNSP2paOSXUE141qO2ZZkrSXISEHxkPG8phSMGI6a1SQ1Q9zHwMcErz8xvM9IJ
	gQA/MNpZwlef/VTLGF+wp6/0AntsAnJYp1loJbYxYg==
X-ME-Sender: <xms:ZIY0Zq15gx54VokSjEPsn8-5aIb7A2he1qLxs767ZeruIcJScNEn0A>
    <xme:ZIY0ZtFYvpY6GjEMBYM6cI1FMIqrivKsMHArmyfV5S9hnllui5zVZJLqXjF3-Z4bP
    NU4EGRFJg8C0sGIWA>
X-ME-Received: <xmr:ZIY0Zi7v40gFfMlSjqJb9P5eft0JqFqjzlNmYn1TlZcoRykgSHCH4E6t_40-4TpNmRKvof9mPR7S1ZaikleNuf-O5Tk5b56vO2BxHKaG_xX_5F0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ZIY0Zr2WO3lB0z0Fd_QaokBlRanwEWiZdLRUvejuuQaUy7CCdcsjQg>
    <xmx:ZIY0ZtHATECYi5AjlJnHF_S92iNSMY58cGpVAp_hb8O4wijCyUTSUg>
    <xmx:ZIY0Zk97fNW1WJ3hKcdjbaqQD9BrkutooQjciHkVIquR-pVf_4bg2A>
    <xmx:ZIY0ZikMO16H1Vb_MyQyTGtYNnH3JSSrozPvtJFO2rDLkVwUroMG5A>
    <xmx:ZIY0ZtBbtZ5MV1GNYyxZ-0AGVQtof__TQre-rpQ88xyQX99DXMq5_KD->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 02:38:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 38488efc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 06:37:58 +0000 (UTC)
Date: Fri, 3 May 2024 08:38:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ivan Tse <ivan.tse1@gmail.com>
Subject: Re: [PATCH v2] refs: return conflict error when checking packed refs
Message-ID: <ZjSGX1eK-kSFKK1u@tanuki>
References: <pull.1716.git.git.1714488648294.gitgitgadget@gmail.com>
 <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CFLyq/rY4TcaS4SW"
Content-Disposition: inline
In-Reply-To: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>


--CFLyq/rY4TcaS4SW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 04:50:29AM +0000, Ivan Tse via GitGitGadget wrote:
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
> ---
>     refs: return conflict error when checking packed refs
>    =20
>     Changes against v1:
>    =20
>      * added test for the error message during git fetch
>    =20
>     Thanks for reviewing! I've gone ahead and attempted to add tests for
>     this behavior. It tests that the error message is shown for both cases
>     when the ref is stored as loose vs packed-refs. How does this test lo=
ok?
>     Also, should this test have a REFFILES prerequisite?

There is no need for the REFFILES prerequisite as you never access refs
on disk directly, but instead use our plumbing commands. Furthermore, we
do want to verify that both backends behave the same here. If the test
failed with the "reftable" backend I'd consider that to be a bug in the
backend.

[snip]
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 33d34d5ae9e..ae0828e26a1 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1091,6 +1091,22 @@ test_expect_success 'branchname D/F conflict resol=
ved by --prune' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'branchname D/F conflict rejected with targeted erro=
r message' '
> +	git clone . df-conflict-error &&
> +	git branch dir_conflict &&
> +	(
> +		cd df-conflict-error &&
> +		git update-ref refs/remotes/origin/dir_conflict/file HEAD &&
> +		test_must_fail git fetch 2>../err &&
> +		git pack-refs --all &&
> +		test_must_fail git fetch 2>../err-packed
> +	) &&
> +	test_grep "error: some local refs could not be updated; try running" er=
r &&
> +	test_grep " '\''git remote prune origin'\'' to remove any old, conflict=
ing branches" err &&
> +	test_grep "error: some local refs could not be updated; try running" er=
r-packed &&
> +	test_grep " '\''git remote prune origin'\'' to remove any old, conflict=
ing branches" err-packed

I would personally add those calls to `test_grep` right after the
respective fetches to make the test a bit easier to follow.

Also, instead of using '\''`, you can use the "${SQ}" variable to insert
single quotes. So, something like this:

    test_grep " ${SQ}git remote prune origin${SQ} to remove any old, confli=
cting branches" err &&

Other than that this patch looks good to me, thanks!

Patrick

> +'
> +
>  test_expect_success 'fetching a one-level ref works' '
>  	test_commit extra &&
>  	git reset --hard HEAD^ &&
>=20
> base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
> --=20
> gitgitgadget
>=20

--CFLyq/rY4TcaS4SW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0hl8ACgkQVbJhu7ck
PpS+RhAAn4QxFwYQ46C4KGLD5CK35qfcRCynZFVVcCVZauB2yIdbfVRBmgJMvZa8
fani2SgLYdHTFAFE8sHmr/VcUsIQ9UWIvJy2LMN9C0sbqOiHGR0eA4MQ4Dc91jwz
Y9X/EJZfvzdko0ps+hgjiqc3/xx3jwEIBgQYeRIXI+H6HAwt7avF+1y5AS2Ed/mc
F9LQfi/H3abi1SA1NJ/51TxhUl7fb0rfqnW6brrmAfLbSdKyG+AJOiOcwumgIpEL
DsHpf7rJBBw8WhFo6UiCxAfIQlfR1P9Ya7JmTI5Ff5TMM0KekE7Fl7kg2kPQ1fs9
cdWP8ptLTQ1bErzRz9s9I98Fuc6FjQi4yz9aNXF/nVO8dxrAIqekyE1nk42laIwE
NJKORPjlyr61nTpjmUpk4QeSbwCzHLCmcrNJZMzq9KPrsnNEbipwUBCdZ2thrM9X
XI8kB0u4Aj+/x1H+bumHIi2bubekp9Ihs6Y2o31G69JJ5wEG8qC1yhtOSc/UUw6v
Dje4/yf0yLeeLmN1k/hT/i77zwaDPeM9eoS79Buxn2QvMOumhXh/Rf57W79ZadcA
N0sOahRrSe7agkCfLWGURQRFt8J1uzAp9nO6xaIQW8/cX5zMl829TmAGFIHqcyk7
azNdBpxeZ+3kvwSqTPcofWr+CmAY1+7d/JgZ/iDtkJzYaTTztx4=
=ZoZI
-----END PGP SIGNATURE-----

--CFLyq/rY4TcaS4SW--
