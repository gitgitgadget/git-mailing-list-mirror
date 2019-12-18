Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE1C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 01:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D362176D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 01:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/gxthAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfLRBLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:11:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54288 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRBLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 20:11:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so91655wmj.4
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 17:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ngSdRqyl6MraJtxfKfl6BnjgZjU6RAOjliwHtdKkXEk=;
        b=u/gxthAynLLw7IqfFiOmriyo3yO3krk59LpQZ1g5i+Mek0kKmL5w1BlupxhVQYDxbB
         eKsTUZbGh3esYvRY9SAGtd10EiEvhqkTBvzhSnDlLI0Urjv9SDUPj/dfklzROlBfcwgw
         eXLtCwXVv6VPwdat0HDGW45x2aQKgax0XoYzSHbnY7jHmp376zz/iik1y51mFx7QyNLy
         zVLHSbLAfHsNtPx3YjU56zHGDrkizT/xLPajiR9A1fqbPhyQ1zirOfzRssjo+meFflna
         nmYBmrP/RpifxdhlUl2b8RfOOxLAc0o7/RK+9vBcyNLEsUxhMChHCHsXe+3BGg42vwwo
         uiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ngSdRqyl6MraJtxfKfl6BnjgZjU6RAOjliwHtdKkXEk=;
        b=JLQMItJW4prK3wX+6s0Ib2W1cnUdXY/cfer1Fog9SfDut+psqrsYvCRLCfTbaZ1mOF
         Wvf8/lwopUb1CW0/IBMoF0KGcucpbo+hUVMECtm5qghozZkHo82WNv2YdrcxvfVaSaIk
         HnGqHyuuJc8QEe6cGHxuTzOeRI5bNgS2kMcuBLxRSNgYIJf+j9gHyXQ0ij+gn06r90FF
         AIJPVRL/DGKpajhXVNw4pcp8KmcoZdHglZAKnXeZ8X76vTHSMLcjYupS7ypJr4v1Ez2I
         O+robuTKQFUO8n5DRN7dVAS3DPVpkp3q+maj0bYBm4Isevq4eCd3EXxe6m2Dx1d0PR8U
         /BMw==
X-Gm-Message-State: APjAAAVRObBXbapUpLhEzlzSanR6sqVeP3+G4FzZv36b2lXX0oR3Gpb+
        5ehApFW0UGDxaHAgG9f5Q4UXpBfw
X-Google-Smtp-Source: APXvYqxfmU+QfY/y9K1RbNn4AP5ruNIEMevT/u8LLGZlb+bXKk4BNBkwk1cw3WvxuU3qCpx4R4azjw==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr19254wmb.35.1576631465137;
        Tue, 17 Dec 2019 17:11:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm603591wrq.92.2019.12.17.17.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:11:04 -0800 (PST)
Message-Id: <pull.478.git.1576631464.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 01:11:03 +0000
Subject: [PATCH 0/1] config: allow user to know scope of config options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was originally a pull request to the git-for-windows repository
[https://github.com/git-for-windows/git/pull/2399]. It adds a new option
--show-scope which would allow a user to see what scope a given
configuration value has (sytem, local, global, etc.).

Matthew Rogers (1):
  config: allow user to know scope of config options

 builtin/config.c  | 60 ++++++++++++++++++++++++++++++++++++++++-------
 t/t1300-config.sh | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 8 deletions(-)


base-commit: b02fd2accad4d48078671adf38fe5b5976d77304
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/478
-- 
gitgitgadget
