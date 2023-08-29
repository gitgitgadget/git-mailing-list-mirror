Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A822EC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 00:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjH2A4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjH2A4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 20:56:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FB12D
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 17:56:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cb845f2f2so54189157b3.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693270569; x=1693875369;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+exErM7WlbDCwcYVI/Kh1ybLgmJ+atJwvohyvzwbrnc=;
        b=ppFmzXMuHF4gkELhBOTE83I9ji1Z00pHg4WWCdhO5AWMozZnIymKVTsL29iLJncVq5
         dx8Pnu6qDE/sRqGxds3iclPfbzyRUupBkghvIeZWRtqtQ+JshCsGV/dm8GiiHjL6fdG6
         JiUBsj/GWPQ2nQdz5kFB8/tQTlE3Gm38IRjb5uIG3hkoDEy0Cf86n2qxfpDv/PW0ttqW
         edN6vVLU06YqLbN3Ofix8qHg6yRJ4Z1FMaSgRgCfLo3/cLHht41+UiDclNs9gAc/49/6
         FpAZNZxLAnhJE3WXqZUjZnm0rWymWg28iUe6rP2eWY+yDRfiK4qpWDezTijJf1z3PStP
         Xlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693270569; x=1693875369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+exErM7WlbDCwcYVI/Kh1ybLgmJ+atJwvohyvzwbrnc=;
        b=aHrrE5pP9dqO6GvYEJ62VF0N9zRE4IVe1LLfRJNVRNCewhp2mCcmhAK0JQA9KfP+rc
         7vkYm4e+U2WgAYoGCdgrhs3NhRZ+TjsW8Ohv4qVfkBETgYH2YzFVOjo+/Bvd4Tc/jXaY
         9QQSGet5jQzGkjFHLJMhU5sqCmzgQSvZXowLlSR0M5KiiB7VjOAGUOpuPsJmlzQugJf1
         Sp1WShKrEbRJN6EUz7OoioV1lKO6XkjoVGy+hlVD4AF9YzuXiutzjMr/0k54xq1dSJeG
         ftc29X/L1KwxNeGfanRPc4cFmgu89QonVANfDQmkPfkTQyv4Y5Re0dTZxUb+7gdFdQB7
         RxGw==
X-Gm-Message-State: AOJu0YzRlICRUWI2tKA+gV71e6x2rxxyidRl1qavwwALdvdM9V6eCcWE
        6ZkURcI/61ctz7fgPeAo9X2UlawzQHIRknsLY+rK6/9ps79FH3nFNIJSViqyM3Um5oQw3Jzh/mv
        PvntpL+gmPJdk+CND0ATDLBUY7GWwNoZiKHQ0dDm0BnmGNll0U9XjZlSoJ+PHdhsW9waU9+KnG1
        Jg
X-Google-Smtp-Source: AGHT+IFDjioCzE4ppVWeKSBUT7OuMrGOxQDUdE+HZOv6XzSMfLpgE4ydkZk/BGubvVIM6OdEjefqaltsmPpmQ+gXyBDP
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:686c:2ad0:dfbc:9328])
 (user=jonathantanmy job=sendgmr) by 2002:a81:7653:0:b0:586:5388:82ba with
 SMTP id j19-20020a817653000000b00586538882bamr927627ywk.6.1693270569640; Mon,
 28 Aug 2023 17:56:09 -0700 (PDT)
Date:   Mon, 28 Aug 2023 17:56:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829005606.136615-1-jonathantanmy@google.com>
Subject: Strange diff-index with fsmonitor, submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a strange interaction where diff-index not only produces
different results when run with and without fsmonitor, but produces
different results for 2 entries that as far as I can tell, should behave
identically (sibling files in the same directory - file_11 and file_12,
and both of these filenames are only mentioned once each in the entire
test).

You can see this with this patch:

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 0c241d6c14..e9e5e32016 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -809,6 +809,11 @@ my_match_and_clean () {
                status --porcelain=v2 >actual.without &&
        test_cmp actual.with actual.without &&
 
+       git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
+       git -C super --no-optional-locks -c core.fsmonitor=false \
+               diff-index --name-status HEAD >actual.without &&
+       test_cmp actual.with actual.without &&
+
        git -C super/dir_1/dir_2/sub reset --hard &&
        git -C super/dir_1/dir_2/sub clean -d -f
 }
@@ -837,6 +842,7 @@ test_expect_success 'submodule always visited' '
        # some dirt in the submodule and confirm matching output.
 
        # Completely clean status.
+       echo Now running for clean status &&
        my_match_and_clean &&

and this is the output:

++ echo Now running for clean status
Now running for clean status
++ my_match_and_clean
++ git -C super --no-optional-locks status --porcelain=v2
++ git -C super --no-optional-locks -c core.fsmonitor=false status --porcelain=v2
++ test_cmp actual.with actual.without
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u actual.with actual.without
++ git -C super --no-optional-locks diff-index --name-status HEAD
++ git -C super --no-optional-locks -c core.fsmonitor=false diff-index --name-status HEAD
++ test_cmp actual.with actual.without
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u actual.with actual.without
--- actual.with	2023-08-29 00:39:26
+++ actual.without	2023-08-29 00:39:26
@@ -1 +0,0 @@
-D	dir_1/file_11
error: last command exited with $?=1
not ok 61 - submodule always visited

Notice that with fsmonitor, diff-index reports a "D" line that is not
present when fsmonitor is off. To add to that, it only reports "D" for
file_11 when I would expect that if it reported file_11, it would report
file_12 as well.

I'll continue investigating this myself, but does anyone know what is
going on?
