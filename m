Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EA920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbdLERDq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:46 -0500
Received: from siwi.pair.com ([209.68.5.199]:15287 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbdLERDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:15 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0293C844E5;
        Tue,  5 Dec 2017 12:03:15 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7D757844DE;
        Tue,  5 Dec 2017 12:03:14 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 08/14] fixup: fetch: update --blob-max-bytes to --fitler
Date:   Tue,  5 Dec 2017 17:02:48 +0000
Message-Id: <20171205170254.65293-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5500-fetch-pack.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 65fc7bb..ec9ba9b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -782,7 +782,7 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
 	test_i18ngrep "filtering not recognized by server" err
 '
 
-fetch_blob_max_bytes () {
+fetch_filter_blob_limit_zero () {
 	SERVER="$1"
 	URL="$2"
 
@@ -804,15 +804,15 @@ fetch_blob_max_bytes () {
 	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
 }
 
-test_expect_success 'fetch with --blob-max-bytes' '
-	fetch_blob_max_bytes server server
+test_expect_success 'fetch with --filter=blob:limit=0' '
+	fetch_filter_blob_limit_zero server server
 '
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-test_expect_success 'fetch with --blob-max-bytes and HTTP' '
-	fetch_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+test_expect_success 'fetch with --filter=blob:limit=0 and HTTP' '
+	fetch_filter_blob_limit_zero "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
 stop_httpd
-- 
2.9.3

