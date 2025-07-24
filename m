Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B2274665
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358327; cv=none; b=nLiYoURiwiT09GlNJaJguWH+eRbPXs5zihfdkESFglCGO+rij9T3aLbytfYPpdzImwn8GZHOj/+ZNkiX4XRg4AC455IcNsFPC0CIf51nCViqNgMmK+UBFvv5ouRxoLuWUKzklOtzCAGBwGEjfxAKul1M2ieWCeULRthJIDguSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358327; c=relaxed/simple;
	bh=jbvVGxV5Fke6vWUGphrLyvVzj3vksYRcJxVFb604x1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gICa9F1V7LP6BAZ8cTYm1rkqDI4+IqRrD1oUdoYdCMhYXEmk9PoYvCGi8evsQtX1D+qMso1zNNLC0r8GOvDIV/ZQarpxCf6Qb28keBih526oabciLfZZecIQ2a9UFeIJrgw3mWx2g3kzAvAIVXcxqbX9/mIb4BNE/yvsIkBUFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QBfoE6yZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+JH37kd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QBfoE6yZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+JH37kd"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D81701D0013C;
	Thu, 24 Jul 2025 07:58:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 24 Jul 2025 07:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753358323; x=1753444723; bh=1MpxJk3a3Q
	L4qAnKQ7MxpBQirOCamSwHPJct14KGVEw=; b=QBfoE6yZqdrS1ARVD0UoNYW1Hc
	dG2cK2yalzj2bvRbiyZSBlkpzKNqmAuE7mRuqNIfT6MLIAq9XTlX5YcJ3bRSGRtc
	MIWosd/AprpU+et/zXSXGJr1wH60RyGU8n6WuuixCHX2CwJ4U9mhsY7wFBLaC+Y4
	F9ADt56ER3/BxEyEgp3CtmA6un8Eaq9cWAlnNoC2UKCJnR27prFb59Y8Ha3MSjpi
	eJMnD0NxHfAoDVGkH2v8Dg3dvu+Nq1FtXfVALpJaVvTQWvKLw+n/F7klYr5lAZic
	AiAAIJOMkc4AE0Q0yYrJN6nRI6pH51gcZqMgktXiiTQl3yIqnNn7w7USoqdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753358323; x=1753444723; bh=1MpxJk3a3QL4qAnKQ7MxpBQirOCamSwHPJc
	t14KGVEw=; b=S+JH37kd0Ksg2kRHrM6cPRhu8rbHIVIrbrMavNFpNDyqPLAuNKH
	kUaOECQC4A90al5Ejv37yPFUwRBW4an2duJna07JKiGCWUe1zsgfh3JJ1pll4ArE
	RsdxM4nC2UZn6DxHrQ0I7WuyQvmAEvzVRpY/DPVNMzycbWiBDOimeuBUcAb/5R0P
	8uQucewFKq7xxOj/cXHIsUstX51hAZ42qjbvfGcDSgbxWkKI8KdH5cVrfFnQgqC6
	zlObOYt7QW3linmURrV8pvMKSjMuOqwadMQYvLCWpDaSeTC49ijNU34xJ+/wVFsZ
	TQNMyLhqHTdF3tJ6i+yoAIM4LSCdRW0S0zA==
X-ME-Sender: <xms:8x-CaHaZsSiGFQzyCjcYRfLuSRHDRNuI-Z9_xN8XfM2XjOOdlFHpcA>
    <xme:8x-CaJpjxOQJFfPFu41drk8T8_a5RAT-OOpiecNpK1HrKzV7ZPE_cbQIiqOFzDOQO
    EaTikPiIR3D9h7bEg>
X-ME-Received: <xmr:8x-CaDZI3R_GVK1cDrLLrI13n6rq52VToh87HObkX3vO4EqBFfJPMssHc1ukYgFKqKw20-Iw9VjJrzqGPSIgKbC4efLN_YLlLQR6NgNmjSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8x-CaJS-QTAg8QFCZw53z6tV9FxBjdcHWLLWCf991S-rp9zJyScRXw>
    <xmx:8x-CaC6eOLAmtvOiX7mEczz8MJBiBi0Azce2QdOFLlxHvy0KnSVLyA>
    <xmx:8x-CaGy3cwpB9nGUP3R_a398TUav2oLI5jVLaKaPQzvENDdRm9isLQ>
    <xmx:8x-CaJThzox3fMIB7GbR25_8JhDaqjxBvX0LZq-OBmWqLCGOE_jRGg>
    <xmx:8x-CaHRMRlzZmvZxmNuoF9Gf0jSGuHIIth7bjbNjgNW2ActKvgS3ncEz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 07:58:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f637708c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 11:58:41 +0000 (UTC)
Date: Thu, 24 Jul 2025 13:58:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <aIIf7S5iPspktxdw@pks.im>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724104536.GA1316505@coredump.intra.peff.net>

On Thu, Jul 24, 2025 at 06:45:36AM -0400, Jeff King wrote:
> On Thu, Jul 24, 2025 at 09:59:45PM +1200, Han Jiang wrote:
> 
> > What did you expect to happen? (Expected behavior)
> > 
> > `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> > "refs/remotes/server/master";
> > `git symbolic-ref 'refs/remotes/server2/HEAD'` outputs
> > "refs/remotes/server2/master".
> > 
> > What happened instead? (Actual behavior)
> > 
> > `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> > "refs/remotes/server/master";
> > `git symbolic-ref 'refs/remotes/server2/HEAD'` outputs "fatal: ref
> > refs/remotes/server2/HEAD is not a symbolic ref".
> > `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> > "refs/remotes/server/master".
> 
> Thanks for the report. I can reproduce the issue easily here. Probably a
> simpler reproduction is just:
> 
>   git init
>   git remote add -m whatever server1 /does/not/need/to/exist
>   git remote rename server1 server2
>   git symbolic-ref refs/remotes/server2/HEAD
> 
> The problem is that the branch-renaming code in git-remote is not
> prepared to handle symrefs that don't resolve. This seems to make it
> work:
> 
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5dd6cbbaee..478ea3a80c 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -630,7 +630,9 @@ static int read_remote_branches(const char *refname, const char *referent UNUSED
>  	if (starts_with(refname, buf.buf)) {
>  		item = string_list_append(rename->remote_branches, refname);
>  		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						 refname, RESOLVE_REF_READING,
> +						 refname,
> +						 RESOLVE_REF_READING |
> +						 RESOLVE_REF_NO_RECURSE,
>  						 NULL, &flag);
>  		if (symref && (flag & REF_ISSYMREF)) {
>  			item->util = xstrdup(symref);
> @@ -835,8 +837,8 @@ static int mv(int argc, const char **argv, const char *prefix,
>  	 * First remove symrefs, then rename the rest, finally create
>  	 * the new symrefs.
>  	 */
> -	refs_for_each_ref(get_main_ref_store(the_repository),
> -			  read_remote_branches, &rename);
> +	refs_for_each_rawref(get_main_ref_store(the_repository),
> +			     read_remote_branches, &rename);
>  	if (show_progress) {
>  		/*
>  		 * Count symrefs twice, since "renaming" them is done by
> 
> That is, we need two fixes:
> 
>   1. When iterating over the refs, we need to cover _all_ refs, not just
>      those that fully resolve (there's a related bug here: we'll
>      silently ignore an actual broken or corrupt ref, whereas I think
>      the right thing would probably be to try copying it and then
>      complain loudly if we don't have the object).
> 
>   2. When resolving each one, we shouldn't recurse. We're doing a
>      shallow copy, not a deep one.
> 
> Reading this code, though, I can't help but think that the recent "git
> refs migrate" command had to deal with all of these problems. I wonder
> if we could reuse its code. +cc pks for wisdom.

I'm not sure whether we can easily reuse the code -- the use case is
quite different, as the migration works across two totally independent
refdbs. So all refs are recreated 1:1, without any renaming involved.

But it certainly seems to me like this whole logic could use quite some
love:

  - We create N+M*2 separate ref transactions, where N is the number of
    direct remote refs we need to migrate and M is the number of
    symbolic refs. This is bad with the "reftable" backend, but given
    that the N transactions are all renames that have to delete the old
    ref it's even quadratic in the worst case for the "files" backend
    because we may have to rewrite the packed-refs file for each such
    transaction.

  - It is way too brittle, as the update isn't even pretending to be
    atomic. We first delete everything, and then we recreate it. So if
    any of these updates fails we'll be left in an in-between state.

  - We shouldn't have to even call `refs_resolve_ref_unsafe()` at all,
    as the `read_remote_branches()` nowadays gets the referent as
    parameter.

To demonstrate:

     $ git init --ref-format=files repo
    Initialized empty Git repository in /tmp/repo/.git/
     $ cd repo/
     /tmp/repo:HEAD $ git commit --allow-empty -m initial
    [main (root-commit) 00c2622] x
     $ git remote add origin /dev/null
     /tmp/repo:main $ for i in $(seq 100000); do printf "create refs/remotes/origin/branch-%d HEAD\n" $i; done | git update-ref --stdin
     /tmp/repo:main $ git pack-refs --all
     /tmp/repo:main $ time git remote rename origin renamed
    Renaming remote references:   0% (2216/100000)

I stopped after a minute -- this will take hours to complete.

So I think we should adapt this logic to use a single transaction.
There's one catch, as refs_rename_ref()` also migrates any reflogs that
exist. But with the recent infra that Karthik has added we can now also
migrate reflogs, so that's all doable.

Patrick
