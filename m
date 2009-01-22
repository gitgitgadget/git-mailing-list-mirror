From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Thu, 22 Jan 2009 06:02:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901220601500.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer>
 <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <7vr62wb28h.fsf@gitster.siamese.dyndns.org>
 <20090122005901.GA10826@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 06:04:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPrjg-00032J-PM
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 06:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbZAVFCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 00:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbZAVFCp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:02:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:33678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750751AbZAVFCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:02:44 -0500
Received: (qmail invoked by alias); 22 Jan 2009 05:02:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 22 Jan 2009 06:02:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+C6j8q+WuCtkhYWrplqedi/09V7W8j5/yFJZ1kz6
	rXOJfBNHj7xvHu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090122005901.GA10826@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106719>

Hi,

On Wed, 21 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 04:42:22PM -0800, Junio C Hamano wrote:
> 
> > Independent from the above, I suspect that some of the existing tests 
> > cannot run in parallel; I haven't really looked at any of them, but a 
> > server-ish tests to open a local port and test interaction with client 
> > obviously need to either use different ports or serialize.  Perhaps we 
> > need a way to mark some tests that cannot be run in parallel even 
> > under "make -j"?
> 
> I think the only culprits are http-push and a few SVN tests. The 
> http-push test starts a server on a specific port, but because it is the 
> only script which uses that port, it is fine. It looks like a few 
> different SVN tests start an httpd server (9115, 9118, and 9120), which 
> could potentially interact badly. I've never had a problem running with 
> "-j4", but I don't have svn installed, so I always end up skipping those 
> tests.
> 
> It looks like both the http-push and svn tests are set up to take an 
> arbitrary port as input. Perhaps the simplest thing would be for each of 
> the svn tests to pick a different port so that they can be run 
> simultaneously.

I _suspect_ that the svn tests already use different ports (or can work 
with the same httpd), as I have subversion installed and run with -j50 
regularly.

Ciao,
Dscho
