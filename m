Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750A820987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbcI2VAY (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52896 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934141AbcI2VAW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3425D42991;
        Thu, 29 Sep 2016 17:00:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Xapz
        p2INXgCew+XOePxJeXYwWn4=; b=NpfurVY2gmRcvRc0FClZu+zRe3dzzZgLG2YB
        eeCfZNCanNwcp+7TM5XKi+UkUbEJP5CpBsZ15HbDxeq1aQZs3IHwAdWUgve1e/XH
        alqpOuZyMRLKvvtEDj+Vwk5c4Ldt94N3q0/UX2GQYHHy7dheSKAV9QrT7saxcHi7
        LcdQmC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=bPkTp3
        92EqxH82+zSBs9n07T0c0jLCQhOyWLOMgQeBAPqN5r7YQ0XdcKnKF7rbj7iTA8mn
        FlKZn3Kpg8t3+inhwpgSKMt1LDyrIGOnlcNp8ws6/FqnWPEAcwKUEfVaarzbvf0R
        SKQt4bkafy6ZrXwHd1HXh07T1J/RED3P8SKeo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9BA42990;
        Thu, 29 Sep 2016 17:00:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7A294298E;
        Thu, 29 Sep 2016 17:00:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/9] t1300: always compare expect to actual
Date:   Thu, 29 Sep 2016 14:00:07 -0700
Message-Id: <20160929210014.3874-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: BB91E19E-8687-11E6-9587-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two arguments to the test_cmp helper should always have the
expected output first and then the actual one, so that an unmet
expectation would appear as

    -what we wanted to see
    +what we actually saw

in its output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0543b62227bf..1b3f6f4854f9 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -936,7 +936,7 @@ EOF
 
 test_expect_success 'value continued on next line' '
 	git config --list > result &&
-	test_cmp result expect
+	test_cmp expect result
 '
 
 cat > .git/config <<\EOF
-- 
2.10.0-589-g5adf4e1

