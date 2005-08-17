From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Improve handling of "." and ".." in git-diff-*
Date: Tue, 16 Aug 2005 20:52:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508162044390.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508162037080.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 05:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Eyb-0004ZS-6r
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 05:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVHQDw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 23:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVHQDw0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 23:52:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbVHQDwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 23:52:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7H3qLjA028146
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 20:52:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7H3qKBU031990;
	Tue, 16 Aug 2005 20:52:20 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508162037080.3553@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Tue, 16 Aug 2005, Linus Torvalds wrote:
> 
> This fixes up usage of ".." (without an ending slash) and "." (with or 
> without the ending slash) in the git diff family.

Btw, if it wasn't clear, with this patch you can now do

	git diff .

and it will show the diffs for everything under the current working 
directory. Similarly, you can do

	git diff ./drivers

or something like

	cd arch/i386
	git diff . ../x86-64 

and it will do the obvious thing (the "obvious thing" in the latter case
is to show the diffs for everything under _both_ arch/i386 and
arch/x86-64, but not anything outside of that - the path pattern gets
rewritten to "arch/i386" and "arch/x86-64").

		Linus

PS. A number of the other "work tree" ops can be similarly extended to
DTRT in git project subdirectories, but I wanted to finish off the "git
diff" family first, and get that one all done. I think I'm done now, and I
might tackle the other things (git-update-cache, git-checkout-cache,
git-commit-script, etc) tomorrow.
