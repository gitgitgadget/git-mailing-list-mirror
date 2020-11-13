Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD00AC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FC520936
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqt5Pkuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKMJqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMJqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 04:46:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8829DC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:46:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u18so12857422lfd.9
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 01:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FlTcNMFJFz78UlrXoADJ/r0m6ui6MO3gTiaH7ceyoZ4=;
        b=sqt5PkuvTxpcbgSa70RJRqDMdmglsa9lWYc4JBWSfb1Vmxg9k6arJlWCFyFbK9dFsh
         rUVJH67NhFg81jsyd4ayNGasCLBWHOwmakxdE4fX2y7IMg0RXIdgv2zvG86aUgoHIK/c
         TYhJULc9nUc9DCGf0+cvnS8dA24cJOuoiY4og25XENs5Bibbvk0ljrb277srmx4zKAa7
         yoF48R0sVppdXUbXE5s4G5+HVR+oxxz7lyf3JAttOwDzPG+QFm9G+vhOpdNbjC2wiHiR
         KjgrVu8FPUhejd6dMcafENbUQh1+JdgMoauPYZG7cGFxOwvLvQCwBWBw7BE0WdnRdHL5
         WR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FlTcNMFJFz78UlrXoADJ/r0m6ui6MO3gTiaH7ceyoZ4=;
        b=H6+bECKETaKJyfDFCZD9XV0WvPdXiuLOqAmv2VKbzzVxJIW/dPH1yjg+ut6gafuNCD
         sBy0ZBOUNkLdgYCLQae7TTkSwsKGF2+jw4nBUIeSTXhBD56EJ4CBLSqLYl9J0b42of++
         iQvkLvGP/q+u6TH/GxU3FRvBpRKzZm7nApr0zsMXrcbs4RoeR8WKKwaD3NOGWdQ+tIxs
         MtSuxdgGFlTFZLguwDx3sRaqBV3rVq1NLQTZKv6HVRIj6+ebztiQGaKjGbJDtoxasZpy
         +EEI6xAfqZo81J0k0TTzex3/z7NmsV0K4o6cnY8H4m4rES/cWUaAUEgkvc+L6Aw3yGTb
         KBUw==
X-Gm-Message-State: AOAM531G1SEWKY8Ms2xApwGFtRL6W1sGHuRgEMaelRfhZNyIgoSZrPgc
        9tg9ftB9U1wxKJ/8iVEfuQVOOlqk3HH7oW0ZzO+F1/SsTAMFBg==
X-Google-Smtp-Source: ABdhPJw0m3Dfo64nGveUymFkP0mDD8lD0iP3YvilB6VAksF0y07XZipHw8UOkmklUzbFBalsdt2MyCOm8nVEpTKDUSc=
X-Received: by 2002:a19:c514:: with SMTP id w20mr502586lfe.525.1605260781562;
 Fri, 13 Nov 2020 01:46:21 -0800 (PST)
MIME-Version: 1.0
From:   Alireza <rezaxm@gmail.com>
Date:   Fri, 13 Nov 2020 13:15:52 +0330
Message-ID: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com>
Subject: Why Git LFS is not a built-in feature
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, having to set up git-lfs in each client and checking server
compatibility is a huge barrier for using it in the first place,
whilst it is generally a good practice to store large files in lfs.

As a consequence a lot of repos are not using it when they should.

Is there any reason that we don't have built-in support for such an
important feature?
