Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C5344035
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547375; cv=none; b=UMQ3jV0QcorZkOZzdkrw4CbNWgd1ovysoeePyxE/w9Pl71wylJRIJZ19BMtbPTUSg1dXbMNymIfHq6jpYjUaptXtUrbyujz0n/HV3KueVj1mPgQtwvSGfRN0vDS/KQ9NNKNhsVvv7touyyGF6rSuUsh8dyd6RffKpfWajg42dek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547375; c=relaxed/simple;
	bh=vQVtuSt0IgdgTWz6K9ZF+er5CqK6oUFEHVeUqvrB7rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVyvpE3giKwGz5YPZ0nVsuj3IPNuZRMEExNbiKjbh2w7XZD10oMmyAv1Zgrd69wVYP25IHuMVqOy6vOHp0clLBds1GDynY+tjhiHxeP7+bBLEN0+0h0ZHudSGwP9cEC3Kwj/9tBtEg0WWTgJoEBCZqcon3msq7fmbIeYzYRjlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YgjSil9P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wf9+VWLS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YgjSil9P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wf9+VWLS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12B0D7A00EF;
	Fri, 16 Jan 2026 02:09:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 02:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768547372;
	 x=1768633772; bh=1ZOs4ESL9hUrPqWlzE/+S7Tvubcz7L8snjFw/xNzQ8w=; b=
	YgjSil9PPjKK+j3jBdta0zhInDLhCXHHWF8tfQz0eJF9vBraNzQaPkrPkIrsgxaP
	1eJ1NeLHL7FGUv0DJ5YrQM/huj6My+DDuwh3ORPaGNC0gQrI7X/SxV6J3fXciUGK
	T+xy/9dA3f3DtmUH2pwBNYuU6ndKfoVVYltNdnwdeqrqxjQvU1ok9sCZQGqbrCfV
	SnSwIWZBOYjnfc/XYGtVadstvS2P9J1Tm72RveXpmj1QUHYgM/BcIzaivQdl9hmx
	Jgxqa4Glz+F4oWa6cNH9SWOQrwT9+l/2K8QX4IMq0clSml/OvLW8fTN0BnMIh6Qj
	RM8hGNDbEwjO3zdmheBuwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768547372; x=
	1768633772; bh=1ZOs4ESL9hUrPqWlzE/+S7Tvubcz7L8snjFw/xNzQ8w=; b=w
	f9+VWLS+NI1Vl07HHSwkpwWaAKEqpV1S3bMaWSazd2FeSF3aMVQLYkxFf6ytukmw
	Dkx2EucKGtiI4FM5nwID1AS7S8OWQ3MwyhqBBMJU/EFJSac+/ZTyTtvl3HrKQ31n
	CurcfWPtxnOZ1nY2p1WIJRLnU0zx+94bjrdLj1/35+ro/FQD/4ajt0YxXrmGoz5M
	f1RKzja90L1nA3lf4KhQjeUT8CUCt8WaDgDhT8o7gS+RMoHobPQnbwCvIWBg78Qj
	nXfLs4JCAaN3ROVjTA5hit3aHv9b/GiPap1wHxSfTKoZx7pMuHOHf/UQ613UX7kw
	RZWT92MhhktQWTgT73jDQ==
X-ME-Sender: <xms:LORpaWjDw4d3fMyAZatPYVH6hd82SBfY0i1Q_vVeONlEdXvOlPmCXw>
    <xme:LORpaeeam7X3NgEd0dt7Dqh8tm2Cd5zYdGyuD0jCr3G9wtIGStckZWunXQV1_hRN1
    w4YfkqtbBAXWLeSjVOX0hcJArZFEjD4wTkzgWNhivkw9B896Tj3PbQ>
X-ME-Received: <xmr:LORpabeG3nMGFY_PkkshFNIjNPtQJ2fStQMxxwQg2r7d-guqbLk3c0AgUsEPzUaMFkRm0pHePVnlPXs6pVaQbGuMsiJRntuRY1LKoUGYPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:LORpaY9JRg7x2082N3ZbvLdm8PBQ3mPrvJmGquRdnRfzOwHcGu4xgQ>
    <xmx:LORpaXlHOXYBnFkyQd215ovdvins_i1ugphJBHZXKHlNFu3CK_ydeg>
    <xmx:LORpaa-lt6gDbO_SJVECb5f07iSHUBRo5XPDH7B-N16mcxuoYdJMRQ>
    <xmx:LORpaVnPM8KwfA3f67fMsz1Sk5Pg_gS91Row2mI40tp0Get-yNXASg>
    <xmx:LORpaZEjDLyDZeJyyxVVsJQbW96Q9Z6K6VVyulEobhDMSwpK2kxu1oaR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 02:09:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ee2fc5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 07:09:30 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:09:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
Message-ID: <aWnkJ_GpgbXBPwFp@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im>
 <87jyxjjejz.fsf@iotcl.com>
 <aWjVWC71rFeTsHLP@pks.im>
 <ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>

On Thu, Jan 15, 2026 at 03:34:50PM +0100, Kristoffer Haugsbakk wrote:
> On Thu, Jan 15, 2026, at 12:54, Patrick Steinhardt wrote:
> > On Thu, Jan 15, 2026 at 12:33:36PM +0100, Toon Claes wrote:
> >>[snip]
> >> I was thinking about mentioning something like "commit-ish" instead, but
> >> I felt "commit-ish" isn't a commonly used term toward end-users. Looking
> >> at gitglossary(7), it says "revision" is a "synonym for commit". I'm
> >> happy to change this message, but I'm not sure s/revision/commit-ish/ is
> >> the best change for this.
> >
> > gitglossary(7) also defines commit-ish, but I guess you're right that
> > revision is the more common term. I'm a bit surprised that it's defined
> > to be a synonym for a commit, but oh, well.
> 
> Surprised that “revision” is a synonym for commit? Why is that?

Because in my mind a revision can resolve to any object type.
"<rev>^{<type>}" for example is a revision, but it can resolve for
example to a tree if you say "HEAD^{tree}". Still a revision, but
definitely does not resolve to a commit.

Also, it's confusing to conflate the way to name a commit with a commit
itself. "HEAD~10" is a revision, but taken by itself it's not a commit.
It's not even clear whether it resolves, so it feels sensible to me to
keep these two concepts separate from one another.

Patrick
