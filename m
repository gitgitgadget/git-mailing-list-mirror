Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5925520248
	for <e@80x24.org>; Sun, 24 Mar 2019 13:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCXNS7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 09:18:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38233 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXNS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 09:18:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so2582092pgl.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwmEEN574nan98fVlGfgoLop/HYgHEouRShzYaBPQsM=;
        b=szzmCApmuzGnrKPw+8qp1TF2EtbI2+Ih/kZVoDaJYQ4PHrYfKh3Sg/Xq6aGrhAfJkb
         3KQWASHwlS5Fl7nlOk6E8eFxwx1YL+3Zrhw5QvjHR2SGECltmY1Ifpqf/fRP1ANBYnYy
         GBzVKxaI+HhmEO9+vPlP+3UV2kgHALjvvvOJJDIQsoUELpCqihz8Wn9UqjbSwoO830aI
         8xPueoRry4iz0qp+5EYi+FOF0zaA3rIA/b0OflUCXjFtiIJxd3b36ASC1aQMo0bxNowt
         +2n6PsyZwfHSrI+QYrHBbZpgaeUrC1oR0LlGSa1TzaC9jcLWQIMCCsRpD9RHvyQE3fkv
         hjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwmEEN574nan98fVlGfgoLop/HYgHEouRShzYaBPQsM=;
        b=lLj+5pCb3gn22RYVeV2sNdysEloEBGN0urhxjTxSGIaAJLfKE+BsuDHv8suZTcvjPY
         FVpk2GpxX8xU8LwgXIOnBBI+7aLRqP1d9rPGXRFARYggIocwJCd1+Y2k6L+gHIR2TK4C
         MeDZ+QjrrKDk13U5rZspP1lOF7FRqDxmV75mup3FtG06OldaZlF1uThRW1vTD8XtfEDU
         7aGRJOMZqY1K/GTy3zkE2YyyUrW2EJV+aYPmNor7ZQx/tNSPeOVXQ0rJxW21ePRiPkak
         xfHPg3XV7Ufj8+/coBNwmvAyyoKwqQJeWGqPmMk/SDvf/xEzrRugeD1CZAsb1tpIm1OU
         vFZw==
X-Gm-Message-State: APjAAAXDoK1weTDtH5MIJqYZDX9Aoflj8D9/2ErEjabNqghnF4404kKD
        +LD+R1F0wTtb1Qhhk0lnjsY=
X-Google-Smtp-Source: APXvYqz6giTmUrR+FF4v9jo420cvClwos336M0MVm7BACFH5QZNr3XpTUDti1VyzvCn9G/vlDtelsg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr12868415plp.74.1553433538245;
        Sun, 24 Mar 2019 06:18:58 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l80sm1352717pfb.60.2019.03.24.06.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 06:18:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 20:18:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jason.karns@gmail.com,
        me@ttaylorr.com
Subject: [PATCH v2] config: correct '**' matching in includeIf patterns
Date:   Sun, 24 Mar 2019 20:17:55 +0700
Message-Id: <20190324131755.26821-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190323034535.23364-1-pclouds@gmail.com>
References: <20190323034535.23364-1-pclouds@gmail.com>
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
 v2 adds a test. My laziness can't get past Junio.

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
index 635918505d..4d6e70c11d 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -229,6 +229,19 @@ test_expect_success 'conditional include, early config reading' '
 	)
 '
 
+test_expect_success 'conditional include with /**/' '
+	mkdir foo/bar &&
+	git init foo/bar/repo &&
+	(
+		cd foo/bar/repo &&
+		echo "[includeIf \"gitdir:**/foo/**/bar/**\"]path=bar7" >>.git/config &&
+		echo "[test]seven=7" >.git/bar7 &&
+		echo 7 >expect &&
+		git config test.seven >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success SYMLINKS 'conditional include, set up symlinked $HOME' '
 	mkdir real-home &&
 	ln -s real-home home &&
-- 
2.21.0.479.g47ac719cd3

