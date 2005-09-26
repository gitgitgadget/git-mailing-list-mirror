From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 09:43:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509260941340.3308@g5.osdl.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
 <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
 <20050926163846.GD21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 18:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJw4a-0006M1-Rk
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 18:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbVIZQnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 12:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbVIZQnW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 12:43:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751670AbVIZQnV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 12:43:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8QGh94s030713
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Sep 2005 09:43:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8QGh8tU001699;
	Mon, 26 Sep 2005 09:43:09 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926163846.GD21019@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9310>



On Mon, 26 Sep 2005, Petr Baudis wrote:
> 
> Actually, it would be nice to be able to tell git-fsck-objects to only
> verify objects which are referenced between given two commits (perhaps
> just make it support the ^object notation). Then I wouldn't mind running
> that after each rsync fetch in Cogito.

You can kind of do it.

Do

	git-rev-list --objects $oldheads --not $newheads >& /dev/null
	echo "$?"

and it _should_ largely work. Untested, of course, but I _hope_ that if 
any object is missing, git-rev-list should die with an error. And if it 
doesn't, I should fix it ;)

		Linus
