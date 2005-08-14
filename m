From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sending changesets from the middle of a git tree
Date: Sat, 13 Aug 2005 22:03:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508132155100.3553@g5.osdl.org>
References: <42FEBC16.9050309@austin.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 07:05:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4AfT-00038g-5h
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 07:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVHNFDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 01:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVHNFDy
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 01:03:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932452AbVHNFDy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 01:03:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7E53pjA025689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 22:03:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7E53mVN011843;
	Sat, 13 Aug 2005 22:03:50 -0700
To: Steve French <smfrench@austin.rr.com>
In-Reply-To: <42FEBC16.9050309@austin.rr.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Steve French wrote:
> 
> 1) There is no way to send a particular changeset from the "middle" of a 
> set from one tree to another, without exporting it as a patch or 
> rebuilding a new git tree.

Correct.

> If I export those two changesets as patches, and send them on.
> presumably I lose the changset comments etc.

Well, you can export them with "git send-email" and you won't be losing 
any comments.

Alternatively, use "git cherry", which helps re-order the commits in your
tree. They'll be _new_ commits, but they'll have the contents moved over. 
Junio, maybe you want to talk about how you move patches from your "pu" 
branch to the real branches.

> and then when the upstream tree is merged back, it might look a little
> odd in the changeset history.

Well, you'll end up having the same change twice. It happens. Or if you 
just redo your tree as a separate branch, you can reorder things so that 
you don't have them twice at all.

> 2) There is no way to update the comment field of a changeset after it 
> goes in (e.g. to add a bugzilla bug number for a bug that was opened 
> just after the fix went in).

That's correct. Same things apply: you can move a patch over, and create a 
new one with a modified comment, but basically the _old_ commit will be 
immutable.

The good news is that it means that nobody else can change what you said 
or did either. 

> 3) There is no way to do a test commit of an individual changeset 
> against a specified tree (to make sure it would still merge cleanly, 
> automatically).

Oh, sure, that's certainly very possible, and the git cherry stuff even
helps you do it.  Or use "git-apply --check" to just see if a patch
applies and do your own scripts. 

		Linus
