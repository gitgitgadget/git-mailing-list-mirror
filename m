From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linus' sha1 is much faster!
Date: Sat, 15 Aug 2009 13:54:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain>
References: <4A85F270.20703@draigBrady.com>
	<3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com>
	<43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
	<alpine.LFD.2.01.0908151315400.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Kocher <paul@paulkocher.com>, Bryan Donlan <bdonlan@gmail.com>,
	Bug-coreutils@gnu.org, Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigbrady.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org Sat Aug 15 22:55:12 2009
Return-path: <bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org>
Envelope-to: gcgcb-bug-coreutils-616@gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McQHN-0007gQ-Ri
	for gcgcb-bug-coreutils-616@gmane.org; Sat, 15 Aug 2009 22:55:10 +0200
Received: from localhost ([127.0.0.1]:39166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1McQHM-0004Sd-Q0
	for gcgcb-bug-coreutils-616@gmane.org; Sat, 15 Aug 2009 16:55:08 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1McQHK-0004SX-RK
	for bug-coreutils@gnu.org; Sat, 15 Aug 2009 16:55:06 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1McQHE-0004SI-VP
	for Bug-coreutils@gnu.org; Sat, 15 Aug 2009 16:55:06 -0400
Received: from [199.232.76.173] (port=48622 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1McQHE-0004SF-MF
	for Bug-coreutils@gnu.org; Sat, 15 Aug 2009 16:55:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33924)
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.60)
	(envelope-from <torvalds@linux-foundation.org>) id 1McQHD-0005gW-Uj
	for Bug-coreutils@gnu.org; Sat, 15 Aug 2009 16:55:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id n7FKsOE8010163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 13:54:25 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	n7FKsNI7028371; Sat, 15 Aug 2009 13:54:23 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
X-detected-operating-system: by monty-python.gnu.org: GNU/Linux 2.6 (newer, 3)
X-BeenThere: bug-coreutils@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "GNU Core Utilities: bug reports and discussion"
	<bug-coreutils.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-coreutils>
List-Post: <mailto:bug-coreutils@gnu.org>
List-Help: <mailto:bug-coreutils-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=subscribe>
Sender: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Errors-To: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126028>



On Sat, 15 Aug 2009, Linus Torvalds wrote:
> 
> That said, I don't know if the MPL is ok for X11. I've not looked at 
> compatibility issues with MPL. For git, we could just ignore the MPL, 
> since the GPLv2 was acceptable regardless of it.

If MPL isn't ok for X11, then we'd need to make sure that even the 
silliest Mozilla crud has been rewritten. There really isn't much, but 
hey, the _history_ is based on the mozilla code, and who knows - the 
'blk_SHA_CTX' struct has things like the fields in the same order as the 
Mozilla equivalent, for all those historical reasons.

(Heh. Looking at that, I probably should move the 'size' field first, 
since that would have different alignment rules, and the struct would be 
more tightly packed that way, and initialize better).

Afaik, none of the actual code remains (the mozilla SHA1 thing did the 
wrong thing for performance even for just the final bytes, and did those a 
byte at a time etc, so I rewrote even the trivial SHA1_Final parts).

Of course, maybe the Mozilla people would be interested in taking my 
faster version, and say that the new-BSD license is ok, and make everybody 
happy. The only listed author for the Mozilla SHA1 is Paul Kocher. I added 
him to the Cc.

Paul, for your information, we're talking about a faster rewritten "mostly 
portable" SHA1 routines that you can find at

	http://git.kernel.org/?p=git/git.git;a=tree;f=block-sha1;hb=pu

(follow the "blob" pointers to see sha1.c and sha1.h). I don't know if 
you're active with Mozilla/Firefox or whether you even care, but you seem 
to be the logical choice of person to ask.

			Linus
