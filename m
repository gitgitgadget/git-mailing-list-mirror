From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories?
Date: Sun, 1 Jan 2006 15:09:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601011452230.3668@g5.osdl.org>
References: <20060101200121.GA20633@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 02 00:10:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtCLA-00013u-LL
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 00:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWAAXJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 18:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWAAXJ7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 18:09:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932101AbWAAXJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 18:09:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k01N9tDZ019397
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 Jan 2006 15:09:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k01N9s32007317;
	Sun, 1 Jan 2006 15:09:54 -0800
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060101200121.GA20633@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14134>



On Sun, 1 Jan 2006, Olaf Hering wrote:
> 
> How do I get a list of commits in the 'powerpc' tree, which are not part
> of the 'linux-2.6' tree? The git tutorial has a section 'Working with
> Others', but the examples dont work for me. Probably because
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git has
> no info that it is not the "mainline tree".
> All I need is a list of individual commits in that tree, which are not
> (yet) in "mainline".

First, get a kernel tree, let's say that you just get the standard one 
and thus my head will be in "origin" (and perhaps HEAD too, unless you 
decide to do some stuff of your own). Then just do something like

   git fetch \
	git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git \
	master:powerpc

which gets the master branch from the powerpc.git tree into your "powerpc" 
branch (or set up a .git/remotes/powerpc thing if you expect to do more of 
this).

Then you can just do

	gitk origin..powerpc

(or "git log" or "git-whatchanged -p" instead of "gitk") to see the 
commits that are in powerpc but not in "origin".

		Linus
