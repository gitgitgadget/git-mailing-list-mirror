Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F93E7D0AF
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjIUV6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjIUVj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:39:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F29400E4
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so21234717b3.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695331055; x=1695935855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvVec6cbm7k9iBEgTWmnNMO71JWPvgA81uYJ7EX831A=;
        b=GaHYdh5bQs9SnxOxIAj+l2+ielRqNcfvG0reSwz+paFri0brpPYUSHyiy2FpDJFoZ6
         B+WUwjyZZOc7+jzOqedzdRV5bCKyk/NJNWPQvOKnYaktNFHaaW85eG3V4ldS2yARCI5B
         WqCvmXESCZldWVeyFiijhKxWV0bYN6SgNlssUjyQN8s+sKGSbs8HrcRq44zM9MwhotWy
         JkdW1y5xfHtPiza28Z0Q7nTZK7H6sPj6VEhozofql1Ufv2lC8MgPiEXbrG3Kh9X+gMSB
         B/OAWerDhEA4ye7QLLyy8UMpxxp1R2i5f60FDON9vnrhLPQbh/llsS0jGgdzJPallIJE
         hRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331055; x=1695935855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvVec6cbm7k9iBEgTWmnNMO71JWPvgA81uYJ7EX831A=;
        b=hMP+Ml+TKYa1ltGauMpi0zJzJhFqBC3JhcECkM2gWcI2a6Q/thTurkrVV5uOMmwCML
         +ohMs5gZh/D/EfDSa36pc4lQ9RJc1mKvfclXldaD0kIfawNat0eSORnmx9FKppj8yfrg
         VAY0g+pJoFBrMToCEZFyfMlIQphZpH8PFEE70hnTqjMBIe+DTdGV/vxnGR7AK4O0NNuO
         Ck5GKm3xztmq/0Xid4eP7h/nD3y4OzsxzBBqGT7Rj3mHmLdGirOjPsaasuWPz02uLcu6
         4iONjxk81XYncgud39LTH0+LjNWgH5FbcBZqqKlZhUPf+q+CqnqDtCZYF41MtJoZ+GKE
         WPsg==
X-Gm-Message-State: AOJu0YzpxZ7Da0+eO5py84hJ0MFFbi57m7slZfBQShNt8xDKjmGSlEyZ
        qXxTqt+Z0cuQY+Ku176xTjML7AjzfjK0Duc9o27gimRTgRJwSsj2NbB9rTegA3CPzOHCwgwvger
        JkaCyFotBBZGchsuV6bErwPUxrTC/3702v+CJqw1VziJCEcq535qogb6jop6QVnA=
X-Google-Smtp-Source: AGHT+IF851MqmTK9CO/smWr91n0HwIdZ3Si0jUrwHND8BAKGuigbNSnhrvGQrzsq5Pku/YbGVnelZI6xonErMg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
 (user=steadmon job=sendgmr) by 2002:a81:b726:0:b0:59b:ccba:124f with SMTP id
 v38-20020a81b726000000b0059bccba124fmr94547ywh.9.1695331054767; Thu, 21 Sep
 2023 14:17:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:17:23 -0700
In-Reply-To: <cover.1695330852.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1695330852.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <49d4b649919e5661daa2113c2f5d674c5cd8dd0e.1695330852.git.steadmon@google.com>
Subject: [PATCH v3 4/5] config.c: accept config_parse_options in git_config_from_stdin
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

A later commit will move git_config_from_stdin() to a library, so it
will need to accept event listeners.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 0c4f1a2874..50188f469a 100644
--- a/config.c
+++ b/config.c
@@ -2063,12 +2063,11 @@ static int do_config_from_file(config_fn_t fn,
 }
 
 static int git_config_from_stdin(config_fn_t fn, void *data,
-				 enum config_scope scope)
+				 enum config_scope scope,
+				 const struct config_parse_options *config_opts)
 {
-	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
-
 	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, scope, &config_opts);
+				   data, scope, config_opts);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2303,7 +2302,8 @@ int config_with_options(config_fn_t fn, void *data,
 	 * regular lookup sequence.
 	 */
 	if (config_source && config_source->use_stdin) {
-		ret = git_config_from_stdin(fn, data, config_source->scope);
+		ret = git_config_from_stdin(fn, data, config_source->scope,
+					    &opts->parse_options);
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
-- 
2.42.0.515.g380fc7ccd1-goog

