From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recover broken git index?
Date: Thu, 28 May 2009 14:20:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905281413130.3435@localhost.localdomain>
References: <4A1DB700.4080705@bcm.edu> <4A1E52FD.6090801@op5.se> <4A1E86D7.3060401@bcm.edu> <alpine.LFD.2.01.0905281053030.3435@localhost.localdomain> <4A1EFBE9.7070805@bcm.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Misha Koshelev <mk144210@bcm.edu>
X-From: git-owner@vger.kernel.org Thu May 28 23:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9n1d-0001N6-EK
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764066AbZE1VUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760302AbZE1VUY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:20:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41105 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763387AbZE1VUW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 17:20:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4SLKHDK008097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2009 14:20:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4SLKGLQ018048;
	Thu, 28 May 2009 14:20:16 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A1EFBE9.7070805@bcm.edu>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120231>



On Thu, 28 May 2009, Misha Koshelev wrote:
> 
> Actually it was technically a _clean_ restart on Ubuntu 8.04. I suspect
> there may have been some kind of strange hardware error though as
> computer was very sluggish and BIOS took a while to start up.

You may have had a disk that flaked out (disconnected from the SATA bus or 
something). Sadly, when that happens, the messages obviously don't make it 
to /var/log/messages, but you might have had them in your log when you 
rebooted. Things like

	ata1: device not ready (errno=-16), forcing hardreset
	ata1: hard resetting port
	ata1 SRST failed (errno=-19)
	ata1: reset failed (errno=-19), retrying in 10 secs
	...

and sometimes the problem doesn't go away until power is actually 
disconnected, or a hard reset is performed.

It could be a one-time event, but it could also be a sign of something bad 
going on with the disk. Since you likely don't have any messages anywhere, 
it's hard to even guess what is going on. But your symptoms are consistent 
with that (sluggish simply because some things try to read or write to 
disk and will fail after a _loong_ timeout, and BIOS taking a while to 
start up because it probably does some really fundamental reset thing to 
get the controller back)..

Of course, that's just a guess. 

		Linus
