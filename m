Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A8C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBUVgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUVgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:36:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324D27D4B
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:36:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso280102pjv.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DnJVS/msx9n1mG5wF/VTp4VhvTV/wnRa34wTOFb/bg=;
        b=RQZlivOl7VILtn859BvKTtBbaB9lg2Qo+5NVYxOOXVPGX9UNaXzJtHiOnnnD8q0bEJ
         +9jVCS4vShRezGZe26pUSakZ+xiQyymBna+qK6XLNPWeDBdyjAiGnt78EL2G2gXbEclm
         a19rD2ENSToff1YqJ9PeVuMP2tkSMS2CrldFdJrtt6KCg4Ug2ZRiVSznLIRFBU/gpbD6
         GRM2uy6rark3+3DviltagPJHVKWaYPqFM1rRSXtxuLxoq6xTGYdfc7aYzjdHUNDhRjtr
         WpFwnEQcAG6bq9v++rxvpiGJqhWm0JE+qIkDtFeMUa1rVeSIXqh2Y06X+XtUZXJXJ2Rr
         K/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DnJVS/msx9n1mG5wF/VTp4VhvTV/wnRa34wTOFb/bg=;
        b=y+jQSJ/nF0GBKIkFkSs6Vx5yExrmiAyvxaD5b5cGZ3EMxhQxgRqKlp/ex9rnuZPm8G
         yJ0TxkFTGsjuR7p0Q+fRD++2Av2PsAN1Oq0ujgSFa0Zm6P20j5YrFPHO86YQze80HGwN
         ajOWPsDPnCLIfqyjvzxy5Tn07RrzUGXe36gdJw6zVFi/7ZbNfI3Y76Pfcw9Hs7rh9lsp
         5Ebk1X03UiIhVmmLHAYBItiV2WYU8X0kLnziYYN1Yos9rlp+UTH9ziZIdu3JFPIoB2/d
         CGzvj7gFN7h/vK34VgrNi3G9xhe+538K4S0DFM8DkI2d6qvE0Qg19KATl/N1JbqJOxWB
         3G3A==
X-Gm-Message-State: AO0yUKWP73K29Z6I2oJ7F80B0dUf74HjPO5ENtl3qxkPnhZZDtzCQyIs
        8JRi5tW5pwtHhViQ/1LTZOzHuv/TYw0yUw==
X-Google-Smtp-Source: AK7set8F497Unn55+rODJk0EnpQsUTCbMpptaMNUYZ5/lKjI2ogvci59zCPbTO468npjjtHlnYTvSg==
X-Received: by 2002:a17:903:230b:b0:19a:9833:704 with SMTP id d11-20020a170903230b00b0019a98330704mr9895796plh.61.1677015380010;
        Tue, 21 Feb 2023 13:36:20 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b00199563fff0fsm6524217plm.190.2023.02.21.13.36.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 13:36:19 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH v2 1/1] t4121: modernize test style
Date:   Tue, 21 Feb 2023 14:35:26 -0700
Message-Id: <20230221213526.85591-2-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230221213526.85591-1-gvivan6@gmail.com>
References: <<20230220235121.34375-1-gvivan6@gmail.com>
 <20230221213526.85591-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file t4121-apply-diffs.sh are written in old style,
where the test_expect_success command and test title are written on
separate lines, therefore update the tests to adhere to the new
style.

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index a80cec9d11..f1cc42ff71 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -16,8 +16,8 @@ echo '1
 7
 8' >file
 
-test_expect_success 'setup' \
-	'git add file &&
+test_expect_success 'setup' '
+	git add file &&
 	git commit -q -m 1 &&
 	git checkout -b test &&
 	mv file file.tmp &&
@@ -27,10 +27,11 @@ test_expect_success 'setup' \
 	git commit -a -q -m 2 &&
 	echo 9 >>file &&
 	git commit -a -q -m 3 &&
-	git checkout main'
+	git checkout main
+'
 
-test_expect_success \
-	'check if contextually independent diffs for the same file apply' \
-	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
+test_expect_success 'check if contextually independent diffs for the same file apply' '
+	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
+'
 
 test_done
-- 
2.37.0 (Apple Git-136)

