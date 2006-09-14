From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 08:31:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
References: <20060914142249.GK23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 17:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtBw-0000eH-6T
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 17:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWINPbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWINPbt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 11:31:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbWINPbs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 11:31:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8EFVenW016874
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Sep 2006 08:31:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8EFVdW9021652;
	Thu, 14 Sep 2006 08:31:40 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060914142249.GK23891@pasky.or.cz>
X-Spam-Status: No, hits=-0.514 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27001>



On Thu, 14 Sep 2006, Petr Baudis wrote:
> 
>   just to test the packing improvements we had achieved over the last
> year, I have repacked the historical kernel repository and achieved a
> significant improvement:

Umm.. Only apparently because the old pack was really really bad. It also 
has the wrong name, probably because it's using the original naming that 
had the SHA1 computed on the unsorted input. That was changed a long time 
ago.

Yours isn't wonderful either.

> -rw-r--r-- 1 xpasky users  13600376 Sep 14 16:18 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.idx
> -rw-r--r-- 1 xpasky users 197168186 Sep 14 16:18 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.pack
> -rw-r--r-- 1 xpasky users  13600376 Sep 14 12:18 pack-cc3517351ecce3ef7ba010559992bdfc10b7acd4.idx
> -rw-r--r-- 1 xpasky users 262818936 Sep 14 12:29 pack-cc3517351ecce3ef7ba010559992bdfc10b7acd4.pack

Mine are:

-rw-r--r-- 1 torvalds torvalds  13600376 Apr 19 10:06 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.idx
-rw-r--r-- 1 torvalds torvalds 185374386 Apr 19 10:06 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.pack

and as you can see from the date, they aren't exactly very recent, but 
they shave an additional 6% off the size.

I agree that the _oroginal_ history pack by Thomas seems to be bad, and 
that's from Aug 9 2005, so it's likely with some really really old packing 
rules.

For better packing, I think I used a larger depth, ie try something like

	git repack -a -f --depth=50

to get more improvement. For a historical archive that you don't much use, 
doign the deeper depth is definitely worth it.

		Linus
