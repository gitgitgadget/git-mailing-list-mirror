From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Fri, 28 Sep 2012 19:04:10 -0400
Message-ID: <20120928230410.GA9851@sigill.intra.peff.net>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
 <m24nmh4x1t.fsf@igel.home>
 <20120928223152.GA7906@sigill.intra.peff.net>
 <7vipaxkayf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 01:04:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THjbc-000718-RK
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690Ab2I1XEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 19:04:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33987 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758465Ab2I1XEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 19:04:12 -0400
Received: (qmail 23016 invoked by uid 107); 28 Sep 2012 23:04:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Sep 2012 19:04:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2012 19:04:10 -0400
Content-Disposition: inline
In-Reply-To: <7vipaxkayf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206616>

On Fri, Sep 28, 2012 at 04:02:32PM -0700, Junio C Hamano wrote:

> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > +proc refresh_index {} {
> >> > +    global need_index_refresh
> >> > +    if { $need_index_refresh } {
> >> > +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
> >> 
> >> I think the usual idiom for ignoring errors is to use catch around exec,
> >> avoiding the extra shell wrapper:
> >> 
> >>         catch { exec git update-index --refresh }
> >
> > Thanks. I don't speak tcl at all, but your version makes much more
> > sense.
> 
> But isn't the redirection still needed?  Otherwise the "Needs
> update" messages will go to the terminal, no?

I think the weird tcl-catches-stderr thing kicks in (at least it did for
me in a simple experiment). But like I said, I am not an expert.

-Peff
