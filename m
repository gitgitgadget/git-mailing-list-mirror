From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:25:27 -0800
Message-ID: <20060213022527.3f888666.akpm@osdl.org>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<20060213093938.GC11053@mythryan2.michonline.com>
	<20060213015146.26e6c09d.akpm@osdl.org>
	<20060213101443.GD11053@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 11:26:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8auY-0000Wh-Lj
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWBMK0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWBMK0Y
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:26:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751230AbWBMK0X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 05:26:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DAQGDZ023385
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 02:26:17 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1DAQGYH012908;
	Mon, 13 Feb 2006 02:26:16 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060213101443.GD11053@mythryan2.michonline.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16067>

Ryan Anderson <ryan@michonline.com> wrote:
>
> On Mon, Feb 13, 2006 at 01:51:46AM -0800, Andrew Morton wrote:
> > 
> > Assuming I find the bad commit, how do I extract it as a patch?
> > 
> > I tried
> > 
> > git-format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netdev-all
> > 
> > and that chewed 10 minutes CPU time and produced no output, so I killed it.
> 
> Well, assuming it's not a merge, you'll want something like this:
> 
> git format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20

That worked.

> For essentially the same output, you can do a few other variations:
> 
> git whatchanged -p 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20
> git diff 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20
> 
> If it's a merge that bisect terminates on, things get a bit trickier, as
> you want to figure out what went wrong in the merge to cause it, so
> you'll want to use either the syntax for specifying which merge parent
> to look at (which I forget at the moment) or, run:
> 	git rev-list --parents --max-count=1 386093ef9a6c88576d8b418bf1c8616d5e410a20
> and look at columns 2+ individually.

It did terminate on a merge.  Thats over four hours gone and, frankly, I'm
sick of it.  I just want the darned diffs so I can do something useful.

> In fact, if you want, you can re-do the merge, by creating some branches
> based off of each parent, then pulling one into the other, and seeing
> what went wrong.
> 
> Hope that helps (if not, I apologize - I should've gone to bed a while
> ago and it may have snuck through)

It does.

I'm still not having much success geting a string of patches out of it.

git format-patch -o ~/a d834a41c966c6a20368fadb59248740935e6fbae..826eeb53a6f264842200d3311d69107d2eb25f5e

Has chewed 5 minutes CPU so far and hasn't produced anything.

How do I get the IPW patches out of Jeff's tree, in order?

I guess since I found a command which actually works, I can type that
20-odd times.
