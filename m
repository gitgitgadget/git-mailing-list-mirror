From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 11:45:09 -0700
Message-ID: <20080428114509.240ef4ae.akpm@linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
	<20080427124454.6a606305.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:47:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYN5-0002gn-SU
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934955AbYD1Spt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935869AbYD1Sps
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:45:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37920 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934955AbYD1Spl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 14:45:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SIj9iY014497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 11:45:11 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3SIj9Za009481;
	Mon, 28 Apr 2008 11:45:09 -0700
In-Reply-To: <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.806 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80581>

On Sun, 27 Apr 2008 13:24:08 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sun, 27 Apr 2008, Andrew Morton wrote:
> > 
> > But I'm pretty sure that the simple solutions were found wanting, but I
> > don't recall why.  I think it was because of a problem when
> > git-netdev-all is based on git-net which is based on origin.  I want to
> > extract the git-net -> git-netdev-all diff, but doing that generates
> > patches which reapply things which are already applied.
> 
> Well, if a tree has patches that are already applied up-stream, then yes, 
> you do actually have to do the merge in order to see that. Because 
> obviously the diff is in two places, and if they merge cleanly, one of 
> them has to be made to not count.
> 
> So it depends on what you want.
> 
> 	git diff a...b
> 
> says literally "what has been added to 'b' since it diverged from 'a'". 
> 
> That is a useful and valid thing to ask, but it is very fundamentally also 
> *not* the same thing as actually doing the merge, and asking what the 
> merge added. Doing
> 
> 	git merge --no-commit otherbranch
> 	git diff HEAD > diff
> 	git reset --hard
> 
> will do that: it will do the merge (which obviously squashes any diffs 
> that existed in the other tree as different commits), and then diffs the 
> HEAD against that resulting state.
> 

hm, weirdness.

y:/usr/src/git26> git-diff origin...git-ia64   
y:/usr/src/git26> git-log origin...git-ia64 | wc -l
15574

I'd have expected git-log to operate on the same patches as git-diff.

I'm sure there's a logical explanation for this ;)
