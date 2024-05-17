Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC51171A
	for <git@vger.kernel.org>; Fri, 17 May 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925914; cv=none; b=HrsSCHqmjR+roZIv0EvUw544mPVz2EW8brYqIKAyzmo6e97aCDDD9QrbCUe2co4JOFV05X3vN7ydoV6HdcQWjzdNMcBUSCV9/j5HKD2lHaX4kaG/bnQnnj+OJWmQ1JnU2WGveQFhL223bfIXe0XouHRg966c/hkDu52YobUDo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925914; c=relaxed/simple;
	bh=CFQ8CBpRkzfD1gdTpK/M46df/7m81K0wBsIQ0Rb5Zt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uObrwcjmF4OBfKIEodW4sIzx+Kuvxx6g02k3BN84AhCTjES7tPQpH8BKGoISqcPndb63DLm5eVzx8H4optnHKsdqFJSNupH8voJuLnVoxsraPwb4NriYKpQ7yLRXbmYwwe55CaAL4P2VAd9MpxXf2Ziioac3F+SubIFB2mBdDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qqPiRLKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+APAKUN; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qqPiRLKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+APAKUN"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 359B61C00131;
	Fri, 17 May 2024 02:05:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 May 2024 02:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715925910; x=1716012310; bh=QmE6Ms3PkU
	Xoz3h9x7D2SCAsJcnBhiI/RCh6nu4ltFg=; b=qqPiRLKO3PfVUcuBVruOSrOdqP
	+FsKgFlzO8RxkUu61Qz+adqt+w/QHelSlazUAOcaTMcvtnbJbxvuyl9OawWDD3aj
	seS+6WvQuC5nvSyBdQmhpTv7kfEHk3xpaPE2FDHJXpWdy6w5c4YIptW0ZxJGWn07
	LC75cK8qtkEYtY1yQr7d9Q0lyHmf4YHRzkfv6KTNHtEqbjUzG9ksO25+9BQVOybb
	zr/5JvM95sca3fTZ0qqML805/db2SCALekktFZM2yn8dcjTl2Oydl4tDrRFGbU/a
	Z+gQzz9Z/FEhED6BJHXIVPHCmAxDKY/pUPtCPWRj78eU2YSIzacJVtNhHvmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715925910; x=1716012310; bh=QmE6Ms3PkUXoz3h9x7D2SCAsJcnB
	hiI/RCh6nu4ltFg=; b=Z+APAKUNv2SZ98T0fd594/vqIv2zIRRXSSLVOo4KQRRM
	j7vHwShpAX+txOy6309iSru9X15g+C+gL7H3KIEi0/48ZDhprX/ZvStquzkpxxtD
	7nm1ky2CEpl8Wf4oVgm5oMOuG8+oPo3hhGLdMe84dfXPv4iYKOdcpw5SVYeYb4MR
	yoTWjuN9LWZFnThn3hcs8TDbVHdkM2u5itsGVRYYKtORrlqKwPEf0wOjXdc0KIpq
	S1E9m9U/onhVGNSCWV5gtmzE3XFx/fu+2hPsYh9xDz80S2mB5eYCyFMTAdP2rIYZ
	hM5UlhDtnFpM0ah2cnRHTt/rvA4x6bd6UYqw0Gt0kg==
X-ME-Sender: <xms:lvNGZvLD5HRoXg8VdbKKj0K1MhJsXZuYs4zkNBr995J8TrJJC0xAUg>
    <xme:lvNGZjL2gBR_vVglGruL60191S634KjMdrxE5opqUv-8yrr859nIDktujVy2KPXEZ
    mYS9osQ3d6IQs6uJQ>
X-ME-Received: <xmr:lvNGZnsXkuEE-A51PpHRPLIMkvDQ1sgpUNHY5knwG8J-fpI7ldEtsnjR0UwL1e1_tnL0PX2MN4JW4LFXuGJFEN6DQ2Rcye5RdhiHEMO-pbDsr0-CVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lvNGZobtk-AmgS-q_Yj0NE2zZwMVRIbSQlE7Aef69gG1YX9m0QD-bw>
    <xmx:lvNGZmZKLu5WXpx83ftNSUeszWIgrDtoYW3Tv0ljj5OkSeFnxxSx1w>
    <xmx:lvNGZsDte4tEvSHHSg_od5SNAoNvCgr9lnKIR5Cea_t_2PfX14W0SQ>
    <xmx:lvNGZkZM_NoP_v1ql8zyk1QDBM751r9jCmEry00J7Sawvs3u6dnzag>
    <xmx:lvNGZln-tUseS1xzG2tMObmObKo8mI2Z0S_ZTAwUFrRR6zqpySbJiC-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 02:05:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b5548852 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 06:04:41 +0000 (UTC)
Date: Fri, 17 May 2024 08:05:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] completion: adapt git-config(1) to complete subcommands
Message-ID: <ZkbzkYhJVO-uEeX5@tanuki>
References: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
 <xmqqv83dsqhn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u+WUi+1s9ykthEMg"
Content-Disposition: inline
In-Reply-To: <xmqqv83dsqhn.fsf@gitster.g>


--u+WUi+1s9ykthEMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 08:53:08AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +	local subcommands=3D"list get set unset rename-section remove-section=
 edit"
>=20
> Wouldn't "git config --git-completion-helper[-all]" work here?

I knew there was something here, but I just wasn't able to find it
yesterday.

Will fix, thanks!

Patrick

--u+WUi+1s9ykthEMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZG85AACgkQVbJhu7ck
PpRwLw//RioEz14IA1Lr8HbkoOGLKrWQONWHCnax1tI4IYdKJItEFmLSqSjFCdXY
taZY80NqKHqtkfqwD+eBbbN5HTjJS5bAWxFCWCD7PdLZ648bCx5cZ3MT61IcvS99
h4A+l6faWZ5jAR3wrCNQRaljWUZzyK6DKeUdoFPPZnjtjgvlKwQpNdanlANON386
bUYQ1QcTPZfNQxlykbQaML3NKfVePON9pEIx3EA8chjstEA2Zii/XcAAs2KQ/Lv9
GLhCM0I2JD7YYQn5zjRZ7svJI51S1nyzsE9emFWaJ+Tba3PBe2KfgjOFUcbzCyYE
G5QqEWD8RRPxCpXSoSWsL7VC8OPkTqctzrg0oNvFt3Cod81bLrx2DMXz8SEcEcju
sgB84fqCMu+D12aKtEWkPumnOPqZpsuj2y04627QHvvcrswgLL2jZBu2qhpv6qRx
m5cg8g8R5k6C14WCrEbQ6py3WhU3Emf+rOhNEAZRECt2sllCVz2DOZlJSK9+WtSE
eQYqCB4N5xGmhSBLHvdbX1EPYRNw9z3C2X5bdaRXuFifq4hf1yHszaOZakzW+6vS
1qgMpWSJTRp7qWQkqiH+0QMFAUpsdxXSyClV9XX4cAS8YJPVN56q+nZa6AL00LAW
nHseHFhx1bqr3UUR1QS2xShkH9iZvRPywT9U9R17pOSBEjkMbXo=
=Htzm
-----END PGP SIGNATURE-----

--u+WUi+1s9ykthEMg--
