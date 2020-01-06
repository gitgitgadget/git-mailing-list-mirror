Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DCAC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D923F20731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 14:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ2suSVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAFOuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:50:16 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:54638 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 09:50:16 -0500
Received: by mail-wm1-f50.google.com with SMTP id b19so15184110wmj.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mYl+MN2IqvXEBJbeiiHKBxmnXi27ZrXVCesrUIbcxdA=;
        b=iQ2suSVsnefcXXORupPUZQcKBQTMGmzPeNPkLXDvBhH7BQDKyzDYTRO1j1K0MRh0C7
         7E05EK7aUdkaRnK0lAknO0okJSTtrcMZRfg/KHaeGDxlRR83jIeUz5z+08VW61nDap0G
         B2AjiSGtyZ7fjRg0pPv5vLFhJLshnkfSTIUtT5hsON2vuTfMy0YXtFCZmeWxggh+Euoz
         Bn/n4Y81iqedzQke0T5ncWSsox532DZsc4bCNq2Ir1f3qSJSQuh5v/qu++jyiqgg+9IC
         q07SiFt7irm5jlJatYjldDaa/YAC3CvUKxR4rlKc6e4jnWONHmn8qIaEj0GQ0uSttx40
         mhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mYl+MN2IqvXEBJbeiiHKBxmnXi27ZrXVCesrUIbcxdA=;
        b=eH37GeOJ8tRbxzLPb96YlN+r+SOz3Bb0+NTojckhIxbkk7YPeqjQAVcRraXQ1qzBRx
         bBhKqaTM8hxE7IQc5hxn8AncqOvGkhsKmVsRfk8SZC0SVllwSst0zJ6uJzp1Zh1ztm+D
         VMjQqqBapeXbNdW0MOQJiZeiFck6azdGkf+RaD5modGKikykdcD5CAsTQhFQw0ra93pt
         Kp3qTMChJdHIoc0SCNSGBhtbDuxIvyq/jR1XpdCWNkQI1hXrZid8cn0h0/8iAbeLFyt/
         745jZeBRt4+RJSzVf/uVig+024utoC35fE0M07x6SAbhmh4/BUuEOK3GFBd+wCrBAKkJ
         qwOw==
X-Gm-Message-State: APjAAAU0WaeXCEWNpaCyb8VUrswvkytuGkMzDlDktzcp2IifTlxZ63fy
        8O+GfR9QqfrEKoat3d/33J/mVlDn
X-Google-Smtp-Source: APXvYqwba1XC/uLK0+plme1olPFDgQsWRnpudG8rp6LdU4GyHMK2bndcIXju6nJ7YA/tea6yWgTf3Q==
X-Received: by 2002:a05:600c:23c9:: with SMTP id p9mr35265131wmb.160.1578322214624;
        Mon, 06 Jan 2020 06:50:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b137sm23935270wme.26.2020.01.06.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 06:50:14 -0800 (PST)
Message-Id: <pull.688.git.git.1578322213.gitgitgadget@gmail.com>
From:   "thomas menzel via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 14:50:12 +0000
Subject: [PATCH 0/1] doc: fixed a typo in git-submodule.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     thomas menzel <github@tomsit.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fixed a typo in the doc of submodule

elonderin (1):
  doc: submodule: fix typo for command absorbgitdirs

 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-688%2Felonderin%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-688/elonderin/patch-1-v1
Pull-Request: https://github.com/git/git/pull/688
-- 
gitgitgadget
