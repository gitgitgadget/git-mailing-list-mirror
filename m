From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel headers git tree
Date: Thu, 13 Jul 2006 18:08:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607131806140.5623@g5.osdl.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net> <1152838562.31372.58.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 03:08:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1CAq-0000x8-4L
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 03:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWGNBIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 21:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWGNBIw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 21:08:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161159AbWGNBIw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 21:08:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6E18jnW011402
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Jul 2006 18:08:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6E18iib022278;
	Thu, 13 Jul 2006 18:08:45 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152838562.31372.58.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23865>



On Fri, 14 Jul 2006, David Woodhouse wrote:
>
> Btw, git-rev-list is _very_ slow at this. Even when the output is
> actually HEAD, it takes my 2.3GHz G5 a _long_ time to give a result:
> 
> pmac /pmac/git/linux-2.6 $ git-rev-parse HEAD
> ab6cf0d0cb96417ef65cc2c2120c0e879edf7a4a
> pmac /pmac/git/linux-2.6 $ time git-rev-list --max-count=1 --topo-order HEAD -- include
> ab6cf0d0cb96417ef65cc2c2120c0e879edf7a4a
> 
> real    0m18.840s
> 
> Is there a better way to do that step?

Umm.. On my poor little 1.6GHz laptop:

	[torvalds@evo linux]$ time git-rev-list --max-count=1 HEAD -- include
	ab6cf0d0cb96417ef65cc2c2120c0e879edf7a4a

	real    0m0.014s
	user    0m0.004s
	sys     0m0.012s

that's 0.014 sec. Not exactly slow.

Now, the --topo-order you have there does slow it down a lot:

	[torvalds@evo linux]$ time git-rev-list --max-count=1 --topo-order HEAD -- include
	ab6cf0d0cb96417ef65cc2c2120c0e879edf7a4a

	real    0m24.016s
	user    0m23.973s
	sys     0m0.016s

so now it takes 24 seconds, and gives the same result.

		Linus
