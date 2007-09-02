From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: git clone over http
Date: Sun, 2 Sep 2007 11:23:03 +0200
Message-ID: <200709021123.04218.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 11:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRleB-0004RQ-J5
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 11:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbXIBJVb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 05:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755020AbXIBJVb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 05:21:31 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13616 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbXIBJVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 05:21:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A1D84802849
	for <git@vger.kernel.org>; Sun,  2 Sep 2007 11:13:36 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27899-04 for <git@vger.kernel.org>; Sun,  2 Sep 2007 11:13:36 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 27F8E8003E1
	for <git@vger.kernel.org>; Sun,  2 Sep 2007 11:13:36 +0200 (CEST)
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57309>


git clone (1.5.3) with http is somewhat unreliable. I've noticed if can actually give
me different versions of a branch each time I run it, eventually yielding
the one I'm expecting.  And now this:

(Using master, just after rc7)
$ git clone http://unix.schottelius.org/git/cLinux/cinit.git
Initialized empty Git repository in /home/me/tmp/cinit/.git/
got c56b79346e5058762db82cb98647628ddf3d6ebd
walk c56b79346e5058762db82cb98647628ddf3d6ebd
got c0d6c3ae3b4999892d7cbc22fd719c0e9797be59
got 73dc306099bdb21abf22e4a015d3059e8577bb49
got 6943289356f8431073cb8c7708bb7c9c05888333
walk 6943289356f8431073cb8c7708bb7c9c05888333
Getting alternates list for http://unix.schottelius.org/git/cLinux/cinit.git
got 3912109b5cd65a68039d473c11c9f7ac2303e06d
got 0fbf76f58b248f6b11421db5aa9c02fe12b0ce7d
Getting pack list for http://unix.schottelius.org/git/cLinux/cinit.git
got 3ac57ee54f4c4e350622888c4e37213a7d2337b7
got a170a50db31947dfae0b27d5dd8bb54b5ac97b20
got 00f2651b7c63c56fda93d2f94cc2a2b7c28ac86b
Getting index for pack 119f90491743d6454866ba8761f49757e359cec1
got eec4105805e9f57b27158f847c9ce1b2b6eb40c7
got 8a686b4ae9cbb91a74ff71984baee0c944950c05
Getting index for pack 22000d3bf6fc9fdf439f63c8b33817f5786298f6
got dc4d9d9a69310c7d4f8e1fdf6517c10e8c6ab227
Getting index for pack 41850f3f697748a77d37d4d210415031bc6c73c4

/usr/local/bin/git-clone: line 40: 14823 Segmenteringsfel        git-http-fetch $v -a -w "$tname" "$sha1" "$1"

It doesn't repeat itself, but I cannot clone because it always crashes.

[me@lathund tmp]$ git clone http://unix.schottelius.org/git/cLinux/cinit.git
Initialized empty Git repository in /home/me/tmp/cinit/.git/
got c56b79346e5058762db82cb98647628ddf3d6ebd
walk c56b79346e5058762db82cb98647628ddf3d6ebd
got c0d6c3ae3b4999892d7cbc22fd719c0e9797be59
got 73dc306099bdb21abf22e4a015d3059e8577bb49
got 6943289356f8431073cb8c7708bb7c9c05888333
walk 6943289356f8431073cb8c7708bb7c9c05888333
got 0fbf76f58b248f6b11421db5aa9c02fe12b0ce7d
Getting alternates list for http://unix.schottelius.org/git/cLinux/cinit.git
got 3912109b5cd65a68039d473c11c9f7ac2303e06d

!! now wait a minute. Why isn't it getting 0fbf76f58b248f6b11421db5aa9c02fe12b0ce7d
here like it did?

Getting pack list for http://unix.schottelius.org/git/cLinux/cinit.git
got a170a50db31947dfae0b27d5dd8bb54b5ac97b20
got 00f2651b7c63c56fda93d2f94cc2a2b7c28ac86b
Getting index for pack 119f90491743d6454866ba8761f49757e359cec1
got eec4105805e9f57b27158f847c9ce1b2b6eb40c7

etc a hundred objects or so:

got f0d2e75fa8247f246aeb8ecdadd94d307481ea78
got 3b01bfe1a064a4407bd6308cc4f02fcc2ac0d9a7
got 3c54e71aca555fcfc163809669aa39426cb52421
got 750e330305676e09479f63532782ce93462e71f5
*** glibc detected *** git-http-fetch: corrupted double-linked list: 0x080dd9f0 ***
======= Backtrace: =========
/lib/i686/libc.so.6[0x44c99516]
/lib/i686/libc.so.6[0x44c9b728]
/lib/i686/libc.so.6(__libc_malloc+0x85)[0x44c9d075]
/lib/libz.so.1(zcalloc+0x20)[0x44d9dfd0]
git-http-fetch[0x804cb78]
git-http-fetch[0x804ae2b]
git-http-fetch[0x804aeab]
git-http-fetch[0x804d265]
git-http-fetch[0x804a732]
git-http-fetch[0x804c240]
/lib/i686/libc.so.6(__libc_start_main+0xdc)[0x44c4bd8c]
git-http-fetch[0x804a071]

I'll spare you the detfailt unless you want it.

-- robin
