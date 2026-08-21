Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFF2BD59C
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297479; cv=none; b=OB2HfKSSRGcMgiRpM9aJx3esw8EgzsGMkkwRH+YTBXIEC8y4UILZ0tDqBlUTam0TceTxMD7kdpTH91AbBCBjOKhULTmyY5YclLN5jb8CIQm2Yd2/DqnIBVgm+tclo3FSs2EgTQV7EtZqtzgf0j2UUok4iQnyouWPXKe0VxYRUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297479; c=relaxed/simple;
	bh=sLsn0WNL0FIukbfapnXnA1uA0r+BKVybLzbVQJ1Tm+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsZfeZGiH4BZii5t3DGHo/cSR6YNWr936Q9F9HHxjLfXy2hBsB/UgEay9g1YoZ4sOjlONkImzJOmiz/5RBgiGET+EWj6JTI39agG3LiYfdmgru6P1KQf4DsVCRkJ7PlKRr0FF3LVwExZoC29n7A2jVHeQ/vv8UxlueG6D50/z+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jx7lihh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ya+IBL0m; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jx7lihh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ya+IBL0m"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBD4614001CE;
	Fri, 21 Aug 2026 03:31:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 21 Aug 2026 03:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787297475; x=1787383875; bh=n0eSnaqOxJ
	aZWNGVRYXswlSWkQX/WSWBuJ1EK4dRZIQ=; b=Jx7lihh444lwvPFsUAcrMwNqCe
	LkKi0E3ASENdu4F2fOaAHh2TJdNONwF/hWBH7lZaTHJw1bbbQp7G+rdFdNCfVSeQ
	RExVj/JeM7Kcj8LONU3oqYdrVLvqvu9CmEpcPLARoAToV3ZHtY+Dcd5tv+KspHun
	nSzCwcZierjdiGr16mSZNluJ8wR1QhC+KzqbCBLNldwX0UCzziyWJM/Q/Vioo/HB
	7n1NRzG1B2JpFXfWLQ72D4cbUUpp3ukzjHmTqrZFoKw8TSp9MJ1KLQqzZFapSPTe
	Q/AE+Pk8oHeIU4TEsc5f4hiiyCbl4EIMeDGxwhY4WxyKMIwYDxRJktJbsTMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787297475; x=1787383875; bh=n0eSnaqOxJaZWNGVRYXswlSWkQX/WSWBuJ1
	EK4dRZIQ=; b=Ya+IBL0mWsqlXAzQCAE0ZICk5iRYEDgyASjPTz8LvhS0Hq1r/Fj
	ZyAm2SJiUJsXckvFFU1eULVcZEJURJzIr3k7fUlgX/xCR90Sf3p1ep+NxKfZHJi+
	7KadoiydJ8PBx7AWikXT7T+ui95tt8l2+s1kicNZc3rupyxmWtGg7T3COaIbnMmJ
	XC8JbVqAyyS6ytJ8RAcCZlY5Jsczs/f1/g2DD7Yj33rSHRoB75Iq/J9zSPQbUpLT
	lLWjbnf2nrNfeR5HWQfnJ+MLXqiZc91xPD420J9RLDNFk+Y+Sc0qqry31b+RIeSO
	B/FA33Cixbcx5/YwWAYQzYkbKjTUrNqnwFg==
X-ME-Sender: <xms:w_6HanFzflppsLDq5DlTgC9zs4EDqgRrpyxmiDNv7d_ZEKt28PWuDQ>
    <xme:w_6HarVt6fBBK6j7Uk-V0tLaAI1-M72s__-ttW8AnPdrCsSAWwYhUKtQGvElRx_7M
    n_803j4dslTOUCrbGsott3NLuJq-ADQ1Pdvx6xko_UmYb4iTQ_r5F8>
X-ME-Received: <xmr:w_6HauJhutLnGBmU5njAfcGwimy37EwN_fq3vfMittbU7R1wW-94g86fPy5ZBHzyX3yXWRMSIJhtHtaDFdzN9AGaEYD2tNqFxsTjTVDzfzZZ>
X-ME-Proxy-Cause: dmFkZTF0LKpv2U+FX+v3AwO7ZjPKs54Ed1RtGODe3DMZlx79XdrHt+wWN7PeHDTBw/BnFB
    UMGVy/hvJ9q0OG4UFal5or/xk8deAPCgaU1zAWpwsIoqJ63OBGQ6aSknOvicC2Pnjo0cu/
    +hEdGkVW883H7NOX76xtzk0a4qMQQec46QbcEX5UrclSZ1dTCVmh2mPS6pArudfRMmaNWJ
    S3oCI5RpSXmZ4vt1HPxt2wh+sFS8B/Xfz+VjqCnBNcncJWcXdyIm5COn+wJc25rLDlZVfk
    IhNss6HhI/46gVzWqciYwR5whjMYE2aGULK+zuICHVThVOzCn9yFUbrPQlBPyf/JtGu5e4
    2x1VTSwnkA8QWNAgDXV3co84c8hNjhTDlaqS4/tahC2CdgTfUn1RnV+QghnwK2t1s2Unu2
    fc396ecqcR+rLVd65/zkH0mGKf7VZA0EPe71BT+f7wf77Dlg+3b4v+iMI/SNhBO/ftNAWp
    qwtTQfFvrhY/QYTZNmkAmwEiq1jbJvWq1mxEayX4tgDf1nrdKICXNPXf9nveCsyBGE/tFR
    3v7UZ6rnKrkzxQKrq366IOBmnRqS06lntKeXh1ttlr/rJopjEd+ztQGRm3YrZW6i4pQXGA
    ks4GPnqffzQQmHO8i0Ls9W/Agz7K97XVXQ1IlOk+irx7yrf+sPG6nPpJj4Eg
X-ME-Proxy: <xmx:w_6Haj_HxD4tzGINX5jgno9WnmR7O-TCKv5s67qeIEVYRmPTbtQpWw>
    <xmx:w_6HapKlIIJm9pzi_IYuKKxghgqVS8xVS58nS7FImmcStXZNKeD0cQ>
    <xmx:w_6Hagn51Umm8viZmHRofl2UXNQXReMoXVRmKdZn-ZlHqnUK6dpmDQ>
    <xmx:w_6HalMyEJhLWqTVfIO9KxgA3Kzpa8NwU9W8p9kQOXtWx3yhPuf2pw>
    <xmx:w_6HauHhnOZG4XhsscLUf-dObp8YRiZ20TR1QbwKvtj23qMj2xJonfyr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 03:31:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a868192f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 07:31:11 +0000 (UTC)
Date: Fri, 21 Aug 2026 09:31:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <aof-t_bRzC0u1hHj@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
 <20260817-pks-odb-eagerly-prepare-alternates-v3-2-1115a7e02467@pks.im>
 <xmqqmrugsryl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrugsryl.fsf@gitster.g>

On Thu, Aug 20, 2026 at 08:59:46AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When registering alternates we deduplicate object database sources by
> > their path so that the same source won't be added twice. Ever since
> > cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> > this duplicate check is backed by a map keyed by the source's path,
> > using `fspathhash()` and `fspatheq()` as hash and equality functions,
> > respectively.
> >
> > These functions are problematic in this context for two reasons:
> >
> >   - They implicitly depend on `the_repository` instead of the
> >     repository that owns the object database.
> >
> >   - They derive case-sensitivity from `repo_ignore_case()`, which
> >     returns a default value in case the repository's configuration has
> >     not been parsed yet. Object database sources may be registered
> >     before that is the case, so the answer may flip depending on when a
> >     source gets registered.
> 
> As you later mention, we can always hash case-insensitively with
> the downside of additional possibilities of hash collisions.  I
> would not be too worried about the hash side, but the above makes
> me wonder what should happen in the eq() function when a repository
> uses object databases living on separate filesystems, some being
> case-insensitive and others being case-sensitive.
> 
> In any case, I wonder if 'core.ignoreCase' should even be a part of
> the repository configuration.  Do we need to support
> configurations where some parts of the repository are backed by a
> case-insensitive filesystem while others are not?  And if so,
> how?  It almost feels as if each of these object database sources
> needs to report "This is the path to my filesystem location, and
> the path may have case-different aliases" and "My path is on a
> case-sensitive filesystem so you do not have to worry about it
> clashing", and we need to compare them accordingly.

In theory you can of course construct cases where we'd need that. But
this whole mechanism is very old already, and I don't know about a
single reported case where it caused problems. So yes, it is imperfect,
but I think we're overcomplicating things that have been working just
fine for the last 20 years in practice.

> > Overall it's quite debatable whether all of this complexity really is
> > worth it, out of two reasons:
> >
> >   - We could linearly search through all sources to find duplicates. But
> >     the mentioned commit cares about cases with thousands of alternates,
> >     and a linear search would of course regress performance quite a bit.
> >     This doesn't really feel like a reasonable case to care about, but I
> >     don't feel comfortable regressing it anyway.
> 
> Linear or hashed, the issue of what the definition of eq() should be
> remains.  Discarding the hash map does not help at all, I suspect.
> Am I missing something?

No, you're not missing anything here. This was more of a "using a
hashmap in general feels overengineered" statement, as you'd typically
only have at most a handful of them anyway.

Doing a couple of string comparisons would likely be more efficient
compared to spinning up the whole hashmap machinery if you really only
have one or two alternates, which is going to be 99% of all the use
cases out there. Having the hashmap probably only starts to make sense
once you have a couple dozen or even hundreds of alternates, so I have a
feeling that we overoptimized for a mostly theoretical scenario here.

I don't feel comfortable removing that mechanism though. There's always
that one person relying on those weird edge cases.

> >   - It's dubious whether we should handle "core.ignoreCase" in the first
> >     place. The downside would be that we might add the same alternate
> >     multiple times with different casing. But this is an edge case, and
> >     it's not even fully fixed because we don't resolve symlinks or
> >     mountpoints, either.
> 
> Do we know if these all come directly from the way the user spelled
> these paths?

We have two different sources, "objects/info/alternates" and
"GIT_ALTERNATE_OBJECT_DIRECTORIES", both of which are parsed via
`parse_alternates()`. That function knows to translate relative paths
into absolute ones and it normalizes the result via `realpath()`. So no,
they're not exactly the same as what the user has provided. But
unfortunately we cannot assume that `realpath()` provides a canonical
representation of the path name, either.

> Unless there is a demon that randomly flips the character case in a
> pathname once it is obtained from the user or readdir() before it
> gets to this code path, an easy way out may be to tell users "don't
> spell the pathnames inconsistently" or its equivalent, "do spell
> them exactly the way readdir() would report on your system", with "if
> you fail to do so, bad things will happen".  I suspect that the bad
> thing in this particular case is merely that a search in the
> alternates is made unnecessarily inefficient due to duplicates, so it
> may be a reasonable alternative.

Yeah. All of this is really just caused by the fact that there is no
platform-agnostic way to check whether two directories are the same
thing. Which is kind of surprising, if you ask me.

> Alternatively, we can even say "your repository cannot span
> filesystems with different case sensitivities"; I am sure there
> would be some users affected by such a declaration, but I do not
> know how much we should care.

I'm hesitant to go there, as that would retroactively introduce
limitations that could break existing use cases that we supported just
fine until now. The proposed patch is carefully trying to not alter any
user-visible behaviour at all, so both before and after this patch the
behaviour with regards to case sensitivity should be exactly the same.
And that current behaviour seems to be working just fine, or otherwise
I assume we'd have seen bug reports in this area.

So I think we shouldn't throw the baby out with the bathwater.

> > +/*
> > + * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
> > + * _may_ be the same. This requires quite a bit of boilerplate for dubious
> > + * benefit:
> > + *
> > + *   - Duplicating alternates should really only lead to regressed performance.
> > + *
> > + *   - We don't properly resolve symlinks or mointpoints, so we may still end
> > + *     up duplicating alternates.
> > + *
> > + *   - The value may be lying, in which case we might deduplicate alternates
> > + *     that are in fact not mapping to the same directory.
> > + *
> > + * We should investigate whether we can remove this whole mechanism outright.
> > + */
> > +static int odb_source_paths_cmp(struct object_database *o,
> > +				const char *a, const char *b)
> > +{
> > +	if (o->source_paths_icase < 0) {
> > +		int icase = 0;
> > +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
> 
> I suspect accessing o->repo should be safe even in the
> initialization sequence, simply because "o->repo = repo" is done as
> the first thing in odb_new(), but do we know o->repo->initialized is
> true in this code path?  Refraining from making that call and
> assuming a case senstivie comparison may be necessary when o->repo
> is not yet initialized.

Part of the motivation for why I did all the refactorings in "setup.c"
was to ensure that we always set up the object database (and reference
database) after the repository was fully initialized, including all of
its extensions. So yes, we know that it's fully initialized at this
point in time.

One way to prove this is by doing the following:

diff --git a/odb.c b/odb.c
index 115957e983..2f1cdfd592 100644
--- a/odb.c
+++ b/odb.c
@@ -1063,6 +1063,9 @@ struct object_database *odb_new(struct repository *repo,
 	char *primary_source = NULL, *secondary_sources = NULL;
 	struct object_database *o;
 
+	if (!repo->initialized || !repo->commondir)
+		BUG("repository is not initialized");
+
 	CALLOC_ARRAY(o, 1);
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);

That _does_ trigger a test failure, but only in our unit tests because
we don't fully initialize the environment there for t-odb-inmemory. All
the other tests are passing.

I could add that to the patch series as a safety mechanism, but I'm not
sure that's worth it.

Patrick
