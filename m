From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 11:08:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
 <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200508031908.22562.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 20:10:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NfX-0005Yh-W0
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 20:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVHCSIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVHCSIe
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 14:08:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262382AbVHCSId (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 14:08:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73I8TjA009828
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 11:08:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73I8TjO031970;
	Wed, 3 Aug 2005 11:08:29 -0700
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508031908.22562.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Josef Weidendorfer wrote:
> 
> Yes it is. To reproduce:
> Create a repository with 2 branches.
> Make 2 clones of the 2 branches via SSH.
> Make a commit on one clone and push.
> Make another commit on the other clone and push => ERROR

This works perfectly fine, you just have to make sure that you update the 
right head.

If you try to update a head that is ahead of you, that is driver error. 
Admittedly one that could have nicer error messages ;)

This is why git-send-pack takes the name of the branch to update..

The real problem with git-send-pack is that the local and remote names 
have to be the same, which is a bug, really. It _should_ be perfectly fine 
to do something like

	git-send-pack ..dest.. localname:remotename

which would push the local "localname" branch to the remote "remotename" 
branch.

			Linus
