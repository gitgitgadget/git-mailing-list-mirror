From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2] Makefile: add missing phony target
Date: Fri, 11 Dec 2015 14:22:46 +0000
Message-ID: <1449843766-41658-1-git-send-email-gitter.spiros@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 15:23:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Ob4-0005kC-G1
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 15:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbbLKOWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 09:22:54 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35786 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbLKOWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 09:22:53 -0500
Received: by mail-wm0-f44.google.com with SMTP id l68so15843494wml.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6l4MCNVWXPHlYi2fEwWC4nKwMc5sDD/zF20OI8Ml9Ko=;
        b=hczE0dYubrtDav1+AEv8XORx9CRqGg0ZpAm0PrE4llHe6W4hKIggLUQeNvnWuhIa9Z
         tloIdGELJ6I+R0JKDJFGRpF7uNKNS7Br9Y8Ov97TtmHhKC7XHvoIcQw2NX5lM9oXTM8v
         Zo+VgyRFnpJ0CQPxt719p+z77RuHgPY+l7XygMpcthm7d1nH7TjVgzE9YkhMiYshPCjD
         nm1JIhecPgarejHRmTadrFTIipkMyZchbE6dHtU+18IVH1IF7kzQCFrryYQPfdglu/PQ
         8aIX/VicUJz4UFkrntHlRP0KxQgczL7pVwQPoOetO0gInZyXitPjkDUhEjRGFBQ08pCM
         DgWA==
X-Received: by 10.28.186.138 with SMTP id k132mr6537933wmf.75.1449843771935;
        Fri, 11 Dec 2015 06:22:51 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id da10sm17164591wjb.22.2015.12.11.06.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Dec 2015 06:22:50 -0800 (PST)
X-Mailer: git-send-email 2.6.3.444.gfd13a2e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282257>

Add some missing phony target to Makefile. Also put the .PHONY
declaration immediately before the target declaration, where necessary,
for a better readability and a uniform style.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
This is the second version of this patch.
Added the corrections suggested by Matthieu Moy ($gmane/282221)

 Makefile | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 43ceeb9..afd2358 100644
--- a/Makefile
+++ b/Makefile
@@ -534,7 +534,7 @@ install-perl-script: $(SCRIPT_PERL_INS)
 install-python-script: $(SCRIPT_PYTHON_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
-.PHONY: clean-perl-script clean-sh-script clean-python-script
+.PHONY: clean-sh-script clean-perl-script clean-python-script
 clean-sh-script:
 	$(RM) $(SCRIPT_SH_GEN)
 clean-perl-script:
@@ -1644,6 +1644,9 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $^
 
+.PHONY: all profile profile-fast
+.PHONY: please_set_SHELL_PATH_to_a_more_modern_shell shell_compatibility_test strip
+
 ### Target-specific flags and dependencies
 
 # The generic compilation pattern rule and automatically
@@ -2011,6 +2014,7 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
+.PHONY: doc man html info pdf
 doc:
 	$(MAKE) -C Documentation all
 
@@ -2054,6 +2058,7 @@ po/git.pot: $(GENERATED_H) FORCE
 		$(LOCALIZED_PERL)
 	mv $@+ $@
 
+.PHONY: pot
 pot: po/git.pot
 
 POFILES := $(wildcard po/*.po)
@@ -2074,6 +2079,7 @@ $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
 	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
 
+.PHONY: FORCE cscope
 tags: FORCE
 	$(RM) tags
 	$(FIND_SOURCE_FILES) | xargs ctags -a
@@ -2189,6 +2195,7 @@ export NO_SVN_TESTS
 export TEST_NO_MALLOC_CHECK
 
 ### Testing rules
+.PHONY: test perf
 
 test: all
 	$(MAKE) -C t/ all
@@ -2196,7 +2203,6 @@ test: all
 perf: all
 	$(MAKE) -C t/perf/ all
 
-.PHONY: test perf
 
 test-ctype$X: ctype.o
 
@@ -2215,6 +2221,7 @@ test-svn-fe$X: vcs-svn/lib.a
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
+.PHONY: check_sha1 $(SP_OBJ) sparse check check-sha1
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
@@ -2224,7 +2231,6 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		$(SPARSE_FLAGS) $<
 
-.PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
 check: common-cmds.h
@@ -2237,6 +2243,7 @@ check: common-cmds.h
 		exit 1; \
 	fi
 
+
 ### Installation rules
 
 ifneq ($(filter /%,$(firstword $(template_dir))),)
@@ -2263,6 +2270,7 @@ mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+.PHONY: profile-install profile-fast-install install
 profile-install: profile
 	$(MAKE) install
 
@@ -2329,6 +2337,8 @@ endif
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
+.PHONY: install-gitweb install-man install-html install-info install-pdf
+.PHONY: quick-install-doc quick-install-man quick-install-html
 install-gitweb:
 	$(MAKE) -C gitweb install
 
@@ -2365,6 +2375,8 @@ git.spec: git.spec.in GIT-VERSION-FILE
 	mv $@+ $@
 
 GIT_TARNAME = git-$(GIT_VERSION)
+
+.PHONY: dist rpm dist-doc  distclean profile-clean clean
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
@@ -2445,9 +2457,6 @@ endif
 	$(RM) GIT-USER-AGENT GIT-PREFIX
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
 
-.PHONY: all install profile-clean clean strip
-.PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE cscope
 
 ### Check documentation
 #
@@ -2499,9 +2508,9 @@ check-builtins::
 
 ### Test suite coverage testing
 #
-.PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
-.PHONY: coverage-clean-results
 
+.PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
+.PHONY: coverage-clean-results coverage-untested-functions cover_db cover_db_html
 coverage:
 	$(MAKE) coverage-test
 	$(MAKE) coverage-untested-functions
-- 
2.5.0
