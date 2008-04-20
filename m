From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 17:31:41 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191727270.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org> <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl> <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org> <2F8F3BF2-66F9-473C-BE82-8F784E1FF9A4@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Apr 20 02:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnNTu-0000i7-WB
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 02:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbYDTAbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 20:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYDTAbt
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 20:31:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38003 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751314AbYDTAbs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 20:31:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3K0VgMs003749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 17:31:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3K0VfiH007003;
	Sat, 19 Apr 2008 17:31:41 -0700
In-Reply-To: <2F8F3BF2-66F9-473C-BE82-8F784E1FF9A4@ai.rug.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.433 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79941>



On Sun, 20 Apr 2008, Pieter de Bie wrote:
> 
> Yes, I just tested this.
> 
> 	for (int i = 0; i < 50000; i++) {
> 		sprintf(s, "/Users/pieter/test/perf/%i", i);
> 		int ret = lstat(s, a);
> 	}
> 
> This loop needs about 3 seconds to  run. Replacing the i with 10 in the
> sprintf reduces it to 0.24seconds.

Ok.

On my machine, that's

	real    0m0.090s

with the 50,000 different files, and with the same filename it's

	real    0m0.081s

so yes, we're looking at another case of Linux performance just being in a 
class of its own.

Taking three seconds for the warm-cache case for just 50,000 files is 
ludicrous. That's about an order-and-a-half slower than what I see.

Maybe my CPU is faster too (2.66GHz Core 2), but the thing is, Linux 
really does tend to outperform others at a lot of these kinds of loads. 
System calls are fast to begin with, and the Linux directory cache kicks 
ass, if I do say so myself.

OS X doth suck. 

			Linus
