From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merging
Date: Fri, 17 Jun 2005 16:31:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
References: <20050617133440.GI6957@suse.de> <Pine.LNX.4.58.0506170937260.8487@ppc970.osdl.org>
 <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org>
 <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org>
 <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
 <42B357D7.6030302@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Axboe <axboe@suse.de>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 01:24:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjQCK-0007kX-AC
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 01:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVFQX3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 19:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFQX3v
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 19:29:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261224AbVFQX3r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 19:29:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5HNTfjA025286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 17 Jun 2005 16:29:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5HNTdGK029161;
	Fri, 17 Jun 2005 16:29:40 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B357D7.6030302@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 17 Jun 2005, Jeff Garzik wrote:
> 
> I've been too lazy to report this, but...
> 
> last time I tried it, git-prune-script ate valid objects, for my 
> multi-branch trees.  This was 100% reproducible.

Ok. The most likely reason is that your main branch is not a symlink to 
".git/refs/***" at all, but just a regular ".git/HEAD" file.

"git prune" will by default _only_ look for references in .git/refs/, and
if you have any references anywhere else, you need to do all your refs by
hand.

There might be a bug in the ref-lookup code, of course, but it's more 
likely that your refs just aren't where fsck expects them.

		Linus
