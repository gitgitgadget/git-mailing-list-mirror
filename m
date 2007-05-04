From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH] Rename "bury" back to "sink".
Date: Sat, 05 May 2007 00:53:03 +0200
Message-ID: <20070504224639.26133.6157.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 00:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk6f8-0001qb-8O
	for gcvg-git@gmane.org; Sat, 05 May 2007 00:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767756AbXEDWxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 18:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767763AbXEDWxq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 18:53:46 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59306 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767757AbXEDWxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 18:53:44 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EE0EA5E1B4;
	Sat,  5 May 2007 00:53:42 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id F33D31F15A;
	Sat,  5 May 2007 00:53:03 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46226>


Signed-off-by: Yann Dirson <ydirson@altern.org>
---

Well, it looks like the voices we heard on this naming issue were
quite equally cast towards each of the 2 name.

Let my vote be to get back to "sink", so the user can easily pair the
command with "float".  I expect that any previously-silent majoity
prefering "bury" will talk now, before Catalin decides if he wants
this patch in the next release :)

Oh, this patch reminds me we still have to activate rename
detection...

 Documentation/stg-bury.txt    |   49 -------------------------------
 Documentation/stg-sink.txt    |   49 +++++++++++++++++++++++++++++++
 Documentation/stg.txt         |    4 +--
 contrib/stgit-completion.bash |    4 +--
 stgit/commands/bury.py        |   65 -----------------------------------------
 stgit/commands/sink.py        |   65 +++++++++++++++++++++++++++++++++++++++++
 stgit/main.py                 |    4 +--
 7 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/Documentation/stg-bury.txt b/Documentation/stg-bury.txt
deleted file mode 100644
index 22ab548..0000000
--- a/Documentation/stg-bury.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-stg-bury(1)
-===========
-Yann Dirson <ydirson@altern.org>
-v0.13, April 2007
-
-NAME
-----
-stg-bury - stgdesc:bury[]
-
-SYNOPSIS
---------
-[verse]
-'stg' bury [--to=<target>] [--nopush] [<patches>]
-
-DESCRIPTION
------------
-
-This is the opposite operation of stglink:float[]: move the specified
-patches down the stack.  It is for example useful to group stable
-patches near the bottom of the stack, where they are less likely to be
-impacted by the push of another patch, and from where they can be more
-easily committed or pushed.
-
-If no patch is specified on command-line, the current patch is buried.
-By default patches are buried at the bottom of the stack, but the
-'--to' option allows to bury under any applied patch.
-
-Buring internally involves popping all patches (or all patches
-including <target patch>), then pushing the patches to bury, and then
-(unless '--nopush' is also given) pushing back into place the
-formerly-applied patches.
-
-
-OPTIONS
--------
-
---to=<TARGET>::
--t <TARGET>::
-	Specify a target patch to bury the patches below, instead of
-	buring at the bottom of the stack.
-
---nopush::
--n::
-	Do not push back on the stack the formerly-applied patches.
-	Only the patches to bury are pushed.
-
-StGIT
------
-Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg-sink.txt b/Documentation/stg-sink.txt
new file mode 100644
index 0000000..0f569be
--- /dev/null
+++ b/Documentation/stg-sink.txt
@@ -0,0 +1,49 @@
+stg-sink(1)
+===========
+Yann Dirson <ydirson@altern.org>
+v0.13, April 2007
+
+NAME
+----
+stg-sink - stgdesc:sink[]
+
+SYNOPSIS
+--------
+[verse]
+'stg' sink [--to=<target>] [--nopush] [<patches>]
+
+DESCRIPTION
+-----------
+
+This is the opposite operation of stglink:float[]: move the specified
+patches down the stack.  It is for example useful to group stable
+patches near the bottom of the stack, where they are less likely to be
+impacted by the push of another patch, and from where they can be more
+easily committed or pushed.
+
+If no patch is specified on command-line, the current patch gets sunk.
+By default patches are sunk to the bottom of the stack, but the
+'--to' option allows to place them under any applied patch.
+
+Sinking internally involves popping all patches (or all patches
+including <target patch>), then pushing the patches to sink, and then
+(unless '--nopush' is also given) pushing back into place the
+formerly-applied patches.
+
+
+OPTIONS
+-------
+
+--to=<TARGET>::
+-t <TARGET>::
+	Specify a target patch to place the patches below, instead of
+	sinking them to the bottom of the stack.
+
+--nopush::
+-n::
+	Do not push back on the stack the formerly-applied patches.
+	Only the patches to sink are pushed.
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index cf28b02..af57c37 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -137,8 +137,8 @@ stglink:goto[]::
 	stgdesc:goto[]
 stglink:float[]::
 	stgdesc:float[]
-stglink:bury[]::
-	stgdesc:bury[]
+stglink:sink[]::
+	stgdesc:sink[]
 stglink:applied[]::
 	stgdesc:applied[]
 stglink:unapplied[]::
diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 3c3bf92..760fc2f 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -15,7 +15,6 @@ _stg_commands="
     applied
     assimilate
     branch
-    bury
     delete
     diff
     clean
@@ -46,6 +45,7 @@ _stg_commands="
     rm
     series
     show
+    sink
     status
     sync
     top
@@ -190,13 +190,13 @@ _stg ()
         # repository commands
         id)     _stg_patches $command _all_patches ;;
         # stack commands
-        bury)   _stg_patches $command _all_patches ;;
         float)  _stg_patches $command _all_patches ;;
         goto)   _stg_patches $command _all_other_patches ;;
         hide)   _stg_patches $command _all_patches ;;
         pop)    _stg_patches $command _applied_patches ;;
         push)   _stg_patches $command _unapplied_patches ;;
         series) _stg_patches $command _all_patches ;;
+        sink)   _stg_patches $command _all_patches ;;
         unhide) _stg_patches $command _all_patches ;;
         # patch commands
         delete) _stg_patches $command _all_patches ;;
diff --git a/stgit/commands/bury.py b/stgit/commands/bury.py
deleted file mode 100644
index b14f09e..0000000
--- a/stgit/commands/bury.py
+++ /dev/null
@@ -1,65 +0,0 @@
-
-__copyright__ = """
-Copyright (C) 2007, Yann Dirson <ydirson@altern.org>
-
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License version 2 as
-published by the Free Software Foundation.
-
-This program is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-GNU General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-"""
-
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import stack, git
-
-
-help = 'bury patches down the stack'
-usage = """%prog [-t <target patch>] [-n] [<patches>]
-
-Pop all patches (or all patches including <target patch>), then
-push the specified <patches> (the current patch by default), and
-then push back into place the formerly-applied patches (unless -n
-is also given)."""
-
-options = [make_option('-n', '--nopush',
-                       help = 'do not push the patches back after sinking',
-                       action = 'store_true'),
-           make_option('-t', '--to', metavar = 'TARGET',
-                       help = 'bury patches below TARGET patch')]
-
-def func(parser, options, args):
-    """Bury patches
-    """
-
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal()
-
-    oldapplied = crt_series.get_applied()
-    unapplied = crt_series.get_unapplied()
-    all = unapplied + oldapplied
-
-    if len(args) > 0:
-        patches = parse_patches(args, all)
-    else:
-        patches = [ crt_series.get_current() ]
-
-    crt_series.pop_patch(options.to or oldapplied[0])
-    push_patches(patches)
-
-    if not options.nopush:
-        newapplied = crt_series.get_applied()
-        def not_reapplied_yet(p):
-            return not p in newapplied
-        push_patches(filter(not_reapplied_yet, oldapplied))
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
new file mode 100644
index 0000000..85cc70f
--- /dev/null
+++ b/stgit/commands/sink.py
@@ -0,0 +1,65 @@
+
+__copyright__ = """
+Copyright (C) 2007, Yann Dirson <ydirson@altern.org>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+import sys, os
+from optparse import OptionParser, make_option
+
+from stgit.commands.common import *
+from stgit.utils import *
+from stgit import stack, git
+
+
+help = 'send patches deeper down the stack'
+usage = """%prog [-t <target patch>] [-n] [<patches>]
+
+Pop all patches (or all patches including <target patch>), then
+push the specified <patches> (the current patch by default), and
+then push back into place the formerly-applied patches (unless -n
+is also given)."""
+
+options = [make_option('-n', '--nopush',
+                       help = 'do not push the patches back after sinking',
+                       action = 'store_true'),
+           make_option('-t', '--to', metavar = 'TARGET',
+                       help = 'sink patches below TARGET patch')]
+
+def func(parser, options, args):
+    """Sink patches down the stack.
+    """
+
+    check_local_changes()
+    check_conflicts()
+    check_head_top_equal()
+
+    oldapplied = crt_series.get_applied()
+    unapplied = crt_series.get_unapplied()
+    all = unapplied + oldapplied
+
+    if len(args) > 0:
+        patches = parse_patches(args, all)
+    else:
+        patches = [ crt_series.get_current() ]
+
+    crt_series.pop_patch(options.to or oldapplied[0])
+    push_patches(patches)
+
+    if not options.nopush:
+        newapplied = crt_series.get_applied()
+        def not_reapplied_yet(p):
+            return not p in newapplied
+        push_patches(filter(not_reapplied_yet, oldapplied))
diff --git a/stgit/main.py b/stgit/main.py
index 9c319c6..1a1f534 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -63,7 +63,6 @@ commands = Commands({
     'applied':          'applied',
     'assimilate':       'assimilate',
     'branch':           'branch',
-    'bury':             'bury',
     'delete':           'delete',
     'diff':             'diff',
     'clean':            'clean',
@@ -94,6 +93,7 @@ commands = Commands({
     'rm':               'rm',
     'series':           'series',
     'show':             'show',
+    'sink':             'sink',
     'status':           'status',
     'sync':             'sync',
     'top':              'top',
@@ -111,7 +111,6 @@ stackcommands = (
     'applied',
     'assimilate',
     'branch',
-    'bury',
     'clean',
     'commit',
     'float',
@@ -124,6 +123,7 @@ stackcommands = (
     'push',
     'rebase',
     'series',
+    'sink',
     'top',
     'unapplied',
     'uncommit',
