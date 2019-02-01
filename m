Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6A31F453
	for <e@80x24.org>; Fri,  1 Feb 2019 08:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfBAIgQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 03:36:16 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:54982
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728739AbfBAIgP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Feb 2019 03:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1549010174;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=7zBzO0YYcMw/8QABvawukZqBk5oF4voGTFRp3fLTBX0=;
        b=j+DeCGX2j8fiXKxkL7b94WndKq7mO1e2Lxy8yadT3oYj+bDbnNwgsh7szQN2kGeQ
        w+mu1Bsp0cUy8dPRnvokRwruRxBc5+oNvEBZMaUGzuDkS4dkK+fRe2s9y2q4uSsgpc6
        4sblKj6DaLfmkI70jMvw6BSKgU4D6YprJSt2HxiE=
From:   Shahzad Lone <shahzadlone@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020168a8338127-d50bd8d1-c178-4f13-86b1-9a191f64ded0-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
References: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
Subject: [PATCH 3/3] It's C not C++ so variable length array should not be
 used [-Werror=vla] :,).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 1 Feb 2019 08:36:14 +0000
X-SES-Outgoing: 2019.02.01-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/pack-objects.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c1ec9ef3232cb..3017beb8236fa 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -197,9 +197,8 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct hashfi
 					   const struct object_id *oid)
 {
 	git_zstream stream;
-	const unsigned bufsize = 16384;
-	unsigned char ibuf[bufsize];
-	unsigned char obuf[bufsize];
+	unsigned char ibuf[16384];
+	unsigned char obuf[16384];
 	unsigned long olen = 0;
 
 	git_deflate_init(&stream, pack_compression_level);

--
https://github.com/git/git/pull/572
