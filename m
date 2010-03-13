From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 12/12] diff docs: remove <rev>{0,2} notation
Date: Fri, 12 Mar 2010 23:53:04 -0500
Message-ID: <1268455984-19061-13-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMj-0007qX-1V
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647Ab0CMExn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:43 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:38432 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757498Ab0CMExX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:23 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447878qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2iTh72d+jKu+Xp33Puyh6crmiwnLOqn+uDzjIaYbo70=;
        b=Py4hYNHB5A3VoWcik2rjUmpUE7De3gPqs+SjjWrD20HJg9+ps0zOs8pgch9SoOpEgd
         5YWjyKuW2QkD6VcKuOebGnbmm1j6CmqnLXqLt56EMRGQLyj02GbhX4KB/HM0w3zv8rWA
         9W82VPdTnOYKwBd8xT7kpcRwIi0Z4iI8X0i94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nwu63pQCpvl1z9UnTGfEINyh11reHzS2g4WTvokmGq5ZA7Br+rd6XU0H3uqhIDZCt+
         Flt3rPiWPgBtkXRS1asFg1oV9733226MM5q6slMl+5qSCKKcjmYO2MSZe75sue1uMFux
         DW5UfxgmSTjWpakbejgXa3wcwKGbUWAXP9t4o=
Received: by 10.229.230.208 with SMTP id jn16mr2551189qcb.106.1268456003266;
        Fri, 12 Mar 2010 20:53:23 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:22 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142086>

This notation is not used anywhere else, so it can be confusing when
first encountered.  Instead, prefer the slightly longer but just as
clear "[<rev> [<rev>]]", which is consistent with other commands.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
When I first ran `git diff -h` and I saw the old syntax, I was rather
confused.  It took me a minute to realize that this was the regular
expression syntax.  I think it's best to stick with one syntax, even if
it is a bit more verbose.

 Documentation/git-diff.txt     |    2 +-
 Documentation/git-difftool.txt |    2 +-
 builtin/diff.c                 |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 4582179..e2d868d 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,7 +8,7 @@ git-diff - Show changes between commits, commit and working tree, etc
 
 SYNOPSIS
 --------
-'git diff' [<common diff options>] <commit>{0,2} [--] [<path>...]
+'git diff' [<common diff options>] [<commit> [<commit>]] [--] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 8250bad..a02e3b5 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,7 +7,7 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [<options>] <commit>{0,2} [--] [<path>...]
+'git difftool' [<options>] [<commit> [<commit>]] [--] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/diff.c b/builtin/diff.c
index f73da93..e2e2efc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -21,7 +21,7 @@ struct blobinfo {
 };
 
 static const char builtin_diff_usage[] =
-"git diff [<options>] <rev>{0,2} [--] [<path>...]";
+"git diff [<options>] [<rev> [<rev>]] [--] [<path>...]";
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
-- 
1.7.0.2
