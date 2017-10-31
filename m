Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B937B20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbdJaVTC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:19:02 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:48780 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJaVS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:18:59 -0400
Received: by mail-io0-f195.google.com with SMTP id d66so1019481ioe.5
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXfai27gqdsOb8fmIHYe14NtRESzdyYG05wAxN9Ykdk=;
        b=Ddns5SDBPIAI5/dIKVZ4BRGnO/VooN0MKDaDOVjJoxbYaM+pVqSJxMxrKpyYT39ksI
         5bNlnlw9ajFov6pO5vd7/r38iTLfl4ROWpZZt1WXSDhM934bzkRnmnyHFr4oS2gGUsDk
         BagrKbQBWLfyCb23SH95CKpzlTL5HNwozZefjiA1qVYbdqJuysx49DYLapfQT3WUWQsm
         gwY7XWU13vHaPwO93Gyzb2lAzKZOm0T1QREPs0W6WUZRIvkECOgVrXPyTj94+Kv2kg3m
         s92AO8gXamu0P29OnmH0RoOorz9URIcdvVq2bPC5gEBPym8I9tspUtffwS8K0FnwDxKl
         QqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXfai27gqdsOb8fmIHYe14NtRESzdyYG05wAxN9Ykdk=;
        b=Rmb05awqeAXhCnCuVp9S1EpqEhZ52Hls2mjxc1S/aYkt/DnrMjHkXOSjR5cOhysa9A
         UpiiTx1ODUTY5tHuUP1x6orDiwZGta3k2clRbwXit0vmN9EUfxaQ5Mfma+7EpWrBmJu1
         kwQl38e4j+l6LYsUyu1oCtbs3YKsrMAHRxPu+kZ1hQxlOfVwZOQlKf4mQhIkDe3Q/pj/
         V5OoHYQ7oKh7syxsR5C4hh6G4fhrtcGMrO3Y67Oo8MW5+g3EjkIQ4m0x5JwVa/cMul3U
         eEXrgRxBz4eKvkfv9MYvsSbHlTkcatzc/gQjnKBIRhiP1vX+CzhxuiRwkLkenAX+jy9d
         gXeA==
X-Gm-Message-State: AMCzsaXVzttZV4seNtWeS01n6SESKI/xthzES1NbHkh+fX4yB/W1+nS8
        4x+4ui0xHBdSZ7lddGagHb5wdU31yyg=
X-Google-Smtp-Source: ABhQp+QJ7g7FcfD/XLBmnFy+YuidmqpZUQisa5rC+x8ERtcb9I09EoqN5oA+jafOMF0owiDUzmG53A==
X-Received: by 10.107.10.157 with SMTP id 29mr4328505iok.285.1509484738975;
        Tue, 31 Oct 2017 14:18:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:55a5:57f1:5248:2d32])
        by smtp.gmail.com with ESMTPSA id a17sm1086334ioe.55.2017.10.31.14.18.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 14:18:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: [PATCHv2 3/7] builtin/describe.c: rename `oid` to avoid variable shadowing
Date:   Tue, 31 Oct 2017 14:18:48 -0700
Message-Id: <20171031211852.13001-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031211852.13001-1-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com>
 <20171031211852.13001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `describe` has already a variable named `oid` declared at
the beginning of the function for an object id.  Do not shadow that
variable with a pointer to an object id.

Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.15.0.rc2.443.gfcc3b81c0a

