Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629D11F461
	for <e@80x24.org>; Fri, 12 Jul 2019 23:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfGLXCP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 19:02:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44457 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXCO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 19:02:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so10996269otl.11
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUqVO9gNw8HHYBwxjBbURyAf8vtrrkGOweh6xiiymX4=;
        b=qWKxu2S9l5nzuvBcRmY+102H8WVfxM9e95vwakaEJ0uZg7qXQhR0ydy/fNQ8HQILSN
         REA9Oj56mO2I2vvrnHMKaljKS8JGwD3Z5UimfHseQ7nGl1rZtZ3EmHrRiF3RY7HSEZ97
         o/wIq7p+GbboB3pkTlnsUbpeKmXTNsp1tN4WAbFUvAGdzCtfCKj+b4zJL36fhQjExZL3
         gzN4hhkM7WRrH+qXXd0KpIzgqFJhDkqWsTkuwc9FqzheCovfdfgFvTlSyH4MLSd+XSJu
         jFqu3u33VQBjgwKjezRcZ7RgEhDfRePCkjKH4MwuPffOePMjzMdt3eB2VqxClQMFSYy2
         4TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iUqVO9gNw8HHYBwxjBbURyAf8vtrrkGOweh6xiiymX4=;
        b=Y+vxAY+lY5qsqpDT5npSNhhEMx+6ibAJx+BUEgXB5KfPzdlqetmeu9yfMgL6xxcvoZ
         773NEldacjFaI7WcUx6J7FH37+X9896XT3uXt4EQtrirk6XzRS1cPdjvVD97p+WguWvY
         TiYbldXDWxBh8lndwQri2+VmHu2kwqd1k0SEnVV+U1k5gEg09W1Y7tdzK62oyU46hrNi
         qPUsREmQyRfU6tu77zBxsgBtNOw/XZ1GwBYuh6CjwQbOCS6+nWU3V7GvROrkL/YwOUob
         53GTrW7xcY5f4mRlskm+v6gnFz10e0NZTze5TJupsIhjAULjA/RWq1ZfW4e6lnVe9/bq
         0I3w==
X-Gm-Message-State: APjAAAU1DudkV/JuUcVakbPEKKysvBgWFqQJ+8Tdx2g/BAjh1EnTyaow
        aVj2QoMi8h0z6f9YwtRolJhPNMU/
X-Google-Smtp-Source: APXvYqzLdtd4uVk3YVppdK7uJ2CCJsYQxISlQ7TumVRi5udB9MgX1nfKKTI1dcLD13ZoHoNck3a2AA==
X-Received: by 2002:a9d:12af:: with SMTP id g44mr9752598otg.96.1562972534083;
        Fri, 12 Jul 2019 16:02:14 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id i21sm3260066otl.24.2019.07.12.16.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 16:02:13 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 3/3] tests: defang pager tests by explicitly disabling the log.mailmap warning
Date:   Fri, 12 Jul 2019 18:02:04 -0500
Message-Id: <20190712230204.16749-4-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712230204.16749-1-ariadne@dereferenced.org>
References: <20190712230204.16749-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patch, we added a deprecation warning for the current
log.mailmap setting. This warning only appears when git is attached to
a controlling terminal. Some tests however run under an emulated
terminal, so we need to disable the warning for those tests.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 t/t7006-pager.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 00e09a375c..1c72aae197 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -304,6 +304,7 @@ test_expect_success 'tests can detect color' '
 
 test_expect_success 'no color when stdout is a regular file' '
 	rm -f colorless.log &&
+	test_config log.mailmap false &&
 	test_config color.ui auto &&
 	git log >colorless.log &&
 	! colorful colorless.log
@@ -311,6 +312,7 @@ test_expect_success 'no color when stdout is a regular file' '
 
 test_expect_success TTY 'color when writing to a pager' '
 	rm -f paginated.out &&
+	test_config log.mailmap false &&
 	test_config color.ui auto &&
 	test_terminal git log &&
 	colorful paginated.out
@@ -318,6 +320,7 @@ test_expect_success TTY 'color when writing to a pager' '
 
 test_expect_success TTY 'colors are suppressed by color.pager' '
 	rm -f paginated.out &&
+	test_config log.mailmap false &&
 	test_config color.ui auto &&
 	test_config color.pager false &&
 	test_terminal git log &&
@@ -326,6 +329,7 @@ test_expect_success TTY 'colors are suppressed by color.pager' '
 
 test_expect_success 'color when writing to a file intended for a pager' '
 	rm -f colorful.log &&
+	test_config log.mailmap false &&
 	test_config color.ui auto &&
 	(
 		TERM=vt100 &&
@@ -337,6 +341,7 @@ test_expect_success 'color when writing to a file intended for a pager' '
 '
 
 test_expect_success TTY 'colors are sent to pager for external commands' '
+	test_config log.mailmap false &&
 	test_config alias.externallog "!git log" &&
 	test_config color.ui auto &&
 	test_terminal git -p externallog &&
@@ -573,6 +578,7 @@ test_expect_success TTY 'command-specific pager' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
+	test_config log.mailmap false &&
 	test_unconfig core.pager &&
 	test_config pager.log "sed s/^/foo:/ >actual" &&
 	test_terminal git log --format=%s -1 &&
@@ -583,6 +589,7 @@ test_expect_success TTY 'command-specific pager overrides core.pager' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
+	test_config log.mailmap false &&
 	test_config core.pager "exit 1" &&
 	test_config pager.log "sed s/^/foo:/ >actual" &&
 	test_terminal git log --format=%s -1 &&
@@ -593,6 +600,7 @@ test_expect_success TTY 'command-specific pager overridden by environment' '
 	GIT_PAGER="sed s/^/foo:/ >actual" && export GIT_PAGER &&
 	>actual &&
 	echo "foo:initial" >expect &&
+	test_config log.mailmap false &&
 	test_config pager.log "exit 1" &&
 	test_terminal git log --format=%s -1 &&
 	test_cmp expect actual
@@ -610,6 +618,7 @@ test_expect_success TTY 'command-specific pager works for external commands' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
+	test_config log.mailmap false &&
 	test_config pager.external "sed s/^/foo:/ >actual" &&
 	test_terminal git --exec-path="$(pwd)" external log --format=%s -1 &&
 	test_cmp expect actual
@@ -619,6 +628,7 @@ test_expect_success TTY 'sub-commands of externals use their own pager' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
+	test_config log.mailmap false &&
 	test_config pager.log "sed s/^/foo:/ >actual" &&
 	test_terminal git --exec-path=. external log --format=%s -1 &&
 	test_cmp expect actual
-- 
2.17.1

