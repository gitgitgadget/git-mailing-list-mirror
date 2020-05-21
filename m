Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60F8C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9499D20823
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ga5oFA0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgEUSyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgEUSyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:54:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E6AC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e139so6484996ybc.0
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lc9eZK2MgJ4dYdTCedCpEcBKw9hOEglwiIzMmKvjgtQ=;
        b=ga5oFA0c2k+J94MfaitlAQW0GDpwRpeYgPZOfNaT8VsMbmBKpfx5WzvAaB4fr7zze8
         9O4N8yB+hfhumH6ZJPpqqcleAE/gy1o3otBPMkDwlCHvybdbgwLipwmj0i1JEnl0hvGV
         znBrzT8M3OrRCq2QBx3nD9qv5SWx8tlE/I5oxps04/dYHVDPJgveTlMiUrYrXcftmIfR
         nxCy9G9P6VhFNOA5Qdks/yLFfKnK7WYpYHGrtTIxd9KRDUMPJ+m7s+yPoBKU7+p98oBo
         qDdQTrSnLD7czrE026qJaBqBDgcYRqhzkCvOzcFwld2A/Cpeh5xDV6+q/8kFtwt2X3KH
         3gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lc9eZK2MgJ4dYdTCedCpEcBKw9hOEglwiIzMmKvjgtQ=;
        b=SSc2dv66yq5VG9Uj/dgQYghYyEcZJmKYVgASzHaJ/5kxBE9Ul/MoZ5BOknzaKd3VMC
         AHWdSJNu4RXZL7WzaLItbpz1+rf22waSKGikO0WuuRl1JYicWTVsuRpSbdOTjxXE02sR
         HLIdZF3OTXGVtvKcUYKOuhBEQtd7u15eUgpYLZBE+OVD+XJrmynzQoygmhCI+EYZ4dhk
         MFSJ99kPOmHBxek3fDAuXCIeOwILP5GwH4ihRQDzxrolUDgY3SODHg1SGOVZ2xcYBIEM
         zAElSXpRyb3AoBX6f50YO+MSC5pbSZ0+MW7+O3TXApPjEGL6GiECzHpM9KvHgOFQEiIo
         wcqQ==
X-Gm-Message-State: AOAM5315ZFx+DS48Yv/0A+JRPuJPN8qChhm/2SrB13e5mBviamovMhKb
        RFYU+r6JEUd7c22l2HD2AgLRfb5vrk8bRy9CGpFGZK3RdhEupyGI+L6GbqsA0NokwhLkHQmLxTJ
        3R0tf9PhUm2zaXiq5M4Ygi5AxpvhKEWhi2sCKWvSp2kl4S9GXOq4dN7609LMICWabirBrvXFgsA
        ==
X-Google-Smtp-Source: ABdhPJxOxt5NuPYO++RB+a8VTa88JytO1ZR4HHbaLB7iWNnJGVUd5KTixxyVsc5zTrijTKzBLAzirftg4cWq3UtSOis=
X-Received: by 2002:a25:684f:: with SMTP id d76mr18150914ybc.18.1590087262359;
 Thu, 21 May 2020 11:54:22 -0700 (PDT)
Date:   Thu, 21 May 2020 11:54:10 -0700
Message-Id: <20200521185414.43760-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 0/4] propose config-based hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements "Stage 1" of the config-based hooks rollout
process as proposed in the design doc. It does not touch the existing
hook implementation or change the way that Git functions - it only adds
a new, independent command.

In the design doc, I mentioned the possibility of including 'git hook
add' and 'git hook edit' in this stage. However, I'd like to get input
from our UX team internally before I get started - I know my own limits,
and coming up with good UX design is one of them ;) Unfortunately, I
won't be able to get time with them until the first week of June, so I
haven't included those commands here.

The series is listed as v2 because I included the updated design doc
with changes pointed out by Junio and brian. That's a good place to
start if you're reviewing the series for the first time. (I'm also
breaking thread with the contributor summit notes to bring the series to
the attention of more contributors who may be interested.)

One point I'd like discussion on especially is the '--porcelain'
command. The intent was to make it very easy for non-builtins to run
hooks; but I'm starting to wonder whether it makes more sense to include
a `git hook run <hookname>`, which makes parallelization possible in the
future if we decide to implement that. Even if we decide it makes sense
to keep 'list --porcelain', I'm not sure what information to include;
providing simply the line to pass to 'sh' seems a little thin.

The next stage from here is to migrate internal callers who use
'find_hook()' now to call the hook library (and teach the hook library
to call find_hook()), which will essentially turn on config-based hooks;
does it make sense to include that stage at the same time as this
series so we aren't checking in unused code?

Thanks all.
 - Emily

Emily Shaffer (4):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: add --porcelain to list command

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/git-hook.txt                    |  63 ++++
 .../technical/config-based-hooks.txt          | 320 ++++++++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/hook.c                                |  77 +++++
 git.c                                         |   1 +
 hook.c                                        |  90 +++++
 hook.h                                        |  15 +
 t/t1360-config-based-hooks.sh                 |  69 ++++
 11 files changed, 640 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.27.0.rc0.183.gde8f92d652-goog

