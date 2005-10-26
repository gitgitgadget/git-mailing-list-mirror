From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: [PATCH 1/4] git-init-db should error out with a message
Date: Wed, 26 Oct 2005 22:47:27 +0200
Message-ID: <20051026204727.GA19846@steel.home>
References: <Pine.LNX.4.63.0510260139000.30576@wbgn013.biozentrum.uni-wuerzburg.de> <20051026194520.GC8030@steel.home> <7v3bmoc9d7.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:50:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUsBs-0008Qv-UV
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVJZUrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJZUrh
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:47:37 -0400
Received: from devrace.com ([198.63.210.113]:58386 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964913AbVJZUrg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 16:47:36 -0400
Received: from tigra.home (p54A0C833.dip.t-dialin.net [84.160.200.51])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j9QKlU6B092772;
	Wed, 26 Oct 2005 15:47:31 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EUsBD-0008RI-00; Wed, 26 Oct 2005 22:47:27 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EUsBD-0005As-Kp; Wed, 26 Oct 2005 22:47:27 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bmoc9d7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10693>

Junio C Hamano, Wed, Oct 26, 2005 22:27:00 +0200:
> > Not just that. It would be interesting to give the user an option to
> > use the file references ("ref: refs/heads/master").
> 
> Actually, the users should not have to care how HEAD reference
> is implemented.  It might make sense to use regular file symref
> regardless of platforms (i.e. never define USE_SYMLINK_HEAD on
> any platform).

This my idea too. All the time I was doing that patch :)

> HOWEVER, I think "falling back" (both in Johannes' patch which
> is in the "master" branch, and your version) has a funny failure
> mode.  What happens when two processes try redirecting .git/HEAD
> simultaneously, possibly to different branch heads?  Both of
> them unlink(), one successfully does symlink(), and the other
> gets EEXIST and falls back to create regular file symref.

I think the file ref version uses rename of HEAD.lock into HEAD, doesn't it?
Rename(2) should just remove the symlink, right?
