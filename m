Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FB15FCED
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319213; cv=none; b=qxXsp8vB51SC7iOnckxIYpccPgbScWlZseUIeKTKt1DB5Hd8wJSRX65FmwkHgVc1ynCn/vglqntoMS+dXAe5dfs/FbioIfD49vqIggcujxUrgj1BP+Dgaf4qKVXHfWtsJRSOE+GvPrbRqSW+A4PbFi/EdBfeCOXClYH4nLenWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319213; c=relaxed/simple;
	bh=NDBMks+tbz1aZhOQNsMpbhxCtnpEcrOKWVwnjaPww/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxi7Deb73eMnFphYM7mL12A4PWToBfA+Z17Px26pjeJ5+/v5WuZh2zRJoUSXQFMYLYQPbJVNkAr0XYA7plsJ3LSVtk47MaB1J2sFmLr5rLbUBA79bMgA2Kv4HPTq3pek1LiVk3jgyMi3I7G0du2Rd1rKdiXQz5fxOCpfnf+dkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W7py2Nxl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTegDRzZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W7py2Nxl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTegDRzZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B815D114055F;
	Tue, 30 Jul 2024 02:00:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 02:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722319207; x=1722405607; bh=qvpqUpge/f
	mr8QgX2HKE5dpFJdkbbxuQ0swZKh4pxEw=; b=W7py2Nxl0pSldRWWj1rMGq+Mwm
	AIaiin351zY+1ErLg/mf0oAyf0PR+quZj/ukPM0KSYI03eOk6zUgHOAyetnBgTXc
	NDtfNKkNANx/J40p4jtjFnSLOKyPNxSAMV3upE+okoeIkWfmzxeVGgRaF5lEfaab
	HJ+LhYx6r0XmbIA7hgpR1CMQkwc7Bndt1WL8DEx0AlV0KGLRiMj65nHp07tgHitd
	rMfLThAe1yGRc8BRgx8QVbA/c5b1N89Gm2x3hH/TRVwCamFF9DCZhZ6BV16/vwag
	Fw9GBnJqVZ87np2HFu6x+ncWkXYzjV5ToWL9ppa0Yzos6AyJGTwXtUZbHU+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722319207; x=1722405607; bh=qvpqUpge/fmr8QgX2HKE5dpFJdkb
	bxuQ0swZKh4pxEw=; b=YTegDRzZVtllEqG1ki3mzX546tYDZZY0xsFvX3TI9D8c
	R4nsnfY8HhR5YAV7tPDtVkO54b2i5oy3sB3JWm/lZOzql6d4vI54L9p5eoTQ+7H7
	QbS3YEZ/wZByaH7/WXc6aTw5DCiXE7HXwe/O8e1ukuvSn83a80cZb4VnDCrNNdxO
	zWMBYNQcJai72ivWSg90xbSKdxk5ZmO+o+hxbDOJgryAZbEEX0Ppwgecjnsv/P/L
	8SxLtN/U9BXxWNMIYpQv0Xi3B7de1eAHh4wmtJy6Byr89hIgxyRMPMbqX3KRqBhE
	/YkGPfrEP2Rvwt/GrdNKZ+yl1c7hPeF3MwS07xjC6g==
X-ME-Sender: <xms:Z4GoZuC5H-LAmDhmyhL9aKIrGbnYnm-oYKW2MlpjiK2FjZvoG41n7w>
    <xme:Z4GoZoiA96qbWVicXddEIKEnTL3DhpF-LsKX2pntW-ag6ZpZkVWnbAkppV6ulvNTo
    raibIn2vV46lbHrAg>
X-ME-Received: <xmr:Z4GoZhlCnI3bkCe2hm_tAVegT003HN7yBXQGHaPthyrRNE6gPxBVjerv4pYzSborGcbrm_ArPkGEP-PHCsZtl0JNZAI06QVycDLEFmvQcwewsdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:Z4GoZswG2pDPJF4Ash6PX0RE1p2Tet9OyEpgTTiwoWFJl8h5KxTaNA>
    <xmx:Z4GoZjTxQ_fPggrS_-RuzKXdNzG7e3TQ2-ZxolxsMTblI-MH84bFBA>
    <xmx:Z4GoZnYHeUdOTCXsX4n6KaI0-Hl649SYWY346FjJeuJHSmUPOV_4MA>
    <xmx:Z4GoZsTCodK7hFXa1Uns0buiHOMwN4yFAxwEES89eE4lVuULq2E8rg>
    <xmx:Z4GoZhNmF9bUBPcJlm7N9L7mx3OGvckPR_92tGNnkp6a6lSnLiULuWK_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:00:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 59e33d8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 05:58:35 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:00:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH 2/3] ci: update Perforce version to r23.2
Message-ID: <ZqiBYK2HwLRk3Kqn@tanuki>
References: <cover.1721740612.git.ps@pks.im>
 <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
 <da9c4d1e-0fce-3bf3-c35b-32704a8a2129@gmx.de>
 <ZqDC7O985AUUg3Pd@tanuki>
 <xmqqmsm6ydm9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqe/kb3SicUDHeww"
Content-Disposition: inline
In-Reply-To: <xmqqmsm6ydm9.fsf@gitster.g>


--pqe/kb3SicUDHeww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:10:54AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I don't think that is a good idea. If we stop installing p4, the result
> > is that _nobody_ will ever run the tests at all. The tests, and by
> > extension git-p4 itself, would start to bitrot and we wouldn't notice
> > any kind of regressions at all anymore.
> >
> > If we want to consider going down that route, I'd rather say we should
> > do it all or nothing: either we rip out git-p4 and the tests, or we
> > leave both of them in. I couldn't care less about git-p4 itself, so I
> > would not mind ripping it out altogether. But there may be users of this
> > script out there that do care, so I don't want to make that decision
> > unilaterally.
>=20
> Yup, I was actually interpreting Dscho's message as advocating the
> removal of "git p4".  Such a move would certainly force people who
> do care about it to come out.  It is up to them to volunteer to help
> maintaining "git p4".
>=20
> This may be a good example to discuss "support policy" not on niche
> platforms but on niche features (Emily Cc'ed).

As said, I wouldn't mind dropping support for `git p4` altogether. That
is a much bigger discussion though, and I'm not sure whether we should
just drop it at a "random" point in time without something like a grace
period where people can chime in and express their wish to help out with
the maintenance of it. In other words, we should probably deprecate it
properly and announce our intent to deprecate it. Both our release notes
and "Documentation/BreakingChanges.txt" could we viable ways to do that.

And while we haven't yet decided to rip out support for Perforce, I
think that the proposed patch series is somewhat sensible. I honestly
really only care about marking the patches as leak-free to help my
bigger goal of making the whole test suite leak-free. The other patches
that make the tests compatible with newer versions of Perforce aren't
all that important, but at least they help to make those tests a bit
more accessible to interested folks.

Patrick

--pqe/kb3SicUDHeww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaogV8ACgkQVbJhu7ck
PpQIohAAh/+pAZIzCQ/yackuzxDZ84ZVgvrOO9SK8nSxLm7lfQYONDTScR8gxomz
nxAf0scUecMRtu78wc46vGnhhe7HUsqm6QJht2rJbuAfqBA8eCJRmn+ae6UBWHTs
PsNgWCNcGWBfyT9IeZ7zzt1fTV8jdJSVkBNexwzuA6HTDrxnZ8CM49vb5tdu/y22
PzI5k+HFU9HSX7hd9pRYXUxKtuuCiCHFH15QEs3p1ZHHkBfc7vapeKJcBt8VbV5l
9PmqqmwHZH8bAf7f2RLLJUK1LdbtUGX9js1iWSp+61n9u+rOMYZuZYIs2ocvoqa6
eZm1kPnQAeFIe2qE97mcU/waAYzfOb8YczcnAesadKDhra1VIKvj0JpNVMFlcZPU
0iC/kLsiL3WOAyAG66r7tn/xMtDo0lhcwUiPJ+bm/KU97IOe1b7UNfRG+mBNwVX9
zIH/OJoH9UqKmeznsZ4AmhBGucf2UD8GByaC9SDBsYkXit5WES1KGcqI9mvY+NGb
c5pRqt4EVx3SKykHyVM3xIDQhbziaHGLRFlmVooU84XdXYKkMTJ86KhxeyC8Ry+c
KKj9PXTVY9TmPP0g8l0453hCmqFovmfKOBm2G8hFCZNMUMYSRv4GepP1JtUK/wnL
J2XjO/vhveLU7CD/KXs6n0iBdDiQ85gkAfODtjRqGT1INNPFGnA=
=axts
-----END PGP SIGNATURE-----

--pqe/kb3SicUDHeww--
