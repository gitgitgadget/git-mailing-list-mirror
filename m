Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F89C208D5
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdHCJUD (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37361 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdHCJTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so1420005wmt.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bFS37GnSeTCcJKTxWLTkngiDzWOHLfxOoLn8s+s6cM0=;
        b=T6p0rqojTPPLy9RREkVaXPNPSb3Q/7hjNA70tXeInRlwIhBXoRgIK5VDAsU4KOOjRv
         pw/YEk5Fe2ItOLMSQS9DE/Fq3kgguwDtKo1oN0+gWbPlnna3Ug0+Q6pqtlwCrTlfqCLf
         2sfC3ZyB47A7gEltakQU+STXtF74YJJjVw7Nn6wIYt4eex0gFMQBjsAZGBavqiqZ3Ays
         tAeNDpKm4wzj1/6WczaJ8/CL86WLzDsBmRUUdI7bo/wsUx/WhGicNeWQF+gFt3rXKlsr
         3PiFeH/NxZeVm1o6LJ7Q+P7kT5WMsjJfC4l6guYCmD7RgRJvQQ3sH4f3CC/ALVzn1hGh
         mXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bFS37GnSeTCcJKTxWLTkngiDzWOHLfxOoLn8s+s6cM0=;
        b=GoyRzucmBDXMcDKvBxtiYl6aAXr8ir3E1aE38MAgBmv8SUJZK1w8GENqqZGLXcsciL
         OhO8ZYFoWO9dNYFpqI/9CVaKvQQVX1L2JYGdhV9yafHXjf7kt4wJChM9NvSUi/MjY8UG
         ByQJi++RqQcli5as5Lx5aLPtUeDsN0wYhK4ENDqk2pJzRqojprHd6NPLr0W4y6zlky20
         7tTOIayhq2r+pGYP1tS5jC03XmGQGXwGVU5VyfJBdnYQ3aB8vkbCOX/19GGngQmlBbWr
         TgwCrxR+d9+d1bkpYvs6mgoxIpuUahDqtV8CtaQKn+qT2CZyAJygDVcUh4fzibOh8grL
         ANRg==
X-Gm-Message-State: AIVw113LevWHyWGjIYyfh0dExdkgZ936/M7KC+WWP2/2u/Kqe33TJyvE
        mGUR9QUZYCv/IOSB
X-Received: by 10.28.29.130 with SMTP id d124mr680998wmd.78.1501751992633;
        Thu, 03 Aug 2017 02:19:52 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 12/40] t0400: add 'put_raw_obj' instruction to odb-helper script
Date:   Thu,  3 Aug 2017 11:18:58 +0200
Message-Id: <20170803091926.1755-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To properly test passing objects from Git to an external odb
we need an odb-helper script that supports a 'put'
capability/instruction.

For now we will support only sending raw blobs, so the
supported capability/instruction will be 'put_raw_obj'.

While at it let's add a test to check that our odb-helper
script works well.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index ed89f3ab40..3fa0449883 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -7,10 +7,15 @@ test_description='basic tests for external object databases'
 ALT_SOURCE="$PWD/alt-repo/.git"
 export ALT_SOURCE
 write_script odb-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
 init)
 	echo "capability=get_git_obj"
+	echo "capability=put_raw_obj"
 	echo "capability=have"
 	;;
 have)
@@ -20,6 +25,16 @@ have)
 get_git_obj)
 	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
 	;;
+put_raw_obj)
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
@@ -47,4 +62,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put_raw_obj "$hash" "$size" blob &&
+	alt_size=$(cd alt-repo && git cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

