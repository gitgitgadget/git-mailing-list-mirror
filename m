From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Fri, 23 May 2008 12:21:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805231221390.30431@racer>
References: <482BE5F7.2050108@thorn.ws> <alpine.DEB.1.00.0805161139530.30431@racer> <alpine.DEB.1.00.0805161148010.30431@racer> <alpine.DEB.1.00.0805161403130.30431@racer> <7v8wy34jj3.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805221136230.30431@racer>
 <7v8wy2w7wg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 13:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzVM4-0000vv-SI
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 13:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbYEWLVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 07:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbYEWLVp
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 07:21:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:41881 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754674AbYEWLVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 07:21:43 -0400
Received: (qmail invoked by alias); 23 May 2008 11:21:40 -0000
Received: from R0685.r.pppool.de (EHLO racer.local) [89.54.6.133]
  by mail.gmx.net (mp042) with SMTP; 23 May 2008 13:21:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NVZ8kc2pNQQjpTq/BgBcQ8VhSxGCz02DQnLpy+A
	vYZnAna9Mlaq3o
X-X-Sender: gene099@racer
In-Reply-To: <7v8wy2w7wg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82693>

Hi,

On Thu, 22 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Looking at what handle_body() does for TE_BASE64 and TE_QP cases, I have 
> >> to wonder if this is enough.  The loop seems to stop at (*op == NUL) 
> >> which follows an old assumption that each line is terminated with NUL, 
> >> not the new assumption you introduced that each line's length is kept in 
> >> local variable len.
> >
> > Of course!  But does BASE64 and QP contain NULs?
> 
> The loop in question iterates over bytes _after_ decoding these encoded
> lines, and a typical reason you would encode the payload is because it
> contains something not safe over e-mail transfer, e.g. NUL.
> 
> I think decode_transfer_encoding() also needs to become safe against NULs
> in the payload.

Okay, I missed that.

Ciao,
Dscho
