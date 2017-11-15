Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DE2202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756478AbdKOAbM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:12 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:54638 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756119AbdKOAa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:30:57 -0500
Received: by mail-it0-f67.google.com with SMTP id b5so9525707itc.3
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhNIsCcME0XsXTl7aAaDIyDGnjAyi5m/IC5vqSFjXyo=;
        b=UGZYorIoQih3jSiLsLF+ZWxy6dZ8gZz6Xq8dURlQqDTKAXG0i2bvjry6OQiEvrHnYa
         BtLlXcGCVUABtzdcbsc5oOwukDrkLbFiOsiVtr9GbtptUhjVznyc+wMIvKriMXRynk48
         EhWYu6c6s3TQTBqIWvepva3eAWs11xlFcsQ0Lq2kC5jJZzxFKTTdhhzu2pczUzD1tdbT
         zWsRauPulFg/8MvfzsFp5DKvq7I/YyOnW/5HzeVI2JXWjHB23IF2g/ZYzQ8KhKkR3f1G
         Wy+PruxMmAot0Cu/Y/6dwTDlzuz9S2MkjJXXjBhA+L1xeb05vdwiaRyiLD8q0M/8UwDC
         7glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhNIsCcME0XsXTl7aAaDIyDGnjAyi5m/IC5vqSFjXyo=;
        b=CgOQaEQxrq/jHk2lr+bDtij26dXsbcIQBYflc/3AL6u3UznSoXDCp6n2fUJ3x3JQ0k
         W0p9ZmWy2ETbrbv6webkfvzGWDxw8eH8SZbMKTxaz//vjW2/KyFiLo1CgM2SIlgIp1Jg
         n2R8BCCj/MpNI0LuwEqLalWOixsZOOHjWfY/W9HQUJcOYz2braMox80Hrk6iA4eSE9Eu
         PJoFMdt3s7cU/QjFNMLg7y+lYb0VVDpXeI2pf9KPgzpNZ6M4vnXmXFob7RTKNO9Gss0m
         G8ZF0GdzBgxzVzegt/jU4PQeZL8MkmHm+TtUguyKVIvTEQBOWTonuG6JQkeNUyIHiea5
         9RFg==
X-Gm-Message-State: AJaThX6Q2d+gsThvGgrckEg4+GzKU6Mv8EQ4GbaiCHIT2A+ByYavVKES
        fL7xocSYfWYsol+oUsNf56amGe7PUXM=
X-Google-Smtp-Source: AGs4zMYjEmsOp1jmPoP09r01PUcbn5a4ZXT9Wnd5XG6Gzjnd9HGhfaLAFGahTu+xcR8smEd8l+jdpA==
X-Received: by 10.36.221.216 with SMTP id t207mr9988348itf.112.1510705856006;
        Tue, 14 Nov 2017 16:30:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id o76sm3683723ioo.8.2017.11.14.16.30.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/7] builtin/describe.c: rename `oid` to avoid variable shadowing
Date:   Tue, 14 Nov 2017 16:30:40 -0800
Message-Id: <20171115003043.24080-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `describe` has already a variable named `oid` declared at
the beginning of the function for an object id.  Do not shadow that
variable with a pointer to an object id.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..fd61f463cf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -381,9 +381,9 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!match_cnt) {
-		struct object_id *oid = &cmit->object.oid;
+		struct object_id *cmit_oid = &cmit->object.oid;
 		if (always) {
-			printf("%s", find_unique_abbrev(oid->hash, abbrev));
+			printf("%s", find_unique_abbrev(cmit_oid->hash, abbrev));
 			if (suffix)
 				printf("%s", suffix);
 			printf("\n");
@@ -392,11 +392,11 @@ static void describe(const char *arg, int last_one)
 		if (unannotated_cnt)
 			die(_("No annotated tags can describe '%s'.\n"
 			    "However, there were unannotated tags: try --tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 		else
 			die(_("No tags can describe '%s'.\n"
 			    "Try --always, or create some tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 	}
 
 	QSORT(all_matches, match_cnt, compare_pt);
-- 
2.15.0.128.gcadd42da22

