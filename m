Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B814F213
	for <git@vger.kernel.org>; Mon,  6 May 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979544; cv=none; b=ALNxY+KIQRZoSB5sTFhfWC155mhsULab3jz/3hiPaJFbeIjhw+5LThgKwzFrnQbH56eSWtY+ibYyjGlhzOmDGaXG/8n8ACo2UXPkC4g1uimriQ8vgxpGI1sC8E9OF5OztgFJVOmsVEdLe/sHJyKKGlrup+Eq+et+UVwNr2kGpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979544; c=relaxed/simple;
	bh=kPO6qy/yHOKSekdPd0OxzF9Cee5cCxTRWdjEivwPuFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqyvZwAKv8PCT0x5M6HWvFu/2wO4SunjqeV650Qy3In49YG+pknEZqWOhCqAhWO1kkKx2taMWgxiTJiDXBnH1dlkXCM88Fje0g071rcBwoLy8/PuolVwUD7ihfmfePihuh0I/ewKDFmB9Mh/VRetlqPVXAuQ0QjuHWzoPxkA2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZFxjoT5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fWH7G6po; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZFxjoT5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fWH7G6po"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 77E5E18000AA;
	Mon,  6 May 2024 03:12:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 06 May 2024 03:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714979541; x=1715065941; bh=kPO6qy/yHO
	KSekdPd0OxzF9Cee5cCxTRWdjEivwPuFM=; b=ZFxjoT5aH5CItptdzioIO1pzDa
	n5rgZz7lx2z1o4AbsICYEVhJAi8zcv0pyO3a0waoqypZY69perAIeeQf83kwz9xb
	cDN5qQQgazLdvm0c/HTSoZFOxML370cRuR8+7fKYeOE5zmbQF5n4Cmu+wBWC7vvN
	WMGT1RcDTwSNvZ4WQx6PYrx5p0czN2elAR1njGaGFFZMyOtGrDi0F27hva7j47OG
	cc+TtD+4cB3X8SVuyTW/hmlh4iChCcbvYwMNXV/8j/lgPt9BzinHP8gKHkx7uYvV
	rFvb8KATmhHQZQE060Q9zxJdt7vEEf6aamvGqsy19bknn/QAFVaRvb/U1NWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714979541; x=1715065941; bh=kPO6qy/yHOKSekdPd0OxzF9Cee5c
	CxTRWdjEivwPuFM=; b=fWH7G6poL30s+L+ATtpNiPvwie76UlDSYim4baIE3lHG
	pyJCRdTvrvsNzdgsipPNYUl3GwfkpOXp7gLHprC/1t8A4yuOW/AjX7bGvS2QGKj/
	TMTakrEyNgv0B7BBk/JzacMtGkQINpL3ssGPaNL2JAtUYaGadXQZAeeF5OyJdM46
	KdHW6FuvHnFU2cQDX/jzsKs/N9qABfBMf4zkylHEkBHlOmoVX/UHrMlADDOaGvJ6
	2yHPRg51zgd0n2K65ZL3s0sePj4Cb7XgsapBxhGhdQiWiC5G/sBpsWW3R5gFgvZw
	PboOpJP+tQ192Y6WOnUpYp/IyPwpkwYrvqDIevZ/XA==
X-ME-Sender: <xms:1II4ZuxamFCSHWr_ESOp__-IyvgND3DZOW2a_2rrEEEufUbwkukckA>
    <xme:1II4ZqTaFPS6eV74jrN1FRr5VexC0EYE1fRmmClx81BoqMpzMm2EfbdV3LZnZBraV
    dOuaoyvFoo3qlVjBw>
X-ME-Received: <xmr:1II4ZgXI4Gdp5CRXpykE-P_mbIj9rsD7XU520SQIbTi6jXWbEiv8KZ1Ln058Y-_iJ6GLkqwHrmqU4Jqtvl5GNr1P9lO5RY6EhWyqD6KzBRPozVUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguth
    cuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevheetgfevteefueefudei
    ffekgfeltdekteettdegfeevtedvuddtfeeltedutdenucffohhmrghinhepghhithhhuh
    gsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1II4ZkgU6S3dbGg8iU8474w4OXz7SVuutXVdxHz0vGEAKqM9AKD8oA>
    <xmx:1II4ZgAXGlMEgpBvfb59kuwljMDfCapkHhtL_CcDL4BG9dGutOOo9Q>
    <xmx:1II4ZlJnrIfdZk2p6aZ6ZdOBLQSvd0iLxAG7OHvpCl4y0WaxT_w_dg>
    <xmx:1II4ZnA7cXe45dfX3Hm1w-Souq2jrWU4MI8-GHqHnWmUvsx6tGYpVg>
    <xmx:1YI4Zs27lduYA0A7II37CdScOWn6v9fmLsS0V2YRT4DLoyPfGkQYkR6y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 03:12:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 282a9d8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 07:12:12 +0000 (UTC)
Date: Mon, 6 May 2024 09:12:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>,
	git@vger.kernel.org, avarab@gmail.com, christian.couder@gmail.com,
	Enrico Mrass <emrass@google.com>,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
Message-ID: <ZjiCz4_2KABLshLx@tanuki>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <20240417163244.651791-1-emrass@google.com>
 <xmqqr0f47wp9.fsf@gitster.g>
 <xmqqseyzar96.fsf@gitster.g>
 <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
 <xmqqfruy7oq8.fsf@gitster.g>
 <ZjU7CWdwb+xKubul@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TZHX792vd9uS7lRy"
Content-Disposition: inline
In-Reply-To: <ZjU7CWdwb+xKubul@nand.local>


--TZHX792vd9uS7lRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 03:29:13PM -0400, Taylor Blau wrote:
> On Fri, May 03, 2024 at 11:08:15AM -0700, Junio C Hamano wrote:
> > > Yes, sorry for silence on this thread. I am working on a V2 but
> > > probably won't have it ready today.
> >
> > Don't be sorry; the message was not addressed to you, but for wider
> > community participants---especially the ones with more "clout" (or
> > "long timers" or whatever word we would use to describe those whose
> > opinions are trusted by others and count more) need to buy in if we
> > were to first agree on that it is good to have a set of written
> > rules, and to then agree on what rules to adopt.

Fair enough. Given that I have been contributing quite a bit more
recently I'll feel myself addressed here.

> I have been meaning to respond to this thread since I was mentioned in
> it by Emily, but have been unsure of what to say.
>=20
> On one hand, I think the document basically outlines the status-quo of
> decision making for issues that are larger than the scope of a single
> patch series (think "should we use Rust?", "what is our platform
> support policy?", or "how should we approach libification?" not "is this
> particular patch (series) correct?").
>=20
> So in that sense, I think that the document is a good starting point,
> and I think that it reasonably captures the status quo.
>=20
> But I wish that we didn't have to have such a document in the first
> place. In my opinion, I would much rather see decisions like "what is
> our platform policy?" made according to discussions on a patch that
> defines what that policy is. That way such decisions can be treated in
> the same way as ordinary review is today, and we can avoid the need for
> a separate process.

With "such a document", do you refer to the one documenting the process
to do such changes or the RFC-style document?

If you mean the former I disagree and think that it would be great to
document reasonable approaches for how to get to an agreement with the
Git community. It's especially helpful for newcomers to the commuinity,
and I do get questions around "How to reach consensus in Git" all the
time at GitLab.

Now the important part to me is that we should retain flexibility and
allow us to adapt. It should rather be a helpful resource to newcomers
than a rigid set of requirements that everyone has to follow, in my
opinion.

If it's the latter (no need for an RFC-style document) I somewhat agree.
I'm of the opinion that patches are the best way to trigger a more
informed discussion because participants will know how something will
end up looking like. I also tend to send patch series for controversial
topics upstream without prior discussion, but my intent here is never to
force the result, but rather to force the discussion itself. This of
course comes with the big downside that you may end up wasting quite a
lot of your own time in case the community disagrees with your approach,
but that's acceptable to me most of the time.

It's only part of the story though. There are bigger changes that simply
don't make a ton of sense to propose in the above form, mostly because
their sheer scope is much larger. As you point out further down, things
like the SHA256 transition are in that realm.

Here I very much think that having a central place where such large
projects are tracked. Given that we have no issue tracker, I think the
next-best place to do this would be the Git repository itself. We
already do this for some larger topics, but I feel like the bar is quite
high right now. It doesn't make a ton of sense for example to have a
huge RFC for the removal of `the_repository`.

So something that I'd really love to see is if we adopted the micro
projects document [1] into Git itself and generalized it such that we
can add smallish sections for new large-scale projects. Ideally, such
projects could also have trailers that indicate who is interested in
those projects such that folks knew whom to reach out to if they want to
start contributing to the project. This would help us to document
consensus around new projects, and would help newcomers of the
community to pick up new projects.

Patrick

[1]: https://git.github.io/SoC-2024-Microprojects/

> (For what it's worth, I thought that the SHA-256 transition was a good
> example of this. The RFC was posted, and the discussion was had on the
> patch series itself).
>=20
> Another way of thinking about this is that I would be extremely
> reluctant to see a similar document proposed for reviewing at the patch
> series level. In my opinion, the system of reviewers and participants
> discussing the series and the maintainer solely determining whether or
> not consensus has been reached is a good one, and I would be extremely
> hesitant to recommend changing it.
>=20
> And I would advocate for a similar approach to decisions that have
> implications beyond a single patch series.
>=20
> Thanks,
> Taylor
>=20

--TZHX792vd9uS7lRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4gs4ACgkQVbJhu7ck
PpS3zhAAknZqVxYg1diJykM2lj0wPC4RbAe2J6AXg8EftwL8mXPpvYJ32r0+ZmvP
z4XZ7gulpfrHJuWypht7tTAmlYyk80OVhKyvDqw1XsdIKQN+kKbfTtryjXTx20aY
rbyX3smnFpZdgNueg+DooHYQKnw3ieD5dqP1ndFiLkWLiKzCvpiHua1opJS+4ooh
P7jWeBw7yya1UJ+hGcaUlqENp5mQF8Hcv/Sanayt+vToSZuZtGMXgMfkvVnmFBQM
C7TPveHjXPYsZTXlmT+PX9l+mRINYv/N6VpK9fgk41bGOCfzv3Uxk4hrH12u4Qmh
ML+oVui++yWjDSkL4xu/l1QB65LSpsoeaNOQU2iDhW8s1a4E2e+G0YuB35blH4dX
7Va/W2zCWYhg8goq4zXzrFOvxax6y9T1t8nZDdioZGQuvlNwBlWrHydoNodtZCJO
sbdoxwj0LHFqCpwz4A4uGPWO2BxEWqc2AnP84E3WxW6LQixR4yy5oxsqqDXi6k7M
kQhjlLBNvyvW4rKty3osWBfN9iosWcK0acTSAuvAZ3N3RUnKQuyXj7bWWTRYVf/8
2844xedSQ1FXDjH+Y9N/xhZkpgD0sR3kBOIJHVN15RlT6eiUwUxwsiT+ypeokpKq
V23ixzqhT9u1TV4mkO3EoLzkhrKSpcs/yBEBo3oF8KLkAyfHqu4=
=cO7n
-----END PGP SIGNATURE-----

--TZHX792vd9uS7lRy--
