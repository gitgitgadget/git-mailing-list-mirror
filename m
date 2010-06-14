From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] Git.pm: better error message
Date: Mon, 14 Jun 2010 11:19:16 +0200
Message-ID: <20100614091916.GB31387@swoosh>
References: <1276477222-21465-1-git-send-email-book@cpan.org>
 <20100614071046.GA5639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 14 11:19:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO5pE-0001zD-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 11:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749Ab0FNJTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 05:19:19 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:55873 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab0FNJTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 05:19:18 -0400
Received: from localhost ([127.0.0.1] helo=swoosh)
	by ks354402.kimsufi.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1OO5p7-0000mQ-1U; Mon, 14 Jun 2010 11:19:17 +0200
Received: from book by swoosh with local (Exim 4.71)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1OO5p6-0005QF-PG; Mon, 14 Jun 2010 11:19:16 +0200
Content-Disposition: inline
In-Reply-To: <20100614071046.GA5639@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149087>

On Mon, Jun 14, 2010 at 03:10:46AM -0400, Jeff King wrote:
> On Mon, Jun 14, 2010 at 03:00:22AM +0200, Philippe Bruhat (BooK) wrote:
> 
> > -d doesn't set $! if the directory doesn't exist
> 
> Really?
> 
>   $ perl -e '-d "bogus" or die "fail: $!"'
>   fail: No such file or directory at -e line 1.
> 
> On the other hand:
> 
>   $ touch file
>   perl -e '-d "file" or die "fail: $!"'
>   fail:  at -e line 1.
> 
> So perhaps it is best not to rely on $!. Also, this is with perl 5.10.
> Is it different with other versions?

Come to think of it, it probably makes sense: -d probably depends on stat
to get the information about the file, and that fails harder when the
file in question doesn't exists.

I guess the best would be to put the directory name in the error message
(always interesting information), and keep $! in case it was set by an
harder error.

-- 
 Philippe Bruhat (BooK)

 There is no solution to a problem of sheer greed.
                                    (Moral from Groo The Wanderer #94 (Epic))
