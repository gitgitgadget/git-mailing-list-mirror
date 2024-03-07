Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73312F393
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828663; cv=none; b=qfCUAg9KKdjiw5ZcFPm7NU2yi84rJm3SZSA3L0c193SsNoJ/2276uJChEcQAMuyN9UM++vt2ckam+WwhwGcWfjnGponYmWBjCGuWzQ3kiiTXHvtSeKZheDThLP3Pv/FBnkiHNpcTPLqm/IAna7xtF1oMSx2ou/s3JNfpAb7AEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828663; c=relaxed/simple;
	bh=Ih9mmjv33nAP5gjnIKpV4choKM76VYicdy5ZWzVUeO4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHpx2P67A3hCNUaDL2/SHWZSyvLZdHMJkh2WVJt2Y71H1LeG6+lSKTCaOhfxMQYfAYRr1xhH2t2FfzmPRX+Ri/F88QpVVBXHSaGLunOnrS/i4Mnu5gRbcJeBBArIiSVuB3rrZCHkfo6eCiOAx6NedUr7MaGG3X/44eAuR+SWhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fRo16aOP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2oRO44Z; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fRo16aOP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2oRO44Z"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 554331800070
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 11:24:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 07 Mar 2024 11:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709828658; x=1709915058; bh=ekzuzGZve6
	nE7gB5Ed4fs+Jlacd2W9Su4ESse6f7WHc=; b=fRo16aOPkv22vtmklTi5SgV8y2
	+c11ZZ5OUWxAU8neo5OE/UJJlg/krbuQ+YuseHDyNafAcmx0PlTGpV4ZMlJfJTbx
	9FH1oJkna0ArumNoJutJUNRs9efNAp0lAgWmYX7IjXn9jF1mAAWrSip1Wu35bL5F
	RIBM0MpPIDarbl7Q1noxxP2QcGAW7EadmgMGv6Xy7zHjGlHVp5RBrTVNZdbz00gz
	TC0B4uwdPFOipzdn4fPr86hGF8/YZFXOPAfWOnqElZS9PnA/EfqhDpCHLKmlOTfR
	vhj4uv6NhvMUH9/z6pY+F3aQtWgwdoUSS4DsQoqvd3Ybca5C7DxabGwxtghA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709828658; x=1709915058; bh=ekzuzGZve6nE7gB5Ed4fs+Jlacd2
	W9Su4ESse6f7WHc=; b=E2oRO44ZUH13SS6Bj1ZZKTCd80NIx22tQ+1xEfwO4b8b
	pitp7V+H+Ryaj3xf74v1yzhda0BEEaQAkiORvap/UkiRl22AaHfIpqq39GUrBT3C
	nzsLR23s7ac/26ZYdsY1yb/akJluAnh9qU0ZyVNBMUCErr1T4HJoZdYP7gnLA3Yu
	m99vLHc/T+KI4ya5rCFevgRTfKUxuzelUBbTLkFAouujy+uT7kiSbeQApaknAu3X
	CskuH5BYhWSxs5msQ5EaM9FG5cElZRfW13rYD+wRLfj/wBRsFvQgsMtP0+R60kQ1
	XtFCbTfJJ75NNFJK9qoklW7PSdikp5GIb+wu4elGoQ==
X-ME-Sender: <xms:MurpZRiIGGCyTDx8KRvOLrhf5VufZtPX44-Weh7ekeT79XXYSG_GGA>
    <xme:MurpZWCezYL6pbwhZG5SGd4r5wVI3LED3_T3sYWTyHgddLI_VjbXn9esB1nr3To15
    Cpmb3n6xTxpgTj2yA>
X-ME-Received: <xmr:MurpZREHt6U949iOrBRmHZgW2f7_ZE2ne5lpgVoQk-qzCbTY5DK1C15Cxfr3tPFScd96BcXKOOhNcOwH83IjkedNsIXrEvdJev1dG20DiTYxNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtdorre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeefvdfhleehheelgeehtdevieeikeffud
    evvdduteefffejffejleelfeevhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MurpZWS01oVxFlAcmSIpe9Do6grMhaqxumF0vNZwzuJ80J-bbsZWtg>
    <xmx:MurpZexq8CI-rAxGbtaP4cVl6Qui5w8XNjDF0LJ1TZK0LrVBBmlzSA>
    <xmx:MurpZc4q5JqYPS6lD9g33Cz7Oh9GAGE0pI-N1QTvGlqOLvV6Vb8rCA>
    <xmx:MurpZTpoguS1hdgnGf2lMvPsvg84uXP1PJxkeEoPfzo0RofkQbNN82CU0i4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 7 Mar 2024 11:24:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18b06940 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 7 Mar 2024 16:19:44 +0000 (UTC)
Date: Thu, 7 Mar 2024 17:24:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH] reftable/block: fix binary search over restart counter
Message-ID: <ZenqLgfSomVlYDwh@tanuki>
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/6fOGWCh8iXtEGk0"
Content-Disposition: inline
In-Reply-To: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>


--/6fOGWCh8iXtEGk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:26:38PM +0100, Patrick Steinhardt wrote:
> Records store their keys prefix-compressed. As many records will share a
> common prefix (e.g. "refs/heads/"), this can end up saving quite a bit
> of disk space. The downside of this is that it is not possible to just
> seek into the middle of a block and consume the corresponding record
> because it may depend on prefixes read from preceding records.
>=20
> To help with this usecase, the reftable format writes every n'th record
> without using prefix compression, which is called a "restart". The list
> of restarts is stored at the end of each block so that a reader can
> figure out entry points at which to read a full record without having to
> read all preceding records.
>=20
> This allows us to do a binary search over the records in a block when
> searching for a particular key by iterating through the restarts until
> we have found the section in which our record must be located. From
> thereon we perform a linear search to locate the desired record.
>=20
> This mechanism is broken though. In `block_reader_seek()` we call
> `binsearch()` over the count of restarts in the current block. The
> function we pass to compare records with each other computes the key at
> the current index and then compares it to our search key by calling
> `strbuf_cmp()`, returning its result directly. But `binsearch()` expects
> us to return a truish value that indicates whether the current index is
> smaller than the searched-for key. And unless our key exactly matches
> the value at the restart counter we always end up returning a truish
> value.
>=20
> The consequence is that `binsearch()` essentially always returns 0,
> indicacting to us that we must start searching right at the beginning of
> the block. This works by chance because we now always do a linear scan
> from the start of the block, and thus we would still end up finding the
> desired record. But needless to say, this makes the optimization quite
> useless.
>=20
> Fix this bug by returning whether the current key is smaller than the
> searched key. As the current behaviour was correct it is not possible to
> write a test. Furthermore it is also not really possible to demonstrate
> in a benchmark that this fix speeds up seeking records.
>=20
> This may cause the reader to question whether this binary search makes
> sense in the first place if it doesn't even help with performance. But
> it would end up helping if we were to read a reftable with a much larger
> block size. Blocks can be up to 16MB in size, in which case it will
> become much more important to avoid the linear scan. We are not yet
> ready to read or write such larger blocks though, so we have to live
> without a benchmark demonstrating this.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/reftable/block.c b/reftable/block.c
> index 72eb73b380..3d7a7022e7 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -302,7 +302,7 @@ static int restart_key_less(size_t idx, void *args)
> =20
>  	result =3D strbuf_cmp(&a->key, &rkey);
>  	strbuf_release(&rkey);
> -	return result;
> +	return result <=3D 0;
>  }
> =20
>  void block_iter_copy_from(struct block_iter *dest, struct block_iter *sr=
c)
> --=20
> 2.44.0
>=20

Hum. I noticed that this causes a memory leak in our CI. I'll need to
investigate.

Patrick

--/6fOGWCh8iXtEGk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXp6i0ACgkQVbJhu7ck
PpSW1g//UVxEXUGo0uxngINA9uIc6uwcU6L98CKSO4ebzPubE9g6++QKnCoJjy+H
3ND6ZWCl3BJlko8ctInK+DZNikNcZ7ARvOS+TXS/9psXZssBL/tuipTMe9Zfg/Um
6dhIISUJlmDWTxIQsZPC6t2UQZURALKGtAv0eW5QHt+jfLr9brUre/GDolPEfgjW
EcITVKRoY71B1Xo82Tx1camC97hlfPe+PEX5qM5snbzGtSdTeMvWxdAUcrvnMA4s
4zmsTnzgPyv48kLmiNzj4bXpMpMOOW79zB+OyiGIOciG+vFyJYW2P1MsNmDCltzi
AUWOVTRYudJS5cWchc4iLzpEBWGKgoYn9721mBx2JzWPiuxs55NBPshukkbGfixL
ibhlyq1oCXDuTugK9YeNokPkoAuNxMm/AZrlD+zY26JMncl2il2GJ5W/mliH7i5M
CS7BeQxP/QQpNh8VQ/SOeJ4juAKmcdS+02RKcSzHKp/3JAuOGEHMkFXyRYIECXlx
DERHGCzYzPzxxVq2xL/TIX0mT+FmkyATHreEkO+gEx/LJzTGr+/n/eIqIsL+601x
4kPf7vFvQ43RQWYWT4cseooPPdxt1lx1ITr9RyD74I3+iE0zIyi73w2Y8xS8VfwK
y8GlhYDGoyFXGiRJ+5mFNLgqh7ssEsteW5QXgKkJrpwVr27FLIE=
=ZhiC
-----END PGP SIGNATURE-----

--/6fOGWCh8iXtEGk0--
