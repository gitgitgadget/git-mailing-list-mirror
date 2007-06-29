From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 03:05:08 +0200
Message-ID: <20070629010507.GL12721@planck.djpig.de>
References: <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org> <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org> <20070628190406.GC29279@thunk.org> <20070628213451.GB22455@coredump.intra.peff.net> <20070628235319.GD29279@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 29 03:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I44vL-0001oI-P9
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 03:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763876AbXF2BFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 21:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764415AbXF2BFV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 21:05:21 -0400
Received: from planck.djpig.de ([85.10.192.180]:2560 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764074AbXF2BFU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 21:05:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id AA99488102;
	Fri, 29 Jun 2007 03:05:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87kxIu0ARzgv; Fri, 29 Jun 2007 03:05:08 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id BD3BC88105; Fri, 29 Jun 2007 03:05:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070628235319.GD29279@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51142>

On Thu, Jun 28, 2007 at 07:53:19PM -0400, Theodore Tso wrote:
> Good point.  Here's a revised patch where GIT_FLUSH=0 and GIT_FLASH=1
> trumps any hueristics.

[...]

> +			else if (getenv("GIT_NEVER_FLUSH_STDOUT") ||
> +				 ((fstat(fileno(stdout), &st) == 0) &&
> +				  S_ISREG(st.st_mode)))
> +				stdout_is_file = 1;
> +			else
> +				stdout_is_file = 0;
> +		}

Any particular reason why you still check for GIT_NEVER_FLUSH_STDOUT in
addition to GIT_FLUSH?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
