Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E87C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A048C60F8F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhKLFBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 00:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLFBI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 00:01:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5B0C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:58:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so13388611wrh.8
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BJDhYNk7f9eVRZ+nN2hkacxhaxOLthBjk+Xayaq+k9c=;
        b=FREH7YSXuKRqsWWly5JmFv++qlptQZv4DbWgOFBWghzEgLjPWWAr5Xp17taa4H5BXE
         YI76CXGSUgTwGorcCkDcltfuQYKkc+kfZik+vDqlpWgKDg6Dfpm8W7KHlE5GtNpnfGTB
         QnY8IKYuXRDgR2XLEUVqrIEafpHFmDUS7Yybej7G9l6c5FQhCADoEojwIbUrHf9SrUjF
         b5ECm2It4QPQUqSOeKUUO2Q+rs+QKF8k7QSY3HJsRihMvfqO7dTo4RPLty//R0n+0Hnx
         sxO7aShcuZ4p7kGSq3fSfoH684utM7QpX+UdMnbYb+gBJ2KzfrOj3kNZV4gpORqmYslY
         CU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BJDhYNk7f9eVRZ+nN2hkacxhaxOLthBjk+Xayaq+k9c=;
        b=S51RqkldI6gphxt1NCnPlmBJC3ahE8rIv1c4eFw6stdnbYnfpJrT7Jsd5boMnto5iP
         TcxsZfeluXamjE39jscAVX/bCoG6JyWXndoVVXvUz82bd9+EUtdFsTlrYVTbQZf52gR1
         R6td1iGPhtg2mg3qlFcmI8nQIkA5HbLuuX1n9+Xkx8qgAkfEHPGHT1yvUZgg328Xm80S
         R78DGfDvVUYqnhWTO05XmoveYZ/kCxkmWqyBr+5jMvlA+UxMS8Gshbmvy54s+HkdBSQ9
         pTIm+wj6OKnvefiJZCPE3hjSPxwhYod4Kn0kuyel2vez0SdxJEzu0QZF+TYsMHGZk2W9
         FHUQ==
X-Gm-Message-State: AOAM530Pyq/NxWP8R1Jt17wwa/hbbQocNz4otTNTE4rel2wdn9DZ91r1
        Ps8hpbX4xOs9qILsGP0XKtRz4pmE9tE=
X-Google-Smtp-Source: ABdhPJyj8NbPKDfGfAkVsallOBwVVjly+TmKZulWyL1oj7UZuM0rNKUYmj2cCTvl654nLXZvsKETAQ==
X-Received: by 2002:a05:6000:12d2:: with SMTP id l18mr15547108wrx.289.1636693096334;
        Thu, 11 Nov 2021 20:58:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm4767265wra.5.2021.11.11.20.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 20:58:15 -0800 (PST)
Message-Id: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 04:58:13 +0000
Subject: [PATCH 0/2] am: support --always option to am empty commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with empty commit message, git-am should support
applying and committing with empty patches.

Aleen (2):
  doc: git-format-patch: specify the option --always
  am: support --always option to am empty commits

 Documentation/git-am.txt           |  5 +++++
 Documentation/git-format-patch.txt |  5 +++++
 builtin/am.c                       | 18 ++++++++++++++++--
 t/t4150-am.sh                      | 25 +++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)


base-commit: b550198c73edd4cc058832dcf74b41aeec2adba2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1076
-- 
gitgitgadget
