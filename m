From: Jon Smirl <jonsmirl@gmail.com>
Subject: Fault in curl on Ubuntu 9.04 with git 1.6.3
Date: Thu, 7 May 2009 22:07:16 -0400
Message-ID: <9e4733910905071907q44de8980je4008695092d4a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 08 04:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2FUm-0001dv-84
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 04:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZEHCHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 22:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbZEHCHS
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 22:07:18 -0400
Received: from mail-qy0-f129.google.com ([209.85.221.129]:59636 "EHLO
	mail-qy0-f129.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZEHCHR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 22:07:17 -0400
Received: by qyk35 with SMTP id 35so451689qyk.33
        for <git@vger.kernel.org>; Thu, 07 May 2009 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=pNjzpFl9TnQIMiRkx4fZVGIzigmAku2OTfasSUg5snQ=;
        b=n/MUNVt8VjMeMk+Vx0cFC8J0by4GDYGcjYji/HY1u0SqMszbt4yfn0qct09mbRe3Iy
         mWA6PFIPeBzPEfP02wklgvc+p4hVF7lvhl7Jx16WEcHQr077kxXbVMURPaEQWD9Dr3Dt
         FntfcYz/WTQ/IhIL01V7ozrvUbUBDtPshnwWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lJJyAefH/ZJQid0J2TxN4st0Y6aZ/ZpMxHkcbcc8qEww5ZNi6qPcZyvImqA1iddOlQ
         JYYcD6KalaW4QKam4f8T2hqJpLTm5wvBTFymTg41AxIJu2J89W/RjTjnSYhRAup0R1bv
         gqQ7+uw9eBu9F4Px7k1OrYQ0Biy10pUofJehY=
Received: by 10.220.95.75 with SMTP id c11mr6902852vcn.1.1241748436869; Thu, 
	07 May 2009 19:07:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118558>

It's doing a fetch of a remote http server...
I hit this once. Then ran the gdb and hit it again.

I installed libcurl3-dbg and was unable to get it to reproduce again after that.

(gdb) set args fetch ds
(gdb) go
Undefined command: "go".  Try "help".
(gdb) run
Starting program: /usr/local/bin/git fetch ds
[Thread debugging using libthread_db enabled]
[New Thread 0x7f2b89134710 (LWP 22527)]
walk ef43259a2962371cf15f5e3690392e347d60aadb
walk a34828bff3ca67f6f58fff254f5068ef058bc8e6
walk acef302356c187723b61202d4736d059c1bcbc5b
walk 586ef118cc127200faf1f8c1dfeac5eebcaff936
walk 098f6ff7f0588c7c4565e5be02dbd31d4e78c927
walk 43c6d90c91b1aa84bed9785d5bd6f0b38425500d
Resuming fetch of object b031c08ff07c8b559c01d72ef76500a3518968ff at byte 7828
walk f1c49c1b97c74bff24e2a8ccf156becb508d3238
walk defbbaf0927125fc5e4b05b21f1818828504a580
walk cc04a5e1b5c858844b1c33f16409558a43f316c4
walk 00926250cae235cab08c442e87856f5d3f7f6785
Warning: requested range invalid; we may already have all the data.
got b031c08ff07c8b559c01d72ef76500a3518968ff
got 8c7cd8cf6deb03c1762d8de2d309816e3bcd5837
got 236b94e996e63623cf10c2c0ffb75ff58661f16d
got 8fc56c7c2baa6435377dbaa07c7284020db58933
got e1ce94c1f8bb3d6733976f7cf99156aabc014389
walk 236b94e996e63623cf10c2c0ffb75ff58661f16d
got 611bb77e319a7c4e8b9f71c0855da5290f5aa2ae
....more...

ot b52db27d6c7dae2fcd94c8c6632037595d733940
got 9950066210046f98fb364c3bc518eef6b8cfe64a
got 956c62eb0640ddc2a940c8c7ca67aa8f78566a7b

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7f2b89134710 (LWP 22527)]
0x00007f2b88d299d0 in ?? () from /usr/lib/libcurl.so.4
(gdb)  bt
#0  0x00007f2b88d299d0 in ?? () from /usr/lib/libcurl.so.4
#1  0x00007f2b88d2a55c in ?? () from /usr/lib/libcurl.so.4
#2  0x00007f2b88d2a762 in ?? () from /usr/lib/libcurl.so.4
#3  0x00007f2b88d2b24b in curl_multi_perform () from /usr/lib/libcurl.so.4
#4  0x00000000004ac15f in step_active_slots () at http.c:509
#5  0x00000000004a845d in process (walker=0x7364f0, obj=0x9532b8) at
walker.c:152
#6  0x00000000004a8c34 in walker_fetch (walker=0x7364f0, targets=2,
target=<value optimized out>, write_ref=0x0,
write_ref_log_details=0x0)
    at walker.c:56
#7  0x00000000004a21a1 in fetch_objs_via_curl (transport=0x10,
nr_objs=2, to_fetch=0x7705a0) at transport.c:375
#8  0x00000000004a1153 in transport_fetch_refs (transport=0x736360,
refs=<value optimized out>) at transport.c:1064
#9  0x0000000000423592 in fetch_refs (transport=0x736360, ref_map=0x0)
at builtin-fetch.c:452
#10 0x0000000000423b3a in cmd_fetch (argc=<value optimized out>,
argv=0x7fff9115f560, prefix=<value optimized out>) at
builtin-fetch.c:581
#11 0x0000000000404cb3 in handle_internal_command (argc=2,
argv=0x7fff9115f560) at git.c:247
#12 0x0000000000404ea4 in main (argc=2, argv=0x7fff9115f560) at git.c:438
(gdb)

jonsmirl@terra:~/fs$ sudo dpkg -S  /usr/lib/libcurl.so.4
libcurl3: /usr/lib/libcurl.so.4
jonsmirl@terra:~/fs$ sudo dpkg --status libcurl3
Package: libcurl3
Status: install ok installed
Priority: optional
Section: libs
Installed-Size: 444
Maintainer: Ubuntu Core Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: amd64
Source: curl
Version: 7.18.2-8ubuntu4
Replaces: libcurl2 (<< 1:7.11.2-2), libcurl4
Depends: libc6 (>= 2.4), libidn11 (>= 0.5.18), libkrb53 (>=
1.6.dfsg.2), libldap-2.4-2 (>= 2.4.7), libssl0.9.8 (>= 0.9.8f-5),
zlib1g (>= 1:1.1.4), ca-certificates
Conflicts: libcurl4
Description: Multi-protocol file transfer library (OpenSSL)
 libcurl is designed to be a solid, usable, reliable and portable
 multi-protocol file transfer library.
 .
 SSL support is provided by OpenSSL.
 .
 This is the shared version of libcurl.
Homepage: http://curl.haxx.se
Original-Maintainer: Domenico Andreoli <cavok@debian.org>
jonsmirl@terra:~/fs$



-- 
Jon Smirl
jonsmirl@gmail.com
