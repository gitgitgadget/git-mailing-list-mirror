Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A90CC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53512207D0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sL+n5GW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFEJKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgFEJKe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 05:10:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBFC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 02:10:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n37so7826046qtf.18
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jc2ReHBKGAOq9PGExWlorCnAZ+P5oIesDZwLjiuvSSE=;
        b=sL+n5GW2ZLcaR4Qi8OVzQJ7Aq6+P1O+fmfx6xPZX2UjtMBmW1EvwxhDsJgoKrYYUfJ
         N1DXZYyZOkiI+9eTFToFlaDaaHy0YDenySqSLymc2Ze5/ruqwizQEINwDpq/CsEOX+lR
         dZX9Jw8eZDR5Y1FFrRBzlOioB9mAx1XvdbVFjjuM3mo2eFLuGebErRaNyRXiVCMH7+Rv
         JPrd+To9vm3uMC3BeBsBw/yn9XEhXiREO3N+E80zRkVgocbn2D+K0083Wtg04lcrFKZS
         zl3Se8yzK8Bz5b0B/4jJTKl/y9DC5nIE18xn9NBgqv1R3ndi36pY7qnDXsmaflUNZ091
         Ft0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jc2ReHBKGAOq9PGExWlorCnAZ+P5oIesDZwLjiuvSSE=;
        b=raRoZDsDCmSG+QF//Cc0KFZ86lALFO1Gkhh9vUolGVoMAjj54PV+fBBw3lnFIzE901
         X1xqr8KIwOm7xfPeLJYWhDjIV4QH7WcchsD9BieMFDpO2+QA+wh9npLcIgkNwXNsQ/Gt
         +rRLzKjuc9f5ag1pvICzHa/rHfTv9ewawMlnR1OB8fFkqxlUNd/B5BY86+OLvb+/ZZ0K
         rvt0elAx4MbVyF/60RXBRrdrZ/7g8XftROngigOsvg69bbsIvlKDQYrO9DYx7s5NZjfJ
         hLSujzaCG6UQTdSTx5I3N9aLTmiIEgU/OZtC8UB1QOW2OxI3fWkn+SG2jdXud1NhrxBI
         bB8g==
X-Gm-Message-State: AOAM530cwUXZ3GnPQJ0Yd32PHjRtYjTFYQXixcDA92ADfarvGM11l+pm
        rgHFiAGve+DN4Hi7Iyvbh377/PQ/FTwgouVJIRtdaO9OkxJGOI2vQTW7uZ2nzf/SAu9VuetdLt8
        j83kULEVqOcBv997MseAazaGbDvUx8iPNGrtXn4TOAopevC3jsmD3d34KSXrv
X-Google-Smtp-Source: ABdhPJzjKh7VddXhosUUN7zKMYrhYCC6gGjP4qxcmBEaAMfxvaGnmbXN8NFP1We4i1CWbmW6fTlunA3HOwY7
X-Received: by 2002:a0c:c249:: with SMTP id w9mr8656610qvh.149.1591348232664;
 Fri, 05 Jun 2020 02:10:32 -0700 (PDT)
Date:   Fri,  5 Jun 2020 02:10:00 -0700
In-Reply-To: <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
Message-Id: <20200605091004.208668-1-delphij@google.com>
Mime-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com> <20200529000432.146618-1-delphij@google.com>
 <20200529010119.GE114915@google.com> <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v6 0/4] fetch: allow adding a filter after initial clone
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        sandals@crustytoothpaste.net, iankaz@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patch makes fetch to allow adding a filter after initial
clone, useful for existing shallow clones as they allow users to see
earlier change histories without downloading all git objects in a regular
--unshallow fetch.

This version of patchset is mostly identical to the v5 draft but splitted
into smaller individual patches.

Please note that the last patch is an incompatible change that would
make extensions stop working for version 0 repositories.  Currently,
unknown extensions are silently ignored for version 0, which means the
user may see undesirable result when upgraded to a new Git version.

Xin Li (4):
  repository: add a helper function to perform repository format upgrade
  fetch: allow adding a filter after initial clone
  sparse-checkout: upgrade repository to version 1 when enabling
    extension
  check_repository_format_gently(): refuse extensions for old
    repositories

 builtin/fetch.c                  |  3 ---
 builtin/sparse-checkout.c        |  2 ++
 cache.h                          |  1 +
 list-objects-filter-options.c    |  3 ++-
 repository.h                     |  6 +++++
 setup.c                          | 41 +++++++++++++++++++++++++++++---
 t/t0410-partial-clone.sh         | 23 ++++++++++++++++++
 t/t1090-sparse-checkout-scope.sh |  1 -
 t/t2404-worktree-config.sh       |  4 +++-
 t/t5500-fetch-pack.sh            |  1 -
 t/t5702-protocol-v2.sh           |  1 -
 11 files changed, 75 insertions(+), 11 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog

