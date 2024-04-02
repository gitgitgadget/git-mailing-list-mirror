Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA9199B0
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038937; cv=none; b=Q09tYXeE1V2Q7aJw6aQAGt5FRdHwgVntpDZRj2IEYWfxX2YsbOUAfyqHOGcm64XRPAGZNRZSp5dLN/yJ/2M8NYx7SpaclZHAruqTy5aXB3hg7X08gFa75Hvqyhsm5rHXChOIpJwGf1sBR1QwltCEh8De8f4K3G8qgfZjjxCqqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038937; c=relaxed/simple;
	bh=OnrFBsmsJOc+Wj/+yUs6n5k+03yBRfCFNDMoMU52NDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/soWi4hgfOyJN0rL7jYcGkj4WQu62+c7dHYsohbpDw+4hPAquOo7he+Cv18qkcrwQxHRbJUhh7Gqa1900MKhyMDiRnNdiqvdHDaycpiQL4Rc/rkFZ/et2yKp3+judxXkgbY9pz1+BFVTM4mTQ6wE3+e7+j04zA61Ocs1YKJCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=APAXaKmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpbMt0rr; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="APAXaKmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpbMt0rr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id F24ED1C00091;
	Tue,  2 Apr 2024 02:22:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 02:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712038933; x=1712125333; bh=OnrFBsmsJO
	c+Wj/+yUs6n5k+03yBRfCFNDMoMU52NDo=; b=APAXaKmke+8NrnyMtY8pCPDt1P
	/ENJ56ji7XKA95Bw9aoHTcKdzTIauFW0OhDTn3Cimn2CgBMnwGVHU4CAOprFiVOH
	Q8ftJId+7PmMkG6rFkD/Qg1LcGvSJNAG0p1tCyRLhSKBq0O2pJOkobqWqIBSkLOX
	L22KhTVJ17wASheIcJH2Nxwu1Fu4IuEYvYqb9GDP7abE8W84BtE1Vp40bZAat/qS
	iq5moe2bXcQHtr5bzaXhQXHcTkV4H/NLg0DWM9PxsPlBHm+jouTjpm1TFf8lWmMo
	a+ZxDc1DD7S4eptyLG6qdUu6F9x5ci1DVYCXOL45UV5Ntlfre96UWa5VIUZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712038933; x=1712125333; bh=OnrFBsmsJOc+Wj/+yUs6n5k+03yB
	RfCFNDMoMU52NDo=; b=rpbMt0rr35hnX8S8PcgKqQG3PTGFhjiA5WI3DKQmo15K
	S8GiO6snBiezjum4SpX8IsasZ+mZWxB4c6KLYnWJf0HOC2ym6Mr/3T42qFEJWQUu
	5qrC7MdTxqNDjit/1WLwGFBoguXA13nr9JZlNXgFabUFR0lqylPSUoaTGEFlNHe6
	rjDpWt4FBpozgICe9UP6Zn8bRSgGSaHY+5/6duhSyeKWlZv1A6sbOnJP5rmsX+iV
	k6x3sBeNZu6qYbAc9HTHyxVfmOd0QoJ6R9y0vv/NMWxRjRzaP6z+SQ79arrsEM9j
	ekdU01LMwA6thGFZ+PPaHJBiVHX0U7L7AEJaF6M+EQ==
X-ME-Sender: <xms:FaQLZvmBUslrcaIkYu3M3b9n31Qf3AMMi8N4fxbdxvjj_yiSrEfhtA>
    <xme:FaQLZi0paeBr4EmmQCn-FC5q9hMvkD6_nTlGyxpMMZfgptm0bzbhyyngf_rHpqWWG
    mtz3-zjg5EqFa204Q>
X-ME-Received: <xmr:FaQLZlpOofp0pIMLUGzUhCf-KuqORLSWdm9TBVBDaWo1le7CpNVD7t6vhc3eOEHM13tQp9Bza--H1Rof8WRxjBBP1IEgR7eXbAoIOT9CPIZo0k4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FaQLZnmk7i4sgrNPDc983WaMJPs7rMD3V8oaRGlFNNXLLvUxLVEl9Q>
    <xmx:FaQLZt2BMC0Roi_tT7tnhUWWyGaCh6ArzwsvZvx-BISvV_mtwnZI8g>
    <xmx:FaQLZmt19rB2G5r9kNnILooSGLtYcUsFQ3vfAAkNY3LFtj_Rfi2M7w>
    <xmx:FaQLZhWyr0GoReT5oRq448NKamd7KJTZ7Gbkn7Wm2ObiNIduDBrr3A>
    <xmx:FaQLZl88X00jcO2q39ly_-XR-7ScZn_u4w9PcB8lEZ_A3MhN_ER7hJhR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 02:22:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43cf6218 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 06:22:03 +0000 (UTC)
Date: Tue, 2 Apr 2024 08:22:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <ZgukEQVqOgqAIIVR@tanuki>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
 <owly7cho1eh4.fsf@fine.c.googlers.com>
 <xmqq4jcr6bx2.fsf@gitster.g>
 <owlyttkn61nq.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TOv08J3Nku5q8ROM"
Content-Disposition: inline
In-Reply-To: <owlyttkn61nq.fsf@fine.c.googlers.com>


--TOv08J3Nku5q8ROM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 10:59:53AM -0700, Linus Arver wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Linus Arver <linusa@google.com> writes:
> >
> >> I realize that such an idea is beyond the scope of a simple MAINTAINERS
> >> (or similar) file that's checked into the Git code repo, but I think
> >> it's worth stating as a thought experiment.
> >
> > As we already have agreed that neither of us care the exact format
> > of the file (yet), regardless of how a contributor, who is about to
> > send a patch, will find an area "maintainer" to help the patch along
> > the process, it is far more important to discuss and decide what
> > responsibilities and authorities are expected of these maintainers.
>=20
> I'm starting to think that the new responsibility should be as small as
> possible, and build from there. So the smallest bit of (initial?)
> responsibility expected of the new roster of maintainers could be
> "maintainer must respond to CC pings on the list within 7 days".
>=20
> For those who have more time to spend on the project, the next rung of
> responsibility could be "maintainer is available to review patches
> outside of their domain of expertise if no one else has reviewed the
> series in 7 days".
>=20
> I haven't thought too much about the "authority" part yet.

One thing that makes me feel a bit uneasy about the authority part is
that contributors to Git are quite often direct competitors on the
company level, as well. This never has been a problem in the past, quite
on the contrary: I really value the cross-competitor collaboration we
have in this project.

But I have to wonder what it can potentially lead to if we did assign
more authority to some contributors. Theoretically speaking, that would
allow for sabotaging interests of a direct competitor.

Mind you, I don't think this would happen in the current state of the
project. I'm merely trying to think about worst-case scenarios, which
may or may not be helpful in this context.

Patrick

> > The development community has been fairly loosely organized so far,
> > but I'd like to see responsibility and authority spread a bit more
> > widely yet still not too thinly to compromise the project integrity.
>=20
> Agreed.

--TOv08J3Nku5q8ROM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLpBAACgkQVbJhu7ck
PpQcjQ//U4qrWHTFDRvTABLByJAJlcAmhMRe5W8Q27UrIOqH4pcOBeh7+ob0g3xH
ud4Xr+E5LWqwiib+zfJt5YifvEht0eT3NTAnwX54z3ZLVnkkwUh8kBFanIwEYM9D
6xG37rI890WrqlS3Y1Bwsww79ELIuw37JPXQYtBS7HpCgm795eRuklMEg1ZgB/PD
cIhAqqm6dyaCX8fxe7JR728YwYc2BYKxmh/vBd0tAjUg+cki8TSIDSGp8Lzp/2B8
oiBpR9woIQuRuO10dyvori1i34RNLa7UX3JHHL2wfd9ug8sfc6OADufqejl9jbrw
KaFHVyzEunw7+a9qHk54L7vlXO2hTiUOhbqprn0SnojXNnUNso1bSLEYjTcYzvDc
Qu51GDpCwY4aaX+0iiNum5BZFHEOMaliZxKgTFyfbCd/izKXcvWz9C0mDWSigg9H
AGy3hWtZ6fZCQFsoYZ9psRmn/+C90K7YOOHDu6zr5WC68sEECMTKJg1Gs9Z9R0pJ
gMrko2UluoFB8CNiCRgyjzzRqdqEOYvkDrlvXJ/Vde1ZTsUcWyo04NLAk77Fv1od
IQbFI4ujVBvZs0ECMZSn9z8o15uAtz/rhxHOMNnAGs+36JMS7wmgOVfLk/vQ70cb
3WJ4uuRHSpAlHbjXIgVjgJ5nLOwGKT5u+uJg4rDx044P2HgkShc=
=wclN
-----END PGP SIGNATURE-----

--TOv08J3Nku5q8ROM--
