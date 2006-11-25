X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Blake <ebb9@byu.net>
Subject: git on cygwin
Date: Sat, 25 Nov 2006 07:38:23 -0700
Message-ID: <4568555F.8050500@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 14:41:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
X-Enigmail-Version: 0.94.1.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32288>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnyiY-0006r4-NR for gcvg-git@gmane.org; Sat, 25 Nov
 2006 15:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966586AbWKYOkW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 09:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966594AbWKYOkW
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 09:40:22 -0500
Received: from alnrmhc11.comcast.net ([204.127.225.91]:28297 "EHLO
 alnrmhc11.comcast.net") by vger.kernel.org with ESMTP id S966586AbWKYOkV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 09:40:21 -0500
Received: from [192.168.0.103]
 (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225]) by comcast.net
 (alnrmhc11) with ESMTP id <20061125144020b1100skqede>; Sat, 25 Nov 2006
 14:40:20 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I found the following patch useful for building git 1.4.4.1 on cygwin.  As
of cygwin-1.5.22, C99 format strings are now supported (since I
contributed the newlib patch that added them).  As of cygwin-1.5.21, d_ino
is now reliable for all cygwin filesystem accesses (except for some remote
NetApp drives, which have been fixed in cygwin CVS).  And while it is true
that native Windows does not support symlinks, making NO_SYMLINK_HEAD a
good idea for native builds; this is not the case for cygwin, and I did
not seem to have any problems with removing it, either.

- --- origsrc/git-1.4.4.1/Makefile        2006-11-22 19:38:07.000000000 -0700
+++ src/git-1.4.4.1/Makefile    2006-11-24 17:51:00.600344000 -0700
@@ -369,11 +369,8 @@
 endif
 ifeq ($(uname_O),Cygwin)
        NO_D_TYPE_IN_DIRENT = YesPlease
- -       NO_D_INO_IN_DIRENT = YesPlease
        NO_STRCASESTR = YesPlease
- -       NO_SYMLINK_HEAD = YesPlease
        NEEDS_LIBICONV = YesPlease
- -       NO_C99_FORMAT = YesPlease
        # There are conflicting reports about this.
        # On some boxes NO_MMAP is needed, and not so elsewhere.
        # Try uncommenting this if you see things break -- YMMV.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFaFVe84KuGfSFAYARAjdrAJ9A+d9/aaEG0V2j8VTs/oycIpUS0wCeL/Ly
70V5CWHOrAKD7kI09gQiTh0=
=C8dP
