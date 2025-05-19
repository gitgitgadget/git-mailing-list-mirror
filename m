Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA3265CA7
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639371; cv=none; b=jVgZ+SEj1vg2fB2uo/y1Q6nsO+jkq2bCH//tHOTCHRPW/vQv1UhLyVRQR7QF4y+OMTPHMHOKh5stZI1Id/hvq3h6xQ/Lktmt0bDL7iHUETNr1GjT4mseOk2ScQM7NBWNN0HuT2rqhwr9YIzniDwllDDNhkyEjBxNkjjdhSShCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639371; c=relaxed/simple;
	bh=ekETQKpLDFi5tvRUhPlhSovp2RYdATeMZB7kKdEd3ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPpD2L7c/mHD5ZTjaVfd4PYAoEbJDc1ovN+68ti17tOLwB2TmHw51z3IKAXOpEO1hfjQO5I9+cUTl9tgAugF3SkJEGS4Xz18bXY9In17T5QVXMrRW+9q4T1WCSalQMwDQcDbroqTIL1QoNv7RIy2/hTq41fnzlDODZ8i3W520s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aVz/G3hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ms8XKQGV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aVz/G3hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ms8XKQGV"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 17D0D1140095;
	Mon, 19 May 2025 03:22:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 May 2025 03:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639367; x=1747725767; bh=kHXiX0ell6
	DqGuUPbGGAatDXXOf4GH+n3aG3oC8Xop0=; b=aVz/G3hwcDOE7o3G60hGamGODx
	IzT3+ZL9qybBhxG2zNMwF5weB4Wi5Jn59axmUUKk0tQkZRdgr8eyY2HgfuO1rrH1
	8G8Cj2K4WbBopYZs7rg5ky3D+K5KLkbSZyoWY52UKlOcOLrH1WHrRSdRkmJpy/Dj
	/WapzTWFsHwjFG3tiYHeCLM1oKds1WI1iR7ZK2GW+HNV0eAvLojU88jOGQitbeYa
	iix9fKvGrLNolJy62+rWWHT2flkwEyTMHooxsQqBdW5QCCMRDM6fdvAMYHR3axy7
	lAMEs0rnEovjiBeT/DmfStsYpRKIhNQtDsxySLagn8qSGbB+N3Smf3U/D2HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639367; x=1747725767; bh=kHXiX0ell6DqGuUPbGGAatDXXOf4GH+n3aG
	3oC8Xop0=; b=ms8XKQGVFLwwfEfTjRCuvU5ikf8QUYe5gShgUMfb6fSl5lHKOEa
	k27PN+lvRJB0p76xgeUUj8xSL4l2YYLbKw+W6j3Th6asSiM5AOVwN79s99H0J8uJ
	K/cIokQfE4zCQk0BEeGzvEFYJmMlaXBqP8l69BhRijwvY//BmTZDodaq6kPW81qW
	ucwWeLsD8EZOy+LWuX7wY6JyJgHe1/TdS94bQKX7nRfz3qbjwWQ9z2TF8HRMvbsj
	kuwCxbz8ybHLR134zHYJFI1k0i6k1/cofQJtPZeHCxdY1wbXq02qOYq1+cbhYGuY
	3JlrDoATWBr+jSgfKFlhSYe4r07SPdWUJLg==
X-ME-Sender: <xms:R9wqaGDRoFjiQ_guqCwRAhVFe1fpEXqmE7mkR-_ZDRmyrbkAv2tmKQ>
    <xme:R9wqaAiCC8UAASSICVGyqqoKcZAbNv6LRoe5RzKqELsx-OVEDoXiwea3Cn5kGAtFE
    pQLML_XvKeHXK_grg>
X-ME-Received: <xmr:R9wqaJnleQPAVJrzZwn_6hBS7Pi6W3sLQPsxQ_GnVlu5KdvTr-lG0uoA6RXSPtRH7gpfaRxQqq8CNFRTOHWsEBb139qvQyZ9wBcfgiKS_pOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:R9wqaEykHZtMqv33rHCOK7-1YXQZykk11OsHfdkMzzlrK0uKVxJ7lA>
    <xmx:R9wqaLQAj0exp3tlT-h_GEh9VrFo_8VOoi59tdZqq6G28snrTDY38g>
    <xmx:R9wqaPagWzFcM6cvTdfxecd9bo2N0QKeoLqpS4wNjhVh5d4eCzzj9Q>
    <xmx:R9wqaEQeBoDqPiO3u0uw3eugioDvmAFiP44KodhrUPfKdj5aSuvSbw>
    <xmx:R9wqaMJXFK0JuJJ1rpw276mBAcjpCQF9gKT1M3T_RzKv0iLMpLp02MNH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:22:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f286330c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:22:46 +0000 (UTC)
Date: Mon, 19 May 2025 09:22:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] cat-file: make --allow-unknown-type a noop
Message-ID: <aCrcRZ1sv-YCfLLA@pks.im>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516044935.GB22242@coredump.intra.peff.net>
 <aCcK0p7wMURHppe7@pks.im>
 <20250519061617.GA102701@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519061617.GA102701@coredump.intra.peff.net>

On Mon, May 19, 2025 at 02:16:17AM -0400, Jeff King wrote:
> On Fri, May 16, 2025 at 11:52:18AM +0200, Patrick Steinhardt wrote:
> 
> > > The code change is fairly small (but we'll able to clean up more code in
> > > follow-on patches). The test updates drop any use of the option. We
> > > still retain tests that feed the broken objects to cat-file without
> > > --allow-unknown-type, as we should continue to confirm that those
> > > objects are rejected. Note that in one spot we can drop a layer of loop,
> > > re-indenting the body; viewing the diff with "-w" helps there.
> > 
> > Shouldn't we have a test though that the option is still accepted, even
> > though it doesn't do anything?
> 
> I dunno. It is obvious-ish from looking at the code that the option does
> nothing, so we know that it will behave the same whether it is provided
> or not. I guess it depends on how white/black-box we want our tests to
> be.
> 
> If we did this on top:
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 67a5ff2b9e..ff92b14201 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -1022,7 +1022,6 @@ int cmd_cat_file(int argc,
>  	struct batch_options batch = {
>  		.objects_filter = LIST_OBJECTS_FILTER_INIT,
>  	};
> -	int unknown_type = 0;
>  	int input_nul_terminated = 0;
>  	int nul_terminated = 0;
>  	int ret;
> @@ -1047,8 +1046,7 @@ int cmd_cat_file(int argc,
>  		OPT_GROUP(N_("Emit [broken] object attributes")),
>  		OPT_CMDMODE('t', NULL, &opt, N_("show object type (one of 'blob', 'tree', 'commit', 'tag', ...)"), 't'),
>  		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
> -		OPT_HIDDEN_BOOL(0, "allow-unknown-type", &unknown_type,
> -			  N_("historical option -- no-op")),
> +		OPT_NOOP_NOARG(0, "allow-unknown-type"),
>  		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
>  		OPT_ALIAS(0, "mailmap", "use-mailmap"),
>  		/* Batch mode */
> 
> that would perhaps remove the "-ish" from "obvious-ish". I had left the
> flag in place because I wondered if we might want to produce a
> deprecation warning before dropping it completely.

Fair. I don't have a strong opinion here.

> > > @@ -202,9 +201,6 @@ flush::
> > >  	only once, even if it is stored multiple times in the
> > >  	repository.
> > >  
> > > ---allow-unknown-type::
> > > -	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
> > > -
> > 
> > Should we maybe introduce a "deprecated" section and spell out that this
> > option is a no-op nowadays that will be removed for example in Git 3.0?
> 
> I don't have a strong opinion there. It mostly seems like clutter to me
> in the manpage. In theory it could help somebody who had learned about
> the option previously and wondered what happened. OTOH, the release
> notes can help with that. With the patch above, "cat-file --help-all"
> would also produce:
> 
>      --[no-]allow-unknown-type
>                             no-op (backward compatibility)
> 
> though I don't really expect anybody to find that casually.

Well, the use case I'm worried about is person X that inherits a script
that uses this option. They may wonder what the option does, but if we
don't mention it at all in the man page they won't have a chance to
learn that it is a no-op without digging into Git's history.

Patrick
