Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E1C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 12:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjEGMGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjEGMGd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 08:06:33 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E48D132AC
        for <git@vger.kernel.org>; Sun,  7 May 2023 05:06:28 -0700 (PDT)
Date:   Sun, 07 May 2023 12:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1683461186; x=1683720386;
        bh=fAO2i91IOn7YgmhgQbDw22dlL/NZ9iHIA4EB/RgWTw4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EVx8yPbChEpF+3wPjQKznziiDOLR4XsEM+gVIwrJpbrSwISrfN5S2bePb1xcXPwa3
         JqgQuJ6MLQuSPotVDg20QTp55kQSJ2zW9AIek236CTXJsuJz02qI72hNI8e8ZFCbWU
         LLR7cvwHlyjH9dR2EzJtQYYKkr1HGyVFcnyWsqtc4bIGJIhF+M2+G5SIG3/uqEEqpy
         zOykWcRGg2C2j/APus7ac1rQniyIHCngTA7yBJYTT6mUHLyvKcPHLb8vap62PX9rU4
         3iyxq1qLVLOFxj7kpUQpT3DHdSFl2re+hie7gIYpc3WKjdEm0p3cWlh6KoBVHIqZ8c
         FILknj3mDKRIw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v10 2/8] t2400: cleanup created worktree in test
Message-ID: <20230507120530.14669-3-jacobabel@nullpo.dev>
In-Reply-To: <20230507120530.14669-1-jacobabel@nullpo.dev>
References: <20230507120530.14669-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..a3f108347a 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -326,6 +326,7 @@ test_expect_success 'add -B' '
 '

 test_expect_success 'add --quiet' '
+=09test_when_finished "git worktree remove -f -f another-worktree" &&
 =09git worktree add --quiet another-worktree main 2>actual &&
 =09test_must_be_empty actual
 '
--
2.39.3


