Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1982C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935D120855
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdc1aWZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgILPFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgILPFO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 11:05:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F849C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 08:05:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so3103659pjb.2
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYGnEF/ONN+dXyLtP3qt1y+/h+8AXXrL8aLPL9+lqDQ=;
        b=jdc1aWZStaUWnDI01OhlmfnGxIf1s1wT5qLCSgRwS1tP9clElO8fIYbjztcEvY0OF5
         6JRmHc4lHZp5Gnj63H6mweSXN5yfx70GAI84ycRy5xuexu8isEF/I6O/p7HnmME0clYO
         Xkb6r7xmCBhYjQrqSE1ScGL353qa5W7b+BHPVTX0rtnbRBiNasOO83Xx/AJhCVhaE8on
         uvEbiRbY1tbe46hIWr0Aa7KvqVYCtMc1u4BJzeXkIbYoqosSN3qM73KynNzvvVv5Z2mm
         SU1k6v9FiGjYG6zyUbG3Rb1L4+Bni8Y1H0r5B9bJ2M25CfO2ZmSEs8sO1KR13EnIy3E7
         NbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYGnEF/ONN+dXyLtP3qt1y+/h+8AXXrL8aLPL9+lqDQ=;
        b=OsemLAh8x64IFqmNPVKM3FFA1UjKu/aeFSxeqW59iqZ6Gyt58tbFXRMa8PpuXKhkT/
         PWAJgZLbKK4ih94erPn9XYNP/yeuEinTCGBxlDbOP63afnXsG+3SFaf1/hrYhRiIJFCR
         ukDGIlgxsRdQX3adjBN2Qbza48vMeNMmm+L5dP+vmTGCQ4xDlND9mQfGuzxdVDAdZ3/r
         XRv226Of9vLQA9euD3BjkkI8pupuHCFbe4CvJbZVpCZtSnHOcOMGxK4KrS1Rq3Hy9fs2
         1rY/p346PaWaI0KP9bE9aMM/jdhpU09QQsE04R8za0bAidVLdjclnxX3W0IkEkH3cJft
         Bw9w==
X-Gm-Message-State: AOAM531daBTgNyKymFlkDo0ZZl5kv8omFtoJ6ou2CTmScLyq4h55V+1w
        /uYYS3QGmjOYuT2sLr+wKrPyLeS7eKFkHv8y
X-Google-Smtp-Source: ABdhPJw5nCxcVy9J/VrF8aRUUuFyg9bnF8sqBAg5Kh1UqcNJo9Idn+DmiMVgBvG6isONf6dZOtMu9g==
X-Received: by 2002:a17:902:aa85:b029:d0:cbe1:e70d with SMTP id d5-20020a170902aa85b02900d0cbe1e70dmr6982782plr.27.1599923113253;
        Sat, 12 Sep 2020 08:05:13 -0700 (PDT)
Received: from localhost.localdomain ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id q24sm5479196pfs.206.2020.09.12.08.05.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 08:05:12 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] push: make "--force-with-lease" safer
Date:   Sat, 12 Sep 2020 20:34:57 +0530
Message-Id: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--force-with-lease[=<refname>[:<expect]]` option in `git-push`
makes sure that refs on remote aren't clobbered by unexpected changes
when the "<refname>" and "<expect>" ref values are explicitly specified.

For setups where the remote-tracking refs are implicitly updated by
tools that run in the background, not specifying an "<expect>" value
for force updates may result in loss of remote updates.

Let's say, we have a local branch that is based on a remote ref
that may be updated implicitly with a background fetch. If we decide
to rewrite changes on the remote, and base our local branch on the
current tip of the remote-tracking ref. If the remote ref was updated
by a push from another user, and it was fetched -- right after the
checkout, during rewrite or before push -- in the background, and if
we decide to force update our rewritten local changes on the remote
with `--force-with-lease[=<refname>]` (i.e, without specifying an
"<expect>" value) to `git-push`, the remote changes pushed from
another user during our rewrite may be lost.

The new option `--force-if-includes` will allow forcing an update only
if the tip of the remote-tracking ref has been integrated locally.
Using this along with `--force-with-lease`, during the time of push
can help preventing unintended remote overwrites.

Srinidhi Kaushik (2):
  push: add "--[no-]force-if-includes"
  push: enable "forceIfIncludesWithLease" by default

 Documentation/config/advice.txt   |   4 +
 Documentation/config/feature.txt  |   6 ++
 Documentation/config/push.txt     |   8 ++
 Documentation/git-push.txt        |  22 +++++
 advice.c                          |   3 +
 advice.h                          |   2 +
 builtin/push.c                    |  38 +++++++-
 builtin/send-pack.c               |  13 ++-
 remote.c                          | 129 ++++++++++++++++++++++++---
 remote.h                          |  14 ++-
 send-pack.c                       |   1 +
 t/t5533-push-cas.sh               |  53 ++++++++++++
 t/t5549-push-force-if-includes.sh | 139 ++++++++++++++++++++++++++++++
 transport-helper.c                |   5 ++
 transport.c                       |  24 +++++-
 transport.h                       |  12 +--
 16 files changed, 451 insertions(+), 22 deletions(-)
 create mode 100755 t/t5549-push-force-if-includes.sh

base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
--
2.28.0
