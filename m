Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F86324B32
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320849; cv=none; b=T/RLwVA+wVSrVY+4AV9Nc5oxRpEMXAt8OBzpGr+GJrlro49PnVxVv8+cudSK+a2lFZR9Pewsh/tA0PQIHpZN/KqtwzOY/HGqGWftWpb3zUoQUmoBGN4dKjL22japvTL9I93eBKXmrTNvbRI7P9L7mwsefo2a8Gmaqd+CXrgR1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320849; c=relaxed/simple;
	bh=SvvDTWfV9j+SfrIeaGYQkVdPIPO/JZ+8WvG+RcQsU68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah48KT8hRM6ERj2AgczkNP8mOMKS4Xywo62ycYy3MYPykdQZfnIdwTJgvcurAKX22Afb/nAz/mTD+E7I4zSoQw3L4KVafcgqAiVyHbD4l/qFomj2mz7LCI/j9ZtHlZq21PU4bqZ5O9dQflqgC+6VrRLEpQr3e9+1Z9MD8QsZuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gt+rVjDJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gt+rVjDJ"
Received: (qmail 325648 invoked by uid 109); 24 Oct 2025 15:47:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SvvDTWfV9j+SfrIeaGYQkVdPIPO/JZ+8WvG+RcQsU68=; b=Gt+rVjDJ5lYqbg92hqTNmPNKju9+i0TT0Qr3MGLS5Sh88o+pFcnC3Q5Rbx6ITh2Pntdx0WdFhgWvIvRrJhygBpXr3LK0QgPbvDGFD2jTWLTmAadVQDD81GLbwOEGFsrXp8R64BC4EqZ7HNBB6Ax00iK31dLEH25idFQwfzFXbtMoQ/afMOc5py1wLrUkFEax6BNB9vjhhGMbOljeJYFcTdpbkZ4bkHSQ/FKChRnxCHkaccO/Bah3KbJdyNa9oeLHb5X4PvLnaswUSrYBdhA4xPsZg5mLv9bew2LP0t9Y+580365x0MwWWAP1DEr7qdHcrHa+WgztpOf6Z8TI6gxPBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 15:47:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 512279 invoked by uid 111); 24 Oct 2025 15:47:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 11:47:19 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 11:47:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #08; Thu, 23)
Message-ID: <20251024154719.GA1779502@coredump.intra.peff.net>
References: <xmqqy0p1qjha.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0p1qjha.fsf@gitster.g>

On Thu, Oct 23, 2025 at 04:36:01PM -0700, Junio C Hamano wrote:

> * jc/diff-from-contents-fix (2025-10-22) 1 commit
>   (merged to 'next' on 2025-10-23 at fae07d2113)
>  + diff: make sure the other caller of diff_flush_patch_quietly() is silent
>  (this branch is used by ly/diff-name-only-with-diff-from-content; uses jk/diff-from-contents-fix.)
> 
>  The code to squelch output from "git diff -w --name-status"
>  etc. for paths that "git diff -w -p" would have stayed silent
>  leaked output from dry-run patch generation, which has been
>  corrected.
> 
>  Will merge to 'master'.
>  source: <xmqqy0p4wcac.fsf@gitster.g>

OK, looks like you picked up the fix from the last round of discussion.
Good. Is this destined for 'maint'? My patch fixed the regression from
v2.51.1 with "--quiet", but I think there is still one for "-w --raw",
etc. And so our choices are:

  1. Take jc/diff-from-contents-fix to maint to fix that.

  2. Take ly/diff-name-only-with-diff-from-content to maint to fix that.

  3. Let that bug remain until those topics hit 'master'.

As I said earlier, I had at first thought that the bug there was just an
incomplete fix, but it really is a regression (extra garbled output).
I'm OK if we want to do (3), but there was so much discussion I want to
make sure that we're making the choice intentionally.


Also, (though maybe a bit late since it's in next): the comment in your
patch has some typos in it. But if I'm optimistic maybe we get rid of it
in the long run anyway. ;)

-Peff
