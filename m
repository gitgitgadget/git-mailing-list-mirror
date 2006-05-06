From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 09:30:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
 <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
 <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 18:31:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcPgT-0001g6-IL
	for gcvg-git@gmane.org; Sat, 06 May 2006 18:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWEFQbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 12:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWEFQbB
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 12:31:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750902AbWEFQbA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 12:31:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k46GUotH020433
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 May 2006 09:30:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k46GUmHt001346;
	Sat, 6 May 2006 09:30:49 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19661>



On Sat, 6 May 2006, sean wrote:
> 
> Wondering why you feel so strongly that most "users" shouldn't be real people.
> What is wrong with continuing to make git easier for developers to use without
> needing any extra software?

Basically, it boils down to the end result.

If you design things for "people", then things tend to become hard to 
automate, and it's hard to make wrappers around it. Maybe you've even made 
the interfaces interactive, and thus any wrappers around it are simply 
screwed, or need to do insane things.

On the other hand, if you design things for automation, doing a "people 
wrapper" that uses the automation should be trivial if the design is even 
remotely any good at all.

In other words: you should always design things for automation, and 
consider the "people interface" to be be just _one_ wrapper layer among 
many.

This has worked really well in git. The whole system was designed from the 
start to be all about scripting and automation, and the "people wrappers" 
tend to be trivial scripts around it.

This was even more obvious when we had a number of basically one-liner 
scripts like "git log", which just did some trivial wrapping around

	git-rev-list | git-diff-tree --stdin | $PAGER

(Now we still have that trivial wrapper, but you just need to look into C 
code to see it, so it's not _as_ obviously trivial).

Contrast this with going the other way: if you talk about the interfaces 
that _people_ want first, you immediately start doing pretty-printing, 
nice parsing, maybe interactive stuff that asks questions. Nice GUIs. And 
the end result is CRAP. Exactly because it lost its ability to be generic.

To some degree, this is the fundamental difference between the Windows and 
the UNIX mindset. At least it used to be.

		Linus
