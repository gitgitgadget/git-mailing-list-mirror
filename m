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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4E21F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfFUWb1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42985 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFUWb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so7779542otn.9
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6RBg0DD4sqgVlOHsY9wfoAFRK6crKRic2ax0/1zoGA=;
        b=r143sdHE/eB3Ra6jIubxWSTsk6xtZbwEK1RmLa2x46jri337lfRmtDbJ4nRrWK+LUB
         yJv0V3Vgw/MobSjuv69imcqqwO6H0FrBPtiVzT6I86/ZPg40ZiCza5QQNJfYziQbmB2U
         g81t0i+WYFuWqhORxrOp6fl2DT284bXAiA20bYtIn8IOYtlkOscQICO/DYR9t1MaL0S4
         33Z5fHV8xQdE1VFu73nNAOBC6lhunBI8PmmjLrubm/HKSce3LVoFU/KbM+akXpV2ThV9
         Lov6Ox6/N4YkkgUm2IuJk2xQOL63854H4U54i5DCZMufFiU6LbZFR3MVEjae2IX3umcI
         NJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6RBg0DD4sqgVlOHsY9wfoAFRK6crKRic2ax0/1zoGA=;
        b=Mu4yMwCnlIL0uQPquRdBexKlOkf8Dden7LywRlgQfE6SNPkjHFIwhTNOhrs6EZnAMC
         Z47pmBF5fTPpCRoXPaop50FL+AJq6MtFblyWaZ3vUfov1zuqNQKnejw96oVtSpDo0j6J
         N8FI7vW3tXufYpE5VGhLa8zfFy+CG40NXUDlneZYrcVRZ/VKD3Nsd1duUwYerOaPxvtk
         rtJTgwCwyYkjQUP4Z2tZrD/8UmmQAGNm0+ETuUDArHXjdzyVRuITB47q1tsNop576tbc
         pRiFjUxaSuBvGU1uRBNCbjmRghUTglh2korf45lAsHNF9WQVfJH4/KgqSsXIZH4EysvJ
         s5sQ==
X-Gm-Message-State: APjAAAUnEsaAsbhaqcIz419c5XIWv51BUWuWRLZFRLxhntxfwZlplyS9
        p3AKgMPF2R6F2fDP6ldPP+MWcx3e2os=
X-Google-Smtp-Source: APXvYqwf3WEU+YOvE4VidmXgruVVnLneCrrYY85iFg7ZhgJ+CtOwzxlFb4FtZ82qRmem6NAgjcLsGQ==
X-Received: by 2002:a9d:620e:: with SMTP id g14mr13834777otj.317.1561156285043;
        Fri, 21 Jun 2019 15:31:25 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id w123sm1644318oiw.38.2019.06.21.15.31.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/14] test: completion: use global config
Date:   Fri, 21 Jun 2019 17:31:05 -0500
Message-Id: <20190621223107.8022-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When appropriate.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7bef41eaf5..3dbfef6960 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1497,9 +1497,9 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
 
-test_expect_failure 'completion.commands removes multiple commands' '
+test_expect_success 'completion.commands removes multiple commands' '
 	offgit &&
-	test_config completion.commands "-cherry -mergetool" &&
+	test_config_global completion.commands "-cherry -mergetool" &&
 	git --list-cmds=list-mainporcelain,list-complete,config >out &&
 	! grep -E "^(cherry|mergetool)$" out
 '
@@ -1637,7 +1637,7 @@ test_expect_success 'complete files' '
 '
 
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
-	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
+	test_config_global alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
 	master Z
 	mybranch Z
@@ -1646,7 +1646,7 @@ test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cm
 '
 
 test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val git <cmd> ... }' '
-	test_config alias.co "!f () { VAR=val git checkout ... ; } f" &&
+	test_config_global alias.co "!f () { VAR=val git checkout ... ; } f" &&
 	test_completion "git co m" <<-\EOF
 	master Z
 	mybranch Z
@@ -1655,7 +1655,7 @@ test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val
 '
 
 test_expect_success 'completion used <cmd> completion for alias: !f() { : git <cmd> ; ... }' '
-	test_config alias.co "!f() { : git checkout ; if ... } f" &&
+	test_config_global alias.co "!f() { : git checkout ; if ... } f" &&
 	test_completion "git co m" <<-\EOF
 	master Z
 	mybranch Z
-- 
2.22.0

