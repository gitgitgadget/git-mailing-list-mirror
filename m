Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69C120323
	for <e@80x24.org>; Wed, 22 Mar 2017 20:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdCVUIS (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:08:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58927 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbdCVUIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:08:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 375A17EFC8;
        Wed, 22 Mar 2017 16:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=88hf
        m4Sq8cVMtOBL9i3TyF1Fe+w=; b=enecax0NjIImwUi0xufAeCuOMnzBR5g6vsg3
        e36ZoX5jjlA75FQpVOktXhAXY8z/IBg08NAfMMKHbbgLwSJQnPDZ2rRcGN7EMZBU
        sqX4nbtnK1y/QbKuc3vMipYGqJVkcxAtzytcBBdPveO6kKxbOyfIS6hBnaEr3rcR
        7uuChXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        Nk+2PU/DmZux+tclTv0DSQZSSRBEOab5EUaWSxXJifxCXPUJ0PuySPsPm+5sXEO3
        sBV0sWJrGZowzhouPwu01QiLTycpNkXZHlIfvs31yCMgPQL9DTykvtEAZxOgAr7Q
        i3scmQv6Drr3RlhT/R7GmmLWbM68gc6pmX9BWKlJsPs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E6A17EFC7;
        Wed, 22 Mar 2017 16:08:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F5EF7EFC5;
        Wed, 22 Mar 2017 16:08:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jan Palus <jan.palus@gmail.com>
Subject: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Date:   Wed, 22 Mar 2017 13:08:05 -0700
Message-Id: <20170322200805.23837-4-gitster@pobox.com>
X-Mailer: git-send-email 2.12.1-430-gafd6726309
In-Reply-To: <20170322200805.23837-1-gitster@pobox.com>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
X-Pobox-Relay-ID: 46481E48-0F3B-11E7-A2CF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jan Palus <jan.palus@gmail.com>

These all came as part of an earlier st/verify-tag topic that was
merged to 2.12.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This should be applied on top of 4fea72f4 ("t/t7004-tag: Add
   --format specifier tests", 2017-01-17)

 t/t7004-tag.sh        | 8 ++++----
 t/t7030-verify-tag.sh | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..efc6dde7b8 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -896,17 +896,17 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 '
 
 test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : signed-tag
-	EOF &&
+	EOF
 	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : forged-tag
-	EOF &&
+	EOF
 	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index d62ccbb98e..ce37fd9864 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -126,17 +126,17 @@ test_expect_success GPG 'verify multiple tags' '
 '
 
 test_expect_success 'verifying tag with --format' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : fourth-signed
-	EOF &&
+	EOF
 	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : 7th forged-signed
-	EOF &&
+	EOF
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_cmp expect actual-forged
 '
-- 
2.12.1-430-gafd6726309

