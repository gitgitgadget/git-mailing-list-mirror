Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7BE1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKOMg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41337 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKOMg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so9352125wrj.8
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Y+Y2LQod9zUyOrfGDBHnTtu6XWOdwDsOtaMLyfZowKQ=;
        b=WJwZB3V/oY4VOoydF2SxxNoXHx5POYt4BJpGR/XSXUx4mKORchAGdhvrM1JpKvMcBF
         gAebvgaaSB02KrBTtYrpOpic6tE1vTaBr+7cgTdEvom5yy207mzTqsJWKClM3mj7kV+8
         gKcjV/3OhgIT3ZEZ50EUP/hMgOaK0x5TFUWrMg8SckRE/PFXh0STCIwBxTrJb8RF6WOR
         IrsFXgTBBS0iwLbuhiUzSRzjgnaqD5OXx4qlBQbBHDj8nIV0ra/zAcdzHvdteT/yEqLp
         SC5A33j2HnfR+5+sIbLxyPV3PPHsV8cbsb47HsKQNtQIaH0582vku+PPziNRO4WKg+0n
         l5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y+Y2LQod9zUyOrfGDBHnTtu6XWOdwDsOtaMLyfZowKQ=;
        b=gcJIXzKlggONEVaB5DCGvLENd1VrtQq2LKsDWsWcsuOn/oSKmtk+5bHuxSf/mMH9jp
         v4ik2HvBzUnXMJCQdhHzMxcW64wxQeeiT6iCsU8dJkQ67pcUR4GG04POsRerwMWLFYT/
         ZepD5fxVlhCNkzqarRACLqgreELrqoA3oMGGZP7UueQRKTQczvFkenDtbV1vQsQlzDN7
         SjHefepdDeu2nHXyb8fVaybJ/Qjwj1Rji66H6P8t4GT2gaIQMr8SlzZ1Lx4T3RRgF2Af
         u5GWi+L2Q+uaxTYn8caGS1V/rqfdCue7jeZ8wWj9zfvmF8oxAA9sAWgST9wnaFA5T/6x
         txQg==
X-Gm-Message-State: APjAAAUbSynoJeAZnSsP6OrvDzgTPUn1+7QyQRL3gwA1iza62I8O/BjM
        K0rqAbAwnIaWmSaO7iChE8JWIoqR
X-Google-Smtp-Source: APXvYqwvN3XpeZrUSRYI8XZr5H9djWshkah8DujMM5QG7T4+B6dhMl8ajnENzP3YLtk9niQ2E0gZVg==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr10770392wri.378.1573821383427;
        Fri, 15 Nov 2019 04:36:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm13876024wrg.0.2019.11.15.04.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:22 -0800 (PST)
Message-Id: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:14 +0000
Subject: [PATCH 0/8] build-in add -i: implement all commands in the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the js/builtin-add-i branch, this patch series implements the rest
of the commands in git add -i's main loop: update, revert, add_untracked, 
patch, diff, and quit. Apart from quit, these commands are all very similar
in that they first build a list of files, display it, let the user choose
which ones to act on, and then perform the action.

Note that the patch command is not actually converted to C, not completely
at least: the built-in version simply hands off to git add--interactive 
after letting the user select which files to act on.

The reason for this omission is practicality. Out of the 1,800+ lines of 
git-add--interactive.perl, over a thousand deal just with the git add -p 
part. I did convert that functionality already (to be contributed in a
separate patch series, see https://github.com/gitgitgadget/git/pull/173),
discovering that there is so little overlap between the git add --patch part
and the rest of git add --interactive that I could put the former into a
totally different file: add-patch.c.

Johannes Schindelin (8):
  built-in add -i: allow filtering the modified files list
  built-in add -i: prepare for multi-selection commands
  built-in add -i: implement the `update` command
  built-in add -i: re-implement `revert` in C
  built-in add -i: re-implement `add-untracked` in C
  built-in add -i: implement the `patch` command
  built-in add -i: re-implement the `diff` command
  built-in add -i: offer the `quit` command

 add-interactive.c | 608 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 553 insertions(+), 55 deletions(-)


base-commit: 2b5d5c1524d62add395da2b0ef50bbbe342362e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-171%2Fdscho%2Fadd-i-in-c-all-except-patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-171/dscho/add-i-in-c-all-except-patch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/171
-- 
gitgitgadget
