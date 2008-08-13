From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
 merge_recursive_generic()
Date: Tue, 12 Aug 2008 23:17:27 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808122309460.19665@iabervon.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6sY-0004XW-Vn
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYHMDR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbYHMDR2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:17:28 -0400
Received: from iabervon.org ([66.92.72.58]:39435 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbYHMDR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:17:28 -0400
Received: (qmail 16479 invoked by uid 1000); 13 Aug 2008 03:17:27 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2008 03:17:27 -0000
In-Reply-To: <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92170>

On Tue, 12 Aug 2008, Stephan Beyer wrote:

> merge_recursive_generic() takes, in comparison to to merge_recursive(),
> no commit ("struct commit *") arguments but SHA ids ("unsigned char *"),
> and no commit list of bases but an array of refs ("const char **").
> 
> This makes it more generic in the case that it can also take the SHA
> of a tree to merge trees without commits, for the bases, the head
> and the remote.
> 
> merge_recursive_generic() also handles locking and updating of the
> index, which is a common use case of merge_recursive().
> 
> This patch also rewrites builtin-merge-recursive.c to make use of
> merge_recursive_generic().  By doing this, I stumbled over the
> limitation of 20 bases and I've added a warning if this limitation
> is exceeded.
> 
> This patch qualifies make_virtual_commit() as static again because
> this function is not needed anymore outside merge-recursive.c.

You might look at builtin-checkout and see if merge_working_tree() could 
be made cleaner with this API, or if some other API could accomodate both 
cases more nicely.

(I'm not sure either way, but it would be a good confirmation that the API 
is properly convenient if that additional case could use it.)

	-Daniel
*This .sig left intentionally blank*
