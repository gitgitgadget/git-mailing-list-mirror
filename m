Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4978340DAD
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636823; cv=none; b=XUygUwF0ngntZoLJCXXwJKpIGm4XKRWb/KCFwxTfyl0w/NTGwK1HEiKeKy63Sq3J1z+xvlHe1VW5vRXplgKItrHjtQkOBbAq0ilpQXFquXOA043sGNBiVokCrzAZ1AYp3iXbYPzIYdQAKzgBbwjOsfxWTwh7dfZMd3oXBf243NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636823; c=relaxed/simple;
	bh=B4wmsJwADnfsDG9P1Yb85XVE0KJUUvdqecDstdplIe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfcZ1z8wFGZ0Gv7meB7uHisNMliR1PTM8C189BWeA7E50s2M2R7HWLr751icah8YrJkbVx33MxA2qIBg9F6zjTagJEXwNjspXoqb1MJ/B/CvYmv7FzkW+CuO3Hh6EJ9XgCrD0Ez6IUCSLpXTTdvHilUlLF+4OnkP+v2iIVgupiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DcB3265r; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DcB3265r"
Received: (qmail 31695 invoked by uid 109); 19 Aug 2025 20:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B4wmsJwADnfsDG9P1Yb85XVE0KJUUvdqecDstdplIe0=; b=DcB3265rUBmsMa21qmKcPV5xegHVV+qBJJ1EO3YNBrP5xH8iH4/EoZInON3liZWMS96fAgRQzA3rqjrqA8/yIJc60WDPgjRide+8toMiGN1SG895naUzOUGQErqK8KgLBguXrmWW8SPSApk/ctAEzorQKx2q2fNpuBEUHOlTdkXQxBdAO4fsvoYmbDrZfWeYZtqaOXIU/8mTTkmd5Liqp5ceHRJV7x6AaEL+2OuIr8Hjb7dZhkLmxBXKzW3VJco7NEuc/bYdbTv8AOCAuSYhe00PebeQESOFoq6fxTL1VFGo3tNJ5svH52r2mc7j4YIc4+EJcq+xfddVQXvXxyBXGw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 20:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47628 invoked by uid 111); 19 Aug 2025 20:53:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 16:53:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 16:53:38 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] t5510: make confusing config cleanup more explicit
Message-ID: <20250819205338.GA1071667@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192455.GA1059295@coredump.intra.peff.net>
 <8797c495-8277-4f65-845b-167542b82949@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8797c495-8277-4f65-845b-167542b82949@charter.net>

On Tue, Aug 19, 2025 at 04:03:23PM -0400, Eric Sunshine wrote:

> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > @@ -119,7 +119,7 @@ test_expect_success "fetch test remote HEAD change" '
> > -	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
> > +	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
> 
> For what it's worth, I have an unsent patch from a much larger unsent series
> which cleans up the t5510 messiness differently. (The below patch is
> probably whitespace damaged by the MUA.)

See my patch 2, which does this part. I split this out because it got
complicated to explain why that patch wasn't breaking these lines. ;)

-Peff
