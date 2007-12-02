From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 21:34:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712022132060.27959@racer.site>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
 <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IywTZ-0003yR-JF
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXLBVfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbXLBVe7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:34:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:49183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbXLBVe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 16:34:58 -0500
Received: (qmail invoked by alias); 02 Dec 2007 21:34:56 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp050) with SMTP; 02 Dec 2007 22:34:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/54Mwa31D5NHA3Ajdk5sG90WtFQ+Uh01GJvEirAl
	deoTbOo/a+Je0Q
X-X-Sender: gene099@racer.site
In-Reply-To: <20071202193918.GQ6212@lavos.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66820>

Hi,

On Sun, 2 Dec 2007, Brian Downing wrote:

> On Sun, Dec 02, 2007 at 10:53:33AM -0800, Junio C Hamano wrote:
> > Yeah, I was wondering what that commit that records the change older
> > than git or myself come to life ;-)
> > 
> > I did rewrite the commit a few times, and it was some interaction
> > between the built-in commit series, git-rebase -i and git-am, but I do
> > not have the details, sorry.
> 
> It looks like the "guilty" commit that allowed this behavior was:
> 
> commit 13208572fbe8838fd8835548d7502202d1f7b21d
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Sun Nov 11 17:35:58 2007 +0000
> 
>     builtin-commit: fix --signoff
> 
>     The Signed-off-by: line contained a spurious timestamp.  The reason was
>     a call to git_committer_info(1), which automatically added the
>     timestamp.
> 
>     Instead, fmt_ident() was taught to interpret an empty string for the
>     date (as opposed to NULL, which still triggers the default behavior)
>     as "do not bother with the timestamp", and builtin-commit.c uses it.
> 
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> With the above, something like:
> 
> echo msg | GIT_AUTHOR_DATE='' git commit-tree sha1

Darn.  But when can "GIT_AUTHOR_DATE" be set to the empty string?  I mean, 
I understand unset'ing it.  But setting it to ""?

Ciao,
Dscho
