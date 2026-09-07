Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E243CE7B
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769434; cv=none; b=aMESIfDL5Bhyl8MvdrrFxO2nxYyrTwEhL7/v8NihG1Bi8TXTw7vsFxhHpXw7ohyEz0TOc0HihV4RBVqdcJMHtrJ9UqDWNvv0hGWGe4iej5gMtOnu6HtgF1bpDWtKKRSYKSqzq5zaP+mQma9EGuDsCNpiU/tiAbHryyvYFpR/YRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769434; c=relaxed/simple;
	bh=C/HEDZScDOfRZZw9VcasUxAxn05LuzgtrhuZpamnJTs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrx5mxpHQF6eyW7Ld3BMXOLuUhGTnmzx648KBQIGsBpBoOws/+jx1A2p8X6Eo3xiyU1OKkHJQDUz3Crc4qIhPl8o1XU1QZDHpThL9ycoY7qmwdgyBOisJHgxbTRrfATdJ9yGv98G+b61uXrEqYkotp7UFKw37XeqjFuCuohf5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gRvkgTFy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgDWHBPM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gRvkgTFy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgDWHBPM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D79914001F4;
	Mon,  7 Sep 2026 04:23:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788769431; x=1788855831; bh=bBrmfToiQ4
	fdkx5eEO08qGXYV8BbTnZk89RMUfl38ok=; b=gRvkgTFytrN8OCnrIAOUr6TWyT
	CqvDW1hcYT50GQ/fsvbT8Nxv74BPVNgO8LJoj2z2C2NdK4W3A+WDCzw9C9VrN1kR
	sZU8gFkvxsckkvpD4Jxwxcs3eSPxAjKTTJ6nTqHzVUZJ8yWorNfCVb7xNdDRafQJ
	74U7B3USjstCq37C3utUDCEtvAIOEQc7MI2klakHQhMS5WJTZwV7Bvb/x4aXvIT5
	7dfwxpVpHvXQDB6ZNzFiNNCzKBvj/fgIOAFMw5dCP7Vz+rvvZTHXLQDnRpzrvhmC
	/qQKvqLLI01YzK8JbgJq7ZJS5m3aAMNCzRpt2ZQZZ7TeFBRth2e02Zvgoz9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788769431; x=1788855831; bh=bBrmfToiQ4fdkx5eEO08qGXYV8BbTnZk89R
	MUfl38ok=; b=BgDWHBPMfDL9dI6evz7g5ILXMtbXo48YoasY0D82DbHkUPuaqzR
	2xYyZat6RY5+GPeubAk8UPH5sC3l+gxQ2BWEL0gK/TqQJYTnQdz1NwEL0Qwg48o0
	zm1PYg2ew8ZPr4FSiPJZ0g/DofH0CptojlUZLK08do5eIt4zeepnvt1tGi3gfYmT
	OtYYrQ1yTGK70ETfHcI4LpeVKPkZ0AMUHMceO0FAwod5v4WoKsPQ/2CcpP9gZj5X
	RUa/865/9pqQJGL91UTcO42WVwSH9VQT8+jZ+zOfByWM8aGD1VJEm3isbpwAOHEV
	+b38Qw/sTDYx5oAiE0W/sndnQ061HH25lbQ==
X-ME-Sender: <xms:l3SeaoWo5IsPIxEeYIYFfJXijIoLDqSTJlgVJmg1yUueuFx5h0y_YQ>
    <xme:l3SeakA2MWJweiPLGub5KO-QsmVXiEZwKZGm8hg0Sipr5Dm_zqHfNtmC3KD4KTIoq
    UrVhNfI-NZBfNBxaZh0eMjU28M09ak7jnpmOEzYr-nMmEiCHO3UN9Q>
X-ME-Received: <xmr:l3SeapyhL72Z9pMIiuBjJVn9SGGcH1Cry9yD02xiFXRiKfBFa2em_A>
X-ME-Proxy-Cause: dmFkZTGVd4fJNB0R8vALFpFeE30+zgllb4fLrPonca6uSznlWl6yGuHODD4oT1g1SGLHnT
    tk8SZUBenRRnxq9rVFLjF14r3wY6F/vJ6BYv92NmAE8wAncrI+S2eJ2tJvoULaIEGztp11
    GZdlPVJ9J7EzeH5s/8rY4GJWDtlU3XdlW30ZK2XejG7CnxRLwDP4Zj7Uydi+khggEaJgn3
    Absg6+DIfD0TWx8zkn3/4VsB6cVkdo7h3PVF3dfhxtQig9++8bILhDdz6+vGW/37YrYbRu
    iMPQMQ4Bt0UzxZQipLKCti8MHSla25YxLoTyFWJjqXRjzc1aCF7uTLbdo5tz+tIeMU7/LY
    wXJRST8zNqXWmsCwTvSReEfrGfvd1btL+NqXNRAIoZ7/N64j3skLCRGUM/OcqA8I4vml20
    CCSqgBaIrPilC4olkDANhqiD9kNRfCDYy79pUqfNUzFbEVRiOTwbjbnkY6QB63EQpn0k/Q
    6rHYkYC+IMz4gh1IUS6ibPFdyIH2bvcCKnMtbTKiNRrUbWh6Zgob9qX4JpJ9Egd+246JyZ
    T2LvjvW7k3tNwWMGiTDw1K5TRcEC+d1gBsrEnqad9QVH6VuZG4TmpV4SOOQ6VBb7pNUHo7
    zsyFSdWtMOolpUeQZd9vRI7A+B29hlHN09oiqqZD8al04GcCAUW1AcbLdWCw
X-ME-Proxy: <xmx:l3SeahB7FIXsTJ2T2mLyjK3DbN8qjn1cwIumpQtK0QavWum33A1sOA>
    <xmx:l3SeamZBas3W2TuXrvIx2aq1kvpE6b7XLVxrzKn_tJzPMPMR9fax6A>
    <xmx:l3Seapj9mLWGf3fiObEqGZRp8Y8itS195AOZaSYhYg-JjMmnd5kSYA>
    <xmx:l3Seao6T7csAfh-KBt9asb7178Sydxis7OUuAl7QLKPxQunfROp2vw>
    <xmx:l3SeavvzjKJsRFy8Bkazu8y0u7qQK7DEeA6ZDhsjgquA22beXtyiVBah>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:23:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1a6f0ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:23:49 +0000 (UTC)
Date: Mon, 7 Sep 2026 10:23:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What will come after Git 2.56?
Message-ID: <ap50kgyenpRrsqln@pks.im>
References: <xmqqmrtu50av.fsf@gitster.g>
 <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>

On Sun, Sep 06, 2026 at 06:14:40PM +0000, brian m. carlson wrote:
> On 2026-09-06 at 07:03:20, Junio C Hamano wrote:
> > http://tinyurl.com/gitcal tells us that the current development
> > cycle for Git 2.56 will conclude around the end of this month.  As
> > our typical development cycle lasts between 8 and 12 weeks, we will
> > have exactly one more cycle after that before the end of the year.
> > 
> > Now, the question is what that release should be called.  A few
> > thoughts.
> > 
> >  (1) Git 3.0: it is tempting to conclude the year with a big
> >      version bump.  Splash!
> > 
> >  (2) Git 2.99: by leaving no more room until 3.0, we will
> >      conclude the year with a version that is still in the 2.X
> >      series, but will hopefully force us to seriously prepare for
> >      a big version bump with the first release of the year 2027.

Well, same as there's room after Git 2.9 we also still have room after
Git 2.99. No reason we cannot have Git 2.100. :)

> >  (3) Git 2.98 (or 2.97): we admit that we are not ready for even
> >      (2) and chicken out, leaving us breathing room for a few
> >      more preparatory releases before the big one.
> > 
> >  (4) Git 2.57: doing business as usual.
> > 
> > Needless to say, this is not a popularity contest, nor is it even a
> > democracy.  Regardless, we should review what we have in the
> > 'BreakingChanges' document and ask ourselves how ready we are.
> 
> There are a few remaining things I think we should consider in regards
> to this:
> 
> * forge support for SHA-256 on the remaining major forges (I have an
>   update to provide about this at Git Merge);

Yeah, GitHub is the biggest question mark for me, and I wouldn't want to
pull the trigger before it supports it. So I'm looking forward to your
update!

> * any updates on libgit2 and its support for SHA-256 and reftable; and

I have upstreamed support for reftables into libgit2 now [1]. And SHA256
support was default-enabled in [2] now, which was merged roughly a month
ago. So once the next release is out I think both of these blockers
should be removed.

Patrick

[1]: https://github.com/libgit2/libgit2/pull/7117
[2]: https://github.com/libgit2/libgit2/pull/7261
