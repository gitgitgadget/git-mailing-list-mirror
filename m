Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4220468E
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697386; cv=none; b=ud0jf9gQO1H3IxBFYMhZiGqj4Ch+NgJVh5+omsdC1hYTTXC0dI6esizdFLjxRg8BVWaUqt14yIcywIrttWL3erWU/avXdXiRLfFPMlgJ4tzSHWwP6ydYn4J8CkEKiLCT/q0R6Ha0EqX2wnOvsLKqN9jC/7VWfWYe+4UWUhLzhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697386; c=relaxed/simple;
	bh=0CrnZOsxl0c9Y/auq6YW7CcZ7C7wJOyOKc+5cpL1B+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2Bs9ixF1S5bWJN/qH45mTkD8sa4uvWwBHW5adEmr5+E3hUtNL7Xk9JFs5yZ7pnW8vMSnb7a+DGIlvaTrSRDPVAxaQ77uLE+PJZJbweFZjEf2ZvV+zH5XLGq+vLwn7o5lFHNqN4m1pA9f2gFW1KUW0brJwyVz0DLHXy4u095jfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lUDsUpbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pShwdNy8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lUDsUpbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pShwdNy8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 34CCA138022E;
	Fri, 20 Dec 2024 07:23:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Dec 2024 07:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734697383; x=1734783783; bh=mLR+NJtOQh
	eV3BwgW6GMWZk51QqNIs6mQSTtKLa/eLA=; b=lUDsUpbEL0u+4dIf5glUeXP+N2
	GvnzRQ8BZIuC+67uwJ4m0dwoGSgKu5OJkPZhp0P5VFNF+v9OFzmcvjt2J7arKrIn
	Y92TQOGJktPLjJOPYpCY+lSSjWpt/OFEd6RIhDrcDImjBhKCNeQ0nXnIW0njzx6t
	E3cdpOd6adD9LdVv0v7KHfFir0+Q8gVhKRFoDwNq4TfJduSfGv+xJsAxgBi4eHMq
	q54gd5wrHo2mPxD6LpSociT8z3VEq1eCyXzr0ga0h782GN8S6GPOmLa7TpEChrwo
	PEDCNZEKzFriIrOoGExQMUJW1VzndHUJxnm00bneiDQ807HfOgf5KvTjcQHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734697383; x=1734783783; bh=mLR+NJtOQheV3BwgW6GMWZk51QqNIs6mQST
	tKLa/eLA=; b=pShwdNy8eyScHjqSwdI0PxcMAiaJwd5FND76neNnqh1LOn102Jl
	poyVhLbpYmBkltsQKhPRjXHwO/KCXnYtWZfDxpyKoRLh1i5sCKRq88iF7YWI/vgB
	QSvjKbzU0XIcsne5xVY4bdjmqMDngy+YvWENGsQxtNGypHtwMaZYdg4XYff6dTny
	bQYYNI1EYzpv4DWRw8Bc/VhVH/VV+EzxQd7UH103cbPGTtR2ZPrDucTiVqTyztx2
	h/z+nswfsWSaAYlnNMFN+sEXvcXYCiRGr8Lxa1DLO580zR6riDOG+r4ip4/KLOlG
	pSmKS99qgNTCmKcXQdKOSuLFLWGlag69aXg==
X-ME-Sender: <xms:pmFlZ4QnVGbfijPFQJJSmbnBLAKV2gZDoIF4HSoS1KZRIDNjDHbnPw>
    <xme:pmFlZ1yH-1r0fYmZ9azQann0TlPUjkxYEjoQzqBCrpDiDSGnnibi3gYlzIYTEwRzG
    SwHXMM4ByJkJCtcmQ>
X-ME-Received: <xmr:pmFlZ12i5UCP4vxQblnqELGKKtDSejgITAr8s4Ubz76wSP9jAydtS29ensRs-sKi0sZN1IYibZIMUx32lWWdMDMvPumPsAPO-ZOvo1KIbnzsrEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhp
    vggtthhrrghlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:pmFlZ8AbRYpEyJX1T3fnJbNpjQQ5tKbEd1T0BAHBETq-3-jYR3xlZQ>
    <xmx:pmFlZxgVn0fKWvTlSbcJSRy3xrB_yE1_rJNxScV1zEVMcXKXrfMMIQ>
    <xmx:pmFlZ4onti5nuNv6W5Hj4lx_sqhGiOR2cWiEjOIjXD7IaOyvTP_TyA>
    <xmx:pmFlZ0hj6hxuEw6FNMz_Jn_QINU1fIFCvwQpOisR6nMfo9r9wnudkg>
    <xmx:p2FlZxcTOrQ0l85NpsbsdlkH2gJvP6Mo0Niaob4WQewkIpdi-SkEz5b2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2881d27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:08 +0000 (UTC)
Date: Fri, 20 Dec 2024 13:22:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <Z2VhknVFuhl0xbhA@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
 <20241220073437.GA2389154@coredump.intra.peff.net>
 <Z2UlpaDFjvl--zau@pks.im>
 <20241220085626.GB133148@coredump.intra.peff.net>
 <Z2U5cslf10hs_-Az@pks.im>
 <20241220111716.GA140368@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220111716.GA140368@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 06:17:16AM -0500, Jeff King wrote:
> On Fri, Dec 20, 2024 at 10:31:30AM +0100, Patrick Steinhardt wrote:
> 
> > > > I guess. It'll become quite painful to do this at every callsite, so
> > > > I'll add another commit on top to introduce a call template that does
> > > > all of this for us.
> > > 
> > > Is there any reason not to just do:
> > > 
> > >   export GIT_VERSION
> > >   export GIT_DATE
> > >   export GIT_BUILT_FROM_COMMIT
> > >   export GIT_USER_AGENT
> > > 
> > > in shared.mak? Then you only have to do it once, and no need for
> > > templates.
> > 
> > You could do that, yeah, but the user needs to be aware that they can.
> > I'm happy to not go down that path and live with the above solution.
> > Alternatively, this would be what the call template would look like.
> 
> I meant that _we_ would mark those variables for export ourselves (in
> shared.mak, which is used by all of our Makefiles, not the user's
> config.mak).
> 
> I.e., this:
> 
> diff --git a/shared.mak b/shared.mak
> index 29bebd30d8..4aa7dbf5e0 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -116,3 +116,5 @@ endef
>  define libpath_template
>  -L$(1) $(if $(filter-out -L,$(CC_LD_DYNPATH)),$(CC_LD_DYNPATH)$(1))
>  endef
> +
> +export GIT_VERSION
> 
> which makes:
> 
>   echo 'GIT_VERSION = foo' >config.mak
>   make
> 
> behave as it used to (when coupled with the fix you already sent to
> respect the variable within the version-gen script).

Ah, I misread "shared.mak" and thought you meant "config.mak". That
makes more sense then, thanks!

Patrick
