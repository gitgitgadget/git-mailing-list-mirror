From: gitml.jexpert@recursor.net
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Thu, 08 Aug 2013 15:27:12 +0200
Message-ID: <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 15:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7QFM-0006Aw-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 15:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947Ab3HHN1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 09:27:16 -0400
Received: from gourmet7.spamgourmet.com ([216.75.62.102]:55349 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757831Ab3HHN1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 09:27:16 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7QFH-0001kO-NV
	for git@vger.kernel.org; Thu, 08 Aug 2013 13:27:15 +0000
Received: from mail.exxcellent.de ([217.6.238.198])
	by gourmet7.spamgourmet.com with esmtp (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7QFH-0001js-Bk
	for ; Thu, 08 Aug 2013 13:27:15 +0000
In-Reply-To: <vpqli4cfhhe.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231884>

Am 08.08.2013 15:18, schrieb Matthieu Moy - Matthieu.Moy@grenoble-inp.fr:> gitml.jexpert@recursor.net writes:
>> So - now the puzzling thing: With valgrind it seems to work! 
> Weird, indeed. What about GDB ?


Ah - come on. Is this another Heisenberg bug ?
Still trying to reproduce it using gdb and/or valgrind...



ben@n179 /tmp/project.git $ gdb --args ~/projects/git.git/git-fsck
GNU gdb (GDB) 7.5-ubuntu
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /home/ben/projects/git.git/git-fsck...done.
(gdb) run
Starting program: /home/ben/projects/git.git/git-fsck 
warning: no loadable sections found in added symbol-file system-supplied DSO at 0x7ffff7ffa000
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Checking object directories: 100% (256/256), done.
Checking objects: 100% (63588/63588), done.
[Inferior 1 (process 3795) exited normally]
(gdb) quit

ben@n179 /tmp/project.git $ ~/projects/git.git/git-fsck
Checking object directories: 100% (256/256), done.
error: packed 49cdd0b21a351f3366008615d2cf8d03ca943978 from .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack is corrupt
Checking objects: 100% (63588/63588), done.

ben@n179 /tmp/project.git $ ~/projects/git.git/git-fsck
Checking object directories: 100% (256/256), done.
error: packed 49cdd0b21a351f3366008615d2cf8d03ca943978 from .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack is corrupt
Checking objects: 100% (63588/63588), done.

ben@n179 /tmp/project.git $ ~/projects/git.git/git-fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (63588/63588), done.

ben@n179 /tmp/project.git $ ~/projects/git.git/git-fsck
Checking object directories: 100% (256/256), done.
error: packed 0f5f33639bfc1a781fe080c31a1f076d9a25c1d3 from .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack is corrupt
*** glibc detected *** <unknown>: free(): invalid pointer: 0x00007fe129669010 ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7fe162d3eb96]
[0x51e401]
[0x51e53c]
[0x51ecc3]
[0x4e707b]
[0x4e7485]
[0x43d433]
[0x405158]
[0x4052ee]
[0x4054ba]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7fe162ce176d]
[0x404429]
======= Memory map: ========
00400000-005bb000 r-xp 00000000 fc:01 3939047                            /home/ben/projects/git.git/git-fsck
007ba000-007bb000 r--p 001ba000 fc:01 3939047                            /home/ben/projects/git.git/git-fsck
007bb000-007c2000 rw-p 001bb000 fc:01 3939047                            /home/ben/projects/git.git/git-fsck
007c2000-00822000 rw-p 00000000 00:00 0 
02770000-05809000 rw-p 00000000 00:00 0                                  [heap]
7fe129669000-7fe12bc38000 rw-p 00000000 00:00 0 
7fe12dff5000-7fe12e00a000 r-xp 00000000 fc:01 7081526                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7fe12e00a000-7fe12e209000 ---p 00015000 fc:01 7081526                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7fe12e209000-7fe12e20a000 r--p 00014000 fc:01 7081526                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7fe12e20a000-7fe12e20b000 rw-p 00015000 fc:01 7081526                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7fe12e20b000-7fe13e9c1000 r--p 00000000 fc:01 10879034                   /tmp/project.git/.git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack
7fe13e9c1000-7fe162a0b000 r--p 00000000 fc:01 10881032                   /tmp/project.git/.git/objects/pack/pack-5b132454d5acb542969a939fe55186a65d9dd697.pack
7fe162a0b000-7fe162abc000 r--p 00000000 fc:01 10902665                   /tmp/project.git/.git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.idx
7fe162abc000-7fe162abe000 r-xp 00000000 fc:01 7085848                    /lib/x86_64-linux-gnu/libdl-2.15.so
7fe162abe000-7fe162cbe000 ---p 00002000 fc:01 7085848                    /lib/x86_64-linux-gnu/libdl-2.15.so
7fe162cbe000-7fe162cbf000 r--p 00002000 fc:01 7085848                    /lib/x86_64-linux-gnu/libdl-2.15.so
7fe162cbf000-7fe162cc0000 rw-p 00003000 fc:01 7085848                    /lib/x86_64-linux-gnu/libdl-2.15.so
7fe162cc0000-7fe162e75000 r-xp 00000000 fc:01 7085850                    /lib/x86_64-linux-gnu/libc-2.15.so
7fe162e75000-7fe163074000 ---p 001b5000 fc:01 7085850                    /lib/x86_64-linux-gnu/libc-2.15.so
7fe163074000-7fe163078000 r--p 001b4000 fc:01 7085850                    /lib/x86_64-linux-gnu/libc-2.15.so
7fe163078000-7fe16307a000 rw-p 001b8000 fc:01 7085850                    /lib/x86_64-linux-gnu/libc-2.15.so
7fe16307a000-7fe16307f000 rw-p 00000000 00:00 0 
7fe16307f000-7fe163097000 r-xp 00000000 fc:01 7085833                    /lib/x86_64-linux-gnu/libpthread-2.15.so
7fe163097000-7fe163296000 ---p 00018000 fc:01 7085833                    /lib/x86_64-linux-gnu/libpthread-2.15.so
7fe163296000-7fe163297000 r--p 00017000 fc:01 7085833                    /lib/x86_64-linux-gnu/libpthread-2.15.so
7fe163297000-7fe163298000 rw-p 00018000 fc:01 7085833                    /lib/x86_64-linux-gnu/libpthread-2.15.so
7fe163298000-7fe16329c000 rw-p 00000000 00:00 0 
7fe16329c000-7fe16344d000 r-xp 00000000 fc:01 7078062                    /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7fe16344d000-7fe16364d000 ---p 001b1000 fc:01 7078062                    /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7fe16364d000-7fe163668000 r--p 001b1000 fc:01 7078062                    /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7fe163668000-7fe163673000 rw-p 001cc000 fc:01 7078062                    /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7fe163673000-7fe163677000 rw-p 00000000 00:00 0 
7fe163677000-7fe16368d000 r-xp 00000000 fc:01 7081635                    /lib/x86_64-linux-gnu/libz.so.1.2.7
7fe16368d000-7fe16388c000 ---p 00016000 fc:01 7081635                    /lib/x86_64-linux-gnu/libz.so.1.2.7
7fe16388c000-7fe16388d000 r--p 00015000 fc:01 7081635                    /lib/x86_64-linux-gnu/libz.so.1.2.7
7fe16388d000-7fe16388e000 rw-p 00016000 fc:01 7081635                    /lib/x86_64-linux-gnu/libz.so.1.2.7
7fe16388e000-7fe1638b0000 r-xp 00000000 fc:01 7085838                    /lib/x86_64-linux-gnu/ld-2.15.so
7fe16394a000-7fe163a4d000 r--p 00000000 fc:01 10888685                   /tmp/project.git/.git/objects/pack/pack-5b132454d5acb542969a939fe55186a65d9dd697.idx
7fe163a4d000-7fe163a8c000 r--p 00000000 fc:01 1048722                    /usr/lib/locale/de_DE.utf8/LC_CTYPE
7fe163a8c000-7fe163a90000 rw-p 00000000 00:00 0 
7fe163aa5000-7fe163aa6000 rw-p 00000000 00:00 0 
7fe163aa6000-7fe163aad000 r--s 00000000 fc:01 12987862                   /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
7fe163aad000-7fe163aae000 r--p 00000000 fc:01 1050508                    /usr/lib/locale/de_DE.utf8/LC_MESSAGES/SYS_LC_MESSAGES
7fe163aae000-7fe163ab0000 rw-p 00000000 00:00 0 
7fe163ab0000-7fe163ab1000 r--p 00022000 fc:01 7085838                    /lib/x86_64-linux-gnu/ld-2.15.so
7fe163ab1000-7fe163ab3000 rw-p 00023000 fc:01 7085838                    /lib/x86_64-linux-gnu/ld-2.15.so
7fff8299b000-7fff829bc000 rw-p 00000000 00:00 0                          [stack]
7fff829fe000-7fff82a00000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
Abgebrochen
