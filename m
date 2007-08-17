From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix initialization of a bare repository
Date: Fri, 17 Aug 2007 23:20:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708172319480.20400@racer.site>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vhcn0pm3h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 00:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMABO-0005tn-4u
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 00:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbXHQWUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 18:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbXHQWUe
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 18:20:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:38300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752932AbXHQWUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 18:20:33 -0400
Received: (qmail invoked by alias); 17 Aug 2007 22:20:32 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 18 Aug 2007 00:20:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vBslvz3RvaqdK3JbFFQpy7UIb9L+TLbHy4tUB6V
	VtiLYeF4sdi1eB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcn0pm3h.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56092>

Hi,

On Wed, 15 Aug 2007, Junio C Hamano wrote:

> Wait a minute.
> 
> Let's step back a bit and think what we want to happen here.
> 
>  * No GIT_DIR, no --bare.  Having GIT_WORK_TREE is an error.
> 
>    $ mkdir foo && cd foo && git init
> 
>    We want to say "not bare" and create foo/.git/config and friends. 
> 
>  * No GIT_DIR, with --bare.  Having GIT_WORK_TREE is an error.
> 
>    $ mkdir foo && cd foo && git --bare init
> 
>    We want to say "is bare" and create foo/config, foo/HEAD and
>    friends.
> 
>  * With GIT_DIR but no GIT_WORK_TREE, with or without --bare.
> 
>    $ mkdir foo.git && GIT_DIR=foo.git git init
>    $ mkdir foo.git && GIT_DIR=foo.git git --bare init
> 
>    We want to say "is bare" and create foo.git/config and friends.
> 
>  * With GIT_DIR and GIT_WORK_TREE.  Having --bare is an error.
> 
>    $ mkdir foo.git foo.work
>    $ GIT_DIR=foo.git GIT_WORK_TREE=foo.work git init
> 
>    We want to say "not bare", create foo.git/config and friends,
>    and record core.worktree = /full/path/to/foo.work
> 
> Is the above list reasonable?

Yes.  I'll try to work on it the day after tomorrow.

Ciao,
Dscho
