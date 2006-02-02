From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Thu, 02 Feb 2006 00:27:36 -0800
Message-ID: <7v3bj2tbbb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
	<Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
	<cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 09:27:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Zod-0000H1-0u
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 09:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423377AbWBBI1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 03:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423378AbWBBI1k
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 03:27:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49796 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1423377AbWBBI1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 03:27:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202082743.CNEA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 03:27:43 -0500
To: Aneesh Kumar <aneesh.kumar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15497>

Aneesh Kumar <aneesh.kumar@gmail.com> writes:

> Ok i tried using --cc. But then as per the man page if the
> optimization makes the all the hunks disapper then commit log is not
> show unless -m is used. Is there a way to get the commit log printed.

Yes, there is a way.  I need to fix a bug ;-).

This patch was done on top of the other two patches I sent
earlier tonight, but should apply on top of master even if you
have not applied the other two.

--

diff --git a/combine-diff.c b/combine-diff.c
index 44931b2..45f1822 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -675,6 +675,8 @@ int diff_tree_combined_merge(const unsig
 					       show_empty_merge))
 				header = NULL;
 		}
+		if (header)
+			puts(header);
 	}
 
 	/* Clean things up */
