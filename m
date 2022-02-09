Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4CC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 12:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBIMFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiBIMDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:35 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BBFC036497
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 03:29:42 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k1so3461674wrd.8
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 03:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BAJfRBBRr3D1qphyqjnAYQVy/cFkZvmi6MYCMPUWoGo=;
        b=jqyMc+OAFzSfX9umvFKYdk1xPJdAGveveajZynTSHt5VIn69bed+vxJ+5dVdhI5o1w
         ocjlwu1PdC1mlWteW4s2gnzSRJR3vKGA73BrpUw2LkbzJoYkfzW8C67m+Bb+VCqVNfKU
         q0yiQjo31mDIZHz7SucUAr0ZqISb+lJIJ5R9GwUEupbfpVjA1ngtxGOkx829Vd+TkxI8
         XbvDxbm+BOmSmXn8mJFan+/HHQ8zFt0oQ0ey+K1Yzafi3/Jx5+M2tJJNHFnVVgSfvwSJ
         F2obdvBIr8QkH7FMN1GzHgml448E1205xbwHCus9vBPLD0aTKJd20bPIV5/iEoThXZIb
         4g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BAJfRBBRr3D1qphyqjnAYQVy/cFkZvmi6MYCMPUWoGo=;
        b=pnRTPYlxhw890wZtA7/76g1KPPUHfxZLzyhDk4GXhPFvLccnAD94pGYztUmP6lxUwA
         ddXKm0+kuSWxF73vuWVRTuh3GpqvSd9vq11gdFN9l6PdtCdeMislGlSolukbR9i801aY
         MjAKmrk4Qhy6AS6NJGm4FPDQ9L1f05jyIp5NItrplclxmS2aTzTxL9P7FqMHKc4/HW+t
         MVJXArfroqqev1TeD98dxcnUhTOVoL0bTghZeNaLWcIR3baWP/nXsIzZIKGqA1QTGsdR
         fMX+gnJx9fzko8I7xfTsSIatD3StDeECYH/Nr3xm3UfMacwD05gOUBroVcli+1TrUxw5
         SEoA==
X-Gm-Message-State: AOAM533PeCZNDlYvOY83jwJPkVnE7UZpfgsIeRrZkH0YgK6pl7LWBKwA
        zEYV8xqDj3DxvzNLcEgKk/8OdRPh7oE=
X-Google-Smtp-Source: ABdhPJyYeV62TSQwJNPRYT8z4OF2K9QGtCfIf90vfToIHpKkTTv+cGX3fJ+BDa5sKBYN58TrCRpWgg==
X-Received: by 2002:adf:db42:: with SMTP id f2mr1623481wrj.431.1644406180999;
        Wed, 09 Feb 2022 03:29:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm15423215wrw.116.2022.02.09.03.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 03:29:40 -0800 (PST)
Message-Id: <pull.1213.git.git.1644406180.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 11:29:38 +0000
Subject: [PATCH 0/2] reftable related tweaks to t1410
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adapts two tests in t1410 for use with reftable.

Han-Wen Nienhuys (2):
  t1410: use test-tool ref-store to inspect reflogs
  t1410: mark bufsize boundary test as REFFILES

 t/t1410-reflog.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1213%2Fhanwen%2Ft1410-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1213/hanwen/t1410-v1
Pull-Request: https://github.com/git/git/pull/1213
-- 
gitgitgadget
