From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] work-trees are allowed inside a git-dir
Date: Sat, 28 Jul 2007 02:01:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280157100.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271957250.14781@racer.site> <7vejity3h8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280122160.14781@racer.site> <7vabthwdyg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 03:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEagX-0001es-TC
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 03:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXG1BBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 21:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938353AbXG1BBb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 21:01:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:60700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S938237AbXG1BBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 21:01:30 -0400
Received: (qmail invoked by alias); 28 Jul 2007 01:01:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 28 Jul 2007 03:01:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gD3ZpZyog134K8Oh5g1UDYBU5OrjbFzMvctYkMF
	EsVsVSwBmZ1lE+
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabthwdyg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53985>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > It is allowed to call
> >> >
> >> > 	$ git --git-dir=../ --work-tree=. bla
> >> >
> >> > when you really want to.  In this case, you are both in the git directory
> >> > and in the working tree.
> > ...
> > There are files in that directory (and all of its subdirectories) of a 
> > certain type, which are the only ones which are human generated, and 
> > therefore precious.  I like to add them, and inspect them, with
> >
> > 	git --git-dir=$HOME/x.git add
> >
> > and
> >
> > 	git --git-dir=$HOME/x.git diff
> 
> I understand the --git-dir=$HOME/x.git to keep track of
> something in $HOME/foo/bar example.
> 
> But that is not the issue you described in the original message.
> I was asking about this (which is the way I read your original
> message):
> 
>     $ GIT_DIR=$HOME/x.git git init
>     $ mkdir $HOME/x.git/workroot
>     $ cd $HOME/x.git/workroot
>     $ git --git-dir=../ --work-tree=. 
> 
> That is, $HOME/x.git/ is the GIT_DIR that has HEAD, index and
> refs/, and you are keeping track of contents whose rootlevel is
> at $HOME/x.git/workroot

Ah!  But I have a really nice use case for that, too.  I track a 
.git/refs/exclude in one of my branches, because I do not want anybody 
else to have those excludes.  They only apply to me.

Another example would be a temporary checkout+change+checkin to some 
branch that is not currently checked out in the default working tree.  (I 
do that, too, and had to work around that by cloning with "-l -n -s")  
What I do there is to keep a checkout of some often-rsync'ed (actually 
wget'ed) state in the current working tree, automatically committing when 
upstream changes, and tracking upstream _releases_ in a different branch.

Ciao,
Dscho
