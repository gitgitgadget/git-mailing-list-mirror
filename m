Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44121552E3
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538328; cv=none; b=Vo7aC4454azPAhPJeXRoL6cH3S/xb6/i0hC72TTqZUPHq0J77k3eoE0vQOxm19M4lqOhDmxnXW4+5adnfKIWbTGt3mRSd4P3oqWksZ3xK60X971XyrWpsXZd+BYpbci75kR2sDsS2tJML94IyYcJ99OKTw4n+ri3hx6nsNxk0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538328; c=relaxed/simple;
	bh=gZkO50IeA0ukmf1WM4fKOZpfpcelhcRRayRBjAvW8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZlM/CRBPwaLNKlJXsSEt++9giKXBh5fEoTG5M+1wyN7lnTP3ODtqMjW9pUdAPHsiQyFG3DWWVUhZnkQj34gpd59f6S689l1KQk/CQOKHiD8Rd/hvG/OzPOqxGfxVU8u7mDbd2ad0Lti0i1G2vFGbfuqKXNcDfnEDQruiTR1W48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D3kYJz7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OE/aazGF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D3kYJz7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OE/aazGF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB79711401E7;
	Mon, 25 Nov 2024 07:38:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 25 Nov 2024 07:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732538323; x=1732624723; bh=ozVRfFegdO
	5BhuATOqxwttigsH62l/zpC/ajzeicZnU=; b=D3kYJz7vSjQs4mykJ1DPlFCL58
	mZewQh6lu4qnWiyFxoUCKT2aGHhJ078EwPcK5+SIuAJ1n3wWgXuWUfnGTaHSO5RR
	WsnJeqmsjV37uqCJxMtFJr16PpXCnCkS1l2NJJ3SMbs6lpdQxxw7mQZOpJB//1ZB
	KP4sE373yp+oBvamolBtQuJBuA8W34CtbvPZxTLwO3JIKpmeLdI3GST07CDMNYu2
	NhsLtVObQVitOEvsPCKOOUXUee/vqorRV+KKVIu0ketHeqKQ8OsamB/bybXFqYWF
	mg16hjQNhCi0tHK/HnC9SvsnE0iQ9XVVJMn3pYNKAPZBThqKKuNJy7df19wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732538323; x=1732624723; bh=ozVRfFegdO5BhuATOqxwttigsH62l/zpC/a
	jzeicZnU=; b=OE/aazGFeVQFewmTlqEyfVHai1+PCvIom4JSbWdSfgV9W2Ohhvj
	S2oeON1hMT2rIcCDMFn/50wuQhcyOek7vEsAc9mrqqGfODCLUNsIB+HwOLpeFmBf
	Kde6K2V5hmMcGmad/PVQaTqd2Y+kTmyRCA+yC7kiLN/UrfXxU9vgp9Eu2Bl/2pkd
	JVTM9ysfgY+DvWF6uMgn9TZZMUa9Sk5CKTl0yRRlO+JR+OLfVUw05+lye/xgXNWC
	rNyK4iRkm/AM3ts15lTuRJYcwy8AkasC/uTDJEESEXgydsfAx+NYq4U8/4ZoljoN
	H7uwwrtMbA5u10bNNYC8baRQAmVi09GWZNw==
X-ME-Sender: <xms:029EZ7WZXLc45QakcHDAQKqeNmwYqKY82ztIo5Vo7t2Jj8ZYz6ez1g>
    <xme:029EZzksWDWqIzPDqFvsQP9Y37V2uhSKLzH41QBKN07IVqMIsbgz1fortQ2MR8B8-
    lH9UEug37MnwICqMw>
X-ME-Received: <xmr:029EZ3ZiMhgGRR2CkQsF8EVS2pYWB4RiYBBWnxi4fLwtuXR2B1Pu84-yvmqRqPppz5RdIKbeAKfOpVxz4JjeGHu-VdgV7wcA8quyvffroFSn-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:029EZ2Vcle8NNew-BIxffxZbuMXQiJXu3Wjpa0MjRirKh5mvJFel8w>
    <xmx:029EZ1nZ-jK8H4xlMQKVvBjsmq4-PJrK0-fYzHj3eUJU2jn-FsT2KQ>
    <xmx:029EZzcdByH5biezZKOUSwdChZEkCTkX41Pkh9IGvxpsOieG9w1cFA>
    <xmx:029EZ_FrmIfbZ58-sOEFsF84WcRP9XryG3K-iM7OZsKXrWepEiLoyA>
    <xmx:029EZ-And8M2ttpzXoiKW8CsX-9iB2D484XmhLPeq4AwA8WlNbdUqD2t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 07:38:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29de33d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 12:37:39 +0000 (UTC)
Date: Mon, 25 Nov 2024 13:38:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 07/27] bisect: fix various cases where we leak commit
 list items
Message-ID: <Z0RvxAkmfZhgo_LJ@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
 <20241120-b4-pks-leak-fixes-pt10-v3-7-d67f08f45c74@pks.im>
 <20241125112746.GA1069812@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112746.GA1069812@coredump.intra.peff.net>

On Mon, Nov 25, 2024 at 06:27:46AM -0500, Jeff King wrote:
> On Wed, Nov 20, 2024 at 02:39:36PM +0100, Patrick Steinhardt wrote:
> 
> > diff --git a/bisect.c b/bisect.c
> > index 12efcff2e3c1836ab6e63d36e4d42269fbcaeaab..f6fa5c235ffb351011ed5e81771fbcdad9ca0917 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -442,9 +442,12 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
> >  			best->next = NULL;
> >  		}
> >  		*reaches = weight(best);
> > +	} else {
> > +		free_commit_list(*commit_list);
> >  	}
> 
> Coverity complains about this hunk being a potential double-free, and
> I'm not sure it's wrong.

Sigh. The whole bisection code has been a bit of a nightmare to
make sense of for me.

[snip]
> We iterate over commit_list using "p". If the entry is UNINTERESTING, we
> free that node immediately and skip it. That's OK for a node in the
> middle of the list, since after we reverse the list by modifying the
> next pointers, nobody will refer to it anymore.
> 
> But we never updated commit_list. What if the first entry in the list is
> UNINTERESTING? We'll have freed it, but *commit_list will still point to
> it, and your free_commit_list() will be a double-free.
> 
> And for that matter, I am confused about what should be in commit_list
> after the reverse anyway. Even if we didn't free that first entry, it
> will now be the final entry in the reversed list. So wouldn't
> *commit_list always be pointing to a single node?
> 
> Should the code be freeing "list" and not "*commit_list"? Should the
> reversal be assigning "*commit_list = last" (in which case do we still
> need "list" at all)?

Mh. By now I wonder whether this code can be hit in the first place. Is
there ever a case where `do_find_bisection()` returns `NULL`? Replacing
the whole branch with `BUG()` doesn't make even a single test case fail.

Anyway. I'm not familiar enough with the code in question to tell, and
it's clear that `*commit_list = best;` will leak `*commit_list` if it is
not free'd beforehand. So I think freeing `list` is the right thing to
do. Do you want to send a follow-up patch or shall I do this?

Patrick
