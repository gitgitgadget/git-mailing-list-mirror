From: Jeff King <peff@peff.net>
Subject: Re: Git clone problem, missing "configure"
Date: Tue, 18 May 2010 16:01:50 -0400
Message-ID: <20100518200150.GB4448@coredump.intra.peff.net>
References: <984297.53304.qm@web30503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anthony Willard <awillard69@yahoo.com>
X-From: git-owner@vger.kernel.org Tue May 18 22:01:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESzG-0007Rg-JV
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 22:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923Ab0ERUBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 16:01:53 -0400
Received: from peff.net ([208.65.91.99]:46001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab0ERUBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 16:01:53 -0400
Received: (qmail 21021 invoked by uid 107); 18 May 2010 20:02:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 May 2010 16:02:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 May 2010 16:01:50 -0400
Content-Disposition: inline
In-Reply-To: <984297.53304.qm@web30503.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147306>

[cc +git@vger]

On Fri, May 14, 2010 at 01:50:16PM -0700, Anthony Willard wrote:

> First off, I apologize if I have err'd in sending this directly to
> you.  Please forward to the responsible party.

Usually such things just go to the list (which is open to
non-subscribers).

> I did a "git clone git://git.kernel.org/pub/scm/git/git.git" to a
> fresh working folder.
> 
> I attempted a "./configure" and it failed -- the file is missing;
> there is a "configure.ac".  I had a different clone from mid March
> that contained the file.

Right. We don't commit the configure script, as it is auto-generated.
You need to either:

  1. Build from a release tarball which contains the "configure" script.

  2. Run "autoconf" to generate the configure script (obviously this
     implies that you have GNU autoconf installed).

  3. Just run "make" without configure. You may need to tweak some
     settings if you don't have some optional libraries installed. See the
     top of Makefile for details.

> I found the entry in the ".gitignore" file, a "git blame .gitignore" yields:
> ...
> c591d5f3 (Jeff King                   2009-10-26 21:10:24 -0400 191) /configure

That does blame to me, but if you "git show c591d5f3" you will see that
I was just tweaking the entries, and the original "configure" line
predates me. Try the "blame parent" option of "git gui blame" or "tig",
and you will see that 5566771 (the original commit adding autoconf
support) is actually responsible. So yes, it has been intentionally
ignored since the beginning.

Hope that helps,
-Peff
