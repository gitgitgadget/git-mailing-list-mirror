From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 21:11:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004152059100.7232@xanadu.home>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
 <20100415163607.GA4279@coredump.intra.peff.net>
 <7vhbnck618.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1004151545240.7232@xanadu.home>
 <7v7ho8ibi3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 03:13:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2a7c-0004MZ-Ai
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 03:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299Ab0DPBNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 21:13:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48125 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259Ab0DPBNG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 21:13:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0Y002IM3AFECN0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Apr 2010 21:11:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7ho8ibi3.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145044>

On Thu, 15 Apr 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > I'm a bit worried about this discussion.
> >
> > What's the point of having a reflog for unreachable stuff if it is to be 
> > pruned faster than stuff that is already reachable without any reflog?
> 
> To keep recently failed experiments alive for some time (30 days), but not
> overly long (90 days)?

What is a "failed" experiment is still subjective.  It might be possible 
to realize that part of it was not that bad after all and some pieces 
could be worth cherry-picking.

Again, keeping reflogs 90 days for stuff that is _already_ reachable 
through existing refs is much less useful than keeping otherwise 
unreachable stuff 90 days.  So I still don't see the point of this 
eagerness to prune deleted stuff faster.

If you explicitly want to get rid of failed experiments then it should 
be done through an explicit prune command.  Otherwise I'd argue that 
reflogs should take care not to lose track of unreachable stuff, even 
more so than stuff already reachable.

Some people even tried to convince me that reflogs should never expire 
by default, and that the 3 month grace period was already too short.


Nicolas
