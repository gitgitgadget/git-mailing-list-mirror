Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CDE1F51C
	for <e@80x24.org>; Sun, 27 May 2018 08:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936282AbeE0Iit (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 04:38:49 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36103 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935834AbeE0Iin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 04:38:43 -0400
Received: by mail-wr0-f173.google.com with SMTP id f16-v6so249252wrm.3
        for <git@vger.kernel.org>; Sun, 27 May 2018 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iucms6tPoYrMJqZt4wIaJNjMpRHxNcN/qqXIYPmXTT8=;
        b=uGGrP8XJqeu7YPl6685tR1r/Y3RedqztkKf8msas0JRuw5krl9Hn+A/ZhkLdvWnt/d
         dCg8Djr8RGZQib0WpxgUNYBxSapCCH0yEE3xtpfuq7pCcB5Z0JsZwu9RAwsB/3nR2AwN
         yJflNKA0ud7nrMr249k8aMaZHOGF49Frojt7Ym3oVTIKENHyH2WDikDNMXFjvFNv7/+O
         i7VEyqyHy8kghGrJdDJPixHkmIktrNuhBs1cZICa7Mya8bKnh4sVRFlBsCVhYuevOfxP
         r5J2OFwyFM5iu77Yzp68WXJIKIcSF9haG9imj3m3G2Joro3umyiH+asNakI7022paval
         egmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iucms6tPoYrMJqZt4wIaJNjMpRHxNcN/qqXIYPmXTT8=;
        b=rGE7UeKXvvDLDfhBGMRB/cexIr45FURnp49QkE4uuowDr0slEac5e0WRnXpQQhpWAX
         IDBgd6302Q0adsrQcByWP3kKkYadtXeYxS6YdoBIoifWO+wYQW1s5FdXj1SUfTVObRzd
         szWoK1CJxVh/5WZX/1lwTZQsxMpDJIZ3fcqjPN2quABgBv/AFbAWkvuq3lGmdykFWMbz
         srqwfxGHm3QeZAsUB4/KsM8Dy+n17OG9frjYH52Nzt4/E/w1IRcjIEV9Egdxe9XI66lf
         0BKuklLyub0sYcUG5t3jqzfQ2kxCPgLrLido1ZUY+eVrxY2IgbHJsU92GyuCQ3NTa2ag
         oozA==
X-Gm-Message-State: ALKqPwcixSQj5nBACyys+j49xlkjVzN6OIgZvjcdtNevr+KJHZ4bu8Dp
        HAD4brQT8OoQmFnpGIgiIdI=
X-Google-Smtp-Source: ADUXVKKFqJNgN/TOEN+2b5zaPUpzWL0g9u36XR1gWjofbZ0gDFr3fxl6s42DAtdLlB/kMtN5VPweEQ==
X-Received: by 2002:a19:7b11:: with SMTP id w17-v6mr4881536lfc.103.1527410322523;
        Sun, 27 May 2018 01:38:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c1-v6sm5297468ljk.80.2018.05.27.01.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 May 2018 01:38:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] completion: suppress some -no- options
Date:   Sun, 27 May 2018 10:38:27 +0200
Message-Id: <20180527083828.6919-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180527083828.6919-1-pclouds@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com>
 <20180527083828.6919-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most --no- options do have some use, even if rarely to negate some
option that's specified in an alias.

These options --no-ours and --no-theirs however have no clear
semantics. If I specify "--ours --no-theirs", the second will reset
writeout stage and is equivalent of "--no-ours --no-theirs" which is
not that easy to see. Drop them. You can either switch from --ours to
--theirs and back but you can never negate them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c    | 10 ++++++----
 t/t9902-completion.sh |  2 --
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b3b768eff..c7670dbbfe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1119,10 +1119,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-		OPT_SET_INT('2', "ours", &opts.writeout_stage, N_("checkout our version for unmerged files"),
-			    2),
-		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
-			    3),
+		OPT_SET_INT_F('2', "ours", &opts.writeout_stage,
+			      N_("checkout our version for unmerged files"),
+			      2, PARSE_OPT_NONEG),
+		OPT_SET_INT_F('3', "theirs", &opts.writeout_stage,
+			      N_("checkout their version for unmerged files"),
+			      3, PARSE_OPT_NONEG),
 		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 07c3e3b760..7e5e3ad5b1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1245,9 +1245,7 @@ test_expect_success 'double dash "git checkout"' '
 	--orphan=Z
 	--no-orphan Z
 	--ours Z
-	--no-ours Z
 	--theirs Z
-	--no-theirs Z
 	--merge Z
 	--no-merge Z
 	--conflict=Z
-- 
2.17.0.705.g3525833791

