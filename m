Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6023A20958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964962AbdCWP3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34347 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755993AbdCWP3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so17260821wmg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uro5eTdwOJguojDuekFl2mD7N0R3b5xuQ+/3Koaldlc=;
        b=ZsyuMUI5BEXPUh4mtEHn6iLr67y5VUD1SKEIaD/N/OSCmNk8wun0rNNS6KZIINWQoi
         jC6v/pdV6HtegYrJXUL9Mtqb2+U9yPx4RlW79jiFvIdo3sXhT8Tk0rPAqveb+BcF6wJP
         trN1TKibjVQT5w2kKeKs7Ke3dKpmC18U0m2VbhJv56C6yqZlFqilx/RBs+ia8dihrE/s
         NT7RUEOGdDZfa7MvoikxCqeQkHBG5XXUMrY+j1M/KuTccrxbHno2rjNtfHD6HUWZy1Nh
         Lo4SUczyypFgNpCtg5wbZjhaSteIp/2VQtBtZSV800rdj40HwwllBv9hJV3bq1zXNfLQ
         UWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uro5eTdwOJguojDuekFl2mD7N0R3b5xuQ+/3Koaldlc=;
        b=NIztK8MR0xYi/1L1kfLWJq5RmhT1AHQvS0TwL6vEznWpTEBYycHPsskGa2bsF+gkBy
         1796dy6Ynty0UBwmPpGmtK/7H1H0jIyOleiIk1nCqYPDR0vJ1O/X3oeGLAX2utgLHvDl
         VdwrrbmVjYPT1IVfFF2LpcupQ0f0kH2vS7NPSysnkD+2t81/WPLcDFckzG9JcB6KOa7n
         yFddjQbsFpsxGDjuAPWfY8eFcHjyrM6CZ//x5vbhu06DeILV62eGh/Hd4BIb1BEenPPS
         sta3Vn+HSQbjqlx4c2oWUdbvjHVCKmnD/OAfOdqbNAbGeotSvGxtyUUYhXWbNwJYqPd+
         blLg==
X-Gm-Message-State: AFeK/H15KjUF/eKDBzlMvm/GRTqojs8M1PbEL/LGTr5yh9xwKe6z5LLPK/VIupMjn87Mqw==
X-Received: by 10.28.107.14 with SMTP id g14mr14172682wmc.106.1490282976947;
        Thu, 23 Mar 2017 08:29:36 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:36 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 01/14] completion: remove redundant __gitcomp_nl() options from _git_commit()
Date:   Thu, 23 Mar 2017 16:29:11 +0100
Message-Id: <20170323152924.23944-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those two options are specifying the default values that
__gitcomp_nl() would use anyway when invoked with no options at all.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 66d84745c..91fda7ffb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1216,7 +1216,7 @@ _git_commit ()
 {
 	case "$prev" in
 	-c|-C)
-		__gitcomp_nl "$(__git_refs)" "" "${cur}"
+		__gitcomp_nl "$(__git_refs)"
 		return
 		;;
 	esac
-- 
2.12.1.485.g1616aa492

