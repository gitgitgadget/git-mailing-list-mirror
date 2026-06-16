Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5C3B9937
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621158; cv=none; b=jumasbVde5Ydbaq78XFJ9llS3V1Y7HOuh89RFRDyfsVERMJHX2twfi+lEpt5Xt3+LzOwYAfkvTHLGxPCC1G4Thz7d3UW1By9fAnJiofHLEXuTlvvNdqehIlt8RTIWIckx5w8xhFVn/poUe9ZmuKj5Fih3TE7Z/2/xva1KwuH7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621158; c=relaxed/simple;
	bh=QWQOzsYiD0rGG4fHyIpeSZkNMD8MJ8/NG3KsaVQwG1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVXDnanrj1+sd7o064tVCb/p3ulx6pTZ6dMvJb3UDxCDKHUyCGfr9YCOePbzrm8fK1ZhKE1BLyGJjjW/fvnm1nGDZYw5Q1FsbUCQeB4/+G8YGiKUoaB/xxqLRw/62t6y5pAb/6rUq6qQKS9qqlaC6dlnRV8yAXGmxlnnpnT9JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UwLu5nOo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UwLu5nOo"
Received: (qmail 150459 invoked by uid 106); 16 Jun 2026 14:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QWQOzsYiD0rGG4fHyIpeSZkNMD8MJ8/NG3KsaVQwG1M=; b=UwLu5nOoA7cTUPth/knigqKTv+N+i50NJty0a7eEkOuZgND7ZE3qPN1lQp3nPLob8hkAIkcIJbVw6UybZUIMuBd01VWMIHKsZ6SiUiRTGZZe5iv8j/x9QoZ9pTmtG88VGCFeeUYLAZz6jAlAWQUbBcAZmJoUCxQ+GlZ3Acs1QrtFddYn/G6xy1afB++D2lASi5OPvFZSG30rnl2js1JgvQ48S9mYbLNSdwvx50s1dvuUxiLop1SI3OHa5oT7FX6IXq9nh0uIuXkz80a9MFMwTfDryYrsY8o8zn3cgOyBKWBP5xm1dT7Q+oy++G87ZYBszTAGAcQDWRy0Imy+UBAAnw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2026 14:45:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 410753 invoked by uid 111); 16 Jun 2026 14:45:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2026 10:45:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jun 2026 10:45:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v3] read_gitfile(): simplify NOT_A_REPO error message
Message-ID: <20260616144554.GA2305974@coredump.intra.peff.net>
References: <20260602061159.GA693928@coredump.intra.peff.net>
 <ah6WEtk2pXyViEQA@pks.im>
 <xmqqeciezh0w.fsf@gitster.g>
 <20260616111919.GC687438@coredump.intra.peff.net>
 <20260616123516.GA2301231@coredump.intra.peff.net>
 <xmqq7bnya7gh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bnya7gh.fsf@gitster.g>

On Tue, Jun 16, 2026 at 07:25:02AM -0700, Junio C Hamano wrote:

> >     +@@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'git dirs of sibling submodules must not be nested' '
> >     + test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
> >     + 	test_must_fail git clone --recurse-submodules --jobs=2 nested clone_parallel 2>err &&
> >     + 	cat err &&
> >     +-	grep -E "(already exists|is inside git dir|not a git repository)" err &&
> >     ++	grep -E "(already exists|is inside git dir|does not point to a valid repository)" err &&
> 
> A few things.
> 
>  * Will we be happy to see only one of these possibilities, or do we
>    expect to see these once for each kind?

I imagine it is only one. This all comes from 9cf8547320 (clone: prevent
clashing git dirs when cloning submodule in parallel, 2024-01-28), and
it is expecting the nested path to cause a failure. Which failure I
guess depends on the racy ordering. If we create the inner one first,
then we probably get "already exists", and if the outer one, then "is
inside git dir". I don't know exactly what sequence yields the
NOT_A_REPO message.

But none of that is changing in this patch, just what the user-visible
text is for the NOT_A_REPO case.

I did briefly wonder if we might see "not a git repository" from a
_different_ code path, and need to catch it along with the new message.
But running successfully with --stress implies that we never see the old
one anymore.

>  * a recently started in-flight topic tries to catch bare "grep" and
>    fails until you write test_grep X-<.

Yeah. This will create a merge conflict for you, but hopefully the
resolution should be obvious. I don't think it makes sense to fix here,
as it's orthogonal to the purpose of the patch.

-Peff
