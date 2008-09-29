From: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH] explicitly set LANG to 'C' in for guilt run-tests
Date: Mon, 29 Sep 2008 16:49:58 -0400
Message-ID: <20080929204958.GD31590@josefsipek.net>
References: <1222714272-9557-1-git-send-email-smoser@brickies.net> <237967ef0809291325p7a0e3581vac348a1e99dbd4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Moser <smoser@brickies.net>, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 23:00:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkPqD-0004kb-Ng
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 22:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYI2U62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYI2U62
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 16:58:28 -0400
Received: from josefsipek.net ([141.211.133.196]:36951 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYI2U61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 16:58:27 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Sep 2008 16:58:27 EDT
Received: by josefsipek.net (Postfix, from userid 1000)
	id 6BB841C00DA4; Mon, 29 Sep 2008 16:49:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <237967ef0809291325p7a0e3581vac348a1e99dbd4ed@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97053>

On Mon, Sep 29, 2008 at 10:25:48PM +0200, Mikael Magnusson wrote:
> 2008/9/29 Scott Moser <smoser@brickies.net>:
> > The output of guilt's run-tests is dependent on LANG due to reliance on a
> > given sorting algorithm. Currently, the test '052' will fail if LANG is
> > set to 'en_US.UTF-8' (and likely others values).
> >
> > Remove the assumption by explicitly setting this in run-tests.
> >
> > Signed-off-by: Scott Moser <smoser@brickies.net>
> > ---
> >  regression/run-tests |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/regression/run-tests b/regression/run-tests
> > index 8f572eb..945150b 100755
> > --- a/regression/run-tests
> > +++ b/regression/run-tests
> > @@ -2,6 +2,7 @@
> >
> >  export REG_DIR="$PWD"
> >  export PATH="$PWD/bin:$PATH"
> > +export LANG=C
> >
> >  source scaffold
> >
> > --
> > 1.5.6.3
> 
> If I'm not mistaken, $LANG is used as the ultimate fallback, while LC_ALL is
> the one that overrides all others, so you probably want to set LC_ALL. I'm
> unsure which off the specific ones would apply here, but very likely it's
> LC_COLLATE. In other words, if LC_ALL is set, it is used, otherwise if
> LC_COLLATE is set it is used, otherwise if LANG is set, it is used,
> otherwise, "POSIX" is used.

IIRC, my devel system has all of them set to UTF8, _except_ LC_COLLATE (I
like the case sensitive sort of filenames in ls(1)) which I have set to "C".
So chances are that the minimum required is LC_COLLATE=C, but overriding
everything might be safer overall.

Josef 'Jeff' Sipek.

-- 
Penguin : Linux version 2.6.25.4 on an i386 machine (6135.73 BogoMips).
