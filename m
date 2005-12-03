From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-update-server-info crashes on hera.kernel.org:/pub/scm/libs/klibc/klibc.git
Date: Sat, 03 Dec 2005 14:35:26 -0800
Message-ID: <43921DAE.7060606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 03 23:35:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eifye-0002zR-Cj
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 23:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLCWf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVLCWf3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 17:35:29 -0500
Received: from terminus.zytor.com ([192.83.249.54]:8647 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932154AbVLCWf2
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 17:35:28 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB3MZQVO017062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 14:35:26 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13171>

git-core-0.99.9j-1, and the backtrace is as follows:

: hera 29 ; ls -l /usr/lib/debug/usr/bin/git-update-
git-update-index.debug*       git-update-ref.debug* 
git-update-server-info.debug*
: hera 29 ; gdb -s /usr/lib/debug/usr/bin/git-update-server-info.debug 
/usr/bin/git-update-server-info
GNU gdb Red Hat Linux (6.3.0.0-1.63rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host 
libthread_db library "/lib/tls/libthread_db.so.1".

(gdb) run
Starting program: /usr/bin/git-update-server-info

Program received signal SIGSEGV, Segmentation fault.
0x0804c04c in nth_packed_object_sha1 (p=0x986a1f0, n=0, sha1=0xbfffc9f0 
"") at sha1_file.c:1017
1017            memcpy(sha1, (index + 24 * n + 4), 20);
(gdb) where
#0  0x0804c04c in nth_packed_object_sha1 (p=0x986a1f0, n=0, 
sha1=0xbfffc9f0 "") at sha1_file.c:1017
#1  0x08049a61 in update_server_info (force=0) at server-info.c:248
#2  0x08049466 in main (ac=1, av=0xbfffeed4) at update-server-info.c:22
#3  0x00ce1e23 in __libc_start_main () from /lib/tls/libc.so.6
#4  0x080493a1 in _start ()

	-hpa
