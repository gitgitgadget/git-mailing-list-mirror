From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 13:21:59 +0200
Message-ID: <4A72D3D7.1080706@drmicha.warpmail.net>
References: <20090726232154.29594.qmail@science.horizon.com> <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWqBs-0005C0-Nt
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbZGaLWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 07:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZGaLWP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:22:15 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45361 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752544AbZGaLWP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 07:22:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C43543BD4FA;
	Fri, 31 Jul 2009 07:22:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 31 Jul 2009 07:22:15 -0400
X-Sasl-enc: JoloYOrbwrIr7QdQLUdn8irDOVXqSn6z7rnDuqeCe5x9 1249039334
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7F419C40;
	Fri, 31 Jul 2009 07:22:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124544>

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
500000000 bytes: 1.642336 s
./x86test
Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
500000000 bytes: 1.532153 s

System:
uname -a
Linux localhost.localdomain 2.6.29.6-213.fc11.x86_64 #1 SMP Tue Jul 7
21:02:57 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz
stepping        : 11
cpu MHz         : 800.000
cache size      : 4096 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm ida tpr_shadow vnmi
flexpriority
bogomips        : 4389.20
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 Duo CPU     T7500  @ 2.20GHz
stepping        : 11
cpu MHz         : 800.000
cache size      : 4096 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm ida tpr_shadow vnmi
flexpriority
bogomips        : 4388.78
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:
