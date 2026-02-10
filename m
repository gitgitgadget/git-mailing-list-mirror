Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F412D0617
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705971; cv=none; b=ApqfEbDO+bUovRQUU9/2Af7JFHsW4jEjXYjQWt1iiOVo5MvW+Aax1v5jxkt72Uv6BQZi01dDwkIYM1tsnh0un7xjZgx8/R/1ALo+hOmLJhmj6gqSS3uvPP11c8IF5p+tfl1lOWdWOaVxwsjba7xp3t2nisMiEKR7Zk/2BuDAQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705971; c=relaxed/simple;
	bh=d4UvmJiq3YDzEOrn05ND5dF3/B6ydoH/8Q0qr2eqr2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/Epi6SwvCeQih0BDiwNiffOQs0RqEvZoosJpACNrBnj2zfDPAZHD/PNiw50fU8mH90IMHXniIQkMMo6tPG23SV/iLggAuPYGoecyIv1O8IQOmR8WE5imRv/OnGHCZ5HoQr2HJtjubLARky8ZEwGDCXufm+elpeDEl+r0UdcEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OOhfy7/Q; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OOhfy7/Q"
Received: (qmail 353418 invoked by uid 109); 10 Feb 2026 06:46:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=d4UvmJiq3YDzEOrn05ND5dF3/B6ydoH/8Q0qr2eqr2M=; b=OOhfy7/QFWxrYW9sLRn6qqKegnNbkbjWusV11UgZfN/Z4Gj2xEw+LvOZao81+eBr1hbSTjqMcnlDrOXisb+hWS17EenuvHfJHWJdwOBF675yhzdTZKJgrXoatXC86Df8C77j61Yk+3JTE+ajeOaIAkEvQO6g2Zc/W+Zjpbvlsor7hWh0siw8Njx4eYA248rqecl7IFw3R3mQCUVv8PPOvXF+9Iq7rO2Zo15bIyphrXSGUGIiU1md6A5X4sPlLpbDp+lSSuy616oYOtJOuSaiC332mQB+xjCfeiQdtj0/sdcB/Ck7lpoTitms9n5dmtxe7eZKwQ4fUVKgUyD6+MNmAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 06:46:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 697845 invoked by uid 111); 10 Feb 2026 06:46:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 01:46:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 01:46:08 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com
Subject: Re: [PATCH 0/3] commit-msg.sample: reject messages that would
 confuse "git am"
Message-ID: <20260210064608.GB1756549@coredump.intra.peff.net>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <20260209065703.GA585828@coredump.intra.peff.net>
 <f5f100de-815e-4bf3-832f-3d473413c635@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5f100de-815e-4bf3-832f-3d473413c635@gmail.com>

On Mon, Feb 09, 2026 at 10:43:23AM +0000, Phillip Wood wrote:

> >    2. I'd guess that these days only a small minority of people care
> >       about sending patches by email. So for most people, a warning about
> >       their commit message containing a diff or "---" will be mostly
> >       useless, if not outright confusing.
> 
> People do download patches from github and apply them even if they're not
> using a email based workflow. I'm not entirely clear but I think that's what
> happened in the post Matthias linked to. Though if they're using "patch"
> rather than "git am" to apply them indenting the diff wont help.

Yeah, true. I have done that (thought not very often). I think limiting
our thinking to "git am" in that case is probably OK. We have to draw
the line somewhere.

-Peff
