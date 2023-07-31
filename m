Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D35C04FE2
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGaXuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjGaXuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:50:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8515D10C7
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a4015791so45285217b3.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690847397; x=1691452197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2oPWbVuymBjneQYbPQLzD5OBULkdkE8A8kMIDx+JPY=;
        b=CUywR1ZdWISEozDr8/1kfoi+sfhQfwU1qhsAzQmgjJtA9fG8Jm9EZbVqGU2nW3UiVw
         3fTxqUwZNv6lb9APVFZGXL3RoG0WzDWECYFyE+Iq4Gr9PCrlhS6etkVlMu9Wm1GumD8V
         sgz38iIMTeCERo7RgneLBBGmCCq8DnnUQibtsbHWA5L1rEg9n8+3fKqrZiYIPmAFilVF
         FjDVSjMSNhux2VfNZ+Aqf/zqCCBYXYoS7ToxFuuQfraW0GE1Tdeklk12XqKgJkt6kAct
         eWTafo6W+ulGEH1i/C7t5/gHjTwo+E3ff0PBqI5hUJMAZHX9OCrtBbHKQ0CwYpqmBnq5
         ixYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847397; x=1691452197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2oPWbVuymBjneQYbPQLzD5OBULkdkE8A8kMIDx+JPY=;
        b=HACecg4iMsSeMBqZhep5llVJ+z2M4TbzMNziZeZsm6aodVuhWxIVUSuz7XCuqnSe9+
         esIZw9Tkto4jsUIZEqQHKfi+o+ono0XWFMrCIzuG1fSR17uj+9ikymjZjF/hHS1Fep/1
         AQf2/EDY8dhoRX1m4k1B5AhGKd64w8b4g5v7woXGJRI0QN+pZUDOx05PPIz9X+fmHjFm
         lg5qeqQs6dbDPYjUInugOHlE8G6L97ohjyd4qbDta7miPNRqQ5QpB6wgEPMXhsMo8bpl
         vwv/f9/2epH2L1mFrc2ukaj+QZcGg1Ae7vTmi46tOkbM7JXO45iNnxueNGPBbW8BUkvR
         DoPw==
X-Gm-Message-State: ABy/qLZ7oYqut5T2ryZS7ZtWrpf+/uxZC8VvfrpKjUQ1nTBWibTQpi3j
        TwKhMJeGYbtYxpOvUFZdJ9w4PklM5QqhhE4orVy8bekfZFzjo4TVsDqA+8NPwcN0fbmHSes6ygE
        8PTcv3EVfTtxyYSV8h7MdZeX4U71Ceh78izPhwm88Y80dCW73Y6FJJttZmQtO+CU=
X-Google-Smtp-Source: APBJJlGoSk+g/cvJXMZSFV5OkQ4nvWs14pS0vDGTF49FQCW1m61S8B3f+NCBaXq5eZqejZ+T/rj1h1YQ4s095A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:abe3:0:b0:d22:4059:b2bd with SMTP id
 v90-20020a25abe3000000b00d224059b2bdmr68539ybi.1.1690847397025; Mon, 31 Jul
 2023 16:49:57 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:46:41 -0700
In-Reply-To: <20230731234910.94149-1-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <20230731234910.94149-1-chooglen@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731234910.94149-5-chooglen@google.com>
Subject: [RFC PATCH v1.5 4/5] config.c: accept config_parse_options in git_config_from_stdin
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later commit will move git_config_from_stdin() to a library, so it
will need to accept event listeners.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index b6d0e16240..cf0785a258 100644
--- a/config.c
+++ b/config.c
@@ -2025,12 +2025,11 @@ static int do_config_from_file(config_fn_t fn,
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
@@ -2265,7 +2264,8 @@ int config_with_options(config_fn_t fn, void *data,
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
2.41.0.585.gd2178a4bd4-goog

