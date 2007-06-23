From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: help with cvsimport
Date: Sat, 23 Jun 2007 12:27:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706231213020.4059@racer.site>
References: <1182589892.5937.10.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 23 13:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I23mF-0007gx-T5
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 13:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbXFWL1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 07:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbXFWL1e
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 07:27:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:34940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754111AbXFWL1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 07:27:33 -0400
Received: (qmail invoked by alias); 23 Jun 2007 11:27:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 23 Jun 2007 13:27:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q4oFWHm6qkkgVgM76ALT888C1uToO9X9TufgPzm
	JAefLGFvbGSmLM
X-X-Sender: gene099@racer.site
In-Reply-To: <1182589892.5937.10.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50731>

Hi,

On Sat, 23 Jun 2007, Raimund Bauer wrote:

> I unfortunately have to work with several cvs-repositories and was
> wondering if there was a way to have the files processed on import:
> - strip trailing whitespace
> - convert to newline-only line endings

If you want to use cvsimport incrementally, I'd rather not process the 
"origin" branch like this, but rather use git-filter-branch (with a simple 
index filter) to do that.

Even if you do not want to use it incrementally, it seems easier and 
cleaner (if somewhat slower) to me.

So, something like

	git filter-branch --index-filter 'git ls-files |
		while read name; do
			perl -pi -e "s/[ \009\015]*$//" "$name"
		done
		git add -u' cleaned-up-origin

should do.

Hth,
Dscho
