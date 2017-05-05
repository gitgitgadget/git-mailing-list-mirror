Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC2F207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbdEFStk (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33445 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdEFStf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:35 -0400
Received: by mail-qt0-f193.google.com with SMTP id a46so4889178qte.0
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8cjS7fxdUkDYpqBsceI/hMW4ncQKWfJrBKEFyWSWcv0=;
        b=jvVO7S4ZuAbSUWj6m9IeWMfcHTlD9I7QF8/Yo0nG6WXiCY416sdIshqjt6yya0Yj2O
         9o4/pQUmmVQTmRF1DpQBhUi0CEH8Vgzc04GAnMEK7yXOckz0SrtWQm+dnF6DJnMJytFE
         L7MxxzVvAv4LxrZk2SdbYI3LXdZgTU/xzdwVedcB1xU3Us+dryEQOLBGQkhGqxfGzNMX
         A2Ms9WbLoQDHSKfsu0DG10mytPZWJsRJRIenV3M80H77SHt1lANH5J+kbRt154nlA+GF
         m6cySgwQIuUeS/U0tnMaskmfBI3Nmw0kgLScMFgo6qDg1vYQzGeXTLNmmyJs0o0jlCTn
         F9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8cjS7fxdUkDYpqBsceI/hMW4ncQKWfJrBKEFyWSWcv0=;
        b=C90sTbbIIgBH7Aiy7L6YqbObFI82Aop7h90mLWJNDg2p1wBJVaVAKH7GkiPFa5X2YO
         mKPV/uAYxqKX4lrf5AVNQz39MQHapziRZMBpWxPLoxpqWGx1dwhRTAnGGdaDfEKJxjSU
         MmXPTLFcr0Irr8j1kZ/CffTv2cg7/pbBikmibtzVWOwVcwKAFCkp6AktMK9nC6XnXghA
         nsHLKGuaC1YNjrGvrCEwzYMzp3Z2Co1GNj5x4idxfMg0BWiDN8o/BLSVskZSSpgU/FA1
         8d0EKfM1al4vP5kS/oNHAkNZqtrxvWklkxQ++97uyyS1rNSswzsDcAj+SPK21CAyDgbg
         Yvsg==
X-Gm-Message-State: AN3rC/5S0Avz9ADmD/HjI6zi8AMTbh15q8NVtTnO23u60iOBycSHOp+5
        s7gFGn689TiOXYo8YAY=
X-Received: by 10.237.41.199 with SMTP id o65mr51821477qtd.239.1494096573834;
        Sat, 06 May 2017 11:49:33 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:33 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 6/9] dir: change linkage of cmp_name() and check_contains()
Date:   Fri,  5 May 2017 05:46:08 -0500
Message-Id: <20170505104611.17845-7-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 4 ++--
 dir.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index fd445ee9e..6a71683df 100644
--- a/dir.c
+++ b/dir.c
@@ -1844,7 +1844,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	return dir_state;
 }
 
-static int cmp_name(const void *p1, const void *p2)
+int cmp_name(const void *p1, const void *p2)
 {
 	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
 	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
@@ -1853,7 +1853,7 @@ static int cmp_name(const void *p1, const void *p2)
 }
 
 /* check if *out lexically contains *in */
-static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+int check_contains(const struct dir_entry *out, const struct dir_entry *in)
 {
 	return (out->len < in->len) &&
 			(out->name[out->len - 1] == '/') &&
diff --git a/dir.h b/dir.h
index bf23a470a..1ddd8b611 100644
--- a/dir.h
+++ b/dir.h
@@ -326,6 +326,9 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+int cmp_name(const void *p1, const void *p2);
+int check_contains(const struct dir_entry *out, const struct dir_entry *in);
+
 void untracked_cache_invalidate_path(struct index_state *, const char *);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
-- 
2.12.2

