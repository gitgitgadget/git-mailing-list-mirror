From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git merging
Date: Fri, 17 Jun 2005 19:51:35 -0400
Message-ID: <42B36207.3020209@pobox.com>
References: <20050617133440.GI6957@suse.de> <Pine.LNX.4.58.0506170937260.8487@ppc970.osdl.org> <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org> <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org> <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060506030908090101000207"
Cc: Jens Axboe <axboe@suse.de>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 01:46:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjQXW-0001T9-NT
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 01:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFQXvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 19:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFQXvo
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 19:51:44 -0400
Received: from mail.dvmed.net ([216.237.124.58]:5264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261288AbVFQXvm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 19:51:42 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DjQcc-0000MB-72; Fri, 17 Jun 2005 23:51:38 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060506030908090101000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Ok. The most likely reason is that your main branch is not a symlink to 
> ".git/refs/***" at all, but just a regular ".git/HEAD" file.

This is definitely not the case; my .git/HEAD is _always_ a symlink.

My git-switch-tree script, attached, demonstrates how .git/HEAD symlink 
is retargetted to the specified branch.  My workflow depends on 
.git/HEAD being a symlink.

I'll see if I can reproduce with the latest git.

	Jeff



--------------060506030908090101000207
Content-Type: text/plain;
 name="git-switch-tree"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-switch-tree"

#!/bin/sh

if [ "x$1" != "x" ]
then
	if [ ! -f .git/refs/heads/$1 ]
	then
		echo Branch $1 not found.
		exit 1
	fi

	( cd .git && rm -f HEAD && ln -s refs/heads/$1 HEAD )
fi

git-read-tree -m HEAD && git-checkout-cache -q -f -u -a


--------------060506030908090101000207--
