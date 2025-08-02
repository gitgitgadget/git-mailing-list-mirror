Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CF1B7F4
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152534; cv=none; b=MnzGxYv3lLJZZFd3CZWubpUc+pQ2pU4xpU5RtWDMUdRBiE7ljL+Iv+LJt6UuFnnwvExmw7tvBtcpxQC3DdN39tYT7PDIk/VMCLbZsWTWe3qK+vAlVviNVAfQ/ACNOqsHfeLOqs7pymVmMWq7aTNT1QBWZxaV/MeFXBvTOP1QKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152534; c=relaxed/simple;
	bh=2FBO8tdM4JZzMC4ReEXEvuYDQZTCVsA7QZ3uRnIuuSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLO7hVZ0hwRVDYdiZW0wCZuh0Yud94zgelCm1y/vuOEetkm/aM4iQOaRpw8+0v6CxtOHDl0OjJ4eF2Kq3C5PXvH6iybsf8+tlC0u2KdXuqA04QTm+sSEPzvnhJhtUxrYa9GlXGAJ+ZFQC9hJ5HzvvTaItJx9uTHxbul+Q1aTSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WYTaJ8q9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WYTaJ8q9"
Received: (qmail 12292 invoked by uid 109); 2 Aug 2025 16:28:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=2FBO8tdM4JZzMC4ReEXEvuYDQZTCVsA7QZ3uRnIuuSs=; b=WYTaJ8q9e5vsSr7bzl+IW5Zt+ja+g+tEcQc5DSLh2VO62D5JaqFP/LTMWsSq8nC5CJhwjl02hGSLtqZk3ku55L4mEBUgMIPT2bJTxaa4e3QOqHs40SXJwIkEPBtegXIvwkbsE2K+pezCoSCMhONnaa/wWeQowGKa6RcdJ/XEzeeMha6XqFYr2p67s/r4BvD5JGesQT8EizMzLS1tM/mVX6gTDTajEqxQe5yerrYflEGDyGNSAjKhk7JFBJIjWJNiwe7a1dG+ybp+wD8sFswthugs9p286w3Vto+zQ3sAGonanBxYA199LbAtEQvbdjzUvzxYB9vGsAmpJRCsRBwJkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 16:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17540 invoked by uid 111); 2 Aug 2025 16:28:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 12:28:47 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 12:28:45 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more
 than 2 arguments left
Message-ID: <20250802162845.GA1203943@coredump.intra.peff.net>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-5-ben.knoble+github@gmail.com>
 <xmqqms8qzdd0.fsf@gitster.g>
 <CALnO6CAbTjuFrLbhC24VDmdy4Utx29g92M5eYV9BPahXK+o+1A@mail.gmail.com>
 <20250802092331.GA3721454@coredump.intra.peff.net>
 <CALnO6CD_=ksmXrzS-k5rQukYcMSDLm0HSLZ35xP-Y1neKc70Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CD_=ksmXrzS-k5rQukYcMSDLm0HSLZ35xP-Y1neKc70Xw@mail.gmail.com>

On Sat, Aug 02, 2025 at 12:10:17PM -0400, D. Ben Knoble wrote:

> >   1. You didn't touch this spot in the parse-options code. Would you
> >      need to for it to be consistent with the non-parse-options callers
> >      that use the if_asked functions?
> >
> >   2. We can only get here if we make it past the help check in
> >      run_builtin(), that you do modify in your patch. That works for
> >      git-grep because it does not use RUN_SETUP, and calls
> >      parse_options() before checking whether we are in a repository.
> >
> >      So in run_builtin() we do set "help" to 1, but it does nothing
> >      without the RUN_SETUP flag. But imagine a hypothetical git-foo that
> >      takes a "-h" option and does require a repository. It would set the
> >      RUN_SETUP flag, and then:
> >
> >        git foo -h bar
> >
> >      would show the help before we even get into cmd_foo() to parse the
> >      options.
> 
> I think I need to consider both questions in parallel: as you point
> out, this patch probably doesn't work for a hypothetical command that
> both needs a repository and has a "-h" option. (I note that ls-remote
> also is RUN_SETUP_GENTLY, like grep). Since no such command exists
> today, we /could/ take some version of this patch and refine later if
> a command needs both RUN_SETUP and a "-h" option. Or we could reject
> this patch (assuming there's no workaround for now). Given Junio's
> concern, I'm inclined to just drop the patch from the series…
> 
> …which moots question 1, I think. OTOH, if we keep the patch, it does
> seem like we might want the parse-options API to be consistent.
> Fortunately, I don't think this area needs adjusted for 3/4 based on
> the tests.

I think I mostly share Junio's concern. The issue is that we want to
detect the "user is asking for help" situation without having access to
the option-parsing information for the actual sub-command. And so our
strategy has been to make the rule for triggering "asking for help" to
be fairly conservative.

If we loosened it now, even though it happens to work for all current
commands, we'd later potentially have to re-tighten (which is awkward)
or start carrying extra signals back to git.c (e.g., a HAVE_H_OPTION
flag).

> > BTW, I applied your patch 4 manually to dig into this. I wasn't able to
> > apply the whole series. It doesn't go on top of the current 'master',
> > and applying with "am -3" mentions "sha1 information is lacking or
> > useless". Did you build this on some other unpublished series?
> 
> The base is published and mentioned in the cover letter [1]; if I can
> make that more explicit in any way going forward, please let me know!
> 
> [1]: https://lore.kernel.org/git/20250726165320.4039-1-ben.knoble+github@gmail.com/

Ah, hmm. I was trying on top of ua/t1517-short-help-tests, which still
fails. But it works if I merge that branch to 'master'. I guess that's
what you meant by "Merge that branch to a new topic branch".

-Peff
