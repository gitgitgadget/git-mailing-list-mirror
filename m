Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C0A20196
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbcGMPok (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:40 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33455 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbcGMPoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:38 -0400
Received: by mail-lf0-f44.google.com with SMTP id b199so42580102lfe.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqKWeuXWq4zaCllPMKFrDaHxCgR44vvG2pG0VIq9yHc=;
        b=Aji0fVH3Qy5fpINlxM7dRiaRZFpvpof774FBfU0sLPKS94DoVsvSdxvBKCBFscxYLU
         bZA9pqHKlMQCasVr1M96Y7EOWZDG2MtHmyG1+sv539cH3PaW82gWqdzy5MqAIwH3GaTC
         +0QiO8mNxoWNjivFRKGNYSXed2b0ehRbD3j1br3h4vMINMLG3cSCtSERqnn0B1gBNOIv
         HjfRV+tX9RHRIR2xpjvsPq0a6Zwd/TxSDWYP01Kk0uT6LWp2leYryEVx4pczUFTFTUJm
         udtJp4Moikos1hq8cRbhhgnSI2EI1RVvvJoHjmm0ZKL7DbINj6XDs7Fy7Sd3UUsi0Mmy
         GysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqKWeuXWq4zaCllPMKFrDaHxCgR44vvG2pG0VIq9yHc=;
        b=UL/DmtLg2ENHC5u5kR/ftpy31O5ffj8DTvnKpE9sCub80EDm6rBKmNsV+skMXw5C1z
         vPrTY8ImiGMTQvlxa41Ot34utL4j5nBigM17ux+cyJSDG7gb69sttGzSANoOrphng6pD
         V8ZjArDDVSG7mzTsgcak9ZioYRPxzC89i3pGhQS1M2cl55xxy2kEJr9bkAhu6Pc+39Zx
         k24lPFA7DPhz6SRLUdpdacdMoOEryg+DLUFX1Eqdo6NAmZLhBMHF3LydPRTj1qZLO5oe
         gwWCLmqXNng1K4rSZmZBxeA4RDHG64n95n1tiapWaHnt053ZeM7vPHXaEu/pCmSDzYBY
         rGWQ==
X-Gm-Message-State: ALyK8tLoPO5sR43fmU+gqrOOTiX/LmfzNDCrLdJGd0koxDG/zAFYm7Z15aRjV15cbe3SUA==
X-Received: by 10.46.71.70 with SMTP id u67mr4753928lja.19.1468424651637;
        Wed, 13 Jul 2016 08:44:11 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:10 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/7] Number truncation with 4+ GB files on 32-bit systems
Date:	Wed, 13 Jul 2016 17:43:57 +0200
Message-Id: <20160713154404.22909-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A diff from nd/pack-ofs-4gb-limit can explain the changes better than
me.

I did not add PRIdMAX or similar because that carries a risk to exotic
platforms that people rarely test. Just casting to unsigned should be
fine.

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 55eac75..b08bc8b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -356,6 +356,10 @@ static int fsck_sha1(const unsigned char *sha1)
 static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 			   unsigned long size, void *buffer, int *eaten)
 {
+	/*
+	 * Note, buffer may be NULL if type is OBJ_BLOB. See
+	 * verify_packfile(), data_valid variable for details.
+	 */
 	struct object *obj;
 	obj = parse_object_buffer(sha1, type, size, buffer, eaten);
 	if (!obj) {
diff --git a/pack-check.c b/pack-check.c
index 14e8cb0..d123846 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -106,7 +106,7 @@ static int verify_packfile(struct packed_git *p,
 		enum object_type type;
 		unsigned long size;
 		off_t curpos;
-		int data_valid = 0;
+		int data_valid;
 
 		if (p->index_version > 1) {
 			off_t offset = entries[i].offset;
@@ -130,6 +130,7 @@ static int verify_packfile(struct packed_git *p,
 			 * the data in-core only to discard.
 			 */
 			data = NULL;
+			data_valid = 0;
 		} else {
 			data = unpack_entry(p, entries[i].offset, &type, &size);
 			data_valid = 1;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f9f3d13..096dbff 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -177,10 +177,9 @@ test_expect_success 'zip achiving, deflate' '
 	git archive --format=zip HEAD >/dev/null
 '
 
-test_expect_success 'fsck' '
-	test_must_fail git fsck 2>err &&
-	n=$(grep "error: attempting to allocate .* over limit" err | wc -l) &&
-	test "$n" -gt 1
+test_expect_success 'fsck large blobs' '
+	git fsck 2>err &&
+	test_must_be_empty err
 '
 
 test_done

Nguyễn Thái Ngọc Duy (7):
  pack-objects: pass length to check_pack_crc() without truncation
  sha1_file.c: use type off_t* for object_info->disk_sizep
  index-pack: correct "len" type in unpack_data()
  index-pack: report correct bad object offsets even if they are large
  index-pack: correct "offset" type in unpack_entry_data()
  pack-objects: do not truncate result in-pack object size on 32-bit systems
  fsck: use streaming interface for large blobs in pack

 builtin/cat-file.c     |  4 ++--
 builtin/fsck.c         |  4 ++++
 builtin/index-pack.c   | 23 ++++++++++++-----------
 builtin/pack-objects.c | 17 +++++++++--------
 cache.h                |  2 +-
 pack-check.c           | 23 +++++++++++++++++++++--
 pack.h                 |  1 +
 sha1_file.c            |  2 +-
 t/t1050-large.sh       |  7 +++----
 9 files changed, 54 insertions(+), 29 deletions(-)

-- 
2.9.1.564.gb2f7278

