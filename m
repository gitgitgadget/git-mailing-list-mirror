From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Move the pick_author code to git-sh-setup
Date: Sun, 24 Jun 2007 11:22:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706241118250.4059@racer.site>
References: <Pine.LNX.4.64.0706240000340.4059@racer.site>
 <7v7ipt3lh6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 12:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2PEm-0003bq-QP
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 12:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbXFXKW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 06:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753097AbXFXKW2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 06:22:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:57511 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752523AbXFXKW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 06:22:27 -0400
Received: (qmail invoked by alias); 24 Jun 2007 10:22:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 24 Jun 2007 12:22:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195SEgh9Mt52CZ3ly4hHqOS04eW+1sSnbd1kfpy40
	CCsxhR1sgRO6DH
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ipt3lh6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50787>

Hi,

On Sat, 23 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > -	set_author_env=`git show -s --pretty=raw --encoding="$encoding" "$use_commit" |
> > -	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
> > -	eval "$set_author_env"
> > ...
> > +	eval $(get_author_ident_from_commit "$use_commit")
> 
> Are you sure about this part of the change?

No, I am not.

> I suspect that you are losing IFS by not dq'ing the argument you give to 
> the eval.

That is well possible. Quoting in shell is such a hassle, and I never seem 
to get it right.

Therefore I did a minimal test, namely committing with another 
GIT_AUTHOR_NAME (which has spaces in it), and then commiting again, with 
"-c HEAD". Which did what I expected: the second commit had the same 
author name as the first one.

So I thought that it was okay.

Ciao,
Dscho
