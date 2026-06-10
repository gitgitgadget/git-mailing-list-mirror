Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578D37104C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076713; cv=none; b=CU17EU6JZFGV8Iz3ogJ3T00FL58DWIMTtHmg5M8TZFFkPRNJSWFCUVxPM0cY1eO0hlvue84kfUawLfn7uFpI6ELaQvE8U1jal5ThZs18zQMuyLsM10UGJAFVpEGqkS7294cvg3bJEmcqdCiaLhlIYALykjBt+hvWOcdrCV094zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076713; c=relaxed/simple;
	bh=JaxOHumLENImOOA9daQAAICZDILguRKc8wkf7+pj4ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxP4NMleGXj9LcsFTPnmRzsQBcqJYY3RVknDnyjLg7TR3jNAgwu2GeUZr8M4HjPpJe6AxjXVlVJxqXIcJncoLAM9gx3p5ONcSdGLN1ZC6JdGXhvR4k+EJmKnXMNKHKeFEh2NDkudNl+AUaODcXceBmBmJNI6yBqyUppVsH1aDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ILv0AWT8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qbj12MG0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ILv0AWT8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qbj12MG0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B194F7A00A2;
	Wed, 10 Jun 2026 03:31:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 03:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781076711; x=1781163111; bh=ilUZfxSkjo
	vZSznUpdgCuNj2/sdpvFqszzQ6FILkMLM=; b=ILv0AWT8WAxpI8Wm2PIYX5K6Qx
	Dc30g9NACKYl//X2Lo8ZGUAYVMqZxiLjkLn3AJzctkcotUBRG0q/O5IviNK+U98B
	tCjoIC57ds2hKOpy3JSDq/LXkZzlvU6X5llWhWfulvZ+f3qNhN+A/+H98SEZvl2P
	kS8wTZLPj5My4u/TzAKMGwk/WVL/BAv/f4O8CwJhnd+LC3+Aefeclt64LMdmhd/Z
	Lctpnsti8uV/C6Sexar9ukFe7HJqqataKxIFEHLB/lVfe7j3k7u1J6Qj2Akk2bPE
	zbJQRg3KYBCcqZLNjwmkjomDwG1PSbUic1W4i42khkkfENeU1FwBP0TVi1Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781076711; x=1781163111; bh=ilUZfxSkjovZSznUpdgCuNj2/sdpvFqszzQ
	6FILkMLM=; b=Qbj12MG0WteZNoOhe2WaauBExTc4Kb40u2EQRoxslUpxYyP7lFO
	Zl338E5HH+AHLPozzkj394hRIO3s3JWCNzmUDizXTErIT8XXo0MOgVwW+Wa4EVPa
	EBvS3vKX6gf6stdZ6NXRRtZoZni7iUW4Ehf0WVn0iiVAxBGDMIKB3mxlKWZbMCUA
	rGh2cDZXIuXB7d28eaaS7QrAinwbA2rIBLRsj2opgAwkgJp4nyHiR6cHocpW+tmK
	XkGB0fvoGoFFQ9Xiyh1/4umEBXbS3Wju84M7FSPys0GYoapp4A9q51mcpvQJn81i
	g1DIY3CWwCkkfAbuwU/ZQPFr+3I8GYmM+Ug==
X-ME-Sender: <xms:5xIpagy79MYSksY9VORFnJ0sxXzDSZ8xPCwABLLXeSSG48_68LePsQ>
    <xme:5xIpaiF6cEa_diZ8XWYnTVGZvCyE1VnES91cqrZbLaeReZl66HfQfsrn3CONLFpd1
    pTsulHnwdZVPCAAj5spwUEHhDigxSbb18Q_yNuJLDFut0H7VQiizw>
X-ME-Received: <xmr:5xIpaszbSu27O3awb4grcWn-NyObBdJId8R2mPBOT-yChKAb-tyhHiSaKSEBc2qfSMPefKetEs04fbyFU2KDXPLjR-Iun5TnoAIAGgoKRg>
X-ME-Proxy-Cause: dmFkZTFnhE9n8JOvrr1IWbi06toYlnQeh/VZf4B+z50I0YrWfZSjGz3BMr97/iPCI4jXQh
    sWm5TXbD9hic3YWoY2MF+ePbM5kH4WWwcRpnS1/zgwv0gHBc+4JODI7fUKfuJndXdGHs7z
    q4zE8HULxgnDPxHiuOaTlAIHiJTlx382UDfM4ixzw0L3JZNIWzB9kd2ShW+Yt/mcTX2Kyg
    V3K4MVCSDgCQ0jCDVg0U2mtpas0n8m5Sw2JVbfLRHNfLfU7d0SBBaOjeSN2L3CEzVGWoEb
    4OlchOcucXGDxEbNlZ//y2j42v/WUULM6bPUKy+q/pFRcv8pKmmPDG0FlS+9lNVV8lrqUB
    3yaDnwhNMiJaV2T0D5trw5XLx27FAdV6FBvI8lXAXRmiSBbiTAa5F9gZyYnSQIQ+icck8D
    H8fD+4wlbdki8g3iZoKpV1fmy7/w/F/ge4JyB6ZggKzhGtakltAiPqTM0DcuvgmutYSQ8W
    V8YU9bZ2MokuOSJ/A/8lg8kMUaCO6o8++CaSVXAsMmK53PLZEQcNngDx4fnrvP7hsC6Izq
    qIciChMwa3FgnJVbNgszfKZ5OM2ZRI/Lue/EjUohTiz0Mr8m8xEeI5t/WUbBgWeyf1jZem
    /ZKo0yi9D813Z48X+hi5sU5pBvzKx8BE7w8ZoNzhTLJP1HAWDTSvyusOBmIA
X-ME-Proxy: <xmx:5xIparsr_yAEcnSEKSZA0-Su0wfnV0dBVLh3bcjtnOB7FdgIg0TBjA>
    <xmx:5xIpah20PlDNCTh6qDuDCUCS0EI4IjcQWKXYm42ABwDaaEt4cmStcw>
    <xmx:5xIpau-kbcxWkrZgFcnE53oyiL0cnuXq051qfwDUthhGjNgqcvo_jA>
    <xmx:5xIpaqOGRH7VeZU799TJBs2qSDaBLvTozbwXNrVSAxfZB0iDkcJfDg>
    <xmx:5xIpahvly5L8ZTkk11Tlz8j4DXPsND2o06wWd6B2gev-JJ7vWrZIHGID>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 03:31:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77c52f4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 07:31:48 +0000 (UTC)
Date: Wed, 10 Jun 2026 09:31:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
Message-ID: <aikS4huB4Qe9tEa4@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
 <0fdaeec8-99cd-4dc9-9549-8a08133deebf@gmail.com>
 <aiaH3ZmFZfmWYwr7@pks.im>
 <aiaI6thDj8y_EekG@pks.im>
 <b9055227-f6e8-452d-928c-d944ad840f31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9055227-f6e8-452d-928c-d944ad840f31@gmail.com>

On Tue, Jun 09, 2026 at 11:03:24AM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 08/06/2026 10:18, Patrick Steinhardt wrote:
> > On Mon, Jun 08, 2026 at 11:14:08AM +0200, Patrick Steinhardt wrote:
> > > On Fri, Jun 05, 2026 at 04:12:42PM +0100, Phillip Wood wrote:
> > > > Hi Patrick
> > > > 
> > > > On 03/06/2026 17:14, Patrick Steinhardt wrote:
> > > > > In a subsequent commit we'll introduce a new caller to `reset_head()`
> > > > > that really only wants to update the index and working tree, without
> > > > > updating any references. Introduce a new flag that lets the caller
> > > > > perform this operation.
> > > > 
> > > > We already have a flag to update ORIG_HEAD so would it make more sense to
> > > > have a flag to update HEAD, rather than adding a flag to disable the
> > > > updates? It would mean updating the existing callers but I think it is a
> > > > clearer api and it avoids the pitfall of
> > > > 
> > > > 	RESET_HEAD_ORIG_HEAD | RESET_HEAD_SKIP_REF_UPDATES
> > > 
> > > Hm. The question is whether it's sensible to have
> > > `!RESET_HEAD_UPDATE_HEAD && RESET_HEAD_UPDATE_ORIG_HEAD`. That feels
> > > like a somewhat weird request, too, and we'd have to introduce extra
> > > logic to make that combination work.
> 
> As there are no users at the moment we could make that a BUG() and implement
> it later if required. At least that way we're not introducing conflicting
> flags, we're just not implementing setting a certain combination of refs.

Hm, okay, I'll have a look at this.

> > > > I wonder about the function name as well if we make updating HEAD optional
> > > > then what does reset_head() mean? Maybe we should rename it something along
> > > > the lines of reset_worktree() or update_working_copy()? I'm not really sure
> > > > what a good name would be.
> > > 
> > > That's a good point, the name does get somewhat awkward. I think we
> > > should keep "reset" in there, but `reset_worktree()` to me reads as it
> > > if was rather related to git-worktree(1) than anything else. Maybe
> > > `reset_working_tree()`?
> > 
> > I think I'll skip these changes for the next iteration for now. The
> > patch series has already exploded quite a bit in its scope due to the
> > refactorings of `reset_head()`, so I'd prefer to maybe do such changes
> > as a follow up.
> 
> Renaming the function can certainly wait. I'd quite like to sort out the
> flags though as the new flag is being added in this series.

If we introduce RESET_HEAD_UPDATE_HEAD I'd also like to rename so that
there's not a silent new caller where we don't have the new flag.

Patrick
