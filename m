Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3E24293C
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910321; cv=none; b=szh4/XepF3mokTfClqQe8Q2cwMKoZqW2ibfuXJAgjx2wS0h4Tg+pXxHKQhfU7uI6SNLRE688CQ1U6wRpIVlFey7EfBcctByrAo9TAAscgv68/iS3z4xaIghLRiLng5FrI2Ray+im4I4PQgPU3csKessU7pJAj0er7H+oW+JOn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910321; c=relaxed/simple;
	bh=O3TOYRLwMRBh0jrFVRpRPaB4SG+a4jBBlujsE7pEIPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCMsPWhS08k6GXh37xAGv5b6O4b+J8WT6sIFU75roYXvQXRkYn3seiDk92bRNydvXNDiQFLv0nQwVM4Y1RFgyKItcGVnZBxHIC4hYqXaN8y2wwlK6iXOrrwDFRC1jnj9h8hufpllbmh6mC9vNzirrQCsMOtwsLu8W5XIl3BN/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V2MbWeb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BthxT6qM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V2MbWeb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BthxT6qM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0742C7A0109;
	Mon,  8 Jun 2026 05:18:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 05:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780910318; x=1780996718; bh=4yWxtadZxq
	3QvUwRsm6SJjT3lIAZc9m/FXLIAASbJqk=; b=V2MbWeb6WsGNLdPjddpihhmhiD
	HvW2O3psSNjfQRJfy8gjGze8m3TSDhzDmXralYi5+NTv8QX5siAwHWCW9fqFDAIP
	y2tcS/VCC2iFVRUTMBZ8oFhvs2BTNPPuSTP5vC5O+MUfvMZsVOkAgVMzmeIG6go7
	OGsJyPnRB/2PC23Tn6jYUTby8ocudI6sWST9L/4KXMcbJeKHO6szSKjDnXL1l1mQ
	lZt0ToWaCzqkoewbwptI8Dpiq6ooMY+Ghdr36w3CC4kAtXyTc//D9M5sB4PLxkcf
	fHILqOGb5Jyf9msmDnB6aeXyliwDEL938KvjID75zO9BwVu3BXEXiptL1Uvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780910318; x=1780996718; bh=4yWxtadZxq3QvUwRsm6SJjT3lIAZc9m/FXL
	IAASbJqk=; b=BthxT6qMfGxityaJ0hm/wA1zQO36WYLqfuZONA1m/X0BIGDEzdN
	aQSC50EW/Je6O1vt85Sk5EVI3qa9NWkAGNvboM4V+/uFbpk9ycRbRdGJzskoQvFO
	nbWzFJ4D8haQsQ3GnrWrV+wnVZeejQ2tXobcqQCajxm7CLf/A5OQ8nxkaM61jnLB
	mLv379YJx2MTKdagnuHlB4J80qDF+MDJtoBCSuuCHoGblxBb+FwMUlwOqamjCByI
	Ydz9FrologZ6XaZADZjF4OzRcYvicU9ZU/FhxhOggUCD3gtO/rQOhRm+bQyKTBUt
	E9LLmK0IwArfnGsPeZ5PuH4gsQPai2/IHrg==
X-ME-Sender: <xms:7ogmar14js4fbcrV03AyvA2A5Uy9Mfci0HwbO5jNbMsUk5Y15Cya3Q>
    <xme:7ogman5EfwD-HIuLRiBp-d6GWgxYJWkGmCeorWTyCjUu2A5ag4oyOdO-z0YcB1aDI
    cTb2Jr30WRJIiNCrhEykT3IfzVFHnC6ckIosSQ-8awXsQkV4xGg7A>
X-ME-Received: <xmr:7ogmamWTIqOp52RJG3In1E614qvXrZcQ_s7wQj0FS6IwgLxcPCYljURqlknAmk-ESwNP1unedtJIuXbBc2YaK4ePAxCk0cMknlEltO_Q2w>
X-ME-Proxy-Cause: dmFkZTEdJ7oGit7gc7RtQdPGDzhWG/I2Y+E4tSxTs30Zmy/8wonaAgC5O/lPp33YHsKM9F
    yz9m2rVVO11WXzMQHt5Lt50Sv6Hq7uhnqikKykGCNAyWS9LemmNAeCV363GvpDhe2onvqy
    ktQS0LoItHqPyhcDBWQF6Vo/O/2zNgt/wEZYoIMWEloveX+qXpoMoaLfzFHJvhuHZV0bjM
    EyK+1NFeeeHeXD7ihHcGlDDN566v9Vhs5tBd7pVbKw7CZvHMXNvn6EelwmocWRQmutivp/
    xNzQI9MwdfgbPYgfaIn+mH4c1TgF9dgmURh5T2Fv0k5vJx+vkDb6wbOIzHsvqXOtRg7pdT
    ckpbHqoJoqhVJHcVcredtnztShYmeFo/7B6KWMo5XTZkIidnSqlTrybYcKud/Y+QJ7d8xC
    7Rc4mH4YCWHMwYyR+fRasDq1QGojkpdAB9pPu0eboB4faKjtJB0qjmEgFAVjkQRfrBVB/F
    SjLT1bVLNgOk5QARJfX3Itp0koZrAy87vDLf96ehdS95ArCoCb6Z0vDu7vFzlkCbsmiE90
    twPvlf2hZ44ISTplZR+PB701dG+zpr6hY5g8TuuUPmQd5qglenkSuIEqfzyjy6OFdeCA+x
    TlAbZSWKZufNl8y+3jD0nbrKUO5S8gTFARvGLSgkglk6EFWCbRN3lOpxVyRQ
X-ME-Proxy: <xmx:7ogmauDN10vgEiY4oj2oXPED5NmZ5ccNisDe8RfozX2kD2nuRoMCEg>
    <xmx:7ogmat77RMCiHFwXNau8jHhCot5rjqdZaSML90gwH6TwXlDiwiYJdw>
    <xmx:7ogmahyYfaf_bwV8zWzOjVLuKsZhLOLVFF_bfPBUCZ4XRxG4jEdATw>
    <xmx:7ogmasx-BUwILIgNalSM3e5jBh08VdGE7GWP8VcLwUi_2vBebWI8IQ>
    <xmx:7ogmasR2FOM_KQMb7ZA_ijtqZqjqvLZMdHcQHwLphWCVBjt86U30aOPc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 05:18:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95ae95f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 09:18:36 +0000 (UTC)
Date: Mon, 8 Jun 2026 11:18:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
Message-ID: <aiaI6thDj8y_EekG@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
 <0fdaeec8-99cd-4dc9-9549-8a08133deebf@gmail.com>
 <aiaH3ZmFZfmWYwr7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaH3ZmFZfmWYwr7@pks.im>

On Mon, Jun 08, 2026 at 11:14:08AM +0200, Patrick Steinhardt wrote:
> On Fri, Jun 05, 2026 at 04:12:42PM +0100, Phillip Wood wrote:
> > Hi Patrick
> > 
> > On 03/06/2026 17:14, Patrick Steinhardt wrote:
> > > In a subsequent commit we'll introduce a new caller to `reset_head()`
> > > that really only wants to update the index and working tree, without
> > > updating any references. Introduce a new flag that lets the caller
> > > perform this operation.
> > 
> > We already have a flag to update ORIG_HEAD so would it make more sense to
> > have a flag to update HEAD, rather than adding a flag to disable the
> > updates? It would mean updating the existing callers but I think it is a
> > clearer api and it avoids the pitfall of
> > 
> > 	RESET_HEAD_ORIG_HEAD | RESET_HEAD_SKIP_REF_UPDATES
> 
> Hm. The question is whether it's sensible to have
> `!RESET_HEAD_UPDATE_HEAD && RESET_HEAD_UPDATE_ORIG_HEAD`. That feels
> like a somewhat weird request, too, and we'd have to introduce extra
> logic to make that combination work.
> 
> > I wonder about the function name as well if we make updating HEAD optional
> > then what does reset_head() mean? Maybe we should rename it something along
> > the lines of reset_worktree() or update_working_copy()? I'm not really sure
> > what a good name would be.
> 
> That's a good point, the name does get somewhat awkward. I think we
> should keep "reset" in there, but `reset_worktree()` to me reads as it
> if was rather related to git-worktree(1) than anything else. Maybe
> `reset_working_tree()`?

I think I'll skip these changes for the next iteration for now. The
patch series has already exploded quite a bit in its scope due to the
refactorings of `reset_head()`, so I'd prefer to maybe do such changes
as a follow up.

Let me know in case you feel strongly about this though. Thanks!

Patrick
