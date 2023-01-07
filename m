Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E600C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 04:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjAGE72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 23:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGE70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 23:59:26 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DD80AF7
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 20:59:25 -0800 (PST)
Date:   Sat, 07 Jan 2023 04:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673067564; x=1673326764;
        bh=uOU159f1xBFFudgbruc4Svi6HWCXAyh3kqVg7dmaZcI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=XWto9QPeU7Gy7cjfkcaKoGEORKACVbBnJKN24QuEMR9WWAlKzhBKBPGaplKdPh5DH
         aoVo+ua6zJLKjyeP5BAleuiA8onG03v2JDOqAr7hvpzkJfS6jlM/3DAK5cspftWJy9
         JLidb70/dg1UlgCtFPLW2HFE5vqdOs+3bz97zuobAdZqG25XNYf5KpARt/uhtvpYCQ
         pahfVn2v2vwrNnhOy08/lVprtN9KhRK/1oEgDV3utBfR3f6Lo1DQX7egn8M+rxvwpO
         DbsMJKwmDs3x18yc6xvLMNo8h+N9J0yZ95MwipOmAb4uOkx4kkLnAhXN1u9thKT00e
         7+G859ecSjL5w==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v7 1/4] worktree add: include -B in usage docs
Message-ID: <20230107045757.30037-2-jacobabel@nullpo.dev>
In-Reply-To: <20230107045757.30037-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document `-B` next to where `-b` is already documented to bring the
usage docs in line with other commands such as git checkout.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 2 +-
 builtin/worktree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 063d6eeb99..b9c12779f1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [-b <new-branch>] <path> [<commit-ish>]
+=09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4a24d53be1..ddb33f48a0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,7 +17,7 @@

 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
+=09   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
--
2.38.2


