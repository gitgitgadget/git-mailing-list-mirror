Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27406370D6B
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886981; cv=none; b=cRU2Ni6h/3HaX0VequBKkb4u7bB1V6pvlkcNkquit2AxDdhV0PCv984yPtQiBWMAiS7OgxH9V1pOa1U6SRYYT41lx13QHodm3qhl8y/bm5VGtIpiX99kmmWiHoWKKCTCmTpl7YjvxTsPNjXqd5CAO1Er/J8Szseu1xyJbF/a98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886981; c=relaxed/simple;
	bh=K2haEbp+lH+hKBR6vaVtrE9UYyEJQokWrfvSb6haRh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9liRkDDGUPoFBKfeQk56uym3x/wHBt5wZXbh/YMe7KFHr6GBTwMjINRTutEOFtKb9Y8dXHSJD5TNz8K3mJpg+2qgrOMovTAQgYsyg0ib5gw2ovzvrpalKyXMc0aNpJVD1GIO76zfPGzHd/j9TGRukkQf8NHPqC14brlJzRQfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=dA69Pqi8; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="dA69Pqi8"
Date: Wed, 22 Apr 2026 21:42:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776886976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbyGyce9VwkE6QK12RbayZ5sXyHWtQBwn7iQGBjgFcw=;
	b=dA69Pqi8ST6zOchBox2mOdqjh6YlECghxZlCBZIDEFSjH0PHFVf+vjYsG2wSEprmjcnilb
	O/apFt4rAtCDCqiAVoV+oTAKeG7/wReC3etP0ulZ/ten4CMIV422LTq7JUTQwxvi40YvOZ
	+AYAhsljhEhDT9+XzRdc1BHCxVHrL07rOvgGQIq5h7uTth1I6m03Q9bMv55m6gNDOTj58+
	zfbfOhe2ry1jNYCfpd5HMwOxBPAEdLJKmfazlL8FIRQ0PxT/nhDQ34BNPFMaGe/TgVCdw6
	le8BTbu9jpUr18owu7cU1nnWnwiyiMD/EKiRDb4Nux35xnw5JTaQCR6yvDbwsw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aekjhDIUH_joIH0b@exploit>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
 <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
 <aeUqSltEWIWaPDh3@exploit>
 <CALnO6CAjMAZhBk_WXW1wbKk1kpQScFtbY0R+mCxHTFB7=CcEDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAjMAZhBk_WXW1wbKk1kpQScFtbY0R+mCxHTFB7=CcEDg@mail.gmail.com>
X-Spamd-Bar: -

On Wed, Apr 22, 2026 at 02:24:48PM -0400, D. Ben Knoble wrote:
> > > > > >        c = pop_commit(&revs->commits);
> > > > > > +        if (revs->reverse == 2)
> > > > > > +            revs->max_count--;
> > > > >
> > > > > Hm. Why do we decrement here? Again, not an area I’m familiar with, but a bit surprising.
> > > >
> > > > get_revision() (in revision.c) handles the reverse option and updates
> > > > the "struct git_graph". get_revision() then calls
> > > > get_revision_internal(), which handles commit boundaries and max_count,
> > > > here is where it gets decreased. Since max_count gets decreased
> > > > everytime get_revision_internal() is called, if we were to leave
> > > > max_count as is before the walk (in get_revision() at line 4558), the
> > > > walk would stop before reaching the root commit. This is why the current
> > > > --reverse option is applied only after commit limiting options. So
> > > > instead we set max_count at -1 walking the whole history and storing it
> > > > in 'reversed'. Now we're in "reverse_output_stage = 1", and in this
> > > > state we never call get_revision_internal() again, instead we pop
> > > > commits from 'reversed'. Because of this we have to handle max_count
> > > > outside get_revision_internal(), so we decrement it in the snippet of
> > > > code you referenced.
> > > >
> > > > A bit verbose but hopefully it'll get my point across.
> > >
> > > I don't 100% follow, but I'm out of my depth :)
> > >
> > > I think I see that get_revision() effectively has 2 modes pertaining
> > > to reverse: reverse and reverse output stage (the former falls
> > > directly into the latter, though).
> > >
> > > After some setup, the reverse mode calls get_revision_internal() as
> > > you said. That decrements max_count as a way of counting how many
> > > commits we've seen through the loop, so if we asked for 5 we'd only
> > > process 5 commits.
> > >
> > > Then we fall into the output stage mode, which pops a commit [1].
> > >
> > > With this patch, in reverse=after we disable max_count in the first
> > > (reverse) mode, as you said. Ok: we get the whole (filtered) history
> > > then, at which point we can now shrink. That makes sense.
> > >
> > > Then in the reverse output stage mode, we pretend to have one less
> > > max_count. That's what I can't figure out. Is it because of the
> > > pop_commit()? I guess I'm not totally seeing how that interacted with
> > > the max_count in the original code: does the current code yield one
> > > extra commit in get_revision_internal() ?
> >
> > I'm not sure I understand what you're referencing with "Then in the
> > reverse output stage mode, we pretend to have one less max_count".
> >
> > If you're referring to line 4573, then...
> >
> > > You wrote that "we never call get_revision_internal() again," but I
> > > don't see why that's true with this patch and not true before it.
> > >
> > > I do agree that _somebody_ has to handle max_count after
> > > get_revision() returns with reverse=after. I'm just not sure what
> > >
> > >     if (revs->reverse == 2)
> > >         revs->max_count--;
> > >
> > > is doing.
> >
> > ...we're not pretending we have fewer commits. Every subsequent call to
> > get_revision() after the first call will never enter the branch at line
> > 4548 and will only enter the branch at 4568. Everytime we pop a commit
> > from 'reversed' we decrease max_count so we can limit only to the amount
> > of commits the user wants.
> >
> > So, to recap, with "reverse = 2", on the first call to get_revision() we
> > walk the whole history and store it in 'reversed' in reversed order and
> > return the first commit.
> > On subsequent calls to get_revision() we do not walk the history again,
> > we simply return the commits that have been stored in 'reversed'.
> > Everytime we pop a commit we have to decrease max_count, and we check
> > againts max_count to know if we shouldn't return anymore commits (by
> > returning NULL).
> 
> …but I think this one does. I think what I missed is that in all
> "reverse" modes, get_revision() does some pre-computation and then
> yields one at a time the commits. In traditional "after" mode, the
> counting is done by get_revision_internal() [before reversal]. In the
> new mode, get_revision takes on that responsibility of
> get_revision_internal instead.
> 
> Hm. That suggests to me that get_revision's responsibilities are
> becoming complex. Might be worth some version of a refactor, but idk
> which.

If the refactor is to yield the responsibility of max_count to
get_revision_internal() for the new reverse mode too, then I'm not sure
if we want that. To maintain state across calls to
get_revision_internal() we'd have to store the temporary max_count that
currently lives in get_revision() in rev_info. I don't want to add
unnecessary new fields to the struct when its space is so valuable
(afterall we're using bitpacking).

In the current implementation all of the reversal happens in the same
call to get_revision(), so state is preserved across multiple
get_revision_internal() calls through the temporary int max_count.
