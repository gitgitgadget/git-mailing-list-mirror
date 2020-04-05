Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F9C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E284E20675
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5fQftv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDEPuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:50:23 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:35886 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgDEPuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:50:22 -0400
Received: by mail-ed1-f51.google.com with SMTP id i7so15834198edq.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Qmzp2tbtq+o+XZo6FRT1onwIM6ytZcdcQshcw/8etko=;
        b=f5fQftv1+hlmgPhQmg4FFb3Wn3GAGuKm0Nanyz+BTQpa5Tz0nA4oyQ6MuIJspVWe3I
         lc7xuO/KiXPhDsQknu6hA4ScircPtWm0TWWplXvEP6tlk5Q9HGaU8AYo3fn7OrqZeeod
         s5vPfuKaY2qvEopQxhaidrqBBV2ZLhI+SowgeoEUJdBY/dZr02wKfZUG4aaC9zpjVDhA
         iG+KXxTJAf84MIdRp96iJIW1D55Snjw1MWvfp+Rq7OVSHDnH5kFT0GaK3raODFBT4RDb
         9l/29PX0Dp5OEmbOe2E1eGvzSd9UT6Se0z94OoHTMxkyoMqENKSpoPVZ5sGHg770v0lC
         gXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qmzp2tbtq+o+XZo6FRT1onwIM6ytZcdcQshcw/8etko=;
        b=LktarzEpjTr01iCl96dZ2HneL7Q7Doz8ItcPu/m/EmXvRzeSXLx/lWz/YET56vLlig
         DqZrAAphEp+sS8F5b+XKLPSmW9/CtM6+cnGVYttXDpBmdI0PT8AvpuwptJWhYXMMUA02
         F1QJUDCFslb2O4fVn0KljvTlVu1Le4DzCfbatx6SGPgDklOhrQ/IyFoW1yLO7zpqhlW0
         3FhXH5cdvfWJlORcSgAs9U3b+lFHuCH6gdX5LZDXzN4IEjLZIbwmJzORu+jIVw2p6dx+
         iatW+6a5lgd+owCIW9b8+FmxlDTpCZFWFjrxWTDQT07RhA7mHM6qydCaMgH3ConwsfAF
         Pu5g==
X-Gm-Message-State: AGi0PuZkMA/8dCqzLzNUJno3ls72tTLOaKBXgsq40Krq8pMlaEsxHb/R
        DGek0orQEVIZxZ2MnjTnmixy0Gog
X-Google-Smtp-Source: APiQypI+2PRJ2uFtNEoRMIWqofKXSFW1/BgY7J/efgIT1je84V5WVXDuSRVveEOsQDA369Y+oBc0tQ==
X-Received: by 2002:a17:906:b204:: with SMTP id p4mr16869707ejz.188.1586101820283;
        Sun, 05 Apr 2020 08:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm2676893ejo.27.2020.04.05.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 08:50:19 -0700 (PDT)
Message-Id: <pull.751.git.git.1586101819.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Apr 2020 15:50:17 +0000
Subject: [PATCH 0/2] git-pull.txt: correct outdated example + link to specific 'git fetch'
 section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was reading the git pull documentation and discovered an outdated example
description. While reading the git fetch documentation to confirm the
behaviour described ingit pull was indeed wrong, I figured it would be
easier to refer directly to the "Configured remote-tracking branches"
section in git fetch from the git pull documentation, just as in git fetch.

Philippe Blain (2):
  pull doc: refer to a specific section in 'fetch' doc
  pull doc: correct outdated description of an example

 Documentation/git-pull.txt         | 6 +++---
 Documentation/pull-fetch-param.txt | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-751%2Fphil-blain%2Fdoc-pull-update-remote-tracking-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-751/phil-blain/doc-pull-update-remote-tracking-v1
Pull-Request: https://github.com/git/git/pull/751
-- 
gitgitgadget
