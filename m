From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 17:39:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807031735330.2815@woody.linux-foundation.org>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org> <20080703223949.GA23092@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZM2-0003Tk-Rw
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYGDAjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYGDAjy
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:39:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56303 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753946AbYGDAjx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 20:39:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m640dj8X022886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jul 2008 17:39:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m640dixv003090;
	Thu, 3 Jul 2008 17:39:45 -0700
In-Reply-To: <20080703223949.GA23092@old.davidb.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.366 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87348>



On Thu, 3 Jul 2008, David Brown wrote:
> 
> I'm still not clear how the one-commit-at-a-time resolution gets recorded
> anywhere (except in the cherry-picking branch).

For merges, the _only_ thing that matters from a "resolution" standpoint 
is that the history joins together. And it doesn't matter if it joins 
together fifty times or once - only the last point is relevant, since that 
becomes the last point of shared state.

> It seems to be that I would need to do multiple merges, one at each point
> where there is a conflict that I had to resolved.  I would remember this as
> I did each cherry picked change, but after the fact, I would have to
> compare the cherry picked change with the one it came from, and figure out
> where conflicts had to be resolved.

No, because you simply don't care. You only care about the final result. 
With a single merge, there is only a single merge-point, and a single 
result. The advantage of doing the cherry-pick is just that it splits the 
decision on how to merge up into many smaller decisions (that is often the 
_dis_advantage of cherry-picking too - it often makes for more work, even 
if the individual work may be simpler).

But once you've done all the small cherry-pick decisions, you'd only make 
one final merge that takes that final result as-is. Any future work will 
then know about the fact that you have a new common base point.

		Linus
