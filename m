Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7DCC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 00:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiBXAHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbiBXAHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 19:07:54 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0C4755D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:07:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso2542185wms.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=99Y1F33sWLPoo2ATKXYXx99x5DGhpjJKHUTjaB256JE=;
        b=cXGxO2m1cw07RAB8eRTFNUWL5luRE9nGWeRqKxskAnnPcTE1OpYq9iYeZ4Wu7uZyTg
         RHM9QI6vb3svBf/jRyeldDw7zSHa7EHZyNawMcLKZLZhot8VbpTtE50svV3ylOFNXACM
         XqIJsAp2a/aRZ2To36Or7LYno29dWq/TMrtQe5ehEKMcj2jYpShpx4Kn2L9cYkvn/vIz
         7Y5W4xGuJ6w8vS9CKkr3k2DhxsTYfMlHGunxTC5p0mLgmslPhWfB18LEx7JNsauqwSrA
         pilNG2sPSwYp1xJJrIJoMkzG4MxNC2FsvJ9wS8ORZTmXtWNOeDPUZ9MJd+3x5EeIcTkE
         ZZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=99Y1F33sWLPoo2ATKXYXx99x5DGhpjJKHUTjaB256JE=;
        b=BMvpWQ/XCKsCxKDImBa7T44JtKCzLNyCjWvAJQ893Nc3FQr4g2CBwS23FRWe5RN5i4
         5tSI6uyxKpYIoTuUawCFBwNxf0KCEm6O3fCsMVICLxK5SJcqgAIyNKa1nq0cFmobxPb3
         pqzNfp3GTPcfbQxsrqasxCnNS7pZFzHWzS7zV69S+wInsarKu5l6XqrwEmgnJVjFq0AW
         RVq+K+IXI+q6fhZkmwMHI7DPX6D8K2XyEbifqsU0VK+KBd0IQc2KJgSx5cLKKWxWqKNT
         9Sos/kK0AsxyIveK4yQ37G0HAYgNZOIzAwuFe0oZYhNhn48l/ykWOFzve7k1QNDBAEuJ
         vzMQ==
X-Gm-Message-State: AOAM5316tPC6nNHQHMeBw/PmImlcDd7qbwXYKU1mEc9wzJdrVqeTycKA
        4/ltBmrnDjjL4ZVwwNn4qqw2BRDDVRs=
X-Google-Smtp-Source: ABdhPJyJYSWy4H/GMieVeV9TvZ9gfE8bNi5+i7I1d7Mv/ApV3pnsQdozL389GzObgyWjxlSejLtCQA==
X-Received: by 2002:a1c:7906:0:b0:37d:25c9:1c2a with SMTP id l6-20020a1c7906000000b0037d25c91c2amr9328359wme.112.1645661241742;
        Wed, 23 Feb 2022 16:07:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm1143003wrc.52.2022.02.23.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:07:21 -0800 (PST)
Message-Id: <pull.1158.v2.git.1645661240356.gitgitgadget@gmail.com>
In-Reply-To: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 00:07:20 +0000
Subject: [PATCH v2] index-pack: clarify the breached limit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

As a small courtesy to users, report what limit was breached. This
is especially useful when a push exceeds a server-defined limit, since
the user is unlikely to have configured the limit (their host did).
Also demonstrate the human-readable message in a test.

Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
---
    Specify the actual pack size limit which is breached
    
    Git allows configuring a maximum pack size. GitHub (like presumably
    other Git hosts) configures this setting to a generous but finite limit.
    When a user attempts to push an oversized pack, their connection is
    terminated with a message that they've exceeded the limit. The user has
    to find the limit value elsewhere, probably in the host's documentation.
    This change adds a small convenience -- specifying the limit itself in
    the error message -- so that users no longer have to search elsewhere to
    discover the limit.
    
    v2 squashes the changes into one commit and corrects the commit trailer
    misordering.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1158%2Fvtbassmatt%2Fmc%2Fhumanize-limit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1158/vtbassmatt/mc/humanize-limit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1158

Range-diff vs v1:

 1:  a2eb3956f3e ! 1:  abf21ec109a index-pack: clarify the breached limit
     @@ Commit message
          As a small courtesy to users, report what limit was breached. This
          is especially useful when a push exceeds a server-defined limit, since
          the user is unlikely to have configured the limit (their host did).
     +    Also demonstrate the human-readable message in a test.
      
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
      
       ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static void use(int bytes)
       }
       
       static const char *open_pack_file(const char *pack_name)
     +
     + ## t/t5302-pack-index.sh ##
     +@@ t/t5302-pack-index.sh: test_expect_success 'index-pack -v --stdin produces progress for both phases' '
     + 	test_i18ngrep "Resolving deltas" err
     + '
     + 
     ++test_expect_success 'too-large packs report the breach' '
     ++	pack=$(git pack-objects --all pack </dev/null) &&
     ++	sz="$(test_file_size pack-$pack.pack)" &&
     ++	test "$sz" -gt 20 &&
     ++	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
     ++	grep "maximum allowed size (20 bytes)" err
     ++'
     ++
     + test_done
 2:  43990408a10 < -:  ----------- t5302: confirm that large packs mention limit


 builtin/index-pack.c  | 8 ++++++--
 t/t5302-pack-index.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..c45273de3b1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -323,8 +323,12 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die(_("pack too large for current definition of off_t"));
 	consumed_bytes += bytes;
-	if (max_input_size && consumed_bytes > max_input_size)
-		die(_("pack exceeds maximum allowed size"));
+	if (max_input_size && consumed_bytes > max_input_size) {
+		struct strbuf size_limit = STRBUF_INIT;
+		strbuf_humanise_bytes(&size_limit, max_input_size);
+		die(_("pack exceeds maximum allowed size (%s)"),
+		    size_limit.buf);
+	}
 }
 
 static const char *open_pack_file(const char *pack_name)
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 8ee67df38f6..b0095ab41d3 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -284,4 +284,12 @@ test_expect_success 'index-pack -v --stdin produces progress for both phases' '
 	test_i18ngrep "Resolving deltas" err
 '
 
+test_expect_success 'too-large packs report the breach' '
+	pack=$(git pack-objects --all pack </dev/null) &&
+	sz="$(test_file_size pack-$pack.pack)" &&
+	test "$sz" -gt 20 &&
+	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
+	grep "maximum allowed size (20 bytes)" err
+'
+
 test_done

base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
-- 
gitgitgadget
