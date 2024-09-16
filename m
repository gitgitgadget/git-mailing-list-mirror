Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCB13211F
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469784; cv=none; b=f/JZqVf+jOwyf34VDFMuVEXtnGlWhg2rJaDU2lc+ZAHV8EIat+KErWjD5haksSNPgYlT29awmccF/e3O/sijV9jGELQhfEQGBQdwiT4WQIQyjSlXTec9uR5UjIJyAiDv6uRuCYiOGzxMLacpk1pPnunMT+XDlHyp4qhoxfHsNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469784; c=relaxed/simple;
	bh=j/PggJ4A63kmxsCPVQI1k8cQWXCpqY4crrW8KvJ1Y9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tck4EguDeV2vIsE9CQ7zKri/JAuA0TVb+m+H4ZY5P8Dvvs80X9uiRoRnirUxWaENKQ7Zp/4myQJtMuzOuiIMgRRxyt7SGonQtSeL0r9pZt3hzROe3PB7yeHfaxdtdnYLqMNAd4n6drPe9wNZFfD94yX/hZOBPxRJ+c10c+4tTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bw358kF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoRRz21A; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bw358kF6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoRRz21A"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 982D111401CE;
	Mon, 16 Sep 2024 02:56:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Sep 2024 02:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726469781; x=1726556181; bh=NF4VYVzQQx
	qf0M9J7yp09YVIwbhXBWBaifsQBis7urE=; b=Bw358kF6BhPMWCaV9HzILFznhV
	6UehxZRqsAOaCCem4NvvG2xe8+6S8zuJVqYeDUEvi4WHeI3DSKW8eU87aOXBGFNs
	9PVp+ZW1Ar4iuW7XcUEj8vcRFDyelh8CKBohBFtr3NvqW6CXxqmcmkc9aNimbuC9
	0mF6KZMj/8VHXh+pVAcGFXxtBMXF5M0kED7ynLQiEEUk3NE+4Wx4SWZQnTZ232Xp
	/goJJ+hVUD3nxKI9CCBT1Hof4m6k4RLUG/jFXo6DYSxJYU+3vHdG2FR/jIDaECN2
	R/vOKaWvw4/CIpDD22NEGf91Ff1rqD3l51gHu00/LAUYCtfRRRbqXSoCwgOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726469781; x=1726556181; bh=NF4VYVzQQxqf0M9J7yp09YVIwbhX
	BWBaifsQBis7urE=; b=UoRRz21A6UlKkstwTh6ezTlkHudHR3EbRf5otToMAoRj
	hp3b/zaw+qaqdZTF+Pkv3BY9BqUs8Yr3tO3Rq+n5Zd+vUqt7KCo70naoHbUZjR3p
	twLz5S+uRzM93h0o4tNDqJt7P+nNcVEM4zQAMmmrp+wze58LJ0OSb5XekfmibxcG
	OzJP4psnW/qiFYdQcq33oApYFHXcc7wOdrH2/9Yz9fYBZx3n4if+Zu//6viHGwF2
	+fWeX4mnYco9fY4yJYl4SnwQCHk03Egz4kzHIWQzPW7E/QC0EDjMfkNDAx6yubga
	B7mNtMZ+80FGJqoiTqW3bdtEFeVIZeRMdgv+p3s/mA==
X-ME-Sender: <xms:ldbnZkB1b9wLuYyG8aJ_lpoOFrX4dKYS2bgK497aRjn7cV002TLWcA>
    <xme:ldbnZmiIwt3q2uRUK9Wj6v3kqxA9RA5nMJpR5Zb5qEkK3bwp1J4paxbveMx4B-Qqt
    PvDnvQM9PbDXDG3mQ>
X-ME-Received: <xmr:ldbnZnncoRm9s8_sP4ig-py2b2l4yJ_ti10bjRph-KH46O1bwrz6TiXME2ZNLEIP-gOUDzo3CyIo-DSE89Gx_Ab0HFcdNiH0S5jFZr0OIFXPtwaP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:ldbnZqwBb8iACkc_6Phr4PPdMFgP7OelGQ_--cjyNfuWFEaXMolEoQ>
    <xmx:ldbnZpQCmAGSEfpr8et-7Ptmvo2L68pMO1mFtctL557dc1biAfmkPQ>
    <xmx:ldbnZlatYHmqpdumdDHy7QTEGHgI50z7Iqgf_qyrnbbho3IBEJG8EA>
    <xmx:ldbnZiSjylu-ekQ0w1dbQ6-qedReX2dH46E31YOwOF01lHlS8Zeo6A>
    <xmx:ldbnZrcnNQ7ssIhUNvuEZBZMc8FBE8QveVqCEU80XttTo6joXQ9i4wdU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 02:56:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b6fe077 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 06:56:04 +0000 (UTC)
Date: Mon, 16 Sep 2024 08:56:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] refs/reftable: wire up exclude patterns
Message-ID: <ZufWlEViXqgNqBLh@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <CAOLa=ZS3XBG4_=D5rCkntJuU0tzV7t=rB95rkNvWgm++Q+xukg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS3XBG4_=D5rCkntJuU0tzV7t=rB95rkNvWgm++Q+xukg@mail.gmail.com>

On Fri, Sep 13, 2024 at 07:48:02AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series wires up exclude patterns for the reftable backend.
> > Exclude patterns allow the backend to skip references internally that
> > match a specific pattern. This avoids having to read references that the
> > caller would discard immediately anyway.
> >
> > The series is structured as follows:
> >
> >   - Patches 1 and 2 fix two separate bugs in how we currently handle
> >     exclude patterns in combination with namespaces. We didn't happen to
> >     stumble over these bugs before because exclude patterns are only
> >     implemented for the "packed" backend. But once you start to pack
> >     refs we exclude references based on their full name instead of the
> >     name with the prefixed stripped. For the reftable backend we'd
> >     always hit those bugs because it always uses exclude patterns when
> >     passed.
> >
> >   - Patches 3 to 5 wire up proper re-seeking of reftable iterators and
> >     adds some tests to demonstrate that this works as expected. This is
> >     a prerequisite for handling exclude patterns.
> >
> >   - Patch 6 wires up exclude patterns in the reftable backend by
> >     re-seeking iterators once we hit an excluded reference.
> >
> > Thanks!
> >
> > Patrick
> >
> 
> This was a bit more intensive so I took my time with the review. Overall
> I have some questions/comments. But the series looks good. Thanks!

Thanks for your review!

Patrick
