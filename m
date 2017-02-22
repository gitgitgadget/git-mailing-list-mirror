Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45C6201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbdBVOGE (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34451 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932600AbdBVOFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:05:53 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so550329pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DUiK7cqfEScCV8JhKBNnJYvWTwOtas6DlYYMKBlBGU=;
        b=gqUVS+zrr8b8mAyYBchVfga1MqvkP1uijUWqH7mjgQJ9+wSI5c/NopHCLJEP5gfVId
         k3Hk12gpjLIw2WM8ZjFnP9Ho69qcjzgfZW02Ww7c6PU/rPC3FyuRcKurYmdLAFUVxjmE
         R0v82gmbjLiKgQzybIzL1+yy7LQQejjCLfzPaLscTwBA1DVi+fjMJU6mEB5jkb4tVoGq
         7stswU2yPEFWHn2MT499B/ciCdw7gF6VvDdRIWr6qECaeIs5noj/nhaq1ifczai/5jKv
         kmKCiveej07+11O88XRmF6TTyhG8B7a+CK03f/uQER/zWbz7yBwmyzmlrmOF/bf3hu4o
         mb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DUiK7cqfEScCV8JhKBNnJYvWTwOtas6DlYYMKBlBGU=;
        b=nlV/tFwhvjSCVEf5II5ejEkhaByWmqjYmoSKFBMimtD2W64LAXdBZkW8RN0NF0Ypl3
         0la0/sqpQfMtoaePWR0sRYI6RuLa6tic87FwXwQ0RvbpOQ3RyG4k0v7o8e6/x46Z8PU6
         /jbbGXZErN4+40bv4rtvJJ7IKDmTad952+NjtKsH0ZlJ59l4ZeHDBVacVrL+/QjjbW5o
         gV/NUlWk78dehxFCblVPMUxocUqCqIXIGtAw/hjTE4oOScVfyUoV5l3GHeFkpXXGCC0Q
         1ImBkRZ/P+j5pUh/imdsINXuWSZQ1qEHTJP4kMM1BAu3S0dDWOf3OnbtGyhiMe5kCJlB
         vRsA==
X-Gm-Message-State: AMke39mezwjLANfnkhmFxufcF+XE0UJyxh1UwLauBfe5NtUOtkXNGRrSi2oIv2YeznzIEw==
X-Received: by 10.98.209.73 with SMTP id t9mr40588232pfl.9.1487772352706;
        Wed, 22 Feb 2017 06:05:52 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r78sm4084930pfl.63.2017.02.22.06.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:05:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:05:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 03/24] files-backend: add and use files_packed_refs_path()
Date:   Wed, 22 Feb 2017 21:04:29 +0700
Message-Id: <20170222140450.30886-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep repo-related path handling in one place. This will make it easier
to add submodule/multiworktree support later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1ebd59ec0..4676525de 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -923,6 +923,8 @@ struct files_ref_store {
 	 */
 	const char *submodule;
 
+	char *packed_refs_path;
+
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 };
@@ -985,7 +987,14 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	refs->submodule = xstrdup_or_null(submodule);
+	if (submodule) {
+		refs->submodule = xstrdup(submodule);
+		refs->packed_refs_path = git_pathdup_submodule(
+			refs->submodule, "packed-refs");
+		return ref_store;
+	}
+
+	refs->packed_refs_path = git_pathdup("packed-refs");
 
 	return ref_store;
 }
@@ -1153,19 +1162,18 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	strbuf_release(&line);
 }
 
+static const char *files_packed_refs_path(struct files_ref_store *refs)
+{
+	return refs->packed_refs_path;
+}
+
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
  * creating it if necessary.
  */
 static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
-	char *packed_refs_file;
-
-	if (refs->submodule)
-		packed_refs_file = git_pathdup_submodule(refs->submodule,
-							 "packed-refs");
-	else
-		packed_refs_file = git_pathdup("packed-refs");
+	const char *packed_refs_file = files_packed_refs_path(refs);
 
 	if (refs->packed &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
@@ -1184,7 +1192,6 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 			fclose(f);
 		}
 	}
-	free(packed_refs_file);
 	return refs->packed;
 }
 
@@ -2160,7 +2167,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &packlock, git_path("packed-refs"),
+			    &packlock, files_packed_refs_path(refs),
 			    flags, timeout_value) < 0)
 		return -1;
 	/*
@@ -2426,7 +2433,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(refs, 0)) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		unable_to_lock_message(files_packed_refs_path(refs), errno, err);
 		return -1;
 	}
 	packed = get_packed_refs(refs);
-- 
2.11.0.157.gd943d85

