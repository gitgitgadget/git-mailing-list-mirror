Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982AEC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3D161446
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhDUKDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhDUKDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:03:17 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A0C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:02:44 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o192so4920631vsd.7
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5rOyGW0DhCS9H5PTRFGAkp8ucHzHdsg70QRqfRyXh2s=;
        b=O1kVHtmx5m1y1twKt3E/o26eZDutUO3MDRt/NILgaJX7+9J1Fwle8xfwaZRiI/Tl0K
         RzfbwTW+54yNIVycx7IOW5Ze2ays0p69MTusiFZDbAJ6IyTBVWAiQiEi1C/sCrVFUdU5
         Xj0ed6jJ1/qT2FzCDbkiRLgnAwHzASMxV1x0Z/PH+zHVfpeDi0uWwueVHQOgtOrKg9IE
         T4AIMHmmrL2jvtX7iCMNTGsqiJxOwZuV7NBmtwUjeAK3l0vXus7CZ1UpbRkF09Lt5Sr7
         V4jjrZo8YCMNm5tojXiZ4A4bh7+KxzCKWSeMwuKqRS9vkg5RNpHfTQ9mP1lAPm/xM9j2
         ZpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5rOyGW0DhCS9H5PTRFGAkp8ucHzHdsg70QRqfRyXh2s=;
        b=lBSMFZdJobQexaafbPx+H1X2RBwBBTcrJfMfYX8qV8x9mz9hGohbiIZ6jAMmu/v21s
         LvXUIUxNpaOiov9DuJzrClsvMTtPtS50DNw5M9CTmLlgDtXM0i3vVDWVzQtGB9VtlkMV
         x5C0xpDVQ5ZLpKL6Wd94oAS20b1T+dDDOBnvH9PdDjlNThjbP8JVu4TmdzTfjZa9N7kM
         pEFRV5WirKAMwJPXN3RJ0+HQNXwSeytdgIlvsoklgON1dhEN4hiwlwvmtLCJlxyD2rMi
         6zY2oVibRHi8Lv35z93sxkXuBm39k/F5Z8g4DxVJxqyljDYfbiyQ8akOHwS7kXLJsuCx
         +qPQ==
X-Gm-Message-State: AOAM530RREbCVUAJjsIofO4+qM66xex1fZqTVpa0CCe5jsmaiRStSZd8
        WqfKHl01MkDoFnxQuFzjaNrwF7pGOmL1aPRiaSj17PW5YVkRaw==
X-Google-Smtp-Source: ABdhPJwwIptXu+qi4jq/0jjb13zuRVqbuUSXIjjh18bJxr8WG9ydRcia3TRKUKx67CvM1FUy7Tk5WqEDgJDuOVJbAj0=
X-Received: by 2002:a05:6102:20cc:: with SMTP id i12mr10982234vsr.12.1618999362907;
 Wed, 21 Apr 2021 03:02:42 -0700 (PDT)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 12:02:32 +0200
Message-ID: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
Subject: reflog existence & reftable
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

(splitting off from a code review of my test cleanups.)

Currently, reflogs are stored in .git/log/*. Git adds entries to the
reflog only if the reflog already exists (See the log_ref_setup()
function).

The current iteration of the reftable design has a unified key space
of {refname,index-number} for reflog entries. This causes there to be
no distinction between

  1) reflog is empty (.git/logs/blah is a 0-byte file)
  2) reflog does not exist (.git/logs/blah does not exist)

This trips up some current tests that make assumptions on reflog existence.

I don't know why one can tweak reflog to be written or not, but the
current functionality will cause a change in operation with reftable.
I see two ways forward:

1) Have different functionality in case of reftable: you cannot query
for the existence of reflogs, and writing reflogs doesn't depend on
the existence of a reflog.

2) Add a reflog existence feature to reftable. We could introduce a
magical reflog entry, which indicates that the reflog exists (but
might be empty). This adds some complexity to the C code, but lets us
maintain backward compatibility.

What do you think?


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
