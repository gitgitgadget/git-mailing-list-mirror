Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921034B19A
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160080; cv=none; b=WIBPfz1kd5t4Ci9X/kEdr7BgrCL7xnkfNxBe2UgNHNR8Y5S9Xn2WL9PZ70fkFKDVJPrkJrx6IUN+JwZCh8Ctvt+aP5wzCes65+qH1K4QCp4Oi58M5UVOD82IRXM6EXwLXd2z2Nmu3DMiKxRg2ESbzJnvVMiBmJeu53xZH6wazrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160080; c=relaxed/simple;
	bh=3BJ1Q+57aguc5WiCQmpeFX0r/V23ofm+fezyeurPftQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZEjxhitJzwVyE3FxUS4O4QXhP8cCLeYQrzhBNZpIbHHGbGTTeUVi8K882R3Kci/iEwZ7hATOfeBWzpRcFsIZ9Z5ZGt7pzM68fQhJ+2pPDMPFMTx6EQKW05IDHtKQ4J+gICnkujZNU1i/LTL2cYgdyV1Z54cwSwzG+jG3RosAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ej2cnH8V; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ej2cnH8V"
Received: (qmail 106278 invoked by uid 106); 11 Jun 2026 06:41:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3BJ1Q+57aguc5WiCQmpeFX0r/V23ofm+fezyeurPftQ=; b=ej2cnH8Vo9KdLPJ01so01miZmfGcdMMZmUOK9/C1mkXYqGgutM1UuaO4dCIlFGGr2WmbgIxp/EdS7jC9Fh7ta7hn7g87yEekJMq2pVgnUYespH94FWFS5gtGqzyGxjyGTqglW9Lp30DCs+HwLhURhRuzAliBt51tfBU3N9ymP1qER8ZG2hDdwkXKGIfwc2qwFfVmQxWMeUSu94m7JYoLNd5mOhK9RMBVHAwTOoLO+jeHUOT2jeyLEyaRY+Pz2W++AY7Kqvdd3hTwBCZKTMt+SkVHGFuV/GhY3h13qxXrJrX2DsDiBbsWgC3yiiPeSeD2sJrmnSyxbPJaJ/3KKTj4Tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:41:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313960 invoked by uid 111); 11 Jun 2026 06:41:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:41:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:41:17 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
Message-ID: <20260611064117.GB2191159@coredump.intra.peff.net>
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
 <20260609110957.GB1509396@coredump.intra.peff.net>
 <aika_Q0rWhcI6eXR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aika_Q0rWhcI6eXR@pks.im>

On Wed, Jun 10, 2026 at 10:08:51AM +0200, Patrick Steinhardt wrote:

> > Given the discussion in earlier rounds and sibling topics, I assume the
> > commit message here was AI-generated. And it's OK in the sense that it
> > is describing what happened and I assume is entirely accurate. But as a
> > human reader, it feels so much more verbose than what I'd expect, as it
> > is full of semi-irrelevant details. Why set --warmup and --runs? Why
> > bother with --command-name, which just means you have to show the
> > commands separately anyway? Is the amount of RAM in the machine
> > important for this test? Surely it could be if it was absurdly tiny, but
> > in general, no, I would not expect it to be.
> 
> I agree. Earlier this week I also drafted a message that was going down
> this angle, but I think I didn't end up sending it to the mailing list.
> Or at least I'm not able to find it anymore.
> 
> To me the biggest problem is not the verbosity, even though it _is_
> overly verbose. The bigger problem though is the incoherence of the
> story that the commit message is trying to tell where it jumps around
> randomly. It almost feels like rambling to me, and that makes it
> extremely hard to follow the narrative and figure out what the message
> even wants to tell the reader in the first place.

Thanks, this hits directly at the point I was trying to make (I have
trouble sometimes with verbosity, too!). A commit message should
primarily be laying out a narrative about why we are going from the old
state to the new, with supporting arguments. Sometimes you need
back-story for that, sometimes not.  Sometimes you need to discuss
alternatives, sometimes you need specific details about the platform or
versions used for testing, and so on.

> I very much think that we should and even have to expect that
> contributors adapt, because if we don't we will basically reinforce
> whatever AI is doing right now and increase the load on reviewers even
> more.
> 
> I also think that we should reserve the right to reject a patch series
> completely in case we notice that we're basically just talking to a
> middleman that sits between an AI prompt and us (please note that I
> don't refer to this patch series specifically, this is more of a general
> statement). My assumption is that this will become more important as AI
> gets established in more workflows. The number of patch series that look
> sane on the surface but that are utter garbage will very likely increase
> quite significantly going forward.

Yep, agreed.

-Peff
