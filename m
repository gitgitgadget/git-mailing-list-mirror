Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61030E846
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210644; cv=none; b=HJPH7+R4g6cCcDLYekbLqitM07zJUXnlBmt9OCfYnB8y0pP3ySM6RDf+aWOhQCF95QH2dBakFYAHUMe7NTK8w7L+/Zq5wT54dRHLdcXvniK+v/HpFe9fSaQjRLYRuF5050ZYOB11074uBZbJxi093/Wve31vVsbaRJaPTWIBWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210644; c=relaxed/simple;
	bh=YPkeFg9ycY5VFHBYi+9YIUpKQWoi4hHWSKIcqNvWA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaWGbA7QwhPChEjsPdgNv+OgwhWYDWdj0yLXN6ozNyzke1ONcHlcYQAy+b+fNdjTBbj11bChgYacLDBKt2MG57x/vTY4zJbVaYXOH8BgfziVDsKyIzKNZUtHJMT3ocEJECiots/5Ln9ZFJ7eRtNRGlCAg+3fjSbVl3GC7a9zFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fxxO5RLq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnSuMgPW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fxxO5RLq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnSuMgPW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C3381D000A1;
	Mon, 12 Jan 2026 04:37:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768210642; x=1768297042; bh=Di2+z+fJUG
	1Cr8onzrdb4MduKEC0xkiDCxs5DnJpMq8=; b=fxxO5RLqoC7VfHCvjVZEoNSxcT
	NJoEdLc8tNZjgU+hdEbp6cm+tY4YwKVgVaQj9F/kDtZALTtTGpN5sS/Gy1mSS52s
	xhpcwdZ1Q7nmx3MWJe8yGVzToTQPgNv79EmBAY629dz5gDqWNUTTXPFfVT5YlRIL
	MZYikSXI9waNj10R3qBQHnVQ3+M/ZMgpxEVWSPx2X9LicNzVu2k7uh8xcs5mzG/b
	BzaTg2dOwOlNglmyI0mwyE+r5yrobqiJw+qiAU5GYX5oKSRN4FL3drQ3vwp4ss/t
	Tve/SQR4enZuk7Yp4qfwJRHM/cSLnhfWbziwLwjSW2Yau1Bydi3yEpR2vzFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768210642; x=1768297042; bh=Di2+z+fJUG1Cr8onzrdb4MduKEC0xkiDCxs
	5DnJpMq8=; b=dnSuMgPW8If2rVSBXuGIzIEnOKel4Uv9pSIk+wavzUfCNxfevHX
	I1NZxc0JxpLMzgrXdOm2otfaGKxmV7L6uxBHCMRnFCkpGWffSYuFo9G+kLgJOS+X
	UdTmaaslPPRQYivAVbYyaWXx0uhH9d0kw41YdKxOU1Jp1sH1hJE4mgM2XX3H+rtf
	a0+E7qYMgmEuIlMwr9VPjXpozY1HR9lmJs6LSGffyRHEr/kn+mZ8EqEPDTySUHZG
	RKux345ecW5oDE7f8Pi//A1YZSeHsKw7ERCf6pPPTUi03xFt4pC8OmLPYdPgNOdQ
	cDtr1Ok9LLSRNljf80mbo9/LaRPJhxPRr2w==
X-ME-Sender: <xms:0sBkaSCrcZJGoTbgqsrLT8627YsoojU8xwIibh-DfYPZwySUu0KOPw>
    <xme:0sBkaSg8ONRue0KxglwKcztfoBPv4nKELJNEyIqXduUgvXzEfUnp5mJ7T-9bYBrZW
    ro1IxGaVjoTEcekGt453a6FLzcAjvh1497BZ_apdd_Nb3TTZwJbWQ>
X-ME-Received: <xmr:0sBkaTODJjuHGuZmi9J0kMKTLl_hcQbvMzrmuNBAY6faGOE5kiM56bNWNZMtjRDi8mW0KeumtaSPBLfD26MSYNjCRfzjF0kK6JDsfmPj0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0sBkab73Ix6m-157yt5VShP5luddFFHOazHYeF4PcLP_yVG3lXHU1g>
    <xmx:0sBkaZ2t0zaY7g-1PZhMIfFFsBiHbiaMdEL3d9r4TleuJOObnGia9Q>
    <xmx:0sBkaUblb1b1YfTIxU8JAA-J8r2XBPw1lsNxm1UXkhCeQrJXZ6F0wg>
    <xmx:0sBkaZA1vkGKHJpNAY5IB-Is7t2NHlLn6yKD_XYdkKSeZQznnZnE1Q>
    <xmx:0sBkaVJQYVVAC7wA34G1eDGbzYTY9lM0qYniyYiTJoCFM3HhYk6k5QhT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:37:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90e5b431 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:37:20 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:37:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] builtin/pack-objects: exclude promisor objects with
 "--stdin-packs"
Message-ID: <aWTAzR4H3XuAlJJn@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
 <20260105-pks-geometric-repack-with-promisors-v1-1-c4660573437e@pks.im>
 <aWGP/Lp2Eo03F7vN@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGP/Lp2Eo03F7vN@nand.local>

On Fri, Jan 09, 2026 at 06:32:12PM -0500, Taylor Blau wrote:
> On Mon, Jan 05, 2026 at 02:16:41PM +0100, Patrick Steinhardt wrote:
> >   - "--stdin-packs=follow" does the same as the first flag, but it also
> >     asks us to include all objects transitively reachable from any
> >     object in the packs we are about to repack. This is done by doing
> >     the revision walk mentioned further up. Luckily, fixing this case is
> >     trivial: we only need to modify the revision walk to also set the
> >     `exclude_promisor_objects` field.
> 
> Hmm. I'm not totally sure if I'm following why we handle this case
> separately. Could you elaborate?

You mean why we handle "--stdin-packs" and "--stdin-packs=follow"
separately?

The thing is that we don't really need to care about the case where we
want to exclude promisor objects with "--stdin-packs" because we don't
perform any object walk at all. We'll only merge objects part of packs
that have been passed to us via stdin. Consequently, you can say that a
request where the user asks us to exclude promisor objects while at the
same time asking us to pack a promisor pack is self-contracdicting, as
they could have just as well left out the promisor pack from the
request to achieve the same.

There's two approaches here:

  - We can simply die when seeing such a malformed request. This is
    exactly what we do with this patch, and that cannot be a regression
    because we already died beforehand. We strictly expand the set of
    supported cases where we pack objects.

  - We can honor this, but exclude promisor packs altogether. This is a
    feasible thing to do, but now we also have to care about the case
    where all passed packs are promisor packs. Also, the result would
    arguably be _more_ surprising if we exclude packing some packs that
    the user has passed to us.

In "--stdin-packs=follow" we _also_ do the same as above and die in case
we're passed a promisor pack directly. But in addition to that, we also
need to pay attention to the rev-walk we do, because "follow" asks us to
include objects reachable from any of the packs. So in case any such
object is a promisor object we need to exclude it.

In the context of `git repack --geometric=2` we won't care about the
first case: we won't ever ask git-pack-objects(1) to include a promisor
pack in the normal geometric sequence. We do care about the second case
though as git-repack(1) may end up passing "--stdin-packs=follow" when
"repack.midxMustContainCruft=false".

> > diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> > index 4a8df5a389..cd949025b9 100755
> > --- a/t/t5331-pack-objects-stdin.sh
> > +++ b/t/t5331-pack-objects-stdin.sh
> > @@ -319,6 +319,45 @@ test_expect_success '--stdin-packs=follow walks into unknown packs' '
> >  	)
> >  '
> >
> > +test_expect_success '--stdin-packs with promisors' '
> > +	test_when_finished "rm -fr repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		git config set maintenance.auto false &&
> > +		git remote add promisor garbage &&
> > +		git config set remote.promisor.promisor true &&
> > +
> > +		for c in A B C D
> > +		do
> > +			echo "$c" >file &&
> > +			git add file &&
> > +			git commit --message "$c" &&
> > +			git tag "$c" || return 1
> 
> Unless these changes all have to live in the same file, could this
> instead be written as:
> 
>     for c in A B C D
>     do
>         test_commit "$c" || return 1
>     done &&
>     # ...
> 
> ?

We unfortunately can't. The problem is that any object reachable from a
promisor object may be labelled as a promisor object. So if we had a
tree that makes all blobs reachable we'd treat all of them as promised
blobs.

It's quite confusing overall.

Patrick
