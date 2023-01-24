Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A2C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjAXOOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAXOOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:14:40 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6213DE9
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:14:39 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b718cab0e4so219245587b3.9
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lT1H7OqJs+cakHt26XnlIGG53LeF/i07z0Q7GCWWu64=;
        b=Y7sNf8EPmyUrCn2gV7HjgBg+IFDIKDg3f2wGAjn8jn8qfNt+g2gab4QOE7Un8i2bZG
         G1MKAUsAFujZzQT5ousUw9LH94Dt1wc+R+nX4Empp/Chuly+fX8I4T9hyUgI8AKoEkhA
         5ILcvBiHpX/R4DrSaae1z0WX/eG7tu+EV6B5/XCdgTaPwLvQlgjymZfDgYvlXIJ0qHie
         /MBO9Dg95OZl7RLsOlTfk9IOrVJEufi5Mg4MZnoI6AqX5vpTS59DBBl5RTeZWJwLeqXm
         WlIudkaY0iqjAaN5BhhSKf6yIEEOCNVCFNJuR1T2imGq8RubWvjuFFheAicCrA5RnsoZ
         CiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT1H7OqJs+cakHt26XnlIGG53LeF/i07z0Q7GCWWu64=;
        b=cDwsFOncx4wlzhtne42qeUfYhGKmQl7WdavzaoFGZm3mOQZMpxyQkLEB5LtxzzzWUj
         P/nOAsUszoqDz8CnROMD4rR70YYy9eYVVEAW4+q2Va4DWDyWxLJB3uTOnx+LfsfDVGgs
         bjvs8kyedL3obQg7+xCzCkVFRBT7ENkb8bftHbpnjzbb2CkirySeLCMgyr1iNHJVTgSj
         VIWyKs7w1CAH+m/CgOgeQM2CsTsXhrT5vQK0aJvd0Z+4luxftvpZAz4mcvwhyYmg4VFD
         6md4cSUDhVg3k91lMB3ThcgI//JYEuK6reQoqWHZb6VkyIaqG6i00UHI1LLzkmhMVFni
         bVyg==
X-Gm-Message-State: AFqh2kob0Lts4PTBmlYpz0Zp1DQDltA+Oq0zQ2vcbmmuqvI5anaGAzMI
        7Fzub/R1+4TCKbY/FLHNM9qT
X-Google-Smtp-Source: AMrXdXuQwbEpNKGYvFZiKIiA3rPFbwjyehyiV6GtBInZgLrLszo42Lk3eJDLPD7hh/fAY5Um3Eudcw==
X-Received: by 2002:a05:690c:a99:b0:4d1:da3:c18f with SMTP id ci25-20020a05690c0a9900b004d10da3c18fmr18034022ywb.39.1674569677915;
        Tue, 24 Jan 2023 06:14:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:70c6:2d77:ae17:eae3? ([2600:1700:e72:80a0:70c6:2d77:ae17:eae3])
        by smtp.gmail.com with ESMTPSA id e127-20020a376985000000b006f9ddaaf01esm1452786qkc.102.2023.01.24.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:14:37 -0800 (PST)
Message-ID: <01f97aff-58a1-ef2c-e668-d37ea513c64e@github.com>
Date:   Tue, 24 Jan 2023 09:14:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v2.5 01/11] bundle: test unbundling with incomplete history
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
 <xmqqsfg1m8l6.fsf@gitster.g>
 <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
 <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
 <771a2993-85bd-0831-0977-24204f84e206@github.com>
Content-Language: en-US
In-Reply-To: <771a2993-85bd-0831-0977-24204f84e206@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2023 7:27 AM, Derrick Stolee wrote:

> I'll focus on this area today and see what I can learn and how I
> can approach this problem in a different way.

The first thing I did was try to figure out how things work today,
so I created this test case. It appears we were not testing this
at all previously.

This is just a candidate replacement for v3, so don't worry about
applying it until I re-roll.

Thanks,
-Stolee

--- >8 ---

From f9b0cc872ac44892fe6b1c973f16b35edfdc5b20 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Tue, 24 Jan 2023 08:47:19 -0500
Subject: [PATCH v2.5 01/11] bundle: test unbundling with incomplete history

When verifying a bundle, Git checks first that all prerequisite commits
exist in the object store, then adds an additional check: those
prerequisite commits must be reachable from references in the
repository.

This check is stronger than what is checked for refs being added during
'git fetch', which simply guarantees that the new refs have a complete
history up to the point where it intersects with the current reachable
history.

However, we also do not have any tests that check the behavior under
this condition. Create a test that demonstrates its behavior.

In order to construct a broken history, perform a shallow clone of a
repository with a linear history, but whose default branch ('base') has
a single commit, so dropping the shallow markers leaves a complete
history from that reference. However, the 'tip' reference adds a
shallow commit whose parent is missing in the cloned repository. Trying
to unbundle a bundle with the 'tip' as a prerequisite will succeed past
the object store check and move into the reachability check.

The two errors that are reported are of this form:

  error: Could not read <missing-commit>
  fatal: Failed to traverse parents of commit <present-commit>

These messages are not particularly helpful for the person running the
unbundle command, but they do prevent the command from succeeding.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t6020-bundle-misc.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 3a1cf30b1d7..38dbbf89155 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -566,4 +566,44 @@ test_expect_success 'cloning from filtered bundle has useful error' '
 	grep "cannot clone from filtered bundle" err
 '

+test_expect_success 'verify catches unreachable, broken prerequisites' '
+	test_when_finished rm -rf clone-from clone-to &&
+	git init clone-from &&
+	(
+		cd clone-from &&
+		git checkout -b base &&
+		test_commit A &&
+		git checkout -b tip &&
+		git commit --allow-empty -m "will drop by shallow" &&
+		git commit --allow-empty -m "will keep by shallow" &&
+		git commit --allow-empty -m "for bundle, not clone" &&
+		git bundle create tip.bundle tip~1..tip &&
+		git reset --hard HEAD~1 &&
+		git checkout base
+	) &&
+	BAD_OID=$(git -C clone-from rev-parse tip~1) &&
+	TIP_OID=$(git -C clone-from rev-parse tip) &&
+	git clone --depth=1 --no-single-branch \
+		"file://$(pwd)/clone-from" clone-to &&
+	(
+		cd clone-to &&
+
+		# Set up broken history by removing shallow markers
+		git update-ref -d refs/remotes/origin/tip &&
+		rm .git/shallow &&
+
+		# Verify should fail
+		test_must_fail git bundle verify \
+			../clone-from/tip.bundle 2>err &&
+		grep "Could not read $BAD_OID" err &&
+		grep "Failed to traverse parents of commit $TIP_OID" err &&
+
+		# Unbundling should fail
+		test_must_fail git bundle unbundle \
+			../clone-from/tip.bundle 2>err &&
+		grep "Could not read $BAD_OID" err &&
+		grep "Failed to traverse parents of commit $TIP_OID" err
+	)
+'
+
 test_done
--
2.39.1.vfs.0.0


