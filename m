Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5279720D09
	for <e@80x24.org>; Sun, 16 Apr 2017 19:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756655AbdDPTEE (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 15:04:04 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:58576
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756597AbdDPTED (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 15:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1492369441;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Y2osTDmSdNhuQxgtltQOjCJQOm8RLccToazQ034rOFM=;
        b=FMyyUlDMlGhGPJNE1eFpQi2Cbifqt9GHNLYYAQzjN8QIQsH8ptfLXrTDzUIw+3e/
        jYwUXUhZCHOprJhvI5RUe4goy4zazogKvJSUAZZTIhXMU6Ufw3CimgzxB5LaSLHYKpu
        Bzx999Ii9IB7+UiH9YWCYkbQs7ecxkvVCRXY+MTI=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015b7826824a-7bacaa78-5158-4d33-9615-e1a5bffea7a2-000000@eu-west-1.amazonses.com>
Subject: [PATCH] sha1_file: remove an used fd variable
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 16 Apr 2017 19:04:01 +0000
X-SES-Outgoing: 2017.04.16-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 sha1_file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7106389..9ecf71f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3970,7 +3970,6 @@ int read_loose_object(const char *path,
 		      void **contents)
 {
 	int ret = -1;
-	int fd = -1;
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
@@ -4020,7 +4019,5 @@ int read_loose_object(const char *path,
 out:
 	if (map)
 		munmap(map, mapsize);
-	if (fd >= 0)
-		close(fd);
 	return ret;
 }

--
https://github.com/git/git/pull/344
