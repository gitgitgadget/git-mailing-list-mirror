From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Fri, 11 Jan 2008 12:39:40 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801111237540.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <874pdmhxha.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101204120.31053@racer.site>
 <87myrdhnn5.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101234580.31053@racer.site>
 <87hchlhm3k.fsf@rho.meyering.net> <7vejco4xv5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:40:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDIFE-0001dh-8n
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 12:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657AbYAKLjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 06:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbYAKLjp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 06:39:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:34383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757657AbYAKLjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 06:39:42 -0500
Received: (qmail invoked by alias); 11 Jan 2008 11:39:40 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp036) with SMTP; 11 Jan 2008 12:39:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GCjEpi6gGWufLTZU8zZpbyeCdm1nq5ZqCw5oUnJ
	NcU463jnLdVEDu
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejco4xv5.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70148>

Hi,

On Thu, 10 Jan 2008, Junio C Hamano wrote:

> In this case, a failure while closing that small .keep file is highly 
> unlikely, and if we ever mange to trigger such a highly unlikely 
> failure, I think we would rather want to *know* about it, as it is 
> likely there is something more seriously wrong going on.
> 
> So let's keep that check on close().

My comment was not about that _check_, but about having this die() instead 
of just printing out a warning.

If that close fails, strange things are going on, alright.  But neither 
the open() nor the write() failed at that point, so IMO it would be a 
mistake to error out _here_.  If later stages fail also, well, we can 
die() there, no?

Ciao,
Dscho
