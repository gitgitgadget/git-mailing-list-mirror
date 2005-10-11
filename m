From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to restore the original head after `git-reset --hard master^`
Date: Tue, 11 Oct 2005 08:59:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510110856520.14597@g5.osdl.org>
References: <434BD65A.9000108@ust.hk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 17:59:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPMXY-0006P3-35
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 17:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVJKP7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 11:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJKP7S
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 11:59:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbVJKP7R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 11:59:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BFx64s019981
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 08:59:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BFx5Ln013347;
	Tue, 11 Oct 2005 08:59:05 -0700
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <434BD65A.9000108@ust.hk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9972>



On Tue, 11 Oct 2005, Ben Lau wrote:
> 
>   After involves the command `git-reset --hard master^` in a repository, 
> the working tree , current head and index are restored to the parent of 
> master. That includes the content of '.git/refs/head/master'. Although 
> the original commit object is still existed , I couldn't find it back.
> 
>  Is there anyway to recover the original master branch ?

Just run "git-fsck-objects" and look at any dangling commits. The commit 
and related objects are still there (unless you've run "git prune"), so 
once you find the name of it, you're all done.

First check that you  have the right one by doing

	git log <name-you-found>

and if that looks right, you can just do

	git reset --hard <name-you-found>

and you should be back in business.

		Linus
