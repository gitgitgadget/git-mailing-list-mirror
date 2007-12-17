From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 10:39:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171038130.9446@racer.site>
References: <20071215155150.GA24810@coredump.intra.peff.net>
 <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net>
 <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org>
 <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net>
 <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net>
 <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net>
 <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4DOm-00073H-LV
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 11:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763913AbXLQKkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 05:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763994AbXLQKkN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 05:40:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:44356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763025AbXLQKkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 05:40:11 -0500
Received: (qmail invoked by alias); 17 Dec 2007 10:40:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 17 Dec 2007 11:40:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199BcIU8YB9VQ79Mq5CmayCLmKKzz7ipbV+yWRX73
	Q3sGIaz7AwoVNk
X-X-Sender: gene099@racer.site
In-Reply-To: <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68533>

Hi,

On Mon, 17 Dec 2007, Wincent Colaiuta wrote:

> El 16/12/2007, a las 23:29, Jeff King escribi?:
> 
> > On Sun, Dec 16, 2007 at 02:23:27PM -0800, Junio C Hamano wrote:
> > 
> > > > Aren't we using "git diff" for the second diff there nowadays?
> > > 
> > > Some people seem to think that is a good idea, but I generally do 
> > > not like using "git diff" between expect and actual (both untracked) 
> > > inside tests.  The last "diff" is about validating what git does and 
> > > using "git diff" there would make the test meaningless when "git 
> > > diff" itself is broken.
> > 
> > I think that is a valid concern. But ISTR that were some issues with 
> > using GNU diff. Commit 5bd74506 mentions getting rid of the dependency 
> > in all existing tests, but gives no reason.
> 
> I'd say it's safe and sensible to use "git diff" in all tests *except* 
> for tests of "git diff" itself.

To the contrary.  It has to test "git diff", so it must use "git diff".  
As for the reference output: we include the expected diffs as texts, and 
therefore do not really have to rely on having GNU diff installed.

Besides, we cannot even test the goodies like "rename from" by comparing 
to GNU diff's output.

Ciao,
Dscho
