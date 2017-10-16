Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE77D20437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbdJPR4C (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:56:02 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:51400 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbdJPRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:59 -0400
Received: by mail-it0-f47.google.com with SMTP id o135so2154677itb.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x6NpqQifx+fmh0uIJ+fgXKd++Sl0YYBtYBJ9CVJk2AE=;
        b=CIoyO2/u934bJnbuLpYHK9jO0D8fHZpaztNZm7Nj6WbtP7cOUftVTrFU95hp4GB2f1
         y3z4gz7YPmuyw9quy2PAKaa6M/Aej28enVYi8GSZERQlWdO0sX4zKM9Fk/5IhrOd4vp9
         +q/WumjouF8theKf6M+Sf2u4nlH4LCqgMTz0XZ1fNKXInCB+bq+fyC3c9AcHbSDWx4zX
         cjPtlHRXAeiz1gH8iuYs843rYU4ucMCS10VsYyh0cMCh4Cl1+Mq+kI5VzM3obVw2fHTC
         ceYE8MCz+2urr4XTqm4lsqPai33kQSZ70ZSpm2KQBYlvzPMdbJk9x5edONoUB78T+6iS
         ln3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x6NpqQifx+fmh0uIJ+fgXKd++Sl0YYBtYBJ9CVJk2AE=;
        b=IYD4mfBwYK+tth7QB022/RA4VmxPE3k7ox4GUpZ/fk6tMftDwSCJxS2cCxWf4C8sl0
         4tzhzPXJASDI11H0c5pS46nwG6cTKjObqk56NsZu4soofHW6MvipS0vO9zBF1d94GZl2
         ehZ8T3vXa2kqey9BQO/CYsshDLIBmaDtXguynKtWBeAxMiIQS353J/QOsnr0fdk8zOGV
         HGD7eq4CNu6C8DGKcvBAKNNgQmhl1PRQwDMrplDx3hF/0ocZ03nL3JD9KeYKiNmaS7Zg
         lqzC4Tp1ygOFnbSXRUaDzvjnO1ujs4NQHLb8cxbE5mQMwvZkd1p4o+vyu6+FznhMAj6r
         KOqw==
X-Gm-Message-State: AMCzsaWbZoeF8+Kd1XfBelG/KfocaZEa7HWM2p132LZtrWKBzenA+P+p
        msICBNwC9Z4e9+oI237DSsy1h73OqRg=
X-Google-Smtp-Source: ABhQp+RMg5pjJuKgVBS6VfseOeprZjk2CREmI687fh5zXihu+SvF/stD5t1XTA29Z1eBS/NEg4uwJg==
X-Received: by 10.36.149.196 with SMTP id m187mr2235039itd.75.1508176558288;
        Mon, 16 Oct 2017 10:55:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 09/11] i5700: add interop test for protocol transition
Date:   Mon, 16 Oct 2017 10:55:30 -0700
Message-Id: <20171016175532.73459-10-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
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
2.15.0.rc0.271.g36b669edcc-goog

