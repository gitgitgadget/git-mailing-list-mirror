From: Peter Osterlund <petero2@telia.com>
Subject: Re: Fix interesting git-rev-list corner case
Date: 30 Jul 2005 12:10:35 +0200
Message-ID: <m31x5gob8k.fsf@telia.com>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 12:12:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyoKF-0001u5-GL
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 12:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVG3KLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 06:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVG3KLh
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 06:11:37 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:18125 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S263008AbVG3KK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 06:10:57 -0400
Received: from r3000.localdomain (212.181.176.51) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 42B94E29005EDFA1; Sat, 30 Jul 2005 12:10:44 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j6UAAaw0011638;
	Sat, 30 Jul 2005 12:10:36 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j6UAAad7011632;
	Sat, 30 Jul 2005 12:10:36 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> This corner-case was triggered by a kernel commit that was not in date
> order, due to a misconfigured time zone that made the commit appear three
> hours older than it was.

I have problems pulling linux kernel changes from
33ac02aa4cef417871e128ab4a6565e751e5f3b2 to
b0825488a642cadcf39709961dde61440cb0731c into my local tree. At first
I thought your patch would fix it, but it doesn't:

r3000:~/git$ cat linux/.git/HEAD
b0825488a642cadcf39709961dde61440cb0731c
r3000:~/git$ git-clone-script -l linux linux.test
defaulting to local storage area
0 blocks
r3000:~/git$ cd linux.test/
r3000:~/git/linux.test$ echo 33ac02aa4cef417871e128ab4a6565e751e5f3b2 >.git/HEAD
r3000:~/git/linux.test$ git-pull-script ../linux
Packing 291 objects
Unpacking 291 objects
 100% (291/291) done
Trying to merge b0825488a642cadcf39709961dde61440cb0731c into 33ac02aa4cef417871e128ab4a6565e751e5f3b2
Simple merge failed, trying Automatic merge
Removing arch/mips/vr41xx/common/giu.c
Auto-merging arch/s390/kernel/head.S.
Auto-merging arch/s390/kernel/head64.S.
Auto-merging arch/um/os-Linux/elf_aux.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/um/os-Linux/elf_aux.c.
Auto-merging arch/x86_64/kernel/smp.c.
Auto-merging arch/x86_64/kernel/smpboot.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/x86_64/kernel/smpboot.c.
Auto-merging drivers/i2c/busses/i2c-mpc.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/i2c/busses/i2c-mpc.c.
Removing drivers/ide/cris/ide-v10.c
Removing drivers/media/dvb/frontends/lgdt3302.c
Removing drivers/media/dvb/frontends/lgdt3302.h
Removing drivers/media/dvb/frontends/lgdt3302_priv.h
Removing drivers/serial/bast_sio.c
Auto-merging drivers/usb/input/hid-input.c.
Auto-merging drivers/video/fbmem.c.
Auto-merging include/asm-i386/bitops.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/asm-i386/bitops.h.
Auto-merging include/asm-x86_64/smp.h.
Auto-merging kernel/sys.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in kernel/sys.c.
Removing net/ipv4/utils.c
Removing sound/pcmcia/vx/vx_entry.c
Removing sound/pcmcia/vx/vxp440.c
fatal: merge program failed
Automatic merge failed, fix up by hand

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
