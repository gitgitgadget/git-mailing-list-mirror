Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CC2D542F
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921142; cv=none; b=nnI5nwAHmNM+h95fwHGFeuAd342eEJyt0ClzmntBRf6pCJXJaggdcoQ7hnPpKt+FEu3qBpmAUGioMCchQ1+GXcGf6ETlkY3by2E+BA+5eNRiFBditumjxpwDEyVWrroN1yNMCVabry8G0eZ7Bqr7Q0xXirzMEUnSORADaP1zYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921142; c=relaxed/simple;
	bh=2wfywCIT1/4Cjhs8IK0SRdfXz4Z/FGIXGoqtmo7nl1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeYdgQswyuY+bs8pj1RYo7e9x6ioIph3hpiHSt1f4B5GOwBmPQdJL57DAaBpK+YEeel+mbQQ2He4YzGbI3xkrp/MJi27/d+3zZr/jwWn1gT5Z4FTvEb+Ghh3CBa68HVKxBPpnS4kiZFqXW0dBSkf4Xfemk6plJUOEqKxfKxJPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mP/bEzzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3EsL4Kf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mP/bEzzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3EsL4Kf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98F51140019D;
	Mon, 15 Sep 2025 03:25:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 03:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757921139; x=1758007539; bh=QZ4oX3kGn3
	C3WGdja+YjLlb0csCnN7nK+ySPOmXFOiQ=; b=mP/bEzzGvZhfXzrX3qXxGvLwZ1
	kBXHeFD6MA9uiX2gdVpIR5559dF+QTkxT6lp6U5V4SI3hDVEiLEQfbik5+qC4gO0
	3PvA2BvCdWcgnZbns4wvKRBFf+y6bjUsbiuePjU9qERRSBRc8PHJ9o1we2wmNHi1
	EfwvkC58C+g2vWRwcbjga/r2xUbJj+fSeBZJ7XJH9YIPmI7/oLhgDB/ZvyW5+QJx
	FsmO0Mv5RP1f4lUuHAgFDXVUh8yFprbpOMLTS7hTKjg5VDc1rvxR/3Uh70qXbFDH
	vZs4MmqaGjLVMLxKgAO/PoQn1mmoqjaiHOTVHyzUW6zU0/fMWlqMDWnJdFTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757921139; x=1758007539; bh=QZ4oX3kGn3C3WGdja+YjLlb0csCnN7nK+yS
	POmXFOiQ=; b=T3EsL4KfEbQjxPt7Qi7cZuDcDNLW6lyW99NcZioAmJgZeyy+cR2
	saGjBnQJ+Rrf1ZYcxurcFfbKkFb12vLlWKyGdwkfBgq3Vlp/r8lHthUKLRadS1sX
	Gsrf3FKSSIXnNp5rS7JGSN8AGhEyxxu+7XEgXficFQai4RvEglIj3ECYG35ErnIG
	wPUd+dUcc7nyFB5aiSUAmCsedewSRTV5bny4pOCUQ90ffm/9u68OhdhuZpgAb0Ci
	tyKgH63mwnh0X5Cu0ehAmtDakTvaaJinw3di9rl8f56LcTEw1Crdnj//GSuuxNjk
	fjumm0hBD+cE9QcmdNDyXqE7mBU87iX5Axw==
X-ME-Sender: <xms:c7_HaFRBjJE6UQ_xTnJH9f6-G_JF6pRTo0CZFhV8oErJ-4FdFJwjHg>
    <xme:c7_HaKTb66_n94xKjQEIwERUSnAv4nBQ_mku39L6D5sr_Q8oyEsxmIiiWMzo-Fh-R
    BhACBiy8HJkvEsBaA>
X-ME-Received: <xmr:c7_HaBQHkwfsyJ3u9lj8pXm4bbdCK6aT_qNvFRdoWkEpobwPWtK2nozrNs0VfAvOJLL4S--Xa_R1_vEjPIT93ozDdURMZA7TW0paNUPpvikPuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:c7_HaH64e2Xp1ZFrC_bvalvDVdCUDyQCvnXwAEKuw7qdYt0HK9hoSw>
    <xmx:c7_HaF0bk7nXpHoNh4yzCv1XjSQnBcZ_CWPnCCEGq6Y6sAiJW4CxWg>
    <xmx:c7_HaKB8LWT8zltOLiHAL-uWTAR0q8NA4oMR3Bk3_ipi92t4M3oNuA>
    <xmx:c7_HaIMRRyAULgBjiwXX4iUlUzNx6MIo_zLs0O1A46obWTZvdRgBCg>
    <xmx:c7_HaLHWpuy4J_hDqMcdm2bE6Q4cpsqJ2_6tkV9B_wLGSoLxXx0rxrkN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 03:25:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b715d9d1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 07:25:36 +0000 (UTC)
Date: Mon, 15 Sep 2025 09:25:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/15] packfile: carve out a new packfile store
Message-ID: <aMe_Zu1osrfDnSYL@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
 <aMNd0RkdaW4cWMtw@nand.local>
 <aMNeWPD6spSMB1yh@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNeWPD6spSMB1yh@nand.local>

On Thu, Sep 11, 2025 at 07:42:16PM -0400, Taylor Blau wrote:
> On Thu, Sep 11, 2025 at 07:40:01PM -0400, Taylor Blau wrote:
> > On Tue, Sep 09, 2025 at 01:02:59PM +0200, Patrick Steinhardt wrote:
> > > Changes in v4:
> > >   - Small code style improvement as suggested by Junio.
> > >   - Some commit message improvements as suggested by Karthik.
> > >   - Link to v3: https://lore.kernel.org/r/20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im
> >
> > Thanks for these changes. I think that this series is getting closer,
> > but I do not think that it is quite ready yet.
> >
> > The largest outstanding topic is that this round claims that
> > get_all_packs() behaves identically to get_packed_git(), but this is not
> > the case. I mentioned in a response to the patch that removes the latter
> > function, but I think we should:
> >
> >  - Permit both get_all_packs() and get_packed_git() to coexist for now.
> >
> >  - In a follow-up series, transition get_packed_git() callers one-by-one
> >    to use get_all_packs() instead. Each of these commits should include
> >    IMHO a justification that the change is safe as-is, or include fixes
> >    to make it safe. I think any "fixes" here are limited to "if
> >    (p->multi_pack_index) continue;".
> >
> >  - Once there are no longer any callers of get_packed_git(), we can
> >    remove it.
> >
> > If you want to pursue that in this series, I am happy to review and
> > discuss it, but IMHO there is already enough going on here that I think
> > it makes more sense to do that in a separate follow-up.
> 
> Oops, hit "send" too early.
> 
> The other outstanding topic that I want to raise is that I think
> transitioning away from get_all_packs() to the new API in all callers is
> premature. I would *much* rather see us do this call-by-call when it is
> necessary to do so rather than forcing all callers onto the new API.
> 
> If there is a compelling reason that we must force callers to all use
> the new API now, I'm happy to discuss that, but as-is I worry that we
> are changing things too quickly here.

Okay, that's fair. I'll rework this patch then to not drop that function
and instead make it work on top of the packfile store, as well. I'll
then have another look at this in the next patch series.

Thanks!

Patrick
