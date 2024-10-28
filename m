Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A21EF0B2
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156109; cv=none; b=aSnG8cOHfSvq2IgrlGkEDZV5iw8R4jOUZ5PEkFDe9HnTtpFq1eBCOemwXmVtrKQRC4nR/8ZtbQBosl4RCSyS/IWztic+hU84DMzJY7U3VvG4aZmtc64r3z9csDfRnmIFcCp1mAp1MH1FgjA3fX+j8ni7kQ3nGDyhYK39ry2mR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156109; c=relaxed/simple;
	bh=WUZEzdtncN7n7nq9jynZylFydX/PLQvAfbnUP0Dcrf8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EvrjVHa9HoZ+yWzK8RIfKUC+RVgUA+7yFG1JYwpM9jN47bJ82NYjOYP61iNFTdqFNxxCZoMn75olSSWxi/NlMY570e/qTux2eVJ0noKjJj6nohOVqxeHMU3sMS48xqcFFZSrDsWdvP9H09NRu/daAtJuFlx02WmKTvjStXo8aSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQLsS1AS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQLsS1AS"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e6101877abso89905037b3.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730156106; x=1730760906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WK0v2NqUlsXKe0qI/F8c/VROn+QHv3Fix8YYeWjxX5E=;
        b=eQLsS1ASikPY2jtsFIViPZeiqYv1ALuKtF/AhT5Qjpw6xx7GFvgh02U5O2Crq4uhFf
         cY+j8SQ9+D4cHpfDY4dymODFXl3EDULGpb4TXgjMR3GO126gHD6+V8eW4AZfpw/4J94C
         jDzbceKXcT+cR7cQArNMj60BIlcUJveW+YpuPlgA73ba61RjmJCp0VXstCab7b4AZ+8n
         2gmpYYLAQcC4DVaS7Bp3JirgIAnquHX6377eNmBRKpxV0emVnlLc0sghyMoXqT/OrSmf
         Fjx6gNugsWB5PuKxwxWNg2qc4RgBAgmQl+Q6oBZyjX0Rdnh2/P/u0YT4GGdY5ZnHdB+v
         Mnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156106; x=1730760906;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WK0v2NqUlsXKe0qI/F8c/VROn+QHv3Fix8YYeWjxX5E=;
        b=KEs8QNO48ac0uVPrzmC0yOQnxVFE0aL6bHC1En+DfKJGPYiaMknwKbakFbM6OY3NHu
         GtE2GooOXEO9wLn06Of5UkYfWsUOltdrCrJ+oLRSDkRdfk59+xSw/8e+WkTr6QEe0zOL
         Dp9HoZ2dOAN3DotTmM8ZnRfL+tzYRrcKiUxxjI7cf2uEOiS6JDALsQ7nTsCsHNGmnvC3
         CDIJTnsAmKgPjP1h92hhzbMIeap0iG6b35btw7RS77hDo8qqQ5NqVoTRvkMFc4ppEGJM
         Q7qZytYZvgsSY804RqbnReV/YCyWaYwYaD1mbxblllqgj1/NL753ySppzt/Gs+8YEqZl
         Y8/w==
X-Forwarded-Encrypted: i=1; AJvYcCWMPD3Reuq7YoFqIhanmH1Q+UsMhLKiLGAUOR1fFfbOzd4f/jK9wm1bUx4+kHiQ+93M7fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHoRj+a5Z1RrepVs9jcCacImI1QMIHWKcMitF/uLWRHUWjJ0a
	6HF0nJfutZFqsATF+dqFSBb8NwVPfPZT7tCK0tdapKM/JQ0kVs+be0MIaY2iSlAbW9Rf0FYs0Sf
	1uhVVfcow9xoWJVtcvDHFfnYDBtMiIQ==
X-Google-Smtp-Source: AGHT+IGb1mdgzK5ypjQewtMZlvvwl2BFy3lj0KPnVaF3KMC34A5UPM6WuqSj0LhT5b8jD/c4geN0OtVuGFZmL9E2fqwh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ba9c:8d0f:d4f8:e6ca])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8245:0:b0:e2e:2cba:ac10 with
 SMTP id 3f1490d57ef6-e3087c0fef6mr31811276.9.1730156106345; Mon, 28 Oct 2024
 15:55:06 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:55:04 -0700
In-Reply-To: <ZxlYYQ9VULcqj/YT@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028225504.4151804-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] fetch-pack: don't mark COMPLETE unless we have the
 full object
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Emily Shaffer <emilyshaffer@google.com>, 
	git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Han Young <hanyang.tony@bytedance.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> > I'm going to work on both those things in the background, but I wanted
> > to get the description and RFC out early so that folks could take a look
> > and we could decide which approach is best.
> 
> I am a little confused. Here you say that this patch is still in RFC,
> but the subject line dropped the RFC present in the first round. What is
> the state of this patch's readiness?
> 
> Thanks,
> Taylor

As Emily said [1], I'll be taking over driving this patch.

The tl;dr is this patch is not ready, so I think you (the interim
maintainer) can drop it.

This patch strives to avoid marking missing objects as COMPLETE by doing
a check in mark_complete(), but deref_without_lazy_fetch() already makes
such a check (note how it can return NULL; also its name implies that
it knows something about missing objects, namely that it says it won't
lazy fetch them) so the question should be: why doesn't it return NULL
when an object is missing? It turns out that it first checks the commit
graph file and if it's there, then it's considered to be present, so
it does not fetch at all. However there are code paths during commit
graph writing (executed after every fetch, in builtin/fetch.c) that
access the object store directly without going through the commit graph
file (search for "object_info" in commit-graph.c), and those functions
perform lazy fetches when the object is missing. So there's an infinite
loop of "commit graph writer reads X" -> "fetch X" (nothing gets
fetched) -> "write new commit graph, as we always do after a fetch" ->
"commit graph writer reads X" -> ...

So my initial proposal to not mark objects as COMPLETE if they are
missing does not work, because they are already not marked as COMPLETE
if they are missing. One could say that we should check both the commit
graph file and the object store (or, perhaps even better, only the
object store) before stating that an object is present, but I think
that Git already assumes in some places that a commit is present merely
by its presence in the commit graph file, and it's not worth changing
this design.

One solution to fix this is to make the commit graph writer never
lazy-fetch. This closes us off to being able to have missing commits
in a partial clone (at least, if we also want to use the commit graph
file). This might be a reasonable thing to do - at least, partial clone
has been around for a few years and we've not made many concrete steps
towards that - but I feel that we shouldn't close ourselves off if
there's an alternative.

The alternative I'm currently thinking of is to detect if we didn't
fetch any packfiles, and if we didn't, don't write a commit graph
(and don't GC), much like we do when we have --negotiate-only. (A
packfile-less fetch still can cause refs to be rewritten and thus reduce
the number of reachable objects, thus enabling a smaller commit graph to
be written and some objects to be GC-ed, but I think that this situation
still doesn't warrant commit graph writing and/or GC - we can just do
those next time.) The main issue is that we don't always know whether
a pack is written or not - in particular, if we use something other
than "connect" or "stateless-connect" on a remote helper, we won't know
if a packfile was sent. We can solve this by (1) only write the commit
graph and GC if we know for sure that a packfile was sent, or (2) write
the commit graph and GC unless we know for sure that a packfile was
not sent. I'm leaning towards (1) because it seems more conceptually
coherent even though it is a change of behavior (from auto commit graph
and GC to no), because I think that the repos that need scalability
the most already use protocol v2 during fetching (which does require
"connect" or "stateless-connect" from remote helpers, so we're covered
here), but am OK with (2) as well.

Feel free to let me know if you have any ideas. In the meantime I'll
look at (1).

[1] https://lore.kernel.org/git/20241023002806.367082-1-emilyshaffer@google.com/
