From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/2] cache: remove unused function 'have_git_dir'
Date: Sat, 26 Oct 2013 19:03:02 +0200
Message-ID: <1382806982-20634-2-git-send-email-stefanbeller@googlemail.com>
References: <1382806982-20634-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 26 19:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va7GX-0008TR-Qx
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 19:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3JZRDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 13:03:06 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:36498 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab3JZRDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 13:03:03 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1327041eak.36
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8sIjmL9/ZpDV6qqWornbhwe/KTB2hWlRwfq+bohedk=;
        b=cLvcVTPPctckWvIRzvm0xzc8IDQwyM07lWu6FK1Z2UykdPtOFJO+zYlx7jg92BGXJD
         of7gqxoLHlllK9hzP8UE45VqrPHOgJq9RzSol2uTTb7o97yhcjN/NS6x2JNrRuR0mhTq
         LhWsw6J3wBZaGCa7GmeUqVQhbWhZBIiY4zwAZ2XyBbOqqvYqZWhQO5yAs2yUVFgI04PT
         LVDBIXIaI53nCGdTBZXWGbqggAghphGzwMQnUQ0Fipe7/ubEYYf+LAUQFM4ymlT6UMk5
         6Ju1vWn9VEfdA0x8rPpT3bcaQYW+aAaEpd1U+e7mcnFE4LTRv5tJFSDx3Ql9ssZaqAPB
         rEEg==
X-Received: by 10.14.104.5 with SMTP id h5mr13715422eeg.58.1382806982226;
        Sat, 26 Oct 2013 10:03:02 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a1sm33191416eem.1.2013.10.26.10.03.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 26 Oct 2013 10:03:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.605.g23c6912
In-Reply-To: <1382806982-20634-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236759>

This function was added in d2b0708 (2008-09-27, add have_git_dir()
function) as a preparation for adbc0b6 (2008-09-30, cygwin: Use native
Win32 API for stat).

However the second referenced commit was reverted in f66450a (2013-06-22,
cygwin: Remove the Win32 l/stat() implementation), so we don't need to
expose this wrapper function any more as a public API.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 cache.h       | 1 -
 environment.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/cache.h b/cache.h
index 464c8fb..7e98f9e 100644
--- a/cache.h
+++ b/cache.h
@@ -398,7 +398,6 @@ extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
-extern int have_git_dir(void);
 extern const char *get_git_dir(void);
 extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
diff --git a/environment.c b/environment.c
index 378254c..0a15349 100644
--- a/environment.c
+++ b/environment.c
@@ -155,11 +155,6 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !get_git_work_tree();
 }
 
-int have_git_dir(void)
-{
-	return !!git_dir;
-}
-
 const char *get_git_dir(void)
 {
 	if (!git_dir)
-- 
1.8.4.1.605.g23c6912
