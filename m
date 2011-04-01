From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH 2/2] repack: Remove stale .keep files before repacking
Date: Fri, 01 Apr 2011 10:12:33 +0200
Message-ID: <201104011012.33926.johan@herland.net>
References: <201103311246.25645.johan@herland.net>
 <201104010334.28048.johan@herland.net>
 <20110401014150.GC21036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 10:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5ZTW-0001g7-Oh
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 10:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab1DAIMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 04:12:39 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52530 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab1DAIMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 04:12:37 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIY00FPLS4YIC90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 01 Apr 2011 10:12:34 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 878A11EA5914_D9588F2B	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 08:12:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6D6CF1EA2CC3_D9588F2F	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 08:12:34 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIY004CVS4YQT10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 01 Apr 2011 10:12:34 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110401014150.GC21036@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170559>

On Friday 01 April 2011, Jeff King wrote:
> On Fri, Apr 01, 2011 at 03:34:27AM +0200, Johan Herland wrote:
> > On Thursday 31 March 2011, Jeff King wrote:
> > > On Thu, Mar 31, 2011 at 12:46:25PM +0200, Johan Herland wrote:
> > > > 3. Do I need to scan for and remove stale .keep files in a cron job
> > > >    in order to keep repos healthy and clonable?
> > > 
> > > If we fix (1), then hopefully it is not as much of an issue. But
> > > probably "git gc" should clean up stale ones after a while.
> > 
> > This patch tries to automatically remove stale .keep files. However,
> > it's still work-in-progress, as I don't know how to portably (a) ask
> > for the current hostname (so that I can compare it to the one in the
> > .keep file), or (b) test for whether a given PID is running on the
> > system (to determine whether the receive-pack process that wrote the
> > .keep file is still alive).
> > 
> > Feedback appreciated.
> 
> Since your 1/2 turns them from an actual problem into just harmless
> cruft, there's no real rush to get rid of them. Could we just do
> something like "there is no matching pack file, and the mtime is 2 weeks
> old"?

True, except that in the case I encountered (and reported) yesterday, I 
believe there _was_ a matching .pack file...

> If there is a matching pack file, I don't think we want to get rid of
> them.

AFAICS, in this case we do.

> People can have .keep files if they want to indicate the pack
> should be kept. I do admit it would be weird to write the "receive-pack"
> message into them, though.

Yeah, I don't think we have to worry about that, and even if we do, we are 
free to change the "receive-pack ..." string into something far less likely 
to generate a false positive.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
