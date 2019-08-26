Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461841F461
	for <e@80x24.org>; Mon, 26 Aug 2019 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfHZHtQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 03:49:16 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:46734 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbfHZHtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 03:49:16 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1i29kV-0006CV-26; Mon, 26 Aug 2019 16:49:11 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] http: don't leak urlmatch_config.vars
Date:   Mon, 26 Aug 2019 16:49:11 +0900
Message-Id: <20190826074911.23792-1-mh@glandium.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 27aa0a3192..9e33584f2d 100644
--- a/http.c
+++ b/http.c
@@ -1073,6 +1073,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	git_config(urlmatch_config_entry, &config);
 	free(normalized_url);
+	string_list_clear(&config.vars, 1);
 
 #if LIBCURL_VERSION_NUM >= 0x073800
 	if (http_ssl_backend) {
-- 
2.23.0

