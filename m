From: Max Horn <max@quendi.de>
Subject: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 15:53:23 +0100
Message-ID: <1358348003-11130-1-git-send-email-max@quendi.de>
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 15:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvUNW-00051f-Di
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 15:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab3APOxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 09:53:43 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:46830 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173Ab3APOxk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 09:53:40 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TvUN0-00088F-9L; Wed, 16 Jan 2013 15:53:38 +0100
X-Mailer: git-send-email 1.8.1.1.435.g4e2ebdf
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358348020;aabc99cb;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213756>


Signed-off-by: Max Horn <max@quendi.de>
---
 cache.h           | 2 +-
 git-compat-util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index c257953..5c8440b 100644
--- a/cache.h
+++ b/cache.h
@@ -1148,7 +1148,7 @@ extern int check_repository_format_version(const char *var, const char *value, v
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
-#ifdef __GNUC__
+#if defined(__GNUC__) && ! defined(__clang__)
 #define config_error_nonbool(s) (config_error_nonbool(s), -1)
 #endif
 extern const char *get_log_output_encoding(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index 4f022a3..cc2abee 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -310,7 +310,7 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
  * behavior. But since we're only trying to help gcc, anyway, it's OK; other
  * compilers will fall back to using the function as usual.
  */
-#ifdef __GNUC__
+#if defined(__GNUC__) && ! defined(__clang__)
 #define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
 #endif
 
-- 
1.8.1.1.435.g4e2ebdf
