From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 6 May 2005 10:11:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061009340.2233@ppc970.osdl.org>
References: <20050506134501.GA11430@vrfy.org> <20050506160359.GB6904@kroah.com>
 <1115396614.32065.23.camel@localhost.localdomain> <20050506163603.GA17766@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 19:03:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6EC-00029f-OO
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEFRJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFRJw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:09:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:50609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbVEFRJu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 13:09:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46H9mU3006630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 10:09:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46H9kW8019215;
	Fri, 6 May 2005 10:09:48 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050506163603.GA17766@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Greg KH wrote:
> 
> Odd.  If I reclone the whole tree from the udev kernel.org tree, then it
> works just fine.  If I create a new copy of my local tree, I still have
> the same problem.  Diffing the trees shows no difference in the objects
> at all...

You've not updated your cache.

Guys, remember this command:

	git-diff-files

Just like that, with no arguments. It shows you what is different in your 
cache. If you get a lot of output, it means that your index file isn't 
up-to-date.

The other magic command is

	git-update-cache --refresh

and you need to do that after you merge.

If you use cogito, and cogito doesn't refresh after pulls etc, that would
be a cogito bug. But if you do things like "cp -a" of a git tree, and 
you forget to refresh the cache in the new tree, than that is _your_ bug..

		Linus
