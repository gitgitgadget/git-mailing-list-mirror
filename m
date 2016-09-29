Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4CB207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934206AbcI2VA1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59357 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934173AbcI2VAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6E4429E5;
        Thu, 29 Sep 2016 17:00:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=ZV7O
        QoZkaahzPgc8XltsmjjasX0=; b=YYMxQxv4W7rMWplSMJzKU3J0RutffCYF2sX/
        5MBGkcxiysiMwWRUnuSKrHDVt7SXF8WM0iWNxZLht893IW/7cp85hIu8syhPqkif
        Em73kx4Qlb8CGNy17sKqaxdTuT2eGBKqIW7eCRDIll7sHQivlrEKfw4xJxHdu9m+
        SSLYK1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=lSTGHF
        UJF+3wnJyVvf/vNn1eJ0aGTYOMKTzUuAXtekQj7u4BIrrlzVSoQwUQstvGj3NSdm
        HFD7mpELES7dntNToRti7mFTyoD7dEw5dUqULa0xh0oqIIMvIxuicL/jUTGNbT3U
        TpXotB4qhkUaR3qzOJCnJFU9x1ckSC8C4i+Nc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 936E1429E4;
        Thu, 29 Sep 2016 17:00:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C590429E3;
        Thu, 29 Sep 2016 17:00:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/9] t1308: ignore system-wide config in the iteration test
Date:   Thu, 29 Sep 2016 14:00:08 -0700
Message-Id: <20160929210014.3874-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: BD04CD52-8687-11E6-A903-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not want to keep track of the exact contents of the fake
system-wide t/gitconfig-for-test configuration file.  Keep ignoring
it as we used to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1308-config-set.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7655c94c2801..5d5adb1efd8e 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -260,6 +260,7 @@ test_expect_success 'iteration shows correct origins' '
 	name=
 	scope=cmdline
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-config iterate >actual &&
 	test_cmp expect actual
 '
-- 
2.10.0-589-g5adf4e1

