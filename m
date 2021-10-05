Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51346C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CDA6137D
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhJEAVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhJEAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 20:21:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA93C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 17:19:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 1-20020a630e41000000b002528846c9f2so11487296pgo.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 17:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R0UM0y3VANSODiJSxNqFNYon7P2nOX2ZRqfL2OtIsqg=;
        b=awTbRiysNVjRgHTDYtZrEiq87zxxcOmuoEv+Ls6XVACUPasnvonDDc65AkndZszgxJ
         yLg8LrttSsdy5BiY751HlHf0RMvJQcE8w6ukkJZWM6vJBeXg8cp/MWGS7SNvro+LQnvw
         +NZSKDJwlMluGr9BvS/HZwyqeEvavZyOFRnR/hqHKDlFd6hHPLh7Fs2roDSPSmhOXEZg
         RcGT5SNbkeAnaRvGzl9XsvRpxI0t5pSEBE/MpmmFk7Z3nIC/6s2pcqX1XDfdXmmocvHQ
         j3Qt2kbTZCy6b4OC337CS30auy9ykpAyWvK0KrXx/CqSHlLl7fTtjGLScC2a4mCj5Yv6
         pgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R0UM0y3VANSODiJSxNqFNYon7P2nOX2ZRqfL2OtIsqg=;
        b=PYMVa6/V6HUSgoH7rrySO4XB3B6YZcEwdtjWZ0maYjVcMOnA9aLRab7JzoSN2gNZ4m
         lxkfi0EpnZU5UL7dFrQwo2kSRV3zj/hAgda4BaQjue+bcRw2cBhro86gqj2r4mzc/oYG
         rNvhyiPHvEqYekjVZ28nL5i+8qAhJodi/j0sw0AQAVI+GvnAHA3Qc324fcvVNxvw2y6g
         rbPNNNUB9fL4Mh3wlEy6RkTGfxpvRgcH76ey3GdznjQA6SRrCJOgbr8eb4J2vC3314eh
         ThU3anrgWIBETkTG467z/ZjqCDvJf0qG8UCZS4Hl1d22o5mawF0dDcrhT8CdyoPdLgnc
         /Oog==
X-Gm-Message-State: AOAM531maQHAkJ6sqA3WszEcYe/Bn1w5w6M5i3nH+LBsI/x4fonpfcrZ
        dWafmgO6O9K79XqBvOslvcCbpZ0M+TkfU5eO2o4gLti8LXiIPcbtI5o2iSrprK8WBKnmasIWOoP
        9X+dIINouc0WDwO00oqQpiZ8iytc4e05yroRT322QLucPocIvTaDVWinQkRxnI9w=
X-Google-Smtp-Source: ABdhPJzRfXygzPrNMM4q4zCylV5ko/35OUC7EU5IUYWayTjGi26zecZbphERy7VenEyAw5bgWwRv16Hr0hnDnA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8609:0:b0:44b:346a:7404 with SMTP id
 p9-20020aa78609000000b0044b346a7404mr27619155pfn.86.1633393193555; Mon, 04
 Oct 2021 17:19:53 -0700 (PDT)
Date:   Mon,  4 Oct 2021 17:19:30 -0700
In-Reply-To: <20211005001931.13932-1-chooglen@google.com>
Message-Id: <20211005001931.13932-3-chooglen@google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com> <20211005001931.13932-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 2/3] fsck: verify multi-pack-index when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like the previous commit, the_repository->settings.core_multi_pack_index
is preferable to reading "core.multiPackIndex" from the config because
prepare_repo_settings() sets a default value for
the_repository->settings. This worked fine until core.multiPackIndex was
enabled by default in 18e449f86b (midx: enable core.multiPackIndex by
default, 2020-09-25).

Replace git_config_get_bool("core.multiPackIndex") in fsck with the
equivalent call to the_repository->settings.multi_pack_index.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c              | 2 +-
 t/t5319-multi-pack-index.sh | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1c4e485b66..5bbe8068ec 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -925,7 +925,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (!git_config_get_bool("core.multipackindex", &i) && i) {
+	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3d4d9f10c3..53958bfd1f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -407,7 +407,10 @@ test_expect_success 'verify incorrect offset' '
 test_expect_success 'git-fsck incorrect offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" \
-		"git -c core.multipackindex=true fsck"
+		"git -c core.multiPackIndex=true fsck" &&
+	test_unconfig core.multiPackIndex &&
+	test_must_fail git fsck &&
+	git -c core.multiPackIndex=false fsck
 '
 
 test_expect_success 'corrupt MIDX is not reused' '
-- 
2.33.0.800.g4c38ced690-goog

