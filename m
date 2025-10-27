Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53B2F9DAE
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564099; cv=none; b=CiejGi6hv3JqvJ9TKa4eZzeOMNF3seRahAUv2qVK3FkZjTiQiBHz2KtcuSIqqdfAbfEJP4gnRWKGOMukORkKOrNahty0rqjk9QzV7VLwP0NC7p4aSBzx+JHFqaAoHLxkvF6WFS2zMDcFtfP4hpinFTiug+r10gflZF+ynosnjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564099; c=relaxed/simple;
	bh=Bw5tJQjOhlWbmX9k6Qt09q5L3pC71GDSt7DE3IduwY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmHZnOnbpwpOHq8dw9t2EO9/bA7sJPuPwtL7aot79HrzbafKA91rYk1QDxuoQvXS5JbG0soL/IgUexPoAKHhwBvfx6eWcMgf1CrG6WAi+JG8polJiaWEYE8T2yB4mZ6aRpHDlIYuKCB6kajopHYdR4YJRmaYf3F9WCNIrX/KePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IcmTRb3N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCUxORfm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IcmTRb3N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCUxORfm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1003140006E;
	Mon, 27 Oct 2025 07:21:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 07:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761564096; x=1761650496; bh=Nf3uhHAw3b
	2o0e9VcgmwbCzs7syGUTobW/F10IR9h9I=; b=IcmTRb3N4JcU2R2v8vFWuZu8lv
	FmR7VeayCXtpQPxNupsyOxOCYiv94ozG5HH0THfuc2smFw2yasgH2hlaDEQfHXcJ
	Iuxkdd8SQjlmExz/Ty4TvPgYc0mN+a2NWPAIEJuXLFvySPAEZSOXy9APnmQC9dS0
	TDgFq+aR5GghA8e6pZHaDLnkj0KgevyUj+JIiE+b6ADcXP6vhIeYd3qyRXwcKqnf
	3idTUDhHHHH2wq+L3PSUyq1C/zozzhPXfo+djm9Fa46aakNKXdiR0uwzJ6Tj6SBN
	gTagf3zwS100q11tkawiHSOqpH7wZsLtVnr3xLnhLxJ/GOdBMQ6MVxkZlWXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761564096; x=1761650496; bh=Nf3uhHAw3b2o0e9VcgmwbCzs7syGUTobW/F
	10IR9h9I=; b=RCUxORfm1uRziD9l3+1zOdM0zNPTWgloDE3R+IgSPvQBarUcBfp
	oT9m/wEv/UIHzBEh0s6Gz1j0LyuVa/WJgNiraODEmuUKbIReUKj27uJKLgrBsAmc
	oZFNDJkTtQ9O+wlxGkst2UgL4bDH97UoLugFmjL7LlyKRhyUsbO8Rrw+CyY4g9fH
	RXnqFCI6PLAHL7A057kQgQVYG18Pkt32BaVuwfkPZUaFfMtqZarhG75usjLslxyF
	ehKfXIXjQiAe0ZUEOA0OGAwWHS1RjfKLKnW5cdjuL4lrjqc3sz7PC7lU+AS/icbG
	U+hIt1eTuBUIAYMmCNfmGY0Rcq5f85aX02Q==
X-ME-Sender: <xms:wFX_aI6QrpWx60lu2EuBRl9xMVk2cmXU0rqzuu0xOZ9ooRRTuKcOvQ>
    <xme:wFX_aP6_rtBjqqcwEe6jbPW8xN1fQnhsAucSFnIuJl1SIgBeZC63dYZaDh9PyZap_
    -4IhBv-zkvNLESJB-F2wwYC0sTRTgPxIs5WFpgqdNE48WfebFioeQ>
X-ME-Received: <xmr:wFX_aFHpVlG_gzS-Ub2JuH8G_hHLhHWNLzm1Dld-v7eEKK-c_gSWjhZ1OfytWFIT00rxzJlQbUbTktG7WyKdHUH_30tChFrZu0CknHdwkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wFX_aIRmJjRG5u3E-RjysPgJC6o0wzSvkuNgOahW0AiqB06v5Vwx3Q>
    <xmx:wFX_aOu76pdYvJSdZYPR_sogiV4G5yqK73T26417qtFXadc2R_Ejbg>
    <xmx:wFX_aHwQAziLpU9BhfR_fZ_F14pHOIsiLOlGHNcK5SVObhmz8s6isw>
    <xmx:wFX_aI4fAjBiksFQP9pyHutF20-jfBjkoEwUF1GCzBk70RUO1qNfvg>
    <xmx:wFX_aMT9DJZciLOVGPegnn4dpytsskIe6BLPxAOnGGeUmRYhhmxt_JXK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:21:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59c192d8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:21:34 +0000 (UTC)
Date: Mon, 27 Oct 2025 12:21:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] odb: introduce `odb_source_new()`
Message-ID: <aP9VutHav-f37NHw@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
 <20251024-b4-pks-odb-loose-backend-v1-2-1a4202273c38@pks.im>
 <xmqqjz0kp86k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz0kp86k.fsf@gitster.g>

On Fri, Oct 24, 2025 at 09:37:39AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/repository.c b/repository.c
> > index 6faf5c73981..6aaa7ba0086 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -160,20 +160,24 @@ void repo_set_gitdir(struct repository *repo,
> >  	 * until after xstrdup(root). Then we can free it.
> >  	 */
> >  	char *old_gitdir = repo->gitdir;
> > +	char *objects_path = NULL;
> >  
> >  	repo->gitdir = xstrdup(gitfile ? gitfile : root);
> >  	free(old_gitdir);
> >  
> >  	repo_set_commondir(repo, o->commondir);
> > +	expand_base_dir(&objects_path, o->object_dir,
> > +			repo->commondir, "objects");
> >  
> >  	if (!repo->objects->sources) {
> > -		CALLOC_ARRAY(repo->objects->sources, 1);
> > -		repo->objects->sources->odb = repo->objects;
> > -		repo->objects->sources->local = true;
> > +		repo->objects->sources = odb_source_new(repo->objects,
> > +							objects_path, true);
> >  		repo->objects->sources_tail = &repo->objects->sources->next;
> > +		free(objects_path);
> > +	} else {
> > +		free(repo->objects->sources->path);
> > +		repo->objects->sources->path = objects_path;
> >  	}
> > -	expand_base_dir(&repo->objects->sources->path, o->object_dir,
> > -			repo->commondir, "objects");
> >  
> >  	repo->objects->sources->disable_ref_updates = o->disable_ref_updates;
> 
> Everything else is straight-forward, but this one is trickier.  When
> the .sources structure already exists, we used to just change the
> path in it, but now because creation of .sources structure requires
> path to be computed beforehand, we need an "else" clause to handle
> the "when we already had .sources when we enter this section of
> code" case.

Yeah. I plan on revamping this area so that we create the primary object
source only after we have figured out all details about the repository.
But for now we'll continue to reach into the already allocated source
and replace its path.

Patrick
