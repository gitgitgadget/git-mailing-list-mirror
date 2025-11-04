Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C14E2E2
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260031; cv=none; b=mBomEw8yoUYUN6IgkfvZhI7bHTqT+ZPE1EBhIN68I5vxKHEIZv7LWlQCNLc5Hu8sVscZwKfLeW57Bmx0ZiT6a3oFahepc6Syl8zP/xsJwEHuJtTRvWET5DTAv+eMDUaa3enNR9xIKc5Vu0t60CokttzNauAij2C/KXo9mgr+jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260031; c=relaxed/simple;
	bh=1qa/RipiVNkHxtEtJK13Xg4+SJrLOEbjeV295PHLGrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfkWpGpEdT9VqFn3Voo4PznlygNg3eOlM0d5sVG3PAZxBdsaiNcqlHnB8Aw950SKFsD2mUtkKnc7OJI+P7faTprk95KU9RONJilbcqdW4vUcwC5LVgWMKsjrqd+o50Iq3LzbhCiCnqKbZN2GiserBkpcMC5fMt130AUZYPewKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=orcmhkzv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=shR0zHt6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="orcmhkzv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="shR0zHt6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD3A47A0491;
	Tue,  4 Nov 2025 07:40:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Nov 2025 07:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762260027; x=1762346427; bh=qw1YZBnNKe
	HF85nD5nKzbMba0kotnlVPNWJ/iLTOYrA=; b=orcmhkzv+Fy+25NgGuI+i4bXNM
	gMeildM/H9UQV4a48P9V9gSLzflnuFDMZnR0q5NNmN10m9xoZiNX+qRaN4SBR3A7
	+5d/Ue+xuTwDvBDKwruFIWL3TFZ7rV8YkRnK7XPVK8o24RjSkiMgWVOlNOgasAWL
	BoD7Krasa1tKXYNNtMbj8MgeUUnoNxXbNgzBZ59hPnG2QDdiwSszDvDVYsHLXKPv
	6VqrWRKwlxBeizekTWJZg7L0XmA0fAe0noUa34adymAq0Eo/3wqgRn37enS3vmfM
	3+7rLd8A8An97RKe9U5QfhuIMqgsJQz1CZIIdlS/hDCHspQRjcaAQsFrExoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762260027; x=1762346427; bh=qw1YZBnNKeHF85nD5nKzbMba0kotnlVPNWJ
	/iLTOYrA=; b=shR0zHt6i7yptKXVGjKbsyEHR9U3Nz7QS8eeBeLzQbASn3DLQD9
	pFP8q61PCsjgUbonXEFtTyK8yNo3nV9pva0KW5dUuYfvtf2PSELD907txSomniCP
	cSeY0UVNCpfMnqq/hsp5h4BkT7Crltm7wHjxsn4WlZWdcAvBePZFxnAVhUQcgfsE
	tQ42aAX20GFg49EMmqC4w2Whh+F+A0r5ZB24hl7dpmKygDEAqOmUrV/CiFRZMMH0
	ZUT/QcwTJ3C8Fzzfmkbn5jLHpeFbqMzRrq7597S/lk4EeU98flPSrkl7pf2BXkfR
	Mfc7qBYqDTY4SmKr4sqQpV3rvjDY9c/iY6g==
X-ME-Sender: <xms:O_QJaecSNnfqzp2jrKL6N9dfyCi8RfqHb1s7MHoVs04PMyw3_TKQkA>
    <xme:O_QJafqNx8fC9Vr7NhUFToDitCON1rDn5d2uw30smVgiRABX-MOYxy7ZXM-RjJq_1
    EtnKzJbEir_2UCz_JQg0-j39g8Fkqnkpq6ufy8syA5qRbcCuyQ->
X-ME-Received: <xmr:O_QJac4XfDzBC3SML8B7SGOdwSyKOE1RczVU2Y5K4fJ1TMV3W_7-MuWsG5_ceFmN-dR_XUhj_FiJrjnqPv8hATnnklP2Qg5VVxSq_V5xFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O_QJaVq667wIeKIDRXirzQwdvUgh37NjOd7_lOMMxA676YwGcK3GVw>
    <xmx:O_QJaeivJHv3J5VI1FoZqOrwQJABiztYY0BNoe91dMVNykSJ2714Qw>
    <xmx:O_QJafLWGsnvaFxpQZRmqwtWjaX4OAptUNtVLzwKUlxvD1NEPqfB9w>
    <xmx:O_QJaeD6dS6-xsqIdOCF0nd0B-vFr8QP-wwb3nYNynSv8Ha1uBJ5Nw>
    <xmx:O_QJaYZ4_DHMB3Q8KR01yPENO3OcYlh-MEGrWtrEV09EJupdjeJl3cRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 07:40:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7ae7d31 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 4 Nov 2025 12:40:24 +0000 (UTC)
Date: Tue, 4 Nov 2025 13:40:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
Message-ID: <aQn0LyW248iNDpkf@pks.im>
References: <xmqqpla43wcp.fsf@gitster.g>
 <aQRaRuBtt_r7SamL@pks.im>
 <xmqqo6pjt2wn.fsf@gitster.g>
 <xmqqh5vbt0sf.fsf@gitster.g>
 <xmqq7bw6ubaw.fsf@gitster.g>
 <20251103213059.GA2528366@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103213059.GA2528366@coredump.intra.peff.net>

On Mon, Nov 03, 2025 at 04:30:59PM -0500, Jeff King wrote:
> On Mon, Nov 03, 2025 at 12:10:47PM -0800, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Bisect points at 054f5f45 (ref-filter: parse objects on demand,
> > > 2025-10-23), which is unfortunate, as that is the motivating step of
> > > the whole topic.
> > 
> > Here is a fairly simple reproduction.  It appears that this does not
> > require the refs to be packed (i.e., "t7004-tag.sh -i -v" fails
> > after saying "*** Loose ***" here, without moving to the packed
> > test).

Oof.

> I think the issue is that nobody ever resets data->maybe_object. So it
> is left cached with the very first object that gets looked up.
> 
> Something like this seems to fix it, but there may be a better place to
> do the reset.

Yeah, I think this makes sense. I'd attribute the root cause here to the
fact that both `oi` and `oi_peeled` are global variables. I didn't
realize that and thought it would be populated for every reference
individually, but that's obviously not the case.

Only thing I'd change is to instead call `get_object()`, which is the
entry point for `grab_values()`.

Will send a patch in a bit, thanks both!

Patrick
