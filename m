Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2104246799
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863917; cv=none; b=H5rBL5lxGi8a0Td1TkplNZ4RNrEusIDamsBRFWecxPH51Q1tWdJtg2ZAxwgZn19hYMbBQusLKLgHAl03XGcajvc26flwt3C+SWwgIeG8Zx3b5t2ik0ODbuBfUlSGc/qCuXLKQHiAs2cARkVy8D0PspUHf1d9X0wdl7gY7eTO61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863917; c=relaxed/simple;
	bh=inDJmFSt0wF9YPrHZbWytw01ncIq71njZjvl5CIE5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8yuDKyN8/j3wrLMG4UT4pwFvvieKXatZ1XUy7sDl8H45B1MoVZdLaTfvU0z9Qwiugx19AT8vBdzauU8wfd/0PXulHPhc8jZzf/ZFqpsYhj+zMabWI0+nvJMYi6GdqFYuxTcytTgW7RaE5M0/LGddLyQBKdAxWQpaWk0uXMIYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rr54aq7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmsZet7D; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rr54aq7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmsZet7D"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAC8A14000D7;
	Fri, 26 Sep 2025 01:18:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 26 Sep 2025 01:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758863912; x=1758950312; bh=+hdMqE5Kyr
	W0W8p8yDHxHwHtKMKRS3Tz6U7oI+RGx0o=; b=rr54aq7u8MxZIQXO+QE+hzbnZZ
	0FKmEFpRI15Gv82BJ5iq3V/9dVJRDYoZ/8eGS+6teguPgmBmgNH/1ZAFLSC6ZZc/
	UNE3lRV9D4Vmb4m0b97FB/9MWNSwwln9SmenL8Miahb7VT5hXTBCuogfbW41QjC3
	83QCmGDOVdlebVo+Yb2fbzb20u3s6Z5b4Z3aDtJhLPwYoQqGsbil9sA0t7DGcZXV
	D/ew5wtyn2tx2I8mE78YQOXgLsUl0ew8VZammbevc6zkLlMPiN0m9qhp7W8spPB2
	2pPm3JTCD6E4dGzUcgbWM9tvr19PkNNER9xCJGDsKgLmC7zBaPX0FRELKDQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758863912; x=1758950312; bh=+hdMqE5KyrW0W8p8yDHxHwHtKMKRS3Tz6U7
	oI+RGx0o=; b=fmsZet7D1mZwKzj/EgZvNN27C8SvBQ9T/Ml5tsIGToXrJxZBZS5
	xZs35QaYtEjoqWkLfJ/JJEgsiy14l6JCgI3TLangG7Q0sOwJU0zKSMinzkSCh5Fd
	0YoCsNF2Q0nCPE+riRmhUcan4IW9rm7mzGIx75xHs3V0AWr4UhLI+2vJeZe3I7dm
	1IbStZrtZ9xby7VjWq0um6sc2Ijwj14oAuTE3wKFFG2gAAWrWZgTJ/Qj+EG6wRqF
	MfcmShwhyU9SPJtoQuZ4VEFud8Wnd+6VHy3YhLGo5XN1SH5S9NkL9z8aKP2K97Ed
	AqkwRtmkmeAc0KvlrIwOOq6oKGV+bOc7cCg==
X-ME-Sender: <xms:KCLWaB5z3G03Xd-aLSpXmAGNNMl0Gyh_O9sxmZNO1414Ju35Z5VjJA>
    <xme:KCLWaF64IF1hsdCZ5V6UdX47hoAIs4dxqH3CKpLm8vmURVxn7lqKZc2dMkW9o6Mba
    K843seKt0L8AAaSfXGpRnJf4NSKtd3KNpfa5OGU7qwE6OU1X4WWSQ>
X-ME-Received: <xmr:KCLWaNcBJfXYBwws4YloA9o6-AGVUSJ35A2ot_DK2zj47jdEkTcqRlfquMVynIV9pzP1ykuQoeY3ktwTuMcPETBgYWIwr4nHScXjdnqRrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:KCLWaJAAvZ0IrlmabTS0wOwjAs5weYeNL0Xp7gJsIax0_NpFitUfDQ>
    <xmx:KCLWaA_T-wkunXuPUsmcIUl2HUxC687vezpdMbp-sYz_rsCxjzhC3w>
    <xmx:KCLWaEKlQmKnKAR3UdXg2qQvZz-_eB17WXwIpHtReSW_4QvITl2-zQ>
    <xmx:KCLWaJi8nNNyc-hJq5oL8Jx1sjIv_BRDgDXU4GT9xtKOh2A5Oe586w>
    <xmx:KCLWaG0zM5FIlXcGrz16QEsCFjBOUNzNgxwOxgMOzMfuGM4Doz09Lket>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 01:18:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cdc08f97 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 26 Sep 2025 05:18:30 +0000 (UTC)
Date: Fri, 26 Sep 2025 07:18:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aNYiIsUxR6yNQy_1@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
 <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im>
 <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
 <aMFjGoPhGsRCTihO@pks.im>
 <xmqqo6qyfijl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6qyfijl.fsf@gitster.g>

On Thu, Sep 25, 2025 at 12:17:50PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There is no inherent reason why a new backend would not be able to use
> > the existing commit-graph infrastructure indeed. But there are reasons
> > that specific backends may not want to do so. If objects are already
> > stored in a database table, then it may make way more sense to store
> > additional metadata that is currently stored in the commit-graph in a
> > secondary database table instead of in the commit graph.
> > ...
> > This is roughly what I have in my head right now. And I realize that
> > this information really should be sitting in a design document. I'm
> > working on that, but still need to land two more patch series before I
> > want to send such a patch series to the list.
> 
> So is everybody happy with this line of thought that makes it
> mandatory for each backend to decide and implement the commit-graph
> support if they want to?
> 
> My reading of the later part of Taylor's message[*] tells me that at
> least Taylor does not agree with that position, and I am not sure
> about this design choice, either.  Surely, each backend can have its
> own optimization, but looking at the way data from the commit-graph
> and other auxiliary data files are used to optimize real operations
> (like populating the essential fields of the commit object first
> from the graph, only to read other things lazily from the object
> database, or switching to completely different traversal machinery
> when reachability bitmap is available), we cannot say that each
> backend can store whatever side data they please and leave it at
> that.  The code paths that are supposed to be generic need to be
> aware of these side data used for optimization to some degree, so
> conceptually it is much cleaner (well, at least to my eyes, that is)
> to declare that the auxiliary data files like commit-graph and
> reachability bitmaps are defined on the objects in the repository,
> no matter what backend is used to store them.

Quick update: I haven't found the time to reply to review feedback yet.
I'll pick this topic up again in one or two weeks.

Patrick
