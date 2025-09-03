Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00D263C75
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878076; cv=none; b=T/WdBqnKr65A1LnJ/S4127QotsoWnRFqeYiDTIgYf3kTsdOKScmOFiwLAP0MA8nW6Ph0AT9ad+LWg/uEMxJmhXoEMDRIQgFPv4kVoOy99OIX2ksxPfvqhcTgtu3QtagTosikMG/Ih+ARifgZeE33XuW9kBlIJXGEVFsLVQlWWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878076; c=relaxed/simple;
	bh=3CWhEfy3uu2MfxLuCZEmHqfQXizkTCsmjeXZtLYKIEI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1o5YvW65mSgqTFnK3i4bAx+lHAeaJbBihfRr2Y0wZ4v3ZDfdSG9vFLp7NvoVwyfkhRpMvnIalGkM6gv4bKhYZblzzlvuX8c1gaHM6232qnfpn/OuXXt4gD25pBka3zo1ogCdTyJ7Innwa+TY49SnJpBtDtzGl1FNejnygP3pKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AMSNfKb7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aGQ8iW/w; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AMSNfKb7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aGQ8iW/w"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E54C1140040F;
	Wed,  3 Sep 2025 01:41:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 03 Sep 2025 01:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756878071; x=1756964471; bh=sVMNKuCwR/
	qkKryMhLSnyLzF5Mh1dXRAqMxTsife65g=; b=AMSNfKb7oUvS8JtURMev9NV7XX
	c1hggxjmfE9oTA8ANDXmnDkICWUWERonhoDqQN4eNlS3nDNa5atp/vCmkTcKl+y5
	gpaEo5CmBSp1hILVoeACtzW+zrEqnqCdivnVkTnLUqXH5M04lr1KEblTaUmHlYtG
	f8a4a2LVLujFgX/IfDTVX1+n8ahZZwJ2yyBHPw6/PBUQ8stUr1/JOrXvpn7/ZgHF
	uBZIbXGibzQQtDnLaau4G83nnqJCkNnB2Ral/CTnwq1lU4mRb35hx6dU+jyM5vB9
	TVTpRwpB1wR3LQawsVNei/lq/N8PdQ+YdgRtdDnHtBvsTuEGjojVuIKyr/fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756878071; x=1756964471; bh=sVMNKuCwR/qkKryMhLSnyLzF5Mh1dXRAqMx
	Tsife65g=; b=aGQ8iW/w9Iz2N13nFmBcX/mmQj+2Gfn2Ri10sOSLMbRCPXzNVEo
	jdhw3rMGuH/3RxY8ndXSSHeHGPiqICDgx5CPEpyh5gXnq2PQ2ffSd39CEZxl7+gx
	qH44XSMnFD7btiDEqdTBztkU5PBajZ8OPfZVQiDkkLkOEShJE1dKZqPSdKUQsi1S
	0zYPGuSvd25vEsl8d2nsUzxl5JJM8u7cuCXKHogb1VQ4TZNSZqSb1rGRUzDFdjTv
	TELfEn9hVPmHIDcJ+fR7uwUz58DOyaKcqsaymCTI9bj8jJmh02aWzjn4A3Xrdn++
	kRPx47A1JlvJWl/4QpxagoY8vwTQlV3hGxQ==
X-ME-Sender: <xms:9tS3aOM_kkDod2N-WQZdZO0CkYyR4a73fFt7WZzxHIIuR5KMr8ZipQ>
    <xme:9tS3aEmepppGhww_y5nKD0hi2_vbodNif-7Hke920jCQyaGCNKcPme0zufGOJJerX
    8dZJL01R5i3CMjzfg>
X-ME-Received: <xmr:9tS3aFcCPNrnpJxq0jmUwOfWDw4Sin--oMdv06i7xVk_j7v_GmJgapdUHAA9ojfIQ9kcjLDCoyBFshwnugTnFK-yos9IbVMT1B2vGGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehke
    effeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptggssedvheeisghithdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:9tS3aGsOndYqaxcdTGKscbtCYz1qGrBlQxSJvK7gXthuJV2DRurlSw>
    <xmx:9tS3aHDsiFZfbWumq6LAh7i7xG1gojGr7akm1tGUr4YGlKr02Cr73Q>
    <xmx:9tS3aBzo88Gz11eY1FcoGg8QtVqld2iSFA5I0nvUcGQqZcP9f6nnyA>
    <xmx:9tS3aGLvg_uvTGizmF9nPde4Lu6X1o3uQyfqGedtHL6gPsNFNPbW6g>
    <xmx:99S3aD-7KgOjGUtkBe0IFStUjQQQfHGkrm4SAlRBOpDubpfE3uNedM2C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 01:41:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c8f57a6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 05:41:04 +0000 (UTC)
Date: Wed, 3 Sep 2025 07:40:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLfU5sEa-RE3X4G2@pks.im>
References: <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>

On Tue, Sep 02, 2025 at 05:27:10PM +0000, brian m. carlson wrote:
> On 2025-09-02 at 11:16:19, Patrick Steinhardt wrote:
> > As Pierre-Emmanuel menitoned in [1], the backend is likely to stabilize
> > next year. One or two years of backports for that particular LTS version
> > doesn't feel too bad. And if it does become more involved we can maybe
> > also distribute the load and rely on maintainers of impacted platforms
> > without Rust to help out with the backporting.
> 
> I'm very much in favour of supporting gccrs when it's available, but I
> also want to say that it currently is targeting 1.49, which is much
> older than we want.  It's also not necessarily going to be fully usable
> or bug free in that amount of time.

I cannot really say much about this. Overall I think that the rapid
release cycles and rapid adoption by projects that one typically sees in
Rust are an indicator to me that the whole ecosystem is not yet stable.

If I had the choice, I'd much rather adopt an ancient version of Rust if
it means that more platforms can support it.

> I also want to point out that it's important that the maintainers of
> affected platforms build the tooling necessary for their platforms to be
> supported.  I'm not seeing ports of LLVM to those architectures or
> contributions to gccrs that would make those platforms easier to
> support.

The gccrs maintainers are actively working on that backend, and as far
as I understand the main difference between LLVM and gccrs is that the
latter doesn't have to be ported over to every single platform
individually.

> > Also, all of this feels like a significant shift. I'm strongly in favor
> > of adopting Rust in our codebase, but I think we should do so carefully.
> > So we might take it extra carefully and say that Rust will become a
> > mandatory dependency in Git 3.0, where the last release before Git 3.0
> > will become an LTS release.
> 
> I'd prefer we not wait that long.  I'm doing some work in building the
> new loose object mapping using Rust and it's much more efficient than
> writing it in C because we don't have to sort the data when we use a
> BTreeMap.  The code is much simpler, shorter, and easier to write.

I still think we need to be mindful around the community though. I
understand that we want to have Rust in the codebase, and as I said I'm
in favor of adopting it. But we also have a certain responsibility with
Git given that it's used by almost every single developer out there.

A compromise could be to ease into Rust: we adopt Rust, but before Git
3.0 it is entirely optional. So Git will continue to work alright even
if there is no Rust compiler available. On the one hand this plays
nicely with platforms that do not have Rust. On the other hand it also
allows us to slowly iterate on the build infra for Rust, because I'm
very sure that there's going to be issues there initially.

With that we can:

  - Build confidence in our Rust tooling.

  - Figure out things as we go.

  - Give distributions and other platforms enough time to prepare for
    Rust becoming mandatory.

I think adopting Rust as a mandatory dependency out of nowhere would not
be playing nice. It may require significant effort from distros to adapt
to the new reality, so we should give them time to do so.

Note that I'm not saying that we need to have both a C and Rust
implementation for everything written in Rust. I don't think that's
sustainable in any way. But any feature written in Rust should be a
_new_ feature that can be disabled and that users can live without for
the time being.

> Nobody else is currently working on the interoperability code and we
> expressed that we ideally wanted it for Git 3.0.  Being able to use Rust
> means I can write that code faster, with fewer errors (and hence less
> debugging time), and better tests.  Otherwise, I'm afraid that it will
> take longer and we might not have it fully upstream for Git 3.0.
> 
> We also have this series right now, which we'd have to abandon if we're
> not going to support Rust right away.  I'd like to retain Ezekiel as a
> contributor and incorporate Rust, and I think the best time to adopt
> Rust is now, not at Git 3.0.

It would be a shame, but right now it's a risky bet to build anything on
top of Rust given that we don't officially accept it in Git yet. We need
to first make the decision whether or not we want to have it right now,
and if so how that's supposed to look like.

Patrick
