Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753D81FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbcK3VRd (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:17:33 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36411 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcK3VRc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:17:32 -0500
Received: by mail-wj0-f196.google.com with SMTP id jb2so23998360wjb.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kIYht6QXd2HHF1iL0bvW8bOruAt0iILBA0LYg1xKwSA=;
        b=KWAWBpjGb6VQjqTFpzsLk4NRC7gRX9vnQv/r0J4O78bE9bPqx5/4GN207Waq6EXwno
         j/u4uECJU0jzMUyqQXOm2LJBbc76QvNYeYVkiApW+DZjNjHt/9D036aDCAESQIJ5qCOE
         4XRlqK1nlqo4SbzR8GGgP3n8TXebYr2ccbDKjFx3dtNdEKIIoKIX8yN/l7+a2zuPyj74
         9WKlApaHaN1VLc7hR7BUyp+n+wo21wubFMblFSZ1B6ehdqqzpGxdZKToCtk5xYpqpCx+
         vFkVuhuJj9slJeA2IP2FutMYB3fZjaRmqWcsoooF7KVdoWgFTQHpfjyjqOifAC6XwpZk
         0qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kIYht6QXd2HHF1iL0bvW8bOruAt0iILBA0LYg1xKwSA=;
        b=KqeGMHtQ8iVUbLpyzn5R+Kin+S7fFaZrDMRYU3Jl9xOKIQHF+9WVt8mE7svPS01QEl
         wNCU8PwqWQ2IHv8nlXNs6znxFuLRIKU1cqPfJPrE66nWoy4xLilhxBG3ra9XO57PvUf+
         +VPLGRcLepOfEUzCpbAdqzzbny0EDcls5mYD+9sS1fbUif7z2fRs5az4yMXkUS+IMW59
         RIAxgLk/GcjtC41fn/G6+5JbfXX+3iH1vY0L9WyiMr9ZEqPpCOccS90qjztyQ69dDd0x
         qb/OUUROHWbQQNbYHFeRKWr8NUmiZuWXE7izxEL43V98hWOF/0Y/HIzE5QJSnH++9nYd
         oTfQ==
X-Gm-Message-State: AKaTC02+oH04Com1MDW70NEpbXmPbFnpOEVrA1anKC5p6yMJvHZVw7IpE92CNOcppLWTiQ==
X-Received: by 10.194.200.69 with SMTP id jq5mr30088880wjc.93.1480539894272;
        Wed, 30 Nov 2016 13:04:54 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:53 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 05/16] t0400: add test for 'put' command
Date:   Wed, 30 Nov 2016 22:04:09 +0100
Message-Id: <20161130210420.15982-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 0f1bb97f38..6c6da5cf4f 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -57,4 +57,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put "$hash" "$size" blob &&
+	alt_size=$(cd alt-repo && git cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.11.0.rc2.37.geb49ca6

