From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>"
 (solves part of problem with system_path)
Date: Tue, 29 Jul 2008 13:18:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291315140.4631@eeepc-johanness>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de> <1217308647-23673-1-git-send-email-prohaska@zib.de> <20080729052459.GC11947@spearce.org> <10AD8BDA-72E8-437D-8CFC-CDD71BB016F8@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 13:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNnDL-0001nb-R6
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYG2LQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbYG2LQ7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:16:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:50686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754883AbYG2LQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:16:59 -0400
Received: (qmail invoked by alias); 29 Jul 2008 11:16:57 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp008) with SMTP; 29 Jul 2008 13:16:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Pkchm3IxPlTykuhU9beK9FJzEJCgarCkbUNjcBK
	iWbZ0QJWNluZ7i
X-X-Sender: user@eeepc-johanness
In-Reply-To: <10AD8BDA-72E8-437D-8CFC-CDD71BB016F8@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90615>

Hi,

On Tue, 29 Jul 2008, Steffen Prohaska wrote:

> On Jul 29, 2008, at 7:24 AM, Shawn O. Pearce wrote:
> 
> > Steffen Prohaska <prohaska@zib.de> wrote:
> > > We prefer running the dashless form, so we should use it in MinGW's 
> > > start_command(), too.
> > ...
> > > - We have non-builtins that are implemented in C, e.g. fast-import.c.
> > >   These non-builtins will still compute wrong paths.
> >
> > This feels wrong to me.  fast-import probably won't be adversly 
> > impacted by not being able to read /etc/gitconfig, unless the user has 
> > set something like core.deltaBaseCacheLimit and is doing an 
> > incremental import.  But other non-builtins may be impacted.
> >
> > It feels like we're fixing this in the wrong place.  If the issue is 
> > we don't find our installation directory correctly, we should find our 
> > installation directory correctly, not work around it by calling 
> > builtins through the git wrapper.
> 
> For builtins it is not a work around but a real solution.

No, it is not a real solution.  At least not for the goal you stated: 
getting the correct "toplevel" directory.  It is a workaround, because it 
avoids the builtins being called as proper programs (which they should be 
perfectly capable of, and which scripts still _are allowed to do_).

However, it is a solution.  To a totally other problem, namely "I would 
like to be able _not_ to install the builtins into the exec-path".  Sure, 
you break a few scripts that rely on the builtins being callable in the 
dash-form, but at least the scripts we ship in git.git are safe.

Ciao,
Dscho
