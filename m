Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6FC4167B
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 08:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiLPIcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 03:32:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79CD12D0F
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:32:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w15so1728364wrl.9
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=53yYrpuGSbVIHN0VmJLU+NStMOpKM21Sqvp2BkNV7TE=;
        b=WuT7PXsMVwmgpiuo+cawgyJECJiliqVXCIAgsaRJwSkMdl9/x9LOYb2lzNnz5Mtx7z
         8/7Do//KMweMURPJ0wDOrWbUxVAV8GzrL+UbFDDO5t07OPcAlbCgjJQaIjDSnJsVSQWs
         lzp1idYRYya3/Q1u4BpWLa6PsI5FldyW06U5aFQcTPkeXP1iS8fc7C3bFtm4C4wry87n
         C55HoAJdqMTSwR28QNa5XlxSqHpsWGCyIDWj/H5iPdOBRQjEb3cOpmiI10ltkw5z6kUg
         4Vz3d0t+mXcKLNiaF6ptQHjN7sIn2T44KNxCfYpPB+chaMlWnJx0u959wkGnSNFpfy48
         tXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53yYrpuGSbVIHN0VmJLU+NStMOpKM21Sqvp2BkNV7TE=;
        b=XkPhSsj6dS+vRdjWqCLoMiUaYo3z4Yc8cg5gTxAM8lmUJ1vUWGSqS68Yx1DrPKTSvz
         exj3Hrg9pfpxaZb1odP3Kawae96WA7Lbpo4F7UYjEmYTCKZOFciwROCax+C4pDrvrAZ2
         Y5TK544iLGcWqT8TPHnY3Gpq1pMVzgEZhhthInfkwWOFvkIlH0HBTIVLiqAItIfSdddD
         HSWyiRr+t045xIl8xy7b62+drM8/DEmwomYJDyqAXY/VPu3fa8EHnHdzPABkK+8OXZNs
         oj1rg3Um5gA4pSAR9MivwYxhGLJA4FC1BfKXB1z8n3iLdyr+PTbIfSOF4uOTYuuRAUAx
         8J8A==
X-Gm-Message-State: ANoB5pnyPfSE6aW8xZUJ3ipqLd58Gm/VK/ULnSx/9Cwu2KWCbvpcnqZQ
        PXltm2N62QfBwrYw1Lk+jp5Nh4EjkjM=
X-Google-Smtp-Source: AA0mqf5pTC0D+h+TkA0bfFRrLfI/3miYyhp5uyx/3ynMV+JXWRnPQUDV4uzHcmSnoD4h5qp7AZYb/A==
X-Received: by 2002:a05:6000:1803:b0:242:62df:921e with SMTP id m3-20020a056000180300b0024262df921emr20564887wrh.21.1671179521924;
        Fri, 16 Dec 2022 00:32:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b00236c1f2cecesm1840499wrt.81.2022.12.16.00.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 00:32:01 -0800 (PST)
Message-Id: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 08:31:58 +0000
Subject: [PATCH 0/2] Make check-whitespace failures more helpful
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the errors to the job summary along with suggested commands to fix the
problem. The commits and filenames are links.

This is for issue #1395. Sample job output
[https://github.com/webstech/check-whitespace/actions/runs/3707382446]:

❌ A whitespace issue was found in one or more of the commits.

Run these commands to correct the problem:

1. git rebase --whitespace=fix aaa04a9
2. git push --force

Errors:

1. --- 5cd37f6 Remove annotations
   trailing.txt:4: trailing whitespace.
   +
   trailing.txt:2: new blank line at EOF.


Chris. Webster (2):
  Make `check-whitespace` failures more helpful
  Improve check-whitespace output

 .github/workflows/check-whitespace.yml | 57 +++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)


base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1444%2Fwebstech%2Fwhitespace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1444/webstech/whitespace-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1444
-- 
gitgitgadget
