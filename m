Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACE38B7D9
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901312; cv=none; b=aTHExvstMbWZcbcR1wpGRJLy3ZQa+NWdt8pQAcQotna+k+CZM0L3hf1D5YrIFG7s0AXwUE7sH/bo5G6smONvPwOXALYGP+vKQAi/lWynyAuDBb+k5D1q4gqwnNxKOHxkZKmS5cC+R/aDzUQJWJsRIzmhPw1UE9wGS/QNAyFeg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901312; c=relaxed/simple;
	bh=l3oNtnZ0ZIBFf2X6nKWtodNoLFg+/p702sZM/Nj6YUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLdibEBEmfO+yWw3O1P4HIr4O7IQoAz3xqOPvgNuO5azNmfbmKV4oolZUr/8mvHASLzIP315x1Cvoy8LxLsmSBSQ6fdMPAws3sK/okgw74LUN0wqA/tlhjXMT4tcfq2f2ZkT6oSFK+RLtAbMAD4oJuBMVYTDylpZPUKpDlaVI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VAf843DU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1RHotKm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VAf843DU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1RHotKm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A7EF7A0050;
	Mon,  8 Jun 2026 02:48:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 08 Jun 2026 02:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780901308; x=1780987708; bh=ZfJzd8RJui
	BJTjIzckgytO/zZccEW/A7KoRfyYTy8GI=; b=VAf843DUND9OyL0T+dU83KrC4u
	qFTBSA5lVchira1wCNTgD+zPql16deH4QFDij8JM1dt1vKamOY/mcRCIjRGgFzmk
	McmFFED5FfxYw5f8wXua5OeygQY97jQF6nH9t8ABMEDs7CzLnlIGF9Diahh8XIo8
	YTQsj44GQIoOj6CrHPj6gJJW8fj8SmD3m5sNMuFGiEbN0TfOhVctbULqFPdz/yq3
	lLAub6rIw8hgrkSWue4jQImpEdo/vqjUnrxJ7jQ5NJZoQlDeRCoUT3XxCs40xMjU
	7f6YdEc4OcVIfI5Hu3pcs0BtnbTLrs7TeWmYig0g9olHqAhfnX9NBp7WfeNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780901308; x=1780987708; bh=ZfJzd8RJuiBJTjIzckgytO/zZccEW/A7KoR
	fyYTy8GI=; b=Q1RHotKmOCFDd/EBNbvcaRDIuHDODlSpGf7/RJOuXLk5SWtzUda
	OGaC8VtYvxCeGjd7Wtn2gPr+MtrWfolTQeHJN2xtmnuspmP0Juwf5y7GBNC+6TSj
	WTkw3bB7b+LKraJ22hy2eCqPtAuySYwWPOyIBiiCpxaCDjP1zqvqfrRqBNqgSeL5
	S2FUDdFMCfWki7re3Z+EtvyCp4ZVB8egzbRQDpbJWK9ES/qGhbNRzkWPtQ4o/Ltf
	5b9IkcGyHRHBARFhnvLj7k2Cis9KNlVaHJeJOPd6aHg/yxaygzgFPzX1c7wt+Mqq
	loHc9NZE+tA3+Af2AEbnTsqpaZILybfYoSA==
X-ME-Sender: <xms:u2UmahSDWyDS9gZ-wefs5s450EBedwZqKzNEU3KJMc7Y88YUJCaQGw>
    <xme:u2UmasTxy7Jp4AJD8Hd8A_4S9tac0lbE4brBEwtJgfiZcQxqm40vYlwF9EDMK1cAA
    U65xO_OXxEw07K3jzA5C8Pqv1C7LG1iZUShEGaMLZgXowU4e19D-30>
X-ME-Received: <xmr:u2Umam7F0Wmmx2ZKnX3bTkc7FbljyhgWZk_1bk01y21ID7zkEnvNF9qrOYB3M1ZCbC2Pdv8eWqj9EqE8cTzS8DNQg2Hrr8Ic-ajFL4akKw>
X-ME-Proxy-Cause: dmFkZTEV+p9vbX0g54NnYL/7SD4L+BlH2Z+jPlwwu7gtbo5CA37pTT7Y0dA87aYYQOXfAE
    Xle6wJni/r9LGxZKp67HRSeseP/RRLA50sXf5NCe69FHcAYEcjSLbp5cP3Q3WZuO5C5q5/
    KQn2qHxXYZZvrMtVSMTEVm0sb70uox0f/ErCXG0Q9+tFZ27ZekO/S4xERS4JJDDrzEqGLU
    famCGUFdK3kKE+qZknZ0x0uflXmojS44Yh9EAIckiXTB4TzSMtH1o9+yI0TPjnU8nBUBEh
    94zimER3k4aKHxNGAPflnF7SG5EFHin4NTg7GVw34m79iwrQ2HMzuwgehSdCl0GFyXgPkS
    OWujRGObqDzwV24+K3t8sdPK8y+kHLxr2lzHi1QaIm5tOm2auf9o9ESD6r+r8VCWwn0Mxi
    QcoEzu/pKj48hdDCLwi+FuJ7M8dWNwUBUu3fG4Yez1zY3/Em5LXOf+sJ+SAC1PkVRNhlRM
    Aw5wcm2Pu0WBfv1/UEznNo4XRE9hi7pyoxj4v8i0uzrqdpYRea2C85v2SHrGABN3+wgEsc
    6a0B7KqNhjzdguRjA/DnwQ3zZsOiUuk1BpR8QlDyChMNjVV8KNd7YnFNwopIMZX6crzilV
    A3kcWjJ01bwgeMFM71gWd9N5w+u1fiZJmbY7PHIN8H7QXnQS3pQRREnbELaQ
X-ME-Proxy: <xmx:u2Umao09Fu8BBe8tl3rUvedSRAhl-vaE0rS1VHjhAthlWOh0zIEnEg>
    <xmx:u2UmahAr-iEeJYwU5IkmdqIStbeHfb7kg4nhFMKIaUtgqtm05I3osA>
    <xmx:u2UmajP3ZcS1TA4x_HgUGmdwGSLGsvY5oAGM3fwel8t2R57dTyJ8Mg>
    <xmx:u2UmamZtSaFVkWZQo8L93cv8NdgXv012o-BG0QmO7x4ts-mgRPmQRQ>
    <xmx:vGUmaoGfOh-P2NuLcf7qCYDwBCVBUiVI74rG_SSK72-D0oPsYVjLAIUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f338947f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:25 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Message-ID: <aiZltnUUt2Z_6VR-@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
 <20260603100145.7iym5%taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603100145.7iym5%taahol@utu.fi>

On Wed, Jun 03, 2026 at 01:01:45PM +0300, Tuomas Ahola wrote:
> Patrick Steinhardt <ps@pks.im> wrote:
> 
> > The "MyFirstContribution" document recommends the use of deep threading:
> > every cover letter of subsequent iterations shall be linked to the cover
> > letter of the preceding version. The result of this is that eventually,
> > threads with many versions are getting nested so deep that it becomes
> > hard to follow.
> > 
> > Adapt the recommendation to instead propose shallow threading: instead
> > of linking the cover letter to the previous cover letter, the user is
> > supposed to always link it to the first cover letter. This still makes
> > it easy to follow the iterations, but has the benefit of nesting to a
> > much shallower level.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/MyFirstContribution.adoc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> > index b9fdefce02..069020196c 100644
> > --- a/Documentation/MyFirstContribution.adoc
> > +++ b/Documentation/MyFirstContribution.adoc
> > @@ -1227,8 +1227,8 @@ Message-ID: <foo.12345.author@example.com>
> >  
> >  Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
> >  below as well; make sure to replace it with the correct Message-ID for your
> > -**previous cover letter** - that is, if you're sending v2, use the Message-ID
> > -from v1; if you're sending v3, use the Message-ID from v2.
> > +**first cover letter** - that is, for any subsequent version that you send,
> > +always use the Message-ID from v1.
> >  
> >  While you're looking at the email, you should also note who is CC'd, as it's
> >  common practice in the mailing list to keep all CCs on a thread. You can add
> > 
> > -- 
> > 2.54.0.1064.gd145956f57.dirty
> 
> If we adapt this change to the guidance, let's fix also other places of the
> document that talk about replying to the previous cover letter.

Good catch, thanks!

Patrick
