Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641F0C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F08120658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmJFTHVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgEEKxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728802AbgEEKxi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10158C061A41
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z8so1253268wrw.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alFiRVZxX+n6jVXTeeoJZLpH7aeQCl4VkSj9GFGZ5AE=;
        b=WmJFTHVWyJ2G6FpzdrN58r+tW9w2XMeOfqAayAMSVtvGXzAfCjh6J4jQ7gpVykKWBu
         ISowRtutOGezFaaabYY5Pr0TOyp+PQ4TqdSNrAYDyOdhs7lYneffeKQjLsL8OjUHfc2N
         2zprlGucerdgDUySUpox+ztkeQYUfIQLDoha2KCXQaxHf+A6aHmkO7js3CtsLKb9XxkA
         eLUy48DZGMZfVL6ASWFKngKde0f7Zdmjk7qc85Vgq6FZ9ATgsBdQqfLmQDdQbrAHE5Gg
         6YFtOHhSasA7XVw8BxYRiJUVt/HwLtcQIVI6ff0pTokWyRQ8m0bTYipo63nHN4beAB49
         S2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alFiRVZxX+n6jVXTeeoJZLpH7aeQCl4VkSj9GFGZ5AE=;
        b=ctKYstQcZ3NtlGHbmX3CodBBb7BJpq9WvRErAnixCDnz9idcoouc/RyMhknSNIFeUv
         DKF5LrBVbaSk0hihu2mi4Mah3VGQvLa3M2ZFQGm5gxeds1slNy/pukiojX9TwDPHV9bh
         oxU+RTv3DCUqlPuxg4nuQgsxY6Yx3R1+35+ACgsX/GR5wsc2IsUIImesH4kALT9PUvxa
         sqyGThZKL8d2eilq7SjEUsXvYx1Q8szqZrBLzYWrBNGbYQTxfrvA+c5Gk5Et2WZNDY8T
         WcgjlAgWSZczD9r0eL+G0UGL7GWUI+aFCL2fUohWbaasdx8IMRtdBJY3luOIHShRueMJ
         eUiQ==
X-Gm-Message-State: AGi0PuZLtZiWH1Gi7VeGkQ+gXEzcwOFcy+hYl/7lY00a0cCtOXBZg0pu
        8kx/TjXSjcr4Q7gAx6ocbM1JpJns
X-Google-Smtp-Source: APiQypLwbXjkv7NdyYO7zxIXsWQt/B7j6e67eInJBpvj0npAVl/TabBW+eGvzCQQ9F/usK3tPSi+6w==
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr3296622wrh.179.1588676016560;
        Tue, 05 May 2020 03:53:36 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:36 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 6/6] stash: remove `stash_index_path'
Date:   Tue,  5 May 2020 12:48:49 +0200
Message-Id: <20200505104849.13602-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since stash no longer uses a second index, `stash_index_path' is now
unused, and can be dropped.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1eafc1fe8d..709fd5ca34 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -88,7 +88,6 @@ static const char * const git_stash_save_usage[] = {
 };
 
 static const char *ref_stash = "refs/stash";
-static struct strbuf stash_index_path = STRBUF_INIT;
 
 /*
  * w_commit is set to the commit containing the working tree
@@ -1506,8 +1505,6 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
-	pid_t pid = getpid();
-	const char *index_file;
 	struct argv_array args = ARGV_ARRAY_INIT;
 
 	struct option options[] = {
@@ -1524,10 +1521,6 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
-	index_file = get_index_file();
-	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
-		    (uintmax_t)pid);
-
 	if (!argc)
 		return !!push_stash(0, NULL, prefix, 0);
 	else if (!strcmp(argv[0], "apply"))
-- 
2.26.2

