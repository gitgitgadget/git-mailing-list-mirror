Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868E81ABF
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864645; cv=none; b=eg3txaOrZ0MMXpl33CKQwL2ppmG+HZyprSCLSz6FlNL7hZgkFvV2OPsFeT3APK6BfcTRdd6SNxJWpaHAyj4sVkbXXvfL2ywSNoqtlTKtn3Rd3DimXFgaUtWzQlyp/EPY9rXVIGY9vVPvmwk8tD9d6mnfFFCFSmBTf4c/YG6U9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864645; c=relaxed/simple;
	bh=lJPcXfLZ1wohfYataKurbXijoB+82WPfI8nRin7yvK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcrgIojNTR4WuFAHRqSXNi8Me0w4cjN5Stn7ZNJz1IFBAbJ5/MOr39p7JHL+esTuq2aE/OXUE7zAVF+OF+tPGVdcL90AkZgyu8C/t3Sgnz/JQiBfPewH84Z5LXQVQB6rO36ljE+1y2JHy7DTJKEaZsnzsfMWRAl2qG/hjADsCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TxiOJ+3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExvvPSAW; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TxiOJ+3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExvvPSAW"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 4C95D1C0008C;
	Tue, 19 Mar 2024 12:10:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 19 Mar 2024 12:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710864640;
	 x=1710951040; bh=om7FTHkp0JJ/nZPFMJI6+/QetdfAMSAk06Vo2R8xyc8=; b=
	TxiOJ+3eenLexas8zEilV/Tw47OztPOx1IYdq/2EUcZVpg7lYFxSa00hV5UbdTc7
	13RTygCrVaYl8XCKwr/QovNiyCveA3+33hRRo2WmXxxBastBk4g1lJSsz4i4V2GS
	TgOkW38RG/KBbHbJbxoMx2v5/LQ8bNwRtomd/kSiBFV+/ZPu6yhjBoRaPqTpjd8V
	4eWDz5AtvbdvQe0LszsoCjDrvao3BwTiMEwJwrxYctjhLv9eFej+3pitY4Odaft3
	dPzI04PhgEU9/kojcRB+nrN67i1o9+7kccIZYN1D9qFASwC3VFIepbH7n0pD4CVK
	Em1pFUX2rgcf0uRHI1NVHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710864640; x=
	1710951040; bh=om7FTHkp0JJ/nZPFMJI6+/QetdfAMSAk06Vo2R8xyc8=; b=E
	xvvPSAWvxkSX3ZZWQ8/iUyYLY+xjSiFYLeDnrn5VaqcgLpPtnomUSTxM0YRgUHUD
	lu4xP519T1C7mH8ncw3xQowR1PC8XYfCLyM/tDAjp4WEltPWu34Hi32hoYCQyjr3
	QhlOHO0EISww2woW82k+D6TkAgZfu40JOfEYjE2br1SrLb7aAnikWHj97Xf989Ne
	iKISFVnUFcfReoOXByxLMZ4Ya3n6JpdF9mtbJYnYLeG4gdm3d2wv13HMGdk7ixCF
	AGX729+FOV3NP+xN8Lt8fXNpvCeeh6CmRq93o9vU7eNnA3EZ0mZ2y0zwAYroz6DX
	FyrzNXYX4m4nsSzg4SLEQ==
X-ME-Sender: <xms:ALn5ZWdsqEDanL7wIXMq5bIug3bov9e7azwJ9pgxfq7zqS8UNXFrPg>
    <xme:ALn5ZQPOBGKkT2Rfn1IbT6tKBr_PqkLDRlyDMjjynM7p8peAL8y4t1T6DeTIi3_48
    5Ka1Lml78vNhYvQNg>
X-ME-Received: <xmr:ALn5ZXjBRomSaBofa6ywGmS3jGo2dch5JshR6PjIMN8E1f5HahliF1UOT8ixOlOcgcUUXFFXAvON-N0_0b1icYOP5At0HCgjcKeCNFA_w1jiiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdetheefjedtkedufeejgfehkeehhedvieeuteevteeugfdvkeeujeejgffggeef
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ALn5ZT-cdbRBGv7uQlJWVxB_xkOuGf5Hzn28rgfzIsTYMoXbn0CECw>
    <xmx:ALn5ZSvly2gR5XZmlTK1M1Md5gnlIYqrxHRQxQxiIYXzq2yXa1KDfA>
    <xmx:ALn5ZaHRP911RsPjXNqALLIbsSgEMZop_ctE5aHWz7Bh4C975TKzzw>
    <xmx:ALn5ZRN5jNucFJmqQs-DAG0HloITlbariifex-BTCeGvdzYGUaQ4sg>
    <xmx:ALn5ZUWJ1Qi_1ZOwhVhetT10MoF5evivz6O0hlKcXGmF73gG-J9CcpkOG34>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 12:10:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a68f1bc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Mar 2024 16:05:42 +0000 (UTC)
Date: Tue, 19 Mar 2024 17:10:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: "stolee@gmail.com" <stolee@gmail.com>, git <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 00/15] refs: introduce `--auto` to pack refs as needed
Message-ID: <Zfm4-jCWV81VyAXt@framework>
References: <CAOw_e7aEPE1QRsqsgvdBVGkk2uFo4e080wWbM5dsVwkiSpYcbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOw_e7aEPE1QRsqsgvdBVGkk2uFo4e080wWbM5dsVwkiSpYcbA@mail.gmail.com>

On Mon, Mar 18, 2024 at 11:14:58PM +0100, Han-Wen Nienhuys wrote:
> I had a quick look over the reftable bits of this series. It looks OK,
> but here are some comments. Nothing blocking.
>=20
> * reftable/error: discern locked/outdated errors
>=20
> It is not obvious to me why you need two different codes. Is it so you
> can print the offending lock file (so people can delete them
> manually?). FWIW, this was based on JGit, which has
>=20
>               /**
>                  * The ref could not be locked for update/delete.
>                  * <p>
>                  * This is generally a transient failure and is
> usually caused by
>                  * another process trying to access the ref at the
> same time as this
>                  * process was trying to update it. It is possible a
> future operation
>                  * will be successful.
>                  */

I just think that these are somewhat different failure modes. Not being
able to lock a file because it already is locked is totally different
than realizing that files have been concurrently modified and are thus
out of date now.

So the main motivator why I split up the error codes is that the error
message will end up being shown to the user. Before we would say "data
is outdated" for both cases. Now we either say "data is locked", or we
say "data concurrently modified", which I think is a lot more helpful to
the user.

> * reftable/stack: gracefully handle failed auto-compaction due to locks
>=20
> It's a bit unsatisfying that you have to use details of the locking
> protocol to test it, but I couldn't think of a way to unittest this
> using only the API.  Maybe it's worth considering removing the
> automatic compaction from the reftable-stack.h API, and have the
> caller (eg. in refs/reftable-backend.c) call it explicitly?

I think it's not all that bad. Yes, we now need to know about error
codes returned by the auto-compaction code. But it's still contained in
the reftable library. If we were to remove it from the API itself then
this knowledge would need to exist in all callers of the auto compaction
code which live _outside_ of the library, which I think would be even
worse.

We probably could add a unit test that basically does the same as the
added test in t0610. That is, we lock all tables in the stack and then
check that `reftable_addition_commit()` fails gracefully when trying to
compact the already-locked tables.

But that actually highlights another issue that we will tackle soonish:
I think that the compaction code should handle already-locked files more
gracefully. E.g. when tables 0..N are locked by a concurrent process,
then the reftable library should realize that and only try to compact
tables N+1..M. Justin Tobler is currently working on some refactorings
of the auto-compaction logic in [1], so we will tackle this issue once
a revised version of his patch has landed.

[1]: https://lore.kernel.org/git/pull.1683.git.1709669025722.gitgitgadget@g=
mail.com/

Patrick
