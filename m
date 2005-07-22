From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 13:43:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
 <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
 <42E1571B.8070108@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 22:45:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4OQ-0002lP-G6
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 22:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVGVUoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 16:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVGVUoa
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 16:44:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261395AbVGVUnh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 16:43:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6MKhPjA028742
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Jul 2005 13:43:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6MKhI78016559;
	Fri, 22 Jul 2005 13:43:21 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <42E1571B.8070108@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Jul 2005, A Large Angry SCM wrote:
> 
> To do it without the history rewrite, create an alternate_history 
> directory under .git with it's own objects tree. And populate that 
> object tree with "alternative" content for the objects in the normal 
> trees. Then teach the things the lookup/read objects to look there first 
> and to _not_ care about invalid SHAs. Of course, if you do this, you 
> will never be able to trust your repository.

You can do it much more nicely if you want.

Just teach "parse_commit()" to look at a ".git/fake_parents" file, and 
insert fake extra parents for commits that way - you can graft any tree on 
top of any other tree that way, and it's probably a nice idea for testing 
things out.

			Linus
