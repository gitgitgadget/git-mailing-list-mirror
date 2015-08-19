From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 6/9] config.c: Expose git_parse_maybe_bool
Date: Wed, 19 Aug 2015 11:26:44 -0400
Message-ID: <1439998007-28719-7-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5H0-0004yA-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbHSP1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:21 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38693 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbbHSP1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:18 -0400
Received: by igfj19 with SMTP id j19so8728779igf.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znlSSsLpTq8tQvhwX+3t4g73Vi267y6kwyqWqoNQtXQ=;
        b=Wi/UPRXxqW5zWVTcjrrntvn9/XYjEU/cEAJ6TvoAV61dxxmwUk03+Ymj1Nr2g2nxba
         q3mo3eMNoNgyVnDicFK0xBI5j8WxgvHsKeKbk3zk6ap/WF5Qlgx+kMfqLhYizYn9h5nD
         TkM1ZeCwnvteE4pwkkvqosczMIqjKCXbOsCI6y66UKN22Z/eBTlpEalP4L2RXhPmGMRQ
         G06OeTVyXLpYmnfoQJneRACl44zbQzSo5rdM6tOqJJWMQAHoEonfdVcO00hbFv8SI5cL
         DRF4nA4orKtkk78/eZe4IMDsGP67vrehW9cET8yiMhoePMaoaJmCS70SLsmZ9lbNc5ir
         UNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=znlSSsLpTq8tQvhwX+3t4g73Vi267y6kwyqWqoNQtXQ=;
        b=mT0a3Mv6C7eN3cECHy+fjxsByjixrUAymPb/jBIYhFvoM3ncTZk+VHNHQTlLW0VFyU
         gxbCBa1F1fS/0KZj+ZSGIZ4mFMjEsbJc3Ix3JLqolZCugUKbMzHdhuyqQEXH1D3Nrt0u
         X9OXlmlHefTGQgY4j2AzlxS2rfRyDcTLXVgRHNDlcQ9JvWXt4fNqZkVEYDDHHFvyHxNF
         hwyaPZpPVHa7ZkgTnlq14JDv4r2l5qRlQXQfyjecII5rhi5mdoYm7+PBryj1Xsgh04ms
         AOO3pZAk4Dcvx73EEtjvf1PustpA5vgreJwy4IEwDke6rhqF/BEqEJo66xZ0ky7cZLzo
         xtNQ==
X-Gm-Message-State: ALoCoQnkCTrMIS/iF8riVAbSzgTGJ2Lowee2o5qEfSqn0iSHHvAUScj+1yFruSNAzGHivOR64OiA
X-Received: by 10.50.56.104 with SMTP id z8mr2118666igp.45.1439998037467;
        Wed, 19 Aug 2015 08:27:17 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276188>

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 cache.h  | 1 +
 config.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 6bb7119..95d9594 100644
--- a/cache.h
+++ b/cache.h
@@ -1392,6 +1392,7 @@ extern int git_config_with_options(config_fn_t fn, void *,
 				   int respect_includes);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
+extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
 extern int64_t git_config_int64(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
diff --git a/config.c b/config.c
index 9fd275f..e5d7959 100644
--- a/config.c
+++ b/config.c
@@ -618,7 +618,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 	return ret;
 }
 
-static int git_config_maybe_bool_text(const char *name, const char *value)
+int git_parse_maybe_bool(const char *value)
 {
 	if (!value)
 		return 1;
@@ -637,7 +637,7 @@ static int git_config_maybe_bool_text(const char *name, const char *value)
 
 int git_config_maybe_bool(const char *name, const char *value)
 {
-	int v = git_config_maybe_bool_text(name, value);
+	int v = git_parse_maybe_bool(value);
 	if (0 <= v)
 		return v;
 	if (git_parse_int(value, &v))
@@ -647,7 +647,7 @@ int git_config_maybe_bool(const char *name, const char *value)
 
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
-	int v = git_config_maybe_bool_text(name, value);
+	int v = git_parse_maybe_bool(value);
 	if (0 <= v) {
 		*is_bool = 1;
 		return v;
-- 
2.5.0.276.gf5e568e
