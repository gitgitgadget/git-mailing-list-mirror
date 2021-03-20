Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E6BC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D50F6196B
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhCTOmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCTOlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 10:41:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DFC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 07:41:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d191so6962999wmd.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5I51VK7tCnfvCGua4pe0nrUUPH7oWnHJ109FPoiN6Q0=;
        b=QYrPdKKsrmWT8IMb4xGTNqZccC83ESP8ebdzLdy3WJhMDHbGnR1bgg6qa2/pSoA+cv
         MVBs7ElOELqnZdpTiXJv+p/w7vs3DzM59tcNsW3cImHptfyEyQjrUGDhn62Y+uSvw9B8
         Eltc0eNLZTPykiy0Tl6a+jlA8eBMgEttzpCkabvHCq+dXMs+zch43thTnsrk/tRLiZHe
         Ebx4kyQW8rTnzAFKpvRSoKZHLnf9h3dMcp/EHlXJeeKA0bCXX7g0/WSukGelpwneQ9Uu
         jWAPLu/G3tFha30G4SK6l1zOaPfgD9jl5Yo/rXnY4/19kVbtNrBAh17hnHC71mVhYSzH
         UimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5I51VK7tCnfvCGua4pe0nrUUPH7oWnHJ109FPoiN6Q0=;
        b=UMkjAahtGoZU7wK+gABW4TQYIaOFlm4LvbehHfKQClU5MN7pcK7CqRrzMpc7YuIb0w
         clQmhR7qLt9xd984sny7LKh/myj+3Mb7oRPxrN76zKPc+d+P3538WmGRRhAx5mOIhm8T
         7GKMaWqddubjI+4CynQwaE7aDkOo1giLa/0hhcdz8lz+UIW3IzPkNHOExyVFryol2KWt
         gUXbu+1qQPmqEMUiejfFPKkvR8YEhctx+06fEa/jVtWtLMiK/4hoQrzbRX75sL/1ayRU
         4SmQY/o3nzbi+VLPagxNtRTuIO/3m2uFGLacusBXOnZXtBnzoyVb19/sW1QcXtUCc4CL
         7AfA==
X-Gm-Message-State: AOAM530Nxmt+WN9y2q333IiYClV7PAfinGKSTfZ1zkNwCWroAcIgpt0k
        66Zzz8o30v1Rh0WpeDVe52frU5dy2go=
X-Google-Smtp-Source: ABdhPJxhTdcpMIP2ktEU1kbsfHDKyrDG2rNQxcgWunt0KmEJYc+dtwVNcacDGesGlObon5moizJYiw==
X-Received: by 2002:a1c:dd89:: with SMTP id u131mr7958112wmg.54.1616251300392;
        Sat, 20 Mar 2021 07:41:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm13824828wrg.80.2021.03.20.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:41:39 -0700 (PDT)
Message-Id: <pull.911.git.1616251299.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 14:41:36 +0000
Subject: [PATCH 0/2] [GSOC] interpret-trailer: easy parse trailer value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hope this can help commit --trailer more useful!

Base on https://github.com/gitgitgadget/git/pull/901, The original patch
series was too long so now split it into two.

Helped by Junio and Jeff, Thanks.

ZheNing Hu (2):
  [GSOC] commit: add --trailer option
  [GSOC] interpret-trailer: easy parse trailer value

 Documentation/git-commit.txt             |  14 +-
 Documentation/git-interpret-trailers.txt |  23 ++
 builtin/commit.c                         |  55 ++--
 commit.c                                 |  34 +++
 commit.h                                 |   2 +
 t/t7502-commit-porcelain.sh              | 319 +++++++++++++++++++++++
 t/t7513-interpret-trailers.sh            |  23 ++
 trailer.c                                |  13 +-
 8 files changed, 448 insertions(+), 35 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-911%2Fadlternative%2Ftrailer-easy-ident-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-911/adlternative/trailer-easy-ident-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/911
-- 
gitgitgadget
