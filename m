From: felix-git@fefe.de
Subject: git completely non-operational w/ curl 7.16.0
Date: Thu, 4 Jan 2007 03:31:51 +0100
Message-ID: <20070104023150.GA31151@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 04 03:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2IV2-0002CC-MT
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbXADCie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbXADCie
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:38:34 -0500
Received: from ioctl.codeblau.de ([80.190.240.67]:50391 "EHLO codeblau.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932169AbXADCid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:38:33 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 21:38:32 EST
Received: (qmail 31192 invoked by uid 1000); 4 Jan 2007 02:31:51 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35906>

I'm using git 1.4.4.3 on x86_64-linux with curl 7.16.0, glibc 2.5, gcc
4.1.1 and binutils 2.17.  All of these are as far as I know the current
release versions.

Now, when I try to clone the elinks git repository, this happens:

  $ cg clone http://elinks.cz/elinks.git
  defaulting to local storage area
  Fetching head...
  Fetching objects...
  *** glibc detected *** git-http-fetch: double free or corruption (fasttop): 0x0000000000552390 ***
  ======= Backtrace: =========
  /lib64/libc.so.6[0x2ae65f64f45e]
  /lib64/libc.so.6(__libc_free+0xae)[0x2ae65f650784]
  git-http-fetch[0x4041bd]
  git-http-fetch[0x404f80]
  git-http-fetch[0x403027]
  git-http-fetch[0x404454]
  /lib64/libc.so.6(__libc_start_main+0x14b)[0x2ae65f60e6cb]
  git-http-fetch[0x4029c9]
  ======= Memory map: ========
  00400000-0041e000 r-xp 00000000 00:0d 772197                             /tmp/fefix/usr/bin/git-http-fetch
  0051d000-0051f000 rw-p 0001d000 00:0d 772197                             /tmp/fefix/usr/bin/git-http-fetch
  0051f000-0056e000 rw-p 0051f000 00:00 0                                  [heap]
  2ae65eeed000-2ae65ef05000 r-xp 00000000 08:03 12554262                   /lib64/ld-2.5.so
  2ae65ef05000-2ae65ef06000 rw-p 2ae65ef05000 00:00 0 
  2ae65ef12000-2ae65ef13000 rw-p 2ae65ef12000 00:00 0 
  2ae65f004000-2ae65f006000 rw-p 00017000 08:03 12554262                   /lib64/ld-2.5.so
  2ae65f006000-2ae65f01c000 r-xp 00000000 08:03 14996111                   /usr/lib64/libz.so.1.2.3
  2ae65f01c000-2ae65f11b000 ---p 00016000 08:03 14996111                   /usr/lib64/libz.so.1.2.3
  2ae65f11b000-2ae65f11c000 rw-p 00015000 08:03 14996111                   /usr/lib64/libz.so.1.2.3
  2ae65f11c000-2ae65f26c000 r-xp 00000000 08:03 14996178                   /usr/lib64/libcrypto.so.0.9.8
  2ae65f26c000-2ae65f36c000 ---p 00150000 08:03 14996178                   /usr/lib64/libcrypto.so.0.9.8
  2ae65f36c000-2ae65f38f000 rw-p 00150000 08:03 14996178                   /usr/lib64/libcrypto.so.0.9.8
  2ae65f38f000-2ae65f392000 rw-p 2ae65f38f000 00:00 0 
  2ae65f392000-2ae65f3cd000 r-xp 00000000 08:03 10667012                   /usr/lib64/libcurl.so.4.0.0
  2ae65f3cd000-2ae65f4cc000 ---p 0003b000 08:03 10667012                   /usr/lib64/libcurl.so.4.0.0
  2ae65f4cc000-2ae65f4ce000 rw-p 0003a000 08:03 10667012                   /usr/lib64/libcurl.so.4.0.0
  2ae65f4ce000-2ae65f4cf000 rw-p 2ae65f4ce000 00:00 0 
  2ae65f4cf000-2ae65f4ef000 r-xp 00000000 08:03 10667121                   /usr/lib64/libexpat.so.0.5.0
  2ae65f4ef000-2ae65f5ef000 ---p 00020000 08:03 10667121                   /usr/lib64/libexpat.so.0.5.0
  2ae65f5ef000-2ae65f5f1000 rw-p 00020000 08:03 10667121                   /usr/lib64/libexpat.so.0.5.0
  2ae65f5f1000-2ae65f6fe000 r-xp 00000000 08:03 12554263                   /lib64/libc-2.5.so
  2ae65f6fe000-2ae65f7fe000 ---p 0010d000 08:03 12554263                   /lib64/libc-2.5.so
  2ae65f7fe000-2ae65f801000 r--p 0010d000 08:03 12554263                   /lib64/libc-2.5.so
  2ae65f801000-2ae65f803000 rw-p 00110000 08:03 12554263                   /lib64/libc-2.5.so
  2ae65f803000-2ae65f808000 rw-p 2ae65f803000 00:00 0 
  2ae65f808000-2ae65f80a000 r-xp 00000000 08:03 12554244                   /lib64/libdl-2.5.so
  2ae65f80a000-2ae65f90a000 ---p 00002000 08:03 12554244                   /lib64/libdl-2.5.so
  2ae65f90a000-2ae65f90c000 rw-p 00002000 08:03 12554244                   /lib64/libdl-2.5.so
  2ae65f90c000-2ae65f90d000 rw-p 2ae65f90c000 00:00 0 
  2ae65f90d000-2ae65f94e000 r-xp 00000000 08:03 14996177                   /usr/lib64/libssl.so.0.9.8
  2ae65f94e000-2ae65fa4e000 ---p 00041000 08:03 14996177                   /usr/lib64/libssl.so.0.9.8
  2ae65fa4e000-2ae65fa54000 rw-p 00041000 08:03 14996177                   /usr/lib64/libssl.so.0.9.8
  2ae65fa54000-2ae65fa55000 rw-p 2ae65fa54000 00:00 0 
  2ae65fa55000-2ae65fa5c000 r-xp 00000000 08:03 12554260                   /lib64/libnss_compat-2.5.so
  2ae65fa5c000-2ae65fb5b000 ---p 00007000 08:03 12554260                   /lib64/libnss_compat-2.5.so
  2ae65fb5b000-2ae65fb5d000 rw-p 00006000 08:03 12554260                   /lib64/libnss_compat-2.5.so
  2ae65fb5d000-2ae65fb6e000 r-xp 00000000 08:03 12554257                   /lib64/libnsl-2.5.so
  2ae65fb6e000-2ae65fc6d000 ---p 00011000 08:03 12554257                   /lib64/libnsl-2.5.so
  2ae65fc6d000-2ae65fc6f000 rw-p 00010000 08:03 12554257                   /lib64/libnsl-2.5.so
  2ae65fc6f000-2ae65fc71000 rw-p 2ae65fc6f000 00:00 0 
  2ae65fc71000-2ae65fc7a000 r-xp 00000000 08:03 12554258                   /lib64/libnss_nis-2.5.so
  2ae65fc7a000-2ae65fd79000 ---p 00009000 08:03 12554258                   /lib64/libnss_nis-2.5.so
  2ae65fd79000-2ae65fd7b000 rw-p 00008000 08:03 12554258                   /lib64/libnss_nis-2.5.so
  2ae65fd7b000-2ae65fd84000 r-xp 00000000 08:03 12554251                   /lib64/libnss_files-2.5.so
  2ae65fd84000-2ae65fe83000 ---p 00009000 08:03 12554251                   /lib64/libnss_files-2.5.so
  2ae65fe83000-2ae65fe85000 rw-p 00008000 08:03 12554251                   /lib64/libnss_files-2.5.so
  2ae65fe85000-2ae65fe92000 r-xp 00000000 08:03 14995967                   /usr/lib64/libgcc_s.so.1
  2ae65fe92000-2ae65ff91000 ---p 0000d000 08:03 14995967                   /usr/lib64/libgcc_s.so.1
  2ae65ff91000-2ae65ff92000 rw-p 0000c000 08:03 14995967                   /usr/lib64/libgcc_s.so.1
  2ae660000000-2ae660021000 rw-p 2ae660000000 00:00 0 
  2ae660021000-2ae664000000 ---p 2ae660021000 00:00 0 
  7fff4bba8000-7fff4bbbd000 rwxp 7fff4bba8000 00:00 0                      [stack]
  ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0                  [vdso]
  error: Request for 1e8f8aa4a60a9651e17347d36a880c35c7179391 aborted
  progress: 0 objects, 0 bytes
  cg-fetch: objects fetch failed

As you can see this is somewhat undesireable.  The double free is line
316 in http-fetch.c:

        free(obj_req->url);

If I fix this bug, git still utterly breaks.

  $ cg clone http://elinks.cz/elinks.git
  defaulting to local storage area
  Fetching head...
  Fetching objects...
  error: Request for 1e8f8aa4a60a9651e17347d36a880c35c7179391 aborted
  Getting pack list for http://elinks.cz/elinks.git/
  error: Unable to start request
  Getting alternates list for http://elinks.cz/elinks.git/
  error: Unable to find 1e8f8aa4a60a9651e17347d36a880c35c7179391 under
  http://elinks.cz/elinks.git/
  Cannot obtain needed object 1e8f8aa4a60a9651e17347d36a880c35c7179391
  progress: 0 objects, 0 bytes
  cg-fetch: objects fetch failed
  $

Now, running the same git/cogito command line on my Gentoo box works,
which only apparently differs in that it ships an older version of curl.

Would someone please fix this?

Thanks,

Felix
