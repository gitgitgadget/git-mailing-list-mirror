From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 13:36:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org>
 <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MURXt-00041c-E4
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 22:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZGXUhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbZGXUhF
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 16:37:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60222 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754136AbZGXUhD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 16:37:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6OKaD1u030422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Jul 2009 13:36:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6OKaDvP003810;
	Fri, 24 Jul 2009 13:36:13 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090723195548.GA28494@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123943>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
>
> After 7 tests I got these, 
> 
> time:
> 
>       0.61 +/- 0.08

Btw, I think 0.61s is still too much. Can you send me the output of 
'strace -Ttt' on your machine?

It's entirely possible that it's all the actual binary (and shared 
library) loading, of course. You do have a slow harddisk. But it takes 
0.035s for me, and I'm wondering if there is something else than just CPU 
speed and IO speed accounting for the 20x performance difference.

(That said, maybe 20x is right - my SSD latency almost certainly is 20x 
better).

			Linus
