Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADEC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 06:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EF820719
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 06:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQZVpU1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfKWG2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 01:28:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWG2o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 01:28:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so11132902wrn.11
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 22:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/+9TKBbybG6cm4sOx3HYgLDgmmF78VITTISXFfR46VU=;
        b=NQZVpU1bSwxjWeYcHFPXiCiDzi9I2nR6bume9vPSE63d3Glja54bbVKkhV3NOR1x6D
         yZXVOScT6vzr5gTTGjVrB0HW30Xt2uYb/TL8h+HNgdsfZTJYoUM/KkX/wQws3S2sJPSE
         Ddds09RZ9PFciGcJTuQpvHxiucgWyyAh0HkA/WYcGlpgh/E4Lu9ekeZf5GATxdt42u10
         PYqAfdnAWA56sLQRmq+gVRgKc9yXnsCmRSHqlq+qHgHoiayNrEMV7GQ/7FN7ezvZtYq+
         R81qoVcP/S7z02KnUgK90118p2rzMIsiF7j4d+eO8Im0hIxUTiZ34nIVvAYrHYcyMRjx
         6heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/+9TKBbybG6cm4sOx3HYgLDgmmF78VITTISXFfR46VU=;
        b=bMX2EadDDM4pIudBVbBsBkRTyJdJqPyW+iqziG+O1ndKw0JPlhRU0CtzZo/40gVjb5
         iQ0lfCoxryYkvMdmR6z9dxtJVUC/YCJTWSCwyKN+o3K6gHhTvwHdqk6x965QDp3slUmz
         FlF6lK/sK0M7pfacVNuiIKYtUlS26DATiSehwZZm4ygVHO6wZEbMNuLJ3zkG7xgSyXWx
         igGsmPIHnD0cyCdrt68e8utrW2am3I+y5IuuByWWA3WWMWuFi5Oh2i4FZ0MKocuMAOEN
         mkkBvDd2+R57hiBDv6BIF2cV5SzlxiRdvmd/34bUadIzjBALnlsYf00JxRZK2oKh2xxb
         7Bhg==
X-Gm-Message-State: APjAAAVs+W4grT/X6+8vSM8aSU/aJmDRAQVinxzNg6wapkAcWjlnEm+B
        K41i810yepM0BGWD/Pj8yAKMU8h2
X-Google-Smtp-Source: APXvYqy8/ygpV1wprkoP2BovW0hXA/3tvunq/HqzipS+wiCmqBsemRU6AMEc/3A7v8+NnbNOU2eTPQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr22703157wrp.266.1574490522549;
        Fri, 22 Nov 2019 22:28:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm1007349wro.18.2019.11.22.22.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 22:28:42 -0800 (PST)
Message-Id: <pull.472.git.1574490521.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 06:28:40 +0000
Subject: [PATCH 0/1] submodule: Fix 'submodule status' when called from a subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, when calling git submodule status while in a subdirectory, it
was incorrectly not detecting modified submodules and thus reporting that
all of the submodules were unchanged.

This was because the submodule helper was calling diff-index with the
submodule path assuming the path was relative to the current prefix
directory, however the submodule path used is actually relative to the root.

This fixes the bug by setting the prefix to NULL when runningdiff-index from
the helper, so that it correctly interprets the path as relative to the
repository root.

Signed-off-by: Manish Goregaokar manishsmail@gmail.com
[manishsmail@gmail.com]

Manish Goregaokar (1):
  submodule: Fix 'submodule status' when called from a subdirectory

 builtin/submodule--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-472%2FManishearth%2Fsubdir-status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-472/Manishearth/subdir-status-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/472
-- 
gitgitgadget
