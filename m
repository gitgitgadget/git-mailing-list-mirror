From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 15:14:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901150141570.3586@pacific.mpi-cbg.de> <200901151501.26394.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSzn-0007fy-9Y
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805AbZAOON0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbZAOONZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:13:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:52360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758966AbZAOONY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:13:24 -0500
Received: (qmail invoked by alias); 15 Jan 2009 14:13:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 15 Jan 2009 15:13:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1955L8cyQ95vEM4sEQkWJfw71dBLOn6C+0Gw/IfXS
	Tfqy//tmdolXPC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901151501.26394.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105816>

Hi,

On Thu, 15 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Thu, 15 Jan 2009, Thomas Rast wrote:
> > 
> > > Let git-checkout save the old branch as a symref in LAST_HEAD, and
> > > make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
> > > the shell.
> > 
> > Actually, what you want is in the reflog, no?  So... parsing 
> > .git/logs/HEAD for the latest occurrence of "checkout: moving from " and 
> > then using everything up until the next space should give you the branch 
> > name, right?
> 
> It just feels wrong to grab that information from there; it's a
> free-form comment field for user consumption.  And it wasn't even that
> hard to implement a LAST_HEAD.

There are a number of issues why I would like to avoid introducing 
LAST_HEAD:

- it does not work when you are using different Git versions on the same 
  repository,

- it does not work when you switched recently,

- you are storing redundant information,

- yes, the field is meant for user consumption, but no, it is not 
  free-form,

- AFAICT your version could never be convinced to resurrect deleted 
  branches, without resorting to reflogs anyway.

- the reflog method reflects pretty much exactly how people work around 
  the lack of "checkout -" currently, so why not just use the same proven 
  approach?

Ciao,
Dscho
