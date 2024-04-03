Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63620136E1B
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172629; cv=none; b=cKcEB1WCOkVIlKW75RdKbH/BY/Zrl+hZSnycP813GW3X/kgm5fcrJZ7jnXR53nEUcfm9BnJSB1RaxLM21OjjdsJkh1NEzRgiXxY4JthUWmrPy3w3gesD3p2tfZuFBiL8m+PzvYQg3szr8MYIF99I3c41wLUw5wApraBT2Yham98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172629; c=relaxed/simple;
	bh=e+EKHHw5hOwFZZ75uu1vLlnhPcUMEh0TKaHkxQsba2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsXYEq5KckYYKLq12AoqopjfR9+5GnJe8V7L2kBTD+wAaOd9svQJm5/xVLxVERarOqZa9E29FoXIux4VQr3LbbgqrkP0GAEikWCpJsguFyAtNXw0QGyg93ytf7DNiGkdgpopixd4gMofe7mC7EFUEhxR9fX+iRIKa5557SKK7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CQJIWAJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EedqGjl0; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CQJIWAJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EedqGjl0"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 2E1B71C000AC;
	Wed,  3 Apr 2024 15:30:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 15:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712172624; x=1712259024; bh=//AmpRfiXz
	JfBMNzsJn90J+VB+nABo+CJg7dfqsxMWw=; b=CQJIWAJsb9Pr4vzChour9Nv3cE
	Gg+X8D4tZgIFtU3Z0i6lJSFcM0pJyzTDSAeQJMGYzqL0K+pafYJ7VdwExkxS/JHb
	F5TB4sDX8jH4dFKndY8iHjnla+Pram6ASh7l6AvDYCgB/PBFBzDL+KxX939HXZbc
	wPocutyEg1493STr5bYYXnT26QlAgljZSCX0aBX70+40hd1rIs0gCO7BfENNsDPj
	5QT6+jho8qd7zXQNfZ/s8fY9yfhuoeu4hxLhievd/lQdAV9M86t9FJuy7bsdawSR
	z9FjdxLl+w6qqDpEbepUI7KYlkIDU4gjUtKfOKdAnyKsbZpKCf2B2ztRJxFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712172624; x=1712259024; bh=//AmpRfiXzJfBMNzsJn90J+VB+nA
	Bo+CJg7dfqsxMWw=; b=EedqGjl0Ryfnq9+83UR4iGuYX2TOJoqYLNZXtp6HxcK7
	uZyvTlU1UcmxqUsLYu3e6TCXgAYLE1ERdtBkE1T2468Pwfa1fnN6C/gLKq8upDZQ
	bBtv/nazZV7CNl8VJ0cXNIhv3jwo9XO+bqMgskaq2mQr2n9ogI0eYroHEUVkvPSa
	YVvpdvqINgUZ2MVviM+/P62uNHDfU93LnQeTHt4eAzZpyUFqOhn2HHHj2shCOJkW
	4eNvHsT2FSZwSd5l/Yzj1BInb3jWgdR8gaNjDWbZgFcBAz6aysY4NVtyIcRMBR/A
	mU3UpBWdYzxnk3GWlho3ht5day9zWeRXcOCxlNVklQ==
X-ME-Sender: <xms:UK4NZhZK0hJjjCWpUlK6nBotXyWY7UN2W5KTJ2Z1vP5hyR_svQHlXg>
    <xme:UK4NZoZrV5rwKU942WfOCXjW_xZoo5ahWG2OVWAQaUmfZbzZNY5YoCdtWzgeXSmTW
    TVBlW1qBoMSGdduTQ>
X-ME-Received: <xmr:UK4NZj-Eu4yi-umOd2SqjcWsHSgI_vlZnrC1WiO3Yz0hFPWqkCwU-iLmL7-oha2A2HA9Pdc18LlkVsS5dZwkzlDH-qR-x8hBK4DmcflKMzCDIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UK4NZvpUnzVhPwFq2ox9D8xN8DFAQac5FKlGBaA1t-tSg7_x8nS6aQ>
    <xmx:UK4NZsqO61m2w0VxG2m17iiF0Mucdj9zhMUvnaeuo_eC1qgdlfb7hA>
    <xmx:UK4NZlTkszp6QS1tB1GX4NxDDyyNiwhzM4PaPFqJrIzirmY_Yiw9Mw>
    <xmx:UK4NZkpByWUrZmuQJsyz0O1jNFhCPcLSK66C62BrBu9MB-LTySqhag>
    <xmx:UK4NZhDV0fiS9T4kTO3QFKqCkNxRLDGGhfMeHYnmb1m7MqzYL3aaLwjZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:30:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d31ac72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 19:30:10 +0000 (UTC)
Date: Wed, 3 Apr 2024 21:30:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Message-ID: <Zg2uS5JXjQZsVZhJ@framework>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <xmqq5xwy6z1b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WmYAE7HvXqCv5rM2"
Content-Disposition: inline
In-Reply-To: <xmqq5xwy6z1b.fsf@gitster.g>


--WmYAE7HvXqCv5rM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:12:32PM -0700, Junio C Hamano wrote:
> "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > This is the second version my patch series that refactors the reftable
> > compaction strategy to instead follow a geometric sequence. Changes com=
pared
> > to v1:
> >
> >  * Added GIT_TEST_REFTABLE_NO_AUTOCOMPACTION environment variable to di=
sable
> >    reftable compaction when testing.
> >  * Refactored worktree tests in t0610-reftable-basics.sh to properly as=
sert
> >    git-pack-refs(1) works as expected.
> >  * Added test to validate that alternating table sizes are compacted.
> >  * Added benchmark to compare compaction strategies.
> >  * Moved change that made compaction segment end inclusive to its own
> >    commit.
> >  * Added additional explanation in commits and comments and fixed typos.
>=20
> Has anybody took a look at recent failures with this series present
> in 'seen' [*1*] and without [*2*] in osx-reftable jobs for t0610?
>=20
> *1* https://github.com/git/git/actions/runs/8543205866/job/23406512990
> *2* https://github.com/git/git/actions/runs/8543840764/job/23408543876

I noticed that both `seen` and `next` started to fail in the GitLab
mirror today. Unless somebody else beats me to it I'll investigate
tomorrow what causes these.

Patrick

--WmYAE7HvXqCv5rM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYNrkUACgkQVbJhu7ck
PpR5OQ/7B2JdgbrrpxQVOBfkKRzBvZGFqV2IsLFm/nS0Y+BsV88igf3R5xA0DORT
3isk197hy3fO0lrJqqMW6c1eYK8xGWDNtraxH7n+o6hpGMtKHiMGuxLaVWu5ZqLk
X2ZyMokX7Dtw4imXoUaLyVku0/VlISrJBjwsqgAVaMAr/K6s6IHkeFM0/pA/uqWo
qx8svNKal9YHHfcQ/kqo1kAAaIeQcS41YoNUz0rE+o0mB56bRm1/GIIpEtzDQYAJ
/lUQuO+KuC40GtVQwFPZxFX52/mW75lDjpLuBSgBVJS1nDOE+domf6Tq+5dzOeJO
oPgsRIc2KbZ7VaGmhD/BI/6hUch0NPRjT05k4tIM/FCyK3jjsqiUYAQZoxXKnV2X
2/x5eBzc9R3ogjxg1al2Mns2gwNDfOfScwUs+jZoJ7wvchhObRTrWL0QaVNHvhXI
OJwArlZLRQl7GZ+3Rx9kbkh28lrmQhnCwSOexFZLdKpx2M8aRltcwYkW9hJhcpK9
Xi9B93rdDEyF7XVIJMjzRncvL1RxvOrd/VOFKzh4Bw4KlBWJGhZJnI8TySssrUOR
GLgIqPehBcI3GGcjMTwLVSlD8I04NkdApUPfyPT+auwSSxBkVk0LgBecKVv4NyQ0
M4ooaVOEhKbvUgAHxEeP/VSXxMvxd+qbIEFPrcBUybAfhFo7i8s=
=GkFz
-----END PGP SIGNATURE-----

--WmYAE7HvXqCv5rM2--
