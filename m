From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 23:24:02 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803102319380.4741@racer.site>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site> <7vejaii7c5.fsf@gitster.siamese.dyndns.org> <7vabl6i72j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 23:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYqQA-0003sC-8C
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 23:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYCJWX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 18:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbYCJWX6
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 18:23:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:55604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751752AbYCJWX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 18:23:58 -0400
Received: (qmail invoked by alias); 10 Mar 2008 22:23:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 10 Mar 2008 23:23:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SabMgCy4SwR58YpbKOM6h1J89FJLzStWOOSLr2j
	ecaGyC7Qzggi+S
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabl6i72j.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76763>

Hi,

On Mon, 10 Mar 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > ...
> >> This fixes
> >>
> >> 	git config core.editor "c:/Program Files/What/Ever.exe"
> >>
> >
> > Having sent a few messages about shell quoting, it makes me wonder if this
> > was done very deliberately in the first place, so that you can do things
> > like:
> >
> > 	git config core.editor "emacs -nw"
> >
> > Blame followed by list archive hunting around that timeperiod would tell.
> 
> I'll let others look for the bug report and user request from the list
> archive, but the pertinent commit is 5e2de4f9 (Fix $EDITOR regression
> introduced by rewrite in C.):
> 
>     When git-tag and git-commit launches the editor, they used to
>     honor EDITOR="editor -options args..." but recent rewrite in C
>     insisted on $EDITOR to be the path to the editor executable.
>     
>     This restores the older behaviour.
>     
> In other words, your example is a user error and your patch is a
> regression.

I was well aware of that commit when I wrote the patch, but...

> I guess the right way to do that would be:
> 
> 	git config core.editor '"c:/Program Files/What/Ever.exe"'
> 
> but I do not do windows, so this is obviously untested.

Ooops.  The commit message I gave did not escape the double quotes, but I 
_meant_ to, promise!  So yes, it was my intention that

	git config core.editor \"C:/Program\ Files/vim/vim71/gvim.exe\"

works, but

	git config core.editor "C:/Program Files/vim/vim71/gvim.exe"

does not.  Note that the test was written correctly.

Sorry,
Dscho
