From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to git-archive ignore some files?
Date: Thu, 8 May 2008 21:22:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805082118390.30431@racer>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br> <20080508170442.GK9562@eratosthenes.sbcglobal.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Victor Bogado da Silva Lins <victor@bogado.net>,
	git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Thu May 08 22:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuCe1-00041I-29
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbYEHUWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbYEHUWO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:22:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:43112 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756883AbYEHUWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 16:22:12 -0400
Received: (qmail invoked by alias); 08 May 2008 20:22:10 -0000
Received: from dslb-088-067-216-139.pools.arcor-ip.net (EHLO dslb-088-067-216-139.pools.arcor-ip.net) [88.67.216.139]
  by mail.gmx.net (mp033) with SMTP; 08 May 2008 22:22:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jUW88+Wpj+eut9GiADp8+mY/BXFdlnUiellcPXb
	mcEDYp48HU/1GL
X-X-Sender: gene099@racer
In-Reply-To: <20080508170442.GK9562@eratosthenes.sbcglobal.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81558>

Hi,

On Thu, 8 May 2008, David Bryson wrote:

> On Tue, May 06, 2008 at 03:15:31PM -0300 or thereabouts, Victor Bogado da Silva Lins wrote:
> > I want to use git-archive to create source packages, but my git 
> > repository has a .gitignore that I don't want to be pushed into the 
> > archive. So is it possible to keep the .gitignore file in the 
> > repository and create an archive(*) without it?
> > 
> > *) using git-archive, off course. 
> 
> Others already discussed the --delete method with tar, [...]

I wonder if the most natural way with Git would not be to create a 
throw-away tree:

cp .git/index .git/tmp-index &&
GIT_INDEX_FILE=.git/tmp-index git rm --cached .gitignore &&
git archive $(GIT_INDEX_FILE=.git/tmp-index git write-tree) &&
rm .git/tmp-index

WARNING: this has not seen any testing.

Ciao,
Dscho
