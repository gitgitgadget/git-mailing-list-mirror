From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3] Makefile: add missing phony target
Date: Tue, 15 Dec 2015 15:21:00 +0000
Message-ID: <1450192860-60337-1-git-send-email-gitter.spiros@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 16:21:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8rPo-0008PY-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 16:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbbLOPVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 10:21:10 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37008 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbbLOPVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 10:21:07 -0500
Received: by mail-wm0-f53.google.com with SMTP id n186so30872544wmn.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 07:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qzXXlWvgXCUg2eLk1Xh8/VOJ5i1CVAixyQFjAOnUysE=;
        b=Hw61pS/92K4AXKQJ/KJXNTkGsR4TfiOv+MuJsi9UuUIXR47Kluc4csK4IaZfehfyrD
         vtdmSHiFqklq+z+/2PJ8412iio1pk2++L3oXUPn1wVZ+AmGFLNX5aNwb/xrmEopLn2nj
         oLig6JHyuVjfk8w8Rzud/bmAxX4SDbYJ2A3hWCsDUCf2Y547qehOdFEZLQ2EvEc1X1EC
         rpj6zcQjELmiwWnzwiAkA7aCCi6udALEp9LrD0UY0Myxn447pKdwKYaKS3IsYW/CWk/T
         6z60UJUOExQz9+sDwDd96WdFlAjTMRFx6+wJgBia7miXedyE5UTWPapE63eGHfw0OjIn
         BANQ==
X-Received: by 10.194.114.105 with SMTP id jf9mr44080828wjb.102.1450192866006;
        Tue, 15 Dec 2015 07:21:06 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id u205sm3274288wmb.12.2015.12.15.07.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 07:21:04 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.21.gfb43dd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282477>

Add some missing phony target to Makefile.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
This is the third version of this patch.

Compared to the previous I have added only the missing phony 
target as suggested by Matthieu Moy

 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index fd19b54..fc2f1ab 100644
--- a/Makefile
+++ b/Makefile
@@ -2025,6 +2025,7 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
+.PHONY: doc man html info pdf
 doc:
 	$(MAKE) -C Documentation all
 
@@ -2068,6 +2069,7 @@ po/git.pot: $(GENERATED_H) FORCE
 		$(LOCALIZED_PERL)
 	mv $@+ $@
 
+.PHONY: pot
 pot: po/git.pot
 
 POFILES := $(wildcard po/*.po)
@@ -2277,6 +2279,7 @@ mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+.PHONY: profile-install profile-fast-install
 profile-install: profile
 	$(MAKE) install
 
@@ -2343,6 +2346,8 @@ endif
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
+.PHONY: install-gitweb install-doc install-man install-html install-info install-pdf
+.PHONY: quick-install-doc quick-install-man quick-install-html
 install-gitweb:
 	$(MAKE) -C gitweb install
 
@@ -2402,6 +2407,7 @@ rpm: dist
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
+.PHONY: dist-doc distclean
 dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
@@ -2470,6 +2476,8 @@ ALL_COMMANDS += git
 ALL_COMMANDS += gitk
 ALL_COMMANDS += gitweb
 ALL_COMMANDS += git-gui git-citool
+
+.PHONY: check-docs
 check-docs::
 	@(for v in $(ALL_COMMANDS); \
 	do \
@@ -2514,6 +2522,7 @@ check-builtins::
 ### Test suite coverage testing
 #
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
+.PHONY: coverage-untested-functions cover_db cover_db_html
 .PHONY: coverage-clean-results
 
 coverage:
-- 
2.5.0
