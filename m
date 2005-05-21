From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Fri, 20 May 2005 20:34:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505202025480.2206@ppc970.osdl.org>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
 <7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 05:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZKiC-0004eO-Js
	for gcvg-git@gmane.org; Sat, 21 May 2005 05:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVEUDcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 23:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVEUDcS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 23:32:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:27275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261647AbVEUDcF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 23:32:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4L3VvjA017977
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 20:31:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4L3Vuc6016289;
	Fri, 20 May 2005 20:31:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Junio C Hamano wrote:
>
> Although I do not have immediate objections to what it tries to
> do, I have to think about the intent of the patch and its
> ramifications.

I really think it should be a totally separate flag to enable showing the
sub-trees if the tree-blobification wants this.

In fact, I can pretty much _guarantee_ that the patch as posted is the
wrong thing to do: it will do horribly wrong things for things like

	git-whatchanged arch/i386/kernel/head.S

(but I haven't tried it - try it yourself. The correct output for the 
kernel archive is just a single commit, and a single blob change in that 
commit).

My bet is that the patch will end up showing every single changeset that 
touches anything under "arch/", since such _trees_ will be marked as 
interesting. Which is absolutely the wrong thing to do.

Nico, try it, maybe you'll prove me wrong.


		Linus
