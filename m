From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 16:14:15 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807281610270.8986@racer>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann> <alpine.DEB.1.00.0807281605330.8986@racer>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-237692477-1217258056=:8986"
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 17:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNURa-0000k2-6y
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 17:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYG1POT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 11:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbYG1POT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 11:14:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:45477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752722AbYG1POR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 11:14:17 -0400
Received: (qmail invoked by alias); 28 Jul 2008 15:14:16 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp016) with SMTP; 28 Jul 2008 17:14:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q9rYwxwSqot/14J9swkNrn0iPay32oEDyMXQEb3
	2Q6IOy4j/lg83R
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807281605330.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90466>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-237692477-1217258056=:8986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Jul 2008, Johannes Schindelin wrote:

> On Mon, 28 Jul 2008, SZEDER Gábor wrote:
> 
> > there is a race somewhere in these 'git-mv: Keep moved index entries
> > inact' changes.
> > 
> > The test cases 'git mv should overwrite symlink to a file' or 'git mv
> > should overwrite file with a symlink' fail occasionaly.  It's quite
> > non-deterministic:  I have run t7001-mv.sh in a loop (see below) and
> > one or the other usually fails around 50 runs (but sometimes only
> > after 150).  Adding some tracing echos to the tests shows that both
> > tests fail when running 'git diff-files' at the end.
> 
> To make it more convenient to test: with this patch it fails all the time:

Ooops.  Seems like I changed the test 23 to fail, instead of test 24.  
However, I think it is the same bug: the index is newer by one second, so 
it seems that the patch for builtin-mv.c did not really keep the data 
"intact".

Note that a test case should use test-chmtime to force this scenario, not 
sleep a second.

Unfortunately, I already spent my Git time budget for today, so the ball 
is out of my half for now.

Ciao,
Dscho

--8323329-237692477-1217258056=:8986--
