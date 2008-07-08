From: Jeff King <peff@peff.net>
Subject: Re: Test breakage [Re: [ANNOUNCE] GIT 1.5.6.2]
Date: Tue, 8 Jul 2008 01:16:22 -0400
Message-ID: <20080708051622.GC2037@sigill.intra.peff.net>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org> <g4t342$9m8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Jul 08 07:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5Zz-0006ag-7x
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbYGHFQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYGHFQd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:16:33 -0400
Received: from peff.net ([208.65.91.99]:2315 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYGHFQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:16:33 -0400
Received: (qmail 28435 invoked by uid 111); 8 Jul 2008 05:16:31 -0000
Received: from c-75-75-1-159.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.1.159)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jul 2008 01:16:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jul 2008 01:16:22 -0400
Content-Disposition: inline
In-Reply-To: <g4t342$9m8$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87714>

On Mon, Jul 07, 2008 at 02:44:49PM +0200, Michael J Gruber wrote:

> On Kubuntu 7.10 (not my choice, this is at work...), "make test" gives:
>
> *** t9600-cvsimport.sh ***
> [...]
> * FAIL 6: update git module
>                 cd module-git &&
>                 git cvsimport -a -z 0 module &&
>                 git merge origin &&
>                 cd .. &&
>                 test_cmp module-cvs/o_fortuna module-git/o_fortuna
>
> On the second (and subsequent) run, "make test" succeeds. I tried again  
> with a fresh copy from the tarball, same effect: failure on 1, success on 
> 2 and following.

I tried reproducing on my Debian box with various weaks of $LANG, but I
couldn't. Can you please try running "./t9600-cvsimport.sh -v -i" and
send us the output of a failing instance. It's not clear which step in
failing test is causing the problem, or if cvsps is giving off any
useful errors.

> This is with LANG=de_DE.UTF-8, whereas with LANG=C the tests succeed the  
> first time already. Are tests supposed to be done in C locale only? Do  
> they reuse data from a previous test run? I didn't notice this with 
> 1.5.6.1.

They should be perfectly repeatable, but I have run into problems in the
past with cruft in my ~/.cvsps directory. However, we should be setting
$HOME properly in t9600 to avoid this, so I'm not sure what the culprit
is.

-Peff
