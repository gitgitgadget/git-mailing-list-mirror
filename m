Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A80C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 17:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbiEUROy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiEUROx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 13:14:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE9E666A9
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:14:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so15290102wrg.3
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjKC9ahWgWMZe6zXDTSVsolaxLhiaMyZ74WUV14e92w=;
        b=Se86RQhcvgT0V8bQKnv0/EXu/EqK8HnkUexAH1l7CnldyuPEhMPrW0idN4Ahf8YPAw
         s4Z/Cok91poSKlEGs36MyqTekYKkWjCcGuIb5PqPzbeHw2gq/BX8Mlnb1D6CcPv5DV5e
         DoVRXbQY4lgawfW6xCTajq8EgdcSiLEcltNrcDf9pbLryGuQNPaxvjyz02U2Lc/89QGz
         ZO5YRn06ouxfV0YBmpgSs+i4JQ/MjGEfyi0nihDpZiVVamHSeV7We6ik73dqSCs8CmGj
         Qf6W0bdBbOjJKcdhi1g6zy1Cbw3Mi2mWt8Im1wA5FEOxcrDD330LVeW/+jIjiWgzSiZk
         NU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjKC9ahWgWMZe6zXDTSVsolaxLhiaMyZ74WUV14e92w=;
        b=dIGuWLr5sVqTJEUpHhkEaEjnlpgChxmeGU0En1mXO43de5ZwZwJOvkCXr2+jECsuGs
         HK18TDg/WWOeUq91eFQO3KgtwtDssrqa14Og7wk2m2PsqHxQ6Li8prQ9l3CWcVCQ2FP6
         81cYgvWiC+ooy0oXjT7LeVlvXnAEuQPM8rQz2DwAZzTwg94AZx5fIqCt92iWkMRgvBcJ
         Npy435w3+W6JQfur14aSLh7RxdZuFGAALYAEn+guQIQJFmyNM3mrzDHNjvmEd/VAptwa
         e23AEM4RACob2TdmiuzRIGuqbMwBmhFg1XHQLrNYWAkPBvzhME+zkRSUPM1s4NX2pOSQ
         bOyw==
X-Gm-Message-State: AOAM531EYvpGhV6jiY7vtd1rYWEC4bveytEq3FIJ57b3aEd5/vOX2dSx
        E6JEPdxkG4yVppUBHFOdkWSTQNLXS2z1Ww==
X-Google-Smtp-Source: ABdhPJxKVqWOT6mG59JHz/7iSPrLJv5/3IbwXNJJYmpadP292ODpl2e1Dj960wud9sF+g0tvfp3Mww==
X-Received: by 2002:a5d:5945:0:b0:20d:132e:7e99 with SMTP id e5-20020a5d5945000000b0020d132e7e99mr12580397wri.578.1653153290139;
        Sat, 21 May 2022 10:14:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm4964685wmj.27.2022.05.21.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:14:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] usage API: add and use a bug() + BUG_if_bug()
Date:   Sat, 21 May 2022 19:14:37 +0200
Message-Id: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a bug() (lower-case) function to go along with
BUG(). As seen in 2-5/5 this makes it much easier to handle the cases
such as parse-options.c where we'd like to call BUG(), but would like
to first exhaustively accumulate the N issues we spot before doing so,
and not merely BUG() out on the first one.

I have more fixes for parse-options.c queued up on top of this
locally, including a fix for one (tiny) recent-ish regression, but
found that it was much easier to do so with this new API, as we'll now
be able to freely use normal sprintf() formats in these cases, instead
of xstrfmt() (where we'd also memory leak).

Ævar Arnfjörð Bjarmason (5):
  usage.c: add a non-fatal bug() function to go with BUG()
  parse-options.c: use new bug() API for optbug()
  parse-options.c: use optbug() instead of BUG() "opts" check
  receive-pack: use bug() and BUG_if_bug()
  cache-tree.c: use bug() and BUG_if_bug()

 .../technical/api-error-handling.txt          | 17 +++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 builtin/receive-pack.c                        | 16 +++---
 cache-tree.c                                  |  7 ++-
 git-compat-util.h                             | 12 +++++
 parse-options.c                               | 50 +++++++++---------
 t/helper/test-trace2.c                        | 21 +++++++-
 t/t0210-trace2-normal.sh                      | 52 +++++++++++++++++++
 trace2.c                                      |  6 +++
 usage.c                                       | 30 +++++++++--
 10 files changed, 165 insertions(+), 50 deletions(-)

-- 
2.36.1.960.g7a4e2fc85c9

