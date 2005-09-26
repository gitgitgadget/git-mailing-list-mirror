From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 08:04:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
 <20050926133204.GB21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 17:10:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJuXy-0003jI-Nm
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 17:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbVIZPEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 11:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbVIZPEo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 11:04:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751640AbVIZPEn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 11:04:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8QF4Q4s026270
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Sep 2005 08:04:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8QF4P8G030145;
	Mon, 26 Sep 2005 08:04:25 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926133204.GB21019@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9307>



On Mon, 26 Sep 2005, Petr Baudis wrote:
> 
> Nope. rsync always did packs, I actually un-deprecated it for the time
> period when HTTP didn't. The thing is, rsync is bad - it will happily
> put duplicate, redundant, and especially unwanted data to your
> repository, especially when the shared GIT repositories happen.

Worse than that, rsync will happily sync up to a remote repository without 
even getting _all_ the object files, and never tell you anything is wrong.

This happened to several people when the kernel.org mirroring was 
broken/delayed.

So yes, rsync is fast. But it's fast exactly _because_ it is broken. Very 
very fundamentally broken.

You basically have to run fsck on your repository after an rsync. And if 
it returns errors, you're screwed unless you remember what your old heads 
were.

		Linus
