Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B83EC2D2
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760082; cv=none; b=G24PVv7TCIAu6bOROLOdGwtxjRF57vlMUUW5d9wf9xLRaYVRQXYRvPuSxn5H74AEBGhLdDMDhWfqtMy/Tf9tart8xGgTGh15579FP1KIblZ3xyQg2Yve1Rz2ytCIE8EAD0EYOAjGJKdJ8SaGLg7znym1Zi0o120ykOSURtjCjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760082; c=relaxed/simple;
	bh=Kc1Jx+xQL9UgJLK7qB+VXeb1eJfx9rwsJICDNpna1iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtgPIK6NaM5H1F4MLi7zAww1DF1pWUupfhdaKcRBu3NR2rBgl03EZ9UD13T2vJjQ+YPw6fw64TRWOhnidHQR+L+msj7f7l5fx0448IJvHGKzcvhq1zkIB6HqB32Q5D9lPJTt/zheAxYvADtVJPbypkMIJ6YgH+K7BhgdOeoktv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gE1gA/1T; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gE1gA/1T"
Received: (qmail 30799 invoked by uid 106); 17 Mar 2026 15:08:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Kc1Jx+xQL9UgJLK7qB+VXeb1eJfx9rwsJICDNpna1iY=; b=gE1gA/1TikhEYEFljaqaWl5Mjwkdmvr0hdgGjCttjmsr4hfHBl3zxVXiqN9FcNvEDhcb2+KwONuael1IBDzn5JZnY39/ToDUCYnZ6liY5rSzUtHceTsUIrO96m+T/feMRz3SdYl1/B8J3/iLxWUNj9wZKT97lUY4gJuoO/DB1Jd3gq2m6zCdILniSHKvKbir3h/j12EBZu4IK4eaEKKsSJUT4ug1cZAQbf7edVgpSyxV+XfZRpcl/q5bNHAvuwvqOEFxRsc5x7vU15P8Obqg+wAoDXJhBD/jfsn0lCgR1sL5XltvLG2hvdWHu/OjtJdiJ+3Z7EUjUoMpyDj3e5S5SA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Mar 2026 15:08:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46770 invoked by uid 111); 17 Mar 2026 15:07:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 11:07:59 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 11:07:59 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
Message-ID: <20260317150759.GA9975@coredump.intra.peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <xmqqcy13mgdk.fsf@gitster.g>
 <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
 <20260317145543.GA1828@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317145543.GA1828@coredump.intra.peff.net>

On Tue, Mar 17, 2026 at 10:55:43AM -0400, Jeff King wrote:

> I agree with the general idea that "-h" usually should exit 0. But this
> is not just a bug fix for --parseopt, but a change in overall intent. It
> might be worth digging in the commit history or list archive to see if
> there's any discussion on why we are using 129 in the first place.

I dug around a little but couldn't find anything conclusive. The first
"129" goes back to 2007:

  https://lore.kernel.org/git/20071013221450.GC2875@steel.home/

But there (and most spots where it is added) it is being used to show
options when we have an unknown option. So I _think_ what mostly
happened is that we show options in two different scenarios: on an
error, and when somebody asks for "-h". And we never differentiated the
two, and the latter just inherited the exit code for the former.

For example, when you look at ff43ec3e2d (parse-opt: create
parse_options_step., 2008-06-23), it introduces:

+       switch (parse_options_step(&ctx, options, usagestr)) {
+       case PARSE_OPT_HELP:
+               exit(129);

and only later did we add PARSE_OPT_ERROR to that switch statement. And
back then, PARSE_OPT_HELP came only from running usage_with_options().

But I couldn't find any discussion or intentional use of 129 for "-h"
output. I do suspect that there may still be some untangling to do. In
the earlier (again, untested) patch I showed, I put an exit(0) for that
PARSE_OPT_HELP case. But it may be that there's more surgery needed to
differentiate "we showed help because of -h" versus "we showed help
because you gave a bogus option".

-Peff
