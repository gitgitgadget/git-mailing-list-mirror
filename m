Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DB31F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfFUWba (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43869 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfFUWb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so662320oth.10
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZO7yby0/XVxCyPkgiYHbmca//TbCCBrhLrSjteLUtqM=;
        b=YIu/ngVFqFm4o696Ie6uwL4/LhXIRumaQ+nrKj4m3tVw/SDfbgUJTjXKTc9MP2T5G+
         Cm0isRbARI+kODIUaBGw5/yaMZqE7v/CzWMyDdz+jhXESCwJtC0Cd2IsP8V4x27MdByi
         Wta/acB54tqvIVyUS1lGrEnjFO0zw6gLAGuVCFuBB3t4bgoqreNF/egHccg/PYwBg0YL
         Hptc1TqzLfAzdpF9lt9Bskn6wWXbi8BDlgj6tw2xDAoqCKowRt/au0k4hpvKCron/zIn
         bict3F5b83xGSFPW9fx71C3G8Mtwm+XQpI36R/pV+XRF5lkyG2Fpq6YeDk2Jr91EFzbJ
         U/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZO7yby0/XVxCyPkgiYHbmca//TbCCBrhLrSjteLUtqM=;
        b=Lvd3kv7w6UcE1zifnvydDNFsgHvboK8ZzPpSVtZM1W3i68BXgjFezp1I3BS/okkhfg
         36qC8wrfXiLZ4X8nvY/2augZ2hxeodSx9k/OklGQNaRVtOYZsRT1eYz5UB1ULVobNGkr
         Ids2JcUcFw0IikSWaJqi42xcReCFyUdnhTT41vRINcD3clkIwmAkyJlxy6vU8H0olt6/
         7eC6kxx5B0ZextfpdajYAMEjpURJyPhK2EEyEUoKaksR0+ZVhE7qWZ4BpwG7Nip1nDiL
         ylggdaqsP5DkD888CrcCIqw6rXNSY89R+CFVMC/uBFyUeLjAfp3XTg2+EBTR0cn8s443
         sxSA==
X-Gm-Message-State: APjAAAULHGrqWEZjwGZ8dryWzRRGim9OPfsufb78H09MAD1BZHjOvOEc
        kRTnAYq1sH8fComHzHao6+eoxvv5hRo=
X-Google-Smtp-Source: APXvYqyo0caBgmdNoqYAIsJzUwKbiu8/D5od+8QBlPQIryGh6rqjp7hnQ4IlkXk7PENEQxDJ/k4oEw==
X-Received: by 2002:a9d:7ccb:: with SMTP id r11mr40005877otn.80.1561156287558;
        Fri, 21 Jun 2019 15:31:27 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id a4sm1466470otp.72.2019.06.21.15.31.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/14] completion: add default merge strategies
Date:   Fri, 21 Jun 2019 17:31:07 -0500
Message-Id: <20190621223107.8022-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case the command fails.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 +++-
 t/t9902-completion.sh                  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 922ba5f925..91b87eb558 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -936,6 +936,7 @@ __git_list_merge_strategies ()
 	}'
 }
 
+__git_merge_strategies_default='octopus ours recursive resolve subtree'
 __git_merge_strategies=
 # 'git merge -s help' (and thus detection of the merge strategy
 # list) fails, unfortunately, if run outside of any git working
@@ -945,7 +946,8 @@ __git_merge_strategies=
 __git_compute_merge_strategies ()
 {
 	test -n "$__git_merge_strategies" ||
-	__git_merge_strategies=$(__git_list_merge_strategies)
+	{ __git_merge_strategies=$(__git_list_merge_strategies);
+		__git_merge_strategies="${__git_merge_strategies:-__git_merge_strategies_default}"; }
 }
 
 __git_merge_strategy_options="ours theirs subtree subtree= patience
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 14598bfbec..f4453ce70d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1722,7 +1722,7 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_failure 'sourcing the completion script clears cached merge strategies' '
+test_expect_success 'sourcing the completion script clears cached merge strategies' '
 	offgit &&
 	GIT_TEST_GETTEXT_POISON= &&
 	__git_compute_merge_strategies &&
-- 
2.22.0

