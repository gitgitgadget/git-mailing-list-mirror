Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82C41F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBFAFN (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:05:13 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38793 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeBFAFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:05:12 -0500
Received: by mail-pg0-f68.google.com with SMTP id l18so132135pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LbpKQRlyVhKuWtR39DbPOf2a32DzYfk+eK+Kvn3phBc=;
        b=Vn5JymHJdaLD6h5ET6op7exlIvAfstNkFMnsF3V7GyykexrjDFlIAIRLMwKGlm3stm
         xDT7Vdlqgm0dsUkEIexFc5Ia4leD5tTjXhBxa4ei11uBGjl/wsdqJhxekR8JpkKu0+OY
         F4RIVvmJ+jUcI1z+wTWs+W4vBA4ugYdduvFj6vnHwj3OpHRPVCak9koe2P7QrT5j+VsF
         jIDHoT4vVYRlGoc+1QgmIjNZqLZTq1gFXubwGwbNn/eZhZTn+AM7nLwZ0XMSqwDlDKy/
         mJG0kOuonRTiZqbTaFLv8dt0DeCPmgf9oRBLv3YyOof5ahHOhKJ0vkrLyNVWZh8VCbbZ
         8+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LbpKQRlyVhKuWtR39DbPOf2a32DzYfk+eK+Kvn3phBc=;
        b=GanikLNVJHQO3ezpaa8UzErWWA0O+2GTI/hLMd+RctOJ08RwwFO21a1JemO7j9N1Pz
         MHsIEwjHv2QAONTqi2NOFT99J+oMCKDstosroSfgEgGwiSWhlLjJH/tZ7Sd70sqHV0G7
         YTJvesschlIcCeTHg725FJV+dDKo5ZzZgDOLE6jsbfVuWTma7s2lqxXR+5zt2ho/auBt
         afZEQWMiE5uJz4UyDGnvezbh+hdBOSEVstbqRIz+5yHRBRLlmb+5iQl9G8T0Je8nRrL9
         G472fkenvogx+PDsJbx5Vlfasb37oc+crLT4Cye/8vp72j5P6Z+OoVAOEZnDYV97H3gF
         sqzQ==
X-Gm-Message-State: APf1xPB92dgXBdJn6ZF08lSyURO0C/lrrYtfIQgNkYKFi4mGrqmfMQPh
        pHjkodfeiAvKX7ohHwt3DRPT/eXx800=
X-Google-Smtp-Source: AH8x226KgDBG0Z/R0klAyYnIyKJO3jU4Pm9D8BU5tUAr3pcX7qiuWoYOCtQAwVs+cJcPBfufpAvW9Q==
X-Received: by 10.98.18.10 with SMTP id a10mr518527pfj.140.1517875511267;
        Mon, 05 Feb 2018 16:05:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i3sm14409750pgs.63.2018.02.05.16.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:05:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 054/194] replace-object: add repository argument to register_replace_ref
Date:   Mon,  5 Feb 2018 15:55:15 -0800
Message-Id: <20180205235735.216710-34-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike the other conversions this just takes the repository as the cb_data.

NEEDSWORK: callback interface doesn't supply a repository argument, so
we have to supply it ourselves as cb_data. It would be nicer to update
the callback interface in for_each_replace_ref to pass on the
repository at the same time as it gets a repository argument.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/replace-object.c b/replace-object.c
index 1479530d34..8d3e0a30fb 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -52,6 +52,8 @@ static int register_replace_ref(const char *refname,
 				const struct object_id *oid,
 				int flag, void *cb_data)
 {
+	struct repository *r = cb_data;
+
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
 	const char *hash = slash ? slash + 1 : refname;
@@ -67,6 +69,7 @@ static int register_replace_ref(const char *refname,
 	hashcpy(repl_obj->replacement, oid->hash);
 
 	/* Register new object */
+	(void)r;
 	if (register_replace_object(the_repository, repl_obj, 1))
 		die("duplicate replace ref: %s", refname);
 
@@ -78,7 +81,7 @@ static void prepare_replace_object(void)
 	if (the_repository->objects.replacements.prepared)
 		return;
 
-	for_each_replace_ref(the_repository, register_replace_ref, NULL);
+	for_each_replace_ref(the_repository, register_replace_ref, the_repository);
 	the_repository->objects.replacements.prepared = 1;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

