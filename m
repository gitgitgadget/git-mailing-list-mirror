From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Fri, 10 Aug 2007 11:14:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org>
References: <20070810154108.GA779@ruiner>
 <20070810173242.GA23628@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Hetro <whee@smaertness.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJZ0V-00017m-Ka
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 20:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXHJSOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 14:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXHJSOi
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 14:14:38 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51178 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626AbXHJSOh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 14:14:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AIEJsZ031159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 11:14:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AIEDMW001869;
	Fri, 10 Aug 2007 11:14:14 -0700
In-Reply-To: <20070810173242.GA23628@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.21__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55560>



On Fri, 10 Aug 2007, Jeff King wrote:
> 
> So maybe the right attitude is "hg2git should not be generating such
> broken commits"

I think this is true.

> (or "gitk should not barf on such broken commits" :) ),

And I think this is *also* true.

> but I thought I would mention it as an additional data point for those
> changes. Should git handle duplicate parents of this fashion more
> robustly? Or should we just assume that they should never have been
> generated in the first place?

I think git itself is quite robust in the face of duplicate parents, and 
it really is a gitk bug that it has problems with them. That said, I don't 
think we should *assume* they don't happen, and while we should consider 
it a bug in hg2git that they did, it is not a "serious" bug per se. It's 
only gitk that reacts this violently to it.

I guess we could prune duplicate parents even for commits that didn't get 
rewritten, but I don't see why we really should even have to. I think Paul 
already said that he should look into it:

			    "I see from the following messages that the
    bug turned out to be elsewhere in git, but it looks like gitk should 
    be more robust and do something sensible rather than just throwing a 
    Tcl error.  I'll look at it."

so I think we should fix gitk regardless, and then *maybe* also consider 
doing parent simplification universally.

			Linus
