Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9E346FC3
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181644; cv=none; b=nA4oL2B6dvWNpTkuOAgv1NeAhwEoidtYjTXAifPxdvyPRGrrKPyqXdubyYhRsfQ3v2dwAvv2FWgmivwkigVt5CQL7BBEIkVwCQwCGbwTnMk3rmwDRkRUaSKMpdh+ax5Pjx3fzhP5UiKwQZ7gR6PJQonwJDGJ5LAXIqbUqKmlpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181644; c=relaxed/simple;
	bh=V0wsQ3T1wrSnmGvtDkvvkNh21MiJXiXPE+IXbPmnVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPvaRl6xfRbX45CI/7DT1cAvPWE0/BZYG23djTqx6V+O+JynRr7Qf4lJr9vQ07ltubooz5GI/V0Zivjj4hK9jrCYkeuNjuG4x8TnZ1DIIOUXFdK8V3hhDw5Oe4++1R4u4+unqpsKQbYmeidr9oa6u+egrUVz9SP6FECE+8RYReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VJ6nhIel; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTJBLFqr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VJ6nhIel";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTJBLFqr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B9524EC08EB
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 02:27:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 02:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791181641; x=1791268041; bh=51MOquD0eh
	1zm5OCxKIjP34fkRv1AsRhtMreFJzlV78=; b=VJ6nhIelAcVqWyT36IHPYtQ4j3
	GHv7RqKLgwLs4hL7dbeLmTm8wsCyFHhEsZPrzqXif/9ZVdlT6Ah13AHLQ61+jdqX
	Ou1pIRqE3dY1SDjvyjvr4bmPq42LeHv4K1dKh1quTWLonFGj41OWTeALskZSpES3
	Dk9iXi/BxUKKhr/wbsuNx3zutNUOeBT9j642cWT4AGjGSQ9vt4pbwPaDTtlKHUz0
	VuKNgXi8Q064ZMqYqNYT3tgVw6TH98pOL+a4CvzuXm95fuPG2He5/vcWr1VktMmv
	pVHcCZfke2lzeugzokCsnVy6NJ8VNi12qO1qNAMj1H1VNAQCKHJ0ZwNqOqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791181641; x=1791268041; bh=51MOquD0eh1zm5OCxKIjP34fkRv1AsRhtMr
	eFJzlV78=; b=GTJBLFqr6WGnvkG0h1dZOtlmnPwXfjGQ2sRwtQctGUqlzMDPWZN
	YHaicEUtQlXz0vG/lCC6srp+k/8fPdTVFVoaPsP6wTY5id9VeCQt2GUHIniKWfY9
	iUVuF5M3DKCSWKV9eejl8iu0RYk2ebv+GNqdo124Ftd1XzbfozU7jZ3Vzt8W5kwB
	8vHlR4pS/AjKtuQyOHv2M0En1T8k1xHyjueeAkeSvkbrf/0YW2Is8WcdgY+nwxUR
	Cy4CbgysqUV7DS4yiFOdexNl5ZzntBt9UCLaEr5rqP4NdbWUH8nzRuYob8TlrGJa
	Vm0nazSpWobsM6D9KlBStUsQbnYYj9LccfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791181641; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SkEd+DrrY1owAVfDiQyl7tFoepMtEt62GX8gz7bQa01qQb0
	5HCN/7KA0x2ywLZwKcY/FBQEfrStjssKVOFSz9H+ksTpHKKnmkDwJDzdu/BmpgDe
	Ik1w2btwwjAG64es0u8cJgZ1h9Y919T/e/20qUg4ISLE9vw6y0dNaX07/n1mF5IC
	pTsl6PGHKJpuAJ8EufWkikFzlusMK/m++57jE9huRxzC9VbffME1LBbXjksPGo1q
	enKwlUwl2RrorL5fgzFs3I9K14g8WMHJgWZ5zjW1IqUWEQGgm9tRZO8KueRJEwUZ
	6VL/6VeXrqxtcm3g1wPpr5+yheX+lSCZM9xYY6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TcO/IfhQSQ5k57fdSv0UzNjLuPZaoVgYO7BeZ77PiYI=:V0wsQ3T1wrSnmGvtDkvvkNh21MiJXiXPE+IXbPmnVWE=;
X-ME-Sender: <xms:SUPDataXuNdF5Nfmgh6hPDVE--tqoe7lpJcHuJ-4kWmCmlz27Cbblg>
    <xme:SUPDaoErvDYxLE7VzvS8dg-NxlR4XQIslsgbLB-m2wf78Tc2XBy4iQhg9q4Uw1f6Q
    1fm8YREzfcwRgak2K98_7MtkohIGDTrJvatrPiGLYv4bYZYMOw>
X-ME-Received: <xmr:SUPDapzG455iHSpafzV8_T_y8sAN35Ug-ra1NVYAMwzzQFYTE1zQY1DH2nflxpWi4Wa5ZKw>
X-ME-Proxy-Cause: dmFkZTGU90vG53Jttjc6YWZRB6vFXZVCSANt2wE2rwTgHBqrkhxB8OqnQb3T9E/d3SOOqG
    FaW4TVL4N94ZXpCGwt8NTSzAytjXU2+Knvpx6qiCs4An7MwEBvn+e0SczphsiGmjOoMu1U
    LZSLD1VXfFhka6Xyv/FuMd90Upk1RTnR14BhMxKKtIm5mzfVSlr6TrOLHvA4aAn20Xywwc
    7+QLmwInMXITmGWopRL0rrK3euX71CYiQt/mwGjW7B3piTQMysJsABmywKhq1n4koDEXZ/
    jUfCq8U6oGOqSx+BjxhyyQj4Ln/N4fgAb7BwRBm3hSqJGabcix2X6WfpvCwUe4v0LcDbN5
    vTB/q+iAUZdFg9f1dhQL752qgNDBmckPGvrEKSu3BlMbn6Sj0HXKRhjCFz6kg0np0G/9GN
    5JqEBMQSOIw9IKpbdwM7VumakXBPGxTNOMET/V25GN7INfNV49IBwa9GOSnP2+GyvyKEaI
    BS+efQw4YDMZgS+PwgUPahzOzA3DhyI9hYHIYhHFrap4+qVvfymOKXbpO97Th5j41w3X7w
    zKWumN8c+8Oylq0HKWJwoGRSH04yg+wJ03o3kLUVORG/a8ikufzvwvmH8gL2s6cBDtZ/HV
    P8wHax1k+hV0P83vizGTn78jjX6hHnHLCk6of8Qo8WgekHNaaVjBufRvDvRA
X-ME-Proxy: <xmx:SUPDaikoKY9g5XRpBW9VoZG8_H0qmhgyD08f0x1ByrowDk9c9ZZYZg>
    <xmx:SUPDaqm-3Oh1AxUNbxpsEtP3WJ3nOZ6SmKioFYA_2xPs-ummHcT7Mg>
    <xmx:SUPDaswiRVrO0SlpxqACW_o3rZFxtif0TDTUiE83pa3MEl5ZTxNnJQ>
    <xmx:SUPDanqPy5afVAQx6PXK9xpkZWyEyG74BzWgQQCyQsiYfmrUSwuO0g>
    <xmx:SUPDao0qOVCTySXgNZ8Xkl32lu6-UAiqgICaMjFBG92GQTfqUZUswwN->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 02:27:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc10dc6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 06:27:19 +0000 (UTC)
Date: Mon, 5 Oct 2026 08:27:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fetch: write commit-graph using updated refs only
Message-ID: <asNDP4_YlCHaWIVO@pks.im>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <fee92f3c2009f8f282fe98e6b16d403704db9ad9.1790930019.git.gitgitgadget@gmail.com>
 <ar-T2y54X1uDQ4mX@pks.im>
 <CAL71e4OcAg1PYaZZ2474Q5ayQgTeJFR2-7J+0ddrCe+rwwj=3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4OcAg1PYaZZ2474Q5ayQgTeJFR2-7J+0ddrCe+rwwj=3w@mail.gmail.com>

On Fri, Oct 02, 2026 at 02:40:44PM +0200, Kristofer Karlsson wrote:
> On Fri, 2 Oct 2026 at 13:22, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > >  1. write_commit_graph() was added, and it accepts an explicit set of
> > >     commits as seeds, enabling more targeted commit-graph updates.
> >
> > Hm. The big question here is whether these additional seeds are additive
> > or exclusive. That is, if I have an existing commit graph already, would
> > it basically just extend the commit graph with the additional object IDs
> > or would it replace the commit graph with a new one that only considers
> > the passe object IDs as input?
> >
> > I would hope that it's additive, because otherwise you may now lose
> > commit graph coverage for stuff that was covered before the patch.
> 
> Yes, it is additive.  fetch always writes with this flag:
> 
>     int commit_graph_flags = COMMIT_GRAPH_WRITE_SPLIT;
> 
> so write_commit_graph() only adds the commits that are not already
> in the graph, as a new layer on top of the existing chain.  When
> layers get merged, the commits of the merged layers are carried over.
> 
> You are right that a non-split write without COMMIT_GRAPH_WRITE_APPEND
> would replace the graph with just the closure of the seeds, so this
> relies on fetch using split mode.  I can extend the test to verify
> that commits which were in the graph before the fetch are still there
> afterwards.

Awesome :)

[snip]
> > Curiously, you mention performance as motivating factor for this change
> > but don't provide a benchmark demonstrating the benefit.
> 
> I left it out since the change avoids work rather than making existing
> work faster: the cost of the full scan grows with the number of refs,
> so the improvement depends mostly on the repository.  But I agree that
> some numbers are useful.  Here is a synthetic setup: git.git with 200K
> extra packed refs (~206K total), a local file:// remote, an existing
> split commit-graph (and a warmed up page-cache).  Times are the median
> of 9 runs and I am looking at the trace2 region for
> fetch/write-commit-graph:
> 
>     scenario          before    after
>     no-op fetch       380 ms    (skipped)
>     1 ref updated     357 ms    9.3 ms
>     10 refs updated   359 ms    8.9 ms
> 
> I will include these numbers in the cover letter of the reroll,
> or do you think it makes more sense to also have them in the commit
> message?

I think it makes sense to have it as part of the commit message.

> > > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > > index 533fdfe7d8..8ad7331640 100644
> > > --- a/builtin/fetch.c
> > > +++ b/builtin/fetch.c
> > > @@ -1903,10 +1903,30 @@ out:
> > >       return retcode;
> > >  }
> > >
> > > +static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
> > > +{
> > > +     struct ref *rm;
> > > +     for (rm = ref_map; rm; rm = rm->next) {
> > > +             struct commit *commit;
> > > +             if (rm->status == REF_STATUS_REJECT_SHALLOW)
> > > +                     continue;
> >
> > Hm. Shouldn't we also refuse almost all of the other values here? I'd
> > expect that we only want to consider a tip when it has REF_STATUS_OK.
> 
> This confused me at first too.  REF_STATUS_OK and most of the other
> values are only used on the push side.  During fetch, the status stays
> at REF_STATUS_NONE, and the only value that fetch-pack sets is
> REF_STATUS_REJECT_SHALLOW, so that is the only one we need to filter.
> Requiring REF_STATUS_OK would skip every ref.
> 
> However, I could change it to use status != REF_STATUS_NONE --
> those are the only two statuses we can get so both would work,
> but I guess which one is best depends on what kind of new statuses
> could be added in the future.

Okay, makes sense. I'd aim to be as defensive as possible, and defensive
here probably means that we should err on the side of covering too many
commits rather than covering not enough. And that's basically what
you're already doing anyway.

I think having a short comment that explains this would help though.

> Refs whose local update gets rejected (e.g. a non-fast-forward without
> --force) are still harmless to include, since their commits are fully
> present in the object store.

Yup.

> > > +             if (is_null_oid(&rm->old_oid))
> > > +                     continue;
> > > +             if (rm->peer_ref &&
> > > +                 oideq(&rm->old_oid, &rm->peer_ref->old_oid))
> > > +                     continue;
> > > +             commit = lookup_commit_reference_gently(the_repository,
> > > +                                                     &rm->old_oid, 1);
> > > +             if (commit)
> > > +                     oidset_insert(tips, &commit->object.oid);
> >
> > This is something that always trips me with `struct ref`, that I'm never
> > quite sure what's what. So please forgive my ignorance, but why do we
> > look up `rm->old_oid` here?
> 
> This tripped me up as well.  In the fetch ref_map:
> 
>     rm->old_oid            the value advertised by the remote, i.e.
>                            the new tip we are fetching
>     rm->peer_ref           the local ref it maps to via the refspec
>                            (e.g. refs/remotes/origin/main), or NULL
>                            if it only goes to FETCH_HEAD
>     rm->peer_ref->old_oid  the current local value, before the update
> 
> So rm->old_oid is the new tip, and the oideq() check skips refs that
> did not change.  rm->new_oid is not set on the ref_map during fetch;
> store_updated_refs() copies rm->old_oid into the new_oid of a
> separate struct ref for the local update.
> 
> As a concrete example, say "git fetch origin" with the default
> refspec sees that the remote's main moved from A to B, a new branch
> topic appeared at C, and stable is still at D:
> 
>     rm->name           old_oid  peer_ref->name             peer old_oid
>     refs/heads/main    B        refs/remotes/origin/main   A
>     refs/heads/topic   C        refs/remotes/origin/topic  (null)
>     refs/heads/stable  D        refs/remotes/origin/stable D
> 
> This collects B and C as tips and skips stable.  When fetching from
> a URL without a configured remote, e.g. "git fetch <url> main", the
> entry has no peer_ref (it only goes to FETCH_HEAD), so B is
> collected unconditionally.

That part really is quite confusing. Thanks for explaining!

> > > @@ -2822,7 +2852,13 @@ int cmd_fetch(int argc,
> > >               }
> > >               trace2_region_enter("fetch", "fetch-one", the_repository);
> > >               result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
> > > -                                &config, &filter_options);
> > > +                                &config, &filter_options, &updated_tips);
> > > +             if (prepare_commit_graph(the_repository)) {
> > > +                     if (oidset_size(&updated_tips))
> > > +                             graph_write_mode = GRAPH_WRITE_TIPS;
> > > +                     else
> > > +                             graph_write_mode = GRAPH_WRITE_SKIP;
> > > +             }
> > >               trace2_region_leave("fetch", "fetch-one", the_repository);
> > >       } else {
> > >               int max_children = max_jobs;
> >
> > It's a bit curious that we have `GRAPH_WRITE_SKIP` as an explicit value
> > here as it can be trivially derived from `oidset_size()` anyway. But
> > other than that this is the safeguard that you were talking about: when
> > we have a commit graph already then we only update with new tips,
> > otherwise we use a full reachability walk.
> 
> The oidset can be empty for two different reasons:
> 
>  1. the fetch was a no-op, in which case skipping is correct, or
> 
>  2. fetch_one() was never called because we took the multi-remote
>     path, in which case we must fall back to the reachable scan.
> 
> Deriving the mode from oidset_size() alone would make "fetch --all"
> with an existing graph skip the write entirely.  Setting the mode right
> where the fetch happens seemed like the best way to make this more
> explicit and easy to reason about.

Ah, right, the second condition is what I forgot about.

Patrick
