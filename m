From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Tue, 10 May 2005 00:46:10 +0200
Message-ID: <7ipsw010i5.fsf@lanthane.pps.jussieu.fr>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
	<20050509212842.GC15712@pasky.ji.cz>
	<7iu0lc129m.fsf@lanthane.pps.jussieu.fr> <427FE248.7040403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@abridgegame.org, Git Mailing List <git@vger.kernel.org>
X-From: darcs-devel-bounces@darcs.net Tue May 10 00:40:15 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGu2-0001DB-9k
	for gcvdd-darcs-devel@m.gmane.org; Tue, 10 May 2005 00:39:06 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DVH0y-0003bA-DI; Mon, 09 May 2005 18:46:16 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DVH0w-0003b5-Vv
	for darcs-devel@abridgegame.org; Mon, 09 May 2005 18:46:15 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j49Mk0t0001022
	; Tue, 10 May 2005 00:46:00 +0200 (CEST)
X-Ids: 164
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j49MkAFc025045 ; Tue, 10 May 2005 00:46:10 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DVH0s-0007Ne-Qj; Tue, 10 May 2005 00:46:10 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427FE248.7040403@zytor.com> (H. Peter Anvin's message of "Mon,
	09 May 2005 15:20:56 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.164]);
	Tue, 10 May 2005 00:46:00 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427FE828.000 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

>> I see.  Let me know if you decide to use a different name for the
>> lock file so I can switch to using the same one as yours.

> Are you using flock(), or some other contraption that breaks if a
> process dies unexpectedly?

No, I'm using a file that is created by the NFS-safe equivalent of
open(O_CREAT | O_EXCL).  This is what Darcs has been doing basically
forever.

Darcs usually doesn't die unexpectedly -- it's a Haskell program, so
bugs usually manifest themselves with an exception being thrown
allowing Darcs to clean-up after itself.

The one exception is when Darcs gets killed by the OOM killer (which,
as you doubtless know, doesn't give any advance warning to a process,
thus making it impossible for a process to deal with it gracefully).
In such cases, manual intervention is necessary anyway -- a file could
have been written half-way.

                                        Juliusz
