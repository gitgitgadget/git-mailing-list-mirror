Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7848781
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112689; cv=none; b=OEDy6n3F5XkEXouUQ57qPj3xfVuccwKU5cjVkMA0D1FtH7taSwGRE3UhiVtdu1SerEtKVPBIAx/5A9kkaTjfbd+S29YTaFAsrgwhUIYwFIb1EKmWZtSuZ9QwmmH6rbVK0G3d/7+qk6M35kj+1E9WaR6CIy5jkFZz1iB6ovzHkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112689; c=relaxed/simple;
	bh=LNMSPg1ZIfT5fVCN9oWt8S/qrIHiJN7yfCmEW6Je7n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHJbjcDf/FHg0AkcDn2FWRrp+tZq4GNC0uJUM4GN+PjsAavFpo+UII5JIWd6B4HorWaM/kAEI3EWzqLHvLVBiqGB7s0ihdRyu4wAhrRO3suoqfF2dpuZIO3gLrxePhOp4AzMiSTHhGbzZsP5lZPFYSDmN/b2saqc5MaflQiD3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KBvbjm8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sKddDVU3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KBvbjm8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sKddDVU3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 353E513800E7;
	Fri, 22 Mar 2024 09:04:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 09:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711112685; x=1711199085; bh=LNMSPg1ZIf
	T5fVCN9oWt8S/qrIHiJN7yfCmEW6Je7n4=; b=KBvbjm8ShQsVwPFf1WM77QsRy0
	q/npDHRDifZsPGhaY/fHHwc7yMkwhyNKMtWX1KZw2AzriqwpTqBpCbswGXituoOI
	0a7LyYpyAhk01TtvslwrFVgLmLKIBLcnjy+/nezwByp7EGJwfsDJk9kdjfudN5g7
	3NbF6FXgf6cUebFrYevnVzFUvZz0mVMj3DanyVJ9XPZsuP9zUqKw/xrTqgg2uNlX
	mFVLLiWcHrgQ1wYCtwl0lDr9OmgYJ16jnbdafT0AMGjNdPJ1sIDf2KzPCX0UR9Ns
	WM/8PrglkrZ/P/vjZuI5YfD4gnFiiYKfJdEG8K2BYW0RqpyFagR5zQ/VynXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711112685; x=1711199085; bh=LNMSPg1ZIfT5fVCN9oWt8S/qrIHi
	JN7yfCmEW6Je7n4=; b=sKddDVU3PK7latpXs0xXGMt9/XDbLSjrcm3UOuoyfTI9
	DTfTAnf+uE+V3cRy5ZKduelaLXbhgpLCH9AvxFqYl6bpOKhk7emKqiGzhXN0x+W9
	9w9oN9x6mpUGtvCbS1TPK+4Hj1Ozk7HKKfV6bjpiCYVkh09tpcJXUWzA35HG4HKR
	uSYi7woBbRrzlTCv7FWGU5U1tXxAcyXCsCDeKninwTT3/+HtNv8kWoJIqERPfNEe
	8ZR+cy/fY2Id4vWN4Hc57DVQLwonWYAsTtsinW9JVfrYNz4ha9S9luizeBZc3wjh
	vQlldzWvdSlJLv00ufKR/TEgaTqC7mqyYUURiVLF5A==
X-ME-Sender: <xms:7IH9ZY9fOainzizkzXI4RzFACJ5Vd8_X97siT5L_lZijHWvsqkMY3A>
    <xme:7IH9ZQtGEo4p1O6QeR2Pkctp7R98eLVCE96VbLfvu3JVEDDj4wmTJfSXuzo7Kilya
    JQFyD4VV7luuVP1Jg>
X-ME-Received: <xmr:7IH9ZeAMOvzxNUuoKtqxApi7Bowhd1YTzm9Z4PWtFQDRL55bDMlWrKAaNsUYtNzflQpEpa4P0z1OGOFpD5HSUtuyLnhzPmVwMHjazRFREBf2zFNOIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeltedufeeiuefhhfeijeduhfelkeektdfggfelueeiudegudevleevhfegteet
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:7IH9ZYcnrO-a8hSqJLkXk42ek43jLRsrxGFI32B1j3mKHr2nwCk9-A>
    <xmx:7IH9ZdPih3YOHZLwG98YqfBnxbl3TtuXZ2Fh7BB6d06T_JyMlC2vtA>
    <xmx:7IH9ZSnCDyMw2gFKvkDIfM6eoFPAmiCn-xDiSWtBgsVb36wxh5m2Eg>
    <xmx:7IH9ZfsSkBSfpMverKJ1K__RUKXEmUIE_gtrflUQRLtMLGCnREEMew>
    <xmx:7YH9ZWjtBYxe85GIUdkWQ9RrUq7XDujcNkXVuhmdT54YLaK7Ib2bRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 09:04:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f28d2f9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 13:04:34 +0000 (UTC)
Date: Fri, 22 Mar 2024 14:04:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <Zf2B5oksaJRDH5WT@tanuki>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
 <Zad1S3vCuv4KYIzx@tanuki>
 <ZfwY_h70OeuRT7mk@tanuki>
 <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
 <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8xu5b1RpPYTcM+Q"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>


--m8xu5b1RpPYTcM+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrote:
> (Sorry for initially sending this privately to Patrick.)
>=20
> On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
[snip]
> > I'd personally rather go with the latter, mostly because it matches our
> > git-scm.com domain. I also like it better than the current git-vcs/git
> > because of that.
> >
> > So Chris, would you mind adding me (@pks-t, my non-GitLab handle) as an
> > additional owner of that group?
>=20
> Done.

Thanks! I've set up the repository at https://gitlab.com/git-scm/git
now. I'm coordinating internally to get it signed up for the Open Source
program that we have at GitLab for CI and mirroring functionality.

For any of the stakeholders in the Git project, please feel free to
shoot me a message with your GitLab handle so that I can add you to the
group/project.

Patrick

--m8xu5b1RpPYTcM+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9geUACgkQVbJhu7ck
PpTcPA/5AeayVzwUdhafwe6ysugSy0cH/l4cVHbghAtBoLB4yM4GUsSrzJAl73vn
QWEbo28twfA4Z5v3d3HpIPV7PHG1cVzTRtcLbuYv9KkK+hOCMTZqWGQRFqeKtNLf
XKNaY8/yI13Ay4IdseCi5pV7n4P9hSRcyYl/p1Aq6qGcVTktQGke7Llme0orGOtu
5D0lbAv085K8SqmHOqlIIViayQtK8EuG5ti23tkCTrCjve1NuzFqIZsZzLQzJirn
Uur4J0C9QAVMiJCntB35966FIJ/E5rhwxd4UdEzNhqLahprsLl+PwNUDjBIhHlZl
aWnqonsn0+ewmUifXW8lGoxBKtpNOM/+u1jdi7SGKKKwKJvIQBlAwUZYyuEfsjZy
HcgaT+pYGALK7nDzZVFxi4J3GfcdDLTTZ+FX6+fMHPtf743PF9B06Dk02DD+VG/r
h4G+XDP6KY3pMWYmrG+74VjGVyVmq8j2ZCWfZyuPamufNn2gCFXGyzgoE0G1SjPr
wJzzlXXGervK3zXTI5gvHdtCxSePrX0mA4vXAeAyxVP+3LWip8aNTtW0u9WoqIb8
dSWd1yoP9hEfqdPRuextNI2qPkvLQyBk70CZUv/4HCf85xwQZXGHu+r1OIHVTC1S
3QSXSo+O97CBHH9KmBIljnSergUgUvW+LXizRUnXL9jiU586g3E=
=AU5r
-----END PGP SIGNATURE-----

--m8xu5b1RpPYTcM+Q--
