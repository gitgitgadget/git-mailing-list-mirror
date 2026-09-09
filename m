Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B147348C7B
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937228; cv=none; b=GCiK4ZIvK6ZTPp4XZwtnpmVcS8xEKeQZtwJptM7TC7fG0gEIIh4B+5pa+CyfqxZCIGUYQaXMoNkbifhWfu5hCRTsx3Amrdvg0AhuArPuov7vmb/+UlJfvAjHjwHe4Ia2dEPXzbY/5e9euxUIVpbvenW5j1YTaRChnSJ1/Z75DAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937228; c=relaxed/simple;
	bh=6/hQKYV3+GNgwQIf4+vJ3eTQY+gqsyn4WfmfbKbjinw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/seoHrVbqV/zuvS8aV4DaM8OBv4kfxmQqhO+C0xxUq40M+gS3kX6dhH7WeAfpywh+5lbjEfuPGNnLK6WuxlH5Nd/hS/XAR7NsdJ+UFTl22m8Dl8pGRGOiNjaA6gtSmxWWIEN/5K+FCpLstNsAU8SVYHl6cRQGVUuM2snjYJ+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0orPotZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFJwDYWI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0orPotZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFJwDYWI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55E8D140010D;
	Wed,  9 Sep 2026 03:00:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 03:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788937216; x=1789023616; bh=z6hA/eiibE
	z/oUfvT2ThYtMBOp3O8SI6nMyGew9Nch4=; b=X0orPotZzXJy+AlM+FNtsrxJvy
	QQDXmWXOfmSBmiKXWom19p8JeU1if9r4CMv1jl8wElTK41E9HP9aflXTsXZWF/wX
	ZDV4u9h8Yn4Hzovy0WmBOOgqXPQPikSijMZpyWHYr4rQkOMiBRBPbybJdTGdfyz3
	xtMUyh34ycCOfXzHSDNbJCR5byNjLVq8tFdcD/t24TqJmZrP3/347jp1YoM22Frl
	aRjBKXH43fPaNs+ub3bTuOHoWnDN9G4/xxoPpI2ZuvC28+DZjOAu4xjb7Qd22r8e
	0dtQvZKL0OHpdEnH97+67KJf3/RxkqSiO96txfYCNaGbO4PUrCTa8l/TF8jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788937216; x=1789023616; bh=z6hA/eiibEz/oUfvT2ThYtMBOp3O8SI6nMy
	Gew9Nch4=; b=JFJwDYWIsA9EuZ58BjiZEmT1JVWjhrP1A6LN5bA/Oe3BPB9Tp6Q
	YI7FB+hyRx2womt1eZFQh+HNbAgOWC+zzGNgwroSYSsK5E+mnDaKQgJQ4PIvSUuW
	NbV4dGCVg8XrbN4LVgbymsJOcX2ng+0y3qsOfNRv/oFSRvO6/oftfH6FDrbgsFuX
	gH1bvEcpFkYnzR+vDF7CuONGv+qe7sLZFXXSOknwAjycze2XQpX1BgXIio+MZnN+
	y47mOQ+CoA1qt7m6cqjKXK/KHj9m5vtUouM9uCJrzgkrKjgLff98gF8e3saA4XXk
	9l0AkXnpXRp49fjafzdjz4rDayMu3D1b1Vw==
X-ME-Sender: <xms:AAShaq6BRV1tvXZ4hRXhLqkD_Ger3Bh_cH2F_HcXHGVDB8x7cIF_RQ>
    <xme:AAShaq5LsfzoPEJi36b3_usQBW6QAwhJiUkYhfWk5eihhNCdwMLl-8AN6nSnhGDme
    -hMScD-SUa0hXRBaCGQlpVMOAyXLimsA8XX2GKrej8uKDnjiGJlKB0>
X-ME-Received: <xmr:AAShaueazfeTPKmq_1LGJMEQiHgQWXQAz461WUsdtzHSSQiMa9-Zb_wN7P-8cpT1gVjklA>
X-ME-Proxy-Cause: dmFkZTFldteQYyjts/zFikCqlLXRlDgVdzgQ1uUN9Tw/WegI4Uf+ouHfrSoVH463AUv9mG
    huGgwImLl/yU7jYGOmClY+gZNlyfMk6b26IqeuNoKtmBJAglPYnQxk3OyAn6uMg4nvlSmz
    9H5T/XU2r+KqcJIdy3aDhPK6HzGR3HfGr2fcrJI/FRrfFJXsQEG0lCXSAh9Uir7E5bgCKk
    m6Re+te5kR4p+PNsFjkgU0Dfh4fP3/h1eMVoLBW3AWM4Dxg1M1DhL5IuosYk/neNUnMyEU
    nyAEeVhijZUwyD/0Wbj8ApqUmVeupPJAnZjJajsUdGM7R+KrKBqAERvxR4rsRmoeyj4GRf
    nMen04NuHeQQZ4jLT8mpKNJGNnZUQui49e0sfOqPW4b1FmwvWeHUQkYygg5ZO/MweFb8O9
    wHvM68UgNbZzhrDDYo4J3pKAqlHlaYvh2i6zv/FvlYfEMfPK11w1yJBRpYVD7zKxTxCBPm
    AUXdqg22iJjnNhKH3yJ4EFzZUwR0x/d/YSxUECTZT8ZrjE+kK56fbT/R+s+VwmCrIwfJa2
    z99WGeg+llSrIv7INJxzsAh6XVNCBJXsV+sV2i+oQ9EIuDGbG40vukFiwJrRPBurvIrdLj
    i6Xz5SIAYRqMZ2mgzILWNSzpD68exbNIjPhwYkuWPSJoKTUyteKUyK5Yg53Q
X-ME-Proxy: <xmx:AAShamCMyjMxc3kLcE1GIVPEp-vhvXVJYslNxFtB_wz7qxCJP_OWHw>
    <xmx:AAShap86HV12xe7v-I6VyVVWsmnBx8iYPU4Nsxrk6HtsOtVvrA3r6g>
    <xmx:AAShapIdRyN1CyssWj_C-8bQbKJPCqFkvh8xvG5hZk76P6bpCWiiQQ>
    <xmx:AAShaqjWW1CNkQ2DcyEW9ImACLlQxgLVe2awhFtCD6RTNLhLupuNWA>
    <xmx:AAShat_HIShfbBC3vo4M-axScvNPG-R7_vEmOrMgLF831wap69DND_g->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 03:00:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31c403fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 07:00:13 +0000 (UTC)
Date: Wed, 9 Sep 2026 09:00:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/11] builtin/init: rename "--ref-format=" to
 "--ref-storage-format="
Message-ID: <aqED9Xn6xibcp9pf@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-1-6733c90ca5b0@pks.im>
 <aacc3fcb-43e6-4f62-b083-5fbabaa9f494@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacc3fcb-43e6-4f62-b083-5fbabaa9f494@gmail.com>

On Tue, Sep 08, 2026 at 02:31:22PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> 
> > Instead, this and subsequent patches will fix the mess by consistently
> > referring to the ref storage format as such throughout all options,
> > environment variables and config settings. This new name much more
> > closely indicates that it is about how we store data and finally brings
> > consistency into this area. We will keep the old names working of course
> > for the sake of backwards compatibility.
> > 
> 
> Just a doubt regarding the old option. At the moment, the patch appears to
> introduce the new name alongside the old name. Do we not plan on deprecating
> the old one and issue a warning to users when it is used so that we could
> eventually retire it at some point?

I'm aiming for a a quiet deprecation -- the old options keep on working,
but we don't show them anymore. We may eventually remove them
altogether, but I neither want to warn about use of old options now or
even remove them as that would likely cause more negative consequences
than is worth it. It's not like we want to soon use the old names.

> > diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> > index 7b4abdaf8b..a048f0bddc 100644
> > --- a/Documentation/config/init.adoc
> > +++ b/Documentation/config/init.adoc
> > @@ -15,7 +15,7 @@ endif::[]
> >   	this config.
> >   `init.defaultRefFormat`::
> >   	Allows overriding the default ref storage format for new repositories.
> > -	See `--ref-format=` in linkgit:git-init[1]. Both the command line
> > +	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
> >   	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
> >   	precedence over this config.
> 
> Relevant only if we are deprecating the old option: we need to mention that
> the old one is deprecated in the documentation so that users are aware of
> the same.

But I agree that we should keep the old options documented. Otherwise,
it might be hard to figure out what those options do in case they for
example still exist in an old script.

> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index e96b1283b7..63f33154c0 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -57,7 +57,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
> >   static const char *const init_db_usage[] = {
> >   	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
> >   	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
> > -	   "         [--ref-format=<format>]\n"
> > +	   "         [--ref-storage-format=<format>]\n"
> >   	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
> >   	   "         [--shared[=<permissions>]] [<directory>]"),
> >   	NULL
> > @@ -83,7 +83,7 @@ int cmd_init_db(int argc,
> >   	unsigned int flags = 0;
> >   	int bare = startup_info->force_bare_repository ? 1 : -1;
> >   	const char *object_format = NULL;
> > -	const char *ref_format = NULL;
> > +	const char *ref_storage_format_str = NULL;
> >   	const char *initial_branch = NULL;
> >   	int hash_algo = GIT_HASH_UNKNOWN;
> >   	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
> > @@ -109,8 +109,10 @@ int cmd_init_db(int argc,
> >   			   N_("override the name of the initial branch")),
> >   		OPT_STRING(0, "object-format", &object_format, N_("hash"),
> >   			   N_("specify the hash algorithm to use")),
> > -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
> > -			   N_("specify the reference format to use")),
> > +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
> > +			   N_("specify the reference storage format to use")),
> > +		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
> > +			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
> 
> Relevant only if we are deprecating the old option: We could change the
> description of the old option to convey that it is deprecated so that it
> could be easily distinguished by anyone reading through. I suggest this by
> noting a similar pattern in `builtin/name-rev.c` for the `--stdin` argument.

We don't really have to update the description as we pass
`PARSE_OPT_HIDDEN` anyway, so the option is not even shown.

> If we don't plan to deprecate, I suppose we could use OPT_ALIAS to clarify
> that `ref-format` is an alias of `ref-storage-format` similar to how
> `recursive` is marked as an alias of `recurse-submodules` in
> `builtin/clone.c`.

I was originally planning to use `OPT_ALIAS()`, but we don't seem to
support `PARSE_OPT_HIDDEN` there. Maybe it's better to add a small
preparatory patch to support that though.

Patrick
