Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCCDC2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA42465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWjdZpBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLSSCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44028 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSSCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so5755463edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ggXPAINEbsESlQr63nlQkATEy72egbv3fwl9Q0nJ268=;
        b=GWjdZpBZ3YZ0V7YPvMUu7BAEbMnJBDrYT56GkU68NlS4HofCh/B5jgmtmGS4DchIFL
         w1usOvR375S5s7kTHE8TNv2U/dzafYKbHQ0NgBRxv2fNfXMj3EBxqMbuQj26f/wIF4tx
         8AfApcH7PvyZA9iXbsciWtKHfzwbIrRPamadlkX+7bUz3rEzp14A+zlR+CqxEKt+3hcI
         xnx/6b1jBJmTrE8Cyt/WFPzQUBdAEYjpif4Kgudsj3YTiKQ3WlzLaaceSiABa7Xmy4n1
         oNfPN1xWp4F5rEZsYOXpdszmlYrHCUawQ9MyQqvqMhulsYu7/7o6Cv698PP+72/GF+d2
         aiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ggXPAINEbsESlQr63nlQkATEy72egbv3fwl9Q0nJ268=;
        b=BcJMPGE+BGf5TiHQMMVfnF/orz3OM+rofFRo5xuaSBeH6UdPK8ZdADdnHMjXiRVaJ1
         plCOJmBek/hhrKqI56oBKI3tofc4Vk5e/3oIdXWWfjGeGQI9niJDgdteYaVqFT6lZS2F
         GbImK+e6rCBGV2Gic32oghzxkHp6K1vsLCIzPrEmMENOBML3jgCC1DeWqpSXIoDp5qDU
         5qWM6ijvX7nLdpiS/k8pTuo4ncI3tUCEtiC7IHBmtDC/5yJXMLaZqTNo3ZGUuditZuZ/
         AwU47OXYH3wy8i3bkYSx5B7JFUrV8KmsGbKj8snyeqvnoGwhClYnc9JF5iqMxpnn8fhX
         AKvA==
X-Gm-Message-State: APjAAAX7WP5WtgyCP/xMZp+V9cmdyXV+rBM0FC75Ox0ewnsrbOo3qeLj
        aEOhO96jtkf4lbpuIR9v/PzOojXd
X-Google-Smtp-Source: APXvYqzh51eS0N+pJDDJ4BD9u7XHQx/lY+0mVzpZzlneJrpv0jp5UMsBxFA2t2p05gp9w4/wjgBBkQ==
X-Received: by 2002:aa7:d3c3:: with SMTP id o3mr10691707edr.167.1576778520153;
        Thu, 19 Dec 2019 10:02:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay8sm651839ejb.6.2019.12.19.10.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:01:59 -0800 (PST)
Message-Id: <b1cc4a960d052f43f259f2149518c77712ccd0fb.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:40 +0000
Subject: [PATCH v3 03/18] t7107: add tests for error conditions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Suggested-By: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t7107-reset-pathspec-file.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index f36fce27b9..e91b0ff62d 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -74,4 +74,18 @@ test_expect_success '--pathspec-from-file is not compatible with --soft or --har
 	test_must_fail git reset --hard --pathspec-from-file=list
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+
+	test_must_fail git reset --pathspec-from-file=- --patch <list 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+
+	test_must_fail git reset --pathspec-from-file=- -- fileA.t <list 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git reset --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+'
+
 test_done
-- 
gitgitgadget

