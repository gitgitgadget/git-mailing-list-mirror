Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AE02018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbcF1SUU (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33682 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcF1STx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id r201so7964879wme.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+K5rWVVr90H2f46BY76hwmTrirhZaH6sgqUPFvUcje4=;
        b=oD7QbJ9yM0mQMSMjBnQ3i83gYu77kkoAp3pZUIhex/9Xub/os37OxGdFTHqna89WLn
         dX+iAOpbVpTWq/z3g8tIjHdmTGkVvid9w/J3P08/7HYv/vBAV4PSvSYF43afIWzaKfZb
         +VbNLebZwT1ZS/kPbUZQKTmZ5FjcMKoJQXgCp2EztDtK6DUxycfwOrFRr0NYmKKWQIMN
         F+n1SQKGpXpfi093zA3BUW1gHkFTjtOFkGJ+2vra8sl2hTGxW+oarhNoIoUQbg2ZOJup
         kfpuU7+TeYfkjkD1Al5ZtzW8+z7mnUep3sXu9MvS3uTozZdGufQMiAZ0uLCy8DbXGM8D
         +lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+K5rWVVr90H2f46BY76hwmTrirhZaH6sgqUPFvUcje4=;
        b=Fs7b8ZaAMJT1nrP+FoISacPiyz3ViXJJrdCzDBWLi9e3mrDq1JqaZhZ/M7ernyK7Wf
         zsnvBzZOfLwj1YftyK2EPyk5GGc7zKKeGdcJhD/XUv16tDbaRD4UqkQ8pe4mIPCsSX4B
         RVWnfOnqQqN7n7OWRw1tncAt5+9XmoFjts3a2vAykLQ9lPUNr0Gwgzw6wYwkflYf+STR
         ZBSitrCiTAZ/7iWNGpCHN8RxXA1hV9hKcibQ5hFxMyaSB5uDkflixAUcs/oFHSmzMFyJ
         +Lp/3U3r91yjEc3/rLxuecHev3aSgyKaKFU7M16toLVYhz+uxO40JtNaX/xuYF97S2uj
         astA==
X-Gm-Message-State: ALyK8tL7pnIqqZtgI/djpuWfvQS4ynG5Jho5ZY6UI83lpuUaa4gtumIolFgkIaF4Mal0Jg==
X-Received: by 10.28.31.204 with SMTP id f195mr4610177wmf.45.1467137992265;
        Tue, 28 Jun 2016 11:19:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:51 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 04/10] t0400: add 'put' command to odb-helper script
Date:	Tue, 28 Jun 2016 20:19:27 +0200
Message-Id: <20160628181933.24620-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index fe85413..0f1bb97 100755
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
2.9.0.rc2.11.g990c140

