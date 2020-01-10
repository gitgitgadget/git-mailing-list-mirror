Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66390C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B3A206DA
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPI4+bGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgAJTzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:55:45 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:44045 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgAJTzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 14:55:44 -0500
Received: by mail-pj1-f74.google.com with SMTP id c31so1900315pje.9
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 11:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pazMEqCYC5HVCVu6Nv8/oOH7zuni+jq8F+SJsHXjNqU=;
        b=TPI4+bGj23qcNicFPxprNZRf+Yq4C2RLqyLMepm4L7fq2o83pPXWG7MAt8qMI345Qs
         uBt7xMryLIOHiBuOM6p2qCKVBAQqxKY1FfwrBQ6EEtC7oFh49kJlMhc58PehOMlZMTrg
         NIcVhUT87qmdComJra9hI0ikzZgk4yed+jNiUQv/4k2wGCpnvfQuqz7+cxVjJBAch4Ox
         i9VOL4Al3XmufrT3HT4fOMFilWkHI5A+KguFWTt0lhzptFdWgN51ofkEj5ykuml1/KS8
         uwfRDpqWh5MgeB79V1Xc6V70OlksFb7amkgWs++8n9PAOKX/x0aqh5bCcHLaZxQ2/Gl9
         6a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pazMEqCYC5HVCVu6Nv8/oOH7zuni+jq8F+SJsHXjNqU=;
        b=cOHDsYTsKcKuom3OsETGSqL6a6Fq+l320KAsu8P4FI/XQUHO45MzrqooFFvkzIPpTA
         t/2D/RiyjqhelVywuNNPW6l8RiWwqSaE3EHdzzNPZ5CbDItHOt/RV6qzVr7xs3XQsaog
         JftsW/GNlj5oT2KAh2cHyaqaW+qVXdLE7lGEHyeARf3E7Hd/IhNsl6OJLNEuYtOClKJM
         FAviMay9kG/GinBRbwtUmNjdc/t8JGDuZX8OJEY8sqcxuUdRve1whf5b+inj09YL0NaQ
         WRCllq170gFZUIlox+E+LUb2vNnVSoUHVV27YZcdxakXKhv6U3f4amZ6u1Itz62+/eFT
         /fzw==
X-Gm-Message-State: APjAAAXv9jmpmRoTAN4ZS3jgyPsL+W30oKTmSO3NbVfCLyk/kFOXBmFL
        U/cA4ersbaKB8EyhtLsj8JzPz/uMA+mf8fyPpxRJfPZjYcMYz8tI3jCVGvMfXFyWvHjdqDjDGTp
        zhwHx5flbPC3AWRLroFMHhD0V63/zA1sGSjkcwzHpY7XfXCasPY+QOAJJmsU2js1LlWbf4QdYnA
        ==
X-Google-Smtp-Source: APXvYqyhtORMHBFaBznlwPRS3VV54v0+EpWrJajSRS0ggWWrGXu/KwNkbDp86YxSzudXenaUR/QAB4adZKUzr6fA+cU=
X-Received: by 2002:a63:6c86:: with SMTP id h128mr5911107pgc.200.1578686143855;
 Fri, 10 Jan 2020 11:55:43 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:55:33 -0800
Message-Id: <20200110195533.6416-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] fetch: emphasize failure during submodule fetch
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cases when a submodule fetch fails when there are many submodules, the error
from the lone failing submodule fetch is buried under activity on the other
submodules if more than one fetch fell back on fetch-by-oid. Call out a failure
late so the user is aware that something went wrong.

Example without this change:

  $ git pull --rebase
  remote: Counting objects: 1591, done
  remote: Finding sources: 100% (4317/4317)
  remote: Total 4317 (delta 1923), reused 4252 (delta 1923)
  Receiving objects: 100% (4317/4317), 2.09 MiB | 8.15 MiB/s, done.
  Resolving deltas: 100% (1923/1923), completed with 101 local objects.
  From https://android.googlesource.com/platform/superproject
  [snip ~100 lines]
  From https://android.googlesource.com/platform/prebuilts/fullsdk/platforms/android-29
   * branch            a97149980b7d8acf48392af591b35689f7205d9e -> FETCH_HEAD
  From https://android.googlesource.com/platform/prebuilts/fullsdk-darwin/platform-tools
   * branch            98f9454af8ca210818eff4f502097c471d7327b5 -> FETCH_HEAD
  From https://android.googlesource.com/platform/prebuilts/checkstyle
   * branch            6fb3e23f05ed186908ea9f48d6692220891363b0 -> FETCH_HEAD
   * branch            f21d92f6339f0993a946b25fa2172c2ceb5e332b -> FETCH_HEAD
  From https://android.googlesource.com/platform/prebuilts/androidx/studio
   * branch            bed5e7b5866b8698bbcd1879134b03ac312a2ba8 -> FETCH_HEAD
  From https://android.googlesource.com/platform/prebuilts/androidx/internal
   * branch                179375220f834de5dfbee169f4c2f948d850a203 -> FETCH_HEAD
   * branch                1dcf3ceef9a86001c693fa34b3513f0c4af26178 -> FETCH_HEAD
   * branch                2ea3ccef4c98f5de1b74affd1dda33f5b2834a45 -> FETCH_HEAD
   * branch                a09de09c3814c3d31cc770d5351b92d29ea624ae -> FETCH_HEAD
   * branch                d2ae6add8b2c0e28899e4faeb2d6889ceefb0b62 -> FETCH_HEAD
   * branch                e244e2a5f7d98f47f75d06ef57ef1c6c5701a38d -> FETCH_HEAD
  Auto packing the repository in background for optimum performance.
  See "git help gc" for manual housekeeping.
  From https://android.googlesource.com/platform/prebuilts/androidx/external
   * branch              c3df2fa7f3e63b8714ac8d24f86a26cc50ee4af5 -> FETCH_HEAD
  fatal: remote error: want c5bd7796550b3742772c8fb8c73a1311013b5159 not valid
  From https://android.googlesource.com/platform/external/noto-fonts
   * branch            02969d3046f6944a5a211d2331d1c82736487f01 -> FETCH_HEAD
   * branch            9ee45fcd0b8bb8621c1cdbc6de5fe7502eff7393 -> FETCH_HEAD
  From https://android.googlesource.com/platform/external/dokka
   * branch            03a8ed966a7b847931a0ee20327f989837aaff13 -> FETCH_HEAD
   * branch            cb1684602b5b4e18385d890c972764c55d177704 -> FETCH_HEAD
   * branch            fd4521e89ab0e01447dda9b42be2b9bbc000f02f -> FETCH_HEAD
  From https://android.googlesource.com/platform/external/doclava
   * branch            04ddf3962f0cd40c81a2e144f27f497223782457 -> FETCH_HEAD
   * branch            44bf22680e939b21a21a365f6038d5883d5163c8 -> FETCH_HEAD
   * branch            66f673f4a3865f3b4ab645655a6484101dbd051f -> FETCH_HEAD

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
As hinted by the snippet in the commit-message (should I remove it? I
think it's a poignant example, I couldn't see the fatal without grepping
even after being told it was there) this manifested to an end user via
'git pull'. As I was tracking down the right place to "bump" the error
line, I noticed that 'git pull' is made out of run_command() calls, ever
since it was adopted from bash ~5 years ago. Is there interest in
refactoring it to use library calls instead, or do folks consider 'pull'
to be such a thin layer over 'git fetch && git (rebase|merge)' that it's
not worth the effort?

 - Emily

 builtin/fetch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b4c6d921d0..0c19781cb9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1857,6 +1857,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 						    verbosity < 0,
 						    max_children);
 		argv_array_clear(&options);
+		if (result)
+			fprintf(stderr, _("Failure during submodule fetch.\n"));
 	}
 
 	string_list_clear(&list, 0);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

