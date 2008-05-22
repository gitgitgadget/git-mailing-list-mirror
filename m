From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Thu, 22 May 2008 11:38:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221136230.30431@racer>
References: <482BE5F7.2050108@thorn.ws> <alpine.DEB.1.00.0805161139530.30431@racer> <alpine.DEB.1.00.0805161148010.30431@racer> <alpine.DEB.1.00.0805161403130.30431@racer> <7v8wy34jj3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 12:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz8Cc-0003vX-9F
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 12:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYEVKi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 06:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYEVKi0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 06:38:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:55462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751988AbYEVKiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 06:38:25 -0400
Received: (qmail invoked by alias); 22 May 2008 10:38:23 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp001) with SMTP; 22 May 2008 12:38:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1957bYSynJ5AQtyg5Y9sFEle0bfEGfgzHlFAywhZi
	7hFAn3ZWtG05Dz
X-X-Sender: gene099@racer
In-Reply-To: <7v8wy34jj3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82611>

Hi,

On Wed, 21 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The function fgets() has a big problem with NUL characters: it reads 
> > them, but nobody will know if the NUL comes from the file stream, or 
> > was appended at the end of the line.
> >
> > So implement a custom read_line() function.
> 
> Looking at what handle_body() does for TE_BASE64 and TE_QP cases, I have 
> to wonder if this is enough.  The loop seems to stop at (*op == NUL) 
> which follows an old assumption that each line is terminated with NUL, 
> not the new assumption you introduced that each line's length is kept in 
> local variable len.

Of course!  But does BASE64 and QP contain NULs?  After all, even my 
custom read_line_with_nul() function adds a NUL IIRC.

Well, the biggest problem here is my lack of time.  I thought I would give 
Tommy a patch which kinda works, and he would actually hold through to 
brush it up until it shines and gets into git.git, because it is not _my_ 
itch.

Hmmmmmmm.

Ciao,
Dscho
