From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Alternate Patch: [PATCH] Don't include device number in cache
 invalidation when running on NFS
Date: Sun, 22 May 2005 14:58:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221451590.2307@ppc970.osdl.org>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org>
 <20050522192734.GB23388@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505221332590.2307@ppc970.osdl.org>
 <20050522212312.GC23388@cip.informatik.uni-erlangen.de>
 <20050522214115.GD23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 23:55:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZyPw-00032h-Au
	for gcvg-git@gmane.org; Sun, 22 May 2005 23:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEVV4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 17:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVEVV4p
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 17:56:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:4811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVEVV4n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 17:56:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MLucjA024655
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 14:56:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MLuYhp030452;
	Sun, 22 May 2005 14:56:36 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050522214115.GD23388@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Thomas Glanzmann wrote:
> 
> While reading liblockfile I saw the following:

This is _really_ Linux-specific afaik. Which is ok for git, but at the
same time it really makes me go "Ewww". It's testing that the major number 
is 0, and it would be a lot more cleaner to use 

	if (!major(st.st_dev))

but even that is very Linux-specific.

> [PATCH] Don't include device number in cache invalidation when running on NFS

I'll have to think about it. Maybe I should just remove the st_dev check. 
I guess inode/size/mtime/ctime should be plenty safe enough in practice.

		Linus
