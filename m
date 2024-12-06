Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53561FF604
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486573; cv=none; b=Umj84lomcsBJlOpzpy/GNvk0rd4PCYw1eDTqQFRtRZkmOSNkYHznjCxiO+zDO5z2ZMI/7lc+Xf/ZWMB7DarFUZBINFFTPJiUkgY7QatygL+fCUt+wVklqrbu/tepQjOoVJFW6FCIxljJetcR7n4fys2ebndBNxOiaRJqsBoj3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486573; c=relaxed/simple;
	bh=ji0LRWXGLwN5+oL+B0fnaTPisGTU+1CtSGTJjoHNrpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh09s0y2tvngaln1Otx9N2qO1/zQB/ELpecvbTYnNvnyUQifuS/RDXlC4aOw9ZdhHXm3o4U6pIgAvEPdGq461VDDFS19Zd7qywdv8Ae8Gdrm58sqAE261ULWbCV09bm5gicI5i0cDDl5rcrfy6/G2rM6g2BT3NrXfjXWfPn7Dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f3k1VwIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jXmlZcrh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f3k1VwIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jXmlZcrh"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DA710114014F;
	Fri,  6 Dec 2024 07:02:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 07:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733486570; x=1733572970; bh=TV4PHOy3Mi
	v6I7Oj8loguBxIgcp3XpdEBZL8xYhTU9s=; b=f3k1VwIymcmcIbZoKXTBvPQMGy
	o/0+/1RZai7Ifu61zdkWcNwzGrDq2IkisYFBEJGqxKKNfnO1TLumiP8SEbiqVGtO
	kuXclV/gjJR3Ixsdj4u4EJoZSnwYNAxn6aGphx3mVHK4amc7FHHL6ZThfxRnNbU2
	K+YPq/+qjdqFVKuT+JpR/YdrnQLNufY7ZcFOX5iN4aHYNPJvMjHpqfk1HSvm/ncP
	hXtkh1Ey+H4Ugk9lsxWRcC+6WG57kFm0sQIaEu/s/lF+mPl9YiGLd8IxwP6ea+wD
	1/I9xcNBMdiF6oUUU6ALVNRMu28ZIPAjkCs32sGB2iuGxs8TdkeJ7KZlfv7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733486570; x=1733572970; bh=TV4PHOy3Miv6I7Oj8loguBxIgcp3XpdEBZL
	8xYhTU9s=; b=jXmlZcrhmvCXZdCHbfnSprLZ7hvgkNDiM4Y6S40Q2XG88Y4Pi2B
	p0btyeNhDPwDcu6qWyL/+rvjzEW5ndBZAXRJ5a4Tmn78gczPQSEOBYQWJlGYJk2u
	HWrg0gaIgkBDgltnn7CPj/VeM9kp060tSEFN8+JmHQ6QFQzbJgrMS/vOpS1YvbCM
	tb9rYiYjTbj1Tf7sTpsRuBNEVQlgmYd+QNu+TxrZn3p336FX6byDf5498ah/P6nq
	CmDFZ0XHidLs09sWt6AntDAoiA31A6vz7CcqDHv/wT8mrYFh71NkGOp8lgrOwik0
	H6yYWUw35R6w9E7JmRLKzyHrdO9B37Eq7aw==
X-ME-Sender: <xms:6udSZ-XRqrcp7bk5MjfkJMixFyeDwG42GrkeZlCDlSVd4DAm4BER1Q>
    <xme:6udSZ6k4YQkYz9CG0_kQvvKUzSp1AxELv2GySQlHGkUCRptSb9KmxAe0bLxpKrUOc
    2XxXF4KoR_Vbnn7QQ>
X-ME-Received: <xmr:6udSZyZOeRj8WoN0xyj8K7ZScN4x95BAF8f_Fmhn2oaWn40GvoGHXrcg_-4_eFTFIS3sAhdcvd-4bWtoEw-jwSFcGPwiicLg08KZELmLvUXlnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevhfeffedtteeluefgtdeugfdtkeeugfelkedtheegieek
    udduueevgeehudekffenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6udSZ1XWx6vOQzIvUPb-PTrVCutdJYZQHzGgYKfyCbAMtPgRlUykLA>
    <xmx:6udSZ4lkRjdRNRllYtfhj_h39vNugKk14mMAey6FzLb2SNzTEV7law>
    <xmx:6udSZ6eAfsRjUl519cOd25nedX6mLlcBArhVlVjNlnSmMFXtiFEEkg>
    <xmx:6udSZ6FiBDBDzhsYdO52435iHhPmxTnQGxqRBgRKoX-PEEzX5yCHKQ>
    <xmx:6udSZ9wZHDRElTWIibIxYvccJ3F4FLmwxHZ7KDx2sUHBAAIGS-ufKBnb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 07:02:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id efd142cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 12:01:26 +0000 (UTC)
Date: Fri, 6 Dec 2024 13:02:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] gitlab-ci: update macOS images to Sonoma
Message-ID: <Z1Ln2492OCTwbII1@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
 <20241206-pks-ci-section-fixes-v1-1-7ab1b69e3648@pks.im>
 <CAOLa=ZRUZC9KDj9F6iLWWU+CBHz_DWKA_8znM=7RVSCVGSeD9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRUZC9KDj9F6iLWWU+CBHz_DWKA_8znM=7RVSCVGSeD9w@mail.gmail.com>

On Fri, Dec 06, 2024 at 06:39:59AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The macOS Ventura images we use for GitLab CI runners have been
> > deprecated. Update them to macOS 14, aka Sonoma.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  .gitlab-ci.yml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 526ecfe030a43e0a5a83ddd35cb7c96d46ab2485..61c56ccac8fdc940075d91dd4cb0b54ee33d5199 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -99,10 +99,10 @@ test:osx:
> >    parallel:
> >      matrix:
> >        - jobname: osx-clang
> > -        image: macos-13-xcode-14
> > +        image: macos-14-xcode-15
> >          CC: clang
> >        - jobname: osx-reftable
> > -        image: macos-13-xcode-14
> > +        image: macos-14-xcode-15
> >          CC: clang
> >    artifacts:
> >      paths:
> 
> The changes look good, the documentation also states that if no image is
> mentioned, it'll use `macos-14-xcode-15` [1]. I wonder if this means
> that if the image is unspecified, it will always use the first
> non-deprecated version. That'd allow us to not have to keep updating
> this.
> 
> [1]: https://docs.gitlab.com/ee/ci/runners/hosted_runners/macos.html#supported-macos-images

It does, but at the cost of potential breakage whenever GitLab decides
to update these images. It shouldn't happen all that frequently, but
when we notice that it does become annoying we can iterate in the past
and experiment with setting no image at all.

Patrick
