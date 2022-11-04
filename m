Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03810C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKDBDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDBDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:03:10 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706F1D647
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:03:07 -0700 (PDT)
Date:   Fri, 04 Nov 2022 01:02:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667523785; x=1667782985;
        bh=KUQYzxvmmfhg4Yf5iy1EIgw1BpYpacsJzXKNYgw/i3w=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=AkC6IjJSmWjnQVY/6T2PD+W4sGEtqT3jNDmrDjGiOUyiWsEviY7FbsZ6RZKNvBvCs
         Pw33PBiA0I2nghCx8fIcVhwjdBqO8JXI1jfLXZZd1OOwwvKPpzWWF79dC+dRUogQip
         scUXhWUfnFYh1vwO6+yGB//3ilxA3DpxE9ckJdSLP/bJupcoZ4kshRCwPW05YGDkii
         +KydCOlKGBsEm4KJA95837LXyNAiaCSGFWTPAPPpx4odpDLHUsoQjOWN19ybcHFpEv
         jhsphFzr3mEQoGRyvKDMQ4NfwIchStiz4usTFIHRbmdh7vgjIVG46Hu/F+8Z5hWGHy
         vvNrmxPej6y+g==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>
Subject: [PATCH 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221104010242.11555-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working with the worktree based git workflow, I realised that setting
up a new git repository required switching between the traditional and
worktree based workflows. Searching online I found a SO answer [1] which
seemed to support this and which indicated that adding support for this sho=
uld
not be technically difficult.

Note: This is my first patchset for git so please let me know if there's an=
ything
I should do differently to improve contributions in the future.

This patchset has three parts:

  * adding `-B` to the usage docs (noticed during dev and it seemed too sma=
ll
    to justify a separate submission)
  * switching from `git reset --hard` to `git checkout` for worktree checko=
ut
  * adding orphan branch functionality (as is present in `git-checkout`)
    to `git-worktree-add`

1. https://stackoverflow.com/a/68717229/15064705

Jacob Abel (4):
  worktree add: Include -B in usage docs
  builtin/worktree.c: Update checkout_worktree() to use git-worktree
  worktree add: add --orphan flag
  worktree add: Add unit tests for --orphan

 Documentation/git-worktree.txt | 18 ++++++++-
 builtin/worktree.c             | 72 +++++++++++++++++++++++++---------
 t/t2400-worktree-add.sh        | 54 +++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 20 deletions(-)


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
--
2.37.4


