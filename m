From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Provide a way to flush git-diff-tree's output
Date: Thu, 18 May 2006 19:43:01 +1000
Message-ID: <17516.16805.281168.662330@cargo.ozlabs.ibm.com>
References: <17516.6955.282732.460675@cargo.ozlabs.ibm.com>
	<7vmzdf6bj5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 11:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgf2P-0003fp-JQ
	for gcvg-git@gmane.org; Thu, 18 May 2006 11:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWERJnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 05:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWERJnT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 05:43:19 -0400
Received: from ozlabs.org ([203.10.76.45]:41873 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751137AbWERJnS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 05:43:18 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B8D15679F5; Thu, 18 May 2006 19:43:17 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzdf6bj5.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20279>

Junio C Hamano writes:

> Sounds low impact and sane.
> 
> I suspect the usual caveat on bidirectional pipe deadlock
> applies to the caller.  Does gitk do that?  The current code

Gitk will use non-blocking mode on the pipes to/from the git-diff-tree
process, so there isn't a possibility of deadlock that I can see.

> seems to feed a pre-generated list with "open | cmd <<"
> construct to the command, so perhaps you are planning to change
> that?

That's for the "Find" function.  I'm in the process of adding the code
to let users enter a list of paths and have gitk highlight the commits
affecting those paths.  That will involve a separate invocation of
git-diff-tree.  To make it responsive, I'm only going to ask
git-diff-tree about the commits that are visible on the screen - but I
need git-diff-tree to give me an answer quickly, i.e. in less time
than a human can perceive.

Thanks,
Paul.
