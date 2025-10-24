Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21B33A02D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325200; cv=none; b=tw1koo3z3Ip1lcbqd1Bdqj7etTBUAhARpBV2zLYWRx0HMTPkVPYua6Za04HUzw6R2+f4K6z69Z9Eq3bbvNUGrGrwGJhhOFr2qYwbHU+lFJ6vNJq6mlrapLYrM54r7ud268VbjF0O0QFT3ehRF2WgbBMKD9ykTt7aUxZ3FwbvCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325200; c=relaxed/simple;
	bh=OgsiDSSNMuKlU0kDV+C5nC9CnPAz5d9waZyfNRz3O74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt+sC6GIJs/3fLx6KCNzk+Ny3ZW0emXtcmZ0VcWlQgRhFnXdkRQ/jumZwv3+ZBQwI9iuDqJaHC66IQzQZqHNFmrOHg81gai3U7iDrhgEe2sLg0lR8F88M0oIJSWBilgQx+l0yh6f5ale6Pb8QKTV3AdQn9Hi5LCvsZvC1nWeH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Db2OK9uk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Db2OK9uk"
Received: (qmail 326045 invoked by uid 109); 24 Oct 2025 16:59:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OgsiDSSNMuKlU0kDV+C5nC9CnPAz5d9waZyfNRz3O74=; b=Db2OK9ukHuFeY4GTQ2QrfEcUTDrqgU6QpFbovuDqAfUZB7QtlKiW/s5CBm/vPYRsXsTYH1p0l06TEBxLRVmtJ5HOVnW/vhypnlsj9Z0StnAAZCPyCIZKJXB4ARvgOSc8Q1xfauvmDYEc6buKSyU4INTfMdEM7K0M2fWAzv2kI68eVNZlEDqANvc4s7K5Qr8zPwsfPNvvrct2qkYRSIIKf8Hv5/hc5pCBAlVfjfgZ2ui39Dio4CUV0/+JP0TIPGCApXApNGRYLtLgrvE6AP5lNi5mpnySAeYp9CGsY4gFapTG9Ko5wbu8w3cbZqRBRjHQzHlONqggZO4d2LlcbWge8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 16:59:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513068 invoked by uid 111); 24 Oct 2025 16:59:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 12:59:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 12:59:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #08; Thu, 23)
Message-ID: <20251024165956.GA2344925@coredump.intra.peff.net>
References: <xmqqy0p1qjha.fsf@gitster.g>
 <20251024154719.GA1779502@coredump.intra.peff.net>
 <xmqqsef8p9n7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsef8p9n7.fsf@gitster.g>

On Fri, Oct 24, 2025 at 09:06:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Oct 23, 2025 at 04:36:01PM -0700, Junio C Hamano wrote:
> >
> >> * jc/diff-from-contents-fix (2025-10-22) 1 commit
> >>   (merged to 'next' on 2025-10-23 at fae07d2113)
> >>  + diff: make sure the other caller of diff_flush_patch_quietly() is silent
> >>  (this branch is used by ly/diff-name-only-with-diff-from-content; uses jk/diff-from-contents-fix.)
> >> 
> >>  The code to squelch output from "git diff -w --name-status"
> >>  etc. for paths that "git diff -w -p" would have stayed silent
> >>  leaked output from dry-run patch generation, which has been
> >>  corrected.
> >> 
> >>  Will merge to 'master'.
> >>  source: <xmqqy0p4wcac.fsf@gitster.g>
> >
> > OK, looks like you picked up the fix from the last round of discussion.
> > Good. Is this destined for 'maint'? My patch fixed the regression from
> > v2.51.1 with "--quiet", but I think there is still one for "-w --raw",
> > etc.
> 
> The plan is to merge "j?/diff-from-contents-fix" down to 'maint';
> any other changes that tweak dry-run are to be done 'next' down to
> 'master' but not to 'maint' as a longer term "true fix".

OK, that sounds good. I wasn't sure if it would have said "Will merge to
'master' and then 'maint'" here in that case (like it does for the jk/
version). But I guess it is just that these notes are for your human
eyes, and not a script. :)

-Peff
