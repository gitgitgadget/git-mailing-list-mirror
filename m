Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09821FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756196AbcKVUOr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:14:47 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34238 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756151AbcKVUOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:14:46 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so5622163pfb.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r4FPDMbRjJfSn47DNtE77VqR2XkrBQZ4FQ4mLkelr24=;
        b=JfT7xPOChIm5CR6rwxywuAPzrmW/emCXiQKvZFlvYzx9VqC0pbsvrQiWzyRTXkKdCP
         lOOqI9XXiacE1sHMR5Z3pxn1tfEW+YnqeeIPYVn0in/RfzV68o4ATgGyMCqiZopQaRhB
         RsrGUHG0JYd8I5UswMAwFiYvfn/Gh8Bl4ijch2cqTfgpw1j1Jr9o1G+B5HohTISYL1E9
         AHP2f8fTEIvAAAxxuHlnyKrGMOF+Q+vQrice6guNOPstZJdF3kwG+WnACsKZoI7ZGFGL
         CL7A1G1zD74htRsGlbu2i9Vg2K8ZnPY+7u0RYvSbh6frj4g7BqFVCSNffbLZ9e00tR3X
         8oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r4FPDMbRjJfSn47DNtE77VqR2XkrBQZ4FQ4mLkelr24=;
        b=YRWLeVWS/RnKpyjbvEm8bAST449CARA7Y5vCdoKq+QWf+2K7cjBrBUU9YhZPEJt9L+
         e+MINBncGlZxU1//7JvCrlMRBcV+g9luj7zpMfzlYe8pf8QMjrt/TRrhtacsOhDoHFWT
         QdD+Yumv1RezVd2ZTkOehxaa9QM+f2/lBRjsr6Q9SBZ9lCtWvygIVEpEmEdnRKzKuwTp
         VUfk3C9M5JeFEtNHsJ2e/R8LzCuWjMZ0uJjnf/7tiKjnA9KDHRe/RbUV1KFymEds/jyf
         oK6SsdhBPWRJootVs9VtVWytl2Vjg6aSfgbl97QBseBEdaDBiNlUS/CfPQIS8SQlOh8V
         0avA==
X-Gm-Message-State: AKaTC03AJAqxgY6t43zvIyjTnYkv7C5uT5tiM1n31HweMZmBkmbfBH1LHe1OGGnPWVJRsHmt
X-Received: by 10.98.223.25 with SMTP id u25mr27031658pfg.96.1479845685492;
        Tue, 22 Nov 2016 12:14:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id x90sm47107073pfk.73.2016.11.22.12.14.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 12:14:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/3] submodule config: inline config_from_{name, path}
Date:   Tue, 22 Nov 2016 12:14:36 -0800
Message-Id: <20161122201438.16069-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122201438.16069-1-sbeller@google.com>
References: <20161122201438.16069-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no other user of config_from_{name, path}, such that there is no
reason for the existence of these one liner functions. Just inline these
to increase readability.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 098085be69..15ffab6af4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -471,18 +471,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
-static const struct submodule *config_from_path(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *path)
-{
-	return config_from(cache, commit_sha1, path, lookup_path);
-}
-
-static const struct submodule *config_from_name(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *name)
-{
-	return config_from(cache, commit_sha1, name, lookup_name);
-}
-
 static void ensure_cache_init(void)
 {
 	if (is_cache_init)
@@ -508,14 +496,14 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from_name(&the_submodule_cache, commit_sha1, name);
+	return config_from(&the_submodule_cache, commit_sha1, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from_path(&the_submodule_cache, commit_sha1, path);
+	return config_from(&the_submodule_cache, commit_sha1, path, lookup_path);
 }
 
 void submodule_free(void)
-- 
2.11.0.rc2.4.g3396b6f.dirty

