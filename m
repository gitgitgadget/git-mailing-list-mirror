Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEFC47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4AB61107
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhE3GzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 02:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhE3GzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 02:55:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5AC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:53:37 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k22so8699858ioa.9
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=We1rNGu9A+yhb9SpEpYXD/lxweLtOTVbcpqXu3dElAc=;
        b=QV1K6KwoGx3VEaxprvtzEUcb1XU48r/ZMY9hlJ719U+xCUsx+sakYVKM2ObcpyBDvQ
         XYWkk1vMFO5NPUcPCy+8iRRJm/VhVdAOXB4jTtcexCA3zFFAwN1n9uI2tjVUq5DXCgkK
         7o1Lb2cRxVWMbTyPrWXAv0wbjq6/kQQYDQCcnHfyMqCiZeiYUvxWuc4lkDSfgo5rOQ2W
         FcjzmUBlzJUM/eee+3W40IpZHkEtdbhDxtT/4k/ZdmRI6WdRk2CF21pDDvNdI0SZSeUZ
         g6O+Pzp54CkQd/65ukod9mlFFQ6f0c7lv2nWkwPN3Z/Wokf2xGQkyhLb4269NCrLJuN+
         A+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=We1rNGu9A+yhb9SpEpYXD/lxweLtOTVbcpqXu3dElAc=;
        b=d6x3O1pIwRlo6e6Q+lTWHao3k4rhs9wpk0gdnbB6KZOm07KqJGFmV3hNnxbMwE0wsh
         r0wsClO3SxUt2ly7prrDIRU/XvJnfpXKizMG9QBvVOOf98y17M/g44ijNeVv1N7XKlu0
         rhpxhRrMxdj15Zk/kL+EtySbaTrdXqp7UOdFxUpWzja/+RQf5rVDwEts+m434rudOWgF
         m5Aj777OeRMzHmiibeAu5d5WilUy5/Q1DGMlGHQ8qC7RubD6VN6CQVdXbn6yphqKbJ2V
         SqBIy2lB6sAteJrHDm3LfBz/sdqKO5AVMOUU5YHnF2nnGHd1J3OjeIqBCNuiVymMUGSW
         wO8g==
X-Gm-Message-State: AOAM5328UV2KlZawPCrTkwgQyLPUeVjOFiyaFIZxkZiqthDv90nBbo0d
        MpBdkUH/bC9rfIF0hMeBKitQ4FpahfzEEtE5T2suM//vmHkIoA==
X-Google-Smtp-Source: ABdhPJxnA4Q53ZNgP8B+uzA+cBtju1C8s59FYoe/go9ARS+vtlHCd427ZHT05PLv3xAJ+14zjuQhnoav9g5+2GVhciQ=
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr12867121iok.192.1622357616555;
 Sat, 29 May 2021 23:53:36 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 30 May 2021 14:53:24 +0800
Message-ID: <CAOLTT8SS8Wypho7eCCGH7LtOLwM6tWCzp8mGGEVASBC80MwJ5A@mail.gmail.com>
Subject: [QUESTION] how to quickly find an oid in the git repository
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I tried to make cat-file --batch use ref-filter logic,
I encountered this problem:

get_oid_with_context() does not really let me know
if an oid is in the git repository. E.g.

get_oid_with_context(the_repository,
"0000000000000000000000000000000000000000",...)

will return FOUND. (I really want it to tell me MISSING_OBJECT
or something else)

On the other hand, oid_object_info_extended() will parse an object
in depth, using it will seriously affect performance. So I want to know
if there is a function that can quickly find the oid? I searched in
`object-name.c`, `object-file.c`, and there seems to be no clue...

--
ZheNing Hu
