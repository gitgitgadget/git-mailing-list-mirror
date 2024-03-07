Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD90139593
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844851; cv=none; b=rqyji9LCM/tEnTrZ2cfMPpuYhN1tJV/9OBtBCuDy8bnOjEH/7Fmm66q8mbiGgDBF/gLJZDkXmL2tb3FBR3WW6/8Y/YkPs2nSS/hN3LXcpIGJnlrw4bsznkFRGJMQihFi5KofWzRxaYVpaUp9ObZ1eTQbv82epgabyW/McGj6TPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844851; c=relaxed/simple;
	bh=HBABprgl+ar55ZJvKDB0sWWgBLrDQJcoiy6Js0mhKao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcBVi36EDD7C2+gYLUR9JiNmFV6aNegFMa+LMdrbF5voGxD3AInfFkWA23MfxNJW8ptFqMIAZigGPU1F/K4YSjSnivVlb0lbHK1nrNr2wV4qX7+4jU8yeSI7etbYT15oF+D/sUH+vWd6AfIH/wQqmOdvVw6vEM+t7D2s5A5QJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GWO5F1Oe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0L5wAnd; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GWO5F1Oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0L5wAnd"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E15BB1C000B3;
	Thu,  7 Mar 2024 15:54:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 15:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709844847; x=1709931247; bh=HBABprgl+a
	r55ZJvKDB0sWWgBLrDQJcoiy6Js0mhKao=; b=GWO5F1Oey8Wfk5eHCg+ccFYWix
	vEVmYL2Tx3k+7w7ylNaxx1F0vM0jz4vTkBQA9ygNlBKxUETfHT4D6WePT7cI+eDz
	FS02TFUdUtA1nnzIUj5Yv3dfWFefjh0sWEZwnYdhmydeiAfZYUHuiNpJruPp2Hj/
	n+qxNKJeomLg20qNr4b3+D1SU0X6z5JYfnhk6XIRi5ziM88U777XJpvgjXF51Pah
	vZQDwzyYRIMmoqBkje3IC8J3OKtwfOKOYP/ZmVveldd7yNbNqWWlViudn3DjuI4O
	h4ajfODPrwK14SbUE/wSYIaqZ1jhk9A3OvJOLgJwXEHW7sw3BEGAtici4iLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709844847; x=1709931247; bh=HBABprgl+ar55ZJvKDB0sWWgBLrD
	QJcoiy6Js0mhKao=; b=f0L5wAndOrfiLoed38WsduQyesW/V8hyLCes4gX5+z2L
	fMJztUbt40Ldx1FcjSBVkaznvVRhEw8Cj+YKFD3o9GDM2CrV9gAUppNKDXjamKW/
	0UYa3rZpG2tkWPEslNcPbEuFGd5FZCg/ufjclX6fuMhIYSmQbxd0VWKJgyJFiD+O
	MFiDA6j1lC7fVtJZG4qQp9SJMOsdas0vGuKRGN18l62cs7aeb+srLNDl3q7zlzr4
	ImWKn77ZDS25GYXjK49b606nHNKtfkb1rLmMRLwdL+esCzU9+gWj5xUAC9ruL1MO
	kwwwVM+AuwKkqNod7djIwoVq+akWlvIuamBBVANP3A==
X-ME-Sender: <xms:bynqZUsxwGZ4F5MuTZyVHeAJpsvEap3xJ75EBw2Qlr5htJ0Ds7r29g>
    <xme:bynqZRd7OC81H4thuZ-EgbgoEE31hA7ykzehswqm6nP2xs4hDxR3VX26VrnCm-RkH
    RU9LOZGNkYNwbKY0Q>
X-ME-Received: <xmr:bynqZfxqNzx93yeBHaTogn3x96ukBogglIoQ30ua2_mXWJgfahV3iw2HHQ58RhEwn521fW8zlb9FRhUxLcOvGOsMln14PkKrB1KVeI_dMQUuyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bynqZXNh6to6KjJsS98dy-kL0K_LSMkH-kpJACnBYpH228NsJFSkaw>
    <xmx:bynqZU-UoJV3t8HjYkYgZfIE2NJS1Eyhm5tqPw0Jwmtngznwz3MZKA>
    <xmx:bynqZfW7WLZ11hjcaIjekAxWm3bqmzsXwlrLVnxCs1ry2PTcDOWXzA>
    <xmx:bynqZWI8BkOkiN2BKwu2h_XnlsH__8y5TmsAi8gswzNbkWVDc6I275n-RQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 15:54:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30d16fa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 20:49:33 +0000 (UTC)
Date: Thu, 7 Mar 2024 21:54:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <Zeopa57o1fMxPoZg@framework>
References: <cover.1709549619.git.ps@pks.im>
 <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
 <6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
 <Zehav4V_8GGZG94Q@tanuki>
 <xmqqedcntj06.fsf@gitster.g>
 <Zelb8ldHh4Lnlh7Z@tanuki>
 <xmqqo7bpncrt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yVrwEM3J1Gxe3YpS"
Content-Disposition: inline
In-Reply-To: <xmqqo7bpncrt.fsf@gitster.g>


--yVrwEM3J1Gxe3YpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2024 at 09:59:50AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> I sense there might be some clean-up opportunities around here.
> After all, lockfile is (or at least pretends to be) built on top of
> tempfile, and it is for more permanent (as opposed to temporary)
> files, but it somehow wasn't a good fit to wrap new tables in this
> series?

Well, I didn't think lockfiles are a good fit here. I did convert
"tables.list" to use a lock because it's a natural fit given that we
want to use "table.list.lock". But newly written tables aren't written
to a file with ".lock" suffix, but instead to a file ending with
".temp.XXXXXX". This is intentionally so that two processes can write
new tables at the same point in time, even though two concurrent writes
will end up being mutually exclusive.

As lockfiles to me are rather about mutually exclusive locking I think
that using tempfiles directly is preferable. As far as I can see there
is also no real benefit with lockfiles in our context, except for the
mode handling. But given that we have "default_permissions" I'd say it
is preferable to consistently use these for now via chmod(3P).

I ain't got any strong opinions on this though, I'm rather being
pragmatic. So if there is a good reason to use lockfiles that I missed
then I wouldn't mind converting the code.

Patrick

--yVrwEM3J1Gxe3YpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXqKWUACgkQVbJhu7ck
PpRRTBAAlIDWjl6ZeAJ2Wh1iHMBoQMliNqYupSbeBaDUNTKm1x4+rRyb1Zyz0pJz
wqcFefVLKGr5L/OhhZ4kHhv3cFlDy1225P2SP5it4qea/oUBZG+NLGvFt3wIjla5
Mkqvwt/cZIsNl574MzgQcvaE4QntqeDPFgJgjVbr1AL8oKv3B0Li/4GMQLOAYmiw
adpz2GSMvLktH7GQ7dpEj2RUeHxy7gBLANodlmUHYzamgZLaJ5er7f9+9PMNVbBv
pbCYKWSJg/OJcRE8s4xDsv2+riZiGlF1+nkGxaV1MCYqXIRgG5Q7tbY7KPupyTYd
wy6JcP8gmEpvLRGRvN7mGy5Yr9q9fLEXUaiRHsFSD9r5pr7qTu1iRfayfH7Krepk
4KrkmgGtrVMEz5IIQaIzZRRaSKCqQkJ6Le+S4YQENWZV/P5lEHdCI48RGOdIeSHo
aey8nlvZg3gTYFWqLgghW9si2G5l8dDeYVrxLqzsXrtxlMmoVc67/R0dZ5uOxWH4
EQwnOfVx91995UQzY5Zu91SUMS0MMx+/oKob6VZrDPxturicYDoXMNCglRjoUEev
7peZ86Z82pQR5FaT8QXGh8SDp0j8gB3wQ3HTIaqtwm8KMX6byJO9COdwir0jDgkq
GH/FEOVA4PcvSS7Q1jWlEtf7zLt0wnxKhuWGT/t9pMO+iA7KWVQ=
=nWQ4
-----END PGP SIGNATURE-----

--yVrwEM3J1Gxe3YpS--
