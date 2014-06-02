From: Steve Hoelzer <shoelzer@gmail.com>
Subject: [PATCH] environment: enable core.preloadindex by default
Date: Mon, 2 Jun 2014 11:43:00 -0500
Message-ID: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 18:43:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrVKX-0006so-9e
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 18:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbaFBQnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 12:43:21 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:38439 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbaFBQnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 12:43:20 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so4889231oag.13
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=/IRHFsaDHpc0kz+g/Lb3asO3Kzd5QYQ6x5onADhGqiE=;
        b=uVSFqtSqRKhaQfnbpDPG2oG1Jw2C7+MC8qw0ydcHj/qwEiwlTpkXzvuK6ErkQJWBRW
         pEWEHq29Yze9kt7aFbWbmNdka+JdTP0Y/QdVux46+86/bbVpv6zQ4YRk8l8McGaTK4CB
         bWhRhDYdvRpq26/kSMCPdxSZWyxeJlsuobYYmIBGUgIU4wivk2cf2FBGD2ebTpqyDyQZ
         oZXoADU1BFYQyscVSV7EMPWLBPT+13l7Rgav6CcdNOqLnsqGosc3Bwvkm3uNK9sO3v8P
         dUz+hzXTA/mFwDZQVgUU7ou5nPK6eLKAvOwCMga3iOTuWOWURW9ifU7S9VYcyajl7Qdr
         mCJA==
X-Received: by 10.60.101.170 with SMTP id fh10mr39466991oeb.39.1401727400208;
 Mon, 02 Jun 2014 09:43:20 -0700 (PDT)
Received: by 10.182.115.130 with HTTP; Mon, 2 Jun 2014 09:43:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250572>

There is consensus that the default should change because it will
benefit nearly all users (some just a little, but some a lot).
See [1] and replies.

[1]: http://git.661346.n2.nabble.com/git-status-takes-30-seconds-on-Windows-7-Why-tp7580816p7580853.html

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
---
 Documentation/config.txt | 4 ++--
 environment.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..4b3d965 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -613,9 +613,9 @@ core.preloadindex::
 +
 This can speed up operations like 'git diff' and 'git status' especially
 on filesystems like NFS that have weak caching semantics and thus
-relatively high IO latencies.  With this set to 'true', Git will do the
+relatively high IO latencies.  When enabled, Git will do the
 index comparison to the filesystem data in parallel, allowing
-overlapping IO's.
+overlapping IO's.  Defaults to true.

 core.createObject::
  You can set this to 'link', in which case a hardlink followed by
diff --git a/environment.c b/environment.c
index 5c4815d..1c686c9 100644
--- a/environment.c
+++ b/environment.c
@@ -71,7 +71,7 @@ unsigned long pack_size_limit_cfg;
 char comment_line_char = '#';

 /* Parallel index stat data preload? */
-int core_preload_index = 0;
+int core_preload_index = 1;

 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-- 
1.9.0.msysgit.0
