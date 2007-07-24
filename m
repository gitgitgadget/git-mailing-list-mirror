From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: http git clone memory problem.
Date: Mon, 23 Jul 2007 20:44:22 -0700
Message-ID: <1621f9fa0707232044j7cec2bes7bc7cd268775ce48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 05:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDBK1-00088t-7Y
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 05:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbXGXDoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 23:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756464AbXGXDoZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 23:44:25 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:17289 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbXGXDoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 23:44:24 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1286312nze
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 20:44:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OeY6bR9X35j7fiHLsNOPG93cuNRqZCf83XDjGf2pTEaRD7zMFMa3IwmqQ4XpR72uBzFA+4sKDxVG0tDUmUbmwDZXP9EkgX3rHR5i8gQCV7FDUD/VLdWHcFcXDPO7/CEoiYGuy+1OzgQ8HOUyIviGA0gmB45KV5ollWQ0wNf0kXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AQn9xaY4DFbc+QOEpQhJtMQKOgRDkwAh0kT2hew8pbxnLCqASui5UP/LBR16i2mzR1SyBqvnDxoZA09DAMAmvoYGywWDTu1e/y0pqHlgrFEtg9a9yO4bRmOLSaM3GA+HeYZKnd7nDjp3ammZl69KdsW6Bc77kXI3Npivpl55XMY=
Received: by 10.142.102.5 with SMTP id z5mr265129wfb.1185248662945;
        Mon, 23 Jul 2007 20:44:22 -0700 (PDT)
Received: by 10.143.19.17 with HTTP; Mon, 23 Jul 2007 20:44:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53522>

 - Sorry for the noise if this has already been reported.
 - It's on a Mandriva Spring machine with git 1.5.0.4
 - It's a glibc detected memory error. If I restart with
MALLOC_CHECK_=0 I dont' get the crash.

[bsergean@marge1 src]$ git --version
git version 1.5.0.4
[bsergean@marge1 src]$ git clone http://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /home/bsergean/src/git/.git/
got de9879a91fd7d4d123a303b4bcdc918f43ca3a62
walk de9879a91fd7d4d123a303b4bcdc918f43ca3a62
got 68cb399f1760d4a54ae9ff1f367fea8b6bed9453
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
got f6002a9d88be66b5d7ac79bf312feb0b622791ca
walk f6002a9d88be66b5d7ac79bf312feb0b622791ca
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
Getting index for pack 6ce718d496eba4857e76cc9b8f7a1a82f5dfb416
got 896ff1d95a2a307fd764b66de4fbd882e64dd9c6
*** glibc detected *** git-http-fetch: corrupted double-linked list:
0x0808ad50 ***
======= Backtrace: =========
/lib/i686/libc.so.6[0xb7c35516]
/lib/i686/libc.so.6[0xb7c37728]
/lib/i686/libc.so.6(__libc_malloc+0x85)[0xb7c39075]
/lib/libz.so.1(zcalloc+0x20)[0xb7edbfd0]
git-http-fetch[0x804c6e8]
git-http-fetch[0x804a9bb]
git-http-fetch[0x804aa3b]
git-http-fetch[0x804db94]
git-http-fetch[0x804a310]
git-http-fetch[0x804cb97]
/lib/i686/libc.so.6(__libc_start_main+0xdc)[0xb7be7d8c]
git-http-fetch[0x8049c31]
======= Memory map: ========
08048000-08068000 r-xp 00000000 03:02 506123     /usr/bin/git-http-fetch
08068000-08069000 rwxp 00020000 03:02 506123     /usr/bin/git-http-fetch
08069000-08436000 rwxp 08069000 00:00 0          [heap]
b7900000-b7921000 rwxp b7900000 00:00 0
b7921000-b7a00000 ---p b7921000 00:00 0
b7ad9000-b7ae3000 r-xp 00000000 03:02 678969     /lib/libgcc_s-4.1.2.so.1
b7ae3000-b7ae4000 rwxp 0000a000 03:02 678969     /lib/libgcc_s-4.1.2.so.1
b7af9000-b7b19000 rwxp b7af9000 00:00 0
b7b19000-b7b27000 r-xp 00000000 03:02 678959     /lib/libresolv-2.4.so
b7b27000-b7b29000 rwxp 0000e000 03:02 678959     /lib/libresolv-2.4.so
b7b29000-b7b2b000 rwxp b7b29000 00:00 0
b7b2b000-b7b2f000 r-xp 00000000 03:02 678947     /lib/libnss_dns-2.4.so
b7b2f000-b7b31000 rwxp 00003000 03:02 678947     /lib/libnss_dns-2.4.so
b7b31000-b7b41000 r-xp 00000000 03:02 678943     /lib/libnsl-2.4.so
b7b41000-b7b43000 rwxp 00010000 03:02 678943     /lib/libnsl-2.4.so
b7b43000-b7b45000 rwxp b7b43000 00:00 0
b7b45000-b7b4d000 r-xp 00000000 03:02 678953     /lib/libnss_nis-2.4.so
b7b4d000-b7b4f000 rwxp 00007000 03:02 678953     /lib/libnss_nis-2.4.so
b7b4f000-b7b57000 r-xp 00000000 03:02 678949     /lib/libnss_files-2.4.so
b7b57000-b7b59000 rwxp 00007000 03:02 678949     /lib/libnss_files-2.4.so
b7b59000-b7b5a000 rwxp b7b59000 00:00 0
b7b5a000-b7b99000 r-xp 00000000 03:02 36383      /usr/lib/libssl.so.0.9.8
b7b99000-b7b9d000 rwxp 0003e000 03:02 36383      /usr/lib/libssl.so.0.9.8
b7b9d000-b7bcd000 r-xp 00000000 03:02 215594     /usr/lib/libidn.so.11.5.23
b7bcd000-b7bce000 rwxp 0002f000 03:02 215594     /usr/lib/libidn.so.11.5.23
b7bce000-b7bd0000 r-xp 00000000 03:02 678939     /lib/libdl-2.4.so
b7bd0000-b7bd2000 rwxp 00001000 03:02 678939     /lib/libdl-2.4.so
b7bd2000-b7cfb000 r-xp 00000000 03:02 678918     /lib/i686/libc-2.4.so
b7cfb000-b7cfc000 r-xp 00129000 03:02 678918     /lib/i686/libc-2.4.so
b7cfc000-b7cfe000 rwxp 0012a000 03:02 678918     /lib/i686/libc-2.4.so
b7cfe000-b7d02000 rwxp b7cfe000 00:00 0
b7d02000-b7d20000 r-xp 00000000 03:02 215102     /usr/lib/libexpat.so.0.5.0
b7d20000-b7d22000 rwxp 0001e000 03:02 215102     /usr/lib/libexpat.so.0.5.0
b7d22000-b7d70000 r-xp 00000000 03:02 215628     /usr/lib/libcurl.so.4.0.0
b7d70000-b7d71000 rwxp 0004d000 03:02 215628     /usr/lib/libcurl.so.4.0.0
b7d71000-b7ebc000 r-xp 00000000 03:02 36382      /usr/lib/libcrypto.so.0.9.8
b7ebc000-b7ed1000 rwxp 0014b000 03:02 36382      /usr/lib/libcrypto.so.0.9.8
b7ed1000-b7ed4000 rwxp b7ed1000 00:00 0
b7ed4000-b7ee6000 r-xp 00000000 03:02 678968     /lib/libz.so.1.2.3
b7ee6000-b7ee7000 rwxp 00011000 03:02 678968     /lib/libz.so.1.2.3
b7efc000-b7efd000 rwxp b7efc000 00:00 0
b7efd000-b7f15000 r-xp 00000000 03:02 678928     /lib/ld-2.4.so
b7f15000-b7f16000 r-xp 00017000 03:02 678928     /lib/ld-2.4.so
b7f16000-b7f17000 rwxp 00018000 03:02 678928     /lib/ld-2.4.so
bfd02000-bfd18000 rw-p bfd02000 00:00 0          [stack]
bfffe000-bffff000 r-xp bfffe000 00:00 0
/usr/bin/git-clone: line 33: 12780 Aborted
git-http-fetch -v -a -w "$tname" "$name" "$1/"


Benjamin.
