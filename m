Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E928751D
	for <git@vger.kernel.org>; Thu, 15 May 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297257; cv=none; b=YuMCfMsPkJm62eXOLF8tOk0Qxtnew0mNyMbK3zgikjlJqiziTod+LikMHYYV6UG4p6Ggt8DqIQzA7hUZw76WLRaYHKUiP/wMfna41jDzZ+7hWRE/SVGzhRpQvb0REfpmn+wyktRM48Cg1ZxRByfU2ZiSIVwl/AVhv6L1xleGqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297257; c=relaxed/simple;
	bh=gRh0mAF4o1NR9xwfpeMzh/lHuHzE4fZgrPFfLbyyL0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m18Bn+Fcs0Ai6hjRG4mal+6Z/nNbUgm6qnDsa7BQgD3/vK8YbTT0CaJPyElnECDQXVCnkxyg9AAFw4Qlw1Q70AqYPEUJtfOIMqI94mNg8i1lqQVj81uJY4vXG3L5KCN6KoiTpcFwkeNyiKufjFjTzQWYDZhKqxfNtOa+neWG1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PQEIfvaf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WItkBCzk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PQEIfvaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WItkBCzk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E5B013801EF;
	Thu, 15 May 2025 04:20:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 04:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747297253; x=1747383653; bh=vZEYnTu5ZZ
	V3nl3NWaZx7Nv90VmYAkvo3RZB5H5EtMA=; b=PQEIfvafCaYkq0IEHgpT2qR+PV
	sT9jgWWmipjY4TsEBQ5MIznD4Bt5x1ngSU2ACZnYxevRpw8ZOOeLCaZzoX2uCHj/
	5JJJEwszEXg5vMMxA8eTYUCVK5m37bXHeuLq0Gph1TyRNqI824//xsRa1c621YNE
	BFHY6PJ3yGjqe4qDM/Q5U2aXH3BVxOszmcqYdCyH6KpRkpUc6YAWd9mgu6ESzDBC
	9eik2VLPU4s1dsDjCDyD3uMbgyOpyyVC4yTWzw40fmd4/fmk9wLbJjMXqeWKmisP
	MdqRA51QSVE58b+sbyOM6JVLNR+VsMafScCz+87n1zW3JXGhih0q6TBWpkOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747297253; x=1747383653; bh=vZEYnTu5ZZV3nl3NWaZx7Nv90VmYAkvo3RZ
	B5H5EtMA=; b=WItkBCzkkgS8gGMvH2eJvEB+DwDSSs6pmw/oIYBEbvYWeZEKV5e
	ixweqKGSMipbxlw4hws4xbBSK+8aMn1oUHKPy19zUTsHneBMAk5+qZrhpPeq8zU6
	L7Fu4PyJxAKv5SEIR/jcJ2rgpEJ3JVTD3rQtKFcaAz91qKlXbEq2kk8j0RZvBvRr
	Ox84fVsbrHkjnm6AHK+Ohv5pfE2XTCbVBU8EZlYxaxuCcjhydILr3/RYB1D8/3TB
	1HNJ7KI8NPD6BjU7c+99q7XTtcX++o4WL6aWqxu66acJsmsiopLYt0vOYIbj7EhR
	ZlSBo1Joo4uefcetNVjKpQyWmQhCyWTbKDQ==
X-ME-Sender: <xms:5KMlaOHNbJIsr1Q9QWBjCuC8zQ7lFiOpzkEjAwfXLLbVKcCZTyGXtQ>
    <xme:5KMlaPXqrUoC_oajNBHKNbEjsvMwLHOt6vJW-zHRaJeOR-zCtVtWJWKQCTaEWWC5e
    wLhxPLuHeL1nrcLYQ>
X-ME-Received: <xmr:5KMlaIKAYRTlkOyWmqfqTvDARQIDxPiLhvIHMtqvKiLCHmq4anmkk_5UIrh-TlEOwkcaKgnfKNuV1AlkYt4xjE5t_uHW3xdrzqZxupJtAh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5KMlaIHvs78PYribvp3BrrvsbCBz8AMlimk5NZx1XS9wFKevwP9Y3Q>
    <xmx:5aMlaEWk-i2mZN1eE2Nj59YmuVm_eGK6ShcKg8wB2WmjCZb4jFmS_Q>
    <xmx:5aMlaLOL0ImZMONR-mofR7oOuqqqjhCb0ClkzRJED9wncQjNYs7N8w>
    <xmx:5aMlaL3e74Dj7Nj-skh-ma9rrVa3VaECtwlBUtRGUsbX9Lv5Ogkm1w>
    <xmx:5aMlaLzZqP454nFMJUgmavzNBsJQczUZzX_1enfHSTk3qxn99I__Dovh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 04:20:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34c1758c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 15 May 2025 08:20:50 +0000 (UTC)
Date: Thu, 15 May 2025 10:20:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] meson: parse TAP output generated by our tests
Message-ID: <aCWj4Xi7SuG22_kK@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <20250506-pks-meson-tap-v1-4-5aaab2942a4c@pks.im>
 <CAOLa=ZSxPtMQdb8Hne6-WMEd9gKwWUC5hnCUCAaS2FfifqZHHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSxPtMQdb8Hne6-WMEd9gKwWUC5hnCUCAaS2FfifqZHHA@mail.gmail.com>

On Thu, May 15, 2025 at 12:48:23AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/meson.build b/meson.build
> > index 94bd525dd7b..cd8df189d79 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2031,6 +2031,14 @@ if get_option('tests')
> >      'timeout': 0,
> >    }
> >
> > +  # The TAP protocol was already understood by previous versions of Meson, but
> > +  # it was incompatible with the `meson test --interactive` flag.
> > +  if meson.version().version_compare('>=1.8.0')
> > +    test_kwargs += {
> > +      'protocol': 'tap',
> > +    }
> > +  endif
> > +
> >
> 
> The change itself looks good. But I do have a question about this:
> 
[snip]
> 
> Shouldn't the '--interactive' flag also produce 'Ok: 1'. Instead it is
> printing out 'Ignored: 1'. This is while I was testing on your series.
> Seems to be fine on master.

The answer is unfortunately "no". In interactive mode the expectation is
that the user will, well, interact with the test. This has two
consequences:

  - The standard streams will be directly connected to the user's
    console. This has the consequence that Meson won't be able to parse
    the generated output anymore, and thus it labels the tests as
    "ignored" because it cannot derive their status.

  - Even if Meson intercepted the output it very likely wouldn't be able
    to parse it. After all, we're in interactive mode, which means that
    the user may be directly communicating with the tests. E.g. if you
    use `test_pause`, then you'll be dropped to a shell and communicate
    with it. The consequence is that the output won't follow proper TAP
    format anymore.

So it's basically impossible to parse TAP in interactive mode, which is
why Meson then ignores the results. If all you want is to see verbose
output you can do that with `meson test -v`. But interactive mode really
indicates that you _want_ to get hands-on with the tests.

Patrick
