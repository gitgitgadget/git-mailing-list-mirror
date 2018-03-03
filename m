Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598171F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeCCLi0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42418 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id y8so4862390pgr.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbMfB8eoWRIV8J3D5I2a5W80CwPomJpVV8qdzSot4ms=;
        b=p9oS6CkRr0szNl8lwZHKuHfLOXkipe0MYlIdV5yZnkbWjTvCoS84nZ+lDoaa1JHr50
         6fpB3JHoYcSuNZp9V0neVv7yYJRl+xWc3OnIFfMuz9ues0/akCvjn2bFsFSX7V1NXI61
         O0/gzTT9DdAISlQXu0vCWrfMbrHknfe5blB0wN8AyjCykSf3zsRu2kY0Jh4kSXbgpYbe
         kgad31dF0n5NgfwoqiizTca03HshGigGxcKIXydgrI/xXk5i5Qp9PRry1zmH9EKdZe6l
         Bn51xtgRgEZoj/9jcsCg58H4DfPhTY79NUeOcyThGSY8Xe4qw58Knn+ILZRy0VkeYCjR
         JdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbMfB8eoWRIV8J3D5I2a5W80CwPomJpVV8qdzSot4ms=;
        b=AMOBU+zmJxOsnYEnomAvFkxvq6u/wJtCeBhWSTW+qyKllZhEtqm6281GoJg0P7AS38
         Y964817TOPTTAgEJZrljacqCSfiM4b2ll/S3AQB035AVxUDojtl1R72NnWweK/i1+5wu
         cLsHX88P2f7AzS9XHStPvJZ2vDVRUoDdDn/TLZtetsX7wPhu5BuX9GinGRCZzuTOUTWt
         hrhpGg8SwY8N/LDym+cz8AQ0td0GzLAPzhMHc7rgz3vz8kzjqyI0y0twQCdDapu1neZq
         omyReVD8nWHL/MbnQfDD/jKbZEMywSQfC53v/c5zYIin60ekclUNVOUognK7ucRZ2r28
         7Kew==
X-Gm-Message-State: APf1xPAsgswWd2qK+FkPEnBH2DRvz3hnYd+giwQcihMzx1811EUjAhGp
        Qtd4WMrCZYyga1nhRUnUz4n0VQ==
X-Google-Smtp-Source: AG47ELvvNzXOj9TEk44KPz5GdyyfRDQzK0LwNPFKkmP4/Wtj5LVqV5nQbYDN4Ah5FqxuOWAEQJw/EA==
X-Received: by 10.98.249.10 with SMTP id o10mr8781315pfh.222.1520077105057;
        Sat, 03 Mar 2018 03:38:25 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f11sm17064370pfa.166.2018.03.03.03.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/44] sha1_file: allow prepare_alt_odb to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:13 +0700
Message-Id: <20180303113637.26518-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 12 +++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/object-store.h b/object-store.h
index 20ba136c1f..141455b5b2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -24,8 +24,7 @@ struct alternate_object_database {
 	 */
 	char path[FLEX_ARRAY];
 };
-#define prepare_alt_odb(r) prepare_alt_odb_##r()
-void prepare_alt_odb_the_repository(void);
+void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index f34eb69e39..a3e4ef4253 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,17 +673,15 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb_the_repository(void)
+void prepare_alt_odb(struct repository *r)
 {
-	if (the_repository->objects.alt_odb_tail)
+	if (r->objects.alt_odb_tail)
 		return;
 
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository, the_repository->objects.alternate_db,
-			     PATH_SEP, NULL, 0);
+	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+	link_alt_odb_entries(r, r->objects.alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objects.objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.435.g8f24da2e1a

