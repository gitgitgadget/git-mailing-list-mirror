X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 04:47:19 -0500
Message-ID: <20061219094719.GA25952@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org> <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 09:48:01 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34806>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwbZS-0000XF-PU for gcvg-git@gmane.org; Tue, 19 Dec
 2006 10:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932735AbWLSJrX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 04:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWLSJrX
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 04:47:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:50950
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S932739AbWLSJrW (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 04:47:22 -0500
Received: (qmail 10808 invoked from network); 19 Dec 2006 04:47:20 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 19 Dec 2006 04:47:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Dec
 2006 04:47:19 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, Dec 19, 2006 at 01:10:59AM -0800, Junio C Hamano wrote:

> > in a very unscientific test, without your patch local cloning of the 
> > LilyPond repo takes 1m33s (user), and with your patch (pread() instead of 
> > mmap()) it takes 1m13s (user). The real times are somewhat bogus, but 
> > still in favour of pread(), but only by 8 seconds instead of 20.
> >
> > This is on Linux 2.4.32.
> 
> Interesting.  Anybody have numbers from 2.6?

Similar results to those posted by Marco Roeland (numbers below are
index-pack of linux-2.6 on 2.6.18 i386 smp):

mmap
46.78user 4.18system 0:51.08elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+725627minor)pagefaults 0swaps

pread
45.70user 3.12system 0:48.96elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+363794minor)pagefaults 0swaps

