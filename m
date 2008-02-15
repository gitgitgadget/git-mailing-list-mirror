From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an
 accentuated letter in the filename
Date: Fri, 15 Feb 2008 18:12:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802151811240.30505@racer.site>
References: <87bq6iw42w.dlv@maison.homelinux.org> <7vd4qygld8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ549-0007Jk-65
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYBOSNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbYBOSNE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:13:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:35717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753506AbYBOSNB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:13:01 -0500
Received: (qmail invoked by alias); 15 Feb 2008 18:13:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 15 Feb 2008 19:13:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Yf1Ab++RYd9SIP+0RW2v4zS4YeS3X1yXZvX4B10
	SKBQfRqUEm9TPC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4qygld8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73968>

Hi,

On Fri, 15 Feb 2008, Junio C Hamano wrote:

> Remi Vanicat <vanicat@debian.org> writes:
> 
> > The culprit seem to be those line of filter-branch: (around line 279) 
> > 		git diff-index -r $commit | cut -f 2- | tr '\012' '\000' | \
> > 			xargs -0 git update-index --add --replace --remove
> > git diff-index giving the filename as "foo/bar\303\251"
> 
> I have to wonder in what century filter-branch was written ;-)
> 
> Shouldn't those two lines be:
> 
> 	git diff-index -r --name-only $commit |
>         git update-index --add --replace --remove --stdin
> 
> these days, without any of the cut and cruft?

Maybe even using "-z" in both cases?

Having said that, I do not understand why the old code did not work.  Will 
have a look later today.

Ciao,
Dscho
