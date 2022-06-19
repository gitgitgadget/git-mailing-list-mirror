Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB5FC43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiFSGus (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiFSGui (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79696E0F1
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e25so6740700wrc.13
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/zXXJ+VLNRVlaNZDh3xjYisvuWdRriNBfD/lORGYTOY=;
        b=ZC03jYmPoR/47M2SjwivGzf72vOuUG14nLX+btkhnj+33avLesyN1LfFdPepw2N+fN
         xoeHqcSBQWvJIsanNp6xRhHNt8y2H3/1gVg9mpw3CsPJWmGs0+PVyehE0vhfcpjmEefq
         FSfJFZxfULHtGBy9wTukvNftw0z7gS9lI2of2IYI0Fg0CTXeOcM5LA9o0v0lyAzF4mfc
         t2YaB+tfEO4weSajl2WmEvFipDUz+4tEFPMk1ygkI/QDwXTB/yKoTw8nZcwOvcodEpMb
         C0js5ySIcrpsVNmyJYBfslnqazhfTUd0xKKblhCZrH+qpygTaxok7hAEa914fYcbpdS3
         sjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/zXXJ+VLNRVlaNZDh3xjYisvuWdRriNBfD/lORGYTOY=;
        b=m6t7x6JwaXe4Dp9lf9yy0bpAdIS/h8P8AQIz5irFHD1bCa+9+tw+7V64VfcbmTmA5H
         CYlPgUXyvclIx961CQP8k0+B7slEq3rRiTRPV0VQCIJ6sIp/x/kDBjJGMXlQdzJ2K44E
         rXh7C+b09jpd3v835mKLvL5ftwiPnCkA9bdOhDoNfmDUMma3wvuJrkSkdocS+LXxkMM4
         yHQ73cqcacXZXBlehHfIQvZslr6WME+4dkBu1AkZTkZO0VW5b+OZBoncvw1PO5+cbpBf
         ymlAXxKVFkH6kGNPQ5faK9STBhy3OiygAjJWnYod+n1JUfRiILpKUGj/r6uJK13vUPHZ
         WnZQ==
X-Gm-Message-State: AJIora/T6eJQBN68zehiKjmBHXqvHGZwBKO0OGjsQGI8ZJaP7/0W1QSm
        VdOX/XJJOIAmqXu5Ur+W0iLXIqScodHavQ==
X-Google-Smtp-Source: AGRyM1sm0S+7cA+RUCwRcyRK9brTEwFQqaOL8xELAihioAma2G8PWkPgyM9pJyq0X00L9IivSHtvsg==
X-Received: by 2002:a5d:6606:0:b0:21b:84af:5360 with SMTP id n6-20020a5d6606000000b0021b84af5360mr6684657wru.340.1655621435744;
        Sat, 18 Jun 2022 23:50:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk10-20020a0560001d8a00b0021a05379fd3sm9218491wrb.30.2022.06.18.23.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:34 -0700 (PDT)
Message-Id: <a03075167c1f4410a1b4f415313f11a7e1c3a594.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:23 +0000
Subject: [PATCH v2 5/6] merge: ensure we can actually restore pre-merge state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Merge strategies can fail -- not just have conflicts, but give up and
say that they are unable to handle the current type of merge.  However,
they can also make changes to the index and working tree before giving
up; merge-octopus does this, for example.  Currently, we do not expect
the individual strategies to clean up after themselves, but instead
expect builtin/merge.c to do so.  For it to be able to, it needs to save
the state before trying the merge strategy so it can have something to
restore to.  Therefore, remove the shortcut bypassing the save_state()
call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2dc56fab70b..aaee8f6a553 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1663,12 +1663,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * tree in the index -- this means that the index must be in
 	 * sync with the head commit.  The strategies are responsible
 	 * to ensure this.
+	 *
+	 * Stash away the local changes so that we can try more than one.
 	 */
-	if (use_strategies_nr == 1 ||
-	    /*
-	     * Stash away the local changes so that we can try more than one.
-	     */
-	    save_state(&stash))
+	if (save_state(&stash))
 		oidclr(&stash);
 
 	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
-- 
gitgitgadget

