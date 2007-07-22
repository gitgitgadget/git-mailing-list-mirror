From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Sun, 22 Jul 2007 12:09:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707221205080.3607@woody.linux-foundation.org>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgnq-0000u8-JG
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761790AbXGVTJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761527AbXGVTJK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:09:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39857 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759610AbXGVTJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 15:09:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MJ96ZK019758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 12:09:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MJ91x8018978;
	Sun, 22 Jul 2007 12:09:01 -0700
In-Reply-To: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53296>



On Sun, 22 Jul 2007, Jon Smirl wrote:
>
> It would really be useful if git diff had an option for suppressing
> diffs caused by CVS keyword expansion.

I really think it's not a "git diff" issue, but it might be a "import" 
issue.

IOW, I think you'd be a *lot* better off just not importing those things 
in the first place (which is what CVS does internally), or possibly 
importing them as two trees (ie you'd have the "non-log" version and the 
"log expansion" version, so that you can track and compare both).

Doing the thing at "diff" time is certainly possible, but this is simply 
much better done as a totally independent preprocessing phase. The diff 
handling is already some of the more complex parts (and very central), it 
would be much simpler and efficient to not try to make that thing fancier, 
and instead solve the problem at the front-end.

			Linus
