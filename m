Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F781F76AB
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240047; cv=none; b=FIWfdc/VuN9xIB2vZEjG1QjJasVpXI3ijIOLBjTss43S+5hgckLJc6GQ+vS0T4M96dLhukbD7OCkcgGrKN9RNP7B7SrXLCaJ8sg75ffFbr0olUIV3NeLdL804zfNmTdjB/hdh7l9I5DAPjK5QCKdBIEf1295/66fqTKQ7UMJAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240047; c=relaxed/simple;
	bh=pvmEEgMQL8XHY08NR1R7p4k1OgTLIuGXtlTeWjQbsSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ6D9/UPTsq45rIojb5xsN6hQKuxI2+DUrCdMrI4KGd216lb+sStQuxT940L3Qj+fxZdqCbEILP0Eyf5bcDb0XvYRQzAiydrLIA5kACgvo2EqaVn2RXqMgkBX/xeqnZqQZuKIATMbWQLKbls8PTR/FRsTLMK50PG1vgOM+mU87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vUMij4Zy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=advVOrOG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zsbj4hD5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jw6WQx1B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vUMij4Zy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="advVOrOG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zsbj4hD5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jw6WQx1B"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B52921157;
	Tue,  3 Dec 2024 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733240044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3RU0cJwfT1hxT05m5ccZ6T85w1zDJxUYg9hD82Hhro=;
	b=vUMij4ZyIkIxEFanBU2pJOF9LhcKvpyx4QA/JHmkZWM/ELE6AT641f8XICcDSfRryBFPuD
	eGsEguzzoybVHm+FkY1olC9pL9U78V/BCvrpjxcA1b5Tukp0BiTqHhNEb6AlHQqMptvt0N
	qxcFKZ7UPhCBf6mCd1PHbbmT0T9b3QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733240044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3RU0cJwfT1hxT05m5ccZ6T85w1zDJxUYg9hD82Hhro=;
	b=advVOrOGSjFTZuYBqWOaGjHyOgR20q5ZEayjBDWocMbNan+jElr/MqtvE743bFj4TQG4kM
	wuR5964JUwbRabCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733240043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3RU0cJwfT1hxT05m5ccZ6T85w1zDJxUYg9hD82Hhro=;
	b=Zsbj4hD53655/Lv7nISTFsMbLD9tCUbN9H1hCjOeGSIUzbv2kPpX8Luh5OgYk0hRBWlcDA
	b89UN9KJPagtjOs6mNT0CBCmjJ1JsJWij8WSrHpZUltK+nbZ6Qc0AsofqO8azfjJU/1rqZ
	Au6Np1e/uzaQXrjPvksatOusW6fqEFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733240043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3RU0cJwfT1hxT05m5ccZ6T85w1zDJxUYg9hD82Hhro=;
	b=jw6WQx1Bbjr01TxmPNsod7P5nKH1i6G93u3rCPLS7UfaCPIRLPldXFrkxF8Z6cUg5YzyUL
	sh1dab7Rh1CTIoDg==
Date: Tue, 3 Dec 2024 16:34:02 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/clone: teach git-clone(1) the --revision=
 option
Message-ID: <Z08k6hANEQVe2g70@kitsune.suse.cz>
References: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
 <Z02_YwCgHp_MVj3M@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z02_YwCgHp_MVj3M@pks.im>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[fastmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[iotcl.com,vger.kernel.org,fastmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hello

On Mon, Dec 02, 2024 at 03:08:35PM +0100, Patrick Steinhardt wrote:
> On Fri, Nov 29, 2024 at 01:00:42PM +0100, Toon Claes wrote:
> > The git-clone(1) command has the option `--branch` that allows the user
> > to select the branch they want HEAD to point to. In a non-bare
> > repository this also checks out that branch.
> > 
> > Option `--branch` also accepts a tag. When a tag name is provided, the
> > commit this tag points to is checked out and HEAD is detached. Thus
> > `--branch` can be used to clone a repository and check out a ref kept
> > under `refs/heads` or `refs/tags`. But some other refs might be in use
> > as well. For example Git forges might use refs like `refs/pull/<id>` and
> > `refs/merge-requests/<id>` to track pull/merge requests. These refs
> > cannot selected upon git-clone(1).
> 
> s/cannot/cannot be/
> 
> > Add option `--revision` to git-clone(1). This option accepts a fully
> > qualified reference, or a raw commit hash. This enables the user to
> > clone and checkout any revision they want. `--revision` can be used in
> 
> s/checkout/check out/
> 
> Does this have to be a raw commit hash, or do we also accept an
> arbitrary committish like a tag that peels down to a commit?
> 
> > conjunction with `--depth` to do a minimal clone that only contains the
> > sources for a single revision. This can be useful for automated tests.
> 
> It's implicity, but automated tests in this context probably means CI
> systems.
> 
> > This type of shallow clone could also be achieved with the following set
> > of commands:
> > 
> >     git init the-repo
> >     cd ./the-repo
> >     git remote add origin <url>
> >     git fetch --depth=1 origin <commit-id>
> >     git checkout <commit-id>
> > 
> > Unfortunately, this approach uses git-fetch(1) instead of git-clone(1),
> > and only on git-clone(1) the bundle URIs advertised by the server are
> > used. By adding this option `--revision` to git-clone(1) allows us to
> > get the same end result, while benefiting from bundle URIs if advertised
> > by the server.
> 
> I'd claim that this is not only about enabling bundle URIs, but also
> about making this easier to work with in the first place. The above is
> rather on the complex side even though the use case at hand is not all
> that esoteric.
> 
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index 7acb4cb17618c6cbee5d6ebe41a53be03ebfaa6c..2a3f6d9deae4b817db50d8c4e555a6f33b8296f1 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -218,6 +218,13 @@ objects from the source repository into a pack in the cloned repository.
> >  	`--branch` can also take tags and detaches the `HEAD` at that commit
> >  	in the resulting repository.
> >  
> > +`--revision` _<rev>_::
> > +	This clones the given revision, and that revision only. The argument can
> > +	be a symbolic ref name (e.g. `refs/heads/main`), or a raw commit hash.
> 
> Nit: while I know what you want to say with "symbolic ref name", I think
> it's a bit awkwardly worded because a reader may confuse it with an
> actual symbolic ref. I would just drop the "symbolic".
> 
> We should also clarify whether this accepts tags that peel down to a
> commit.
> 
> > +	Unless the revision points to a branch (i.e. ref starting with
> > +	`refs/heads/`), the HEAD is detached.
> 
> Okay, makes sense. When cloning a tag or committish we wouldn't know how
> to name the branch, so we instead put us into detached HEAD mode.
> 
> I could see an argument that we should do this unconditionally even when
> cloning a branch to simplify the UX by always doing the same thing, no
> matter what the user has passed.

I don't think that's expected, most commands that take a committish
would create a detached head only when it cannot be attached or when
specifically instructed, see eg.

usage: git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
                        [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]


       git checkout [-q] [-f] [-m] [<branch>]
       git checkout [-q] [-f] [-m] --detach [<branch>]
       git checkout [-q] [-f] [-m] [--detach] <commit>

Thanks

Michal
