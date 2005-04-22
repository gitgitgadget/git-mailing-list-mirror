From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Thu, 21 Apr 2005 22:05:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
 <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 07:02:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOqJ1-0001zp-Pn
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 07:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVDVFGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 01:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVDVFGa
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 01:06:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:5763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVDVFGS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 01:06:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3M537s4002568
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 22:03:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3M537js011616;
	Thu, 21 Apr 2005 22:03:07 -0700
To: Junio C Hamano <junio@siamese.dyndns.org>
In-Reply-To: <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Junio C Hamano wrote:
> 
> I am thinking about an alternative way of doing the above by
> some modifications to the git core.  I think the root of this
> problem is that there is no equivalent to GIT_INDEX_FILE and
> SHA1_FILE_DIRECTORY that tells the core git where the project
> top directory (i.e. the root of the working tree that
> corresponds to what $GIT_INDEX_FILE describes) is.

I'd _really_ prefer to just try to teach people to work from the "top" 
directory instead.

>  - A new environment variable GIT_WORKING_TREE points at the
>    root of the working tree.
> 
>  - Each git core command [*1*] that looks at the working tree is
>    modified to take the user supplied pathname as a path
>    relative to the current working directory, and use
>    GIT_WORKING_TREE value to figure out which path the user is
>    talking about, relative to the tree structure GIT_INDEX_FILE
>    describes.

I really don't like it that much, but to some degree it obviously is
exactly what "--prefix=" does to checkout-cache. It's basically saying 
that all normal file operations have to be prefixed with a magic string. 

And git really doesn't do too many of those, so maybe it's ok. What would 
the patch look like? I don't really love the idea, but if the patch is 
clean enough...

		Linus
