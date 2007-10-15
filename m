From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 06:12:55 +0200
Message-ID: <u4pgtj9rs.fsf@gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>
	<1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site> 
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site> 
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
	<4712B616.165BBF8D@dessent.net>
	<Pine.LNX.4.64.0710150217120.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: ae@op5.se, raa.lkml@gmail.com, git@vger.kernel.org, make-w32@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 06:13:13 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhHKK-00084c-E6
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 06:13:12 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhHKD-0007A5-9E
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 00:13:05 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhHK8-00079w-Px
	for make-w32@gnu.org; Mon, 15 Oct 2007 00:13:00 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhHK7-00079L-9c
	for make-w32@gnu.org; Mon, 15 Oct 2007 00:13:00 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhHK6-00079B-Vl
	for make-w32@gnu.org; Mon, 15 Oct 2007 00:12:59 -0400
Received: from heller.inter.net.il ([213.8.233.23])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <eliz@gnu.org>) id 1IhHK6-0006gq-LZ
	for make-w32@gnu.org; Mon, 15 Oct 2007 00:12:58 -0400
Received: from HOME-C4E4A596F7 (IGLD-84-229-224-70.inter.net.il
	[84.229.224.70]) by heller.inter.net.il (MOS 3.7.3a-GA)
	with ESMTP id DVY97264 (AUTH halo1);
	Mon, 15 Oct 2007 06:12:55 +0200 (IST)
In-reply-to: <Pine.LNX.4.64.0710150217120.25221@racer.site> (message from
	Johannes Schindelin on Mon, 15 Oct 2007 02:22:53 +0100 (BST))
X-detected-kernel: by monty-python.gnu.org: FreeBSD 4.7-5.2 (or MacOS X
	10.2-10.4) (2)
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60941>

> Date: Mon, 15 Oct 2007 02:22:53 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Eli Zaretskii <eliz@gnu.org>, Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, 
>     tsuna@lrde.epita.fr, make-w32@gnu.org
> 
> > You can achieve the same thing on Windows with CreateFile() by setting 
> > the dwShareMode parameter to zero and setting the 
> > FILE_FLAG_DELETE_ON_CLOSE attribute on dwFlagsAndAttributes.  This 
> > results in a file that cannot be opened or read by any other process and 
> > that will be automatically deleted when all open handles are closed.
> 
> Aha.  So to support Windows, we have to wrap all sites that use that 
> trick, and special case that #ifdef __MINGW32__. 

No, you need to think in abstractions rather than POSIX-isms, and then
let each platform implement those abstractions as appropriate.

> > > I think Alex means this: you can have C:\a\b\c and D:\a\b\c.  So 
> > > depending on which drive you are, you mean one or the other.  Just 
> > > comparing the paths is not enough.
> > 
> > This just means that you have to consider the drive letter as part of 
> > the filename.
> 
> So to support Windows, we have to special case having a ":" as second 
> character in the filename.

No, you need to think abstractions like `absolute_file_name' and
`dir_separator'.

> > > > > - no real "mmap" (which kills perfomance and complicates code)
> > > >
> > > > You only need mmap because you are accustomed to use it on GNU/Linux.
> > > 
> > > Yes.  And we rely on the performance very much.
> > 
> > Windows may not call it mmap() but it most certainly has memory-mapped
> > file IO:
> > <http://msdn2.microsoft.com/en-us/library/aa366781.aspx#file_mapping_functions>.
> 
> Yes, but there are still incompatibilities with POSIX.

Stop thinking POSIX.  Think abstractions that are common to POSIX and
non-POSIX systems.  If you think POSIX, don't be surprised that it
won't port.

> Again, when you did not close the file, you cannot delete (or
> rename) it.

Yes, you can, nowadays.  But that doesn't mean it was TRT to use such
dirty tricks to implement temporary files or security.  One needs to
think in abstractions again, and leave the implementation to each
platform.

> All this supporting Windows business is certainly possible, if tedious.

Only if the program was written with disregard to anything but POSIX.
