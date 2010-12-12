From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: SIGPIPE in t9300-fast-import
Date: Sun, 12 Dec 2010 17:04:06 -0500
Message-ID: <2F4185D2-5846-45CB-BC92-6BC07AE5CEC8@gernhardtsoftware.com>
References: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com> <20101212214909.GA19709@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 23:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRu1l-00027m-5B
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 23:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab0LLWEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 17:04:16 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34912 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0LLWEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 17:04:15 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id BB06C1FFC43D; Sun, 12 Dec 2010 22:04:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 8E5E31FFC12F;
	Sun, 12 Dec 2010 22:04:00 +0000 (UTC)
In-Reply-To: <20101212214909.GA19709@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163493>


On Dec 12, 2010, at 4:49 PM, Jonathan Nieder wrote:

> Hmm.  Any idea why dd is ending early?

No idea.

> Does using
> 
> 	head -c "$size" >blob <&3 &&

Yes.

> 	dd of=blob bs=1 count=$size <&3 &&
> 
> in its place work?

Yes.

> What does the Mac OS X equivalent of
> 
> 	strace dd of=blob bs=$size count=1 <&3
> 
> (dtrace or ktrace, I guess) tell?

The moral equivalent seems to be "dtruss" (which I think is a front end to DTrace) in modern OS X.

0+1 records in
0+1 records out
8139 bytes transferred in 0.000205 secs (39694698 bytes/sec)
SYSCALL(args) 		 = return
ioctl(0x6, 0x80086804, 0x7FFF5FBFD0A0)		 = 0 0
close(0x6)		 = 0 0
__sysctl(0x7FFF5FBFCF90, 0x2, 0x7FFF5FBFCF80)		 = 0 0
bsdthread_register(0x7FFF852F43DC, 0x7FFF852D4FF8, 0x2000)		 = 0 0
thread_selfid(0x7FFF852F43DC, 0x7FFF852D4FF8, 0x0)		 = 1850088 0
open_nocancel("/dev/urandom\0", 0x0, 0x7FFF70ABABE0)		 = 6 0
read_nocancel(0x6, "\350>6\026\310R\251_\227\213h\237\304\330&Q-\247\0313\020BnH\277\337z\276c\247\206\017\340/\302} \2644\273\003\252`\363d8\252\247)V2\323\021\320\\\214\001\331\226\020RY\024I\0", 0x40)		 = 64 0
close_nocancel(0x6)		 = 0 0
mmap(0x0, 0x3000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0xD000 0
__sysctl(0x7FFF5FBFCE10, 0x2, 0x7FFF5FBFCDD0)		 = 0 0
__sysctl(0x7FFF5FBFCDD0, 0x2, 0x7FFF5FBFCE68)		 = 0 0
getpid(0x7FFF5FBFCD60, 0x7FFFFFE00050, 0x0)		 = 94596 0
open_nocancel("/dev/urandom\0", 0x0, 0x0)		 = 6 0
read_nocancel(0x6, "\253\331\354\357A)G\3256\222\024=\242E\261\301\314\351\017K\301;O\256I\270\301\312\263M\307\340+U\217\242\230\335\020\275\356T\323\334\312\313\331*\037\273K\332\a\247\323\324\377m\360\204\375c\026i\345\017x\2070n\026\266\027\021k\340( \245\337\3277H\214\0", 0x6C)		 = 108 0
close_nocancel(0x6)		 = 0 0
__sysctl(0x7FFF5FBFCE10, 0x2, 0x7FFF5FBFCE3C)		 = 0 0
mmap(0x0, 0x17000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0x10000 0
mmap(0x0, 0x17000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0x27000 0
mmap(0x0, 0x1000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0x3E000 0
mmap(0x0, 0x200000, 0x3, 0x1002, 0x7000000, 0x7FFF00000001)		 = 0x3F000 0
munmap(0x10003F000, 0xC1000)		 = 0 0
munmap(0x100200000, 0x3F000)		 = 0 0
__sysctl(0x7FFF5FBFCF70, 0x2, 0x7FFF5FBFCF30)		 = 0 0
__sysctl(0x7FFF5FBFCF30, 0x2, 0x7FFF70AC7760)		 = 0 0
__sysctl(0x7FFF5FBFCF70, 0x2, 0x7FFF5FBFCF30)		 = 0 0
__sysctl(0x7FFF5FBFCF30, 0x2, 0x7FFF70AC7764)		 = 0 0
__sysctl(0x7FFF5FBFCF70, 0x2, 0x7FFF5FBFCF30)		 = 0 0
__sysctl(0x7FFF5FBFCF30, 0x2, 0x7FFF70AC7768)		 = 0 0
mmap(0x0, 0x3000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0x3F000 0
__sysctl(0x7FFF5FBFCF40, 0x2, 0x7FFF5FBFCF00)		 = 0 0
__sysctl(0x7FFF5FBFCF00, 0x2, 0x7FFF5FBFCF98)		 = 0 0
__sysctl(0x7FFF5FBFCF40, 0x2, 0x7FFF5FBFCF6C)		 = 0 0
mmap(0x0, 0x17000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0x42000 0
mmap(0x0, 0x17000, 0x3, 0x1002, 0x1000000, 0x7FFF00000001)		 = 0x59000 0
mmap(0x0, 0x200000, 0x3, 0x1002, 0x7000000, 0x7FFF00000001)		 = 0x200000 0
munmap(0x100300000, 0x100000)		 = 0 0
fstat64(0x0, 0x7FFF5FBFF320, 0x17FFF)		 = 0 0
lseek(0x0, 0x0, 0x1)		 = -1 Err#29
open("blob\0", 0x602, 0x1B6)		 = 6 0
fstat64(0x6, 0x7FFF5FBFF320, 0x0)		 = 0 0
lseek(0x6, 0x0, 0x1)		 = 0 0
mmap(0x0, 0x58000, 0x3, 0x1002, 0x3000000, 0x7FFF00000000)		 = 0x70000 0
mmap(0x0, 0x1000, 0x3, 0x1002, 0x3000000, 0x7FFF00000000)		 = 0xC8000 0
sigaction(0x1D, 0x7FFF5FBFF380, 0x7FFF5FBFF3B0)		 = 0 0
sigaction(0x2, 0x7FFF5FBFF380, 0x7FFF5FBFF3B0)		 = 0 0
read(0x0, "the quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the l", 0x2C000)		 = 8139 0
write(0x6, "the quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the l", 0x1FCB)		 = 8139 0
write(0x2, "0+1 records in\n0+1 records out\n quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quic", 0x1F)		 = 31 0
write(0x2, "8139 bytes transferred in 0.000205 secs (39694698 bytes/sec)\nuick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jumps over the lazy dog\nthe quick brown fox jump", 0x3D)		 = 61 0
getpid(0x7FFF5FBFF250, 0x7FFFFFE00050, 0x0)		 = 94596 0
open_nocancel("/dev/urandom\0", 0x0, 0x0)		 = 6 0
read_nocancel(0x6, "\232/\226\373ld\353\r+l\236qV\317\370\271.0\353=\316\3464\t\263\262r\022\362w\360H\245LdE\3769\254\3309m\246I\361\374\307\342]6\n\337\303\310\333\332\036\327\313\224(\3443C\327\224\225\376\221\311-\323\272\344\275l\034\353LR<\236\t\202\250\353\202\276AS\363\023@\353\331[\037\bC\036)\336\363WZ\003\0", 0x6C)		 = 108 0
close_nocancel(0x6)		 = 0 0
issetugid(0x100000000, 0x7FFF5FBFF5B0, 0x7FFF5FC40530)		 = 0 0
geteuid(0x100000000, 0x7FFF5FBFF5B0, 0x0)		 = 0 0
__sysctl(0x7FFF5FBFD140, 0x2, 0x7FFF5FBFD100)		 = 0 0
__sysctl(0x7FFF5FBFD100, 0x2, 0x7FFF5FBFD19C)		 = 0 0
shared_region_check_np(0x7FFF5FBFD308, 0x0, 0x7FFF5FC1DC86)		 = 0 0
stat64("/usr/lib/dtrace/libdtrace_dyld.dylib\0", 0x7FFF5FBFC710, 0x7FFF5FBFCD50 = 0 0
open("/usr/lib/dtrace/libdtrace_dyld.dylib\0", 0x0, 0x0)		 = 6 0
pread(0x6, "\312\376\272\276\0", 0x1000, 0x0)		 = 4096 0
pread(0x6, "\317\372\355\376\a\0", 0x1000, 0x1000)		 = 4096 0
mmap(0x100008000, 0x2000, 0x5, 0x12, 0x6, 0x1FFFFFFFF)		 = 0x8000 0
mmap(0x10000A000, 0x1000, 0x3, 0x12, 0x6, 0x1FFFFFFFF)		 = 0xA000 0
mmap(0x10000B000, 0x1F10, 0x1, 0x12, 0x6, 0x1FFFFFFFF)		 = 0xB000 0
close(0x6)		 = 0 0
stat64("/usr/lib/libSystem.B.dylib\0", 0x7FFF5FBFC4C0, 0x7FFF5FBFCB00)		 = 0 0
stat64("/usr/lib/system/libmathCommon.A.dylib\0", 0x7FFF5FBFC370, 0x7FFF5FBFC9B0)		 = 0 0
madvise(0x7FFF89610000, 0x2000, 0x5)		 = 0 0
open("/dev/dtracehelper\0", 0x2, 0x7FFF5FC45258)		 = 6 0
ioctl(0x6, 0x80086804, 0x7FFF5FBFD0A0)		 = 0 0
close(0x6)		 = 0 0
stat64("/usr/lib/libstdc++.6.dylib\0", 0x7FFF5FBFC4B0, 0x7FFF5FBFCAF0)		 = 0 0
open("/dev/dtracehelper\0", 0x2, 0x7FFF5FC45320)		 = 6 0

error: git-fast-import died of signal 13
---- 8< ----

blob does exist, it just seems to end early:

--- big 2010-12-12 16:56:32.000000000 -0500
+++ blob        2010-12-12 16:56:33.000000000 -0500
@@ -182,3915 +182,4 @@

Followed by many lines of:

-the quick brown fox jumps over the lazy dog

and then:

+the quick brown fox jumps over the lazy dog
\ No newline at end of file

> Thanks for noticing.

I tend to update to latest next, compile, and test about once a day so exactly so I can catch things.  :-D

~~ Brian