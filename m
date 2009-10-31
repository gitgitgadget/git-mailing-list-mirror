From: Samium Gromoff <_deepfire@feelingofgreen.ru>
Subject: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 01 Nov 2009 01:07:02 +0300 (MSK)
Message-ID: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sun_Nov__1_01_07_02_2009_267)--"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 23:10:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4M9O-00042n-4i
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 23:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbZJaWKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933251AbZJaWKJ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 18:10:09 -0400
Received: from 69-100-st.zelcom.ru ([80.92.100.69]:41920 "HELO
	feelingofgreen.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S932892AbZJaWKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 18:10:08 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2009 18:10:07 EDT
Received: (qmail 6995 invoked from network); 1 Nov 2009 01:07:03 +0300
Received: from unknown (HELO localhost) (80.92.100.69)
  by auriga.feelingofgreen.ru with SMTP; 1 Nov 2009 01:07:03 +0300
X-Mailer: Mew version 6.2.52 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131861>

----Next_Part(Sun_Nov__1_01_07_02_2009_267)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Good day folks,

Attached is the SEGV bugreport I sent to debian.

I tried to convince ld to use /usr/lib/debug, via LD_LIBRARY_PATH,
and run the thing under gdb 7.0, but it won't use debug libraries
for some reason.


regards,
  Samium Gromoff
--
                                 _deepfire-at-feelingofgreen.ru
O< ascii ribbon campaign - stop html mail - www.asciiribbon.org


----Next_Part(Sun_Nov__1_01_07_02_2009_267)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: (qmail 4154 invoked by uid 1000); 1 Nov 2009 00:38:31 +0300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Samium Gromoff <deepfire@feelingofgreen.ru>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Message-ID: <20091031213831.3786.15715.reportbug@auriga.deep> (sfid-20091101_003832_561599_A7C90C6C)
X-Mailer: reportbug 4.8
Date: Sun, 01 Nov 2009 00:38:31 +0300
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) ) MR-27CA1CFB 
X-CRM114-CacheID: sfid-20091101_003832_561599_A7C90C6C 
X-CRM114-Status: GOOD (  29.23  )

Package: git-core
Version: 1:1.6.5-1
Severity: important


Basically,

deepfire@auriga:/$ git peek-remote http://common-lisp.net/project/qitab/git/poiu.git 
Segmentation fault
deepfire@auriga:/$ git peek-remote http://www.lichteblau.com/git/atdoc.git 
Segmentation fault

Strace shows following:
[snip]
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\27\n\7\210!\373\210\265", 8)  = 8
close(3)                                = 0
mprotect(0x7fe055d69000, 16384, PROT_READ) = 0
mprotect(0x7fe055f89000, 4096, PROT_READ) = 0
mprotect(0x7fe0563c2000, 4096, PROT_READ) = 0
munmap(0x7fe0563ae000, 67595)           = 0
set_tid_address(0x7fe0563ac7c0)         = 4047
set_robust_list(0x7fe0563ac7d0, 0x18)   = 0
futex(0x7fff5e3c057c, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0x7fff5e3c057c, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1, NULL, 7fe0563ac6f0) = -1 ENOSYS (Function not implemented)
rt_sigaction(SIGRTMIN, {0x7fe055d78750, [], SA_RESTORER|SA_SIGINFO, 0x7fe055d819a0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x7fe055d787e0, [], SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x7fe055d819a0}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x26d6000
brk(0x26f7000)                          = 0x26f7000
getcwd("/", 4096)                       = 2
stat(".git", 0x7fff5e3c02d0)            = -1 ENOENT (No such file or directory)
access(".git/objects", X_OK)            = -1 ENOENT (No such file or directory)
access("./objects", X_OK)               = -1 ENOENT (No such file or directory)
chdir("..")                             = 0
stat(".git", 0x7fff5e3c02d0)            = -1 ENOENT (No such file or directory)
access(".git/objects", X_OK)            = -1 ENOENT (No such file or directory)
access("./objects", X_OK)               = -1 ENOENT (No such file or directory)
chdir("/")                              = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Segmentation fault


-- System Information:
Debian Release: squeeze/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (1, 'experimental')
Architecture: amd64 (x86_64)

Kernel: Linux 2.6.26-2-amd64 (SMP w/2 CPU cores)
Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)
Shell: /bin/sh linked to /bin/dash

Versions of packages git-core depends on:
ii  libc6                  2.10.1-3          GNU C Library: Shared libraries
ii  libcurl3-gnutls        7.19.5-1.1        Multi-protocol file transfer libra
ii  libdigest-sha1-perl    2.12-1            NIST SHA-1 message digest algorith
ii  liberror-perl          0.17-1            Perl module for error/exception ha
ii  libexpat1              2.0.1-4           XML parsing C library - runtime li
ii  perl-modules           5.10.1-6          Core Perl modules
ii  zlib1g                 1:1.2.3.3.dfsg-15 compression library - runtime

Versions of packages git-core recommends:
ii  less                          436-1      pager program similar to more
ii  openssh-client [ssh-client]   1:5.1p1-8  secure shell client, an rlogin/rsh
ii  patch                         2.5.9-5    Apply a diff file to an original
ii  rsync                         3.0.6-1    fast remote file copy program (lik

Versions of packages git-core suggests:
pn  git-arch                      <none>     (no description available)
ii  git-cvs                       1:1.6.5-1  fast, scalable, distributed revisi
ii  git-daemon-run                1:1.6.5-1  fast, scalable, distributed revisi
pn  git-doc                       <none>     (no description available)
pn  git-email                     <none>     (no description available)
ii  git-gui                       1:1.6.5-1  fast, scalable, distributed revisi
ii  git-svn                       1:1.6.5-1  fast, scalable, distributed revisi
ii  gitk                          1:1.6.5-1  fast, scalable, distributed revisi
pn  gitweb                        <none>     (no description available)

-- no debconf information

----Next_Part(Sun_Nov__1_01_07_02_2009_267)----
