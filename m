From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 12:53:06 -0700
Message-ID: <7vmza8l8f1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
	<Pine.LNX.4.63.0608132017090.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 13 21:53:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCM1I-0008JU-Dw
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 21:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWHMTxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWHMTxJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 15:53:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25523 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751392AbWHMTxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 15:53:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813195307.CGJU6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 15:53:07 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608132017090.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 13 Aug 2006 20:20:43 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25292>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd rather have a command which tells me if I have commits after the last 
> time I pushed.

Yes.

However, I have not felt the need for "a command".  In my
workflow, I use tracking branches for the push destination.

Before I rewind / rebase / clean-up, I fetch from my usual push
destination with these lines:

	URL: kernel.org:/pub/scm/git/git.git/
        Pull: master:refs/tags/ko-master
        Pull: next:refs/tags/ko-next
        Pull: +pu:refs/tags/ko-pu
        Pull: maint:refs/tags/ko-maint

and have a script to do this (Meta/KO -- found in "todo" branch):

	#!/bin/sh
	git fetch ko
        for i in master next pu maint
        do
        	git show-branch $i ko-$i
        done

I primarily use this to make sure I do not rewind beyond what
are already pushed out, but I also can use it to see what's
outstanding to be pushed.
