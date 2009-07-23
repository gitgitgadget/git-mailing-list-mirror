From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 19:28:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221925100.3352@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain> <alpine.LFD.2.01.0907221753290.3352@localhost.localdomain>
 <20090723020238.GA8948@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 04:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTo3g-0008Nh-4h
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 04:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbZGWC3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 22:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZGWC3O
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 22:29:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52237 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752728AbZGWC3O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 22:29:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N2SeTV031423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 19:28:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N2Se0m017721;
	Wed, 22 Jul 2009 19:28:40 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090723020238.GA8948@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123824>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> 
> Is there another way to check what is going on with that anomalous lstat()?

I really don't think it's the lstat any more. Your directories look small 
and simple, and clearly the indexing made no difference.

See earlier email about using "strace -T" instead of "-tt". Also, I sent 
you a patch to try out just a minute ago, I think that may be it.

> [ perhaps I will try 'perf' after I read how to use it ]

I really like 'perf' (it does what oprofile did for me, but without the 
headaches), but it doesn't help with IO profiling.

I've actually often wanted to have a 'strace' that shows page faults as 
special system calls, but it's sadly nontrivial ;(

			Linus
