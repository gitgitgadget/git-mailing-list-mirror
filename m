Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7390AC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 10:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F74238E2
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 10:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/6c3BaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIZKNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZKNf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 06:13:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88DDC0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 03:13:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so5398661pfp.11
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhFkdbhpSwiRgA2JhO2UaGxTvCCmcqBKE8SXUhsJq/8=;
        b=C/6c3BaMBQbqcwk774ZusHbiMOK3S2qr03rFxOxX/ks4Z/XP4WLLxyDyKIS3EHLqjx
         FDfnhKvybzPwTUV3XvwRy74DJSVcOp1UEkCQcF/IiUrXYPPsvmPnW2UkaDsLKnVfSVny
         zqpYeIQGxB1rZD0ITouyUdw2SMxP7XY0oBvpC66pF5YydDyHhGvogwAXta7Yhxgj+NYM
         3o0M6koDD/OTy2fa/9rjY/gPIL8YVXwKdSU5/t3xdRoIbu1+OwS8m8DOhk3+eA8sXtXc
         N515onhhJWud6ZyVcWslSHiE2uAwRNKa3Kh8Y+FvaCgn+gHDm7CXu8DluG4B/L5OtCek
         kFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhFkdbhpSwiRgA2JhO2UaGxTvCCmcqBKE8SXUhsJq/8=;
        b=cIgCHeGhYbwMygTgrWJhAl6DkfloieqtT6P6RNwjJwZPVSAGGcI+jnEaY5I252TQ1F
         JSBXpC1TwdenHpjEQyuL+RepuoSoF/A9SbNoFxzHo39FHTT8Gsz7yXh5eyqLDqsOIg/Q
         LIjPVi4oIxsA5uXCBhuPF9eHX+URrfVqVc6siEX5ky08lGl9334c+zW3v0z+Sh3BHSxM
         EFMNXxauqEJMXMwWdI3o8jqMrE1F4Av02MySzIluFCpytCfRiEuM/JFBlAHmXdO4JrLS
         GYCW2VNXuwZG2kB8U/WbF01in0wSr8jTuHUnJ3d/3Gh1QD374Ece6ZiFL8FKeSe2Jt2A
         k8fA==
X-Gm-Message-State: AOAM5306VYycIRsxwiLkeQa2GM/IgdnTDgEH+RiHQfNcYtFAceI29GaT
        eRXvJU5Lha66OcrMUPiTP6Oqkp53zI/Xji6b
X-Google-Smtp-Source: ABdhPJwadHpkM8qtT3zWvgxlofacpWj52bkKG4yFGAYACDixiRKzCp0KBAHsUFqkkHvT6J8Tp3W2Yw==
X-Received: by 2002:aa7:9157:0:b029:142:2501:3984 with SMTP id 23-20020aa791570000b029014225013984mr3133287pfi.73.1601115214994;
        Sat, 26 Sep 2020 03:13:34 -0700 (PDT)
Received: from localhost.localdomain ([124.123.106.26])
        by smtp.gmail.com with ESMTPSA id 63sm5226947pfw.42.2020.09.26.03.13.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2020 03:13:34 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 0/3]  push: add "--[no-]force-if-includes"
Date:   Sat, 26 Sep 2020 15:43:21 +0530
Message-Id: <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
References: <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to "git-push" where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can be used with "--force-with-lease" with setups where
the remote-tracking refs of the repository are implicitly updated in
the background to help prevent unintended remote overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with "--force-with-lease[=<refname>[:<expect>]]" without specifying
the "<expect>" value, can cause the update that happened in-between
the checkout and forced push to be lost.

Changes since v5:
  - In the previous patch, the stopping condition for "reflog"
    iteration used the commit date of the remote ref. That has
    been changed to use the the timestamp of the latest entry
    of the remote ref's "reflog"; calls "in_merge_bases_many()"
    are batched when the number of commits collected in the list
    is more than 8.

  - Add more tests for t5533 to include scenarios where forced
    updates should be allowed for "pull --rebase" and local
    rebase operations.

  - Reword commit messages, fix typos, and update documentation
    to use "`" where necessary.

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |   9 +-
 Documentation/config/push.txt   |   6 ++
 Documentation/git-push.txt      |  26 ++++-
 advice.c                        |   3 +
 advice.h                        |   2 +
 builtin/push.c                  |  27 +++++
 builtin/send-pack.c             |  12 +++
 remote-curl.c                   |  14 ++-
 remote.c                        | 185 ++++++++++++++++++++++++++++++--
 remote.h                        |  12 ++-
 send-pack.c                     |   1 +
 t/t5533-push-cas.sh             | 129 ++++++++++++++++++++++
 transport-helper.c              |  10 ++
 transport.c                     |   8 ++
 transport.h                     |  15 ++-
 15 files changed, 442 insertions(+), 17 deletions(-)

base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
--
2.28.0
