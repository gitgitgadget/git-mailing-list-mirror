From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:38:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200934140.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
 <20060920162810.GB23260@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:39:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ56C-0000Hs-Dw
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWITQik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWITQik
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:38:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751673AbWITQij (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:38:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KGcRnW022206
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 09:38:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KGcPfP003435;
	Wed, 20 Sep 2006 09:38:26 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920162810.GB23260@spearce.org>
X-Spam-Status: No, hits=-0.505 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27373>



On Wed, 20 Sep 2006, Shawn Pearce wrote:
> > 
> > A lot of people do things like "git repack -a -d" by hand, and we've tried 
> > to encourage people to do so in cron-jobs etc. We've even had patches 
> > floating around that do it automatically after a pull.
> 
> Ouch.  That's really bad.

Well, what did you think the "-d" stood for?

It stands for "delete old packs".

There are exactly two operations that delete git objects: "git prune" and 
"git repack -d". Nothing else should ever do it, but those two definitely 
do. They're designed to.

I wouldn't call it "really bad" - it's part of the design. It's only bad 
if you didn't realize what "-d" means.

> I knew it but didn't realize it until just now.
> 
> 	git repack -a -d
> 	git branch -D foo
> 	git repack -a -d
> 
> and *poof* no foo.

Exactly. 

I thought people realized this, but apparently sometimes it's just an 
intellectual understanding of what something does, without realizing what 
that thing actually _means_ in a deeper way.

			Linus
