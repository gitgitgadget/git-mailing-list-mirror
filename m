Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD4F20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDFLf7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so4500956pgl.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10ZYZz/KCtQq+hTWl+4RRZs4YFEAPYAluyqXGvx5xco=;
        b=d7IdrH1/ZFKNBlUhJL5SMLfdYW5w0jyP2wUjwjs4Hv7rZTUHBLLYGZh1H8P1lTp+Jb
         NB2c1uWmbbeBqM280qmV7UzdNFXWY/DzfYkcWfCe730p6SWkRdk8eCJVOeuffiQTkSh6
         hOGS1h7vEcE04dHHrsWXDIjCQwqSa/8OgFm2czhjcFx3s2PXYvB0oBI/tEIZR4T9b4XK
         qBuFgwlgDsPlCbY6bs1iQXhupNggUmQqkpTDpY7Gn/Cx9HLLzhgwYVEQ0Eu0nlzAHDHc
         hV7UvHta0xY9UgqaHfyHEnpKwnK+0ZTArxl0DE+h3QW9T9OXRVvEw1DZh9wbF2lwOw7q
         TJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10ZYZz/KCtQq+hTWl+4RRZs4YFEAPYAluyqXGvx5xco=;
        b=mIJhDJC0o+J9+9IP92h3bsz2lKJVx542RTvE5cysa58h0vRDeyOpaWbC6+f2bm36Sl
         bstN+Hg0TbjUD8tmekt5p+oRHDu6KRTU/ElrtL3qWDg90j6bqtOu1YJ3WYXC6RX4jPwJ
         jL+YbSvmi1Dp6d1kYR3m8zSeO671hl3p2CauBG8YhE00h89ZrA/LT8ULIqhS2PUO47r1
         FLXrItawpl1kcJz/4FyX0egI6/S3pVWdizTiLT9sPd4s5XX+PMbJTVd2nQUOD9grfhE3
         hfkW+NmceYDJKthEm5CSrOFrFj1MmtwKFxpGzuO/pxMYPaPcT9gQlafYA9aQDBa7nWLY
         ftTg==
X-Gm-Message-State: APjAAAULwlXY7mnwfx9JmHZUkBDr9+fcra6bunt6OLItfThNc6WbHZ8f
        7zzevinINs9YWWtCfLQEYt0=
X-Google-Smtp-Source: APXvYqyBeqVT9uGGNJG0UjsIxVgifOVwclu4ItOwp3/fYJ/nSYIZwrpkDqGTFOKSFaEKnXCQ4plfNA==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr18307355pfd.89.1554550557957;
        Sat, 06 Apr 2019 04:35:57 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id b7sm73796349pfj.67.2019.04.06.04.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 08/33] refs.c: add repo_dwim_ref()
Date:   Sat,  6 Apr 2019 18:34:28 +0700
Message-Id: <20190406113453.5149-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 12 +++++++++---
 refs.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1f5864aa36..bd0fec5776 100644
--- a/refs.c
+++ b/refs.c
@@ -555,14 +555,20 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+int repo_dwim_ref(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **ref)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
+	char *last_branch = substitute_branch_name(r, &str, &len);
+	int   refs_found  = expand_ref(r, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
+int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+{
+	return repo_dwim_ref(the_repository, str, len, oid, ref);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index b630d5bde7..fd3dc1d0f4 100644
--- a/refs.h
+++ b/refs.h
@@ -149,6 +149,7 @@ struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.479.g47ac719cd3

