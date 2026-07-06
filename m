Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D339C62F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321987; cv=none; b=ON71Sak2vphR9LBzNOQSPhqmvDBiiTYuAwo6JfVZQ3zVU1PCHIDzl5frtrzoGrDd9jGFbmf2dagcS2sqnC9xfAo0ebrT59mX/LWnh97CPz72VcFwlt62jU/o23xF3NkjgzgLeEJudlqCgZAnR6Vjn5CX9PgzjxuaPGmHkMU0jl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321987; c=relaxed/simple;
	bh=R5p83m44S5WPpOVnEhCFRAH7OQs/WGbc/22FAcomi+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgTfegmlVCxuI0rlaClsWdFyxIkK8Id7VYRmpkamy4w9Vig/HNcOm6cpiRY3kiUpMwe6x00fypVd4QPMW3UVp9CzoifWOcw+6MP0frLU/cWs9m+wVjKWvn0X6qNXtgBclWUwlfZn6Lk9jnwShroG7IdkbzEO6xKhUCj8QsgvGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gLtnPAWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuxQmrKq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gLtnPAWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuxQmrKq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC4787A00D4;
	Mon,  6 Jul 2026 03:12:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 03:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783321979; x=1783408379; bh=0Kqp0Mj41l
	u5/09Oq1L4xJ+QmGu/k9qLESuQX9qePio=; b=gLtnPAWZyJgoc4vJGjRSuHX0qY
	7nMCOe1lMp6XzIV+2/VAvMOEI7yhgJaxeho0Rm3aw1EZa0wDbf4koQjR8Fpyv78g
	aWTrbQO4GJTZnrdAFnuUPKkO8BTPzPOMCBVFf50gpSsB5X+3qQaVWDWc2c9TNIZA
	RYwomhP3Kvs0jefp9kRm+JmcSCTQf5MmyIg8MJ3jY0/oOtcIsvkPXU1p72kLzVGP
	nyrCy6hBZS4naTF3oHq3RjKGDkMC4dSZiqzturjiw6vgw+IQXdI5S6A1mtuJZlDv
	msUCQQJf5AWlkxTmJMVXRHtnY0bNnCPh2x+iMDDqAB6AQat+Y4aLFJ0C3l3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783321979; x=1783408379; bh=0Kqp0Mj41lu5/09Oq1L4xJ+QmGu/k9qLESu
	QX9qePio=; b=EuxQmrKqUplE51oO9qBUxIIH2eldoQjSUSFsmfH7glDX1YMbWol
	m2x5MmElR8wSro+4wBruxERYm00g5iR2tBYyg0yyIQZEDuj4W7vu7n2v69jO5B6U
	21RHfwOlwLvcK9OCHBIQfKgpjTlwrzx68sdfFK5mahX00NlGEB5q1Y6ThzuWUYDt
	0eviOBYTG46S+H3yLgUIUwZ9ue8DSJ69TWFbldSszAcNzz0YrzVWpV/LTB4IJ/Ka
	0d8YfwmbjAxoB51tCC4pCsUV9hgjDpwOhweEnwYytBRIRY7BivJos4K4ld5E35fj
	KE4Z4l6e04eu8zFFNsSVPSF8fXefOyzbR5g==
X-ME-Sender: <xms:e1VLalnTwUBYaHcsuME98370PK0IBtz_sOig-rnBVmlgB3Z66b7QpA>
    <xme:e1VLaoTqRmzl_FuTXDoiJZhCBfWDVgWgNKksX4ra2yjT-VlhGptV_Lq_ZwDgVn8vH
    NeiQmtf826A9wlwoscRKWKCZwqOzE9bxMD5jXfW_s3aWmD-DWh14A>
X-ME-Received: <xmr:e1VLapB6Eq_p9a9Zn_Hh-se-xTOVoz9VrVsIObbM77ZG3NAy78MJA-P4IREID9aoghulpantbdVUynL2floRu6ADJpKvLqpUojusr3VigVc>
X-ME-Proxy-Cause: dmFkZTGUNqPqteeLNjFeEkeAAGY8sZ8B1Q0e98o52LpIYiUvup4bfElqttbneVdutLhG5T
    JsOYc9Ilfqwe0s2m9LB3EgbGQVLpD0Qg43SlEmX2vaaPyDd6WI9upWnb0DH3DtVKQkHqZw
    QlX73PdYOHOT2vWYDe07lBcUxa6Eryk8lr5uCJL43FK83ZPJUwHb6xYxaW/XMVFXohP2/1
    RfUeWU/0BhWaTD94WALfIUxdXctUJd7LBlaOsVS++Wca060eBZh1xiW5Kei6ockWYIiYQB
    SGnElYn+5q51oegL0GiGBZrGSRkHFjVLxzfQyhqDo6bqZRL4p3rL9Y60UxSfFdzkYb8iG7
    RcZqvj5FR8bd60pkLG39j9C9pnLny7j98c/TWI4GVKUrMA8L3pe7SMY5NtE+Nt6kgTNEbP
    G6ex/7AJ3mg++PyRi0GYbEZvrQs0xwnoQG4myxoFG72t2/NkKNwy1Sp5Oxfmn5KuneQJjR
    wOjhDPMsoeBNptsu3LHOuyLRCAnJ1Ff16lL6mP2oaNLfwgOBP2GdLgOjFh9Cj/WIletCKz
    5BiRrCh4lgJdSCL83W5We0nWKCQHGHUdSlXxiHqWVDhNpCGd/gj/Isv3IqTxKGkby1kbKp
    9IoB5WlyR/bEZVISNcUf/xSvjwQ9bb4zzXpC4xZWAgsNETQBOvOeMViUUxMg
X-ME-Proxy: <xmx:e1VLavQShuoHN3yfNEckAInuFnwhBEbSN8xrxG3M9UoOtTsvfFicpQ>
    <xmx:e1VLanrFbstCjYFZF54YInFsR3lSUVAf5L4GcW0KVTllIPIR4znjuA>
    <xmx:e1VLahwynwbu5zVhOnZQxnt5MgXln3FYl1SkasTdktzHv1F4gL6JJw>
    <xmx:e1VLasKHcMCH9GcuiCLZ1EH3MHWasluaX_jC0Nb4e20aVoy1KPtbxw>
    <xmx:e1VLah570glo2qSOdqaY2yf5JdT3G0Nf6wzRK8iYedrMEqV5Ou8Sq9J4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 03:12:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ffb8eb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 07:12:56 +0000 (UTC)
Date: Mon, 6 Jul 2026 09:12:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] builtin/refs: add "create" subcommand
Message-ID: <aktVdaB2xRk-iI_8@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-4-deb04de1ecef@pks.im>
 <87qzlk2m0h.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzlk2m0h.fsf@emacs.iotcl.com>

On Fri, Jul 03, 2026 at 04:19:58PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> > index 6475bdcc62..e6a3528349 100644
> > --- a/Documentation/git-refs.adoc
> > +++ b/Documentation/git-refs.adoc
> > @@ -181,6 +184,53 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
> >  	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
> >  }
> >  
> > +static int cmd_refs_create(int argc, const char **argv, const char *prefix,
> > +			   struct repository *repo)
> > +{
> > +	static char const * const refs_create_usage[] = {
> > +		REFS_CREATE_USAGE,
> > +		NULL
> > +	};
> > +	const char *message = NULL;
> > +	unsigned flags = 0;
> > +	struct option opts[] = {
> > +		OPT_STRING(0, "message", &message, N_("reason"),
> > +			   N_("reason of the update")),
> > +		OPT_BIT(0 ,"no-deref", &flags,
> > +			N_("update <refname> not the one it points to"),
> > +			REF_NO_DEREF),
> 
> Can `git refs create --no-deref` be used to create symrefs? Should we
> add a test for that? Or can it not
> 
> I understand the symmetry, but does it make sense to ask the user to
> create symrefs with `--no-deref`? Feels a bit obscure. The docs say:
> 
> `--no-deref`::
> 	Operate on <ref> itself rather than the reference it points to via a
> 	symbolic ref.
> 
> That's far from obvious for a user to realize they need to pass that
> option if they want to create a symref.

It doesn't cause them to create a symref. What this flag controls is
whether the command would fail when the refname exists already as a
symbolic ref. That is:

    $ git symbolic-ref refs/heads/symref refs/heads/target
    $ git refs create refs/heads/symref $OID
    $ git refs exists refs/heads/target

The git-refs(1) command would have created "refs/heads/target" in this
case, and by passing "--no-deref" you'd instead make it fail.

This flag is somewhat weird. Having it is probably a sensible think to
do, but now that I think about it I wonder whether the default makes all
that much sense in the first place. That being said, _if_ we want to
change it then we should change it for all subcommands.

> > diff --git a/t/t1466-refs-create.sh b/t/t1466-refs-create.sh
> > new file mode 100755
> > index 0000000000..cfb21bf863
> > --- /dev/null
> > +++ b/t/t1466-refs-create.sh
> > @@ -0,0 +1,151 @@
[snip]
> > +test_expect_success 'create fails when the reference already exists' '
> > +	test_when_finished "rm -rf repo" &&
> > +	setup_repo repo &&
> > +	(
> > +		cd repo &&
> > +		A=$(git rev-parse A) &&
> > +		B=$(git rev-parse B) &&
> > +		git refs create refs/heads/foo $A &&
> > +		test_must_fail git refs create refs/heads/foo $B 2>err &&
> > +		test_grep "reference already exists" err &&
> > +		test_ref_matches refs/heads/foo "$A"
> > +	)
> > +'
> 
> I was curious about this test:
> 
> 	test_expect_success 'create succeed when the reference exists with the same value' '
> 		test_when_finished "rm -rf repo" &&
> 		setup_repo repo &&
> 		(
> 			cd repo &&
> 			A=$(git rev-parse A) &&
> 			git refs create refs/heads/foo $A &&
> 			git refs create refs/heads/foo $A &&
> 			test_ref_matches refs/heads/foo "$A"
> 		)
> 	'
> 
> That fails. It that intentional?

Yes, this is intentional. We didn't end up creating the reference, which
is what the user has asked us to do, and hence we fail.

[snip]
> > +test_expect_success 'create with symref target and --no-deref refuses to create reference' '
> > +	test_when_finished "rm -rf repo" &&
> > +	setup_repo repo &&
> > +	(
> > +		cd repo &&
> > +		A=$(git rev-parse A) &&
> > +		git symbolic-ref refs/heads/symref refs/heads/target &&
> > +		test_must_fail git refs create --no-deref refs/heads/symref $A 2>err &&
> > +		test_grep "dangling symref already exists" err &&
> > +		test_must_fail git reflog exists refs/heads/target
> > +	)
> > +'
> 
> Would it make sense to add this test:
> 
> 	test_expect_success 'create with symref target with --no-deref' '
> 		test_when_finished "rm -rf repo" &&
> 		setup_repo repo &&
> 		(
> 			cd repo &&
> 			A=$(git rev-parse A) &&
> 			git refs create refs/heads/target $A &&
> 			git refs create --no-deref refs/heads/symref refs/heads/target &&
> 			git reflog exists refs/heads/symref && false
> 		)
> 	'
> 
> But that makes me think, this option `--no-deref` is pretty obscure for
> use with `git refs create`. There are two situations:
> 
> * The symref doesn't exists: so --no-deref basically is forcing the
>   command to create a symref. That's confusing

No, it's not. It tells us that we only want to create the reference if
it doesn't exist and is not a symref. Otherwise, we'd potentially create
the reference that the symref is pointing to.

Patrick
