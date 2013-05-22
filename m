From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 14/15] git-clean: add documentation for interactive git-clean
Date: Wed, 22 May 2013 09:40:35 +0800
Message-ID: <933513155a6f8bc3a383691280da673ca7cedc24.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3n-0001jn-VF
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab3EVBlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:31 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52327 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab3EVBl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:41:28 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so1183241pbb.41
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=IC5vMm+s/lfueZZH14nvD3rCahPzAdbLNREeu3IYpbU=;
        b=gRVGHJqE/2O9CRnERD3hX04YXucw8/WfSzkF+ljWWc0gCzeMpYC8NWvpyFJ/bwMZuK
         1Ewr31cz1CNkNufDJSfShmK8PdJ1KXU3DXq1uXBTSks5nNqH/ePN79yVNyCUlBJrsAol
         3JPFDKYzth0CTZ1lCbis7ZUBcUqBcA0NggbQWhNxTl3koKZ91jHnYD0IxuFIxZluMX3q
         tc4qqvjbbI4sRvVwMXjwm/1l8VjEKvjAtoF7xHdsBVcIq5GaZv+YGWcgijnGFHvyxdF9
         HWCKtPkBhCOcId5dYt0MgIGDs/taDd5Wm539sHkX2ljY2OpCUAavYARkHJNDXKtnepsb
         q9Nw==
X-Received: by 10.68.239.228 with SMTP id vv4mr5435508pbc.5.1369186888345;
        Tue, 21 May 2013 18:41:28 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.41.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:41:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225118>

Add new section "Interactive mode" for documentation of interactive
git-clean.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clean.txt | 65 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 186e34..5bf76 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -39,8 +39,8 @@ OPTIONS
 
 -i::
 --interactive::
-	Show what would be done and the user must confirm before actually
-	cleaning.
+	Show what would be done and clean files interactively. See
+	``Interactive mode'' for details.
 
 -n::
 --dry-run::
@@ -69,6 +69,67 @@ OPTIONS
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+Interactive mode
+----------------
+When the command enters the interactive mode, it shows the
+files and directories to be cleaned, and goes into its
+interactive command loop.
+
+The command loop shows the list of subcommands available, and
+gives a prompt "What now> ".  In general, when the prompt ends
+with a single '>', you can pick only one of the choices given
+and type return, like this:
+
+------------
+    *** Commands ***
+        1: clean                2: filter by pattern    3: select by numbers
+        4: ask each             5: quit                 6: help
+    What now> 1
+------------
+
+You also could say `c` or `clean` above as long as the choice is unique.
+
+The main command loop has 6 subcommands.
+
+clean::
+
+   Start cleaning files and directories, and then quit.
+
+filter by pattern::
+
+   This shows the files and directories to be deleted and issues an
+   "Input ignore patterns>>" prompt. You can input space-seperated
+   patterns to exclude files and directories from deletion.
+   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
+   deletion. When you are satisfied with the filtered result, press
+   ENTER (empty) back to the main menu.
+
+select by numbers::
+
+   This shows the files and directories to be deleted and issues an
+   "Select items to delete>>" prompt. When the prompt ends with double
+   '>>' like this, you can make more than one selection, concatenated
+   with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
+   to choose 2,3,4,5,7,9 from the list.  If the second number in a
+   range is omitted, all remaining patches are taken.  E.g. "7-" to
+   choose 7,8,9 from the list.  You can say '*' to choose everything.
+   Also when you are satisfied with the filtered result, press ENTER
+   (empty) back to the main menu.
+
+ask each::
+
+  This will start to clean, and you must confirm one by one in order
+  to delete items. Please note that this action is not as efficient
+  as the above two actions.
+
+quit::
+
+  This lets you quit without do cleaning.
+
+help::
+
+  Show brief usage of interactive git-clean.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
-- 
1.8.3.rc3.368.g7c798dd
