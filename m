Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED6156F5D
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094380; cv=none; b=Bkwtd+TH82RMBefbRucTsQKePo8AHV4jm4TKPfbaP9PdkKEpekulG6J3zhvggjfhnNbWyEFGkgJpsUviEut5GnKlMWcAclUQHNob/clgpSI6mHOOlCw9KKft4xWoRx3tPxNkC6Qb28dghmf3cFK6Dq9NASv/tfTInqSXO6TLKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094380; c=relaxed/simple;
	bh=b3zlKS6ZOM6SIAR8dv929VHdeLzI+tQWdmq7BFiZjcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+LD5p8/NDzFPFyhXvcz+dbkwsb0ZSSRF4uQSj3ZWXT5PrB52D9P97md8HVsAobMH8x5EoHHQjpsanoVy8GifgB+4APdSJM74gef8Z6LMuP6F5MUGAm/PY9lVPdKtt17t8mIja8tLkRpIdZipc3mkqkW015vGnFUIWj15oxfOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rYqF3oo9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWXwWPo5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rYqF3oo9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWXwWPo5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 127E325400FE;
	Mon, 28 Oct 2024 01:46:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Oct 2024 01:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730094376; x=1730180776; bh=cJoHBpIYz0
	puFe1ddbe9lfSkJk3yFWftQD24CJ9OK6o=; b=rYqF3oo9GX3oIUC4pIfS49J2GC
	40DMqIR1uj90ziQ04AO53/1fW3Bk8uzKZdf+Jdc94zHwQxva5/c+t0/wg+DfRVQr
	ZZdl5BqSqeb0/E/eGdjCEY/p3XAXMXw2k6a6OUT7ypH2JVECQc7eOXejVUb2s4yl
	Fu72qc+2+urcbcoyEhhIfkmhnHjCCPO+rKcKh/j9gC+UZ/el0t0VWC1rVmWy2pon
	69zuCPP/exaG77PUuQ/A/0hO84xjjbaGypdYg+SWj5PAVnIvDi5ClarQnDL6DdHC
	o7ElzKxB1i4YP01/4N/6rs36g49i5J9/hGZcO6oczuM1j40xshRb7G9JRQ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730094376; x=1730180776; bh=cJoHBpIYz0puFe1ddbe9lfSkJk3y
	FWftQD24CJ9OK6o=; b=BWXwWPo5fFnG6oE+VrcOcCC5Y6otuzha1K1Y5K9JzbVs
	ULtz44I+Efic0rSImlJvZOip39JMBCwTH/1dZcLIWdxHyLWEovhLGPflQ25wnf7A
	ARkruehDdzM+ewHZgLBkMnHxWe64rcoHifgjGk2AaAu+XxfpMCNS8EZ++rWGJ5Nk
	hiU1IMCTwsFCOKEBNRetKmOZDAtRBqI/+2P7uF9dZIqCXivq24nGs3t/blGaTjZy
	XTJsLiga4D3lBmmlCzxVaQCsqEAcoQJX7+SQNmxDcg1D3Gk4WiHDyuX2HmP4Ayy3
	GEQNe5wBWQpxFhi1lRtUBWyagGuJNUelGOmhsgfqug==
X-ME-Sender: <xms:KCUfZ04Rkyaku5JHfJfC5UsVj8LdCFFlR8kp2z_6zzOVxKrwBI606Q>
    <xme:KCUfZ16OCG7j7cWXcqvTpICgDDmpvXUOrJJMmcPRDctKhekIAkZ99xDI3TUSDp2XP
    FewQSROpIK6x6qbHQ>
X-ME-Received: <xmr:KCUfZzdqlUPEQ6z75yrgV_yyl8HUkDRWRRWhPukzYY64CTFxS17svL_jnIZw1opbL-RpzoXYRVAgpbCxKxupBh9QZ9DbLneoih70t3x0vOLKhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekie
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KCUfZ5IPo-XL1S-tuD8vsc2IcHy13UZRyJJZguj0OTh_LvQpCVyzEw>
    <xmx:KCUfZ4KRRnmC1pJL5VGGV_gqiYjU3MVP5smB-vCZHHk6pLvXnblRRw>
    <xmx:KCUfZ6xchWohahaa61_HRLKhAtkZ5UXkSyMbUK1C5fUwewv0gX6Frw>
    <xmx:KCUfZ8KOODVWXLnShh29M3xAvA1yz2BcljWBAFvVGxyh-9sB0DNI6Q>
    <xmx:KCUfZ2zyG9N-4tKCswhW-UzreuKbm-36lv1CTTWgiuZ36kbf1vOY9VQh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 01:46:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 304a618e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 05:46:09 +0000 (UTC)
Date: Mon, 28 Oct 2024 06:46:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <Zx8lHzDyqyBpzrAE@pks.im>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxbLFLDgCm6wLmB9@nand.local>

On Mon, Oct 21, 2024 at 05:43:48PM -0400, Taylor Blau wrote:
> On Sun, Oct 20, 2024 at 01:43:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> > Updates in v2
> > =============
> >
> > I'm sending this v2 to request some review feedback on the series. I'm sorry
> > it's so long.
> >
> > There are two updates in this version:
> >
> >  * Fixed a performance issue in the presence of many annotated tags. This is
> >    caught by p5313 when run on a repo with 10,000+ annotated tags.
> >  * The Scalar config was previously wrong and should be pack.usePathWalk,
> >    not push.usePathWalk.
> 
> Thanks. I queued the new round. As an aside, I would like to find the
> time to review this series in depth, but haven't been able to do so
> while also trying to keep up with the volume of the rest of the list.
> 
> I know that this topic was split out of a larger one. It may be worth
> seeing if there is a way to split this topic out into multiple series
> that are more easily review-able, but still sensible on their own.
> 
> I haven't looked in enough depth to know myself whether such a cut
> exists, but it is worth thinking about if you haven't done so already.

I'm in the same boat -- I want to review this, but somehow never find
the time to sit down and do it. I definitely won't get to it this week
as I'll be out-of-office for most of the part.

I've flagged this internally now at GitLab so that we can provide some
more data with some of the repos that are on the bigger side to check
whether we can confirm the findings and to prioritize its review.

Patrick
