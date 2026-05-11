Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734337FF60
	for <git@vger.kernel.org>; Mon, 11 May 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530981; cv=none; b=J7k9+a4x44hN799YcQSecozcsfOru6bIZvbAY7lP8jWbD2Qa0YBAqR40b5n0+i5OdHUuN/2+Vf0hJtfJggUJoe4cl3URLpMWAhJiLIWxdwut2ukvKhXs0ZKUiLYvoVdLfSYNYGDPH80huaG8YG0EwBuwuhrFJJcGdl21ghl5kwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530981; c=relaxed/simple;
	bh=eBilnxYPbZZZvmXOfQwsQ3hDODflZzu13nNN4tHqnbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt1lz44M5uEzlSuTg16bGc/nS2q4IkfNNKf62IguKDn9AtCtlF2fE8++NAWeoVd+Sb4iQE5BK6MIu+1XNzW5XImQW8tgFL+zH+maGiba9lJPywwT2Uxp89R/2Va8ry5pcd/bGTZlq3sgBfI2A/R0ESXtmrPDisr1Rm35HAY4oA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DrZZeWGq; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DrZZeWGq"
Received: (qmail 19440 invoked by uid 106); 11 May 2026 20:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eBilnxYPbZZZvmXOfQwsQ3hDODflZzu13nNN4tHqnbQ=; b=DrZZeWGq+uUHemFK0IHgHBLUX5uO+uy96MVxxkf0f8oh3E508DNAh1KreQdq2kA1DPJjpAJRCiQ5FwS+VsZJR9e1zaGoKvqXvNMwdyoqBlwZ9P74cW1crTKloFe+qFVRcwIdjSN/AvUlHEv82vGiP68z2hvXRHDww0HCZhOJ4R8QSaTjhQIY6J/tAWTd4EhKAIbnkUEYF6Is2LQSLQdRuBU6l0rNGtCDNwpxS+v2HwPM15SK+B796nds7HEXo0eJxtQqCdaV2yBe6aaJ3fSSgsC7lUDgNWHM3o4IZnekEnMI8PkS5HFHnd4DYpiLQ0Grz0oxYt58zxfd2mbfS5KKCQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 May 2026 20:22:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34447 invoked by uid 111); 11 May 2026 20:22:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2026 16:22:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 11 May 2026 16:22:58 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	jean-christophe manciot <actionmystique@gmail.com>,
	git@vger.kernel.org
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260511202258.GD22912@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>
 <agDjyAXxkOIso8FU@nand.local>
 <agF6Q-z1SuTL1xXs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agF6Q-z1SuTL1xXs@pks.im>

On Mon, May 11, 2026 at 08:42:11AM +0200, Patrick Steinhardt wrote:

> In any case, I also agree with Stolee that it may have unintended
> consequences to unconditionally reassign tempfiles to the child process
> when daemonizing. It is okay for all current callers, but I'm not sure
> whether future callers would expect this behaviour.
> 
> An alternative would be to explicitly reassign the lockfile's ownership
> in git-maintenance(1). Something like the below patch.

I really think this should be an automatic part of daemonize(), for the
reasons I gave earlier in the thread. It's really a lurking problem for
any cleanup handler, but lockfiles are the one that is most likely to
bite us.

In fact, I thought "git gc --detach" without "--skip-foreground-tasks"
had the same bug, but it narrowly avoids it by dropping and reacquiring
the lock (!) on either side of the daemonize() call.

So I think you are more likely to avoid unpleasant surprises by baking
the behavior into daemonize() rather than requiring each caller to do it
manually.

Plus it keeps daemonize() a bit more abstract. It's a noop on Windows,
but you can imagine an implementation that does weird platform-specific
stuff and doesn't switch pids at all.

-Peff
