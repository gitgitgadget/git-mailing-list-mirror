From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t5505-remote fails on Windows
Date: Fri, 20 Mar 2009 00:15:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200014370.10279@pacific.mpi-cbg.de>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net> <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de> <7vhc1pai84.fsf@gitster.siamese.dyndns.org>
 <20090319200308.GB17028@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRSS-0001Z4-34
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbZCSXN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbZCSXN6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:13:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:37962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752242AbZCSXN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:13:57 -0400
Received: (qmail invoked by alias); 19 Mar 2009 23:13:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 20 Mar 2009 00:13:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rNzZYuSKrQzNTBEQhNRTnSnXYgpCawqUKbuRJc6
	jSBb122P+yVKms
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090319200308.GB17028@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113857>

Hi,

On Thu, 19 Mar 2009, Jeff King wrote:

> On Thu, Mar 19, 2009 at 04:02:19AM -0700, Junio C Hamano wrote:
> 
> > > Do we really want an API for that?  Calling qsort() directly should be 
> > > obvious enough, no?
> > 
> > I think so.  If it were done like this (notice the lack of double
> > indirection in the cmp_fn signature):
> > 
> >     typedef int string_list_item_cmp_fn(const struct string_list_item *, const struct string_list_item *);
> > 
> >     void sort_string_list_with_fn(struct string_list *list, string_list_item_cmp_fn *);
> > 
> > it would have made more sense, though.
> 
> IIRC, that is actually not valid C according to the standard (that is, 
> even though a void* can be implicitly assigned to any other pointer, a 
> function taking a void* and a function taking another pointer do not 
> necessarily have the same function signature or calling conventions). 
> Which is why cmp_items in string-list.c already does the indirection.

AFAICT the idea was not to pass the function to qsort() directly, but I 
have to agree that I do not see how that should be possible with the 
current interface of qsort();

Ciao,
Dscho
