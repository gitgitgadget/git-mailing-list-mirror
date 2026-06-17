Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E139FCC5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681321; cv=none; b=c0OaUOL3+IFrRvX8BfydO+/M8aUNM5rSuDEXfLZ40nICB9MF5YgedYybTZd8wcSHYXx2E8xR/GiJ7yy/iENPXxpgiyoicFCB/3KEcYDsUWq8VLcXvTkgqbLeaaqju8x6BEKUBiOUYsQYMrQKzdz4XQ6OSJlx3Qyiv24L7zSueFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681321; c=relaxed/simple;
	bh=IZW4s+//hhFiy1UA7cFR+YeK0/Eq255rMhrAYw1ZuaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIQY4pog/sv9HoHQz+I4bm605McfztR5KgpnpSKKgaU2/PVhn4urnfNg7Oq91qGHRNqIUf8hoS5KbZw4+5a+e11Dmp0L84nw0B3g5k9At6qyGUOa7gf8UOUA4DVBoge4vxWwnU+IdIYP03wpNG0z0M7IG8Vati/eXnuhNz0UAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FRQUulDl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4mKCRwi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FRQUulDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4mKCRwi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2599D7A00F1;
	Wed, 17 Jun 2026 03:28:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 03:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681320; x=1781767720; bh=Bb9vzgThzX
	+itVAKU+zpoeZWxR0Xib6OwatjG2hpDCk=; b=FRQUulDl2vMUcu6fqsjYqMJqTk
	GofcEIxNeY/xtdLzUvtvsU3pJIelmfIi7I+RpOWzL162S/lKeo0niZde03QsiftX
	eFvtm1UFrVEpK6lw2fNaaqIoaoKG8JcGsWH0gHCnrZM2ygmyj9br2U4Ueg3ai6So
	JH1VQRBsuOVFRMHPxz9chAweU4qvzIf3oRA4VGdCkqL7mxM7ynQE9cvSOgiOiO3t
	F1+CzPci8RyENiIH5XXmh2m4g/RQ5CHfJ8X+8gmeLZNgsk4UyvC5sZeOwTPstKcs
	7yHOuJb9R6vuqpDkz/CKNNIdAWpQOHYwLBPmnDhxu5pTd2ivCtzwVnk1NWWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681320; x=1781767720; bh=Bb9vzgThzX+itVAKU+zpoeZWxR0Xib6Owat
	jG2hpDCk=; b=k4mKCRwiKELyw4+LbVPCzYeU/c+HVx3WkSBgS9OzW29S0Z/MglG
	wIwj0mIXyUEeuCgl6Wcw7XtY/2Bo+sEYn7fV4otmaWjytuap8EHo2V3Nyp4VrUJg
	88VHgF7pLHDGlNb0VSKmgm7QA3P6itrA0nXIB6tSQA9cFJIXu5uFfstKgIa0XWv7
	JNRLz4HQI1MvbkJkxwUJUM0dq1PndYz3PmfHkrgrORZ9koeM7gh3TRl092hu1V6i
	y0itRJyEkhxZpuVdsUhuHtMzKYEo50cMXCc1Vv8frtHvcojvUlzEqVYJIYSf+M6d
	1cW+Pn4Lk+tP0SAEYr25dGw4J0x11b1Za8w==
X-ME-Sender: <xms:p0wyaujw_9Te8zNCz8huwuUUCTCKoQOfDEN-aeFBKRJ2TFFIIPgXIg>
    <xme:p0wyalCi3cGvhyPuxGwd8eThYmVykj33L4SC8mMKTXsAHkTUWB9p_-cxwMvp8ms2Z
    C_Ky_9LlDmyi9FUaUtg6jGAN3P5nF7phH3bMd0FrGec-dZyWTcB>
X-ME-Received: <xmr:p0wyajvyOuF4hnV8w1F7a_ijsF9hj8g5Z8kbDodPJdubOU7frqfX2SdsX7eSa9Aar7dqiBJo5D-EKq9PdOe8faXdkWfJ3-wx2u9ypQQ>
X-ME-Proxy-Cause: dmFkZTGyUsLXeodEuO5Zklc+Avvz7Jzf2Vy7qoqTB94f5EUHGUWpDVGB0+owJMohiKT6Rk
    56SMYT0FItF05pbBBiazqjVabQCBXOj8ydC51PCORJJmf738n+G6GNCfCOfVderOEio8gn
    gCN2m8QIAgQLKAU+/UcSsGsQsz0llGUZY2YItYIKFQYiqpdLqWQ1zJq+QSP6RxoeQ/R+gt
    Yx8NfW7g0WqpsJ77sl4IhJINmwXHNIM3porakL9jnm0dqEt/86ZosQA6LuoA4p8ppY3Jq1
    9KRPdQqCk/vBk32aJFjgnXJIKukKQBsO6cgVs6QKu42qSjARysafsSDmC9u8scF2+TS2GQ
    dn3D9DW+a8i+Cw5RCz4vVst7n7WoQrPlGGSgT5VfHXFP3jvG2BV54LvzhbQ7sXZ8GglgWV
    D3kCCgOW/8sZ+VPNQE9PydsCDdo2fHNLeoOslH8KPaUcYREd6hQ4Jjm0jMrRkgBDY46YeW
    krizEUqzMyQBuvNYqRmIAQDl/Vi8+4GnP6Lf9GyUlJvRUhzvY42P+X5DaUkQ/GEyoDS2Ok
    IFSMmFaO7GQoNT8RToJktrUzJrZgQpIJjZKqXcaG2y14VGuPX7JgGcNb8hN4ffqJFG3JSz
    IcVN9TCXJWHVMOiDP1axmw8TGXgWNS+WYaObQ2cuenoaEJpqxr828ppfbGPA
X-ME-Proxy: <xmx:p0wyaiZu-HvQxp0-aFVYTT2WzrEWGOoKf-cBVm20uZNwzGQDFu1QhA>
    <xmx:p0wyauWHi2QrwCCOU3OIjhURzKm-_Mi4YboohJYvSjoBAArgSejCgQ>
    <xmx:p0wyau6FNKZiugz7ql7o6GtxCDfHMU-NtK5k_xxKzGvvGezbz4rkXw>
    <xmx:p0wyahiNrav_TrnxSg424vmpeJ1pwEoBy9PjB8q-qbx8HPpkz932LA>
    <xmx:qEwyah6T5xB3s48mpcIKZUpA37OqSIapCd1UA2fLeyGXe4yjkfl8u3eO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:28:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b560d91f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:28:38 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:28:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/refs: add "update" subcommand
Message-ID: <ajJMpH7VQY3Hxm9A@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
 <20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
 <xmqqse6m4jw4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse6m4jw4.fsf@gitster.g>

On Tue, Jun 16, 2026 at 07:52:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >  git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
> > +git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
> 
> "<old-value> vs <new-value>" is good, we should update "delete" to
> use "<old-value>" to match.

Good catch.

> > @@ -58,6 +59,12 @@ delete::
> >  	reference is only deleted after verifying that it currently contains
> >  	`<oldvalue>`.
> >  
> > +update::
> > +	Update the given reference to point at `<new-value>`. This subcommand
> > +	mirrors `git update-ref` (see linkgit:git-update-ref[1]). When
> > +	`<old-value>` is given, the reference is only updated after verifying
> > +	that it currently contains `<old-value>`.
> 
> As to the lack of "create", among the two potential changes, I have
> a slight preference for adding "create" and failing "update" that
> does not refer to an existing ref.  If we go that route, the
> "--create-reflog" option should move to "create", as "update" will
> never be used to create a new ref.

I agree that we should add "create", but I also think that we should
keep the special syntax of:

  - "git refs update $NULL_OID [$OLD_OID]" to delete a branch.

  - "git refs update $NEW_OID $NULL_OID" to create a branch.

While the other commands are more ergonomic, I don't see a strong reason
to restrict the "update" subcommand. Also, this ensures that it's in
line with git-update-ref(1), which also allows for these use cases.

> > +	if (repo_get_oid_with_flags(repo, argv[1], &newoid,
> > +				    GET_OID_SKIP_AMBIGUITY_CHECK))
> > +		die(_("invalid new object ID: %s"), argv[1]);
> > +	if (argc == 3 &&
> > +	    repo_get_oid_with_flags(repo, argv[2], &oldoid,
> > +				    GET_OID_SKIP_AMBIGUITY_CHECK))
> > +		die(_("invalid old object ID: %s"), argv[2]);
> 
> On the "delete" side, these messages quote the object name, i.e.,
> 
> 			die(_("invalid old object ID: '%s'"), argv[1]);
> 
> We should be consistent.

Yup, fixed now.

Patrick
