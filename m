Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8990A1F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeEOXmp (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40515 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeEOXml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so727203pgc.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcNsoPvmrhg4Dek4dsq1c0lRDi/Sww5t+sOOLppOjJM=;
        b=JItmGwfwRpht943qIJRnivptj3uWO/OtCC5uXT6NvcI3H+PxziOsx+5iu0/PZgTEkw
         OeiYod9ST1Ed649Ht8aDc+iVgWLG3M1WvOqcUOpnTmhT01oQfgCF/ZPW8RcQ2qGrCyHI
         +kdwvESAtAlh4PodY2lXYMZiulTD7hsqlOU3PQlncIkVkGJeEoZwKizW4BgrDCt8l44N
         IytChfsxDHqCTdQtwAQ/MZxUoj+pHo3HVXwpPy0MtRGcj1lGFZZRSwHKtU5ynAT5YuCa
         bsePWfliEhzauhI2LreQy75tSh4VxfsQTDF2HC1VL1GmH7y2xsPqwAJzuVDfVWx2et2b
         Iemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcNsoPvmrhg4Dek4dsq1c0lRDi/Sww5t+sOOLppOjJM=;
        b=XSWXSHcRXDI7nnoMoolq5igeomgVs/y1UwRPPGM8ivvVO3lzvYa3554/2dr3Wyg3Mj
         mLOu6YRGs6SJAv85vxDaH2DriFDRt43IhYxRodlesWm3j/YTsdhiuJqupIXhHQHAPI/k
         y6TqQCkUtveEAXro+OID5ZpDd6jyHMfmN+G5q9f128frGl67xtEy6ANs6DrwhNATPbBk
         GgTvw3HY1mK6B0+KEsjWzGKyIEIFbqK/tof+/VMJSV7V3Sh1+fbc3JDhOWzUfMbhB75b
         Hob5F3EJkfON0VWbqbE+b4UfpVhdVL3s6eQ0PXEnEXe8KX/BV7Ur/FL//zVWF0+Aaygn
         0gdg==
X-Gm-Message-State: ALKqPwdIt/tmGm95HB4CmL++KfNUqXSkbrZsD2vg2Ob5njYE+FRor0zt
        AfispyfEf+xZKU9t55GLhZpvrOu3its=
X-Google-Smtp-Source: AB8JxZoLNzWj1Eaqic0Vir4y5cmIPcNoXcIQMByFv9vVu2WZRuYs33ui10wOEaeUMMfiHtHAnZQ7GA==
X-Received: by 2002:a65:4c05:: with SMTP id u5-v6mr9042970pgq.388.1526427760327;
        Tue, 15 May 2018 16:42:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1523840pff.87.2018.05.15.16.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/19] commit: add repository argument to commit_graft_pos
Date:   Tue, 15 May 2018 16:42:17 -0700
Message-Id: <20180515234233.143708-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of commit_graft_pos to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index a0c9eb05c82..2cd5b8a0b96 100644
--- a/commit.c
+++ b/commit.c
@@ -104,7 +104,8 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-static int commit_graft_pos(const unsigned char *sha1)
+#define commit_graft_pos(r, s) commit_graft_pos_##r(s)
+static int commit_graft_pos_the_repository(const unsigned char *sha1)
 {
 	return sha1_pos(sha1, the_repository->parsed_objects->grafts,
 			the_repository->parsed_objects->grafts_nr,
@@ -113,7 +114,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->oid.hash);
+	int pos = commit_graft_pos(the_repository, graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -213,7 +214,7 @@ struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 {
 	int pos;
 	prepare_commit_graft();
-	pos = commit_graft_pos(oid->hash);
+	pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return NULL;
 	return the_repository->parsed_objects->grafts[pos];
@@ -229,7 +230,7 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 
 int unregister_shallow(const struct object_id *oid)
 {
-	int pos = commit_graft_pos(oid->hash);
+	int pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
-- 
2.17.0.582.gccdcbd54c44.dirty

