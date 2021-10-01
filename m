Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30498C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155E461A6F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbhJAKGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353235AbhJAKGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFCEC06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h15so12987662wrc.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=adCRBqCVvXxlRTRcD+OFfeQu6DbMvFmosaVnzgCDr5A=;
        b=JIAAL0ilzNQLD/sFASLFCAjl6hyFf45SUHJ5aGjE0ukJxku7SfENScGutLVI/Cubku
         JhOcVTABFuXSW0ok68zpAdH1oaQFBQC0bB8AWtEVFn3VLAm2f3wuRfsKhbWekxUQJSFw
         OhyFp3/B9MLeqnhVyNmdgnQvUvl1+gXLDW4cH+D1RSIa5E73yqF6z90n0PmdI94e4DDK
         rrWyNPVrO8Hsem4L+4DLz7qZwv9SbyJMgak9DzLnc2qYEmNkWBhUgQ6ksbU8otlJpuT1
         Y6GMVPmAgMOny71vA7Km6PxZPDTwpr0KjWKOh+8RLQFBIGlw4GteFQV6ACsiKooqxVMY
         TJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=adCRBqCVvXxlRTRcD+OFfeQu6DbMvFmosaVnzgCDr5A=;
        b=XJGZLzkL4vJmhliXLI8KvNgiAw2GoAFYm0n7ZqjK1NL78YMpMfAyVW8e09o0vzvZzI
         uqgBDAOZyCeb6aCc695/AQQHmtjM0isWOuR+smoZ0Fr4XKSJiDSDYfx7Qt05UjDXV4og
         KTwfgJCIHXG4gwoM9xT16R8AGiqUw40cf2ua74eSWB5nXWZAhqqVDYSVYG+5PPTwlHeO
         5zKsBEESwuHettgvCADsoRA4dIo6OX/xNDaJg3BQvyTO8ZU3peljnhJbuEfEXoMl+cPc
         4huLixcO7G7hPUUqvWp9eMdEUuud4O0fv2zqvRo2zJeZODrvTPp9UwWQL6CjGKxMm623
         H72Q==
X-Gm-Message-State: AOAM531P3DdJ9j2S4yqVqaE5k7TpAAbYc0/uLAHOoZ6kP5vUxdTwIvDi
        hdFibtQGvG3BIxfcSFECR9jyZvP9tkk=
X-Google-Smtp-Source: ABdhPJyUA0MvIPMhvcvFIG/N4laIOE3bqfOYFdUEVifGter8W11BLEdjGkZo26iNFDJu/352rh7AzQ==
X-Received: by 2002:a05:6000:1a8b:: with SMTP id f11mr2834877wry.251.1633082704672;
        Fri, 01 Oct 2021 03:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm5350287wra.52.2021.10.01.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:04 -0700 (PDT)
Message-Id: <4d3441c2b2571b91cecca7c28232540b9aaf9993.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:52 +0000
Subject: [PATCH 01/11] rebase: factor out checkout for up to date branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is heavily indented and it will be convenient later in the
series to have it in its own function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f82bfaed118..f4c312dd8b5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1099,6 +1099,23 @@ static int rebase_config(const char *var, const char *value, void *data)
 	return git_default_config(var, value, data);
 }
 
+static int checkout_up_to_date(struct rebase_options *options)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addf(&buf, "%s: checkout %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+		    options->switch_to);
+	if (reset_head(the_repository, &options->orig_head, "checkout",
+		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
+		ret = error(_("could not switch to %s"), options->switch_to);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 /*
  * Determines whether the commits in from..to are linear, i.e. contain
  * no merge commits. This function *expects* `from` to be an ancestor of
@@ -1978,21 +1995,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!(options.flags & REBASE_FORCE)) {
 			/* Lazily switch to the target branch if needed... */
 			if (options.switch_to) {
-				strbuf_reset(&buf);
-				strbuf_addf(&buf, "%s: checkout %s",
-					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
-					    options.switch_to);
-				if (reset_head(the_repository,
-					       &options.orig_head, "checkout",
-					       options.head_name,
-					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-					       NULL, buf.buf,
-					       DEFAULT_REFLOG_ACTION) < 0) {
-					ret = error(_("could not switch to "
-							"%s"),
-						      options.switch_to);
+				ret = checkout_up_to_date(&options);
+				if (ret)
 					goto cleanup;
-				}
 			}
 
 			if (!(options.flags & REBASE_NO_QUIET))
-- 
gitgitgadget

