From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Fri, 10 Aug 2007 12:39:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101231580.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: moe <moe-git@mbox.bz>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:39:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJaKx-0004Ww-Bc
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758327AbXHJTjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760458AbXHJTjw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:39:52 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52857 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758327AbXHJTjv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 15:39:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJdlbx003423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 12:39:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJdgXr005042;
	Fri, 10 Aug 2007 12:39:42 -0700
In-Reply-To: <20070809163026.GD568@mbox.bz>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.23__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55571>



On Thu, 9 Aug 2007, moe wrote:
> 
> earlier today i imported one of my larger trees
> (~70k files) into git and was quite disappointed
> by the performance.

Ok, I said I wouldn't have time to fix it yesterday, but today it's all 
done.

With the first fix from Junio yesterday (the one that fixed "git status"), 
and the fixes I've sent out today, your cases should not all be basically 
instantaneous (ie we're talking low seconds, even on not-the-fastest- 
possible-machines).

So with the following patches that were posted over the last 24 hours, you 
should be ok:

  Junio:
	Fix performance problem in "git status"

  Me:
	Start moving unpack-trees to "struct tree_desc"
	Fix "git commit directory/" performance anomaly (+ one-liner fix)
	Move old index entry removal from "unpack_trees()" into the individual functions
	Optimize the common cases of git-read-tree
	Optimize the two-way merge of git-read-tree too

(that patch from Junio was sent in an email in this thread, with the 
subject line "Re: git and larger trees, not so fast?" and a message ID of 
"<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>": the patches from me should 
all have the appropriate Subject lines and be findable that way).

If you can test with your real load to make sure, that would be good.

			Linus
