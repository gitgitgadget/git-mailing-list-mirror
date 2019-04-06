Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA0C20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDFLhh (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36203 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so4765468pfn.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HRwL2T7MODfcXrlBYA8wLAi07ntXHgzSLd7OPKp/jk=;
        b=nXr2R6kCykoomacwVFuuP2Qg2v8cHLRdyBXrxfnMKHgtdTvAXA6KUItKv4TVhgoHAC
         eqkCWmq5DLkTAmdhW1nBx0/ATQ6ql2oDKAuxw64H/BwXQ53OK0QrEFy8ohY8XXEeeBL1
         PHzYtVIfj/uPiJUffjKN1Mn6T/ACz9V2ELrjB7QeETwWJehF+br4kGZ9TFGCROjGefRg
         Z8AKUJ40PR58fscku7f0OlFuRLDTl0saZSJolrAWVDmoBjNZEDHx6nhAMEq6eIV8HMPo
         BM5FTmk0r3fq7tLGA4BN+J0irF4ik8Q8YTkqTkbZlkuCqMlzg4l29J2bwnf13c1mQwHc
         xZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HRwL2T7MODfcXrlBYA8wLAi07ntXHgzSLd7OPKp/jk=;
        b=uUICwBviE4AZ1XBHRluOafjFN7kZraowYmfhzsJco36aWH6g4loJVr3iZ5yn3ali3X
         HL3Jdk/zcACfaT+9bEQryhtmKYRKx5QM0VkKZzBv2YgHWQFxWdooRg3GUu/ShdRPV6Dt
         U+nrESXhhHOLZe4u6ZNilZX4YBuaGGlYroHpPc6iXZ/f0/rYvkjA06IhtbkJqtTrk09t
         WHR4Ga6iKCxbMlTfYDybF1AIVLjHwiBA6KW4y5B0l/CJnjYFzZO8Lq25CJAYUNJkwqEm
         EQwYQsWiPPIhm5DL61xt7xStT/MVu+gNGrIAMW62aB9lHozUqu7L/LmFro+nJmVYjZge
         JE9Q==
X-Gm-Message-State: APjAAAU3Yz29AmvGvxa9HBQkTzXhfh/kkZ2DFCgdpanjUOutgKTcNllA
        t+gQjvLoI3qj+PV1E7y7CuyotNsS
X-Google-Smtp-Source: APXvYqyaoe9NgdhjS1EnkACNVDKR4BXUxfDUAG1hAtesWX9xo9JINzbF4C9zAQY8WC2U9G59UgmjEg==
X-Received: by 2002:a62:448d:: with SMTP id m13mr18402782pfi.182.1554550656559;
        Sat, 06 Apr 2019 04:37:36 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id r11sm53091015pga.87.2019.04.06.04.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 26/33] sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Date:   Sat,  6 Apr 2019 18:34:46 +0700
Message-Id: <20190406113453.5149-27-pclouds@gmail.com>
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
 dir.c       | 8 ++++++++
 dir.h       | 4 +++-
 sha1-name.c | 7 ++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index b2cabadf25..e6d97343f4 100644
--- a/dir.c
+++ b/dir.c
@@ -2315,6 +2315,14 @@ int file_exists(const char *f)
 	return lstat(f, &sb) == 0;
 }
 
+int repo_file_exists(struct repository *repo, const char *path)
+{
+	if (repo != the_repository)
+		BUG("do not know how to check file existence in arbitrary repo");
+
+	return file_exists(path);
+}
+
 static int cmp_icase(char a, char b)
 {
 	if (a == b)
diff --git a/dir.h b/dir.h
index e3ec26143d..47c5409ced 100644
--- a/dir.h
+++ b/dir.h
@@ -269,7 +269,9 @@ extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
 extern void clear_directory(struct dir_struct *dir);
-extern int file_exists(const char *);
+
+int repo_file_exists(struct repository *repo, const char *path);
+int file_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
diff --git a/sha1-name.c b/sha1-name.c
index d9050776dd..6caf3f4e3a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1664,11 +1664,12 @@ static void diagnose_invalid_oid_path(const char *prefix,
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(struct index_state *istate,
+static void diagnose_invalid_index_path(struct repository *r,
 					int stage,
 					const char *prefix,
 					const char *filename)
 {
+	struct index_state *istate = r->index;
 	const struct cache_entry *ce;
 	int pos;
 	unsigned namelen = strlen(filename);
@@ -1708,7 +1709,7 @@ static void diagnose_invalid_index_path(struct index_state *istate,
 			    ce_stage(ce), filename);
 	}
 
-	if (file_exists(filename))
+	if (repo_file_exists(r, filename))
 		die("Path '%s' exists on disk, but not in the index.", filename);
 	if (is_missing_file_error(errno))
 		die("Path '%s' does not exist (neither on disk nor in the index).",
@@ -1814,7 +1815,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			pos++;
 		}
 		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(repo->index, stage, prefix, cp);
+			diagnose_invalid_index_path(repo, stage, prefix, cp);
 		free(new_path);
 		return -1;
 	}
-- 
2.21.0.479.g47ac719cd3

