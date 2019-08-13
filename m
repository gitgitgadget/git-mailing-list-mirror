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
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCD81F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfHMM1M (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:12 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42891 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfHMM1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:11 -0400
Received: by mail-wr1-f42.google.com with SMTP id b16so10862399wrq.9
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rpg6miNQgY/QZ2BwmfrL7B5ff9+w0baFgPS1fYfNOqU=;
        b=EzqAndQdl7RwVN/jidX5/c3sZaLTblx4fGu7G/+7DRuK3KJcKTg0mt/UKl/5UqW8O9
         arfwxcAk/MtQfgUpytMAZ6fTAZPe0HJugyEEmVMERqPiwcI0Fq/g/WIe5R9rA5QhtgEH
         P+7Krbc7m+IYId9aDbOMJ65JN0c/giALc7yr3W544Cx9ytBUl+dAO/zFKc/FCQthms3f
         Z2TSDIkqzJsno6U/lQ7FpZbTkPDn2rtPzO+vjY1wzzQVdZu5fckjTKiUIfN2rQmUidKW
         D7vhLSgg78hUj8pUzglqOn3m0yz13GclZPXS2ZZursjT0JUqDsw8dAHRYCBUaV8UU805
         bA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rpg6miNQgY/QZ2BwmfrL7B5ff9+w0baFgPS1fYfNOqU=;
        b=X591g2YUrpsBF3ensaa1VIw3yorIz0q1na35OPERB/oGthQijCTvvlPrdpg5pUMxMQ
         BIA52eR50toV/M0Y7s5LoI11NOzB0kxMTNpJjCfwvbHX2kRNOXHdh8EqMxcAU10Ptbi0
         49n3MaYREngORgbl8zO0H6PFsvSv8WWZPGeYEOjD0V64frYh+Aac9X5IQIBouJO32bos
         oI5fnNKWMOtM/0k0lbmBks7xdGrQ3Bho8c0Jwc3PkVlKHARFfZWa1/5uuMozSrp7E4/z
         YAtVS4CkL/1nK5oNtr/yhVTdfidhXacmZnCPLTNqJKatC2V7zMhe7ztCvV8UghMAnPy6
         jgYQ==
X-Gm-Message-State: APjAAAUwB0hVaOkbELYP7L9g4W4k0kZR/osPISvLTG+tWCSqu0MQRfO+
        FwqZPol/8q3B8plLA+KaRMY=
X-Google-Smtp-Source: APXvYqw3S0fSB0VfaD3cwAJl3h263j6UkGvzfJujNONYtOp21U4dw25em64qJSsHeYcVKgec5jEtlg==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr23402220wrq.171.1565699227407;
        Tue, 13 Aug 2019 05:27:07 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/11] completion: add tests for 'git config' completion
Date:   Tue, 13 Aug 2019 14:26:44 +0200
Message-Id: <20190813122652.16468-4-szeder.dev@gmail.com>
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

The next patches will change/refactor the way we complete
configuration variable names and values, so add a few tests to cover
the basics, namely the completion of matching configuration sections,
full variable names, and their values.

Note that the test checking the completion of configuration sections
is currently failing, though it's not a sign of an actual bug.  If a
section contains multiple variables, then that section is currently
repeated as many times as the number of variables in there.  This is
not a correctness issue in practice, because Bash's completion
facilities remove all repetitions anyway.  Consequently, we could list
all those repeated sections in the expected output of this test as
well, but then it would have to be updated whenever a new
configuration variable is added to those sections.  Instead, list each
matching configuration section only once, mark the test as failing for
now, and the next patch will update the completion script to avoid
those repetitions.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 75512c3403..e15be1164d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1698,6 +1698,27 @@ do
 	'
 done
 
+test_expect_failure 'git config - section' '
+	test_completion "git config br" <<-\EOF
+	branch.Z
+	browser.Z
+	EOF
+'
+
+test_expect_success 'git config - variable name' '
+	test_completion "git config log.d" <<-\EOF
+	log.date Z
+	log.decorate Z
+	EOF
+'
+
+test_expect_success 'git config - value' '
+	test_completion "git config color.pager " <<-\EOF
+	false Z
+	true Z
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.23.0.rc2.350.gf4fdc32db7

