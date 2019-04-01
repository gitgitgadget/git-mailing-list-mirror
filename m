Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DA120248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfDASwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:52:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44277 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfDASwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:52:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so9199439edh.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vdwaa-nl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CipayeH0dUSXFfRywge3voUglqOFO9CFJ5AFThQaY8=;
        b=BgMabrYp+3mrK/7yePRLf5kzNAswwvBWcNGlaaXafY1gtXb69rJOR5qI+ohQmm2IDu
         R59B4X76b4eyiP9wn3iaEsZxuvDJVVDceYrNXbIGpobOD0JkmLS9Hz5lA81pCCX4gPEf
         +ZlIBEuZ4DkBxPhZkmbdMzh5/axIsJTVSn60bGy6fXwSOnaoeVPEFSJQ3stJPTk15D4C
         JYnHFq/15Cs2MI4trJmUxfRj8DCyvnRo68Dc8InjNStsHzHgnUbR2vy3BZ3Ct/zT5na/
         shcEARIKnXesGIMJnzbaryLAOnhuhkS6EsxQeqB4EpwUYscpBS8ATwZtdk5qtefnn4YV
         +bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CipayeH0dUSXFfRywge3voUglqOFO9CFJ5AFThQaY8=;
        b=oNqaXEHlph9vCwThZEy8l+Vo6i8YKM23b6sWiSh+aNBvM55l+czJrVVSSYFNkHpHKq
         YGD/UeSKFUMfEjzkGbWXcs8JMnD/P12y/f+PKy8liskaD2+Bhx0nrNZiQ2rRJjUWWOEY
         m8dCCTjhFn7cx2jYoSTCERocALxik8NXETLV4EPlNqStzxesBp6Xoe8aafCqcxldT8hs
         lRx0mhF41Uy88kiStO5IHuCEgu+R3nelLnBwR3+fzH43Uv8YgVfNeR1FJUT4aj8UBIkz
         jiMNOZCYkrkzrQ1C1LhU84SMBlbawEirHl1g+Fr5wc/7lC+HtyqgTXJynnIDeroMCKzq
         aoog==
X-Gm-Message-State: APjAAAUjUlaWTGax0htjdWE5XqN48JJFPmcWWm/zbhwALP9k6QEqCkEP
        JvfSefmisSWiwp59L8rW9UTuqZ0g0A7Utw==
X-Google-Smtp-Source: APXvYqwaNn+O0heNBS08xaTXCmNrYR/R4WSYvVJaLd1oTJwvhfNvWxLhaIFTUemcQuAfyKvNtXntQQ==
X-Received: by 2002:aa7:d411:: with SMTP id z17mr36186588edq.161.1554144739072;
        Mon, 01 Apr 2019 11:52:19 -0700 (PDT)
Received: from localhost.localdomain (83-84-17-34.cable.dynamic.v4.ziggo.nl. [83.84.17.34])
        by smtp.gmail.com with ESMTPSA id y2sm3422574eda.11.2019.04.01.11.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:52:18 -0700 (PDT)
From:   Jelle van der Waa <jelle@vdwaa.nl>
X-Google-Original-From: Jelle van der Waa
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH 1/3] contrib: hg-to-git: make print python 3 compatible
Date:   Mon,  1 Apr 2019 20:52:06 +0200
Message-Id: <20190401185208.17031-2-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401185208.17031-1-jelle@vdwaa.nl>
References: <20190401185208.17031-1-jelle@vdwaa.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jelle van der Waa <jelle@vdwaa.nl>

Python 3 made print a function, keep Python 2 compatibility with a
future import of print_function.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 contrib/hg-to-git/hg-to-git.py | 47 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index de3f81667e..f898d6f23e 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -17,6 +17,7 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, see <http://www.gnu.org/licenses/>.
 """
+from __future__ import print_function
 
 import os, os.path, sys
 import tempfile, pickle, getopt
@@ -42,7 +43,7 @@
 
 def usage():
 
-        print """\
+        print("""\
 %s: [OPTIONS] <hgprj>
 
 options:
@@ -54,7 +55,7 @@ def usage():
 
 required:
     hgprj:  name of the HG project to import (directory)
-""" % sys.argv[0]
+""" % sys.argv[0])
 
 #------------------------------------------------------------------------------
 
@@ -104,22 +105,22 @@ def getgitenv(user, date):
 if state:
     if os.path.exists(state):
         if verbose:
-            print 'State does exist, reading'
+            print('State does exist, reading')
         f = open(state, 'r')
         hgvers = pickle.load(f)
     else:
-        print 'State does not exist, first run'
+        print('State does not exist, first run')
 
 sock = os.popen('hg tip --template "{rev}"')
 tip = sock.read()
 if sock.close():
     sys.exit(1)
 if verbose:
-    print 'tip is', tip
+    print('tip is', tip)
 
 # Calculate the branches
 if verbose:
-    print 'analysing the branches...'
+    print('analysing the branches...')
 hgchildren["0"] = ()
 hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
@@ -155,7 +156,7 @@ def getgitenv(user, date):
             hgbranch[str(cset)] = "branch-" + str(cset)
 
 if not hgvers.has_key("0"):
-    print 'creating repository'
+    print('creating repository')
     os.system('git init')
 
 # loop through every hg changeset
@@ -180,27 +181,27 @@ def getgitenv(user, date):
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
-    print '-----------------------------------------'
-    print 'cset:', cset
-    print 'branch:', hgbranch[str(cset)]
-    print 'user:', user
-    print 'date:', date
-    print 'comment:', csetcomment
+    print('-----------------------------------------')
+    print('cset:', cset)
+    print('branch:', hgbranch[str(cset)])
+    print('user:', user)
+    print('date:', date)
+    print('comment:', csetcomment)
     if parent:
-	print 'parent:', parent
+        print('parent:', parent)
     if mparent:
-        print 'mparent:', mparent
+        print('mparent:', mparent)
     if tag:
-        print 'tag:', tag
-    print '-----------------------------------------'
+        print('tag:', tag)
+    print('-----------------------------------------')
 
     # checkout the parent if necessary
     if cset != 0:
         if hgbranch[str(cset)] == "branch-" + str(cset):
-            print 'creating new branch', hgbranch[str(cset)]
+            print('creating new branch', hgbranch[str(cset)])
             os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
         else:
-            print 'checking out branch', hgbranch[str(cset)]
+            print('checking out branch', hgbranch[str(cset)])
             os.system('git checkout %s' % hgbranch[str(cset)])
 
     # merge
@@ -209,7 +210,7 @@ def getgitenv(user, date):
             otherbranch = hgbranch[mparent]
         else:
             otherbranch = hgbranch[parent]
-        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
+        print('merging', otherbranch, 'into', hgbranch[str(cset)])
         os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
 
     # remove everything except .git and .hg directories
@@ -233,12 +234,12 @@ def getgitenv(user, date):
 
     # delete branch if not used anymore...
     if mparent and len(hgchildren[str(cset)]):
-        print "Deleting unused branch:", otherbranch
+        print("Deleting unused branch:", otherbranch)
         os.system('git branch -d %s' % otherbranch)
 
     # retrieve and record the version
     vvv = os.popen('git show --quiet --pretty=format:%H').read()
-    print 'record', cset, '->', vvv
+    print('record', cset, '->', vvv)
     hgvers[str(cset)] = vvv
 
 if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
@@ -247,7 +248,7 @@ def getgitenv(user, date):
 # write the state for incrementals
 if state:
     if verbose:
-        print 'Writing state'
+        print('Writing state')
     f = open(state, 'w')
     pickle.dump(hgvers, f)
 
-- 
2.21.0

