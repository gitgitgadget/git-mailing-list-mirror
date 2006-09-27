From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 14:01:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271354480.3952@g5.osdl.org>
References: <20060927204428.39120.qmail@web51014.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 23:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSgXl-0000uz-Es
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030847AbWI0VCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030851AbWI0VCF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:02:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030847AbWI0VCE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 17:02:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RL1tnW026811
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 14:01:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RL1sRK016649;
	Wed, 27 Sep 2006 14:01:54 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927204428.39120.qmail@web51014.mail.yahoo.com>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27932>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
> 
> What is the difference between a merge and a "merge then pushed out"?

To answer just this technical question, which came up today:

 - I might do a merge at 8:30 in the morning, but since I do it on my 
   machine, and nobody else actually saw my merge.

 - at 9:30, somebody sends me a patch that I already have (through the 
   merge), and I reply saying "I got this already", but I realize I 
   haven't pushed it out.

 - so I replicate my home machine tree to the one on master.kernel.org, 
   and now others can see it.

When did the merge happen? It happened at 8:30 on my machine, and that's 
what is recorded. End of story. No ifs, buts, maybes about it. That's the 
only time you can _ever_ see for that merge.

When did everybody else see it? It only became _visible_ in the git 
archive on kernel.org at 9:30, when I pushed out _all_ the merges that I 
had done (some of them at 8:30, others at 8:00, yet others perhaps at some 
other time).

So all those different merges, which were done at different times, only 
became visible in another git repository all at the same time, at 9:30.

There's _zero_ commits or merges that themselves happened at 9:30. There's 
no development at all that happened then. The only actual thing that 
changed at 9:30 was that the _reference_ that made all those old changes 
visible finally made it to the repository at kernel.org.

This is why you can use the ref-logging code to say "Ok, how did my 
repository look at 9:25 vs 9:35" and you could see the difference. BUT NO 
ACTUAL COMMIT OR MERGE WILL EVER HAVE THAT TIMESTAMP. That's purely a 
"when did it show up" question, and the whole question only makes sense 
within a particular repository (ie the answers are different: on _my_ 
machine, a merge showed up on 8:30 when it was made. On other machines, 
the time will always be different).

		Linus
