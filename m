From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 23 Aug 2005 19:26:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231922340.3317@g5.osdl.org>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
 <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain>
 <20050821094059.GA5453@fanta> <Pine.LNX.4.63.0508221707520.23242@iabervon.org>
 <tnxvf1wd24m.fsf@arm.com> <7virxwmbcu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 04:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7kyg-00029Z-N5
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 04:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVHXC0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 22:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVHXC0r
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 22:26:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbVHXC0q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 22:26:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7O2QWjA021931
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 19:26:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7O2QR8c021564;
	Tue, 23 Aug 2005 19:26:29 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virxwmbcu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7699>



On Tue, 23 Aug 2005, Junio C Hamano wrote:
> 
> Yes it can.  GIT does not care if the commit ancestry does not
> make sense in contents terms (i.e. you can record one tree
> object in a commit object, and record another, completely
> unrelated tree object in a commit object that has the first
> commit object as its parent).  The "git-diff-tree" output from
> comparing those two commits may not make _any_ sense at all to
> the human, though, but that is not a problem for GIT to do its
> work.

One issue is later merges.

If you have incorrect parent information, trying to do a merge may prove
impossible and/or ignore changes from the "already merged" stream. By
marking another head as a parent, you basically say "I have merged
_everything_ leading up to that other head", and if you have only actually
done a partial merge (and gotten just a part of the changes, ignoring the
others), you'll have to notice that yourself, and forward-port the rest by
hand.

For stgit, this probably doesn't matter.

		Linus
