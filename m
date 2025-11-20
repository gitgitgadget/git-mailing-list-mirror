Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701E13AD26
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676162; cv=none; b=tBGIwWZ0Ce03q9Gg9RsBnllSsTj9eqrM0HzewV/qY7iuzPpt+5BVqBytSY5UnaPerLomJ91rAwhAVZdP9M+5IPXHOW5XNSnIuUx2YKy9SroWv+z0FrzRuu+k0mTXh1691UGoIYu3btVo0ZHvoux+6rSM12OzvlGcKLJvbTU69Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676162; c=relaxed/simple;
	bh=bRSQ7AbtwON/4lswVaH5eR0ZS+aSH4xiqi5h3B2oKnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcEJYp4cMw3nDjCdaXnqVBXlgkAYxZPti0zIDVoX3N6NZ0gpWkKk3mSAMjX/yHErSs7gAEVm5gCv0vnKnJ9TvgNiAmxrQWorSEQVh3+8QpZdJXnUdMJpPC+KrD86j+56m2UOZMkG59zywIip4IFE7+C/qdVX97jhKYcrPeyYBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL2LuKr/; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL2LuKr/"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso6111505ab.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763676160; x=1764280960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWeenXz/Hk/5xr2BPM7AagOHyBtGQMil/gCIIpNfz64=;
        b=bL2LuKr/k3odh9gpVLWKzIa3H716FKVFeYzhZIy979DSUX3eEBGzQhO2Lia5Y8nv5w
         +d0p71szZTg3vkelQJTkFeTAr5T/uulzgD4+6IGnr62hVoSX7v7SS/Wu2JDWSiXvEdUm
         MLMs04Fo4h4hmmvkbRTf/kVXsOu4nnkG/j1T/f/L2vB2n4ziBNllsKK7Q6xWm6uqZjWJ
         dRBQ0rojgLYCbMgybw/k0PeyIMBlHeClNBFfa1hR9cVSeQfmvsjX2e32Q7+C8TJJkZgm
         LIhMaYXwD7rGFGAxTjyXaVdoih9MIm3uyTKO8J/py9KxfP15roeNMGe/8v4yVolRDiYX
         XnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763676160; x=1764280960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWeenXz/Hk/5xr2BPM7AagOHyBtGQMil/gCIIpNfz64=;
        b=c7eAze6+0XsGta0HBsrLOWud8+KGKgxlMXvFOLAxHjt8r1QZxA2660G1hrziF+Kd63
         U31IMU3FeSo1KtlIgOkiQUYxyY/5mIz1MZBo2ljvDf4WdPYTyDcxJVQ/6OXd50TyzEKk
         CSiRyvRsD+gQWd2MonWNFXYIF1MN1PHuxZQUb2LYf+q96MxFrO9xMtgw1+lxCnsRvSsq
         deSd41LntOwEpRTeg7zlrR2xzN28rKc/TTQ0PrLThb3LqHG7irkpjPedWcZ35fwD4BWk
         YvHCp4zHZv1hmSt2Qf7oJ/MzVv1F2vx3Y56DF082Z8Xw5DiDqdpiqF7Lsqdf/SiK5oDF
         5zcw==
X-Forwarded-Encrypted: i=1; AJvYcCW0PbRVbk0IjoznblA1bcnHaiUFOPJessE68tYdZzkLi6C1NecPkUQl7uGbq6qW3kERqYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMf3iKZryn/wULOwZ4QmDwBzxjSdF//ZDaqFxttlzeu4hlrxIE
	q1hxdDfEsYSfyzO4hSDwBh0om1wpOpDkki5HKYAOR59cnfs7vTGu/5T6jUOuiwQIR/C3PCP5HmW
	0kgqcSZEj/L6ZCAu0PE1Rb4dp5+a2n8E=
X-Gm-Gg: ASbGnctGCwYaj1oKqZx66XcXYYTp9e8HabU9kPdPHD0VLS5ucM7IA11yTKdmY4qeayU
	zVQmYGzG69vQEXUI3gsEISari2s7CqxSJDIleF9W4MTIEZwiLg0p1/JSBfZnPDUGp7nmQlMCGAD
	lpSObF88qcg6uPBj5uJlZ3yH+1lYJ3/zXs+FAzmmLPZe3wz2njWhGCpGl0jTV961X97m7x/RpRo
	dprH8wy+lIAXsrwIl4odGqcTtzs8CXoDXNRfHtMbtdfN3lkz1wxKNK+XaU3koGQGv2TP23NJS2e
	mX4VQCnfmnWmdHvih3EZaQYHAfbbRTwKMUw3Gz0=
X-Google-Smtp-Source: AGHT+IHFY5rPcH0Cst83uV8IGEMWL9/TndMWsuuIbkQWOdareaP7o8SNYuKLy0wHZ3HygHHC76M43G0LvxYW4SlAdAA=
X-Received: by 2002:a05:6e02:152b:b0:433:23f0:1ebf with SMTP id
 e9e14a558f8ab-435b8c181eamr2435385ab.9.1763676160246; Thu, 20 Nov 2025
 14:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
In-Reply-To: <xmqq7bvk77lr.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Nov 2025 14:02:27 -0800
X-Gm-Features: AWmQ_bmkf8hewmWJE9KtUBd0kW2cvCPZv1gR24330xHFoEPgz1_ketHap30Z368
Message-ID: <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Nov 20, 2025 at 12:28=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> >> This patch series is a starting point for such a command. I've
> >> >> significantly slimmed it down from the first couple revisions now
> >> >> following the discussions at the Contributor's Summit yesterday. Th=
is
> >> >> was my intent anyway, as I already mentioned on the last iteration.
> >> >
> >> > Sorry for taking so long to review the series now that it's based on
> >> > replay.  Thanks for working on this!
> >>
> >> With your comments and Phillip's, it seems that we are very close to
> >> a good stopping point.  Let me mark the topic as expecting a
> >> hopefully small and final reroll before getting ready for 'next'.
> >>
> >> Thanks, all.
> >
> > I'm a little unsure if it'll be small or just one reroll.  Some of the
> > changes for patches 5 & 9 might be big (but straightforward), there's
> > also a couple design related questions (single branch, HEAD-centric)
> > that might bring up bigger usability issues to address (if a commit
> > being edited is part of multiple branches, do we just rewrite all of
> > them by default, or error out unless the user specifies how they want
> > it handled)?, and a potential gotcha on patch 11 (how can you preserve
> > the index and working tree if the user edits the patch while splitting
> > a commit?) that may require rethinking or restricting that feature.
>
> Perhaps.  But I thought the existing patches limited its initial
> scope small and manageable that by operating only on a single strand
> of pearls, with an intention to extend to cover more cases later.  I
> was hoping that we can start small and simple, initially limiting it
> to single branch, etc., in other areas that require design
> decisions.

So, you are referring to the single branch, HEAD-centric piece of the
feedback.  The funny thing there is that operating on a more limited
case, without checking and verifying that you are indeed in the more
limited case (and erroring out if not), risks painting us into a
corner or providing some really buggy behavior when we aren't actually
in that case.  To me, it opens a can of worms and makes the problem
scope bigger instead of smaller.  Funnily enough, the single branch
thing is also the one piece of this that I think could be solved by a
fairly small change in the reroll (and I pointed out how in the
comments), so the limited view really didn't buy anything here IMO.

The other problems are independent of whether you try to limit the
scope initially in such a manner:

Are the testcases and the code requiring something for the feature
(ensuring the index and worktree are preserved) doing something that
is incompatible with the capabilities given to the user (allowing them
to edit the patch while splitting, so that they stage stuff that
wasn't part of the original commit)?  Or...is it assumed that the
split commits always "sum" to the changes in the original commit,
meaning the "other" patch immediately undoes those extra changes?
(Perhaps it's the latter, which I didn't think of until now, so maybe
we are closer to a solution than I realized.  In fact, re-reading the
code that looks like it does do that and I just missed it.  But,
perhaps having users edit the patch when splitting commits is a
special case that should be called out in the docs, since that might
surprise users who try it?)

I'm also worried about extended header handling for the edited
(reworded or split) commits.  That seems to have been overlooked in
this series, despite the fact that in early versions extended headers
were explicitly called out for the remainder of the commits being
replayed/rebased, so it seems interesting that they weren't considered
for the commits explicitly being edited.

And I'm a bit surprised that the original commit message for a split
commit is automatically associated with the second commit; if I had
been forced to choose, I would have assumed it should be associated
with the first.

Granted, I think good progress is being made and perhaps the changes
needed for the rest aren't that huge (and maybe there's more pieces
I'm not quite understanding yet similar to the
two-split-patches-always-summing-to-the-original), I was just a little
surprised that my comments are summarized by "expecting a small and
final reroll".  :-)
