From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Document escaping of special characters in gitignore files
Date: Wed,  5 Jan 2011 14:38:52 +0100
Message-ID: <1294234732-20094-1-git-send-email-jnareb@gmail.com>
Cc: Bruce Korb <bruce.korb@gmail.com>, avarab@gmail.com,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 14:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaTaU-0006K6-L8
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 14:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab1AENjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 08:39:33 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43857 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1AENjc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 08:39:32 -0500
Received: by wwa36 with SMTP id 36so16279717wwa.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 05:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YZlGT4gCqkmnFL734zGScGeMgYKEWDih64uuxh9TKAk=;
        b=LQy/ltu0+pLJ9NJuKI6kD3fGGmvRpmcRjBr3QgQOWkrekdCWknZPGrrSc4ZbS7zUas
         WHJVZ7EiNM5bs4FVsRu8JHU6ERbOYEYTAsU5/gy51SpY+HbIX2nB3WgH2Or1ZLDzCfQ7
         VcaAyO/JZlGDwMcz+NQwnC1T+kdvoy8ziVVqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PV36jfdDONozEu1UTYRd44oE/0BfYo0AmfOLmbD9nrAQpm8zh4UIkDIIxVP7EdkD0k
         VxGmgLpbzEnRAZ7CRSQWylXpigCt8EpcGNk03qE+LjtK8MxUnO4V096fF7I5F9wdaiqb
         JVHvZAL91iWNtkYe1O4CSN3jmuiwO8FcLaF1w=
Received: by 10.216.166.67 with SMTP id f45mr2488262wel.112.1294234771132;
        Wed, 05 Jan 2011 05:39:31 -0800 (PST)
Received: from localhost.localdomain (abwq27.neoplus.adsl.tpnet.pl [83.8.240.27])
        by mx.google.com with ESMTPS id n78sm11180037weq.3.2011.01.05.05.39.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 05:39:30 -0800 (PST)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164562>

You can use backslash to escape special characters, like '#' or '*',
in gitignore files.

Requested-by: Bruce Korb <bruce.korb@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was originally send 10 Sep 2010, but I guess it was lost
because it appeared only deep in thread inside response, and not as
well separated patch.  I have found about it when I got conflict
merging current code.

It applies on top of current 'master'.

 Documentation/gitignore.txt |    7 +++++++
 templates/info--exclude     |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7dc2e8b..20abc20 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -68,6 +68,7 @@ Patterns have the following format:
    for readability.
 
  - A line starting with # serves as a comment.
+   Use `\#` for a literal # character starting filename.
 
  - An optional prefix '!' which negates the pattern; any
    matching file excluded by a previous pattern will become
@@ -98,6 +99,12 @@ Patterns have the following format:
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
 
+ - You can escape special characters using backslash.
+   For example, "{backslash}#*" matches files beginning in `#`
+   (otherwise it would be considered comment),
+   and "{backslash}!*{backslash}?" matches files starting with `!`
+   (negate pattern prefix) and ending with `?` (glob wildcard).
+
 NOTES
 -----
 
diff --git a/templates/info--exclude b/templates/info--exclude
index a5196d1..2ebaf0d 100644
--- a/templates/info--exclude
+++ b/templates/info--exclude
@@ -4,3 +4,4 @@
 # exclude patterns (uncomment them if you want to use them):
 # *.[oa]
 # *~
+# \#*#
-- 
1.7.3
