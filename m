Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F623A5446
	for <git@vger.kernel.org>; Mon, 11 May 2026 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531709; cv=none; b=qMMR7QBWD/S8S9Nf0uWv5PD+Gbp2Zvxlw8/P9/x5VfWpRoA9ojW4w1F+uBixPfPPFCe6QycD+bpfljnasHx9oSIFaHSsxh1pPvYtunSFni2cWHBn+3sDiYTQMtVZMbfC0c6h+kIqtP3yTIz06IvRSODaONOeGLm6rMvQKfrR2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531709; c=relaxed/simple;
	bh=4MKsqO0BJC3glwcAswsOM7uwYq0H/qBld+oPWjwyiKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH4KXDSkGjMBQXVb895/UXKAjgAYBgoGnakL8X0/aBaZgEVznmWXOjPVTe9icC/6ITI7LdmuRWAY/b127S+Z1fMhF8oWUAEgzjCve5OUpQ/SVXUatzmw32iiy2puzDyRX9RlZIGQWXyzGhrz1X8pgXp4WnpIay7bp2SA0KbxZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Rf89ae5O; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Rf89ae5O"
Received: (qmail 19496 invoked by uid 106); 11 May 2026 20:35:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4MKsqO0BJC3glwcAswsOM7uwYq0H/qBld+oPWjwyiKU=; b=Rf89ae5OcnHafzAGD2T4HXHDL+E92ndYkMEabQeNWGq/qa67M2Cr915nV9PjBgCc4NZTLcbw5azcl7lRZ4XhsC1eliNQj+u0MJTNr7aK9KsUL52LUhb11MexPOpU3VWZVHNVRioDg2xGN3959oM6hbJFqeALHKnenMMjqxfpudjpjQ9LbGt0LQfJHVP+M0EGc0FdMYXvfWqR6sU0HnJ8Dk+C6ehkhRJnrS+EgwFFOfVX05oaBjdYxeG9OXexb4eCSVClu5J6E+YSGyVhWN3R1VdPnFX3MbTSsK4G/IX1RpuIiVPGQo2nFjMAs00c7xBnwFQbFlXtjA4dDCs3DwkICQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 May 2026 20:35:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34746 invoked by uid 111); 11 May 2026 20:35:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2026 16:35:02 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 11 May 2026 16:35:02 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	jean-christophe manciot <actionmystique@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260511203502.GA25510@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <20260511200112.GA22912@coredump.intra.peff.net>
 <590781db-7c19-4aa8-8497-e16e5eb5eba1@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <590781db-7c19-4aa8-8497-e16e5eb5eba1@intel.com>

On Mon, May 11, 2026 at 01:21:37PM -0700, Jacob Keller wrote:

> >   - If both claim ownership, it's mostly OK, because they'll both try to
> >     unlink() which is idempotent-ish. Though there is a bad sequence
> >     where we delete somebody _else's_ lock, like:
> > 
> >        1. Parent forks, but has not yet reassigned.
> > 
> >        2. Child calls reassign to take ownership. Now both have
> > 	  ownership.
> > 
> >        3. Signal kills both parent and child, so they enter cleanup
> > 	  code.
> > 
> >        4. One of them (let's say the parent) deletes the lockfile.
> > 
> >        5. Some other unrelated process (let's call it "git other") takes
> > 	  the lock.
> > 
> >        6. The child deletes the lockfile.
> > 
> >     And at that point "git other" thinks it holds the lock, but it
> >     doesn't. It's quite an unlikely sequence in practice, though, I'd
> >     think.
> > 
> >   - If neither claims ownership and a signal kills both, then nobody
> >     cleans up the lock and it is left in place. This is annoying, but
> >     also something that can happen occasionally anyway (kill -9, etc).
> > 
> > I don't have an easy suggestion for making it more atomic, though. You
> > could choose one or the other direction using some synchronization
> > between the two (e.g., child reassigns only after parent signals over a
> > pipe that it has relinquished), but it's all kind of ugly.
> > 
> Ya, that seems really ugly. My first thought was some way to disable
> signals temporarily, but I am guessing that either has no good way to do
> it or would introduce even more issues. Plus there is always kill -9...

I guess the parent could relinquish control by reassigning to "0" before
even calling fork(), and then taking it back if fork() fails. And then
worst case is that nobody cleans up the lock (if the child is killed
before taking control), but that's the least-bad outcome from a
correctness perspective (though still annoying).

-Peff
