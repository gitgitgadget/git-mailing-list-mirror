Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADB1BF32C
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139845; cv=none; b=RvUcdeYuYPYVgWOZF6DEFOKkdRGYJ3nj/zhiMssogGZfKTTFIM7ztkH9gHPUwGzTVcvrwK3zvqPiW/GiCmQGDBQDaNtBsJEYIzCfogiddVd8WVttb5NMcJ7VpDOCIPqmX4Ntpeq32fVd/cBzETHhnWUvh8pePdAnRQnwo49KfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139845; c=relaxed/simple;
	bh=uYc7qI784xhrGtuAGtrTGL63fL0JCt5MNR35V+jBZ08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPAgJqAcCK+3BKxk1J1pYelAUC4wopAO3YxAffyo/HSZre/VnWG1vyTyiTWwqoE2X1gkDmls3y4LaYjXpTmUbySudj2k3an1PsluDBni8Vg+H79NYZR4M4SyJwKjBKN07CAGijbmEOPgBt3U1EAv1fMX2nD/13Y8v3qX5HK74ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DBgj+CyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJGQxySb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DBgj+CyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJGQxySb"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F7391380626;
	Thu, 12 Sep 2024 07:17:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Sep 2024 07:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726139843; x=1726226243; bh=gxjRPhAMIF
	JWGHRbV8WfU+0wRMLkeJPxapz4xcO/vr8=; b=DBgj+CyJwfJj0qqqybSIHQ6DqM
	d+8xluJqHtq/37b7phIs4onXSiYANFmdQtD/K8X6hSlaam03kdxPP9D3lCWsvd0b
	J7zo8xCfr2iSpASU0qBDV41i5aoFtbIuLBDCCSpzCFNyo1K2xOKPfOwkT5ASGiSu
	1ZO8AfRHtPwi6mJd6sNc48N0F7s3bnFvl2Zx649mz6FxMfMNWms0fNTa9e/znu/Q
	EPKIwFfsqWcr5Q3iGmP9AkTuNSGFQA/FWXBHxevtfavnCD3qfwh858ar7EdI/uvA
	TdVOClagr2IP9vco4g8sH9ncBqj54C/w0G6SeEljsSMyw1iRO90aFfVxIx5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726139843; x=1726226243; bh=gxjRPhAMIFJWGHRbV8WfU+0wRMLk
	eJPxapz4xcO/vr8=; b=QJGQxySbAps3qpNWjs0xmQL3yNqkwARlhx4lOu7SHXmd
	Dlvluu7Go0Kx5sLGIj3PvU7UUsWkx6VCcCrzvprMqIqSLC2Ez9SPG2VA+VEDRle+
	xzUXhds9UMwj93R/cJ+yD902YakXAqvr5t6mR2RQsjs7hebDy/EghmO2bnPxKg+/
	RwXvLKQHi9Tk3U5v8gZ7xNmBFZCThsZ3atl9eSemfzg3Z9ICJQOs4O/AICXfCTxL
	6NfOb+fKLBXo6svKrhxf7qTE9w7s1rCR+RvjmQHCe7h25JKY8pZw5Q0oY+4kFaHV
	AGudn0uCHAFajIJELBksigZroCtPGCGwaHN6V644qg==
X-ME-Sender: <xms:ws3iZuculnFDPmW9Il-zgSUXMVixcJHIJRnGfc1xYuTS3f69WvonEQ>
    <xme:ws3iZoOe_yFMF9wt_jDnpb2ZE3DHENiJWcJnjPFRM177KDrfe82TaNzlXvS_cmr_N
    bn8aKFY3rwSi7q49g>
X-ME-Received: <xmr:ws3iZviHZNQRmSWSksVdGd_kA_vcXgPSY68grm34ZPsu_Ft6ioMcEo6eq6nn2AjQEELIaecsTI6TmV75OFJBUKraj1WhrLHF5q561i2ABCGy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptefhvdeijeettedugfffueekgfekiedttddtgedttdeu
    udfhhfegvedvgeehvdeunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    grlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ws3iZr8gem77MwQzNo_SJIKtx5gBKISyAQ__XweS2vNIersgsgFIyQ>
    <xmx:ws3iZqtPw9GpM2YlgavuJ1rmQbmJblvx3-NlWf5yR_-9u9QvUW34ZA>
    <xmx:ws3iZiEqRwb9L5bl7FlcOjV0YpgV_TxHCnYcXd1jZE6DZ0-dZc-XmQ>
    <xmx:ws3iZpMnMINqIfnVKc788k5ysAjARXq6WkHMNcDua5bRmzrj7gZ71g>
    <xmx:w83iZsL1-SvlqsjioNgwOvmjDcZmJA7pE3DNEICCa4z23Pb8bcjaIiXG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:17:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d48054d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:17:13 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:17:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/21] branch: stop modifying `log_all_ref_updates`
 variable
Message-ID: <ZuLNwFIW2CQuHTI4@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <fc30365e1f13d47eb89339603f6a4744525b3967.1725008898.git.ps@pks.im>
 <6hoykgw3gm5hchmtfaci6gwwha6iouidtqvupx55vsjfoedquo@nfgaumnmu4po>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6hoykgw3gm5hchmtfaci6gwwha6iouidtqvupx55vsjfoedquo@nfgaumnmu4po>

On Wed, Sep 11, 2024 at 12:14:55PM -0500, Justin Tobler wrote:
> On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> > In "branch.c" we modify the global `log_all_ref_updates` variable to
> > force creation of a reflog entry. Modifying global state like this is
> > discouraged, as it may have all kinds of consequences in other places of
> > our codebase.
> > 
> > Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag,
> > which has the same effect.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  branch.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/branch.c b/branch.c
> > index c887ea21514..08fa4094d2b 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -601,6 +601,7 @@ void create_branch(struct repository *r,
> >  	int forcing = 0;
> >  	struct ref_transaction *transaction;
> >  	struct strbuf err = STRBUF_INIT;
> > +	int flags = 0;
> >  	char *msg;
> >  
> >  	if (track == BRANCH_TRACK_OVERRIDE)
> > @@ -619,7 +620,7 @@ void create_branch(struct repository *r,
> >  		goto cleanup;
> >  
> >  	if (reflog)
> > -		log_all_ref_updates = LOG_REFS_NORMAL;
> > +		flags |= REF_FORCE_CREATE_REFLOG;
> 
> I'm trying to understand how setting the `REF_FORCE_CREATE_REFLOG` flag
> is ultimately equivalent to setting `log_all_ref_updates =
> LOG_REFS_NORMAL`.
> 
> From my understanding, when `log_all_ref_updates` is set to
> `LOG_REFS_NORMAL`, this is the equivalent to
> `core.logAllRefUpdates=true`. This means if a missing reflog file is
> created for a subset of references[1]. The `REF_FORCE_CREATE_REFLOG`
> flag seems more analogous to `always` value for `core.logAllRefUpdates`
> and would create reflogs for all references. Is this not the case? Or
> does it not really matter?
> 
> [1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-corelogAllRefUpdates

It's not equivalent in general, but in this case it is. Note that we are
only talking about branches here, not about arbitrary references.
Quoting "core.logAllRefUpdates":

    If this configuration variable is set to true, missing
    "$GIT_DIR/logs/<ref>" file is automatically created for branch heads
    (i.e. under refs/heads/), remote refs (i.e. under refs/remotes/),
    note refs (i.e. under refs/notes/), and the symbolic ref HEAD. If it
    is set to always, then a missing reflog is automatically created for
    any ref under refs/.

So for branches, "true" and "always" have the same effect on the
technical level.

And on the conceptual level, `reflog` is set whenever "--create-reflog"
is passed to git-branch(1), and asks the command to cretae the reflog
regardless of "core.logAllRefUpdates".

I'll add this information to the commit message.

Thanks for your review!

Patrick
