Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29AF1F42D
	for <e@80x24.org>; Sat, 26 May 2018 12:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031581AbeEZMJB (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 08:09:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52044 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031529AbeEZMIy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 08:08:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so20757861wme.1
        for <git@vger.kernel.org>; Sat, 26 May 2018 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zx8haMPK5cYKmDy2n37pW76g00ifNKNkPt8/iQafYFw=;
        b=DbGTkTfNjyY3NPYmS/1bD3BbX+g+Lx6Fpu+fYk+/ZvJuqzdeMGDWhp+aUstd3SBnuO
         y6VlSitgUxGO7/kMXmTf23uJTpG4Wy6pMXDF5BXKpFBduyPEDRiTqTEXjuwtVqWBavKC
         w9D/pVg3UJPJVwqYMc0Xxvc71kwXHnjw+dm2Ek8yqEJPlb+GmEOKOLTcilnOA6PuASeT
         MTF4PF4aflduFeyDGBWxhUaByix/E6PcbdWG81HBjgudY8ojKFlc5EC4aCjmZ7o3MkyQ
         summR3tJxFfYMzCzkSUGwvfwpOvi/+t762xwBpfUd1JHWgSpP71kbAL/ZheyUiZ6AkdH
         SmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zx8haMPK5cYKmDy2n37pW76g00ifNKNkPt8/iQafYFw=;
        b=jUd9GKEAysMBOkvuv7KrGe9VFK23VaV46l9se+zqZ5Lu8AE0JsWCxAik2rG4zhkxC6
         8eWtAQvYvVA5khGZfaA3tmUIYLc6sdtdkFVwU9/yJlST+J5if2RLtW18EUwbPiv3ZR5P
         TlZm5EWkg/ZIlQLA+REXTzVMF5jGwEuirzgPETWw5VJ54c5uWp7bLzCTw7qGP2/TvTbZ
         DfTU+ZrG8XBQQjIeuHyOf2EZf0m0cuUzUG9GOPpNH3Lo4pz5ZB4J+H09PBe5ZxItzpJM
         bfRIN3HNmjcXo8DUvVd0WzDl01qx2TrplPnds/UDfHLf30H28T1pc7zKLwF1HewdVGsH
         5Y2g==
X-Gm-Message-State: ALKqPweaRMDlr9h899nfd1QVT7WWCGsXFF7OZ7DNrbRU1ZDVB2e74nBh
        /glhM9+GoXyfjmzxMlIPSFViMA==
X-Google-Smtp-Source: ADUXVKJhB6yrI3sfPgfzz++XzCFwYOPJX2Jn9TTImWMDSqbWkRQ4WAlKT5CMi6vsoRoxTYl4XVWiZA==
X-Received: by 2002:a2e:86d9:: with SMTP id n25-v6mr4064762ljj.18.1527336533607;
        Sat, 26 May 2018 05:08:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r81-v6sm4789574lja.36.2018.05.26.05.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 05:08:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 3/4] t2203: add a test about "diff HEAD" case
Date:   Sat, 26 May 2018 14:08:45 +0200
Message-Id: <20180526120846.23663-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526120846.23663-1-pclouds@gmail.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
 <20180526120846.23663-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous attempts to fix ita-related diffs breaks this case. To make
sure that does not happen again, add a test to verify the behavior
wrt. ita entries when we diff a worktree and a tree.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2203-add-intent.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 1115347712..546fead6ad 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -245,4 +245,21 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 	test_cmp expected2 actual2
 '
 
+test_expect_success '"diff HEAD" includes ita as new files' '
+	git reset --hard &&
+	echo new >new-ita &&
+	git add -N new-ita &&
+	git diff HEAD >actual &&
+	cat >expected <<-\EOF &&
+	diff --git a/new-ita b/new-ita
+	new file mode 100644
+	index 0000000..3e75765
+	--- /dev/null
+	+++ b/new-ita
+	@@ -0,0 +1 @@
+	+new
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.17.0.705.g3525833791

