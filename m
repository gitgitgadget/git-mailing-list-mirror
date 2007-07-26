From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] Add test for sanitized work-tree behaviour
Date: Thu, 26 Jul 2007 15:05:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261503530.14781@racer.site>
References: <Pine.LNX.4.64.0707260732130.14781@racer.site>
 <7vfy3b8wkp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE3y8-0001w7-P4
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 16:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266AbXGZOF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 10:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbXGZOF2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 10:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:53882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758266AbXGZOF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 10:05:28 -0400
Received: (qmail invoked by alias); 26 Jul 2007 14:05:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 26 Jul 2007 16:05:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GwcUQvVzGjZVCckHKpgBIxObl2bDEGyvQCz8f7c
	oUOAVcBnrPODhJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy3b8wkp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53833>

Hi,

On Thu, 26 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > ...
> > @@ -3,90 +3,109 @@
> >  test_description='test separate work tree'
> >  . ./test-lib.sh
> >  
> > +i=1
> > +
> >  test_rev_parse() {
> > - ...
> > +	name="$1"
> > +	for option in --is-bare-repository --is-inside-git-dir \
> > +		--is-inside-work-tree --show-prefix
> > +	do
> > +		shift
> > +		test_expect_success "$name: $option" \
> > +			"test '$1' = \"\$(git rev-parse $option)\""
> 
> > +i=$(($i+1))
> > +test $i = $STOPI && gdb --args git rev-parse $option
> 
> Eh?

Yes, got me there.  It was a real PITA to debug that thing, given that the 
tests were written in the spirit of Malbolge.  So the easiest method to 
debug it was for me to "-i -v" the test, run it again with "STOPI=$n .. 
-v", and work out what was the intended behaviour, and whether to fix the 
test or the logic.

Will clean up.

Ciao,
Dscho
