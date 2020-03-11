Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D78C10F25
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC496208C4
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6zW5ipQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgCKFNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:13:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34709 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCKFNo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 01:13:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so923715wrl.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 22:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SD2axCCluzif8fywXP23C61WBqMhtqFLSBpcvbJIdVk=;
        b=g6zW5ipQQWMcdA5/U4mf2mqWBRR9Vca1zzLkiA1DVSvPEcPmkwxPL6za0WZD/zbQvT
         FGXWiyUKmVaYKrD2Si2sT5ORACD6JxqZza4CMyAdIUsiCCQW9QwxZLnPAOeua1YXZ2nF
         husmUfZ7jf/DKumWPf/ja3ARukj39RW5itAPBc8UwUOhCqnght0yXzfrvH6efGKC/FxY
         SvG770Ps29COu7DCPaiu3qUIoLw+QXYuTMSjs09gFwlhvJZLmEccBwTmCc9vmxQM8csh
         /lJXTzRKBm2HGFNOduCAcWLazUKMnT7mulMqfqZ8V7Ey9VMdoj1CQte7XpDt24ztqJW8
         hGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SD2axCCluzif8fywXP23C61WBqMhtqFLSBpcvbJIdVk=;
        b=W8vTW/TVLr1xOZ95nxByRGBPf6EiDdVYNP5O9/c4AdX8GZfbIZUKcuYrxSWl5uO/k7
         OOl9z0qLPGsPEEcOh/avW1Lm7c//GDedmncKnkwlr6BlSlzFSazcdSqFTKe62ys4NgxZ
         /ryHNlsoYLuisTD366KG3p4N7htB7YixFRlJmB/UODjk3vC854UWfI/OL03FUgRIGMp2
         NzDg1cM0aJyF+/fAZ7DqIlwJ018SedtVN+bYNdSuyQRbLjPML5D/seBXyULzZjC7iAz9
         lFqRbIS8u080l7mQ+VYTsGARBrA1GRkIjXL5Y5WFfcDVSojeJE3s9uSV3XFMArIjy6w0
         zI0w==
X-Gm-Message-State: ANhLgQ17W3yDsvFU7rrHHqd0u3AAlLDN1dgFOdhFS7Bec9qyGPm8ZEoc
        5cTHUG7Ab2wOXbGUmCDcrnsflYth
X-Google-Smtp-Source: ADFU+vucwKj9JWfnA3L+hQrnU5zTKbw3f8fcz7Mvm3hmUIbiRYPUXx31MQb/A9WVx2CIZk6OE7184Q==
X-Received: by 2002:adf:f74b:: with SMTP id z11mr2106404wrp.124.1583903622720;
        Tue, 10 Mar 2020 22:13:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b203sm7314883wmc.45.2020.03.10.22.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 22:13:42 -0700 (PDT)
Message-Id: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 05:13:39 +0000
Subject: [PATCH 0/2] Fix 2.26.0 rebase regression and documentation shortcoming
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This two commit series addresses two points raised by Peff about rebase
backend issues, in reverse order of what he reported. The first is a fix to
a regression in 2.26.0 (when 2.26.0-rc0 added the dropping of commits which
become empty, if the last commit in the series was the one that became empty
the rebase would complete without cleaning out state files), and the other
is just a documentation update about a backend difference that we were
previously unaware of.

The first patch is a one-line fix to the merge backend. The second patch
could probably do with a fix to the apply backend but I instead only updated
the documentation to note this issue in order to minimize the risk with the
2.26.0 release.

Elijah Newren (2):
  sequencer: clear CHERRY_PICK_HEAD upon dropping a become-empty commit
  git-rebase.txt: highlight backend differences with commit rewording

 Documentation/git-rebase.txt | 10 ++++++++++
 sequencer.c                  |  1 +
 2 files changed, 11 insertions(+)


base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-722%2Fnewren%2Frebase-fixups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-722/newren/rebase-fixups-v1
Pull-Request: https://github.com/git/git/pull/722
-- 
gitgitgadget
