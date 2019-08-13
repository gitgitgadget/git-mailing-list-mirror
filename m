Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BAD01F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfHMM1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33945 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfHMM1R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so966912wme.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uRg0QVVmX3kKSXitFVfdMn7sUHNFc2G/aKsqEys8t8=;
        b=fFriSXrTtl/p5L1ftkhD8I2UFJpqWdl2AUFx7oOyc13PvJ2EtJOtDELO4A64aAr1Y+
         3uxmrvQuluqz/aCj/fzM8oVU10mEtiZogDkqra60v2ysa3iUKjGLZs6RutN9UmlJ1tZJ
         6nNjw62H0z9mu8f7h1vniPYa8k7WFt5iCzTeRguUHBawTTso+tS/zgNNHihzrk3mM/gz
         xtOOkXbbwNgmqoeqGghNV5k8lPUQCsW/wZ+SDB3DruQmpl86H1WTXxr1IshQjjaokDPU
         0W6tCmeOaKGFoKLMNZXS86aZNUrvd12m7LI8+Xss+kEQwB18Wb23EgB5hbPCYIg7ZUoh
         ArkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uRg0QVVmX3kKSXitFVfdMn7sUHNFc2G/aKsqEys8t8=;
        b=t1e9yBBXvKPsl9z6ZG+5fH/RREiHXYvOVIhAomTddgXu3GABLy/t3dGAvtAk8CmVs+
         l3iTiq7HgUpLMb6XRNO2oPEIqp/2ZATPMVqz9np+ReYI5uYp0pocK49Z2wu2oNvVzgYp
         Pxbsj7K4IyFtQuJqm8+68UbZKYdIvXpSzdggTWIyHWYot+Pefo6au6gjYiQwPQL3f5RW
         +Gvp8F4z+RF7AcixD+JhG+V1yGY0I5NHCKd1QO+U/j1m1SJRqkwFEMfVC4uvz6bEbZ7O
         sn7FrYM60hV9HSHGgz9j0XG3j6eypLaxGJrHAQVrTV2VoC5ItI4cZlVk0MqatN9Y4Ouf
         Hk8g==
X-Gm-Message-State: APjAAAW25YEiN1dPd3KcZ2RyZNGh+b5HFRmTMQ5UT4dVEXoMowF62tmz
        gORnKSgckegJmzmAeaWFtis=
X-Google-Smtp-Source: APXvYqy/MEnj84FGcdDJU7RARTOmnrJGl1raabtxQZGkZ+6sUgyuPRugcFJ+EUB78T3uYlzHnEn/9A==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr3024327wma.90.1565699235266;
        Tue, 13 Aug 2019 05:27:15 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/11] completion: complete config variables names and values for 'git clone -c'
Date:   Tue, 13 Aug 2019 14:26:51 +0200
Message-Id: <20190813122652.16468-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commits taught the completion script how to complete
configuration section, variable names, and their valus after 'git -c
<TAB>', and with a bit of foresight encapsulated all that in a
dedicated helper function.  Use that function to complete the unstuck
argument of 'git config -c|--config <TAB>', which expect configuration
variables and values in the same 'section.name=value' form.

Note that handling the struck argument for 'git clone --config=<TAB>'
requires some extra care, so it will be done a separate patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6f2bc60707..279f04df87 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1399,6 +1399,12 @@ _git_clean ()
 
 _git_clone ()
 {
+	case "$prev" in
+	-c|--config)
+		__git_complete_config_variable_name_and_value
+		return
+		;;
+	esac
 	case "$cur" in
 	--*)
 		__gitcomp_builtin clone
-- 
2.23.0.rc2.350.gf4fdc32db7

