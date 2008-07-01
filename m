From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH v2] gitcli: Document meaning of --cached and --index
Date: Tue, 01 Jul 2008 23:02:40 +0900
Message-ID: <20080701230240.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 16:04:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDgSX-0001Fi-U4
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 16:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYGAOCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 10:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbYGAOCz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 10:02:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:45805 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642AbYGAOCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 10:02:54 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 65328C888E;
	Tue,  1 Jul 2008 09:02:45 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 7GGKQGCBMYLC; Tue, 01 Jul 2008 09:02:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Dck0m5VgT8WE/c82N7IQMVzq3kzSt1xns3se79OPnp5gdSfNvYpqL7nGfXcVz93T6d+zw53SwncY687hv33JsK1wZCrDxPa1uHpH4O8K8b4h0jPNCvnTiRBiW+LQ+x2i8IsY5dvr3Kxo9/UIMW40Z6R1KrTXzJOC3zCF/NKAZPc=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87039>

We saw this explanation repeated on the mailing list a few times.  Even
though the description of individual options to particular commands are
explained in their manual pages, the reason behind choosing which is which
has not been clearly explained in any of the documentation.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
Here is a resend with updates that fix the mistakes you pointed out in
the previous version.  Includes an update to the Documentation section
(Sverre Rabbelier pointed out that it is more common to say "and the
git-list").

 Documentation/gitcli.txt |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 2316049..7a9a625 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -133,9 +133,45 @@ $ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
 ----------------------------
 
 
+NOTES ON FREQUENTLY CONFUSED OPTIONS
+------------------------------------
+
+Many commands that can work on files in the working tree
+and/or in the index can take `--cached` and/or `--index`
+options.  Sometimes people incorrectly think that, because
+the index was originally called cache, these two are
+synonyms.  They are *not* -- these two options mean very
+different things.
+
+ * The `--cached` option is used to ask a command that
+   usually works on files in the working tree to *only* work
+   with the index.  For example, `git grep`, when used
+   without a commit to specify from which commit to look for
+   strings in, usually works on files in the working tree,
+   but with the `--cached` option, it looks for strings in
+   the index.
+
+ * The `--index` option is used to ask a command that
+   usually works on files in the working tree to *also*
+   affect the index.  For example, `git stash apply` usually
+   merges changes recorded in a stash to the working tree,
+   but with the `--index` option, it also merges changes to
+   the index as well.
+
+`git apply` command can be used with `--cached` and
+`--index` (but not at the same time).  Usually the command
+only affects the files in the working tree, but with
+`--index`, it patches both the files and their index
+entries, and with `--cached`, it modifies only the index
+entries.
+
+See also http://marc.info/?l=git&m=116563135620359 and
+http://marc.info/?l=git&m=119150393620273 for further
+information.
+
 Documentation
 -------------
-Documentation by Pierre Habouzit.
+Documentation by Pierre Habouzit and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-- 
1.5.6

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
