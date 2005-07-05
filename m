From: Sam Ravnborg <sam@ravnborg.org>
Subject: git-update-cache:
Date: Tue, 5 Jul 2005 23:02:56 +0200
Message-ID: <20050705210256.GA28700@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 05 23:13:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpuj2-0002w4-5b
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 23:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVGEVJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVGEVH3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 17:07:29 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:51755 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261949AbVGEVDO
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 17:03:14 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 80B3747FEB2
	for <git@vger.kernel.org>; Tue,  5 Jul 2005 23:03:13 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 0BC6B6AC169; Tue,  5 Jul 2005 23:02:56 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

While trying to execute:
git-update-cache -- drivers/Kconfig drivers/net/Kconfig net/Kconfig

I receive the following error:
git-update-cache: symbol lookup error: git-update-cache: undefined
symbol: deflateBound


I have fetched a clean tree from kernel.org, and cloned it using
cg-clone.
Modifications are done in the cloned tree and the error is seen when
trying to do a cg-commit (that does the git-update-cache).

When this error is seen a file .git/index.lock is left and next
invocation of git-update-cache faild due to this but deletes the file.
Third invocation show the same error again.

To my best knowledge I have a working zlib installed.

Any help really appreciated!

	Sam
	

strace appended:

sam@mars ~/linux/net-kconfig $ strace git-update-cache -- drivers/Kconfig drivers/net/Kconfig net/Kconfig > ../z
execve("/home/sam/bin/git-update-cache", ["git-update-cache", "--", "drivers/Kconfig", "drivers/net/Kconfig", "net/Kconfig"], [/* 54 vars */]) = 0
uname({sys="Linux", node="mars", ...})  = 0
brk(0)                                  = 0x8054000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=136714, ...}) = 0
mmap2(NULL, 136714, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\31\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=54416, ...}) = 0
mmap2(NULL, 56204, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40038000
mmap2(0x40044000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb) = 0x40044000
close(3)                                = 0
open("/usr/lib/libcrypto.so.0.9.7", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \305\2"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0555, st_size=999412, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40046000
mmap2(NULL, 974584, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40047000
mmap2(0x40120000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd8) = 0x40120000
mmap2(0x40132000, 12024, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40132000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220V\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1154496, ...}) = 0
mmap2(NULL, 1088900, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40135000
mprotect(0x40238000, 28036, PROT_NONE)  = 0
mmap2(0x40239000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x103) = 0x40239000
mmap2(0x4023d000, 7556, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4023d000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\v\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=10592, ...}) = 0
mmap2(NULL, 12392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4023f000
mmap2(0x40241000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x40241000
close(3)                                = 0
mprotect(0x40239000, 4096, PROT_READ)   = 0
munmap(0x40016000, 136714)              = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "1@\353)", 4)                   = 4
close(3)                                = 0
brk(0)                                  = 0x8054000
brk(0x8075000)                          = 0x8075000
rt_sigaction(SIGINT, {0x804cb30, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
open(".git/index.lock", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
open(".git/index", O_RDONLY)            = 4
fstat64(4, {st_mode=S_IFREG|0600, st_size=1658992, ...}) = 0
mmap2(NULL, 1658992, PROT_READ|PROT_WRITE, MAP_PRIVATE, 4, 0) = 0x40243000
close(4)                                = 0
lstat64("drivers/Kconfig", {st_mode=S_IFREG|0644, st_size=1030, ...}) = 0
open("drivers/Kconfig", O_RDONLY)       = 4
mmap2(NULL, 1030, PROT_READ, MAP_PRIVATE, 4, 0) = 0x403d9000
close(4)                                = 0
stat64(".git/objects/fb/5c9b2a886518a4bfb0d2e2762fad41a08a5ba7", 0xbf85005c) = -1 ENOENT (No such file or directory)
open(".git/objects/pack", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 2 entries */, 4096)    = 48
getdents64(4, /* 0 entries */, 4096)    = 0
open(".git/objects/fb/5c9b2a886518a4bfb0d2e2762fad41a08a5ba7", O_RDONLY) = -1 ENOENT (No such file or directory)
gettimeofday({1120596694, 840021}, NULL) = 0
getpid()                                = 28699
open(".git/objects/obj_5s6K76", O_RDWR|O_CREAT|O_EXCL, 0600) = 5
brk(0x80a1000)                          = 0x80a1000
brk(0x80d1000)                          = 0x80d1000
writev(2, [{"git-update-cache", 16}, {": ", 2}, {"symbol lookup error", 19}, {": ", 2}, {"git-update-cache", 16}, {": ", 2}, {"undefined symbol: deflateBound", 30}, {"", 0}, {"", 0}, {"\n", 1}], 10git-update-cache: symbol lookup error: git-update-cache: undefined symbol: deflateBound
) = 88
exit_group(127)                         = ?
