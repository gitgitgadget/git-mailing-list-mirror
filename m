Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426F276D12
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729130; cv=none; b=mGSjeN5xoWhnsLvkfKBajZEFvcsq94a1qlFb++fpdk6Xj1VbtRKmFCGiPkUfF7NDLQlaAxArizR4YxV2cFA6tJ+UIGH1aIFcLf1eV+UQe/+zfkNUXwtCroaSi/3P6otYR/GcspLDbfDiqYfXiQcwEBmc0foxtsq5iHVZt5tMw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729130; c=relaxed/simple;
	bh=BmtzflvoP59oTQ1zsjytbuHQ+QGFA/9gPt4e0/dYLNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8tCzPaJ+klbduFrqRe8KMa/GAvqyaylV3d+QRbg61le5kvgMAraV/8PD0rL76+bwS25acnOEOzVspXifEXxoQnDKTduzFdWIXNuEJObL2ZH6ZB3JSiO+aMYSx+qLisPAdpj6nBrs/3yW2+LEB/PriL+u1tf3UEcixWpYUPVsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mQT06OvZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0VGzdh7E; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mQT06OvZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0VGzdh7E"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71A9111403E6;
	Fri, 28 Feb 2025 02:52:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 02:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740729127; x=1740815527; bh=gahCQSFgAW
	DdH7bvAdaavESWdQv9+Ya/PgMsff1jclI=; b=mQT06OvZF5FN54Sc45uF1Vnkdk
	CQ3KDHGkMBbVXLlMZZI3xyDSxtADPZZ5rgvDzTC8cY8PdBuqy9OGgDCP5yws9dml
	PXz2ZRAY2TNYan/XVfgJEXbViqrRoPWuA/aQT8r5Bs0rtrb/Ab8LToGmBsyljFfD
	pBm03LVExkhAsticTk0+4sVQqJBNunlB+0gJRFkNbxkNQSMFf2MsHVXz41bTHste
	NE9yKj96C1AqnthK0SxJa45Oipn2ds4dD/6WYIfcZU3OGPXKrkovvyrsmPdmPSDY
	KGwaohi1BN4/b5U6WZkCdeU2ULFu/cVXnpFe6Qo4H8QMWqzlav13WZeH98AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740729127; x=1740815527; bh=gahCQSFgAWDdH7bvAdaavESWdQv9+Ya/PgM
	sff1jclI=; b=0VGzdh7EuUGTbRX5vmwFppIHx5zpw35+qFxWlw5Bg3kxd6s18Vv
	IXsrrvWGajJKL3NsJb+RV8JYjgkihQ9nh91NG2MeZWQSsbbPkPtO6y7SHL/5fzk3
	f9Ln0GdWpJbmpAyE9WxFC923q3oF1AXDceVyqNUwgtua2Z05wPyOcibq+yf1p2cA
	9xDwlthxOviWxVX7nf8JTjGDwjoMKDoVQUeUsBRsst40VwgUjCqJ+D7/pRBG+qiR
	DOGY5BwevUY2SwSYczooJZkdPMzmgD5LcvRrhGgtIpXNFBeh4bWUvwvCvEu9hiJ3
	keYRvYRsBCrAwM/19MAsgwE+TETKPWSOaHg==
X-ME-Sender: <xms:J2vBZ1CgmFHYFM5gzzSCyrPt05E5hd-IjCOfb366VMVBRvWdgkMDVQ>
    <xme:J2vBZzg-uk-wZpDJxqFqf9BN5xLbrqpaR60xBAvBEKMkCwGRMKj_2-s3wAf8Oa_fS
    FpLhK6NzNLeWEzmGw>
X-ME-Received: <xmr:J2vBZwkmMylZd6bgOghsilH88UM0KAY2rmP8jVKPUsfHm5bvtNb5P1YPUIRvNMiOUwkk-cWMnPwKk-KdJwoj058F7UU-a0hue0wR9g8FuQZPqpGr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J2vBZ_yzIqIdIyEQ5a5E8HDI1IEUr1HE-OZ6e3X1tFNY1sLxOhd5ZQ>
    <xmx:J2vBZ6TODucBpMqlUMlX9NVKLOvPpjYfTWcfQ2IS_ptXEVA3sBxTgA>
    <xmx:J2vBZybwC-faXDOeSkZgWf93DYvHQVqBWtVCtqxLSR-UeR4Vz-wtMw>
    <xmx:J2vBZ7T1fOO4UC65gLFTmnYZKuE7I3Ih1ggm5Dm1ZEeItFojqWSXxQ>
    <xmx:J2vBZ3KkmLPT86CuhMX5NKtqbA6eYYdIUDxSO8AT_WJaXv1uahbyjK67>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 02:52:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 817b8849 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 07:52:03 +0000 (UTC)
Date: Fri, 28 Feb 2025 08:52:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
Message-ID: <Z8FrIfAj_oVwxz3X@pks.im>
References: <cover.1740680964.git.me@ttaylorr.com>
 <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>

On Thu, Feb 27, 2025 at 01:29:28PM -0500, Taylor Blau wrote:
> In 37dc6d8104 (builtin/repack.c: implement support for
> `--max-cruft-size`, 2023-10-02), 'git repack' built on support for
> multiple cruft packs in Git by instructing 'git pack-objects --cruft'
> how to aggregate smaller cruft packs up to the provided threshold.
> 
> The implementation in 37dc6d8104 worked something like the following
> pseudo-code:
> 
>     total_size = 0;
> 
>     for (p in cruft packs) {
>       if (p->pack_size + total_size < max_size) {
>         total_size += p->pack_size;
>         collapse(p)
>       } else {
>         retain(p);
>       }
>     }
> 
> The original idea behind this approach was that smaller cruft packs
> would get combined together until the sum of their sizes was no larger
> than the given max pack size.
> 
> There is a much simpler way to achieve this, however, which is to simply
> combine *all* cruft packs which are smaller than the threshold,
> regardless of what their sum is. With '--max-pack-size', 'pack-objects'
> will split out the resulting pack into individual pack(s) if necessary
> to ensure that the written pack(s) are each no larger than the provided
> threshold.

Hm. So the result would be a new set of packfiles where each of them is
smaller than the threshold, right? Wouldn't that mean that the next time
we'll again do the same thing and try to combine the new set of cruft
packs into one, and basically never arrive at a state where we don't
touch the cruft packs anymore?

Patrick
