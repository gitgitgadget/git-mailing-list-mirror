From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Sat, 29 Sep 2012 21:42:04 -0400
Message-ID: <20120930014203.GA10664@sigill.intra.peff.net>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
 <20120930000527.GB4852@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Batchelor <scott.batchelor@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 03:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI8Yi-0003W2-84
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 03:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab2I3BmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 21:42:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35446 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074Ab2I3BmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 21:42:09 -0400
Received: (qmail 31689 invoked by uid 107); 30 Sep 2012 01:42:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Sep 2012 21:42:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2012 21:42:04 -0400
Content-Disposition: inline
In-Reply-To: <20120930000527.GB4852@bloggs.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206662>

On Sun, Sep 30, 2012 at 10:05:27AM +1000, Paul Mackerras wrote:

> On Fri, Sep 28, 2012 at 04:50:54PM -0400, Jeff King wrote:
> 
> > +proc refresh_index {} {
> > +    global need_index_refresh
> > +    if { $need_index_refresh } {
> > +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
> > +	set need_index_refresh false
> > +    }
> > +}
> 
> Unfortunately this will wait for the git update-index command to
> complete, making the GUI unresponsive while it executes, and that can
> take minutes on a large repository (e.g. the linux kernel) on a
> machine with a slow disk and a cold disk cache.  We will need to make
> the git update-index execute asynchronously.

Good point. We're getting out of my very limited tcl cargo-culting
skills now, so I'll let somebody more clueful do that fix.

-Peff
