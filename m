Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84925B084
	for <git@vger.kernel.org>; Sat, 30 May 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122553; cv=pass; b=PQ4BL1G1uYr7n1V5s9kP2PouiaVk0vNIGYdmXHQmtZMos74YdKhi1cdIFPL9UIGidzJ9EZRQ6vsqyIlIm37pX8TgMQLErfMAUjAvWGO/UqUjZm3boNrT/UeDoehnmvYaaLsEtn/YK3z9M1UOJ7OvrWAjAtDw2rYE3sLVnOVYQeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122553; c=relaxed/simple;
	bh=Z0lABA8n3v2EGsRc/ekvl5p1YlI2kYRsnyKu7pStorY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VFax6E4242IKFK6H3oTJlBDEqBPyaf2qLZ+aOSIVuYZ8kiL3i18NxpIkILaU4zZTAqwnLPlK4VLY2T21npcwRfsyoTuRPeZJhteTV7Ko5mHQUqMPXRhdJ9j1mip4TjcmT/7oO2Shhd+MZZarDzCzpJCH1OH7hRwmM+GzInWsT5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=DeO0DEnn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="DeO0DEnn"
ARC-Seal: i=1; a=rsa-sha256; t=1780122544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XBbUp+LPZYAmoZhzrN3QI68Af34vHYxij860VLws7xll3fgYnhQp1PhoEVkq3gHuNfx8DueUkFvxqH5qDKfG5qn1QUEvdHouTRAKR9VMcJkyI3BHivorDvmEJfpiNrYUNVFwhXV+revv1y3I6umzFXe+iBU3Ig26lZDit5U94eM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780122544; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hhMWVJdkSZga/SH+2D0fz47zYt8ZOC/BDqKBfnL7j0g=; 
	b=oKL1GFUw7zpFS1/tep1LhTIZCYCLtu+wKjE0q3olRi7OXEoFahJMalaAOnSBshQDGcxD3RAc14+bqq/SaopWuB+sfaQ7nXeDwbaPZ03cDPrDx4Z+RM7g5Ub+5XN44iEwAyGgOAqFa5PCPKmdLE7sdhGxfpQ4bUGu+InGgDGYrJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780122544;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hhMWVJdkSZga/SH+2D0fz47zYt8ZOC/BDqKBfnL7j0g=;
	b=DeO0DEnnNA0VP3UazsXLAunRUeQsuR+YEo3ecaIzrAgmWRjLIYMez3Fw0apG0pFH
	e16oYIBwRnMwzuIKzw0/YDlkDPPI8RsBnEcahipT84suRl6yVB0f23I3+oRxTK+YW7X
	DVdIXEXyNEMb54FHiwpHFoHsqZbN7Bps53G0mMO0=
Received: by mx.zohomail.com with SMTPS id 1780122543078400.00491600995156;
	Fri, 29 May 2026 23:29:03 -0700 (PDT)
Date: Sat, 30 May 2026 08:28:57 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] log: improve --follow following renames in merge commits
Message-ID: <ahqDqSH7yfYVOOyE@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahFDgq4TAcs29zCA@collabora.com>
X-ZohoMailClient: External

Hi Jeff,

On Sat, May 23, 2026 at 08:04:50AM +0200, Miklos Vajna <vmiklos@collabora.com> wrote:
> > There might be a more useful rule like: if the path is untouched versus
> > the merge result in all parents but one (i.e., TREESAME), then choose
> > the parent where it was changed, including any --follow processing.
> 
> I like this idea: it keeps working with the subtree use-case I have in
> mind and goes back to not change behavior when the file has history on
> multiple parents.
> 
> > So I dunno. Probably some experimenting could yield more analysis there,
> 
> I think requiring TREESAME for all but one parents is too strict, since
> a subtree merge will look like an addition vs the first parent and will
> look like a rename on the first parent. It seems to me that handling
> addition as TREESAME can be correct: if the file was just added, that
> suggests it has no prior history.
> 
> So a slightly relaxed rule could be: if the path is untouched or just
> added versus the merge result in all parents but one, then choose the
> parent where it was changed, including any --follow processing.

Could you please comment on this, if this tweaked rule and its
implementation in the patch looks OK to you? Let me know if I should
just wait some more.

I would hope this addresses your concern where naively following an
other parent just makes one use-case better and can be worse in other
cases.

This also explains why the normal history simplification is not enough
here: the "added vs parent" is a change that is not interesting in this
case, but is more than TREESAME.

Finally, because I forgot to react to that earlier: I'm not against the
idea to attempt to improve --follow work better when visiting a tree of
commits in general, but sounds like a larger rework, so it would be nice
to have a fix for the subtree use-case first.

Thanks,

Miklos
