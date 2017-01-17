Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19D320756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdAQXi5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:38:57 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34691 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdAQXhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:34 -0500
Received: by mail-qk0-f194.google.com with SMTP id e1so17318164qkh.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjImo4A8vb4wgLYtjOLAL6mvFvVkVCha3t9BRUxq1PA=;
        b=EU7D+gO7F0MAvtbFKZgICz1PckuZlPdJs+tgXkMnQTU8lxMfMGPBxQfmev2KLrLpv3
         QVF/5MrYBJFC9zLSo7PRstCLslS2piWKLDOPdCF3Xlc30G5Y0+9trWjLi2pgzgPZX4in
         qX4bWw15ENLv5Zw1byCjanQG/jmEjXkFnavEBuZkVpQbm04lFoi953DPst7omc5qKpJP
         GvXXN8VgitC+juSRcdLBp/XWg+ccrsWNfeC/vexLCe5idbeoDnckAonaJbTBTSlOEIg7
         Qpg8DBOMYien4S4ipxdtgy2B6OFH24r5T7beZF4sZxD0U/aGxeedOLp/BvFdpKRsrVp/
         RxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjImo4A8vb4wgLYtjOLAL6mvFvVkVCha3t9BRUxq1PA=;
        b=ZhNJBbiVpyG6PqU8UlTphzPu4hAlVkRWyCjjauUqCQHZY5oDDWlol31gGx0amNCs7K
         d3tcMkVupPaSMC/r7LzSinRS2cbjZXyl3KlYuPxE3MeAAmAeoDKpy/sCxUTTvKNgz+v8
         qAvNzOh+RxTGCuVbxANxZA+WHfpFFxiqiQqdbcJumRY5cELQr55cFSbgCg81PV1a5tXI
         1j5RBx8jySn1qmw9uicbGGsGC9vNLcfebBvEms+1UUqYhBGYaibAGisYFkfadeVQzUkU
         lbtkNJhC+p9LsUFTUVPR71z2//DimvDDFaI8lATgaTpdyeO3CNNEiCsW11d9iVtx6Ia/
         yT8Q==
X-Gm-Message-State: AIkVDXJF3oKGlaGhlOpfeHHqa2k7TfLqjQErY2P5o/TIsHouRqTItHEa652NQY6huN9f3ani
X-Received: by 10.55.177.65 with SMTP id a62mr219922qkf.215.1484696253417;
        Tue, 17 Jan 2017 15:37:33 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:32 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v6 5/6] t/t7030-verify-tag: Add --format specifier tests
Date:   Tue, 17 Jan 2017 18:37:22 -0500
Message-Id: <20170117233723.23897-6-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu>
References: <20170117233723.23897-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

Verify-tag now provides --format specifiers to inspect and ensure the
contents of the tag are proper. We add two tests to ensure this
functionality works as expected: the return value should indicate if
verification passed, and the format specifiers must be respected.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7030-verify-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 07079a41c..d62ccbb98 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -125,4 +125,20 @@ test_expect_success GPG 'verify multiple tags' '
 	test_cmp expect.stderr actual.stderr
 '
 
+test_expect_success 'verifying tag with --format' '
+	cat >expect <<-\EOF
+	tagname : fourth-signed
+	EOF &&
+	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
+	cat >expect <<-\EOF
+	tagname : 7th forged-signed
+	EOF &&
+	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
+	test_cmp expect actual-forged
+'
+
 test_done
-- 
2.11.0

