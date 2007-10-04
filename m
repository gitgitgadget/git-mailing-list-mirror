From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] t9400: Add some tests for checkout
Date: Thu, 4 Oct 2007 21:12:17 +0200
Message-ID: <20071004191217.GC31659@planck.djpig.de>
References: <1191521625-2597-1-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0710041921490.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 21:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdW7h-0003jy-Pt
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 21:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbXJDTMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 15:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbXJDTMa
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 15:12:30 -0400
Received: from planck.djpig.de ([85.10.192.180]:4236 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344AbXJDTM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 15:12:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C463988231;
	Thu,  4 Oct 2007 21:12:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzRaQqMI61HX; Thu,  4 Oct 2007 21:12:17 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id A21EB88232; Thu,  4 Oct 2007 21:12:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710041921490.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59994>

On Thu, Oct 04, 2007 at 07:24:05PM +0100, Johannes Schindelin wrote:
> On Thu, 4 Oct 2007, Frank Lichtenheld wrote:
> 
> > +# clean up
> > +rm -fr cvswork2
> > +rm -fr "$SERVERDIR"
> > +cd "$WORKDIR" &&
> > +git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
> > +GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
> > +GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
> > +exit 1
> 
> Should this not be in a test_expect_success, too?

Since I do this several times and since it is easier to see what tests
it belongs to if it isn't buried in one of them, I would say "no".

> > -#------------
> > -# CVS UPDATE
> > -#------------
> > +#--------------
> > +# CVS CHECKOUT
> > +#--------------
> > +test_expect_success 'cvs checkout failure (HEAD)' \
> > +  'if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 HEAD >cvs.log 2>&1
> > +   then
> > +     echo unexpected cvs success
> > +     false
> > +   else
> > +     true
> > +   fi &&
> 
> How about "! GIT_CONFIG..." instead of the "if..then..else..fi" ?

I don't really care. IIRC I took the idiom from another testfile.
Several other tests in this file already use it, too. So unless
Junio prefers I change all occourences, I will not.

> > +   cat cvs.log | grep -q "not a branch" &&
> > +   test ! -d cvswork2'
> > +rm -fr cvswork2
> 
> Again, for consistency, I'd include this in the test case.

Again, I don't really care. But for consistency with the rest of the
file I will only change it if I'm asked to change all occourences.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
