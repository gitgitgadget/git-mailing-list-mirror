Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB9720248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfBVQFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:47 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:49300
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ZOXZDhdUH5f0Zd8BS/jGO+2h1aE+cbLM7cVOqwIulXI=;
        b=XQjqSxv2ROPf9upEqk0ZvNOYhxMk7X0ftXjnQpx1WDdpLyNg7pQ1PrUE4OHRZrg6
        K+gy5kukoY36l5/WVPVfJDYoPUXPI+5Hi7uovYI/ItcXKuMSztPSfUwZ7N81OlFV82r
        6n92diT7FsA87EeMRSx57Cuo9vUXs6FYrcSOARDQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a4f-cdb13ec8-58ea-47aa-a64a-517db120961e-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 04/20] for-each-ref: tests for new atom %(rest) added
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for new formatting atom %(rest).
We need this atom for cat-file command.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 t/t6300-for-each-ref.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0ffd63071392e..fb361369a037c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -322,6 +322,12 @@ test_expect_success 'exercise strftime with odd fields' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Check format %(rest) gives empty output ' '
+	echo >expected &&
+	git for-each-ref --format="%(rest)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 refs/heads/master
 refs/remotes/origin/master

--
https://github.com/git/git/pull/568
