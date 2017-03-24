Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819E61FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965068AbdCXSlz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35860 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964821AbdCXSlx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id u1so1658366wra.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRzauk5W0c4i3AtDmB1tB3FNvj5mK7aRwx6rTnT6lcM=;
        b=nsIxPBkPVZ3Tun60jp/RxCa8aebsDoey1sRe+feqB5XQWi0thlKm3HL2ZDjqNghZSr
         IWEHW9rnHIlzq6FWXlAXBegF2WEZMDPmY7qQUozWUkAjl/4fWzRAMbG3H9UqWeCkVIB2
         gzPt9qLuAZtNkrjNPN2XidA5FO0HJnpxKOiDvtMSEpkfokKG/IuiOD0g0aXZ3Tg5z7VD
         xU68cpXYsuADYym0Vaybmugv1P9eEyL22d5YEaSvriWlwKCP5/KTMXhdLrgoUs6C5zQq
         dYnFTfA8yeepI9Nv4XI7g2nN52TyzjaFBp7AINIv2LCaKvIpoybBQZTUirAQkqRHjMl+
         lrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRzauk5W0c4i3AtDmB1tB3FNvj5mK7aRwx6rTnT6lcM=;
        b=NBKwJ4G0NIl3wN7NUZDumDelkqb3jBeAxS8R1wRqR/Wy5NK9qgNl9LSeOZBQnsB6jL
         YdfEhq4yggxhHtqNZUoBV4Epe3OudQ6AAHJi+5zZa0/ui1P+sU2HM5rbt0v8C+jw+I2N
         6oiW3DIozYNnNIXgxHiyblydl0dIIMJLQBhklyWpzni3RsXe291ehC3X4tGVCZJcxlMA
         beUr5OQ626ey3nJFnUyy6G5hglf1boyXgmBV6pzFCvM516isL8fkPddmOYyth6i/an42
         oDg1U5VvY/WT6kud8wD80ZZ7KAGdKEVT85RnEq6t0UIo+7njyzI7q5cmhhy01F/6LhNd
         VcbA==
X-Gm-Message-State: AFeK/H3FkxDXZtsXjATuZQwthP6FxsF17D8iKrOfA+p3vqaYkkUliZub2s0sqcx2/9ezkQ==
X-Received: by 10.223.164.85 with SMTP id e21mr9257123wra.58.1490380905319;
        Fri, 24 Mar 2017 11:41:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/16] parse-options: add OPT_NONEG to the "contains" option
Date:   Fri, 24 Mar 2017 18:40:53 +0000
Message-Id: <20170324184059.5374-11-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the OPT_NONEG flag to the "contains" option and its hidden synonym
"with". Since this was added in commit 694a577519 ("git-branch
--contains=commit", 2007-11-07) giving --no-{contains,with} hasn't
been an error, but has emitted the help output since
filter.with_commit wouldn't get set.

Now git will emit "error: unknown option `no-{contains,with}'" at the
top of the help output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index dcd8a0926c..9f48f554ba 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -258,7 +258,7 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 	  PARSE_OPT_LASTARG_DEFAULT | flag, \
 	  parse_opt_commits, (intptr_t) "HEAD" \
 	}
-#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
-#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN)
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
+#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 
 #endif
-- 
2.11.0

