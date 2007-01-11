From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 01:47:14 -0800
Message-ID: <7vsleh51zx.fsf@assigned-by-dhcp.cox.net>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
	<7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701110949421.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wWz-0001fe-Ji
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbXAKJrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbXAKJrb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:47:31 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47638 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965333AbXAKJra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:47:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111094729.YQZI29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 04:47:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9lme1W00e1kojtg0000000; Thu, 11 Jan 2007 04:46:39 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701110949421.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 11 Jan 2007 09:53:34 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36569>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW I am not quite sure if you missed this patch: 
> http://thread.gmane.org/gmane.comp.version-control.git/36212/, or if you 
> did not like it, want enhancements, ...

It is still sitting in my in-box; I tend to agree with Shawn in
that mixing the reflog sequence and true parenthood in the same
traversal is kind of insane.  I vaguely recall you thought
dropping that would make the code simpler, and was kind of
waiting for that to happen to review the results.

Also I did not quite understand your comment about circular log
entries.

When you walk the reflog, the entries are by definition a single
strand of pearls (reflog itself is a flat text file which you
read linearly).  The commits adjacent entries talk about may or
may not be related at all, and two entries may happen to point
at the same commit.  But I do not think the appearance of
another reflog entry in an earlier call to get_revision() should
not cause a reflog entry to be dropped from the output only
because it points at the same commit.
