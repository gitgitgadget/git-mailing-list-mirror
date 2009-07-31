From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 13:26:46 +0200
Message-ID: <4A72D4F6.7050707@drmicha.warpmail.net>
References: <20090726232154.29594.qmail@science.horizon.com> <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWqGn-0007BN-Or
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZGaL1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 07:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbZGaL1C
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:27:02 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42153 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072AbZGaL1B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 07:27:01 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9476F3BD796;
	Fri, 31 Jul 2009 07:27:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 31 Jul 2009 07:27:01 -0400
X-Sasl-enc: 0DXN2N4py2PUWj9TTUIfaI0l1+LmCZjW49D7uXEPyTST 1249039608
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4765B1CE46;
	Fri, 31 Jul 2009 07:26:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124545>

George Spelvin venit, vidit, dixit 31.07.2009 12:46:
> After studying Andy Polyakov's optimized x86 SHA-1 in OpenSSL, I've
> got a version that's 1.6% slower on a P4 and 15% faster on a Phenom.
> I'm curious about the performance on other CPUs I don't have access to,
> particularly Core 2 duo and i7.
> 
> Could someone do some benchmarking for me?  Old (486/Pentium/P2/P3)
> machines are also interesting, but I'm optimizing for newer ones.
> 
> I haven't packaged this nicely, but it's not that complicated.
> - Download Andy's original code from
>   http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
> - Unpack and cd to the cryptogams-0/x86 directory
> - "patch < this_email" to create "sha1test.c", "sha1-586.h", "Makefile",
>    and "sha1-x86.pl".
> - "make" 
> - Run ./586test (before) and ./x86test (after) and note the timings.
> 
> Thank you!

Best of 6 runs:
./586test
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 1.258031 s
./x86test
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 1.171770 s

System:
uname -a
Linux whatever 2.6.22-14-generic #1 SMP Tue Feb 12 07:42:25 UTC 2008
i686 GNU/Linux
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
stepping        : 10
cpu MHz         : 2000.000
cache size      : 6144 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips        : 5988.92
clflush size    : 64

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
stepping        : 10
cpu MHz         : 2000.000
cache size      : 6144 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips        : 5984.92
clflush size    : 64
