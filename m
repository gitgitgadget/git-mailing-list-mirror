From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 08/25] contrib: remove 'git-shell-commands'
Date: Thu,  8 May 2014 19:58:19 -0500
Message-ID: <1399597116-1851-9-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:10:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZKT-0000Bn-3g
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbaEIBKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:10:11 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:41605 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058AbaEIBKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:10:04 -0400
Received: by mail-yh0-f48.google.com with SMTP id a41so877686yho.21
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TLKdaqBJhON5tVrh41++K9uFGh41BPcpoMCCQSCGzK0=;
        b=Ov3dzPXVmF6c8xS65INwnetIndkE4rJolfPer1l0C+dEk/7j4cG3LIn7GlE9C6mWvY
         8s262OIRyrqWt3nOHIUI5FAi/W4cuy7R+F8k9HbeQYkhieaRi0Z8I1/ltc4dDuWS4raC
         keApg/DHLmZcOnO8nF6laKhhVjJXeWxAiwo8LS0w0aw5TfMOBT26DHoDIqAjupHtW8nc
         Tgt98uaza0hh5IY526h4LYZLEvFyr4XZhZZHyEyGTLTBjVkbtbUtoeL+ptn2MySzsLJz
         i1oD2SeMrofONIrC/X6eoTdpxN/5rMz33aRGGVkx7k1h+aIGODguV8LFKRa3UVKCaZ/i
         +rRg==
X-Received: by 10.236.198.243 with SMTP id v79mr9914248yhn.87.1399597803602;
        Thu, 08 May 2014 18:10:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m69sm3924719yhn.16.2014.05.08.18.10.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248474>

No activity, no tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/git-shell-commands/README | 18 ------------------
 contrib/git-shell-commands/help   | 18 ------------------
 contrib/git-shell-commands/list   | 10 ----------
 3 files changed, 46 deletions(-)
 delete mode 100644 contrib/git-shell-commands/README
 delete mode 100755 contrib/git-shell-commands/help
 delete mode 100755 contrib/git-shell-commands/list

diff --git a/contrib/git-shell-commands/README b/contrib/git-shell-commands/README
deleted file mode 100644
index 438463b..0000000
--- a/contrib/git-shell-commands/README
+++ /dev/null
@@ -1,18 +0,0 @@
-Sample programs callable through git-shell.  Place a directory named
-'git-shell-commands' in the home directory of a user whose shell is
-git-shell.  Then anyone logging in as that user will be able to run
-executables in the 'git-shell-commands' directory.
-
-Provided commands:
-
-help: Prints out the names of available commands.  When run
-interactively, git-shell will automatically run 'help' on startup,
-provided it exists.
-
-list: Displays any bare repository whose name ends with ".git" under
-user's home directory.  No other git repositories are visible,
-although they might be clonable through git-shell.  'list' is designed
-to minimize the number of calls to git that must be made in finding
-available repositories; if your setup has additional repositories that
-should be user-discoverable, you may wish to modify 'list'
-accordingly.
diff --git a/contrib/git-shell-commands/help b/contrib/git-shell-commands/help
deleted file mode 100755
index 535770c..0000000
--- a/contrib/git-shell-commands/help
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-if tty -s
-then
-	echo "Run 'help' for help, or 'exit' to leave.  Available commands:"
-else
-	echo "Run 'help' for help.  Available commands:"
-fi
-
-cd "$(dirname "$0")"
-
-for cmd in *
-do
-	case "$cmd" in
-	help) ;;
-	*) [ -f "$cmd" ] && [ -x "$cmd" ] && echo "$cmd" ;;
-	esac
-done
diff --git a/contrib/git-shell-commands/list b/contrib/git-shell-commands/list
deleted file mode 100755
index 6f89938..0000000
--- a/contrib/git-shell-commands/list
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-
-print_if_bare_repo='
-	if "$(git --git-dir="$1" rev-parse --is-bare-repository)" = true
-	then
-		printf "%s\n" "${1#./}"
-	fi
-'
-
-find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{} \; -prune 2>/dev/null
-- 
1.9.2+fc1.27.gbce2056
