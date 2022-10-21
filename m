Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5DC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 10:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJUKfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJUKfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 06:35:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C7543C5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:34:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so2191070pfh.6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aAobGoIzWPlNDc/ptdvTjP8a3x9x5OiKfaYusyQTkA=;
        b=CGYsDgIsQou6IHfuIBBPcPTZJVrifOOXFvKO7xOHjApksnuWiaad9D7dZuEf2pzwU3
         pdfrmcafyl7CPB61Rg8rB0oxbhaNuAuNKUqGslvCH1SwA3wOh93z3KZ4IbKn2g36VsKf
         m2fXdkIHOgCE6PzMHGca1T5AlTJGDw03T/98sHGro0kkshi5E8EH7k8QefyXqhtLdB/g
         QJjiDbLUJ5X8C3w/DCQk9A/80OQ1DpxwxFZBAhY23t+d/rRXQqsu/UIbbfKUPvCj8UU1
         DD40FziqvJzCMId+lcrgPpeXsXN9yLWYnk8sP0+Ick1vchFvQx6g/FxzDJtEn+Cvx1Y8
         eZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aAobGoIzWPlNDc/ptdvTjP8a3x9x5OiKfaYusyQTkA=;
        b=zeceSUswEHgVIlGsFBtKaJ/j1JGlhQlnygpIFSaFUXNCcVtJqoLfr8737y2iOHy23v
         qmhsyV9xQRnmx9tkkT6Np3NmYcTqHxImkMr7cbysI3aIi4Ub0K4WaUkqy2Judib+0nHg
         HxUXD9VKpVzExl4YiLVMCyBWM9UTM4KyUdrY3vajGygrMY3TSpyFuM9HD2oJ7tIyi7zm
         nzsbNppOJVhGdZz+hZp7LWK+So2PCVX6IzydgtXhvNyNGgaMfD6Q1nGpdqwUtffPGrFg
         56LfXJDpNdAwK3HDR5rA0jOsEanKnim6iLlZxes1a3qmY6Jj2j8z2un/GuBn/Ntp06b0
         ctcA==
X-Gm-Message-State: ACrzQf0WdqNHEY/hykoEeq14eZvQ7fxv5t1rXYlLXCSRj7EYHnC8GboO
        CqNTPiAr3T22JYHy03Tgi0fgK1zvHd5e1w==
X-Google-Smtp-Source: AMsMyM5vPNYkCeH2n75wz8ESs04LcwVdLhop9ZHfOzZdf3GtJY+5bqfiN2KTR7H/ePZfjOHnwCJ22A==
X-Received: by 2002:a63:f214:0:b0:461:8862:331e with SMTP id v20-20020a63f214000000b004618862331emr15600262pgh.386.1666348490569;
        Fri, 21 Oct 2022 03:34:50 -0700 (PDT)
Received: from HB2.. ([122.171.202.28])
        by smtp.gmail.com with ESMTPSA id x184-20020a6286c1000000b005622f99579esm14895544pfd.160.2022.10.21.03.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:34:50 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Date:   Fri, 21 Oct 2022 16:04:41 +0530
Message-Id: <20221021103442.202759-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.84.g1cc2920221
In-Reply-To: <20220923193543.58635-1-siddharthasthana31@gmail.com>
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command git cat-file can now use the mailmap mechanism to replace
idents with their canonical versions for commit and tag objects. There
are several options like `--batch`, `--batch-check` and
`--batch-command` that can be combined with `--use-mailmap`. But, the
documentation for `--batch`, `--batch-check` and `--batch-command`
doesn't say so. This patch fixes that documentation.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---

This patch was previously sent as the first patch of a 3 patch series for 
adding the mailmap support in git cat-file options:
https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/

Changes in v2:
- Fixed the names in trailers in the commit message
- Updated the documentation to clearly state that the `--batch-check`,
  `--batch-command` and `--batch` options can only be used with
  `--textconv`, `--filters` or `--use-mailmap`.
- Fixed formatting

Changes in v3:
- Fixed formatting

 Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..e2a179770c 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -89,26 +89,45 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin. May not be combined with any other options or arguments
+	except --textconv, --filters, or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines
+	  must specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object if the identities recorded in it were replaced
+	  by the mailmap mechanism.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin. May not be
+	combined with any other options or arguments except --textconv, --filters
+	or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	 specify the path, separated by whitespace. See the section
+	 `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object if the identities recorded in it were replaced
+	  by the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
-	the path, separated by whitespace. See the section `BATCH OUTPUT` below
-	for details.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
+	`--filters`.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	  specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, the info command shows the size
+	  the object if the identities recorded in it were replaced
+	  by the mailmap mechanism.
+
 +
 `--batch-command` recognizes the following commands:
 +
-- 
2.38.0.84.g1cc2920221

