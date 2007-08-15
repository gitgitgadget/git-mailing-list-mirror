From: Nikodemus Siivola <nikodemus@random-state.net>
Subject: [PATCH] reformat revision specifier syntax documentation
Date: Thu, 16 Aug 2007 00:40:00 +0300
Message-ID: <11872140002918-git-send-email-nikodemus@random-state.net>
Cc: Nikodemus Siivola <nikodemus@random-state.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 23:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQb4-00013c-Te
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbXHOVkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXHOVkF
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:40:05 -0400
Received: from smtp6.pp.htv.fi ([213.243.153.40]:54485 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbXHOVkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:40:03 -0400
Received: from localhost.localdomain (cs181229041.pp.htv.fi [82.181.229.41])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 10FC35BC172;
	Thu, 16 Aug 2007 00:40:02 +0300 (EEST)
X-Mailer: git-send-email 1.5.3.rc4.93.g263c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55953>

* Start each syntax explanation text-block with a one-line
  pattern summarizing the syntax for easier eyeballing.

* Use <ref> to signify a ref instead of <name>.

Signed-off-by: Nikodemus Siivola <nikodemus@random-state.net>

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 4b4d229..88ccbac 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -126,36 +126,40 @@ syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list are to name trees and
 blobs contained in a commit.
 
-* The full SHA1 object name (40-byte hexadecimal string), or
+<sha1> | <sha1-prefix>::
+  The full SHA1 object name (40-byte hexadecimal string), or
   a substring of such that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
 
-* An output from `git-describe`; i.e. a closest tag, followed by a
+<tag>-g<sha1-prefix> | <tag>-<commits-since-tag>-g<sha1-prefix>::
+  An output from `git-describe`; i.e. a closest tag, followed by a
   dash, a `g`, and an abbreviated object name.
 
-* A symbolic ref name.  E.g. 'master' typically means the commit
+<ref>::
+  A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by $GIT_DIR/refs/heads/master.  If you
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell git which one you mean.
-  When ambiguous, a `<name>` is disambiguated by taking the
+  When ambiguous, a `<ref>` is disambiguated by taking the
   first match in the following rules:
 
-  . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
+  . if `$GIT_DIR/<ref>` exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD` and `MERGE_HEAD`);
 
-  . otherwise, `$GIT_DIR/refs/<name>` if exists;
+  . otherwise, `$GIT_DIR/refs/<ref>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/tags/<name>` if exists;
+  . otherwise, `$GIT_DIR/refs/tags/<ref>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/heads/<name>` if exists;
+  . otherwise, `$GIT_DIR/refs/heads/<ref>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/remotes/<name>` if exists;
+  . otherwise, `$GIT_DIR/refs/remotes/<ref>` if exists;
 
-  . otherwise, `$GIT_DIR/refs/remotes/<name>/HEAD` if exists.
+  . otherwise, `$GIT_DIR/refs/remotes/<ref>/HEAD` if exists.
 
-* A ref followed by the suffix '@' with a date specification
+<ref>@<date>::
+  A ref followed by the suffix '@' with a date specification
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
@@ -163,7 +167,8 @@ blobs contained in a commit.
   used immediately following a ref name and the ref must have an
   existing log ($GIT_DIR/logs/<ref>).
 
-* A ref followed by the suffix '@' with an ordinal specification
+<ref>@<ordinal>::
+  A ref followed by the suffix '@' with an ordinal specification
   enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
   the n-th prior value of that ref.  For example 'master@\{1\}'
   is the immediate prior value of 'master' while 'master@\{5\}'
@@ -171,52 +176,63 @@ blobs contained in a commit.
   immediately following a ref name and the ref must have an existing
   log ($GIT_DIR/logs/<ref>).
 
-* You can use the '@' construct with an empty ref part to get at a
+@<ordinal>::
+  You can use the '@' construct with an empty ref part to get at a
   reflog of the current branch. For example, if you are on the
   branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
 
-* A suffix '{caret}' to a revision parameter means the first parent of
+<object>{caret} | <object>{caret}<ordinal>::
+  A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
   is equivalent to 'rev{caret}1').  As a special rule,
   'rev{caret}0' means the commit itself and is used when 'rev' is the
   object name of a tag object that refers to a commit object.
 
-* A suffix '{tilde}<n>' to a revision parameter means the commit
+<object>{tilde}<ordinal>::
+  A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parent.  I.e. rev~3 is
   equivalent to rev{caret}{caret}{caret} which is equivalent to
   rev{caret}1{caret}1{caret}1.  See below for a illustration of
   the usage of this form.
 
-* A suffix '{caret}' followed by an object type name enclosed in
+<object>{caret}\{<object-type\}::
+  A suffix '{caret}' followed by an object type name enclosed in
   brace pair (e.g. `v0.99.8{caret}\{commit\}`) means the object
   could be a tag, and dereference the tag recursively until an
   object of that type is found or the object cannot be
   dereferenced anymore (in which case, barf).  `rev{caret}0`
   introduced earlier is a short-hand for `rev{caret}\{commit\}`.
 
-* A suffix '{caret}' followed by an empty brace pair
+<object>{caret}\{\}::
+  A suffix '{caret}' followed by an empty brace pair
   (e.g. `v0.99.8{caret}\{\}`) means the object could be a tag,
   and dereference the tag recursively until a non-tag object is
   found.
 
-* A colon, followed by a slash, followed by a text: this names
+:/:: 
+  A colon, followed by a slash, followed by a text: this names
   a commit whose commit message starts with the specified text.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.
 
-* A suffix ':' followed by a path; this names the blob or tree
+<object>:<path>::
+  A suffix ':' followed by a path; this names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
 
-* A colon, optionally followed by a stage number (0 to 3) and a
+:<stage>:<path>::
+  A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path; this names a blob object in the
   index at the given path.  Missing stage number (and the colon
   that follows it) names an stage 0 entry.
 
+CARET SUFFIX EXAMPLE
+--------------------
+
 Here is an illustration, by Jon Loeliger.  Both node B and C are
 a commit parents of commit node A.  Parent commits are ordered
 left-to-right.
-- 
1.5.3.rc4.93.g263c
