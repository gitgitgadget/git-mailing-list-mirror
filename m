Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D518520248
	for <e@80x24.org>; Tue, 26 Mar 2019 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCZJmC (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 05:42:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33264 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZJmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 05:42:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so8022254pgk.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BvgRfU4jW6peA0ksp8O80QTCiWd/g+q2jo/AOtTsA4=;
        b=ZYBpTtDaBbQNwETenLjie2oHzJXrL/9Z62kTef91La3LByjMd8bP3kuUM1r1wZRnuQ
         iYUo54dGlSyDzM06SgK6Vbc4ks+Q/a3LgCiuOzuFjgOY9u8+NSVuPZt2zV6o6B40Pdfl
         OIV9jgbhR5MQZY6dRwI4n6RQ4j20jMqQY2mjRj446L67fgmuddxGE0OuKfFJafeX+Ry9
         SWF141Yf4qfEHF61QJytfSrq9uf+7IoxPXLpp1EIsCevHtXGItZRsGwpDXxbAUdZSVvN
         b0kDc/Iel2RTGvL4LVSsVuo+UNP+aZzgIy83DIk240TJym5ssstIB9wyHnWvxSiwURdt
         7IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BvgRfU4jW6peA0ksp8O80QTCiWd/g+q2jo/AOtTsA4=;
        b=ZRCJ+jGBOD76kQllJUq5pabURtbNbVHyZqj8CE3B+pnZnuKtUxkoj7MrJYoR+cCT+q
         4dUkVJbwLLjjJP7e0xDmxLX6sTTPHB6cEXk14GrXeGCbV+RBN7DAoDpXJ/rDDiHPbFH5
         eD5zHIRtLrLHM7h987z5DrnI2Qy0upKFX41FQHoWjxio7pr0rJe6jxogrFzX2klvHOy/
         DSJGM5Yxw3h4oNv4X3RbACW0WceGoV+Bnto9xRYc6/OV4DdRxS6Otyg8Zb19GGxxN5zb
         U82TwlRxpSQhvUNaWN5HSZd4Wog928Ve6wa3dRl9if2U6vKVnf5tVbWQ/c3MTgV7P8su
         thSw==
X-Gm-Message-State: APjAAAV/r7a+aFhHw77nz7I2VqKuoNv4bRl3k/mDGb43tuFWf+Kme5ZE
        JjuBrXug6xG5PRPSXypr1GY=
X-Google-Smtp-Source: APXvYqw7sxU5x0DAdqDpxruHYbj/0FPCFn5gwEltsxbS7JY/NLOT6N6aaOWqk7niCBVhMFlp29OUqw==
X-Received: by 2002:a63:c118:: with SMTP id w24mr27721725pgf.67.1553593321777;
        Tue, 26 Mar 2019 02:42:01 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id d20sm3048416pfo.77.2019.03.26.02.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 02:42:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Mar 2019 16:41:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jason.karns@gmail.com,
        me@ttaylorr.com, johannes.schindelin@gmx.de
Subject: [PATCH v3] config: correct '**' matching in includeIf patterns
Date:   Tue, 26 Mar 2019 16:41:01 +0700
Message-Id: <20190326094101.26294-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190324131755.26821-1-pclouds@gmail.com>
References: <20190324131755.26821-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current wildmatch() call for includeIf's gitdir pattern does not
pass the WM_PATHNAME flag. Without this flag, '*' is treated _almost_
the same as '**' (because '*' also matches slashes) with one exception:

'/**/' can match a single slash. The pattern 'foo/**/bar' matches
'foo/bar'.

But '/*/', which is essentially what wildmatch engine sees without
WM_PATHNAME, has to match two slashes (and '*' matches nothing). Which
means 'foo/*/bar' cannot match 'foo/bar'. It can only match 'foo//bar'.

The result of this is the current wildmatch() call works most of the
time until the user depends on '/**/' matching no path component. And
also '*' matches slashes while it should not, but people probably
haven't noticed this yet. The fix is straightforward.

Reported-by: Jason Karns <jason.karns@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v3 updates the test to avoid mkdir and cd, and break long lines.

 config.c                  |  2 +-
 t/t1305-config-include.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0f0cdd8c0f..c2846df3f1 100644
--- a/config.c
+++ b/config.c
@@ -242,7 +242,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	}
 
 	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
-			 icase ? WM_CASEFOLD : 0);
+			 WM_PATHNAME | (icase ? WM_CASEFOLD : 0));
 
 	if (!ret && !already_tried_absolute) {
 		/*
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 635918505d..579a86b7f8 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -229,6 +229,19 @@ test_expect_success 'conditional include, early config reading' '
 	)
 '
 
+test_expect_success 'conditional include with /**/' '
+	REPO=foo/bar/repo &&
+	git init $REPO &&
+	cat >>$REPO/.git/config <<-\EOF &&
+	[includeIf "gitdir:**/foo/**/bar/**"]
+	path=bar7
+	EOF
+	echo "[test]seven=7" >$REPO/.git/bar7 &&
+	echo 7 >expect &&
+	git -C $REPO config test.seven >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success SYMLINKS 'conditional include, set up symlinked $HOME' '
 	mkdir real-home &&
 	ln -s real-home home &&
-- 
2.21.0.479.g47ac719cd3

