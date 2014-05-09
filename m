From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/17] contrib: remove 'svn-fe'
Date: Fri,  9 May 2014 14:11:38 -0500
Message-ID: <1399662703-355-13-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDu-0001jz-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267AbaEITMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:38 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:38446 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241AbaEITMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:36 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so4228697yhl.9
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nKB8zzFOYtjuvJzNTV/QApcJ4G1zRKNCY/H3GoVSpC4=;
        b=xDP2ZflqiXnqi/Kz8J6esa/zfTCh2rkecL2r0D9acZt9QPdGvIKY5iE1Y0j19dprS1
         4QGUvrMQqUFIY2R2Hw0GbBectTC3HOOtffNmRKAip3jxPPe1Su7fPdXRE5bFmlRV2WXi
         +Vn9e74LN4C20Ijo37cY+lAh6g0SAWJPmVClbHDShk2rfm+wvY48/yLGsZRtZy0KtPHK
         mnd/y/Zpcr8B88gAcMVux/sFrw+kjZEV4hX3PXQ5JN4obSyV4yjWpHDtvpkpGpDZlSBt
         2aYP1wAOpJT9leOurHFfBUWNQ0MTnr3Wfz0Fp9idrKiBwl9urg7EwsOwCMXDzOkVsQwv
         BZsQ==
X-Received: by 10.236.133.145 with SMTP id q17mr18005319yhi.3.1399662756123;
        Fri, 09 May 2014 12:12:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k7sm7411418yhj.31.2014.05.09.12.12.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248624>

No activity since 2012, no tests.

Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/svn-fe/.gitignore      |  4 ---
 contrib/svn-fe/Makefile        | 63 -------------------------------------
 contrib/svn-fe/svn-fe.c        | 18 -----------
 contrib/svn-fe/svn-fe.txt      | 71 ------------------------------------------
 contrib/svn-fe/svnrdump_sim.py | 57 ---------------------------------
 5 files changed, 213 deletions(-)
 delete mode 100644 contrib/svn-fe/.gitignore
 delete mode 100644 contrib/svn-fe/Makefile
 delete mode 100644 contrib/svn-fe/svn-fe.c
 delete mode 100644 contrib/svn-fe/svn-fe.txt
 delete mode 100755 contrib/svn-fe/svnrdump_sim.py

diff --git a/contrib/svn-fe/.gitignore b/contrib/svn-fe/.gitignore
deleted file mode 100644
index 02a7791..0000000
--- a/contrib/svn-fe/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-/*.xml
-/*.1
-/*.html
-/svn-fe
diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
deleted file mode 100644
index 360d8da..0000000
--- a/contrib/svn-fe/Makefile
+++ /dev/null
@@ -1,63 +0,0 @@
-all:: svn-fe$X
-
-CC = gcc
-RM = rm -f
-MV = mv
-
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
-ALL_CFLAGS = $(CFLAGS)
-ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
-
-GIT_LIB = ../../libgit.a
-VCSSVN_LIB = ../../vcs-svn/lib.a
-LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)
-
-QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1 =
-
-ifneq ($(findstring $(MAKEFLAGS),w),w)
-PRINT_DIR = --no-print-directory
-else # "make -w"
-NO_SUBDIR = :
-endif
-
-ifneq ($(findstring $(MAKEFLAGS),s),s)
-ifndef V
-	QUIET_CC      = @echo '   ' CC $@;
-	QUIET_LINK    = @echo '   ' LINK $@;
-	QUIET_SUBDIR0 = +@subdir=
-	QUIET_SUBDIR1 = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-	                $(MAKE) $(PRINT_DIR) -C $$subdir
-endif
-endif
-
-svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
-		$(ALL_LDFLAGS) $(LIBS)
-
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
-
-svn-fe.html: svn-fe.txt
-	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
-		MAN_TXT=../contrib/svn-fe/svn-fe.txt \
-		../contrib/svn-fe/$@
-
-svn-fe.1: svn-fe.txt
-	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
-		MAN_TXT=../contrib/svn-fe/svn-fe.txt \
-		../contrib/svn-fe/$@
-	$(MV) ../../Documentation/svn-fe.1 .
-
-../../vcs-svn/lib.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
-
-../../libgit.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
-
-clean:
-	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
-
-.PHONY: all clean FORCE
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
deleted file mode 100644
index f363505..0000000
--- a/contrib/svn-fe/svn-fe.c
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is in the public domain.
- * You may freely use, modify, distribute, and relicense it.
- */
-
-#include <stdlib.h>
-#include "svndump.h"
-
-int main(int argc, char **argv)
-{
-	if (svndump_init(NULL))
-		return 1;
-	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master",
-			"refs/notes/svn/revs");
-	svndump_deinit();
-	svndump_reset();
-	return 0;
-}
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
deleted file mode 100644
index a3425f4..0000000
--- a/contrib/svn-fe/svn-fe.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-svn-fe(1)
-=========
-
-NAME
-----
-svn-fe - convert an SVN "dumpfile" to a fast-import stream
-
-SYNOPSIS
---------
-[verse]
-mkfifo backchannel &&
-svnadmin dump --deltas REPO |
-	svn-fe [url] 3<backchannel |
-	git fast-import --cat-blob-fd=3 3>backchannel
-
-DESCRIPTION
------------
-
-Converts a Subversion dumpfile into input suitable for
-git-fast-import(1) and similar importers. REPO is a path to a
-Subversion repository mirrored on the local disk. Remote Subversion
-repositories can be mirrored on local disk using the `svnsync`
-command.
-
-Note: this tool is very young.  The details of its commandline
-interface may change in backward incompatible ways.
-
-INPUT FORMAT
-------------
-Subversion's repository dump format is documented in full in
-`notes/dump-load-format.txt` from the Subversion source tree.
-Files in this format can be generated using the 'svnadmin dump' or
-'svk admin dump' command.
-
-OUTPUT FORMAT
--------------
-The fast-import format is documented by the git-fast-import(1)
-manual page.
-
-NOTES
------
-Subversion dumps do not record a separate author and committer for
-each revision, nor do they record a separate display name and email
-address for each author.  Like git-svn(1), 'svn-fe' will use the name
-
----------
-user <user@UUID>
----------
-
-as committer, where 'user' is the value of the `svn:author` property
-and 'UUID' the repository's identifier.
-
-To support incremental imports, 'svn-fe' puts a `git-svn-id` line at
-the end of each commit log message if passed a URL on the command
-line.  This line has the form `git-svn-id: URL@REVNO UUID`.
-
-The resulting repository will generally require further processing
-to put each project in its own repository and to separate the history
-of each branch.  The 'git filter-branch --subdirectory-filter' command
-may be useful for this purpose.
-
-BUGS
-----
-Empty directories and unknown properties are silently discarded.
-
-The exit status does not reflect whether an error was detected.
-
-SEE ALSO
---------
-git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
-https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
deleted file mode 100755
index 4e78a1c..0000000
--- a/contrib/svn-fe/svnrdump_sim.py
+++ /dev/null
@@ -1,57 +0,0 @@
-#!/usr/bin/python
-"""
-Simulates svnrdump by replaying an existing dump from a file, taking care
-of the specified revision range.
-To simulate incremental imports the environment variable SVNRMAX can be set
-to the highest revision that should be available.
-"""
-import sys, os
-
-if sys.hexversion < 0x02040000:
-        # The limiter is the ValueError() calls. This may be too conservative
-        sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
-        sys.exit(1)
-
-def getrevlimit():
-        var = 'SVNRMAX'
-        if var in os.environ:
-                return os.environ[var]
-        return None
-
-def writedump(url, lower, upper):
-        if url.startswith('sim://'):
-                filename = url[6:]
-                if filename[-1] == '/': filename = filename[:-1] #remove terminating slash
-        else:
-                raise ValueError('sim:// url required')
-        f = open(filename, 'r');
-        state = 'header'
-        wroterev = False
-        while(True):
-                l = f.readline()
-                if l == '': break
-                if state == 'header' and l.startswith('Revision-number: '):
-                        state = 'prefix'
-                if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
-                        state = 'selection'
-                if not upper == 'HEAD' and state == 'selection' and l == 'Revision-number: %s\n' % upper:
-                        break;
-
-                if state == 'header' or state == 'selection':
-                        if state == 'selection': wroterev = True
-                        sys.stdout.write(l)
-        return wroterev
-
-if __name__ == "__main__":
-        if not (len(sys.argv) in (3, 4, 5)):
-                print("usage: %s dump URL -rLOWER:UPPER")
-                sys.exit(1)
-        if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
-        url = sys.argv[2]
-        r = ('0', 'HEAD')
-        if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
-                r = sys.argv[3][2:].lstrip().split(':')
-        if not getrevlimit() is None: r[1] = getrevlimit()
-        if writedump(url, r[0], r[1]): ret = 0
-        else: ret = 1
-        sys.exit(ret)
-- 
1.9.2+fc1.28.g12374c0
