From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 08:57:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505200855120.2206@ppc970.osdl.org>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org> <7vzmupud54.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:56:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ9pk-0006KT-7Y
	for gcvg-git@gmane.org; Fri, 20 May 2005 17:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVETPzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVETPzh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 11:55:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:35782 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261480AbVETPzc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 11:55:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KFtQU3029284
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 08:55:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KFtQBC018251;
	Fri, 20 May 2005 08:55:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Linus Torvalds wrote:
>
> The only correct way to do name sorting is the one that fsck does in
> "verify_order()". To realize why, you need to realize that "A" (the
> directory) sorts _after_ a filename "A file", because '/' sorts after ' '.  
> 
> In contrast, "A" (the directory) sorts _before_ "ABBA" (the band), because
> '/' sorts before 'B'.

Btw, in case you wonder: the real problem is that we use 
"cache_name_compare()" on a directory name. The function is (as the name 
says) designed for full pathnames, not the diff-tree kind of possibly 
partial basenames.

		Linus
