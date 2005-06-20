From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'git commit' duplicates parents?
Date: Mon, 20 Jun 2005 08:11:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506200808090.2268@ppc970.osdl.org>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org> <42B62C85.10701@pobox.com>
 <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org> <42B690EA.2080605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:04:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkNoo-0003VZ-Hc
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 17:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFTPJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 11:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFTPJc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 11:09:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261306AbVFTPJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 11:09:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5KF9PjA010172
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 20 Jun 2005 08:09:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5KF9NMc001388;
	Mon, 20 Jun 2005 08:09:24 -0700
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <42B690EA.2080605@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, Dan Holmsand wrote:
> 
> git-resolve-script still seems a bit too eager to write MERGE_HEAD and 
> ORIG_HEAD - they only make sense if there's actually been any merging 
> done, don't they?
> 
> Patch below shows what I mean.

I considered this, but decided that MERGE_HEAD is potentially very useful
for some of the other failure exits. There's a few "exit 1"'s in there,
for example when the "git-read-tree -m"  fails because of a dirty
workspace.

Of course, you can always re-do the merge completely (and maybe that's 
what people end up doing), but at least in theory you can fix it up and 
just re-resolve. But in order to do that, you need to know what the 
MERGE_HEAD was...

So I'm not sure what the right answer is, which is why my fix was the 
minimally invasive one that only removes the heads on success..

		Linus
