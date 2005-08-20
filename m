From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: My GIT Day
Date: Sat, 20 Aug 2005 13:02:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508201254040.32350@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net> <7voe7tqpae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 13:02:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6R7E-00042t-Ep
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 13:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVHTLCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 07:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVHTLCI
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 07:02:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:29361 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751244AbVHTLCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 07:02:06 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CE12F139102; Sat, 20 Aug 2005 13:02:03 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AABCCB0A50; Sat, 20 Aug 2005 13:02:03 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8D294A4937; Sat, 20 Aug 2005 13:02:03 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 28D56139102; Sat, 20 Aug 2005 13:02:03 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe7tqpae.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 19 Aug 2005, Junio C Hamano wrote:

>     $ git checkout pu
>     $ git reset master
> 
> This checks out the head of "pu" branch, and then resets the
> index file to match "master" and updates .git/refs/heads/pu.
> 
> What it does _not_ do is to update my working tree to match the
> index file.  Linus recommends to do "git checkout -f" at this
> point, but I typically do this instead:
> 
>     $ git diff -R -p | git apply
> 
> Note.  This is an embarrassingly expensive way; the only thing
> it buys me over "git checkout -f" is that it removes the files
> that were introduced in "pu" branch that did not exist in the
> "master" head.  I have to come up with a not so expensive way to
> do this.

How about this?

  $ git reset master
  $ rm -i $(git-diff-tree ORIG_HEAD HEAD | grep "^.\{97\}D" | cut -c 100-)
  $ git checkout -f

Ciao,
Dscho
