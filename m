Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A88C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377718AbiEMHNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377721AbiEMHMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 03:12:48 -0400
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C042701B7
        for <git@vger.kernel.org>; Fri, 13 May 2022 00:12:45 -0700 (PDT)
Received: by psionic.psi5.com (Postfix, from userid 1002)
        id 873DF40CAA; Fri, 13 May 2022 09:04:42 +0200 (CEST)
From:   Simon.Richter@hogyros.de
To:     git@vger.kernel.org
Cc:     Simon Richter <Simon.Richter@hogyros.de>
Subject: [RFC PATCH 3/3] Allow empty user name in HTTP authentication
Date:   Fri, 13 May 2022 09:04:16 +0200
Message-Id: <20220513070416.37235-4-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513070416.37235-1-Simon.Richter@hogyros.de>
References: <20220513070416.37235-1-Simon.Richter@hogyros.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Richter <Simon.Richter@hogyros.de>

When using a Personal Access Token in Microsoft DevOps server, the username
can be empty, so users might expect that pressing return on an username
prompt will work.
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index c5af90b1b8..dc71fb75ea 100644
--- a/http.c
+++ b/http.c
@@ -433,7 +433,7 @@ static int curl_empty_auth_enabled(void)
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (!http_auth.username || !*http_auth.username) {
+	if (!http_auth.username) {
 		if (curl_empty_auth_enabled())
 			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
 		return;
-- 
2.30.2

