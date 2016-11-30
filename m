Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BE81FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbcK3XY6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:24:58 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35470 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcK3XY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:24:57 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so10074807wjc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 15:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lu38NIdIzVF0jOdd651uiY9gxEkJHpjPvOdmdX7gYdQ=;
        b=DdBvH7KgT6YaoV+O1mWMPKiFcIeE7H9gqZD512MbMOSnPSPONqY7AA4gOu4VxnhNXa
         TZ/eSqUONOPEqXWS27nm+m/0RmFhsxIatRI8cGJrSDG8sPtI1ckt2G55km3OgHLUkDbw
         VwYVjYiZJ9bCgeD1zD++lodt2wId2Xxnpcng7yJsv+o1exn9SnK0u5uI7x6UeLr/rXPZ
         7xOSCk436r+B5+4VoPEavbMMLewCJisCKqXwYoiD30GpM5QnGh/UgamSq/ux2P6GfCrL
         b5NPC+AkQlv1NrNUWq8ku2EJAwFMfWsAiNizy1JZGlpbRb288dyEredrDwUSAEDCJ+cB
         Oz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lu38NIdIzVF0jOdd651uiY9gxEkJHpjPvOdmdX7gYdQ=;
        b=j3SnbUl1Wb6rKNKskl6RpyuHrdBhR+BZnd9Cbc6kUogwlZRIagqDXeXJqHVAdgqFTw
         YYCN4zbWrX8GWTT1WIR7NVBCmvmBPUcrz4BfmmAxLyjHcCTJ9AkgbuZLvmX3uiTTyZv+
         7TIuaUrLhGR6B5B0VgwEGVOg8wCqD4GPeN4dq14FTaDfgYWfgU0NCZ7NDZ2TnfOnN6sF
         407J302567OUFMhnfQhzFMbsHHm0b2j1tD2NrAuZgp2wMHtPDGlckHlMXZFyfKbneRl5
         eeD11d3Ljhv6quJaJ403YeG7zplx8v0N/KZkAVsPU6qT0efAraUQmcV88BVZKj88E9ij
         akUQ==
X-Gm-Message-State: AKaTC00SQLXJD6w4h39b19x3AU+Su8iG3Ytad+2rm4zlVjEi/iClfp1VAkDw3hhWP2hnig==
X-Received: by 10.194.173.73 with SMTP id bi9mr30002389wjc.120.1480539892384;
        Wed, 30 Nov 2016 13:04:52 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:51 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 04/16] t0400: add 'put' command to odb-helper script
Date:   Wed, 30 Nov 2016 22:04:08 +0100
Message-Id: <20161130210420.15982-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index fe85413725..0f1bb97f38 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -7,6 +7,10 @@ test_description='basic tests for external object databases'
 ALT_SOURCE="$PWD/alt-repo/.git"
 export ALT_SOURCE
 write_script odb-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
 have)
@@ -16,6 +20,16 @@ have)
 get)
 	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
 	;;
+put)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	writen=$(git hash-object -w -t "$kind" --stdin)
+	test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
 esac
 EOF
 HELPER="\"$PWD\"/odb-helper"
-- 
2.11.0.rc2.37.geb49ca6

