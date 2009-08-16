From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linus' sha1 is much faster!
Date: Sun, 16 Aug 2009 13:10:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908161306340.3162@localhost.localdomain>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bug-coreutils@gnu.org, =?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigBrady.com>,
	Git Mailing List <git@vger.kernel.org>
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org Sun Aug 16 22:10:56 2009
Return-path: <bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org>
Envelope-to: gcgcb-bug-coreutils-616@gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcm47-0004JY-5i
	for gcgcb-bug-coreutils-616@gmane.org; Sun, 16 Aug 2009 22:10:55 +0200
Received: from localhost ([127.0.0.1]:32812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Mcm46-0006dw-8U
	for gcgcb-bug-coreutils-616@gmane.org; Sun, 16 Aug 2009 16:10:54 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Mcm44-0006dr-DV
	for bug-coreutils@gnu.org; Sun, 16 Aug 2009 16:10:52 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Mcm3z-0006de-Pn
	for Bug-coreutils@gnu.org; Sun, 16 Aug 2009 16:10:52 -0400
Received: from [199.232.76.173] (port=45543 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Mcm3z-0006db-Ip
	for Bug-coreutils@gnu.org; Sun, 16 Aug 2009 16:10:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38193)
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.60)
	(envelope-from <torvalds@linux-foundation.org>)
	id 1Mcm3x-0008Vq-1A; Sun, 16 Aug 2009 16:10:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id n7GKAKue028717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Aug 2009 13:10:21 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	n7GKAKdH003198; Sun, 16 Aug 2009 13:10:20 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <87eirbef3c.fsf@master.homenet>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126071>



On Sun, 16 Aug 2009, Giuseppe Scrivano wrote:
> 
> My GCC version is "gcc (Debian 4.3.3-14) 4.3.3" and the CPU is: Intel(R)
> Pentium(R) D CPU 3.20GHz.

Netburst is very sensitive to random spill effects, and you can basically 
tune things by just code shuffling that just has random effects on the 
generated asm code.

> I also spent some time trying to improve the gnulib SHA1 implementation
> and it seems a lookup table can improve things a bit.

I pretty much can guarantee you that it improves things only because it 
makes gcc generate crap code, which then hides some of the P4 issues.

I'd also suggest you try gcc-4.4, since that apparently fixes some of the 
oddest spill issues.

			Linus
