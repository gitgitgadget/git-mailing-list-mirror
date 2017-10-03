Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0832036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbdJCUPo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:44 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:49098 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdJCUPj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:39 -0400
Received: by mail-pf0-f178.google.com with SMTP id n24so5132198pfk.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jhWlJqrhMTdSWEsThVIFR/76+77o8YpBkwd65vVq0AY=;
        b=jLpPUCEeMoFmVRZeZZnQaRtdEbF+9Oaw0iAGy8wUBI9kI/+zH/tUJ9bmd8C1GuL26a
         aKFB9H55pD4ibDLkhQ6TKOeoLIrLsQ9TwdCnQ51A1ruhXQllvyW8E5yZQF8FeNEEwZ+d
         RPfFuIf8ymuvh87N7B1TKreITuJfvNPJ8kkAJc4xiWdJH3UQaXY0wdAxp2OPdHhYv5r7
         Mj1u19AVoz76hnOwtCI5EnaKgTB3Ooo0DebDPI+cQj8MCm/ga59lv9D01Tc49DhxweN/
         VIYdM2VTN3LRNrfu/tZgVJ4TyqmVn++W2EyIMLCTbBjWARIu/ltImBYdo5HmPTqniWnt
         MHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jhWlJqrhMTdSWEsThVIFR/76+77o8YpBkwd65vVq0AY=;
        b=WOnvivgbGbf/2e4FV5HGPE4R6LDK7HWWapt2bLCKz9dykDCoFMZ9d30eSJpembYgHD
         IxmBj9HPaKtigf0Jr7LYb8+LhrDUt9GOjREyHbSW5M7sVnsLmWaPzNVybR77lik/WzDG
         VFoKSNdHbwpUPwKJeI81sGR55IEQRX/NH545bQ/1iTLMiC7ONRjBWxAd/IaXtFl2rtrC
         Xu2qayR9AKsmV4StlPjhXyXWUkfGBw79iYkls4vuceUQ5ms8yYQlcC+2HhN8g21yJOs4
         pIhxt34tIbfRJnGk1mTJmNk+NDr1aib5aBD3HnVs9TVKJrtYoItusbLn1p5BZITtqphc
         fiAg==
X-Gm-Message-State: AMCzsaU6aSFEHRx5baFUwDvOZ4KYvI+FfV0JytL6Xcoo18EtDcYLQ1cn
        koscI1BETw5WDiCmvTTa2nPPRz0njvA=
X-Google-Smtp-Source: AOwi7QBvUIJdnw00uY722Nm2EZzoy91zPe+ewemfWAU8M3Wy2mwKHnM770FkYzWj7PJP1/3GXC0cDQ==
X-Received: by 10.99.109.65 with SMTP id i62mr7461822pgc.181.1507061737854;
        Tue, 03 Oct 2017 13:15:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 09/10] i5700: add interop test for protocol transition
Date:   Tue,  3 Oct 2017 13:15:06 -0700
Message-Id: <20171003201507.3589-10-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/interop/i5700-protocol-transition.sh | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100755 t/interop/i5700-protocol-transition.sh

diff --git a/t/interop/i5700-protocol-transition.sh b/t/interop/i5700-protocol-transition.sh
new file mode 100755
index 000000000..97e8e580e
--- /dev/null
+++ b/t/interop/i5700-protocol-transition.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+VERSION_A=.
+VERSION_B=v2.0.0
+
+: ${LIB_GIT_DAEMON_PORT:=5700}
+LIB_GIT_DAEMON_COMMAND='git.b daemon'
+
+test_description='clone and fetch by client who is trying to use a new protocol'
+. ./interop-lib.sh
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+start_git_daemon --export-all
+
+repo=$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo
+
+test_expect_success "create repo served by $VERSION_B" '
+	git.b init "$repo" &&
+	git.b -C "$repo" commit --allow-empty -m one
+'
+
+test_expect_success "git:// clone with $VERSION_A and protocol v1" '
+	GIT_TRACE_PACKET=1 git.a -c protocol.version=1 clone "$GIT_DAEMON_URL/repo" child 2>log &&
+	git.a -C child log -1 --format=%s >actual &&
+	git.b -C "$repo" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+	grep "version=1" log
+'
+
+test_expect_success "git:// fetch with $VERSION_A and protocol v1" '
+	git.b -C "$repo" commit --allow-empty -m two &&
+	git.b -C "$repo" log -1 --format=%s >expect &&
+
+	GIT_TRACE_PACKET=1 git.a -C child -c protocol.version=1 fetch 2>log &&
+	git.a -C child log -1 --format=%s FETCH_HEAD >actual &&
+
+	test_cmp expect actual &&
+	grep "version=1" log &&
+	! grep "version 1" log
+'
+
+stop_git_daemon
+
+test_expect_success "create repo served by $VERSION_B" '
+	git.b init parent &&
+	git.b -C parent commit --allow-empty -m one
+'
+
+test_expect_success "file:// clone with $VERSION_A and protocol v1" '
+	GIT_TRACE_PACKET=1 git.a -c protocol.version=1 clone --upload-pack="git.b upload-pack" parent child2 2>log &&
+	git.a -C child2 log -1 --format=%s >actual &&
+	git.b -C parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+	! grep "version 1" log
+'
+
+test_expect_success "file:// fetch with $VERSION_A and protocol v1" '
+	git.b -C parent commit --allow-empty -m two &&
+	git.b -C parent log -1 --format=%s >expect &&
+
+	GIT_TRACE_PACKET=1 git.a -C child2 -c protocol.version=1 fetch --upload-pack="git.b upload-pack" 2>log &&
+	git.a -C child2 log -1 --format=%s FETCH_HEAD >actual &&
+
+	test_cmp expect actual &&
+	! grep "version 1" log
+'
+
+test_done
-- 
2.14.2.920.gcf0c67979c-goog

