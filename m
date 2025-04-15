Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8E27991F
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708765; cv=none; b=rdvoPsh1i8uE3VeCJYeCGeINqJyBYNchbR3Cwsm2qdwnU5hutdJV4Pk2nT02hIOZTY4WxnDjItZzJBrtqjpCbPOHuUJD+skq+oaKhiddO608aRfwxkiNwPQpacusYyteO05dVxQuwRYoPk6KuUuGBd7j2eGaGgtjSZnt02DT/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708765; c=relaxed/simple;
	bh=HiUxeO4p0HQqoL+5cYplWtxrLPekYXpw/6GR0ZHiy/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd2nRz6taBUNPQuIM2ihu+RratwoaGY4tGvN+QltVoqc2ybkUD+2id8npQo3PA5Vv9UxvAT1BgN5NXy0K30zW77JoutVdLUncvtPHxL3G7V6dxI/NRTJiP7ldfZicOt6zdiFI+pyoxGp5JluTud2Ejm5m+rPrNYXYqnWrfOv/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hxt58Wi2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djr+wiok; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hxt58Wi2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djr+wiok"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id EF41611402F4;
	Tue, 15 Apr 2025 05:19:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 15 Apr 2025 05:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744708762;
	 x=1744795162; bh=f6cEZZ8N/sp/nWfIbh3jmRwTKenh9bLRCv3e4IENxns=; b=
	hxt58Wi2Lc9ADMsgtLOTQiPkP4CybEYTpkAsEqUPXiB8tG9H8JtwhDwH7p6wxV9V
	rvtxvDBsSap0yssJFpsAHnph3RvfzgzqrxoaE8+QZsRnf8efcTVZYeio6CYli5g+
	m/RMG3AVm1+XjdQhnesB5GZHvF4rD/Xude2UvTp1zwc4zENGsK5/7Y0Xs2UjN9pm
	8AvdFf8R3dSIKDAmS6Gz1l5OVbizjvbWMakL3omQ8aTpyMhdK1H16ugCFxNYVyY7
	KMvDFtObe5+95UlhVx1rjudBc7WcuytVgZ5KtYXWLuujZpetBmqVycrAe1wYJTXZ
	c7RLaQkG9UEn4oLFRKHIhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744708762; x=
	1744795162; bh=f6cEZZ8N/sp/nWfIbh3jmRwTKenh9bLRCv3e4IENxns=; b=d
	jr+wiokjKDeIIFbhwD5635eayaqyqnM0HeOR8W/N7obe2C3i2DddNuDsBKA2KQ7+
	MqeeoeFrbTSAP05Ad0XXT3PoYDhWQDti7NTPRh3M803QzhnBax22ft+Sh1NNQsZ6
	+KjQYC8sXUIdhDqeAiKF3P9M0jBXf4ZSfFlfK8cWD3lLFbD5v3cVUecRXMnhvrfA
	Qy1pbRgNFbjlPIssBSlm9mMq2vyiJBk8ZGfrnYnUzXc5gnzwaTTtdWDVL9dITu9b
	8+PImNDexbTb2WW+s5LyWqE+yd6ZtlHFOgDgMnyFNgnWDp2pnL9UAIYYrvpGFbDk
	HoHy9egrG1h9iOm4ekZIg==
X-ME-Sender: <xms:miT-Z7v_q9IThs0T2COYm0MapBOGNEZvNS7hrtaCcuxLwoKWNhGT4Q>
    <xme:miT-Z8cAWG2mEaapEp1y-vw5u7C7hk9CZBaQuGaOa5YZ_9pmrWbbCC_De030DDR20
    XW0P5x7ZLih9CN8_Q>
X-ME-Received: <xmr:miT-Z-x2_9-rTKxATgB3EATq4TXgcCWjrDKatvdHcOlqivxci8oc8S-JOXoeOkY2dV1AfhJadypelpBXbgBZG8aE0u7mJpLyEdjdCH_ELozUmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:miT-Z6MWEXO7ZbCb2uKJkkyHflqyl9FNSKysrHUSvw5T6-tO3N4Fyw>
    <xmx:miT-Z7_ZJM324T9Sl2Hr-cMzHLiPDACkC2z_XLBLmLXcnD0udDc8hQ>
    <xmx:miT-Z6XsTFPqSGvYSxRv2I9vPxdmex5dvfuRIhTJXIfPgzeFyeN8cQ>
    <xmx:miT-Z8eRFkUChRGwXQXQh5sjmZeOI6oV9irYvAmMY3ZMGQRwGoVT3Q>
    <xmx:miT-ZzYZzvdnIuGPXRc18vTdRjaLC36crtFsBIHbvZcYYBf-JrMUwAV5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:19:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a2bd640 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:19:21 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:19:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] object-file: move
 `safe_create_leading_directories()` into "dir.c"
Message-ID: <Z_4kmF8NjtERSsBz@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
 <20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im>
 <CABPp-BFpU5iLUN6Fh_+UG2Y593TWp4E+C_QQxLg6b=Cb-30F6A@mail.gmail.com>
 <Z_jgdV7Tkw0hkvgj@pks.im>
 <CABPp-BHJHPx7orf-jjgbcPtJo=tGeDZzYWEKvPU-qzXTa1fNSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHJHPx7orf-jjgbcPtJo=tGeDZzYWEKvPU-qzXTa1fNSw@mail.gmail.com>

On Fri, Apr 11, 2025 at 10:11:52AM -0700, Elijah Newren wrote:
> On Fri, Apr 11, 2025 at 2:27 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Apr 09, 2025 at 07:36:47AM -0700, Elijah Newren wrote:
> > > On Tue, Apr 8, 2025 at 3:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > The `safe_create_leading_directories()` function and its relatives
> > >
> > > How is mkdir_in_gitdir() a relative of safe_create_leading_directories()?
> > >
> > > I assumed the relation was "called by", but there is no such
> > > relationship.  The rest of the patch looked fine, but I was puzzled
> > > for a while trying to figure out what this relationship is.
> >
> > It's more of a sibling than a child/parent in this case, true. I still
> > think it makes sense to move it around as it is rather generic in the
> > functionality it provides and doesn't have anything to do with objects.
> >
> > Patrick
> 
> I fully agree it makes sense to move it and that dir.c is a good place
> for it, I just think it also makes sense to fix the commit message to
> avoid the misleading/confusing text by calling out mkdir_in_gitdir()
> separately since it isn't related to
> safe_create_leading_directories().  For example, highlighting the text
> I added between asterisks, you could make it read:
> 
> The `safe_create_leading_directories()` function and its relatives*,
> as well as mkdir_in_gitdir()*, are
> located in "object-file.c", which is not a good fit as they provide
> generic functionality not related to objects at all. Move them into
> "dir.c".
> 
> However, this is a nitpick and probably not worth another re-roll;
> especially since everything else in your v2 looks great to me.

Eric has suggested moving it into "path.c", which I think is indeed a
better fix. I'm using that as an opportunity to rename the function to
`safe_create_dir_in_gitdir()` so that it matches `safe_create_dir()`,
which is functionally similar. And because "path.c" does not depend on
`the_repository` anymore I'll also inject a repository via a parameter.

All to say: there's a bunch of additional changes now, so I'll split
this out into a separate commit.

Patrick
