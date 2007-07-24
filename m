From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: http git clone memory problem.
Date: Tue, 24 Jul 2007 13:13:50 -0700
Message-ID: <1621f9fa0707241313m7d975388gac677cb1314a87a2@mail.gmail.com>
References: <1621f9fa0707232044j7cec2bes7bc7cd268775ce48@mail.gmail.com>
	 <Pine.LNX.4.64.0707241025450.14781@racer.site>
	 <1621f9fa0707240958y7c5f1b66lbfa940d60c082067@mail.gmail.com>
	 <1621f9fa0707241033l7ac53b97i8c8ea068be0cba2f@mail.gmail.com>
	 <Pine.LNX.4.64.0707241842270.14781@racer.site>
	 <1621f9fa0707241053i23f0e3d4v4a1d50f5a4c5f9e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDQlf-0004QL-Ax
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbXGXUNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbXGXUNx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:13:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:34283 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbXGXUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 16:13:51 -0400
Received: by wr-out-0506.google.com with SMTP id i30so1337699wra
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 13:13:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGSzfZVlzFeSQA0v4UkBJQU0J70Kdf6Mj4zCvomudZMwQaPmqls5xKWqmnL/cFBGkNZsazHfNw6OWppSAagz+k+pCQtenGJqsxYggTPgGDOQCidXTy+KNyxTpAEqmQeUMdLuqJv//4yGmHa3CqNsOEjx5g6N+QkyPNfLXRtvf/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QcwpUz5H73vTNOeeLHJGUzmxkQRFt1AzmYVltZRPBmTGQYf6p9xgvmCUUG/vhTVsWnTO2RRK5dYZnuY7LDqqwfbmzUzjwdz15jt7EDi1OKk+Hz8Ch+eytQjd65pkBhybvszMZlhTsbPify3lXAm/dxHwUkxjWXajW6CwGywAc9w=
Received: by 10.142.187.2 with SMTP id k2mr364744wff.1185308030059;
        Tue, 24 Jul 2007 13:13:50 -0700 (PDT)
Received: by 10.143.19.17 with HTTP; Tue, 24 Jul 2007 13:13:50 -0700 (PDT)
In-Reply-To: <1621f9fa0707241053i23f0e3d4v4a1d50f5a4c5f9e6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53636>

It's pretty random actually. Sometimes it ends like this:

Getting pack ffecdbabefeb7d684650f6c920c53c384bc65b5e
 which contains f6c066fe62e97e3d93d10628318fe62de667b25b
got 12192695f4e402f7385728f14496ab807caeb0b8
error: File 33da1ff3b31eee2635cb105a5b15fab3362f6af7 has bad hash
error: Unable to find 33da1ff3b31eee2635cb105a5b15fab3362f6af7 under
http://www.kernel.org/pub/scm/git/git.git
Cannot obtain needed blob 33da1ff3b31eee2635cb105a5b15fab3362f6af7
while processing commit a196f6d93a21ebac9befc4b52a2b0586471b5fa4.

with no crash.

And sometimes with
Getting index for pack ffecdbabefeb7d684650f6c920c53c384bc65b5e
*** glibc detected *** git-http-fetch: corrupted double-linked list:
0x080a4360 ***

Is there a way to reproduce the crash with this
"ffecdbabefeb7d684650f6c920c53c384bc65b5e", the pack id (the sha1) ?

Benjamin.

A strace version of the crash:


I tried valgrind once but after 30 minutes nothing happened, I could
not even see the process with ps ...
I also tried strace.

A strace version of the cannot obtain needed blob:
got 7579c7107c6b5387fe1e30a0969dcb65d22e4cbf
walk abb503d1fc5802e5de9d5b4a0cb710e87d2b1ba4
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git
Getting pack list for http://www.kernel.org/pub/scm/git/git.git
Getting pack 4146ab3638605f4b364bcf90d377e22c083a3d35
 which contains eb7afba88c1bb4d755d23ca3aafe6d0874b848d0
got da5044940771800d0c7f0f28f269c40297860764
got 39af6c9c8112607fb780f3361c5362f587ab629f
got e3859e2a8a4ff8b9c51e1ebe430fa5bf0fd3d261
got 1ea0f745bd0996e7f30e07f472b79ca0ed578510
got c4bb30d92e0156760d07ebcc3bb3d637aebe9606
got 81536ec1557d84897ebb8565597ef7647fc770b9
error: Unable to find 11ea73c1cc3565eeabff27ef2d3619a5fb5381fd under
http://www.kernel.org/pub/scm/git/git.git
Cannot obtain needed blob 11ea73c1cc3565eeabff27ef2d3619a5fb5381fd
while processing commit abb503d1fc5802e5de9d5b4a0cb710e87d2b1ba4.
Waiting for http://www.kernel.org/pub/scm/git/git.git/objects/29/d8eccef4b9cf30704eaa6428131d788675dad8
got c1c7267135b50ebc653e2c16a73ba3e5c454e1e8
got 2623ef30134cc3f2cf715ba302c3cfa2b3527a48
got 29d8eccef4b9cf30704eaa6428131d788675dad8
[{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 20387
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xbfd1ba08, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {0x808d1b0, [], 0}, {0x807ada0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64("/home", {st_mode=S_IFDIR|0755, st_size=360, ...}) = 0
stat64("/home/bsergean", {st_mode=S_IFDIR|0711, st_size=7480, ...}) = 0
stat64("/home/bsergean/sandbox", {st_mode=S_IFDIR|0755, st_size=528, ...}) = 0
stat64("/home/bsergean/sandbox/git", {st_mode=S_IFDIR|0755,
st_size=72, ...}) = 0
stat64("/home/bsergean/sandbox/git", {st_mode=S_IFDIR|0755,
st_size=72, ...}) = 0
chdir("/home/bsergean/sandbox")         = 0
stat64("/bin/rm", {st_mode=S_IFREG|0755, st_size=36316, ...}) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=528, ...}) = 0
stat64("/home/bsergean/git/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such
file or directory)
stat64("/home/bsergean/git/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/Trolltech/Qt-4.3.0/bin/rm", 0xbfd1ce1c) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/ccache/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/home/bsergean/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/home/bsergean/bin/Linux/rm", 0xbfd1ce1c) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file or directory)
stat64("/home/bsergean/git/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/Trolltech/Qt-4.3.0/bin/rm", 0xbfd1ce1c) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/ccache/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/home/bsergean/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/home/bsergean/bin/Linux/rm", 0xbfd1ce1c) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file or directory)
stat64("/usr/local/Trolltech/Qt-4.3.0/bin/rm", 0xbfd1ce1c) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/ccache/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/home/bsergean/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/home/bsergean/bin/Linux/rm", 0xbfd1ce1c) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/distcc/bin/rm", 0xbfd1ce1c) = -1 ENOENT (No such file
or directory)
stat64("/usr/bin/rm", 0xbfd1ce1c)       = -1 ENOENT (No such file or directory)
stat64("/bin/rm", {st_mode=S_IFREG|0755, st_size=36316, ...}) = 0
stat64("/bin/rm", {st_mode=S_IFREG|0755, st_size=36316, ...}) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb7dab988) = 20388
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x807ada0, [], 0}, {0x808d1b0, [], 0}, 8) = 0
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 20388
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xbfd1cb18, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {0x808d1b0, [], 0}, {0x807ada0, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
exit_group(1)                           = ?
Process 20362 detached


On 7/24/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Tue, 24 Jul 2007, Benjamin Sergeant wrote:
> >
> > > I still have the segfault with 1.5.2.4. If I try to gdb it, it abort
> > > before I can do anything. Is there an environment variable that I can
> > > set to disable signal handling or something in git ?
> >
> > Did you gdb http-fetch?
> >
> > If not, please use "sh -x git-clone..." to find out what command line to
> > use.
> >
> > And when you have the command line, please use valgrind to find out where
> > the leak/corruption is.
> >
> > There are some flags that are automatically set/unset when compiling the
> > http transport, and it is not easy to know which flags are enabled in your
> > setup.
> >
> > But for starters, you might want to recompile http-fetch without -O2.  My
> > gdb always has problems attributing the correct line, which does not
> > exactly make it easier for me to debug things.  I could imagine your gdb
> > is as annoying.
> >
> > Ciao,
> > Dscho
>
> I got that, but it's not super-usefull ... I will try valgrind instead.
>
> [bsergean@marge1 sandbox]$ gdb /home/bsergean/git/bin/git-clone
> /tmp/corefiles/core.18531
> GNU gdb 6.6-1mdv2007.1 (Mandriva Linux release 2007.1)
> Copyright (C) 2006 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i586-mandriva-linux-gnu"...
> "/home/bsergean/git/bin/git-clone": not in executable format: File
> format not recognized
> (no debugging symbols found)
> Using host libthread_db library "/lib/i686/libthread_db.so.1".
> Core was generated by `git-http-fetch -v -a -w remotes/origin/html
> cc13f556fc72f6f0670e61599363f6e3277'.
> Program terminated with signal 6, Aborted.
> #0  0xbfffe410 in __kernel_vsyscall ()
> (gdb) where
> #0  0xbfffe410 in __kernel_vsyscall ()
> #1  0xb7c78590 in ?? ()
> #2  0xb7d7aff4 in ?? ()
> #3  0xb7bd7aa0 in ?? ()
> #4  0xbf928f84 in ?? ()
> #5  0xb7c79e21 in ?? ()
> #6  0x00000006 in ?? ()
> #7  0xbf928ef8 in ?? ()
> #8  0x00000000 in ?? ()
>
>
>
>
>
> >
> >
>
