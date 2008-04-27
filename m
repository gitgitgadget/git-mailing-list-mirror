From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use the modern syntax of git-diff-files in
	t2002-checkout-cache-u.sh
Date: Sun, 27 Apr 2008 19:49:07 +0200
Message-ID: <20080427174907.GB3828@steel.home>
References: <20080427113123.GA3712@steel.home> <7viqy3gqn9.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:50:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqB0g-0002a8-TB
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878AbYD0RtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757754AbYD0RtK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:49:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:14497 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbYD0RtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:49:09 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarHHww/x
Received: from tigra.home (Fad24.f.strato-dslnet.de [195.4.173.36])
	by post.webmailer.de (fruni mo50) (RZmta 16.27)
	with ESMTP id z06d85k3RF8oVA ; Sun, 27 Apr 2008 19:49:07 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B87C0277BD;
	Sun, 27 Apr 2008 19:49:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B637456D28; Sun, 27 Apr 2008 19:49:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqy3gqn9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80473>

Junio C Hamano, Sun, Apr 27, 2008 19:21:30 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > As a nice side effect it also fixes t2002-checkout-cache-u.sh on FreeBSD 4,
> > /bin/sh of which has problems interpreting "! command" construction.
> >
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> >
> > To be honest - it was the other way around: I wanted to fix the test
> > on FreeBSD, but ended up using --exit-code and test_must_fail
> 
> Do you mean /bin/sh there misinterprets "! cmd1 | cmd2" as "(! cmd1) |
> cmd2" and always returns true or something silly like that?  I see a few
> other places in t3400, t3700, t5302, t7002, etc. that use that construct
> without an obvious workaround "! (cmd1 | cmd2)" which t0030 uses.

Yes. That one was just a place I very slowly got to (I have not much
motivation and only one _very remote_ (and production) machine to try
things on).

> >  test_expect_success \
> >  'with -u, git checkout-index picks up stat information from new files.' '
> >  rm -f path0 &&
> >  git read-tree $t &&
> >  git checkout-index -u -f -a &&
> > -git diff-files | diff - /dev/null'
> > +git diff-files --exit-code'
> 
> Is this something FreeBSD 4 has trouble with as well (not a request to
> drop this hunk but asking for info)?

No, this is just the same file and similar construction (use external
diff just to figure out if there are any differences). This is why I
(re)named the patch for "modern syntax". It is named "make t2002 work
on FreeBSD4" in my tree.
