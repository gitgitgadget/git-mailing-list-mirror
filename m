Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16528EB
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267986; cv=none; b=gqwHzggw2jKm3GIsHgDfPn07XTKSaYY76VpLNnAvMjTZdzChWebDR+qmWxj3uU0d4XIQTyba/0PrNJJWSTMWJmUTu6cj4NUbgFkSpY416vJ9JO6/zuekZ0QggYOQ0bczwK1wQvl2B7qrAnFLIjvqIx0+ZJR3d1hbAuL7mJpknfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267986; c=relaxed/simple;
	bh=G6gkfXWz1yPyh0dH9C3Xkmf2L+VnL00FkWd1rLncr1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2Neyj0IiBSJ4Q0YfmPnrBO8qGYT/SMBBlcVlOjeqQSeXV3VY0wB5xaQe9UBolbdMsL3p3sjPLwR2d8UybExMurr0tWin6l7iYKUInAW4qh1i3//qL7PhjGL9NBoIyKBrdPecGmzVTgALnEcCE+rH6DCs1sYhgrQ69xwu0KYgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fGnCOECB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BzcX9SkM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fGnCOECB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzcX9SkM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7B9E1140183;
	Mon, 26 May 2025 09:59:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 26 May 2025 09:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748267983;
	 x=1748354383; bh=8SI1zeyChLDP1HpIeebuabK3hkd8cJNtpvlBsyiG8hg=; b=
	fGnCOECBxtzfgdF/TdG1Z4X681hx7240xTHSiIUuBwUfiOfs3BSkSPMv+dttKBRu
	0nyeMBUZl1jImpsPPA5zBf6pOglm/b3IJMYgRWylk3W0qhNZKCS+D8/1GBGBnaIn
	LMNBqutjRJmuVlQABWtJzMpNi9rwk4Q+o/Y/GZt9TdKu0kNWZUWoyPXSABiRvF7w
	i0ZNXG0PkUZB/AbGlFi5YdtApRNn1tefNxkjA5Om+mWCqnRfhxmT1XObUbpoBTho
	5NCJ2UxSf9tHkGUup4Kzj+slFUcwkSPQtgyCXcod54XLZc26uUlKJyA/cq1ow/Za
	M0tsCw8rXrV7yETUr14tFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748267983; x=
	1748354383; bh=8SI1zeyChLDP1HpIeebuabK3hkd8cJNtpvlBsyiG8hg=; b=B
	zcX9SkMyn5PELXjfn8Tv4m6odbimsXTGG+4beRrkkUlerS5qDqI8rPlniKSZj3vF
	uSKc1ztxeqATSOuE8cW2KTtsXR+rUYVjN2LM9J2V/ZbaULoUZleqiRU0jBfWZWzG
	eZ7sP09cQdEwzxlcHnKq+AvN/JGxvonxlxmS9nbBHsRu161cfbXKYBXtqfBpf4Gi
	qFv5ggDnbWj0wtjEvuBK4H3ic7i1OPq+m9zYxde19+q9DiuPArd/o7MJG6lzLTKZ
	RiMDiTNrDPcBQpyGxXfomIoWmPlsd/6XrRVSFaXTU5qFy35HLnSM000SPkWVRzfo
	rXdrHCn1+pjueRxpwx+tw==
X-ME-Sender: <xms:z3M0aFL2Nt-QG9KMRAE3YVp7q_Dq4N_IQ-QnshoLLeNMIF0exV3Oew>
    <xme:z3M0aBKpQuP4dCqycI99G5L1NeJbLNeyn-wRo6pdRxs-2lTlFYjzf018hEjpv79oi
    sspcgLMha4-S-HPfA>
X-ME-Received: <xmr:z3M0aNuAQBeTzX1kr5yzsToxoC6xZ49pYxwPlHchq2rwgAuzNA3YoqFae8pfX2GZjSWnOpcqtJKtfuPEy_Mp5LHO6VrHQvXypbgU_Bd1xsEWzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeejtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptedtueetfeeutdei
    vdegvefgtdehjeejieekfffhleefieehudfhkeekkeevtdevnecuffhomhgrihhnpehgnh
    hurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhn
    vghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:z3M0aGYLA9MyxLBWkXZGoB5BzZJ-iD6m-_fhiASVjvOF-fR5AlAPTw>
    <xmx:z3M0aMZC1cYfpHTtL-cnJNcCNcwa2zq-A0qiVzHK9T7Kh8jvWuTCAg>
    <xmx:z3M0aKDuOQaSkdw0X94Xft0dfg74e6Ws3hgRKQYIjF3zV34IRSbkrQ>
    <xmx:z3M0aKbrK-FoICiF4WyDTIct5_51wQsnEFpmDsYHlqMs4nj6YBq9nQ>
    <xmx:z3M0aFhaF8m7-3ARc_E6k-ANbSn2EGZcsqs2c7mc9WmXLMP0SPobeB9J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 09:59:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46e50136 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 13:59:40 +0000 (UTC)
Date: Mon, 26 May 2025 15:59:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aDRzy37ZbH9_Qo5B@pks.im>
References: <aC2xp4Cdb0j6OX-G@pks.im>
 <xmqqcyc2aqy7.fsf@gitster.g>
 <xmqqfrgx8xkw.fsf@gitster.g>
 <aDBH7G-oKKxAXWBp@pks.im>
 <aDCNqRAoGygwnAbq@pks.im>
 <xmqqo6vjz5cn.fsf@gitster.g>
 <57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
 <xmqqwma7w29o.fsf@gitster.g>
 <aDRiLdUCEVQHq26z@pks.im>
 <4c06724e-f6dd-46b2-9955-57501f8a4e0c@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c06724e-f6dd-46b2-9955-57501f8a4e0c@gentoo.org>

On Mon, May 26, 2025 at 09:54:40AM -0400, Eli Schwartz wrote:
> On 5/26/25 8:44 AM, Patrick Steinhardt wrote:
> > On Fri, May 23, 2025 at 12:33:23PM -0700, Junio C Hamano wrote:
> >> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> >>
> >>> Question: should meson (or indeed prove) fail the test because of an
> >>> unexpected _pass_?
> >>
> >> Yes, it is a very good question.  I do not mind if the answer is "it
> >> should, and the make and prove shouldn't let unexpected pass go
> >> unnoticed".  The difference between the build systems bothers me
> > 
> > Indeed, a good question. The TAP specification [1] has this to say:
> > 
> >     Should a todo test point begin succeeding, the harness may report it
> >     in some way that indicates that whatever was supposed to be done has
> >     been, and it should be promoted to a normal Test Point.
> > 
> >     Harnesses must not treat failing TODO test points as a test failure.
> > 
> >     Harneses should report TODO test points found as a list of items
> >     needing work, if that is appropriate for their use case.
> > 
> > So if my reading of this is correct then Meson isn't wrong in reporting
> > this as an error -- "in some way" basically gives it full permission to
> > do so. So this is plain old undefined behaviour we rely on :/
> 
> 
> I don't see how you can possibly compare this to UB. It is a documented
> variant behavior and thus "implementation-defined", not "undefined".

Fair enough, "implementation-defined" is the better way to put it.

> Also,
> 
> https://www.gnu.org/software/automake/manual/automake.html#Generalities-about-Testing
> 
> """
> It’s not uncommon, especially during early development stages, that some
> tests fail for known reasons, and that the developer doesn’t want to
> tackle these failures immediately (this is especially true when the
> failing tests deal with corner cases). In this situation, the better
> policy is to declare that each of those failures is an expected failure
> (or xfail). In case a test that is expected to fail ends up passing
> instead, many testing environments will flag the result as a special
> kind of failure called unexpected pass (or xpass).
> """
> 
> > I don't think it's inherently a bad thing to fail on unexpected passes.
> > After all, it shows that our assumption that the test fails is broken,
> > and that we should have a look why that is. But I can see arguments both
> > ways.
> 
> As Phillip noted, treating them as ordinary passes undermines the reason
> for having them.

Yup, and I tend to agree.

Patrick
