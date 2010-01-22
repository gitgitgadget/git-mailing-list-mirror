From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 19:58:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211950480.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:58:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYAfa-0002HI-8q
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab0AVD6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 22:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069Ab0AVD6q
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:58:46 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36721 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077Ab0AVD6q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 22:58:46 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M3wDgf017343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 19:58:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M3wDEn015216;
	Thu, 21 Jan 2010 19:58:13 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137734>



On Thu, 21 Jan 2010, Linus Torvalds wrote:
> 
> It's not just that one file either. I get:
> 
> 	[torvalds@nehalem git]$ du -s /home/torvalds/libexec/git-core
> 	45640	/home/torvalds/libexec/git-core (before)
> 	33508	/home/torvalds/libexec/git-core (after)
> 
> so we're talking 12MB of diskspace here. 

Btw, with the few built-in patches I've sent, it's now

	[torvalds@nehalem git]$ du -s /home/torvalds/libexec/git-core
	27876	/home/torvalds/libexec/git-core

so they're worth about 5.5M of disk-space.

Of course, without debugging and with -Os, the difference is much smaller, 
and libexec ends up being "just" 8.6MB in size. There are still a number 
of trivial programs that could be made builtin.

Optimally, I suspect just things like 'git-daemon' and the remote helpers 
would be actual separate binaries.

		Linus
