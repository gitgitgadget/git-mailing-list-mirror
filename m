From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
	commits older than a year
Date: Sun, 22 Feb 2009 22:16:31 -0500
Message-ID: <20090223031631.GC22348@coredump.intra.peff.net>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: eletuchy@gmail.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 04:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbRKV-0007eF-Tq
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 04:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbZBWDQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 22:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZBWDQf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 22:16:35 -0500
Received: from peff.net ([208.65.91.99]:46819 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbZBWDQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 22:16:34 -0500
Received: (qmail 19706 invoked by uid 107); 23 Feb 2009 03:16:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Feb 2009 22:16:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Feb 2009 22:16:31 -0500
Content-Disposition: inline
In-Reply-To: <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111075>

On Sun, Feb 22, 2009 at 05:44:37PM -0800, Junio C Hamano wrote:

> > +		/* Otherwise, years. Centuries is probably overkill. */
> > +		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
> > +		return timebuf;
> 
> I agree this is an improvement.  It irritated me, too.  And I do not think
> this change falls into the category of bad backward incompatibility.
> 
> I was hoping somebody would do a "N years M months", though.

I thought about that, but I wanted to keep the maximum size down for
column output (like in git-blame). Which is why I bumped the "use
months" limit to 24 months instead of 12.

And that limit can also be tweaked.  Surely at some point there is a
range where you no longer care about the months and "N years" has high
enough resolution. But there is also a point where "N months" gets
cumbersome (75 months is a more annoying than "around 6 years"). The
question is whether we reach the "cumbersome" point before we reach the
"don't care about months" point.

Another option would to give higher resolution in number of years, like
"3.5 years" or even "3.1 years".

-Peff
