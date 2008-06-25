From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 16:38:22 -0400
Message-ID: <20080625203822.GA7827@mit.edu>
References: <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu> <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbme-0005rh-Vp
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYFYUjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbYFYUjH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:39:07 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:45650 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbYFYUjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:39:06 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBblB-0002yl-L9; Wed, 25 Jun 2008 16:38:34 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBbl0-0002Az-TP; Wed, 25 Jun 2008 16:38:22 -0400
Content-Disposition: inline
In-Reply-To: <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86342>

On Wed, Jun 25, 2008 at 04:04:47PM -0400, Avery Pennarun wrote:
> How about making "git checkout" default to HEAD if no revision is
> supplied?  There's precedent for this in, say, git-diff (and I think a
> few others).
> 
> Incidentally, "checkout <filename>" was also the way to do a revert
> operation in CVS.  And the way to switch branches, too, iirc.  So git
> isn't being too unusual here.  That said, the commands were
> deliberately renamed in svn because CVS was considered largely insane.

The one thing I would worry about is the potential ambiguity if you do
something like "git checkout FOOBAR", and FOOBAR was both a branch
name as well as a file name.  How should it be interpreted?  I'd argue
the real problem was we conflated two distinct operations: "switching
to a new branch", and "reverting a file" to the same name, checkout.

Hence the suggestion to add a new command, "git revert-file", where
there would be no ambiguity.

							- Ted
