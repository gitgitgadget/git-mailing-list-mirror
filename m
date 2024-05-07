Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6B42A97
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055509; cv=none; b=FiHCUcgPPlitThXwRxyR/qe6ctBfAAsVphHqDMSjOD53o/RMV2UYFXM2WihR4wIT1CkY56CXtJM7LAokBRJglnj1/VNLi4JM5zLT4pBsn4ubGNE5UoJ02QCLU9ktyC23vMfAG4C40v9vis4/CT8B09w7wUqKJ5qCV6GDF1rx/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055509; c=relaxed/simple;
	bh=4yvBfRy26Pq6kS3COzDAkXVVClIH9wqNbATmwGWhudE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I11fun79j+VAYdnUy8Pn0KKTMN3IMhzmn/OfZ7f86fBVgec0wxYO0xtfxlJsqYJhynmfc3SHdQqay3apmn4/tgBWxoYpbNEKUanrSyeFt1HruQ+YBTmTiD0CRsmEgqiHqeOjzxRKGAGrG5kP9S+u0WWgVDG+BK3FIHJywZZw8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/btbe/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBscRIpB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/btbe/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBscRIpB"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 330961140170;
	Tue,  7 May 2024 00:18:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 07 May 2024 00:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715055506; x=1715141906; bh=zb2qa/NQfx
	6vGZkNIYKUmplkoK6YS0O2MhChoPbGPJk=; b=V/btbe/gSht95KOGaEa79EjldL
	sezYpOLoz+aKkRFTbD/YLwc3CIVlQ9+4Z740kzgsq4TzdNfuPPzS0Qt4zyTOPliH
	Fji/dzThSXcheD38peu4KmKtLLA0yIRogFWabkdZCt5iBURAD1b78TNEYUKfJdVr
	mPt6kQ1BzCOxO2c2SMol2JCFGwUWsL9aW7Y4LoVLbPstEw8GPYGGvC/vuiz85GLY
	4QiyCkhYtsY6Te3l62DH7Fv/Z+6EMY+YO7Hh/w4fJLsftlIrpHsGfBXE4J41XUEp
	wDhBonfwbi3yNh12tj4ybIeKU/pcdzyvSN23wCMXV6Uc6gO7PkJ6nDpSE0qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715055506; x=1715141906; bh=zb2qa/NQfx6vGZkNIYKUmplkoK6Y
	S0O2MhChoPbGPJk=; b=PBscRIpBOKlDpF97NPObJdgZTx8n62HzkDg9+B44VRZY
	e3CmMyV7uR5CqMKtjt68442CF71oYuyugRi8AhhRwSCJDxd+qq3VXakqwuyRR/Ol
	u3EQymczmv+h8kmDjjnhmOWBUha2lBpVTF45AcpWNoOySfvIbfWAcPAphyWdb8ZQ
	eesngnAmRWSCVHkvk3W5n/yRWmkPm5+/dXynuDuJp017m7Cam9lsptei+qx2zbGj
	XE8KwA/Xqj7psJURTDzMxMe3w+2TVePTCCgfNEIPHE1YuZ0HRE5IUUmz6bwPYwfo
	XzXwn0Pqjm1hby+LMTFtUZ7yCgan95g/zTntDVHOQA==
X-ME-Sender: <xms:kas5ZtfBElyLE9VeJzPnDFFxhVfb0mqRHi7nB2aHDpnSQfTvQ6PMUw>
    <xme:kas5ZrPOTXoQ81Ulb0xpzKv0HHrDST1kdMAHbE2KktmS5eDWI0eI0TCzyHcd_8zCn
    2PzP8WvGPb-D6sk6Q>
X-ME-Received: <xmr:kas5ZmgsOrl8fdmrA7GE_Hfte8WzYGdYoXY9XA-yoUj0r7-icdpQPiT4jpPrhJno-t0MsZCvWWyMKNAfn70Sp5J6Go68ahtsI0g1gwS3Q_42BQrnRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kqs5Zm_EbYaRtQThiBE6M_bgFDZlwed5QU-jji2tS661HylHgI_bzw>
    <xmx:kqs5Zpsh0G-g18lqplMussd1srJlLr4RuBq4H-PbMz70zlctIVaDhQ>
    <xmx:kqs5ZlEtmn9UhB_oF4OFjY7CYQ0AHbM2k4WZ2Pbb1meZp6IgJ-a3Xg>
    <xmx:kqs5ZgOjpVBkzuGQxHBn1gpevPGd_FNzJwuhSQGPVGG58OQkcj_How>
    <xmx:kqs5Zi6n5YsRuoa8k_vTcH5S_O2CHgiPd_9I14B788RcJDf6JOUbllGN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:18:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eba5fcc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:18:15 +0000 (UTC)
Date: Tue, 7 May 2024 06:18:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Git 3.0?
Message-ID: <ZjmrjMN-AxW9rCC-@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
 <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
 <xmqqjzkaanr1.fsf@gitster.g>
 <ZjiL7vu5kCVwpsLd@tanuki>
 <xmqqttjazwwa.fsf@gitster.g>
 <xmqqa5l2y6aa.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5pOinR7WAVLgfcUP"
Content-Disposition: inline
In-Reply-To: <xmqqa5l2y6aa.fsf_-_@gitster.g>


--5pOinR7WAVLgfcUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:33:33PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> ... I was pondering
> >> whether we want to introduce a document as part of that patch series
> >> that starts to keep track of upcoming removals for a potential Git 3.0
> >> release.
> >
> > Finally somebody has bit it ;-)  In the 2.44 cycle, I wrote
> >
> >     The RelNotes symbolic link says we are now working towards Git 2.44.
> >     It may not be a bad idea to reflect on what technical debt and UI
> >     warts we have accumulated so far to see if we have enough of them to
> >     start planning for a breaking Git 3.0 release (or, of course, keep
> >     incrementally improve the system, which is much more preferrable---
> >     continuity and stability is good).  End of year being a relatively
> >     quiet period, it may be a good time to think about your favorite pet
> >     peeve, to be discussed early next year.
> >
> > in a few of the "What's cooking" reports.
> >
> >> There are multiple items that could be added:
> >>
> >>   - Removal of the old syntax of git-config(1).
> >>
> >>   - Removal of the dumb HTTP transport.
> >>
> >>   - Removal of `info/grafts`.
> >>
> >> There are probably other items.
> >=20
> > A list of things I can think of that I won't be the primary advocate
> > for but I do not mind too terribly if we had champions for the
> > topics are attached at the end.
>=20
> Just to avoid unnecessary misunderstanding, as I said, what I listed
> are not my proposals.  Rather, take them together with Patrick's list
> that they are invitations for others to let their imagination go wild,
> trying to come up as many ideas regardless of how good they are, sort
> of the initial "brain-storming" phase of a discussion.  We will need
> to cull bad ideas, pick good ones, and refine what we are going to
> implement in later stages, but this is not a time to shoot down what
> you do not like, yet.  It is instead for you to add your pet peeve.

Just to avoid starting this discussion deep down in this thread, I plan
to send an RFC-style patch later today that proposes several potential
deprecations for Git 3.0. The intent of that patch will be to trigger
discussion and it is thus by design going to be controversial :)

Patrick

--5pOinR7WAVLgfcUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5q4sACgkQVbJhu7ck
PpQwOg/+ILTz69DK7CXTH48CmOe8Aw0L+xl4bUFxMcHGTzUsEWIGM8GZ4SHGqQ13
DjiUkRy5EAcsplHHlVDNgGirzbPL5TvLCpd0S/GO9pVbZYtp3DhB7JY8gvMOSM5o
9xQEJDv9FDjrgyVAQcz+OQcneQIgULVGjL8XRetJ5tHzoV8nKe+ni8dZR6FghoXo
J2AmWzWYUNjLlDCBlc6sU+Myq1EdPddkyU+6oan8cSjZPLNHsBKcgPfmixh1xbBa
kl0jUc8auzDN+svdYKkca/4fmVxve9jJVECmcsqbtwOprg3RAXfi9L5uktn3Ec7h
OBCWk9/ZEVvlta29L4akNIzDlH1Lo0pzpPDnV95EXUFf5Ps/zF4RZeH0lfyj0Z1M
M/zXnokhY/QsJAi9hfHIlNo87ChHBoA8IHc75eekjvSnxYHbokgKDWMW27vspERr
ZGt/ds8ddA8P4clxsaCExYAwlQ6doExEfMq4XWa7c4S3UBIphhtzazOJoz/ABKnr
ZPRHSCmrKGhqBC+iB2Ea7WtFIILI9MJ+C4w1clHCU6Z2DJxBOFzIfA+66MPec0td
3QuSnwM0O6K1h/xxGGDcyLWqn+uLV6jGxUBHsMsLtbyH7jtxJIB+EnV+EI4kHhYQ
+MTInnl9sT874XQ5Zx22857CdpfZd888lj0SO36cTzNzt+4I9aY=
=fd7N
-----END PGP SIGNATURE-----

--5pOinR7WAVLgfcUP--
