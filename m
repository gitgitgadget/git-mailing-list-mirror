From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Fri, 7 Aug 2009 08:05:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908070801540.8306@pacific.mpi-cbg.de>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com> <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com> <20090806203223.GK1033@spearce.org> <4A7B68C4.8070406@gmail.com> <20090806233739.GL1033@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 08:05:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZIZh-0004NQ-7L
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 08:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbZHGGE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 02:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZHGGE6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 02:04:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:32822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752764AbZHGGE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 02:04:58 -0400
Received: (qmail invoked by alias); 07 Aug 2009 06:04:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 07 Aug 2009 08:04:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/h+DBGPF7hbLGMy8O4AtuJTu4YuAIsrApj90Ggu3
	byH8ZHym6XQj3N
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090806233739.GL1033@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125183>



On Thu, 6 Aug 2009, Shawn O. Pearce wrote:

> A Large Angry SCM <gitzilla@gmail.com> wrote:
> > Shawn O. Pearce wrote:
> >> Nick Edelen <sirnot@gmail.com> wrote:
> >>> Hrmm, I just realized that it dosn't actually cache paths/names...
> >>
> >> You may not need the path name, but instead the hash value that 
> >> pack-objects computes from the path name.
> >
> > Please do NOT expose the hash values. The hash used by pack-objects is 
> > an implementation detail of the heuristics used by the _current_ 
> > object packing code. It would be a real shame to have to maintain 
> > backward compatibility with it at some future date after the packing 
> > machinery has changed.
> 
> This is a local cache.  If there was a version number in the header, and 
> the hash function changes, we could just bump the version number and 
> invalidate all of the caches.
> 
> No sense in storing (and doing IO of) huge duplicate string values for 
> something where we really only need 32 bits, and where a recompute from 
> scratch only costs a minute.

FWIW it was this redundancy in duplicate (unpacked) string redundancy 
I meant, but I did a poor job at expressing myself, and consequently Nick 
did not understand what I want (and I'm on a slow connection, so I deleted 
the mail halfway through looking if there are some real answers hidden in 
the huge quoted part instead of replying).

And the fragility of the dependency to the implementation detail of the 
pack index suggests to me that my intuition that this whole thing should 
be more tightly integrated with the pack index was not totally off the 
mark.

Ciao,
Dscho
