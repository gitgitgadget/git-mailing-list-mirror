Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5092CC433E5
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B6C22BF3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKWuYUrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGUAVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGUAVw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:21:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6BC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:21:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m7so14931510pgv.12
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=p+htQFTtY1zydhdwogRRBjTIUh+Q6ekwL/3w3gIBKVA=;
        b=MKWuYUrEHEethjKmNxFDBx75iSH04rbAB/Khwz/bjM2DwGmrG1COBmgg+8eCJagiOR
         rqBfIxKx+TvztUTvDJ/D2937DNC7O4JNxJ8SEWWh8bgy4I26OclKe7SEa+wW4ReOXySV
         82b+vbqbNB8dpIETkEC41sqR/vAGarz+E9MZm19B3OBxpFOlGHSE8p/NiYRUo0LqePp4
         MSbPDjJjTF0pgCmE113EzYcdTFuptJm7I7TGJJm4CU6gTYLxyeD+XPQlxmW6Jv2Yk/CE
         rt65Pv7uAWaQSK/pyLU7LtoTkjD31mFELEZ+KgibMyT5d/6z5uAjz+ZiBsGcOBZq0EVb
         22UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=p+htQFTtY1zydhdwogRRBjTIUh+Q6ekwL/3w3gIBKVA=;
        b=NNjyuPFPot6NDQLv8/ex4ZXILokPvCWEPgLN4Uwg42zDIVnQpT/LUU3XbVll/LCta8
         xq+kkLA8FjNvOP75VcTLbZKNMOyRNi2PgRYXNdFrA8vEeiPawc9e2G72dVzSZmsmJaal
         cSkJ91cL7ExAXVKO1CTWE5aut1uQzC9zGn0NE45gepC8vq38bT1602F+Yj90gAgX9ic8
         CWtwN9JGwcGdn9XAecZOAoiIOsHVVNNezHlTx6w8AVr3F/vZ4fm09bawP16QOpYixqry
         YcP3My0wl0NT2HYN0zA6B/FjoDgSs6C7rfwmT5nocPs2K5YWBwMyxnDBMOVFr76Qv94y
         lypw==
X-Gm-Message-State: AOAM530mck582jGX/058PGBco+thZk5I2Yg/EjSR15/PZKWV8r5uF66T
        C08eJ1iv2KChVqYRxtASTaFj33hw3vRyEhiz0Kj+0mV4Gd+otRUNNq0ber8oOVmyBrtTOup3v9k
        Q/z1PZN2yS6bgu1PAFHxEyqmuDzwem27oi07vAaEFFcb34Xv3BbtFkMyOnnOaSyEP9em6wGKy63
        8t
X-Google-Smtp-Source: ABdhPJw9yQWYYe1wTww2d5DjKM9eFXm5YHH6MjHhfsJwsC2as3dV9v+ILoKWWDojvkhCTzjrOKc97Dx1Pc5bqhDJSzRc
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr2047221pjb.2.1595290912051;
 Mon, 20 Jul 2020 17:21:52 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:21:42 -0700
Message-Id: <cover.1595290841.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 0/2] Prefetch objects in pack-objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 1 is refactoring, and patch 2 is the main patch which introduces
the feature.

Jonathan Tan (2):
  pack-objects: refactor to oid_object_info_extended
  pack-objects: prefetch objects to be packed

 builtin/pack-objects.c | 40 ++++++++++++++++++++++++++++++++++++----
 t/t5300-pack-object.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

