Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765AC19F2D
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 20:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiHCU5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiHCU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 16:57:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5131F2F2
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 13:57:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s6-20020a25c206000000b0066ebb148de6so14253180ybf.15
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Ay6KooD/d7Pw4Wgt1Dk883STxhxjgAuHCg+rloqNWi0=;
        b=jB9uNPmGXyp3jaT/y+/9OaSlbJHAnOUgjI6mMU8bMoEJ5co1sX7+TrB5kSCv7Qlz0Z
         AXhoEkIuqz835XrIeakYYrbpnGRxTXZYyImOFu6GNyUIxTXEkMqPLdarHEpORNU6CrF2
         Jn4tf2uxgzMjTJ/Ypen/5JyKbRkbHOUrd6XBQ9BDTyVhy6LUI7TRMJpUqZLzq3+/Pqb/
         ZjBfC4F9bUtJgeY1uAi+fKkt5oOr6Uxnag+TrmO9vm9rlVp3FF3bqB2HealMAhNxjKcN
         HPutGE9JjFEE9djsF7UYQyp4kPFVYJAZorGFAJGfFc80gcnNloQm/xzaokFSZw7EnoXt
         iGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Ay6KooD/d7Pw4Wgt1Dk883STxhxjgAuHCg+rloqNWi0=;
        b=D/exCRWo0mDIMYafJB/V/q7ZsdhvcvNKPOWMQphePyjChdd4acx9oQpbSBIdRfHuYB
         hihBxuXvZq2b4dX3lMGv0yA7RgXbUsF4qFXDUE1VHNRESga50PBdoVCW0ez1vi3MU7KV
         SVTlo8ltpuqHLRRxsVhEEA6CFn2x6jpxaZ6F1hxI3LYYiBntBCHDtYZdFCkA6dGf/OUd
         kvfZPcjjcawp0bCTtqcN+iOd6gcD8PEucgltM5lTe3F3rFMhZGUdZPufoIJ46taGUL6u
         93T7SzWcmCk5pJEuZcJ57mjri3I4iVbNQti0aXAzPDROSBjTSjhYEGkh7BKNVCTOa0Pi
         NYYQ==
X-Gm-Message-State: ACgBeo2eloT9QOuj2WAGoHsZ1fQ/S+cgX824xhyBeZu9XFv7kIRyPh+E
        vuqcHBXzdrjsibwbqB+bAtdHQKFuthP/sjIrHjYl7VF4sIIDdnmdr3FJ/awc+0y6vYP7BBMXbaF
        6kpPuyUhmtC1k1fq52WRbX4N40IPmLLNd56gGBlCdiCMx03uKNrS12kVtaIk5Nb0Wb/UbfMAqkw
        ==
X-Google-Smtp-Source: AA6agR66Jp9REb59k4beye/AUY9QTZF5P1bYDNQBuBX7qxDFPdcvO+feskWfm5E/bM2PsU8zVfE64c9Wvuj19K0uXDo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:b3d5:c5f6:e39a:a9e2])
 (user=emilyshaffer job=sendgmr) by 2002:a0d:e2ca:0:b0:323:1ac3:8a38 with SMTP
 id l193-20020a0de2ca000000b003231ac38a38mr25954115ywe.89.1659560252459; Wed,
 03 Aug 2022 13:57:32 -0700 (PDT)
Date:   Wed,  3 Aug 2022 13:57:20 -0700
In-Reply-To: <20220803205721.3686361-1-emilyshaffer@google.com>
Message-Id: <20220803205721.3686361-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220803205721.3686361-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 1/2] gc: add tests for --cruft and friends
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 5b92477f89 (builtin/gc.c: conditionally avoid pruning objects via
loose, 2022-05-20) gc learned to respect '--cruft' and 'gc.cruftPacks'.
'--cruft' is exercised in t5329-pack-objects-cruft.sh, but in a way that
doesn't check whether a lone gc run generates these cruft packs.
'gc.cruftPacks' is never exercised.

Add some tests to exercise these options to gc in the gc test suite.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t6500-gc.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index cd6c53360d..e4c2c3583d 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -202,6 +202,42 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
+test_expect_success 'gc --cruft generates a cruft pack' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+		test_commit base &&
+
+		test_commit --no-tag foo &&
+		test_commit --no-tag bar &&
+		git reset HEAD^^ &&
+
+		git gc --cruft &&
+
+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
+		test_path_is_file .git/objects/pack/$cruft.pack
+	)
+'
+
+test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+		test_commit base &&
+
+		test_commit --no-tag foo &&
+		test_commit --no-tag bar &&
+		git reset HEAD^^ &&
+
+		git -c gc.cruftPacks=true gc &&
+
+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
+		test_path_is_file .git/objects/pack/$cruft.pack
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.37.1.455.g008518b4e5-goog

