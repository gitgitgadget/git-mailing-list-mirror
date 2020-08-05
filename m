Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25238C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08AE2086A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwMM+864"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHEXHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHEXG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:06:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A4C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 16:06:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h185so32064253qke.21
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=scTkRdah1xxojQ5Q/+8y7jE8EgvmIKzdAOxLD0CEXi4=;
        b=HwMM+864J0IJeJfM1TkrNwJkuDrTPP3zbj26Pimsk64nAGKzX2nTip8qWBg1W5EZQS
         elSNXzmKu6NMXH9p1mIuXakQoSafVboGTZyyRwOO7bLIHf2BBJCf2imZp3EvUQODJNvp
         Aht862gvD3eo8hcGxaaf4W+p3prAAFQxUNwWrjmrYVgPQ3WSNKs91dh3iq7lqQoWuB8s
         wt2uVmOkxHbhIBpYhvSA6w1ZVv7X/SidwhGs9qnmFOXhWyPiP5Bz8RQbt6nzLcCOHrEF
         TvcibVAfftFRgay7O2caYWEnmvMzjSh3oLoqKjdwhnf4ch492qORaWWBh6k+ieGQNfC+
         eNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=scTkRdah1xxojQ5Q/+8y7jE8EgvmIKzdAOxLD0CEXi4=;
        b=pywb5aBUHsuHtFpMmDpcrI5TWX1J7XBW8Lv655u1Wgpltg0ZCkorEVULPlbMoG1GTn
         +G3fsq/THHkyWnPpvUnRGcWhyN+TFQ+gR9Q2ciMSVktcNrIJ5uIq2dhAdb35YzXU9Wks
         UcMrcLpw6o0JEDgE6Jhtu9rZyFZDwPFn9+QcjCcDL6VVihXJdc3Dj2nC5mwmUmLHrCtf
         1inh4ZaEJkMl9OVhM42bxHtDYoIxPKbpUSh04TqgsjvFeFyDqCz75xBOlB73Xcow/nP1
         lLcryUJJVBRSBqHUvARelAdVznWzoRDQnlCwuyB0DC3juYFAPmF/NKyDrz2cySYWgipc
         Dt4A==
X-Gm-Message-State: AOAM533AWsO6uxYFE3u2qOr6oLYC8Ls++/gGl+3MzAnePtFaF9HpxtQz
        4Pf32ajcBkFROuE1dOMPche6BIh0659KPUWn7m0tHnCzPMyk6aLuxBexGmRqSa48CxOLHrVU/Lw
        FoaQpxbyQyD99ee1SZp30FcjUHsDhx0A04de21YXJ8q6mKU3EWfat6bn6HyrN8TJrFgJXXW2FeB
        nW
X-Google-Smtp-Source: ABdhPJwAva9JvWWiF27K4KEc9MQZCa1uJ/InuhqUpTXSvOcORN5QBbH3RwS4w4Ot2cUIrG/IlPdg+sI6OBe0f8vdgYes
X-Received: by 2002:a0c:cc94:: with SMTP id f20mr6242070qvl.159.1596668817006;
 Wed, 05 Aug 2020 16:06:57 -0700 (PDT)
Date:   Wed,  5 Aug 2020 16:06:48 -0700
In-Reply-To: <20200728010403.95142-1-jonathantanmy@google.com>
Message-Id: <cover.1596668156.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200728010403.95142-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 0/4] No-lazy-fetch has_object() and some fixes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v1, I've took a look at 3 other cases that use has_object_file():
2 don't need lazy-fetching (patches 3 and 4 in this set) and 1 does -
"cat-file -e" - although I think this is a special case. So I still
think that not lazy-fetching when checking object existence is more
likely, and should be privileged with the shorter function name
(has_object() instead of has_object_locally()).

Changes from v1:
 - Patch split into 2 (patch 1 and patch 2)
 - 2 additional patches that fix bugs by making use of the new function

Jonathan Tan (4):
  sha1-file: introduce no-lazy-fetch has_object()
  apply: do not lazy fetch when applying binary
  pack-objects: no fetch when allow-{any,promisor}
  fsck: do not lazy fetch known non-promisor object

 Documentation/git-pack-objects.txt | 11 +++++++----
 apply.c                            |  2 +-
 builtin/fsck.c                     |  2 +-
 builtin/pack-objects.c             |  4 ++--
 object-store.h                     | 25 +++++++++++++++++++++++--
 sha1-file.c                        | 12 ++++++++++++
 t/t4150-am.sh                      | 16 ++++++++++++++++
 7 files changed, 62 insertions(+), 10 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog

