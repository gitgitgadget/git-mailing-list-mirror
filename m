From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 10/11] test-dump-untracked-cache: don't modify the untracked cache
Date: Wed, 20 Jan 2016 10:59:43 +0100
Message-ID: <1453283984-8979-11-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpf9-00080T-DF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934205AbcATKGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:47 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35035 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933611AbcATKG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:27 -0500
Received: by mail-wm0-f48.google.com with SMTP id r129so124178322wmr.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NusQUUmz8MXV3ZoqC0qSsR2BqQ/cNSKzoF6ucfHkMw=;
        b=J++GmFtdwMGV4jYl3rEw1yz+zzwiUTHYWJSHenbQFD1+THMi8Cd+ko6oU3SnYKHhz2
         qAaXxekWl5rRIfvjQ7HKp8xupeOf5reS2SpHKh3oS9qhJrSXRmoUdlE2Ss6tsbCCEbQz
         XCnV1/EzuF6bj7GQ1ALr+X7s7/xwvqmN3ZZzHSbcsTGSNiJoIy3oIaljuKuOGu5+FR4K
         vLay/eo4gaDgDjlWzUpavj/oa28wZU5HGdUIXiAfwhfNVs/DLMcYAPa2Ty1oUqlY9Wov
         0agsDgPsP75DLj1q8bNQKV1I+YAzAXKG8XXGz2tw/lUHrE4XUJddKsaBHcdJywJHecvI
         1q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2NusQUUmz8MXV3ZoqC0qSsR2BqQ/cNSKzoF6ucfHkMw=;
        b=F5hF12AQngSmnedi7kT3x6cXX/vpsMYbCkbAT6YE6mrUY1dFHj7VWGWZ1MRAie/Y3g
         Nt8Os33qAvNYRAzBV7jIIbzj7xUfN2MSx39vD5CV8WvfPwXP5h9JU8RZR3FMYnaXoe1o
         QiMRfzexqw52XkDJHtxDPWu9Mca9TQHdckrLWfHxOdAM5LfAlvBy0jwi6cBEJt3QWD6M
         BlqDtHCyXy0YI+HsP/o8QX43yDKYMfCxcQCi8czzPT6AN16yFCM884yIYgsK58yPh2Y/
         OQKO78rjOTr+/BEVVo0fpaL083u5P5ePo3t2LtI6H3cED8JOlUHGNmCgyeM5BqlMc+tX
         qJNw==
X-Gm-Message-State: AG10YOS3FrjHmcLym7/uDmK9quksbSbWaQlkeYicTaD9ekbyNqiTd+v5+thToAKMvHVO3g==
X-Received: by 10.28.4.139 with SMTP id 133mr2870697wme.21.1453284386740;
        Wed, 20 Jan 2016 02:06:26 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:25 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284443>

To correctly perform its testing function,
test-dump-untracked-cache should not change the state of the
untracked cache in the index.

As a previous patch makes read_index_from() change the state of
the untracked cache and as test-dump-untracked-cache indirectly
calls this function, we need a mechanism to prevent
read_index_from() from changing the untracked cache state when
it's called from test-dump-untracked-cache.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h                     | 7 +++++++
 config.c                    | 4 ++++
 environment.c               | 7 +++++++
 test-dump-untracked-cache.c | 4 ++++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 59a15fd..bb4fc18 100644
--- a/cache.h
+++ b/cache.h
@@ -1605,6 +1605,13 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 
+/*
+ * This is a hack for test programs like test-dump-untracked-cache to
+ * ensure that they do not modify the untracked cache when reading it.
+ * Do not use it otherwise!
+ */
+extern int ignore_untracked_cache_config;
+
 struct key_value_info {
 	const char *filename;
 	int linenr;
diff --git a/config.c b/config.c
index 647a15e..b95ac3a 100644
--- a/config.c
+++ b/config.c
@@ -1599,6 +1599,10 @@ int git_config_get_untracked_cache(void)
 	int val = -1;
 	const char *v;
 
+	/* Hack for test programs like test-dump-untracked-cache */
+	if (ignore_untracked_cache_config)
+		return -1;
+
 	if (!git_config_get_maybe_bool("core.untrackedcache", &val))
 		return val;
 
diff --git a/environment.c b/environment.c
index 1cc4aab..6dec9d0 100644
--- a/environment.c
+++ b/environment.c
@@ -87,6 +87,13 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
+/*
+ * This is a hack for test programs like test-dump-untracked-cache to
+ * ensure that they do not modify the untracked cache when reading it.
+ * Do not use it otherwise!
+ */
+int ignore_untracked_cache_config;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 25d855d..0a1c285 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,10 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
+
+	/* Hack to avoid modifying the untracked cache when we read it */
+	ignore_untracked_cache_config = 1;
+
 	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
-- 
2.7.0.36.g6be5eef
