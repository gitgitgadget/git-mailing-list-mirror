X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: git 1.4.4.1.gba98 crash pulling tig
Date: Tue, 05 Dec 2006 16:25:13 -0300
Message-ID: <200612051925.kB5JPDUX020526@laptop13.inf.utfsm.cl>
NNTP-Posting-Date: Tue, 5 Dec 2006 19:25:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 05 Dec 2006 16:25:13 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33366>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grfus-00042Z-09 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 20:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968655AbWLETZR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 14:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968657AbWLETZR
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 14:25:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60767 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968655AbWLETZP (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 14:25:15 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kB5JPDa5009807
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Tue, 5 Dec 2006 16:25:13 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kB5JPDUX020526 for
 <git@vger.kernel.org>; Tue, 5 Dec 2006 16:25:13 -0300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On i686, Fedora rawhide fully up to date, git version 1.4.4.1.gba98,
compiled with the standard CFLAGS and all. It happens to me all the time
fetching via HTTP. Trying to clone tig gives:

[vonbrand@laptop13 tmp]$ PATH=~/bin:$PATH git clone http://jonas.nitro.dk/tig/tig.git
error: Unable to start request
error: Could not interpret heads/release as something to pull

On sparc (Aurora Corona up to date) it works fine. Trying to pull the same
repo crashes as below on i386, the pull works on sparc, and I can pull from
there to this machine via git+ssh. Any way I can debug this further?

[vonbrand@laptop13 tig]$ PATH=~/bin:$PATH git pull
Fetching refs/heads/master from http://jonas.nitro.dk/tig/tig.git using http
error: Request for 56e652be994f94b724f79cea0712663a62308034 aborted
*** glibc detected *** git-http-fetch: double free or corruption (fasttop): 0x08084b60 ***
======= Backtrace: =========
/lib/libc.so.6[0x4e2d8e3d]
/lib/libc.so.6(cfree+0x90)[0x4e2dc490]
git-http-fetch[0x804b2ec]
git-http-fetch[0x804c671]
git-http-fetch[0x804a0c7]
git-http-fetch[0x804b5a8]
/lib/libc.so.6(__libc_start_main+0xdc)[0x4e288e5c]
git-http-fetch[0x8049ae1]
======= Memory map: ========
08048000-08062000 r-xp 00000000 fd:01 559254     /home/vonbrand/bin/git-http-fetch
08062000-08063000 rw-p 00019000 fd:01 559254     /home/vonbrand/bin/git-http-fetch
08063000-080ba000 rw-p 08063000 00:00 0          [heap]
4d8a2000-4d8bd000 r-xp 00000000 fd:00 33074      /lib/ld-2.5.90.so
4d8bd000-4d8be000 r--p 0001a000 fd:00 33074      /lib/ld-2.5.90.so
4d8be000-4d8bf000 rw-p 0001b000 fd:00 33074      /lib/ld-2.5.90.so
4d8c1000-4d9dd000 r-xp 00000000 fd:00 33087      /lib/libcrypto.so.0.9.8b
4d9dd000-4d9ef000 rw-p 0011c000 fd:00 33087      /lib/libcrypto.so.0.9.8b
4d9ef000-4d9f3000 rw-p 4d9ef000 00:00 0 
4d9f5000-4da05000 r-xp 00000000 fd:00 33085      /lib/libresolv-2.5.90.so
4da05000-4da06000 r--p 0000f000 fd:00 33085      /lib/libresolv-2.5.90.so
4da06000-4da07000 rw-p 00010000 fd:00 33085      /lib/libresolv-2.5.90.so
4da07000-4da09000 rw-p 4da07000 00:00 0 
4da53000-4da55000 r-xp 00000000 fd:00 33086      /lib/libcom_err.so.2.1
4da55000-4da56000 rw-p 00001000 fd:00 33086      /lib/libcom_err.so.2.1
4da8b000-4dab5000 r-xp 00000000 fd:03 502786     /usr/lib/libgssapi_krb5.so.2.2
4dab5000-4dab6000 rw-p 00029000 fd:03 502786     /usr/lib/libgssapi_krb5.so.2.2
4dab8000-4dabf000 r-xp 00000000 fd:03 502648     /usr/lib/libkrb5support.so.0.1
4dabf000-4dac0000 rw-p 00006000 fd:03 502648     /usr/lib/libkrb5support.so.0.1
4dac2000-4dae7000 r-xp 00000000 fd:03 502680     /usr/lib/libk5crypto.so.3.0
4dae7000-4dae8000 rw-p 00025000 fd:03 502680     /usr/lib/libk5crypto.so.3.0
4daea000-4db6f000 r-xp 00000000 fd:03 502695     /usr/lib/libkrb5.so.3.2
4db6f000-4db71000 rw-p 00084000 fd:03 502695     /usr/lib/libkrb5.so.3.2
4db73000-4dbb4000 r-xp 00000000 fd:00 33088      /lib/libssl.so.0.9.8b
4dbb4000-4dbb8000 rw-p 00040000 fd:00 33088      /lib/libssl.so.0.9.8b
4dbba000-4dbea000 r-xp 00000000 fd:03 505200     /usr/lib/libidn.so.11.5.22
4dbea000-4dbeb000 rw-p 0002f000 fd:03 505200     /usr/lib/libidn.so.11.5.22
4dc25000-4dc61000 r-xp 00000000 fd:03 505465     /usr/lib/libcurl.so.4.0.0
4dc61000-4dc62000 rw-p 0003c000 fd:03 505465     /usr/lib/libcurl.so.4.0.0
4e273000-4e3be000 r-xp 00000000 fd:00 33075      /lib/libc-2.5.90.so
4e3be000-4e3c0000 r--p 0014b000 fd:00 33075      /lib/libc-2.5.90.so
4e3c0000-4e3c1000 rw-p 0014d000 fd:00 33075      /lib/libc-2.5.90.so
4e3c1000-4e3c4000 rw-p 4e3c1000 00:00 0 
4e3f1000-4e3f4000 r-xp 00000000 fd:00 33076      /lib/libdl-2.5.90.so
4e3f4000-4e3f5000 r--p 00002000 fd:00 33076      /lib/libdl-2.5.90.so
4e3f5000-4e3f6000 rw-p 00003000 fd:00 33076      /lib/libdl-2.5.90.so
4e412000-4e424000 r-xp 00000000 fd:03 498995     /usr/lib/libz.so.1.2.3
4e424000-4e425000 rw-p 00011000 fd:03 498995     /usr/lib/libz.so.1.2.3
4e636000-4e655000 r-xp 00000000 fd:00 33083      /lib/libexpat.so.0.5.0
4e655000-4e657000 rw-p 0001e000 fd:00 33083      /lib/libexpat.so.0.5.0
4ee44000-4ee4f000 r-xp 00000000 fd:00 33084      /lib/libgcc_s-4.1.1-20061130.so.1
4ee4f000-4ee50000 rw-p 0000a000 fd:00 33084      /lib/libgcc_s-4.1.1-20061130.so.1
b7e00000-b7e21000 rw-p b7e00000 00:00 0 
b7e21000-b7f00000 ---p b7e21000 00:00 0 
b7f6d000-b7fd5000 r--p 00000000 fd:01 955780     /home/vonbrand/tmp/tig/.git/objects/pack/pack-c1fd326a6b3d7c1aa4e1b542dd5f3aeb45eb6582.pack
b7fd5000-b7fdf000 r-xp 00000000 fd:00 33048      /lib/libnss_files-2.5.90.so
b7fdf000-b7fe0000 r--p 00009000 fd:00 33048      /lib/libnss_files-2.5.90.so
b7fe0000-b7fe1000 rw-p 0000a000 fd:00 33048      /lib/libnss_files-2.5.90.so
b7fe1000-b7fe6000 rw-p b7fe1000 00:00 0 
b7ff4000-b7ffa000 r--p 00000000 fd:01 956575     /home/vonbrand/tmp/tig/.git/objects/pack/pack-c1fd326a6b3d7c1aa4e1b542dd5f3aeb45eb6582.idx
b7ffa000-b7ffb000 r-xp b7ffa000 00:00 0        /home/vonbrand/bin/git-fetch: line 300: 20236 Aborted                 git-http-fetch -v -a "$head" "$remote/"
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
