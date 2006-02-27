From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Mon, 27 Feb 2006 02:57:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602270257110.4147@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 02:57:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDXdm-0004pu-69
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 02:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWB0B50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 20:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWB0B50
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 20:57:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:61919 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750712AbWB0B5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 20:57:25 -0500
Received: (qmail invoked by alias); 27 Feb 2006 01:57:23 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp013) with SMTP; 27 Feb 2006 02:57:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16819>

Hi,

beware of that patch. It breaks at least one thing: cloning a repository 
with a tag pointing to a tag object (the tag is cloned, but not the tag 
object).

Sorry to not fix it right away, but I am just too tired.

By way of figuring this out, I just found a (warning: irony) "cute 
feature" of git-bisect. I needed to apply a certain patch to trigger a 
certain bug. So I always applied that patch after bisect chose the next 
rev, and of course committed it so that bisect could continue.

(In hindsight, I probably should've applied the patch, 
git-update-index'ed the file, and hoped that the merge mechanism take care 
of it.)

Now, short of finding the correct commit, bisect would loop endlessly, 
giving me the same rev to test over and over again (saying "2 revs to go 
after this"), because I would label the current rev (which was the applied 
patch, not the bad rev) as bad.

So, in a very real sense, it might not be such a phantastic idea as was 
suggested earlier on this list, that you are able to commit on top of a 
bisected rev.

Good night and good luck,
Dscho
