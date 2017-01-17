Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F0020756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdAQXi6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:38:58 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33700 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdAQXhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:34 -0500
Received: by mail-qk0-f193.google.com with SMTP id 11so17310282qkl.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTGc8CSlDU771BsXG3fYpYqAPdAPYtKAxBT5PAlVgcM=;
        b=Tch86ieVU7m1iPmSTCYWCTlRV9C/n3JPc5/Qa+tqgPNPaN+cMGnmr9+KVJYtjciPlG
         fAG/AUWe5S/DKb8a6m0eZGXlOwkD8YdF3qVMEeP2qkh4z0ib7CjSLb3aaDShWRHrvBim
         5FJSNU+ytlk/A3PSrLGghc7zNtiDVuuUyL7WRUea3QAtLJP0C5cVOtHsdL7VylniBdk3
         2sf/OpoulreHNds/XZSPU25sxZUUu0NvFdOXXKNe9hhAuTFVfZig0llMXnk6eqBjuNL0
         Rw4ynCcJAZilShas2Ltn9AgR2AcUDIFIp18RzuQPgYTCLD61mfc3JDYjWNz6xcYlQo6j
         MKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTGc8CSlDU771BsXG3fYpYqAPdAPYtKAxBT5PAlVgcM=;
        b=SRaDV107xdKwT0gR7/R7Yd03M4WvfLVg3tTg/1DRYOu6i2S7+qxnBoO6ZKtHxyb324
         BOxdSgF0cwelo7/j81CIRoCuqFVkLpJOL4bODxXIaMq+P2J1BFMTRDsM+cAeUqi5BQ0u
         ymLEqU+dlTtl+lRoDQBoH/igflzxxO5uuEWJ0rKOq7NKCESDPqvuESBIHz8joTryuwom
         Hcq1y6Hfs1DwuyfcghCWRqH6eRaC4XN0buzvzLmGA+aqmoB+Uka37H49CmLNl1Wl4mGk
         yg37XDavu10F0JSGp+DQdPflPXmMy3ZzptbeQmait1uIXFU80dISfg/EYDa8i490doYF
         ZNCA==
X-Gm-Message-State: AIkVDXJhoEoXgrjNeF9x7CZ9CW8WtmDsr8g5jcR/PgUwJr2C8YN2I5uji6td6dqRsp++mRnu
X-Received: by 10.55.26.159 with SMTP id l31mr250804qkh.164.1484696254082;
        Tue, 17 Jan 2017 15:37:34 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:33 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v6 6/6] t/t7004-tag: Add --format specifier tests
Date:   Tue, 17 Jan 2017 18:37:23 -0500
Message-Id: <20170117233723.23897-7-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu>
References: <20170117233723.23897-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

tag -v now supports --format specifiers to inspect the contents of a tag
upon verification. Add two tests to ensure this behavior is respected in
future changes.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7004-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 07869b0c0..ba88b556b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -874,6 +874,22 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 	test_must_fail git tag -v forged-tag
 '
 
+test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
+	cat >expect <<-\EOF
+	tagname : signed-tag
+	EOF &&
+	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
+	cat >expect <<-\EOF
+	tagname : forged-tag
+	EOF &&
+	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
+	test_cmp expect actual
+'
+
 # blank and empty messages for signed tags:
 
 get_tag_header empty-signed-tag $commit commit $time >expect
-- 
2.11.0

