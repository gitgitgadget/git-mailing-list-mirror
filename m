From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RFH: refactor read-tree
Date: Sun, 9 Jul 2006 00:28:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 09 00:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzLHX-0005rs-9r
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWGHW2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 18:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWGHW2I
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 18:28:08 -0400
Received: from mail.gmx.net ([213.165.64.21]:56275 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751315AbWGHW2H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 18:28:07 -0400
Received: (qmail invoked by alias); 08 Jul 2006 22:28:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 09 Jul 2006 00:28:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23516>

Hi,

the last thing to do with merge-recursive to speed it up, would be to 
avoid reading/writing the cache all the time.

Unfortunately, builtin-read-tree.c grew into a pretty big monster, with so 
many different options which completely change behaviour.

So, how should I go about it? Should I make a struct a la diff_options to 
hold the options to unpack_trees? Where should it go?

I also played a little with git-merge-tree, because it seems so much 
simpler and easier to refactor. But there is a problem: Either I call it 
the wrong way, or it does not yet work correctly: I tried

	git-merge-tree $(git-merge-base branch1 branch2) branch1 branch2

with what is in 'next'. But it only showed the _new_ files, not the 
modified ones.

Help, please?

Ciao,
Dscho
