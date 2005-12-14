From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 08:26:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512140822540.3292@g5.osdl.org>
References: <200512140257.03975.len.brown@intel.com> <7vmzj4yq3l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 17:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmZTN-0002X7-Iu
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 17:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVLNQ1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 11:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVLNQ1G
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 11:27:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964827AbVLNQ1F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 11:27:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBEGQkDZ024512
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Dec 2005 08:26:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBEGQid3023864;
	Wed, 14 Dec 2005 08:26:45 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzj4yq3l.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13631>



On Wed, 14 Dec 2005, Junio C Hamano wrote:
> 
> Gahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh.
> 
> Forget about what I said.  Although all of what I said above are
> correct, I do not think it applies to your case at all --- these
> commits do not appear to be created by git-pull nor git-merge,
> and honestly, they look quite bogus.  There is something else
> going on.
> 
>         $ git cat-file commit 9115a6
>         tree da65904b8c0c0bc6c778b39bc25d06e07ca7c82c
>         parent 927fe18397b3b1194a5b26b1d388d97e391e5fd2
>         parent e4f5c82a92c2a546a16af1614114eec19120e40a
>         author Len Brown <len.brown@intel.com> 1133904460 -0500
>         committer Len Brown <len.brown@intel.com> 1133904460 -0500
> 
>         Auto-update from upstream
> 
>         $ git-merge-base 9115a6^1 9115a6^2; git-rev-parse 9115a6^2
>         e4f5c82a92c2a546a16af1614114eec19120e40a
>         e4f5c82a92c2a546a16af1614114eec19120e40a

Argh. 

Len, how old a git are you using? "git-merge" really should _never_ have 
done this, but old (and I mean really old) git merges sometimes got 
confused with the base parent and would create a merge even when it was 
unnecessary.

		Linus
