Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213139FCC5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681326; cv=none; b=tiyHLMY8KGDj3sXFHEkBKSk4HfbMd6q4GSeupZzJOEPWJCouMidHdChzWus9G3IK0jQG6HGqPzuzC1Zfrj8Db4tGnXfkk8qLqQGsHXz+uvtIIsh/DdR+ICSQfd5neK91CgDWXFplEYId+ouHrApcexOPeGMjyVrAco9QJ4VH91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681326; c=relaxed/simple;
	bh=MEngJsk+YOla2w2UPGVzW0CLsaaaWcTwl2rUV6zQKdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuGmCarY0ekvYFLGQOXShAXowpZyMcJjQv2tr0XlHBYPAE0Pz9OI+oPkL3BlrC5WkBrAsVHGIG+2ANdI5NKENcbV/LxGVuAhgDCbOu69ScvVZhEA4ccfLWamkljF39U9EyJlzmkkdknXXj+kSYbpCqlB7YNYL/LjW6E6/ahLYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kuADpzpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=id/h2rpp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kuADpzpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="id/h2rpp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 524101D00094;
	Wed, 17 Jun 2026 03:28:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 03:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681325; x=1781767725; bh=u6VTIyef8s
	wS76qCtsLflRnAgJ+OjYALt9q2PwYqR7I=; b=kuADpzpdnv3ijugklxbkcyqU72
	tstTtH+Bow4WsDXrME7egj3ApuZg9dqoXWknfFTcBbI86CnfjyeOGO0FDgAUQAG0
	n/rwjabdjwTfkhiJ0ZoARY4coeX5pOFTalsAkSYxgacOM0rQB0kp0hflWICOaGD1
	L3oMThWuXUEWG5hZLzeaXXAnZPlOI8hlZJnxZ53JtcPAlzi/n/97n16WFh6rrZSF
	q8wI12aanFI1FS0ElVivcV4Xv2XJ5bqATKE5JJDk4pJPGxCilBrlaiLLXj3MhYIe
	1qjJ9zSmFt++eqfOUiH+RUQJfxpw+D9oArKrt6Lr6kTGCeUG2wUMElgNKzWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681325; x=1781767725; bh=u6VTIyef8swS76qCtsLflRnAgJ+OjYALt9q
	2PwYqR7I=; b=id/h2rpp+FTw4qPE8prwuRXgozCNMLKnJbxp3cVVOv+6Rm0x+R8
	OaUhl0tBrY4vPybrMtnozQL30Zv4aohvGvctE8Zq8snhhGlNxWtX/Sb+bskM8by9
	EGPaugOIm5CYljmveknkJsBq1rV29uKeRv/e0M57LkgoE0JBKfmEEac+lzF7bzjf
	NKmvsZ0sVthvYfW/G1kqxCS2zcsV+FryfTQIFh06sT86HDFNju7qOJCnxAxWbsrm
	AQEx46b+FligRZ4CYsqt85z10hE7N8ylw/ebcIWgBJuxs8flV7eRCYe7Ah5AKmEv
	YCtquqDwdCxMYNCalCIXGxSAY4NfJdW2IzQ==
X-ME-Sender: <xms:rUwyaqv9zlCbbDZ5HRAnjUHFZZgr9mYw5cNqN4NIioEUWkbmCqKCDA>
    <xme:rUwyaldDQVx2Nj9nZCjPeeLKMN1zjEzI1RQFw6LDFxwwifMSATs3vHZlygVB7FyYU
    kDEQm1_eOoK_gIUwEesgCZy_B25dxqTPuoZFZglVNH4pdoDV9kU>
X-ME-Received: <xmr:rUwyajbMxqQDqmNMePWh4PS105VoZO7K2CMhAD6W7plWLFF2OxTXISzFS0SvZJGoVjJCbjPanHy6k_OJdQO8xLphoYOWKTwzqvJeeSk>
X-ME-Proxy-Cause: dmFkZTGyUsLXeodEuO5Zklc+Avvz7Jzf2Vy7qoqTB94f5EUHGUWpDVGB0+owJMohiKT6Rk
    56SMYT0FItF05pbBBiazqjVabQCBXOj8ydC51PCORJJmf738n+G6GNCfCOfVderOEio8gn
    gCN2m8QIAgQLKAU+/UcSsGsQsz0llGUZY2YItYIKFQYiqpdLqWQ1zJq+QSP6RxoeQ/R+gt
    Yx8NfW7g0WqpsJ77sl4IhJINmwXHNIM3porakL9jnm0dqEt/86ZosQA6LuoA4p8ppY3Jq1
    9KRPdQqCk/vBk32aJFjgnXJIKukKQBsO6cgVs6QKu42qSjARysafsSDmC9u8scF2+TS2DJ
    /8KsC6npxF5JS+12uYrYzvM4inkv6eWhGgjoAvXXkeAelWyWpbuybq6PMWYNwg/zRISrfW
    jbBLqAYR92kFm0DNQYqG+JDEI4/lm9fwFV4N+2lu18FtpT4qlZmlX11KVqqlaNaxAAPPLU
    T/aq7pHwS2KeVGp9VY3nr/8rhJlmcdfejRAB/l4VqizLR7vKO4t7Sc6flBwb+sjfj9sKgP
    BmiSwBoBgeDvj7BQhszdPHWQq6ODOdZ5ZLq6bJYMOb7oZFzJsZgy8jBqlZrOjkoKRFx2xe
    25ufGCNbLh9ASbVBBnZXAoo3Qewjin57qZ74xo7m/TavcEaPZMj1PGO6aGrA
X-ME-Proxy: <xmx:rUwyagXAvwGOd219T8PQqYHibNheTaKkYiGK1cOKLYTq6b-Utx4FrQ>
    <xmx:rUwyati9i0nYnOYcKb4TmFOnjSDlNmlozcacRe_JGAJeojZ7bAHqCQ>
    <xmx:rUwyamXQx83S-riYzdaLUrEKXQwABreQIzlsamSCKyzlNNooNQEH4Q>
    <xmx:rUwyasMr_7Eo48-cD_qQ12O9BOtrmmtGX-7wZHsUbvcDO3-Znp4dUQ>
    <xmx:rUwyamE9w0-iv2I2X8jNIbwlW3o6yT9rYQl5OjBUAjEruqIu0x2LCQjB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:28:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28712aa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:28:44 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:28:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] builtin/refs: add "rename" subcommand
Message-ID: <ajJMqayXuie1FyIW@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
 <20260616-pks-refs-writing-subcommands-v1-4-9f5219b6109d@pks.im>
 <xmqqo6ha4jw1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6ha4jw1.fsf@gitster.g>

On Tue, Jun 16, 2026 at 07:53:02AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +	if (!refs_ref_exists(get_main_ref_store(repo), oldref))
> > +		die(_("reference does not exist: '%s'"), oldref);
> > +	if (refs_ref_exists(get_main_ref_store(repo), newref))
> > +		die(_("reference already exists: '%s'"), newref);
> > +
> > +	return refs_rename_ref(get_main_ref_store(repo), oldref, newref, message);
> > +}
> 
> I suspect that my version shared the same issue, but doesn't
> refs_rename_ref() return -1 for failure, which we may want to turn
> to positive 1 before returning?
> 
> This is a tangent but git.c:handle_builtin() that calls
> git.c:run_builtin() may want to do the "negative return? flip the
> polarity" conversion to make this worry go away.  I dunno what such
> a change would break, though.

Fair. The other subcommands also suffer from the same problem, so I'll
update all of them to return 1 explicitly.

> If we rename a ref that does not have a reflog, would it leave the
> ref under the new name without reflog, or would we get a reflog with
> a single entry that marks the fact the old ref was renamed into the
> new ref?  Should that be controlled via --create-reflog option?

It would leave it without a reflog. In theory I agree that it might make
sense to introduce a "--create-reflog" option, but that would require
some new plumbing in `refs_rename_ref()`. So I'd say that we can add it
at a later point as needed.

Patrick
