Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111764501E
	for <git@vger.kernel.org>; Tue, 28 May 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881287; cv=none; b=qwkf4v9bsIG9s2ozw1PLvZJkuMSmXBlKGQKZKER5ZJkR9LTDX1zoCoC763h59Y5a29p1oCgL6FvJTA5sQMB7GBSeGDMhxnY8861xt7/DOzPnWu8L5unyxwAR0onr3c5+5M56LDddcmvh/XC7swsA8dfmgmlhNvupFC4NYgO3sJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881287; c=relaxed/simple;
	bh=E3qKB4DBXekoD2uHo89pBmjz7KwJ6li+DgE9D+wpyRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PONDqFdqxyh0NOsoLYhjGIBrgKoi99EJE9RLfIVGOGg99t+zJ+Ljy/3MsA20uvKh/0jm4NNrjPLM/pPprQskpkXDqNxDgO2oO6O6/x0rITGTJAdHkuavI811Jx5tHigmdbti4J3yFtf3i1cJ+krjLg78YcCLyqB+4XdDrpq5NUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XJ6dlozF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VcHxGR6z; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XJ6dlozF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VcHxGR6z"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2062913800CD;
	Tue, 28 May 2024 03:28:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 May 2024 03:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716881285; x=1716967685; bh=mJ+1OgqJe2
	KgRk9/MXwZpEFgTTbO6gy3lliW7EUYXTw=; b=XJ6dlozFcwHnKmE5nfALBZnzko
	O67+Mevkg2ZszGQ9A3dNzkv31JBhHtLkrV6V0pPSZsut76xCpNLAs7XBty86RGtj
	vIaR6mczw/cmITH3k10LSP9B6sevupecWIIJSk2hQyBObNGQZhuzP5cSTsNmcnx5
	A4wVHqrgTJhpSAFBVsm6qMbELTIyCcl3z+pRd+qozFKzXtjlQWRbBIyyfOriAy9z
	lCCjnjTIjRjNsdnbR/14vpI2sWjq8mtpFCRWwRoeD5JTtPgpvPTzBIwOODyZHcMt
	YavmogU0dxr7+UuEHlF0Lgdf2xGl6N5TcF8VyLMgGO1Ii3EKGayjn9/5sOlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716881285; x=1716967685; bh=mJ+1OgqJe2KgRk9/MXwZpEFgTTbO
	6gy3lliW7EUYXTw=; b=VcHxGR6zgGmiiTX2c9RxXv8em/Xir34loEdvwrdSvu4x
	cd0CT23xaqnnrlBe6WvzN93JB93WnBAWyUQCBl2RFtwrNdobi/R1JlU6ksRgTRmY
	a2pz32o5R29qLmaDiqAAJRjAq5lGodJlOIaXme/UtZBo7aDPwOa3Qr5tofOTNFP0
	WvZvDvHRVPxQaZ3SF6PXGFHfslWO3OgBo8tFid0Mn/jCu8EaUhyCT6ACY5Ok8sdN
	4+XxiLIPI/3VyF1pEsF24vAE+1h49fAXmKwKFYuR8cf2QdaiW01hvsmEAn/myIvL
	4ZQKQERdowY3p0Z5qnCmipOuF9CMOE1xidF651VnPw==
X-ME-Sender: <xms:hIdVZu5sxoBs37nV_GcdAswcCzJ_zL8YB0BAuYSxExK2zJiSdngQWA>
    <xme:hIdVZn5RuDFGiepAy5JTqTI5Y1-Y30-jzhfGxOXXj_SLbu_fxyRAJOYqiBcVjr3Kw
    QZw0m7208K-V2pBpw>
X-ME-Received: <xmr:hIdVZtc-OiAo0t3nPjvIEwD23aniukXqkB885W7DUjCZX3v9mbkxg8K-GDquFG3ARgIC1aV_4X2v2S98kzkrcx3kfNQAIoZUJrJMej0SFh6Jex13>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:hIdVZrJXWbK1K5Peg_g6viieReGyRAGYIeHKUoBtsqrFoUh_klRFew>
    <xmx:hIdVZiIHMKWYH5GDdnqpNMfS1AAZX2U2u0FWQuabz33H4t7qSClYtg>
    <xmx:hIdVZswxGgx2nKe30DkCmf9c71mXwqMSX2C-dUoCWktUIUJWve1RiQ>
    <xmx:hIdVZmINkvIMwQLHvhsjKYiikBSelHu_Qa8r6ebAXO8Rvj_Ia0KHsw>
    <xmx:hYdVZu2EcqCrU3LDFu15DTPw4KKu7CgGyczUNSrmnsJyKWMDEL-F27Ls>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 03:28:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id db9daed0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 07:27:51 +0000 (UTC)
Date: Tue, 28 May 2024 09:28:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 2/2] apply: do not use the_repository
Message-ID: <ZlWHgBROsPBrmM0D@tanuki>
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
 <36b44eb4c18cfd805ccecd8df695b0d5ee9c409f.1716877921.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bxl7e1f+Btb9m17K"
Content-Disposition: inline
In-Reply-To: <36b44eb4c18cfd805ccecd8df695b0d5ee9c409f.1716877921.git.gitgitgadget@gmail.com>


--Bxl7e1f+Btb9m17K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 06:32:01AM +0000, Philip Peterson via GitGitGadget =
wrote:
> diff --git a/apply.c b/apply.c
> index 901b67e6255..364c05fbd06 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3218,13 +3218,13 @@ static int apply_binary(struct apply_state *state,
>  		return 0; /* deletion patch */
>  	}
> =20
> -	if (has_object(the_repository, &oid, 0)) {
> +	if (has_object(state->repo, &oid, 0)) {
>  		/* We already have the postimage */
>  		enum object_type type;
>  		unsigned long size;
>  		char *result;
> =20
> -		result =3D repo_read_object_file(the_repository, &oid, &type,
> +		result =3D repo_read_object_file(state->repo, &oid, &type,
>  					       &size);
>  		if (!result)
>  			return error(_("the necessary postimage %s for "

We call `get_oid_hex()` in this function, which ultimately ends up
accessing `the_repository` via `the_hash_algo`. We should likely convert
those to `repo_get_oid()`.

There are also other accesses to `the_hash_algo` in this function, which
should be converted to use `state->repo->hash_algo`, as well.

> @@ -3539,9 +3539,9 @@ static int three_way_merge(struct apply_state *stat=
e,
> =20
>  	/* resolve trivial cases first */
>  	if (oideq(base, ours))
> -		return resolve_to(image, theirs);
> +		return resolve_to(state->repo, image, theirs);
>  	else if (oideq(base, theirs) || oideq(ours, theirs))
> -		return resolve_to(image, ours);
> +		return resolve_to(state->repo, image, ours);
> =20
>  	read_mmblob(&base_file, base);
>  	read_mmblob(&our_file, ours);

The calls to `read_mmblob()` also end up accessing `the_repository`.

Other than that the patches look good to me. Thanks for working on this!

Patrick

--Bxl7e1f+Btb9m17K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVh38ACgkQVbJhu7ck
PpTiVQ//TzTxMkJxxuc2u1H1zpQiaGCVWqU+/ylVFgGEI68j4jur8TyGHhVydnI7
E3xCqr1gMcyMTAlhUMylr649AUUV+QRN8pKM1DWTk0SVcmlckv5BtQJ+ZzoCEW/g
DvohFKa9Lep06iDytMK/Cx7fBDjlEYMzMZZhDL59vJz94lMHu0FDAruN3E+qq0lb
V0/V9aBUJzY13IKg9WFLIF8j0wwMLKguS7E/omLZcM59Uc/Q5f86+KvP6SnTgrrW
miG+ePvXUi0R8s1ZEh1G5Eo5ZYSSbfwBlMdhjnNjySyQlTEP8JUfH6NX/mCa1muu
YG6FEO4WXmtP1Lm64fET2JZ9VAX4owzOiAliijvq3fGsuSHxRXEpibBgDjjGE1q6
uea20hoaxa6Gtat57PVLE9FLC1Co8bWrg5QdKecaknHMK/vQrvgWw+JVawz2XzRH
2AudpMmyJbdEzpwFvpFkeISQnA9H9lMWtMhMusYr6TVqblkPGcAaLAFN9g/MH7b8
o+9B0z3AcEpkCsSEk/oysbnX3klPuDf4Bvifim5pzb5s7d8SjQLdRl9dgupafLJx
7zH3jgn6sS6fojmja9S9tHYFXfZXLrfaidaa1V4JwSTt25K4whanSEy/pkqCKuaD
dDuGcG899/vMh7Qo87nbJ9W4mG07a7hSPwSVDO9boMfrzj6Q7eU=
=INw5
-----END PGP SIGNATURE-----

--Bxl7e1f+Btb9m17K--
