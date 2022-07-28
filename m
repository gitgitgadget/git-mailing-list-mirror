Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F424C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiG1XCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG1XCY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:02:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CBE56BB9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a17-20020a17090abe1100b001f320df2e97so1491297pjs.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=6udWw/IyaUWpoB5cdu7LBzGoIS8zo+aqcAWvh2j1cDc=;
        b=aATWjvtyCf2snUESIt5NMCGJZeRvdBQMJKIZ3ozKC5qEJuiQ5k5BhoVeFKDVtlUwcV
         pFTlTxazpLjl1opsx5ZdDgxt0zZqWcUbWiYPHEgq+W5KQRGSh0ZMhZmgrkf8100I07NP
         1PMsY2WE3G/C50TCiTPp8Aca6oN34U00NtMNJS87EYzAlfCsX23rlOkavJRgA5C9yvct
         wYiupY4hQxXu9GYIlyOIoJzHUic+BNQdfiHTwD0ugmL82PS+SHS/keNI1c5C2ZPYBdvV
         DRJpvNX22YWBhoBpNY95NlPExA7KgUa1yeUpmCSSAiDYFs7fdwjj4Sl8x1dPwgIeGz78
         7IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=6udWw/IyaUWpoB5cdu7LBzGoIS8zo+aqcAWvh2j1cDc=;
        b=h7Otx6wq6wh+dSpU0TgoowQfQ9ejcdmpWiCCrtwgqXHIjc6fF/Dg/u91Xa5+E/xbfX
         ZNJCpIoG20YTpTc429YvkMJkgpb2Ai8VhOW7pOeKjQWqljELrmC0gED82XU8q9GHxTt5
         r0O26xsVGZgQA2zMKl77z4kt7KZ+77An1hhussuRlUPPzh9D85fZGUnQLFufP1CEDXvq
         UOClhAWVK8+BWX+ZtOG/Sz9x2qRdgZDfht0lUeXsv8ztUdjNY8/bHkbkbjSjsdNm9Xq1
         Er9BiHQ3D4X91aut2XtcLQaOfD0vbct/yCp/7dLZiUImTAq1mkMAV0NQYHLeZiEnArCZ
         B2cA==
X-Gm-Message-State: ACgBeo0S7ga0T4WnPWr0vgZ2oZ3me5+nvkIKVJqzwdQE+DhBj5TlZVXW
        Xr/uW8UIOvHMxYyepognN+z2v/EJ1BCzzGp5fYYT5fuozp91mXzPnd3+bgCjUVK7pybOxmkgpXM
        lja18IJJMMep0jrxFHPhRP9E2OFde2B380ToHlj3xbpv9wBSUoJoFhQRpAxSZYjsM1Q==
X-Google-Smtp-Source: AA6agR5sUcxM34QKj2NMYDTsLo+f1T5turDNqLnL6SxnDG0XwtUK6By5yhvllmAqmLUE2cMoHAX+djPUy37obek=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:4a91:b0:1f0:64c5:2a04 with SMTP
 id lp17-20020a17090b4a9100b001f064c52a04mr1578761pjb.127.1659049342854; Thu,
 28 Jul 2022 16:02:22 -0700 (PDT)
Date:   Thu, 28 Jul 2022 23:02:04 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220728230210.2952731-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to get information about an object without having
to download it completely. The server logic has already been implemented
as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,
2021-04-20)=E2=80=9D. This patch implements the client option for it.

Add `--object-info` option to `cat-file --batch-command`. This option
allows the client to make an object-info command request to a server
that supports protocol v2. If the server is v2, but does not allow for
the object-info command request, the entire object is fetched and the
relevant object info is returned.

=3D=3D=3D Changes since v4 =3D=3D=3D
 - Instead of making 2 rounds trips to determine whether the server can
   handle the client object-info request, the server now advertises the
   features it can send back so the client can immediately fallback to
   fetch if any feature is not supported
 - Fixed nits and clarified some documentation/commit messages

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>

Calvin Wan (6):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  protocol-caps: initialization bug fix
  serve: advertise object-info feature
  transport: add client support for object-info
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.txt |  16 +-
 builtin/cat-file.c             | 225 ++++++++++++++++-----
 fetch-pack.c                   |  52 +++--
 fetch-pack.h                   |  10 +
 object-file.c                  |  11 ++
 object-store.h                 |   3 +
 protocol-caps.c                |   2 +-
 serve.c                        |  10 +-
 t/t1006-cat-file.sh            | 348 +++++++++++++++++++++++++++++++++
 t/t5555-http-smart-common.sh   |   2 +-
 t/t5701-git-serve.sh           |   2 +-
 transport-helper.c             |   7 +-
 transport.c                    | 110 ++++++++++-
 transport.h                    |  11 ++
 14 files changed, 734 insertions(+), 75 deletions(-)


base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
--=20
2.37.1.455.g008518b4e5-goog

