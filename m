From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] combine-diff: add safety check to --cc.
Date: Thu, 2 Feb 2006 15:03:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
 <Pine.LNX.4.64.0602012353130.21884@g5.osdl.org> <Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
 <7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net> <7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Len Brown <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 00:04:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4nUt-000071-A9
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 00:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWBBXEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 18:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBBXEM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 18:04:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53931 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751120AbWBBXEL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 18:04:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k12N33DZ007193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 15:03:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k12N32uJ012101;
	Thu, 2 Feb 2006 15:03:02 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15519>



On Thu, 2 Feb 2006, Junio C Hamano wrote:
>
> The earlier change implemented "only two version" check but
> without checking if the change rewrites from all the parents.
> This implements a check to make sure that a change introduced
> by the merge from all the parents is caught to be interesting.

Ok, my testing shows that this is all wonderful.

In fact, git-diff-tree now gets the subtle cases right for things that 
"gitk" for some reason gets wrong. I haven't figured out what's wrong with 
gitk, but I don't think it's even worth it: it would be better to just 
teach gitk to use git-diff-tree --cc.

And now when I look at Len's "Merge from hell", not only does it take less 
than 2 seconds for git-diff-tree to calculate, it looks correct too. At 
least I don't see anything that I consider extraneous, although it might, 
of course, have removed too much, and I'd not notice. But it looks great 
(well, as great as it can look without colorization and/or years of 
experience with it - multi-way diffs really aren't very readable ;)

Paul, I'm not able to do something like this in tcl/tk, but could you look 
at trying to make gitk use "git-rev-list --cc" for the colorization?

			Linus
