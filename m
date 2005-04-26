From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: cg-add and update-cache add fails
Date: Tue, 26 Apr 2005 17:35:46 +0100
Message-ID: <200504261735.47008.rhys@rhyshardwick.co.uk>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_i3mbC4l14LnC3Sc"
X-From: git-owner@vger.kernel.org Tue Apr 26 18:38:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQT2a-0004rV-Ha
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDZQko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVDZQjZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:39:25 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:9595 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261688AbVDZQf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 12:35:59 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp002.mail.ukl.yahoo.com with SMTP; 26 Apr 2005 16:35:47 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DQT2J-0005iN-LA
	for git@vger.kernel.org; Tue, 26 Apr 2005 17:35:47 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_i3mbC4l14LnC3Sc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey there,

I posted a little while ago about this, but thought I would collate all my 
findings.  I am very lost.  Trying to add files to the repository does not 
seem to work, no matter which git repository I try.  Creating new trees and 
updating current trees, as well as removing files is not a problem.  All 
other areas of git seem to work perfectly.  I am currently using cogito-0.8.  
This error started to occur in pasky-0.63.

Here is the error I get:

rhys@metatron:~/repo/learning.repo$ cg-add w1p4d1.c
fatal: Unable to add w1p4d1.c to database
rhys@metatron:~/repo/learning.repo$ update-cache --add w1p4d1.c
fatal: Unable to add w1p4d1.c to database

All the files under the .git folder appear to be owned by me, and are 
read-writable.  The disk is not full.  

I have attached the output from strace and ltrace.

If anyone could shed any light on why this might be happening, I would be very 
grateful.

Rhys

--Boundary-00=_i3mbC4l14LnC3Sc
Content-Type: text/plain;
  charset="us-ascii";
  name="strace and ltrace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="strace and ltrace"

rhys@metatron:~/repo/learning.repo$ strace cg-add w1d4p1.c
execve("/home/rhys/bin/cg-add", ["cg-add", "w1d4p1.c"], [/* 37 vars */]) = 0
uname({sys="Linux", node="metatron", ...}) = 0
brk(0)                                  = 0x804c000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fe9000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=78602, ...}) = 0
old_mmap(NULL, 78602, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fd5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`Z\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1254468, ...}) = 0
old_mmap(NULL, 1264780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7ea0000
old_mmap(0xb7fca000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0xb7fca000
old_mmap(0xb7fd3000, 7308, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fd3000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e9f000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e9f460, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7fd5000, 78602)               = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=290448, ...}) = 0
mmap2(NULL, 290448, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7e58000
close(3)                                = 0
brk(0)                                  = 0x804c000
brk(0x806d000)                          = 0x806d000
brk(0)                                  = 0x806d000
execve("/usr/local/bin/bash", ["bash", "/home/rhys/bin/cg-add", "w1d4p1.c"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
execve("/usr/bin/bash", ["bash", "/home/rhys/bin/cg-add", "w1d4p1.c"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
execve("/bin/bash", ["bash", "/home/rhys/bin/cg-add", "w1d4p1.c"], [/* 37 vars */]) = 0
uname({sys="Linux", node="metatron", ...}) = 0
brk(0)                                  = 0x80f1000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fe9000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=78602, ...}) = 0
old_mmap(NULL, 78602, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fd5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\342"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=252592, ...}) = 0
old_mmap(NULL, 257868, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7f96000
old_mmap(0xb7fcc000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x35000) = 0xb7fcc000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\32"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9872, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f95000
old_mmap(NULL, 8632, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7f92000
old_mmap(0xb7f94000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0xb7f94000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`Z\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1254468, ...}) = 0
old_mmap(NULL, 1264780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7e5d000
old_mmap(0xb7f87000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0xb7f87000
old_mmap(0xb7f90000, 7308, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f90000
close(3)                                = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f95b80, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7fd5000, 78602)               = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=290448, ...}) = 0
mmap2(NULL, 290448, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7e16000
close(3)                                = 0
brk(0)                                  = 0x80f1000
brk(0)                                  = 0x80f1000
brk(0x80f2000)                          = 0x80f2000
brk(0)                                  = 0x80f2000
brk(0x80f3000)                          = 0x80f3000
brk(0)                                  = 0x80f3000
brk(0x80f4000)                          = 0x80f4000
getuid32()                              = 1000
getgid32()                              = 1000
geteuid32()                             = 1000
getegid32()                             = 1000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
time(NULL)                              = 1114533106
brk(0)                                  = 0x80f4000
brk(0x80f5000)                          = 0x80f5000
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=381, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e15000
read(3, "/dev/hda7 / ext3 rw,errors=remou"..., 4096) = 381
close(3)                                = 0
munmap(0xb7e15000, 4096)                = 0
open("/proc/meminfo", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e15000
read(3, "MemTotal:       906680 kB\nMemFre"..., 1024) = 598
close(3)                                = 0
munmap(0xb7e15000, 4096)                = 0
brk(0)                                  = 0x80f5000
brk(0x80f6000)                          = 0x80f6000
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
uname({sys="Linux", node="metatron", ...}) = 0
brk(0)                                  = 0x80f6000
brk(0x80f7000)                          = 0x80f7000
stat64("/home/rhys/repo/learning.repo", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
getpid()                                = 9873
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No such file or directory)
brk(0)                                  = 0x80f7000
brk(0x80f8000)                          = 0x80f8000
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=45278, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e15000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
brk(0)                                  = 0x80f8000
brk(0x80f9000)                          = 0x80f9000
read(3, ".B1.002//\nalias\tJS//\t\t\tJUS_I.B1."..., 4096) = 4096
brk(0)                                  = 0x80f9000
brk(0x80fa000)                          = 0x80fa000
brk(0)                                  = 0x80fa000
brk(0x80fb000)                          = 0x80fb000
brk(0)                                  = 0x80fb000
brk(0x80fc000)                          = 0x80fc000
read(3, "859-3\t1\nmodule\tINTERNAL\t\tISO-885"..., 4096) = 4096
brk(0)                                  = 0x80fc000
brk(0x80fd000)                          = 0x80fd000
brk(0)                                  = 0x80fd000
brk(0x80fe000)                          = 0x80fe000
brk(0)                                  = 0x80fe000
brk(0x80ff000)                          = 0x80ff000
read(3, "9-14//\nalias\tLATIN8//\t\tISO-8859-"..., 4096) = 4096
brk(0)                                  = 0x80ff000
brk(0x8100000)                          = 0x8100000
brk(0)                                  = 0x8100000
brk(0x8101000)                          = 0x8101000
brk(0)                                  = 0x8101000
brk(0x8102000)                          = 0x8102000
read(3, "CSEBCDICES//\t\tEBCDIC-ES//\nalias\t"..., 4096) = 4096
brk(0)                                  = 0x8102000
brk(0x8103000)                          = 0x8103000
brk(0)                                  = 0x8103000
brk(0x8104000)                          = 0x8104000
read(3, "IBM284//\nalias\tEBCDIC-CP-ES//\t\tI"..., 4096) = 4096
brk(0)                                  = 0x8104000
brk(0x8105000)                          = 0x8105000
brk(0)                                  = 0x8105000
brk(0x8106000)                          = 0x8106000
brk(0)                                  = 0x8106000
brk(0x8107000)                          = 0x8107000
read(3, "ias\t864//\t\t\tIBM864//\nalias\tCSIBM"..., 4096) = 4096
brk(0)                                  = 0x8107000
brk(0x8108000)                          = 0x8108000
brk(0)                                  = 0x8108000
brk(0x8109000)                          = 0x8109000
brk(0)                                  = 0x8109000
brk(0x810a000)                          = 0x810a000
read(3, "\tIBM937\t\t1\nmodule\tINTERNAL\t\tIBM9"..., 4096) = 4096
brk(0)                                  = 0x810a000
brk(0x810b000)                          = 0x810b000
brk(0)                                  = 0x810b000
brk(0x810c000)                          = 0x810c000
brk(0)                                  = 0x810c000
brk(0x810d000)                          = 0x810d000
read(3, "UC-JP//\nmodule\tEUC-JP//\t\tINTERNA"..., 4096) = 4096
brk(0)                                  = 0x810d000
brk(0x810e000)                          = 0x810e000
brk(0)                                  = 0x810e000
brk(0x810f000)                          = 0x810f000
brk(0)                                  = 0x810f000
brk(0x8110000)                          = 0x8110000
read(3, "143IECP271//\tIEC_P27-1//\nalias\tI"..., 4096) = 4096
brk(0)                                  = 0x8110000
brk(0x8111000)                          = 0x8111000
brk(0)                                  = 0x8111000
brk(0x8112000)                          = 0x8112000
read(3, "\nmodule\tINTERNAL\t\tISO_10367-BOX/"..., 4096) = 4096
brk(0)                                  = 0x8112000
brk(0x8113000)                          = 0x8113000
brk(0)                                  = 0x8113000
brk(0x8114000)                          = 0x8114000
brk(0)                                  = 0x8114000
brk(0x8115000)                          = 0x8115000
read(3, "\t\tto\t\t\tmodule\t\tcost\nmodule\tShift"..., 4096) = 222
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7e15000, 4096)                = 0
brk(0)                                  = 0x8115000
brk(0x8116000)                          = 0x8116000
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\6\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=5920, ...}) = 0
brk(0)                                  = 0x8116000
brk(0x8117000)                          = 0x8117000
old_mmap(NULL, 8860, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7e13000
old_mmap(0xb7e15000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0xb7e15000
close(3)                                = 0
getppid()                               = 9872
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/local/bin/bash", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/bash", 0xbffff490)     = -1 ENOENT (No such file or directory)
stat64("/bin/bash", {st_mode=S_IFREG|0755, st_size=667180, ...}) = 0
getgroups32(32, [20, 24, 25, 29, 33, 44, 1000]) = 7
stat64("/bin/bash", {st_mode=S_IFREG|0755, st_size=667180, ...}) = 0
getpgrp()                               = 9872
rt_sigaction(SIGCHLD, {0x807ac80, [], 0}, {SIG_DFL}, 8) = 0
brk(0)                                  = 0x8117000
brk(0x8118000)                          = 0x8118000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/home/rhys/bin/cg-add", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff608) = -1 ENOTTY (Inappropriate ioctl for device)
_llseek(3, 0, [0], SEEK_CUR)            = 0
read(3, "#!/usr/bin/env bash\n#\n# Add new "..., 80) = 80
_llseek(3, 0, [0], SEEK_SET)            = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
dup2(3, 255)                            = 255
close(3)                                = 0
fcntl64(255, F_SETFD, FD_CLOEXEC)       = 0
fcntl64(255, F_GETFL)                   = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fstat64(255, {st_mode=S_IFREG|0755, st_size=300, ...}) = 0
_llseek(255, 0, [0], SEEK_CUR)          = 0
brk(0)                                  = 0x8118000
brk(0x8119000)                          = 0x8119000
brk(0)                                  = 0x8119000
brk(0x811a000)                          = 0x811a000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "#!/usr/bin/env bash\n#\n# Add new "..., 300) = 300
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/local/bin/cg-Xlib", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/cg-Xlib", 0xbffff490)  = -1 ENOENT (No such file or directory)
stat64("/bin/cg-Xlib", 0xbffff490)      = -1 ENOENT (No such file or directory)
stat64("/usr/bin/X11/cg-Xlib", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/usr/games/cg-Xlib", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/home/rhys/bin/cg-Xlib", {st_mode=S_IFREG|0755, st_size=835, ...}) = 0
stat64("/home/rhys/bin/cg-Xlib", {st_mode=S_IFREG|0755, st_size=835, ...}) = 0
open("/home/rhys/bin/cg-Xlib", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=835, ...}) = 0
read(3, "#!/usr/bin/env bash\n#\n# Common c"..., 835) = 835
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0)                                  = 0x811a000
brk(0x811b000)                          = 0x811b000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".git", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".git/remotes", 0xbffff070)      = -1 ENOENT (No such file or directory)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".git", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".git/refs", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/local/bin/update-cache", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/update-cache", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/bin/update-cache", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/X11/update-cache", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/usr/games/update-cache", 0xbffff490) = -1 ENOENT (No such file or directory)
stat64("/home/rhys/bin/update-cache", {st_mode=S_IFREG|0755, st_size=91464, ...}) = 0
stat64("/home/rhys/bin/update-cache", {st_mode=S_IFREG|0755, st_size=91464, ...}) = 0
brk(0)                                  = 0x811b000
brk(0x811c000)                          = 0x811c000
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(fatal: Unable to add w1d4p1.c to database
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7f95bc8) = 9874
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], WNOHANG) = 9874
waitpid(-1, 0xbffff164, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x8079bd0, [], 0}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x8079bd0, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "", 300)                      = 0
exit_group(1)                           = ?

========================================================================================

rhys@metatron:~/repo/learning.repo$ ltrace update-cache --add w1d4p1.c
__libc_start_main(0x80496b0, 3, 0xbffff854, 0x804ae20, 0x804ae80 <unfinished ...>
getenv("GIT_INDEX_FILE")                         = NULL
snprintf(".git/index.lock", 4097, "%s.lock", ".git/index") = 15
open(".git/index.lock", 194, 0600)               = 3
__cxa_atexit(0x8049690, 0, 0, 0xb7f8de80, 0xbffff7c8) = 0
__errno_location()                               = 0xb7d59280
getenv("SHA1_FILE_DIRECTORY")                    = NULL
access(".git/objects", 1)                        = 0
getenv("GIT_INDEX_FILE")                         = NULL
open(".git/index", 0, 026777021220)              = 4
__fxstat(3, 4, 0xbffff710)                       = 0
__errno_location()                               = 0xb7d59280
mmap(0, 176, 1, 2, 4)                            = 0xb7fe8000
close(4)                                         = 0
SHA1_Init(0xbffff660, 0xb7e67bc8, 0xb7fc2290, 0x804870e, 96) = 1
SHA1_Update(0xbffff660, 0xb7fe8000, 156, 0x804870e, 96) = 1
SHA1_Final(0xbffff640, 0xbffff660, 156, 0x804870e, 96) = 1
calloc(27, 4)                                    = 0x8050008
open("w1d4p1.c", 0, 044653)                      = -1
__errno_location()                               = 0xb7d59280
fputs("fatal: ", 0xb7f86f60fatal: )                     = 1
vfprintf(0xb7f86f60, "Unable to add %s to database", 0xbffff794Unable to add w1d4p1.c to database) = 34
fputc('\n', 0xb7f86f60
)                          = 10
exit(1 <unfinished ...>
unlink(".git/index.lock")                        = 0
+++ exited (status 1) +++
rhys@metatron:~/repo/learning.repo$      

--Boundary-00=_i3mbC4l14LnC3Sc--


