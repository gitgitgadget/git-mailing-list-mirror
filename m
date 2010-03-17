From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH 1/3] config.c: remove static keyword from git_env_bool()
Date: Wed, 17 Mar 2010 12:55:51 -0700
Message-ID: <1268855753-25840-2-git-send-email-lars@pixar.com>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 21:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrzVT-0006Kx-Do
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 21:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab0CQUF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 16:05:59 -0400
Received: from femx.pixar.com ([199.108.77.27]:42760 "EHLO femx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab0CQUF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 16:05:58 -0400
X-PixarMID: 42088956
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.51,261,1267430400"; 
   d="scan'208";a="42088956"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by post.pixar.com with ESMTP; 17 Mar 2010 12:56:04 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2HJu3FA025891
	for <git@vger.kernel.org>; Wed, 17 Mar 2010 12:56:03 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2HJu30W025890
	for git@vger.kernel.org; Wed, 17 Mar 2010 12:56:03 -0700
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1268855753-25840-1-git-send-email-lars@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142435>

Since this function is the preferred way to handle boolean environment
variables it's useful to have it available to other files.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 cache.h  |    1 +
 config.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 89f6a40..c29030f 100644
--- a/cache.h
+++ b/cache.h
@@ -945,6 +945,7 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
+extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
diff --git a/config.c b/config.c
index 6963fbe..70e4600 100644
--- a/config.c
+++ b/config.c
@@ -683,7 +683,7 @@ const char *git_etc_gitconfig(void)
 	return system_wide;
 }
 
-static int git_env_bool(const char *k, int def)
+int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
 	return v ? git_config_bool(k, v) : def;
-- 
1.6.5.2
