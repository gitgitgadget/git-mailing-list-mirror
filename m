Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CCD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeBFA1o (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:27:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45994 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeBFA1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:27:39 -0500
Received: by mail-pg0-f65.google.com with SMTP id m136so162262pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3sm3Trx2WE9MDP0lx2RnCQLEV1n/EpuaCLsu0voOmXo=;
        b=N7jBP3TTsxAjSrifhd2ts+f9vLiwxUIYJh74XcWaR8I4I41ATpekrw/kLxum5ZWB2K
         ic8hO/ueWJMInlh1tEFXQc9c2/zg8Qk+XnP80G+P/ia11HRzJc3mpAicEWA8CdQSO9o/
         rBfCXVOTCJYjgmnIt/bJgW3X6RvKjkWn/Eax57K2zrGOv77Z7/h5hwWkG/jcSCgrl+la
         K92wqavLbfXtUaFI1rQTUVA1R3VTv5+Gi9wzFnFrnFKRD1v0dKjiV3bNqukEcZqSsXl7
         fb15HQQ2WOQQkDtb9mozoFb8bDNwQf8gIgKViaT9OlW/rpaPxZVyEA2RqX5MMP6Hv88d
         yyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3sm3Trx2WE9MDP0lx2RnCQLEV1n/EpuaCLsu0voOmXo=;
        b=b3gt9bwIRJvpea0RL7cpgDP4BjFDwBZuwRDxf20NePSm1Nv113nzdE3WqjXYKdUi2Z
         41F6MF1B7XY1n1SoDq3FWQPKl6Dkme+m29vJDXM0CQMhB+eXBBBNyM5/GjS1CbpXNnnv
         T8oA/8yVmIsCsD6M/q4Kxx+sJ6YktBexhTO4/ARS9fU/B1tzEax0Ii5J7wqrbgmAsDXk
         D2vRo7JNsorY4CysfdH8KUnME+1OzquztxMGOmhSY5d7B5ITB3fm3rJbhoqpgsksh8t2
         S8kpvNDNScuWfBY2op/GH5x9M3P1WA2T1oC3luRizqo/L9ogL4Axo2nTL4d8TjvaNYHQ
         ICpQ==
X-Gm-Message-State: APf1xPAxEZ90jYWfpupaYHXK0OpO1l3aMtWmB1S3SFgtl86/RYngO00Z
        tgcCZZfUNHdVnOzJeFgNRp/pvInJIlg=
X-Google-Smtp-Source: AH8x226xjmILPMxE8ELQQj1T1mPtb+vVHp5ZHUZ4yJFu7NABx4MwJ4hYR9WJ6gSo1/+B6PaEplILOA==
X-Received: by 10.101.67.202 with SMTP id n10mr232503pgp.116.1517876858905;
        Mon, 05 Feb 2018 16:27:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t8sm14406080pgr.21.2018.02.05.16.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:27:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 161/194] commit: allow parse_commit_gently to handle arbitrary repository
Date:   Mon,  5 Feb 2018 16:17:16 -0800
Message-Id: <20180206001749.218943-63-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 8 ++++----
 commit.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 67d329e13c..bd9049a9df 100644
--- a/commit.c
+++ b/commit.c
@@ -393,7 +393,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	return 0;
 }
 
-int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing)
+int parse_commit_gently(struct repository *r, struct commit *item, int quiet_on_missing)
 {
 	enum object_type type;
 	void *buffer;
@@ -404,7 +404,7 @@ int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(the_repository, item->object.oid.hash, &type,
+	buffer = read_sha1_file(r, item->object.oid.hash, &type,
 				&size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
@@ -415,9 +415,9 @@ int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_commit_buffer(the_repository, item, buffer, size);
+	ret = parse_commit_buffer(r, item, buffer, size);
 	if (save_commit_buffer && !ret) {
-		set_commit_buffer(the_repository, item, buffer, size);
+		set_commit_buffer(r, item, buffer, size);
 		return 0;
 	}
 	free(buffer);
diff --git a/commit.h b/commit.h
index 8532ddd69c..153f13600b 100644
--- a/commit.h
+++ b/commit.h
@@ -65,8 +65,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
 int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size);
-#define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
-int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
+int parse_commit_gently(struct repository *r, struct commit *item, int quiet_on_missing);
 #define parse_commit(r, i) parse_commit_##r(i)
 static inline int parse_commit_the_repository(struct commit *item)
 {
-- 
2.15.1.433.g936d1b9894.dirty

