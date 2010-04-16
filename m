From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 23:07:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004152237060.7232@xanadu.home>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
 <20100415163607.GA4279@coredump.intra.peff.net>
 <7vhbnck618.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1004151545240.7232@xanadu.home>
 <7v7ho8ibi3.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1004152059100.7232@xanadu.home>
 <7vljcogot1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 05:08:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2but-000567-Jp
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 05:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab0DPDIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 23:08:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52474 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab0DPDIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 23:08:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0Y00FL48OWWP20@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Apr 2010 23:07:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vljcogot1.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145049>

On Thu, 15 Apr 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Again, keeping reflogs 90 days for stuff that is _already_ reachable 
> > through existing refs is much less useful than keeping otherwise 
> > unreachable stuff 90 days.  So I still don't see the point of this 
> > eagerness to prune deleted stuff faster.
> 
> Hmph, I honestly cannot care about this very much without knowing where
> this is going, because the distinction between the two has been with us
> practically forever, since the day one of "reflog expire".

Argh.  OK you can paint me confused. I was mixing up 
--expire-unreachable with --stale-fix.

Having my head screwed back on now, I do agree with Jeff when he says:

|I think another way of addressing the same problem would be to redefine
|"reachable" in this context as "reachable from any current ref".

Otherwise having a special exception for HEAD would effectively make 
those unreachable objects non prunable until the HEAD reflog entries are 
themselves expired.

> Is there any constructive conclusion you are aiming for?  For example, is
> a proposal to update the default value of both to 90 or 120 days coming?

I think that the default value for reflogexpireunreachable should be the 
value of reflogexpire, and not 30 days.  In my opinion, having a shorter 
expiration period for non reachable objects by default makes little 
sense.  Again, it is for the non reachable objects that the reflog is 
most useful.


Nicolas
