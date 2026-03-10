Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B62D7DD4
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152707; cv=none; b=LzmaSsc0k85YTUybOKIFBNXCGlqK1v1zoDOX7cXzDCPskN0bgF4norK+FLII2qkSw0e5kGSdQAy4HzDkMjIKlVfvjnfhaWXc5OMzV/Za5Bz6vy5pYtC0ChmNS8nxvhQd6sp8B52BK5tVxUOJXY1a2cnuOSImfMLrittdBinhg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152707; c=relaxed/simple;
	bh=ASK0H0PbAVMDv27OYJE0Bi+WFA9p+cNrAa3j14OMIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3Vu4RHiyyEVF+hylxW9nNAPfTNaHr8N4qiRHH5vaRCTlr5N7KDU9DfE1GHkjr/gtNHvcv4sSnkqfERjULf5M0CjNYGfZ6UJ5Lk39Uco2X8rWY6u/FR7HacErqmwH6g4Y2Shz022v+rm1mzyMeug5qYlEaEkrrI6zauxRrhfxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B0rsTcu+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4jL32HZh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B0rsTcu+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4jL32HZh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7135E140021F;
	Tue, 10 Mar 2026 10:25:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 10:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773152705; x=1773239105; bh=D4uMG+3jSi
	iiRxEhdAKK4jEt7kjbrhwzWgWlA1H9LnU=; b=B0rsTcu+l6myDE7LGz1/K0btn1
	wKzHoeM9GswVbTEwYY+OEqUP/jc3tv0SekNIFR8s5S5UMfT4/hXXb9YOtIosrDsq
	PAYWaifQhctPpoZFJHd/f3dHgyAr6GdWev2OLLWHlXcXdQqMwtFslMIsHVJ4rNMH
	trtADNAyN26vhYdKGWEICkmySgSWF7uU9oAAHg/vUQfo7jiRuR0lWIo6ZcTqJ95h
	i3hRA2JvmQ+8G7Iy6NJFhBmSKwcvQMyWAm5QPD1IbNyCEA4GWG9T3Wwaa9/1hzxq
	OwuhR4cWfSbnhlXFhRBQRe+v7Gz8G5rTg3gVsNI/dEC+n9JIGAVnXRMpgMFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773152705; x=1773239105; bh=D4uMG+3jSiiiRxEhdAKK4jEt7kjbrhwzWgW
	lA1H9LnU=; b=4jL32HZhUMabrq5AKXxK/Jwz6qDW2RnxaDAAd2UMvs7is8I+bXP
	+DcjLBHB2/mmT9nA4fkwzOkuAKb2LoX609IU7TRNd3+zojXN5mwdaRB9HnqgnvbD
	jD+iV/af3HowN/RS3D8/tslRptneYeNMEzXYSGWVeI2RvoPaGwv8RiW9SfY1GtsF
	1tlXh96Qs2Ag9TkWcxJr4QWUJnVcRVEHJEMuiSoDG1zf4wOGu246QHs0usZxxhSd
	Jv+r9tJwgTWIqCX22m9Y4i5N6JyHbAKUYrQmmLM1sUBs2tNa7p81Tu2DYWOy69DF
	V3wPzHDxVfBbzkCRsx0TiWZeqivpKzXLH8Q==
X-ME-Sender: <xms:wSmwaeO1k5pwz3_BwJ9v_IIA51bYnENW8aonZH2diNsb8kLRsJcwcQ>
    <xme:wSmwaT8kwXAaAVYLDsgxw4D-WLxCs7qVs8FhAiV4LfTly-su5hNSnKbIaei2TDPOr
    yMuvg_v3IJhUoD5zs-z7WJyzYLSKk3scZLcuw3DIirWkkF2GRZNCw>
X-ME-Received: <xmr:wSmwaaQWywLAr1uywlfAuO7wkQS7PkdS_OMnGw2k4adQsBnh5tQK89oyWPQb5fwbFxslHAJL9NMt0kCAZOBsmtmx7kVf60OIx33cc0vZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvh
    grtddtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wSmwadkJIJeQd3eI7-day_JPw0RnfYEtW3aL-5Zw7fA2DMC9EPj4IA>
    <xmx:wSmwaSRdyhD7nYDuwEPy-E8fhlZhrbU4E_iXpE_-cNlTQT5aWxVtpQ>
    <xmx:wSmwaTNOnll4j--2dk863nBzvvX6AHR5KpJJNuPMP1FFI_xsncv0kg>
    <xmx:wSmwaTUxmDs9-9veXoS56oIxn0VzeeMXmzcD6_G8A0AWFXIB-gGq0A>
    <xmx:wSmwaVnbGIP1ugup-eCdFCxjCeWnfYYRkxdt7ZoK42TUNy01emVCNGZJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 10:25:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35b73393 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 14:25:02 +0000 (UTC)
Date: Tue, 10 Mar 2026 15:24:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
Message-ID: <abApu_JDG4im9vwT@pks.im>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <abAZw-Z1mKf4tAuH@pks.im>
 <CAOAgETMe_yGyuaV4Eo9WDNYBa+eG-SEYDTCDoV45itNh_TE_GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAgETMe_yGyuaV4Eo9WDNYBa+eG-SEYDTCDoV45itNh_TE_GA@mail.gmail.com>

On Tue, Mar 10, 2026 at 07:06:39PM +0530, Arsh Srivastava wrote:
> On Tue, 10 Mar 2026 at 18:46, Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Mar 10, 2026 at 10:59:24AM +0000, Arsh Srivastava via GitGitGadget wrote:
> > > diff --git a/advice.c b/advice.c
> > > index 0018501b7b..e1264f525c 100644
> > > --- a/advice.c
> > > +++ b/advice.c
> > > @@ -81,6 +81,7 @@ static struct {
> > >       [ADVICE_SET_UPSTREAM_FAILURE]                   = { "setUpstreamFailure" },
> > >       [ADVICE_SKIPPED_CHERRY_PICKS]                   = { "skippedCherryPicks" },
> > >       [ADVICE_SPARSE_INDEX_EXPANDED]                  = { "sparseIndexExpanded" },
> > > +     [ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
> > >       [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            = { "statusAheadBehindWarning" },
> > >       [ADVICE_STATUS_HINTS]                           = { "statusHints" },
> > >       [ADVICE_STATUS_U_OPTION]                        = { "statusUoption" },
> > > @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
> > >                           "* Use \"git add --sparse <paths>\" to update the index\n"
> > >                           "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
> > >  }
> > > +
> > > +void advise_on_checkout_dirty_files(struct string_list *file_list)
> >
> > Huh. So this patch wires up a new function and advice, but we don't ever
> > seem to use it. Am I missing something?
> 
> Thank you so much for looking into my PR and i believe advice.h is
> used in the add.c file. And advice really helps young developers
> understand what's wrong in their files because navigating git and
> trying to find solutions is very difficult, causing them to go to ai
> models making them copy pasting machines.

(Please note that we prefer bottom posting on this mailing list, where
your answer goes below the quoted context.)

It is used in "add.c", but not magically so. The function that you have
introduced is the only site that uses the new advice, but the function
is never called as far as I can see. So ultimately, the proposed change
does not have any effect on the user-observable behaviour.

Patrick
