From: Sivaram Kannan <siva.devel@gmail.com>
Subject: Re: Git crash in Ubuntu 12.04
Date: Thu, 11 Apr 2013 15:50:31 +0530
Message-ID: <CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 11 12:20:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQEcQ-0007Th-1p
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 12:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933462Ab3DKKUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 06:20:33 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:35211 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab3DKKUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 06:20:32 -0400
Received: by mail-vc0-f172.google.com with SMTP id gd11so1137866vcb.17
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CsRY+Nb9mMbKbX946GbaE8TLc1JUrwg9PTPcZ+h8Yfk=;
        b=hibVQGoz69AmvcPFff8LJHArThE1+o1z3vC3s2GHOkekYtKri2ZwS6ny7u199h47DZ
         +QiuvOH+BSI3l4wd+AyhyQuP+G+LlLlcp2aVhcgOICdFfzKikg8HMwQe7GKdEhxQJGUO
         pdXIYvVMz+Dwh2z+vF2SbTidsY5k97wjnrwnKIkPTISNHc4zs+965ypd5x2Iau5Pe+PO
         V2kDo1Kg07uINndS+Lm1cXUqqThLMNPulRIltl1zELV1i8nTkaLZF1T6cGNr4pKIU4XW
         1TDfQJbp8yDdwR50eYqBiwpDqqyOnTPW5IHG2gmCD7f/xWDJln/KXxoJUp3XBMx2buA9
         osow==
X-Received: by 10.52.17.51 with SMTP id l19mr1417667vdd.118.1365675631801;
 Thu, 11 Apr 2013 03:20:31 -0700 (PDT)
Received: by 10.221.3.131 with HTTP; Thu, 11 Apr 2013 03:20:31 -0700 (PDT)
In-Reply-To: <87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220840>

Hi,

Thanks for the reply.

> Can you tell us what command you ran, and also try to get a readable
> backtrace from your installation?
>

The crash is happening only when the users are trying to do a clone. I
was monitoring from the htop when triggering a clone operation, all
the cores of the processor hits 100% for some time before dropping.
The servers hw config is Intel Quad core processor with 8GB Ram.

> It seems that the paste would have contained a core dump (you snipped
> it9, but it would be pretty useless without the corresponding binary
> anyway.  Once you have the coredump in hand (as a file) you can use
>
>   gdb $(which git) the_coredump_file
>
> and then in the GDB prompt, enter 'backtrace' and paste its output, to
> give us an idea what is going on.
>

Output of coredump gdb:

gitadmin@gitserver:/var/crash/dump$ gdb git CoreDump
GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /usr/bin/git...(no debugging symbols found)...done.
BFD: Warning: /var/crash/dump/CoreDump is truncated: expected core
file size >= 600195072, found: 1114112.
[New LWP 17584]
[New LWP 17587]
[New LWP 17586]
[New LWP 17440]
[New LWP 17585]
Cannot access memory at address 0x7f193623e2a8
Cannot access memory at address 0x7f193623e2a0
(gdb) bt
#0  0x00000000004820f0 in ?? ()
Cannot access memory at address 0x7f191073bda8
(gdb)


=========

The following I am copy pasting from the file called ProcMaps, which
gets created after I run apport-unpack <crashfile>.

00400000-00541000 r-xp 00000000 fc:00 2098029
  /usr/lib/git-core/git
 00741000-00742000 r--p 00141000 fc:00 2098029
   /usr/lib/git-core/git
 00742000-00749000 rw-p 00142000 fc:00 2098029
   /usr/lib/git-core/git
 00749000-00799000 rw-p 00000000 00:00 0
 01c13000-01ecf000 rw-p 00000000 00:00 0                                  [heap]
 7f1ad57c0000-7f1ae0000000 rw-p 00000000 00:00 0
 7f1ae0000000-7f1ae0ed4000 rw-p 00000000 00:00 0
 7f1ae0ed4000-7f1ae4000000 ---p 00000000 00:00 0
 7f1ae4000000-7f1ae665f000 rw-p 00000000 00:00 0
 7f1ae665f000-7f1ae8000000 ---p 00000000 00:00 0
 7f1ae8000000-7f1aea91a000 rw-p 00000000 00:00 0
 7f1aea91a000-7f1aec000000 ---p 00000000 00:00 0
 7f1aec000000-7f1aefede000 rw-p 00000000 00:00 0
 7f1aefede000-7f1af0000000 ---p 00000000 00:00 0
 7f1af0000000-7f1af3b95000 rw-p 00000000 00:00 0
 7f1af3b95000-7f1af4000000 ---p 00000000 00:00 0
 7f1af414b000-7f1af5eaf000 rw-p 00000000 00:00 0
 7f1af6c4d000-7f1af6ffe000 rw-p 00000000 00:00 0
 7f1af6ffe000-7f1af6fff000 ---p 00000000 00:00 0
 7f1af6fff000-7f1af77ff000 rw-p 00000000 00:00 0
 7f1af77ff000-7f1af7800000 ---p 00000000 00:00 0
 7f1af7800000-7f1af8000000 rw-p 00000000 00:00 0
 7f1af8000000-7f1afb9cf000 rw-p 00000000 00:00 0
 7f1afb9cf000-7f1afc000000 ---p 00000000 00:00 0
 7f1afc113000-7f1afc114000 ---p 00000000 00:00 0
 7f1afc114000-7f1afc914000 rw-p 00000000 00:00 0
 7f1afc914000-7f1afc915000 ---p 00000000 00:00 0
 7f1afc915000-7f1afd115000 rw-p 00000000 00:00 0
 7f1afd115000-7f1afe147000 r--p 00000000 fc:00 13371109
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-a72ab4cf996276ca527a26c6711414e97828aa01.pack
 7f1afe147000-7f1afe52d000 rw-p 00000000 00:00 0
 7f1afe8ad000-7f1afe92e000 rw-p 00000000 00:00 0
 7f1afe92e000-7f1afea57000 r--p 00000000 fc:00 13371175
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-725eb21535f4d3782dce7c1f163c535ae46dd7a3.pack
 7f1afea57000-7f1afeaab000 r--p 00000000 fc:00 13371183
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-a242e26dd75d9f94ac7cc021b79b5a23be86f772.pack
 7f1afeaab000-7f1afeb2d000 r--p 00000000 fc:00 13371188
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-8df0b1d878ce57e7b81439bfbbed75da58298d4f.pack
 7f1afeb2d000-7f1afed1c000 r--p 00000000 fc:00 13371200
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-e7279a5e263e36487664846efd3cf8e326e28b52.pack
 7f1afed1c000-7f1afee48000 r--p 00000000 fc:00 13371324
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-b9440d0950347a7f42994eecb3e4b96ac6cba2ef.pack
 7f1afee48000-7f1afef23000 r--p 00000000 fc:00 13371272
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-334b5d2e30e802e8d11095d64348c61a6fabf4ab.pack
 7f1afef23000-7f1b00280000 r--p 00000000 fc:00 13371511
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-89264699af6b413cbcba76e68866a9531693dc2e.pack
 7f1b00280000-7f1b00391000 r--p 00000000 fc:00 13372427
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-c7d9d3af8fb96dd231186fcdb08c451e0aba3cc2.pack
 7f1b00391000-7f1b003fa000 r--p 00000000 fc:00 13372643
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-f5fcf2f514ee6233964234e7d5947f03013b6b21.pack
 7f1b003fa000-7f1b02efe000 r--p 00000000 fc:00 13372753
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-dfb6ee684e3f58549254a7ddb18776670f64b8f5.pack
 7f1b02efe000-7f1b049e4000 r--p 00000000 fc:00 13371038
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-08a676f6ba45b69cd2a19a7d9f626bd24d9a7c6a.pack
 7f1b049e4000-7f1b049ec000 r--p 00000000 fc:00 13371071
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-075a4d75da5f11b72a3a9a68cb1e6209efe1080b.pack
 7f1b049ec000-7f1b0a3fd000 r--p 00000000 fc:00 13371039
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-8c618ce37614112a933a2dd02bfc4095813f9912.pack
 7f1b0a3fd000-7f1b0a64b000 r--p 00000000 fc:00 13371075
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-af68425c69ab8a50a8e6bb58e13d742f8b5d5edd.pack
 7f1b0a67c000-7f1b0a67d000 rw-p 00000000 00:00 0
 7f1b0a67d000-7f1b0a814000 r--p 00000000 fc:00 13372807
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-7067e4bd2b58f72bcb1a88a3df35cee5cc429090.pack
 7f1b0a814000-7f1b13509000 r--p 00000000 fc:00 13370795
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-61336138de0ccbe951b4652f43d7bbd087edb380.pack
 7f1b13509000-7f1b2604f000 r--p 00000000 fc:00 13370792
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-04da49cd5676b94d557fe984d9a844c1eae94477.pack
 7f1b2604f000-7f1b2623b000 r--p 00000000 fc:00 13371128
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-d79143b52a19edf04d485434f10663ccbb9eee88.pack
 7f1b2623b000-7f1b2629f000 r--p 00000000 fc:00 13370793
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-04da49cd5676b94d557fe984d9a844c1eae94477.idx
 7f1b2629f000-7f1b262a4000 r--p 00000000 fc:00 13371117
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-a72ab4cf996276ca527a26c6711414e97828aa01.idx
 7f1b262a4000-7f1b262a8000 r--p 00000000 fc:00 13371178
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-725eb21535f4d3782dce7c1f163c535ae46dd7a3.idx
 7f1b262a8000-7f1b262ab000 r--p 00000000 fc:00 13371184
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-a242e26dd75d9f94ac7cc021b79b5a23be86f772.idx
 7f1b262ab000-7f1b262af000 r--p 00000000 fc:00 13371189
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-8df0b1d878ce57e7b81439bfbbed75da58298d4f.idx
 7f1b262af000-7f1b262b3000 r--p 00000000 fc:00 13371202
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-e7279a5e263e36487664846efd3cf8e326e28b52.idx
 7f1b262b3000-7f1b262b6000 r--p 00000000 fc:00 13371277
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-334b5d2e30e802e8d11095d64348c61a6fabf4ab.idx
 7f1b262b6000-7f1b262b9000 r--p 00000000 fc:00 13371325
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-b9440d0950347a7f42994eecb3e4b96ac6cba2ef.idx
 7f1b262b9000-7f1b262bb000 r--p 00000000 fc:00 13372359
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-89264699af6b413cbcba76e68866a9531693dc2e.idx
 7f1b262bb000-7f1b262bd000 r--p 00000000 fc:00 13372428
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-c7d9d3af8fb96dd231186fcdb08c451e0aba3cc2.idx
 7f1b262bd000-7f1b262c0000 r--p 00000000 fc:00 13372645
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-f5fcf2f514ee6233964234e7d5947f03013b6b21.idx
 7f1b262c0000-7f1b262c2000 r--p 00000000 fc:00 13372762
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-dfb6ee684e3f58549254a7ddb18776670f64b8f5.idx
 7f1b262c2000-7f1b262c5000 r--p 00000000 fc:00 13372809
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-7067e4bd2b58f72bcb1a88a3df35cee5cc429090.idx
 7f1b262c5000-7f1b262f2000 r--p 00000000 fc:00 13371005
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-61336138de0ccbe951b4652f43d7bbd087edb380.idx
 7f1b262f2000-7f1b262f6000 r--p 00000000 fc:00 13371043
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-08a676f6ba45b69cd2a19a7d9f626bd24d9a7c6a.idx
 7f1b262f6000-7f1b262f9000 r--p 00000000 fc:00 13371072
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-075a4d75da5f11b72a3a9a68cb1e6209efe1080b.idx
 7f1b262f9000-7f1b262fb000 r--p 00000000 fc:00 13371073
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-8c618ce37614112a933a2dd02bfc4095813f9912.idx
 7f1b262fb000-7f1b26300000 r--p 00000000 fc:00 13371076
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-af68425c69ab8a50a8e6bb58e13d742f8b5d5edd.idx
 7f1b26300000-7f1b26306000 r--p 00000000 fc:00 13371129
   /home/git/repositories/sggroup/storegrid.git/objects/pack/pack-d79143b52a19edf04d485434f10663ccbb9eee88.idx
 7f1b26306000-7f1b265cf000 r--p 00000000 fc:00 530936
   /usr/lib/locale/locale-archive
 7f1b265cf000-7f1b26784000 r-xp 00000000 fc:00 18616016
   /lib/x86_64-linux-gnu/libc-2.15.so
 7f1b26784000-7f1b26983000 ---p 001b5000 fc:00 18616016
   /lib/x86_64-linux-gnu/libc-2.15.so
 7f1b26983000-7f1b26987000 r--p 001b4000 fc:00 18616016
   /lib/x86_64-linux-gnu/libc-2.15.so
 7f1b26987000-7f1b26989000 rw-p 001b8000 fc:00 18616016
   /lib/x86_64-linux-gnu/libc-2.15.so
 7f1b26989000-7f1b2698e000 rw-p 00000000 00:00 0
 7f1b2698e000-7f1b269a6000 r-xp 00000000 fc:00 18616018
   /lib/x86_64-linux-gnu/libpthread-2.15.so
 7f1b269a6000-7f1b26ba5000 ---p 00018000 fc:00 18616018
   /lib/x86_64-linux-gnu/libpthread-2.15.so
 7f1b26ba5000-7f1b26ba6000 r--p 00017000 fc:00 18616018
   /lib/x86_64-linux-gnu/libpthread-2.15.so
 7f1b26ba6000-7f1b26ba7000 rw-p 00018000 fc:00 18616018
   /lib/x86_64-linux-gnu/libpthread-2.15.so
 7f1b26ba7000-7f1b26bab000 rw-p 00000000 00:00 0
 7f1b26bab000-7f1b26bc3000 r-xp 00000000 fc:00 18616021
   /lib/x86_64-linux-gnu/libresolv-2.15.so
 7f1b26bc3000-7f1b26dc3000 ---p 00018000 fc:00 18616021
   /lib/x86_64-linux-gnu/libresolv-2.15.so
 7f1b26dc3000-7f1b26dc4000 r--p 00018000 fc:00 18616021
   /lib/x86_64-linux-gnu/libresolv-2.15.so
 7f1b26dc4000-7f1b26dc5000 rw-p 00019000 fc:00 18616021
   /lib/x86_64-linux-gnu/libresolv-2.15.so
 7f1b26dc5000-7f1b26dc7000 rw-p 00000000 00:00 0
 7f1b26dc7000-7f1b26ddd000 r-xp 00000000 fc:00 18612452
   /lib/x86_64-linux-gnu/libz.so.1.2.3.4
 7f1b26ddd000-7f1b26fdc000 ---p 00016000 fc:00 18612452
   /lib/x86_64-linux-gnu/libz.so.1.2.3.4
 7f1b26fdc000-7f1b26fdd000 r--p 00015000 fc:00 18612452
   /lib/x86_64-linux-gnu/libz.so.1.2.3.4
 7f1b26fdd000-7f1b26fde000 rw-p 00016000 fc:00 18612452
   /lib/x86_64-linux-gnu/libz.so.1.2.3.4
 7f1b26fde000-7f1b27000000 r-xp 00000000 fc:00 18616030
   /lib/x86_64-linux-gnu/ld-2.15.so
 7f1b271f3000-7f1b271f7000 rw-p 00000000 00:00 0
 7f1b271fe000-7f1b27200000 rw-p 00000000 00:00 0
 7f1b27200000-7f1b27201000 r--p 00022000 fc:00 18616030
   /lib/x86_64-linux-gnu/ld-2.15.so
 7f1b27201000-7f1b27203000 rw-p 00023000 fc:00 18616030
   /lib/x86_64-linux-gnu/ld-2.15.so
 7fff63db5000-7fff63dd6000 rw-p 00000000 00:00 0
   [stack]
 7fff63dff000-7fff63e00000 r-xp 00000000 00:00 0                          [vdso]
 ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
   [vsyscall]
