From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Fri, 24 Jun 2005 22:23:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 07:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm35G-0003Ax-Sa
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 07:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbVFYFYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 01:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbVFYFYS
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 01:24:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263341AbVFYFYP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2005 01:24:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5P5L0jA001786
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 22:21:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5P5KxjB000639;
	Fri, 24 Jun 2005 22:21:00 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BCE026.8050405@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 25 Jun 2005, Jeff Garzik wrote:
> 
> This is all due to the rsync sweeps, which have to scan metric tons of 
> inodes and dentries.  Orders of magnitude over the pre-git days.

Well, the real solution is to use a git-aware protocol, not rsync.

rsync is wonderful for prototyping, and I wanted to make the database 
rsync'able for that reason, but it clearly doesn't scale.

I think I'll make a "pack"/"unpack" pair that just packs all the necessary
objects between two commits. Then you can basically sync the object file 
by doing

	git-pack OLD..NEW | ssh other-end git-unpack

and you'd basically be done. It looks pretty easy to do, too..

			Linus
