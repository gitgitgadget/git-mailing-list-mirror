Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2521F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeHMS6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39080 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeHMS6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so13012493lji.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lbOnOFowa7REe+NQAwthE4JkbspVc1VM+xrGSN/+tzo=;
        b=IMYeEO57vT9r47C92TxpkdCbn5lA274ovUMmuw1Vo9ZLlaeN1m8cuY303VKF8v4RE8
         KgS5F75at8E/iPu8P35l6fpRB6o5Kb+qkQAgjA0dEhoWY/rf9dPi/WommAeUHPdvaLV1
         d7zelBevXqtFbifepEcTTf0CljKgsoZM3Wd5nzFEOVVHUPbQMT7EwNL5611d8UvaTj2P
         LQpiWWKQEEk04T4RMxFnHbBLJkOGCvWLzFThSatucF44q6BarYMy2rzpYcnTFnkqmT/u
         jhfCLjr8kBobuAvqUtuLeziop5WAflOjDf18pK/7arNkwqlGVvNPRtjNpuBxN7JXcKx2
         9oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbOnOFowa7REe+NQAwthE4JkbspVc1VM+xrGSN/+tzo=;
        b=my0E9EBf3+YUXaofY14kfJOKTephWB/h0Gi+TXOYrInvu7d8voLo+XUI8ATDv3yxFZ
         coiHqn5w2C2ty0+REoLw7vrBpJrbC71ZoSFUonoyHY5Py0wGoi3De82Rr7u636E33OcX
         7cg6VX5lBmEcr9g7NO9x3MKJEPG4X8Bpv3wwMoluyJ4dF06kUpn+W9+DVMEb21hso13s
         yPz48GKbiIWZgY8LGzN1t2zN1c0QV41Hutm8QxlGUcJnjIqHivv/tNV4rkDC2nAo713Z
         vxhK3NVXQsAl3CuGAvLCvsk8SC7QJt3Dh96uxoweeZ4eqKzJISxyivf5ZdslllDqubyI
         slGw==
X-Gm-Message-State: AOUpUlGQynZrPjBKvfqh3CeH6hnNkLgy3IyhqnuXbqMwaOJcFUGkJZII
        aa7fBz7mapfKPlfPRUu7Z55z7okd
X-Google-Smtp-Source: AA+uWPx6TL8pBE9QJBoDivfVx5pQo/Qb0uvR+0j/86l31TfoVkltrOQOAattgpMjYZ2a1Zb4hNCUNQ==
X-Received: by 2002:a2e:590e:: with SMTP id n14-v6mr12328180ljb.128.1534176940679;
        Mon, 13 Aug 2018 09:15:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/24] archive-*.c: use the right repository
Date:   Mon, 13 Aug 2018 18:14:36 +0200
Message-Id: <20180813161441.16824-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With 'struct archive_args' gaining new repository pointer, we don't
have to assume the_repository in the archive backends anymore.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive-tar.c | 2 +-
 archive-zip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 7df8565246..69ff23dfb0 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -277,7 +277,7 @@ static int write_tar_entry(struct archiver_args *args,
 		memcpy(header.name, path, pathlen);
 
 	if (S_ISREG(mode) && !args->convert &&
-	    oid_object_info(the_repository, oid, &size) == OBJ_BLOB &&
+	    oid_object_info(args->repo, oid, &size) == OBJ_BLOB &&
 	    size > big_file_threshold)
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
diff --git a/archive-zip.c b/archive-zip.c
index abc556e5a7..107da5f97e 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -326,7 +326,7 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = 0;
 		buffer = NULL;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type = oid_object_info(the_repository, oid,
+		enum object_type type = oid_object_info(args->repo, oid,
 							&size);
 
 		method = 0;
-- 
2.18.0.1004.g6639190530

