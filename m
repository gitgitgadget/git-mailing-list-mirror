From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 02/11] update-index: use enum for untracked cache options
Date: Wed, 20 Jan 2016 10:59:35 +0100
Message-ID: <1453283984-8979-3-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpee-0007rV-PL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbcATKGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:16 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35913 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979AbcATKGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:06 -0500
Received: by mail-wm0-f44.google.com with SMTP id l65so172184267wmf.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VzhsZG/C4UUjU+DHjHuhfHI4xaa+G7B4mpfuiSMHEYc=;
        b=BeWaSJ0/DjAKERwFrt9AdE4hi+wt57214aEK2GONZY+XXWcRfPPVMGylHL0aXfyaXr
         CbQM7SK5D9itVHnh1QkohKNVq0qaWiBajh+pgw2bOWilWQg7wzJ/rko8ymLM3vCjFVvd
         JT7MaUq02bwYqvGFDTz0wvtlnNHyuHDR/Jeyus0dZdni0ZFEQCi1imYo7DIMeu8njIPN
         YoMQyTWv5Akay1S68Erneq+wVO+npTn5O4byExqRLxABmRx0RQGtEHCvQWgH1HqOKzT5
         /OYw5rPv1mw5FNnYp4CeBPaQVKlCCstGSpIKdhtVlzp+oRNuONQUfIw8nSG3K+a//MF5
         TGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VzhsZG/C4UUjU+DHjHuhfHI4xaa+G7B4mpfuiSMHEYc=;
        b=V4h3VgYPMZjhENn43FpbHOYT+ie59mRwIlRjvu5vxM/Fpv++P8OC45TnpC2C/WFKAi
         bBmAkINmCWdVkgFP/Rvs1A/vzrGbk6Ioxdltx5+lQRZHOx6hF1fF6s9o1Y1szOVc9yLC
         PzltxWPGrJLkHz7rXeqJcHb7/eNGM/EjfGDioEGvddrONGYWLNGh9e+Y92mWryYnV2D2
         5PmUKYeTVfi/y2tq0SMP8zCzegQ8MaB8FTcimN3B9zaHsHmZbNf/pEXI1yxwXY6REiTw
         dqJfXKXISzufufGkgbojfUu/T9HwclkubMytB0bhbIfwkOhk/DZbcWzYOCvDrDoQ/cu2
         wwGQ==
X-Gm-Message-State: AG10YOTocXNHKyBIXuuDtK1GbRgpPcg1vVNAbbMFdQO1TpqU0AifG+OMrQuRtePlyWaSnw==
X-Received: by 10.28.4.139 with SMTP id 133mr2868632wme.21.1453284365409;
        Wed, 20 Jan 2016 02:06:05 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:04 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284437>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Duy Nguyen <pclouds@gmail.com>
---
 builtin/update-index.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6fff87..1e546a3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+/* Untracked cache mode */
+enum uc_mode {
+	UC_UNSPECIFIED = -1,
+	UC_DISABLE = 0,
+	UC_ENABLE,
+	UC_FORCE
+};
+
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
@@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
-	int untracked_cache = -1;
+	enum uc_mode untracked_cache = UC_UNSPECIFIED;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_END()
 	};
 
@@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0) {
+	if (untracked_cache > UC_DISABLE) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
@@ -1122,7 +1130,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (!untracked_cache && the_index.untracked) {
+	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
 		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-- 
2.7.0.36.g6be5eef
