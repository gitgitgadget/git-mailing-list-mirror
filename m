Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B75C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDLUGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 16:05:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1F1B7
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:05:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l18so12015160wrb.9
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681329957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fgZmbmQHvUSHE1W+6KPZx81IcBByc/JzrADZmMWg92s=;
        b=G4Q+BcvPRRNHMzsNxpPZDgmzjUd7PbJVi+HeboIXSXkFB+ZOW2NVThuhBO/HTvMHCH
         txhJDryhJwZX/ki3155ZcOJFiB6hHqlbm2j3E0GrZbd4Gf1h2j369aYmJnAxqvg/XvuL
         cCYQDv5Xd/eOFyDLMY36HK8BwmbMqW3iH0M3rzmaqkToaqnNHxxFTxK8JH0mAgr2P1MX
         9ie5PD0dskI/FXdTuoxBe3GTEFVgpxikriWOhrkJnWx1BvHpNxlrQKgICaBO6rL08EX4
         hhq601D7ycRH4M1yzVivq9+UTNNbO+Y5PjJGOaAVV+yj8hK+dnyGuLn0j0xk+objrM3I
         Ae8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgZmbmQHvUSHE1W+6KPZx81IcBByc/JzrADZmMWg92s=;
        b=jwHDT+gilfjYVyIScV2DKQPxkbNT+LlgDCLgF93GUcW4V0ZsciWnDC7aJfjNGb05lw
         UTPjm5sX6o0RO5vNycx6gSdox4zXCxNTKYEM4qyYuazZmRsCiTlWLGGEWZgo5abrNbiT
         vyXYjcrQhHV4CsviBNW9K/qTxpi29d7J6keq93U76K59Orn3TyJ9jFCt8NF0UO3ZQ5jA
         tI1nQ0zibnsj5y5Qh51LelsM2p4kvlw6ovtfcwL/6o3xinzxDWSEkS6z1Ac0719SYmpu
         3dcFwwPn+fwvMu24WAmyhQdopakfwrmFxc6HXJfq0hl/CCKQjTyxarmWS+OMYLzTnb6i
         E+LQ==
X-Gm-Message-State: AAQBX9fkGOmFkvgbu+N+Zd43/qRr5hYGtyA4WdTAm9XFw4Ku1cou3Kec
        d1E5ncqFN0w9oIfOonOf3GAprDnKoYw=
X-Google-Smtp-Source: AKy350aD/WBs/fWPzitR07RxPCA996o5RIoLBAkaF3btZA2raVtNEKUIM8M3kDkUYzJyGu9lPk7Llw==
X-Received: by 2002:adf:e54c:0:b0:2cf:f44e:45e1 with SMTP id z12-20020adfe54c000000b002cff44e45e1mr2439479wrm.19.1681329956719;
        Wed, 12 Apr 2023 13:05:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d58c3000000b002c55de1c72bsm17893411wrf.62.2023.04.12.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:05:56 -0700 (PDT)
Message-Id: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Apr 2023 20:05:53 +0000
Subject: [PATCH 0/2] cocci: codify authoring and reviewing practices
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the followup to the discussion in [1]. Sorry for the delay.

I've tried to incorporate most of the responses from that thread as well as
suggest some guidelines that I think would make the authoring + reviewing
process smoother. I've opted for stronger wording to make the guidelines
easier to follow, but I don't feel strongly about the specifics.

[1]
https://lore.kernel.org/git/kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com

Glen Choo (2):
  cocci: add headings to and reword README
  cocci: codify authoring and reviewing practices

 contrib/coccinelle/README | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)


base-commit: f285f68a132109c234d93490671c00218066ace9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1495%2Fchooglen%2Fpush-lsxuouxyokwo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1495/chooglen/push-lsxuouxyokwo-v1
Pull-Request: https://github.com/git/git/pull/1495
-- 
gitgitgadget
