From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 10/11] test-dump-untracked-cache: don't modify the untracked cache
Date: Sun, 24 Jan 2016 16:28:23 +0100
Message-ID: <1453649304-18121-11-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbv-0001A9-Ip
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbcAXP3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36357 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcAXP26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:58 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so6786114wmf.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=plW73QyjDnRsOqlZ86ivEeU8GN/RR4xEajazfvSa3no=;
        b=hhD8t44yklEolUFbCTSSQoB+RLkbjDz1ixknb+Cw5yN/pB4QCc3QsF1qATIiOEmsk9
         5aWZaBxPpznBnLWsLJisEaRcvaGyLOk0f1gshl781aEK0xzVDIF7s8Tzm6CYczLCOZsi
         yIj/21JdpCHm1dadBUGX3fQanONirS7AQ0JlWSk+KeJZBPjFhYgc7VHdvOpOCtTSVjOs
         G/YPPbiaO6E/SaxMZj8lu2tIzHA5A3hbktKe1NnXFmo004avpgkvDFe8K0sqLM666HRT
         Py/Sc6+USKQupCPfPOyCpDHzA27rFFWe9oiWM02WVkb+FUgDeViyxO6yU5bR9mLxoXbo
         8mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=plW73QyjDnRsOqlZ86ivEeU8GN/RR4xEajazfvSa3no=;
        b=F2S5ZS/xAwx360YUUxLUQ/HdHzlNeC11X7sO5U3a/OxuciiARo2tl8fBEJyaSQykkW
         9xaJGDcb0SL29dn20VGm00YF91Wd/URM8APS6LtrEcyiMsOCS6Btbc6VpxxKTgSqoz40
         4XSfPu/CGZvqF/Po+zosnRs11Z2r1i7VdJ6RM/uxRX7rb0O61n7xZyc857Bohjx78K8q
         rsq2daEwZ6v72NRKSRTCNXvo8s6erHmEN7wB1aSkF48tI6vTFBosnQWgTTeKLNutgBX6
         s/RIOW+VW1kVfWI8wAhEg0HVpJpS1uQKWoMXRENTwrcFg6QTMXlY//GWI9gh7UQlAYeU
         aN1A==
X-Gm-Message-State: AG10YOTxARLtYjmgF3qeVsqb6t5KtSssn7I1jo4nYBtrI9tZ+Q2ithRD7BJKKV4vW/LVYA==
X-Received: by 10.28.111.217 with SMTP id c86mr12646410wmi.31.1453649337608;
        Sun, 24 Jan 2016 07:28:57 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:56 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284659>

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
index e2900d1..69b08e9 100644
--- a/cache.h
+++ b/cache.h
@@ -1608,6 +1608,13 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
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
2.7.0.181.gd7ef666.dirty
