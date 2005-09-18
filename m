From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 15:29:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181526220.9106@g5.osdl.org>
References: <Pine.LNX.4.63.0509181201220.23242@iabervon.org>
 <20050918145434.GA22391@pasky.or.cz> <94fc236b050918073351075bb4@mail.gmail.com>
 <20050918211855.GA1463@schottelius.org> <20050918221125.GD22391@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Mon Sep 19 00:31:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH7fk-0001OE-At
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 00:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVIRWaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 18:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVIRWaE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 18:30:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932238AbVIRWaB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 18:30:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IMTlBo022727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 15:29:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IMTk6h001025;
	Sun, 18 Sep 2005 15:29:46 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050918221125.GD22391@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8819>



On Mon, 19 Sep 2005, Petr Baudis wrote:
> 
> I think it should actually never happen, updating the references should
> always come as the last thing in the push (or pull, for that matter)
> process.

It happens when you have several layers of non-git-aware stuff in between.

On kernel.org it happens occasionally with the mirroring, for example. I 
push something out while a mirror event is active, and the mirroring ends 
up finding the refs before the objects.

The same could happen with a write-back distributed networked filesystem,
for example (not NFS, which is synchronous in metadata, but some other
level of non-git-aware thing that doesn't necessarily maintain write
ordering).

In general, git does the right thing for anything that honors write 
ordering, but the fact is, there are things that don't.

		Linus
