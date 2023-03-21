Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F2C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 00:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCUAPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 20:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCUAPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 20:15:34 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC681114E
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 17:15:29 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-544f7c176easo108908157b3.9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679357729;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4lvwAUrdKAhJ/aCIu5+DLQPgzWxaoD9PVPRdiQKQiI=;
        b=GvGZ7UUyQa/KR/oZ1+ec8aubGMiDya6XNcIfDQCs7bZQlRWd/O+c6+UI8StXAT3kxs
         Trxy0cGbbYDbc8vrlpgTvFHp850tgXnyLLryG1Y5ZSmh3Iopj6vOqQGVlp3uFtFFjcpT
         9y6LxQq2rWlwydZUk9z3MlurBqExb7eeOBnKfum/xDdjfegMX0SCqWpIgViJdsETVP0R
         JS/zXhddXgVo1oW37+PAXsmdSmEd2xLUhAoKWWCJVeL1Bezk0D0EcRg6tnIyU5XQnxmO
         D0bgKNDZBTS2lo4ktDSvl1ePDunu2vOOs8XbeJ3iTGfoieukyVHSZbBV5wlcc7NBlo1l
         alow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679357729;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4lvwAUrdKAhJ/aCIu5+DLQPgzWxaoD9PVPRdiQKQiI=;
        b=KumiLW4TldZivqJcEaT6DH/4fc/eN1sTMz/lWmC2WDokEFr/wpRiOPaT43d07GLPVo
         M3JiUWnQi++5bf8pjjPFIZSR1vUl4+YTRbbdScVaWZuswZm7SF3gAeZh7nTwr3IRKANY
         F6a0bg54cQufXssjY0CzHBIAXt6OKXoN7HoDftwkMvAbI8RBduxE9TKs39PxKJr3JH+e
         lqlRTGwljUGXztDgdhQKnknJO6/LGBF2z1Qv06zbQrp8l7oNEot+6e621c16qYRWovEO
         Mil7c91gn//7tetWb/oicA/QvtSZxstx2FKvBcm9d77dyc0Dktiq43zPH+XSNiwTo2PY
         pofQ==
X-Gm-Message-State: AAQBX9e4h0bzFAYY6X96LYQF2zjthl4hoYcvXxQUAr2Zma1HTYwx+CiS
        OJ4ngr/M7TYudEUjvS9VIP+PPQ9JTgYsk8EjRxMjCPq7XeQ=
X-Google-Smtp-Source: AKy350aDznESAp4qBGCIO0Vl/CTdWtRQsadI+tsMkNQsm6Q+tp38mgAiAl5nLbBZEr5NG5oub2uZxep9IbLedbZ2l8Q=
X-Received: by 2002:a81:b3c1:0:b0:541:9895:4ce9 with SMTP id
 r184-20020a81b3c1000000b0054198954ce9mr24990ywh.9.1679357728721; Mon, 20 Mar
 2023 17:15:28 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 20 Mar 2023 18:15:17 -0600
Message-ID: <CAMP44s3qa_CoM_4--UmwYQTgO-5dHh6=jogH-rxF7OXEWr53Lw@mail.gmail.com>
Subject: [ANNOUNCE] Sharness v1.2.0
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Version 1.2.0 of Sharness [1] -- the test harness library derived from
Git's test lib -- is released.

This release contains a few features from upstream and many
improvements.

 * Moved functions into lib-sharness/functions.sh
 * Add simple example
 * Add support for zsh
 * Clarify the purpose of `aggregate-results.sh`
 * Add `SHARNESS_TEST_OUTDIR`
 * Add `SHARNESS_TEST_NB`
 * Add `-x` option for tracing commands
 * Add vim syntax file
 * Minor bugfixes

Many thanks to all that contributed to this release:

     1  Albert Chu
     1  Chris Dunlap
    39  Christian Couder
     2  Eric Curtin
    72  Felipe Contreras
     1  Marcel Schilling
     1  Rafael Ascens=C3=A3o
     1  Scott Bronson
     1  Tristan Le Guern

The previous release was v1.1.0 in September 2018.

To find more information about the release, including download
locations, check the GitHub Release [3].

To find more information about Sharness, you can check the
Sharness site [4].

Christian Couder has decided to transfer the ownership of the
project [2] to me, Felipe Contreras.

Thank you Christian for keeping the project afloat these years and your
many contributions.

Enjoy.

[1] https://github.com/felipec/sharness
[2] https://github.com/felipec/sharness/commit/00d30002218928d11d27d7c30890=
9baf6da6da8b
[3] https://github.com/felipec/sharness/releases/tag/v1.2.0
[4] https://felipec.github.io/sharness/

--=20
Felipe Contreras
