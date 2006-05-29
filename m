From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Make git-diff-tree indicate when it flushes
Date: Tue, 30 May 2006 08:02:25 +1000
Message-ID: <17531.28529.215905.856397@cargo.ozlabs.ibm.com>
References: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
	<7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkpov-0004Tc-TU
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWE2WCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWE2WCj
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:02:39 -0400
Received: from ozlabs.org ([203.10.76.45]:50328 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751418AbWE2WCi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 18:02:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7915567A62; Tue, 30 May 2006 08:02:37 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20983>

Junio C Hamano writes:

> Paul Mackerras <paulus@samba.org> writes:
> 
> > There are times when gitk needs to know that the commits it has sent
> > to git-diff-tree --stdin did not match, and it needs to know in a
> > timely fashion even if none of them match.  At the moment,
> > git-diff-tree outputs nothing for non-matching commits, so it is
> > impossible for gitk to distinguish between git-diff-tree being slow
> > and git-diff-tree saying no.
> 
> Wouldn't this help?
> 
> 	$ git-diff-tree --stdin --always

On the git.git tree:

$ cat revs
65aadb92a1ce9605fa2f412b51de91781a3ef3d6
cc189c2ca2c725c430f100f61e7c4a6849f93163
$ git diff-tree -r -s --stdin -- apply.c <revs
65aadb92a1ce9605fa2f412b51de91781a3ef3d6
$ git diff-tree -r -s --stdin --always -- apply.c <revs
65aadb92a1ce9605fa2f412b51de91781a3ef3d6
cc189c2ca2c725c430f100f61e7c4a6849f93163
$

With --always, how do I tell that 65aadb affects apply.c and cc189c
doesn't?

Paul.
