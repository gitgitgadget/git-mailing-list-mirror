Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E62BE03C
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514581; cv=none; b=lUKBziWeELBejpMukglTkmOoLDM7Uhk+AWR3XhPprYnuJudWvw8s5t3z2oELxZePkMnOI1OBQEVJZWXu2hTYMUcIKx+ilzGWis2pIIRuODU8HlZSXxuIpeIMWlea9vNqC4ZILwHKLU/Xgvsym7rQNCQN6H88IpuAamaDk0ybu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514581; c=relaxed/simple;
	bh=apIt8AZBnZP90axAwLDpBFwG5IwVSIS4JrhdgFwwW58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGen6q3w1pV1QdYJKc/8Dz7MS34lkmMt5mCTrxDdXrhX0SFq0jNuqfcZiFUNPGqHo9/QmGq0pmSW6TDEtzccMzLQcpOG75AQxRxOl1XwROLIJ2GTDaP4yAMsAsLznGn2Cm0HJE7f1FvwTuEm8Ez1kTL2i/6NRwL4HGD6uZ0DwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QMsMxVMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnmG71ZM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QMsMxVMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnmG71ZM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A7E141D00056;
	Sun, 19 Jul 2026 22:29:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 19 Jul 2026 22:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784514577; x=1784600977; bh=qqXzTLFhKJ
	7xQwDz7HRAuyWKwCfeAwO2by9WbiBt/k8=; b=QMsMxVMFOjxLeNvcvKd7g/VZpS
	ONzvHgu1CqkFLyPH5H9Ri7ofnJ9brsXr56GrokplI17rCeLBg+ceLu2njpz8KJ1I
	tDPiaQbvPVOXf5Sjn/oANiPAbZVJGpqWzFaYi+hzcqfJQg5LEYUHWE4kazRZvOV2
	orrVGbTPox+hSzxDLtUwRrvZo03nY9AlN3gKjV9eBmxKhCvN4wnfWaVaY/mjgGhg
	mTXdL9h3mZQISdnIzfXm+tDv23U0UVg+0YVH3xPPVzFbMUeCpHo4W/MIGL1VTf9p
	f9XkoQINMm0AKPsnLFONKTIFRaGwI0e0AXir+H9saVCGF1Fd7pIz4xMcnBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784514577; x=1784600977; bh=qqXzTLFhKJ7xQwDz7HRAuyWKwCfeAwO2by9
	WbiBt/k8=; b=hnmG71ZMKeGsaN9sq+U+tzIo2guYUMPKmELJw08wyb55BRqBNpv
	KI8K74D+0VrP77A78MyQHbBq2K9nzt4UTrlVUIHa8IVYGmu/bf5lIyKyE9L5wb3x
	Zu1u03/Dll0ldu1ZqB824FReBCJQN/bJM6jHIuvWXdnqhXSgMVmdr6OuwNHVwVZq
	5Gl2v3PoV4+iH8QU0PZcArx3wRHUFzsIcO4W5w2+UWnc4hQFAfjrLmhwNcLJrdUL
	hScPtER5a0Kty2wBMkZ9hJ2bcdf4d2LeP3WESgRxbbML222oA/z1ahgzNXW/Q+1S
	d252HnXctLHVmvzzudNuBjCH8y/WEZf/puA==
X-ME-Sender: <xms:EYhdagm3GIO7_qdnj9qQeXh5HIspCLvRQ_QphGz1IiZXrKXxUNhd8Q>
    <xme:EYhdamvrcKs5_sXLfLXCci8KnVcYcv8icayS-jdiF3q86eKWXx6yBqswPBlKz5OnR
    oLwz-2nGS-Xlw7BLWLgMN8ao1NyiZV21BW0Grmc3MS58kRKLxLskDE>
X-ME-Received: <xmr:EYhdam_xTOYsx_edseGoATWb6Br0I6RHZFo32hm9sSh6bRmWYyuvTFsOHqj0mY_8ho4Xm8XZk6jeuw38xzXkkoSpwNve-NTrxA>
X-ME-Proxy-Cause: dmFkZTE5pEzvK4UBISbzPpGBM4782OWhG9sZG6wetpil7+wAKmzAg8iHay9ytyQ1bEwsSy
    GZX2i2+9WO4NVe9KoLQMVSRvBvSAk3orBYhU2N0tdZw1LT5fHufPd0qoZBHByka8/9Qkgp
    d5rm73LKOTvQ6HdV4MpWFr3iGFFWeC80+JHJD7EvKhoX6D7QtMf/SsUz6s4c/uiSkszPfH
    gVvp1YU+LIXG5LDUP91sLRCiMuGIEbhCYT40hObfqYjNaqrLuuIVp08cGlLkggnCiXU9io
    q8++fR8cUCw+WPRc1P2ZuUfivJDmUQjCyTs9gfatun4BCIZnuAsQiIx3GOPjP8swgKtMj3
    73outuCjClqpHVzXDK5Obmgjf5A1bjM38vyyk5TatKxTaC9LssMY7h/5O49YIvFrMjR+/s
    R8x7yJL5lJnNe0t5Cd9rdnZ5jqwYUIv/pecCnv+UK6wjlp2MYWW0uaiacIoCImeYfG44Sp
    tj89p9Tvk6qZyrxSJICnux3KPN2OcZ/m+fUDpR6ZWg2eCZh8E4Tg6ODghgZct0aalPXSih
    bledQlnFi7KNP8oNvk7y2DIgVNeleXsr39yPR7uyah+We0numvaxGWqSXY1lC9SCJ3BRO/
    G51TB1qs8Mi5bjSVelL/91SGSqPxwBUHAQyckdOpG8VpBAG0KPgXKBtjsDyA
X-ME-Proxy: <xmx:EYhdaoOwoYlEfrxrdzGLI5wKQof1Fri9PrX2KbT1xyujx4Ds00ijtw>
    <xmx:EYhdasGWR2auKhFFgB-xqXDdNJRRHLue2VnmIKcU4f9iWy7YzI1oaQ>
    <xmx:EYhdauTv1DnT_vdSW23PszSAXkXATvfDPlzFIbyp3IXqw4EdpsR6kw>
    <xmx:EYhdahtEmiOQ9Gcfv_RC6KU0d51PhYhBGq0kxRh5BcKvIkowcLZkpQ>
    <xmx:EYhdane0LdVUC71cXTjd5QLY9zYtQq4Pc1d0ZvWXwCgKodFO1Eobbcgv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 22:29:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
In-Reply-To: <9a0b542c-8984-4d73-8e24-00adf6dcd427@gmail.com> (Phillip Wood's
	message of "Sat, 18 Jul 2026 10:25:56 +0100")
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
	<89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com>
	<xmqqpl1q2xw5.fsf@gitster.g>
	<bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com>
	<xmqqo6h9z7e6.fsf@gitster.g>
	<CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
	<xmqqa4srnwfa.fsf@gitster.g>
	<CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
	<4d150f21-46ea-4bf7-b516-c1763c152b34@gmail.com>
	<xmqqmrvqhmpp.fsf@gitster.g>
	<CAHwyqnVwDsdvvg6a2BtAYw+hYRdgKvRXwHE+uzAZjherfu5B=Q@mail.gmail.com>
	<9a0b542c-8984-4d73-8e24-00adf6dcd427@gmail.com>
Date: Sun, 19 Jul 2026 19:29:35 -0700
Message-ID: <xmqq8q76jsvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Perhaps the user is not interested in "rebasing" the history at
>>> all, but is instead running a check on each and every commit.
>>> That is, a more expensive version of:
>>>
>>>          for commit in $(git rev-list bottom..top)
>>>          do
>>>                  git reset --hard "$commit" &&
>>>                  do the exec command || break
>>>          done
>>>
>>> that just happens to be shorter to type?
>>> Sure, that's exactly right.

> I think I must be missing something; I had assumed that someone running 
> a check on each commit wanted to ensure it passed, and, if not, they 
> would want to fix the problem that caused the check to fail. In that 
> case I would expect that they would want to amend the failing commit, 
> rather than abort the rebase. What's the scenario where one wants to 
> check a bunch of commits but not fix the ones that fail?

I suspect that is what makes this user "not interested in
'rebasing'".  If finding a single breakage in the history is all
they want to accomplish (perhaps because they merely file a bug
report and make it someone else's job to fix it), they have no
desire to amend and continue the run to find further problems in
subsequent commits.

Which, of course, makes me even less sympathetic to the proposed
change.

Thanks.
