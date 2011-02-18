From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] Move test-* into a test-programs/ subdirectory
Date: Thu, 17 Feb 2011 20:33:55 -0600
Message-ID: <20110218023355.GC23435@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 03:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqGAY-0000mV-OV
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 03:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab1BRCeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 21:34:01 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59322 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1BRCeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 21:34:01 -0500
Received: by qyk12 with SMTP id 12so3330895qyk.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RKsbHP1zXvLzB9SHQyWlWLHfmbE1BznGNMlCdzMdZRY=;
        b=kxND+nd+SvYc96JZhUQq4913xiY8uzcjs4f85vAulADoLguj0VdbdWJvSzE0+LTV45
         z93s106g8ngEr+co64FlDJEMDb+I4YjsQ0sGuSwlVHrukOuKV4yIO7R5iPuDpJiKkvbw
         AHjnrvhzTryBOsvp8CfuxEk8JQA096iWQWDWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mPogNSnSmJnGsVFPK1+U5Ip7ihaU9mE94OhTEcD6VgtX+Q5a6R582jNdIlm4WkDgnv
         dWUttg0NySxuZ2j6FStFKw2kSSQE72/wK6Ne/3zLwcD8Kgwp/Xp6aQm60M6slqHpy8hR
         CfJv9bfLVjRQHSHumrWfo1ClND77RWSTOopgM=
Received: by 10.224.200.138 with SMTP id ew10mr133575qab.44.1297996440137;
        Thu, 17 Feb 2011 18:34:00 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id q12sm1215283qcu.18.2011.02.17.18.33.58
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 18:33:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218022701.GA23435@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167156>

Move the source to test programs such as test-sha1 to a subdirectory
where they will distract people working on git proper.

The test programs themselves will still go to the top level when
built, so experimenters do not have to hunt around for them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                                           |   15 +++++++++------
 test-chmtime.c => test-programs/test-chmtime.c     |    0
 [ etc etc ]
 .../test-string-pool.c                             |    0
 .../test-subprocess.c                              |    0
 test-svn-fe.c => test-programs/test-svn-fe.c       |    0
 test-treap.c => test-programs/test-treap.c         |    0
 21 files changed, 9 insertions(+), 6 deletions(-)
 rename test-chmtime.c => test-programs/test-chmtime.c (100%)
 [...]
 rename test-treap.c => test-programs/test-treap.c (100%)

diff --git a/Makefile b/Makefile
index b812c1e..f458f65 100644
--- a/Makefile
+++ b/Makefile
@@ -1830,7 +1830,7 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
-TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+TEST_OBJS := $(patsubst test-%$X,test-programs/test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	git.o
 ifndef NO_CURL
@@ -1840,8 +1840,11 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
-VCSSVN_TEST_OBJS = test-obj-pool.o test-string-pool.o \
-	test-line-buffer.o test-treap.o
+VCSSVN_TEST_OBJS =
+VCSSVN_TEST_OBJS += test-programs/test-obj-pool.o
+VCSSVN_TEST_OBJS += test-programs/test-string-pool.o
+VCSSVN_TEST_OBJS += test-programs/test-line-buffer.o
+VCSSVN_TEST_OBJS += test-programs/test-treap.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1970,7 +1973,7 @@ $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
 
-test-svn-fe.o: vcs-svn/svndump.h
+test-programs/test-svn-fe.o: vcs-svn/svndump.h
 endif
 
 libgit/exec_cmd.s libgit/exec_cmd.o: EXTRA_CPPFLAGS = \
@@ -2142,7 +2145,7 @@ test-svn-fe$X: vcs-svn/lib.a
 
 .PRECIOUS: $(TEST_OBJS)
 
-test-%$X: test-%.o $(GITLIBS)
+test-%$X: test-programs/test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
@@ -2321,7 +2324,7 @@ clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		libgit/*.o builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
-	$(RM) $(TEST_PROGRAMS)
+	$(RM) test-programs/*.o $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
 	$(RM) -r $(dep_dirs)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
diff --git a/test-chmtime.c b/test-programs/test-chmtime.c
similarity index 100%
rename from test-chmtime.c
rename to test-programs/test-chmtime.c
diff --git a/test-ctype.c b/test-programs/test-ctype.c
similarity index 100%
rename from test-ctype.c
rename to test-programs/test-ctype.c
diff --git a/test-date.c b/test-programs/test-date.c
similarity index 100%
rename from test-date.c
rename to test-programs/test-date.c
diff --git a/test-delta.c b/test-programs/test-delta.c
similarity index 100%
rename from test-delta.c
rename to test-programs/test-delta.c
diff --git a/test-dump-cache-tree.c b/test-programs/test-dump-cache-tree.c
similarity index 100%
rename from test-dump-cache-tree.c
rename to test-programs/test-dump-cache-tree.c
diff --git a/test-genrandom.c b/test-programs/test-genrandom.c
similarity index 100%
rename from test-genrandom.c
rename to test-programs/test-genrandom.c
diff --git a/test-index-version.c b/test-programs/test-index-version.c
similarity index 100%
rename from test-index-version.c
rename to test-programs/test-index-version.c
diff --git a/test-line-buffer.c b/test-programs/test-line-buffer.c
similarity index 100%
rename from test-line-buffer.c
rename to test-programs/test-line-buffer.c
diff --git a/test-match-trees.c b/test-programs/test-match-trees.c
similarity index 100%
rename from test-match-trees.c
rename to test-programs/test-match-trees.c
diff --git a/test-mktemp.c b/test-programs/test-mktemp.c
similarity index 100%
rename from test-mktemp.c
rename to test-programs/test-mktemp.c
diff --git a/test-obj-pool.c b/test-programs/test-obj-pool.c
similarity index 100%
rename from test-obj-pool.c
rename to test-programs/test-obj-pool.c
diff --git a/test-parse-options.c b/test-programs/test-parse-options.c
similarity index 100%
rename from test-parse-options.c
rename to test-programs/test-parse-options.c
diff --git a/test-path-utils.c b/test-programs/test-path-utils.c
similarity index 100%
rename from test-path-utils.c
rename to test-programs/test-path-utils.c
diff --git a/test-run-command.c b/test-programs/test-run-command.c
similarity index 100%
rename from test-run-command.c
rename to test-programs/test-run-command.c
diff --git a/test-sha1.c b/test-programs/test-sha1.c
similarity index 100%
rename from test-sha1.c
rename to test-programs/test-sha1.c
diff --git a/test-sigchain.c b/test-programs/test-sigchain.c
similarity index 100%
rename from test-sigchain.c
rename to test-programs/test-sigchain.c
diff --git a/test-string-pool.c b/test-programs/test-string-pool.c
similarity index 100%
rename from test-string-pool.c
rename to test-programs/test-string-pool.c
diff --git a/test-subprocess.c b/test-programs/test-subprocess.c
similarity index 100%
rename from test-subprocess.c
rename to test-programs/test-subprocess.c
diff --git a/test-svn-fe.c b/test-programs/test-svn-fe.c
similarity index 100%
rename from test-svn-fe.c
rename to test-programs/test-svn-fe.c
diff --git a/test-treap.c b/test-programs/test-treap.c
similarity index 100%
rename from test-treap.c
rename to test-programs/test-treap.c
-- 
1.7.4.1
