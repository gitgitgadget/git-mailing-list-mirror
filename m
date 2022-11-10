Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C9DC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKJQhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKJQhi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223D832B88
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p12so1827284plq.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r84yb9B+VjOJ0z8P6REjPJm2qAdqyEJzOWMCwpB6cGU=;
        b=n2txtFoGbkKekiEA0PXgF2vN3m4M6RKcT8cDXs6IW7iATk9JaXlrvSJ6I3601SqWqK
         Hlx4pDV/VAgoCYr8LG6cfuCJUhllhz+J9gYsRHfBzB0MeFZ61W9AvA8tzvKwBJT0ZRC1
         dUObgs3OxfZtvCoZ+nmDh5WPAfcQ1qvCVSQSKyyp6pweDjlNQQFHSRpw86qWeT59lZcS
         yG6rsRURyCs1tXMOr+iv6UQ+PC27ygn3HVIg+vudTR4qB6VhNkcEUwJD9eJSgufH4VPk
         g/blEzvWcr8B/8KCU+CTcBnq+fCHXqsRnvTEEneNVsKtpEsjpS9UAynngep+o2uqKxzJ
         G+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r84yb9B+VjOJ0z8P6REjPJm2qAdqyEJzOWMCwpB6cGU=;
        b=mmhQx5yonTYqMvGzStiEE51st2hMa4cX2/BBiFLnmUXJElAz5SFE/ngIDOuWOfdJDN
         TfSDVmN0L147V/8+cLgYacxsoBPi3mdbAPYGZq885ybqksZrHDmrX5/QdZPw5IWqhuay
         TpXck41KwCdahjL9LiSrVMVDeiBfy2KdSzZ7WBwchRldnuBue0+uyatNujeGGNXub/HK
         sn9mLj6K2mhN6Ct/mVjdYewtEBBuCI5BD+fvclsQBnG3iDz23ZwCvdUwGT0bAn7HMBXb
         1l5uaKizABvx1o1EUs7oamNhKrZ8T/VoCq/GAQyTZzLYuqGF4Z/Or2/38WLn9LAW7El/
         /PGA==
X-Gm-Message-State: ACrzQf1APAkcRuWW5Wv5tHHQi6hExRVYbakP0f5tksYirBo1q2DHQ1su
        iyuEeqZnrE99R2ZVZ5V1U8f4mq3NC4s=
X-Google-Smtp-Source: AMsMyM4dJcUflyf3XlHjKErRU9Q0k6rVfGKVJHnvomzlPPpMClZrPcaAVsOkNw301c8a6rKIDwryXA==
X-Received: by 2002:a17:902:e891:b0:186:c544:8b1e with SMTP id w17-20020a170902e89100b00186c5448b1emr64114597plg.163.1668098252331;
        Thu, 10 Nov 2022 08:37:32 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:31 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/11] bisect--helper: log: allow arbitrary number of arguments
Date:   Thu, 10 Nov 2022 23:36:45 +0700
Message-Id: <de3075eff9ffffea27d19e749af897b72f83ef41.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we would like to turn bisect into a builtin by
renaming bisect--helper.

However, there's an oddity that "git bisect log" accepts any number of
arguments and it will just ignore them all.

Let's prepare for the next step by ignoring any arguments passed to
"git bisect--helper log"

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 4 +---
 git-bisect.sh            | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 29d5a26c64..6066f553fd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1347,10 +1347,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	return res;
 }
 
-static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
+static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED)
 {
-	if (argc)
-		return error(_("'%s' requires 0 arguments"), "git bisect log");
 	return bisect_log();
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 9f6c8cc093..f95b8103a9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -57,8 +57,6 @@ case "$#" in
 	case "$cmd" in
 	help)
 		git bisect -h ;;
-	log)
-		git bisect--helper log || exit ;;
 	*)
 		git bisect--helper "$cmd" "$@" ;;
 	esac
-- 
2.38.1.157.gedabe22e0a

