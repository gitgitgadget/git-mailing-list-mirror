From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git bug: rebase fatal failure
Date: Fri, 16 May 2008 12:01:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161148010.30431@racer>
References: <482BE5F7.2050108@thorn.ws> <alpine.DEB.1.00.0805161139530.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Fri May 16 13:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwxhn-0006op-Ff
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 13:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYEPLBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 07:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYEPLBk
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 07:01:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:53622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750845AbYEPLBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 07:01:39 -0400
Received: (qmail invoked by alias); 16 May 2008 11:01:38 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp030) with SMTP; 16 May 2008 13:01:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xiMkmGQTxlG+SOoxWZQ4MoSeF3rHDON1qWO8FH7
	lUpm2HHn09hSJz
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805161139530.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82273>

Hi,

On Fri, 16 May 2008, Johannes Schindelin wrote:

> It is a .info file, so I suspect strange things going on with 
> non-printable ASCII characters.

And indeed, this is the culprit:

-- snip --
BFD Index
*********

^@^H[index^@^H]
* Menu:

-- snap --

Note the NUL characters?

Now, the thing is: git format-patch still outputs it correctly.  But 
git-rebase pipes the output to git-am, which in turn calls git-mailsplit, 
which suppresses that line.

Will keep you posted,
Dscho
