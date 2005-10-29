From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [PATCH] Add to documentation of git-update-index arguments and usage.
Date: Sat, 29 Oct 2005 17:46:41 -0400
Message-ID: <11306224012707-git-send-email-c.shoemaker@cox.net>
References: <11306224011899-git-send-email-c.shoemaker@cox.net>
Reply-To: Chris Shoemaker <c.shoemaker@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 29 23:47:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVyXS-0008II-4H
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 23:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVJ2Vqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVJ2Vqn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 17:46:43 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:36579 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932210AbVJ2Vqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 17:46:42 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029214638.BWVA28234.eastrmmtao05.cox.net@localhost>;
          Sat, 29 Oct 2005 17:46:38 -0400
Received: from [127.0.0.1] (helo=pe)
	by localhost with smtp (Exim 4.43)
	id 1EVyXB-0006WY-CZ; Sat, 29 Oct 2005 17:46:41 -0400
In-Reply-To: <11306224011899-git-send-email-c.shoemaker@cox.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10810>

Removed unknown [--version] option.

Signed-off-by: Chris Shoemaker <c.shoemaker@cox.net>

---

 Documentation/git-update-index.txt |   28 ++++++++++++++++++++++++----
 update-index.c                     |    2 +-
 2 files changed, 25 insertions(+), 5 deletions(-)

f51a2698073b75c6e0e0f96c0f1f6432167ed85b
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -9,12 +9,13 @@ git-update-index - Modifies the index or
 SYNOPSIS
 --------
 'git-update-index'
-	     [--add] [--remove] [--refresh] [--replace]
-	     [--ignore-missing]
-	     [--force-remove]
+	     [--add] [--remove | --force-remove] [--replace] 
+             [--refresh [-q] [--unmerged] [--ignore-missing]]
 	     [--cacheinfo <mode> <object> <file>]\*
-	     [--info-only]
+             [--chmod=(+|-)x]
+	     [--info-only] [--index-info]
 	     [-z] [--stdin]
+             [--verbose]
 	     [--] [<file>]\*
 
 DESCRIPTION
@@ -42,12 +43,28 @@ OPTIONS
 	Looks at the current cache and checks to see if merges or
 	updates are needed by checking stat() information.
 
+-q::
+        Quiet.  If --refresh finds that the cache needs an update, the
+        default behavior is to error out.  This option makes
+        git-update-index continue anyway.
+
+--unmerged::
+        If --refresh finds unmerged changes in the cache, the default 
+        behavior is to error out.  This option makes git-update-index 
+        continue anyway.
+
 --ignore-missing::
 	Ignores missing files during a --refresh
 
 --cacheinfo <mode> <object> <path>::
 	Directly insert the specified info into the cache.
 	
+--index-info::
+        Read index info from stdin.
+
+--chmod=(+|-)x::
+        Set the execute permissions on the updated files.        
+
 --info-only::
 	Do not create objects in the object database for all
 	<file> arguments that follow this flag; just insert
@@ -70,6 +87,9 @@ OPTIONS
 	read list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
+--verbose::
+        Report what is being added and removed from index.
+
 -z::
 	Only meaningful with `--stdin`; paths are separated with
 	NUL character instead of LF.
diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -393,7 +393,7 @@ static void read_index_info(int line_ter
 }
 
 static const char update_index_usage[] =
-"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--cacheinfo] [--chmod=(+|-)x] [--info-only] [--force-remove] [--stdin] [--index-info] [--ignore-missing] [-z] [--version] [--] <file>...";
+"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--cacheinfo] [--chmod=(+|-)x] [--info-only] [--force-remove] [--stdin] [--index-info] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 int main(int argc, const char **argv)
 {
