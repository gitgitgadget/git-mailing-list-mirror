Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4F32095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdCRCcA (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:32:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34346 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdCRCb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:31:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id o126so10380566pfb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yuaaphKEnDapCUhkaIp+BQdwuw7aAxckqdQ3j3EWEs=;
        b=A6VwxFxLIaelOCe9xMvBttCjSBUEXnCyU9n6uDDZiOXeyysEMNqztui91Ji+idopWH
         Nxi9OmaxcTp9HJjY9IknBW9iruel37UjgL5rHz5dYvqwZyV3oBG3QQVGcp6ZkJDdXatP
         OLBSBFL9H/I5A+VefAcoA0jGommnH8JKO/4ucV2fqNKNtMf5ndJWZ9p5ePsQVI5JzOlc
         EaIxRP4THUeeajnSwN2LXYFmqa9sZUi6rw3l/EVFvhvIVXOVnIhPS30nUingXSRavyRq
         hQqxSCreTcetzsdUpDym9P5NWS0ldCnOYBpqSx7UROMF2dFt/aFpHs9MsHP5CCbFvA/3
         pBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yuaaphKEnDapCUhkaIp+BQdwuw7aAxckqdQ3j3EWEs=;
        b=q9MXB+BYZzbMYbpqoQzvOQ1qRaww6BjKykMLuns44q9l+5SFBVquct8tZVlReEdqBM
         dBxM9ccojqy9Eq/xr9Z7cWWpSPy0T3+vCYzAGNl2xjxJ3MNIpMs9ZXtcfDAbUgJL5qlt
         dI+a0kI1bCEmdhShUpiAQOHD4wSxWUGJtGY8CAtCuDWnn4hOYC0kD2X0mEY10SRtqrDl
         2ib87B/4m2yW7D6yinSU+Vli0Cgt1zorhrd5ksgZTp6tm8e6wauzl0JlmvzVGU9kYLbi
         zAtJCfeATL0NTEezZcNqsMum2CaRnrRl8mexNCltU8woVhyuKb4UmFi0EO7Mh/AWnaqi
         V3kA==
X-Gm-Message-State: AFeK/H2iLTX3KNhFeyS9h9HXlPH7XSGZfR0P5dtp3PYhvwgJB5/nmfLSUuPtdt0NGn4JFA==
X-Received: by 10.98.28.72 with SMTP id c69mr20335049pfc.8.1489802667280;
        Fri, 17 Mar 2017 19:04:27 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id b11sm19135931pfj.27.2017.03.17.19.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:20 +0700
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
Subject: [PATCH v6 04/27] files-backend: add and use files_packed_refs_path()
Date:   Sat, 18 Mar 2017 09:03:14 +0700
Message-Id: <20170318020337.22767-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
index 0ef80c51cc..6e6962151a 100644
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

