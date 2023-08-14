Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23552C04FE2
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjHNPMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjHNPM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD70F10E4
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so40931745e9.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025939; x=1692630739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l9N7SPN2D6YzNwVDVTsGQNWWmgvfMFgMI8aD9nm+zDM=;
        b=XhE8fnmqWGbP94SC2SNU5rkhwf7zWRBzNM/2IMrQuOi6GAWaL6hf9Qj8oDUC2bJE0a
         D0wZJg6dKQ+NKcVP2uVV4E3xNzSERK4UZ05DYHvV0x/f4dq9lI/xPEGVdM9YtAQhBJQj
         Nhvx+HoZBDoYnKQ/E/+HpHdIhyi/0c10YNkrJMeBqzYDUPYXNMrHYf7sP0cXoAhcEGAF
         dxI/QhKSiWc4B15sVD0LhTYYPcpG38W3pOW8wL/11qD/AKqkGnioFI1fBlyU7bM9ez7S
         EXceWDZySuakxaaHJhREVbwGm/VlbXhCuf+4jol4XYqXw1wlrTaUY6vm7joMALo4OuPt
         2Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025939; x=1692630739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9N7SPN2D6YzNwVDVTsGQNWWmgvfMFgMI8aD9nm+zDM=;
        b=dtgiUmPhI18ciQhQPUsznXWxEVujxn5l0cObHjmXbRRG2C3a50ojpH7XMXETn7pgXi
         81D56F0TBQp/IhP6AsadlKCEtV5u4ebNm+xMMT2XSrcpdjJ/l67S5g9CjJRRyBLQzgSt
         AlWs96bAkc8a9yTN1klNxOxIj1iqpKjX1BjXXNDheFaemmkXA96q/suwcw0rGzCzV9et
         YK70H7RjKuBL4Y0jCXugRsuBlkEntZc8TrSm0kd28GaccaRoqlsImx/tMqHyGxWsYVW9
         0RsPqH1nndM8mJrdEx3fWRWcFInLYUxWsvTeM2gu7Je6afoPokoW+raF4UEJB4vuJnVl
         4Caw==
X-Gm-Message-State: AOJu0Yw2fWRORiOCdAVdhGR+QKV2xLuk4xR/pzNR0r2v6w86CNRDnZkd
        V4eLMQj53sHx5y/ZUegiUzi5JACGQkI=
X-Google-Smtp-Source: AGHT+IFn5NpCcsFF8YkuiNolHl0vz1Iat++aDj1zoTzJ3+fZav6v0UzYOlgxgBHxGSbokqpgAbfVaA==
X-Received: by 2002:a05:600c:21c7:b0:3f9:b30f:a013 with SMTP id x7-20020a05600c21c700b003f9b30fa013mr7893414wmj.6.1692025938775;
        Mon, 14 Aug 2023 08:12:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b003fe577eb8cbsm17430413wmc.44.2023.08.14.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:18 -0700 (PDT)
Message-ID: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 15:12:14 +0000
Subject: [PATCH 0/3] scalar: two downstream improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While updating git-for-windows/git and microsoft/git for the 2.42.0 release
window, a few patches that we've been running in those forks for a while
came to light as something that would be beneficial to the core Git project.
Here are some that are focused on the 'scalar' command.

 * Patch 1 adds a --no-src option to scalar clone to appease users who want
   to use scalar but object to the creation of the src directory.
 * Patches 2 and 3 help when scalar reconfigure -a fails. Patch 2 is a
   possibly helpful change on its own for other uses in the future.

Thanks, -Stolee

Derrick Stolee (3):
  scalar: add --[no-]src option
  setup: add discover_git_directory_reason()
  scalar reconfigure: help users remove buggy repos

 Documentation/scalar.txt |  8 ++++-
 scalar.c                 | 67 ++++++++++++++++++++++++++++------------
 setup.c                  | 32 +++++++------------
 setup.h                  | 32 +++++++++++++++++--
 t/t9211-scalar-clone.sh  |  8 +++++
 5 files changed, 104 insertions(+), 43 deletions(-)


base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1569%2Fderrickstolee%2Fscalar-no-src-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1569/derrickstolee/scalar-no-src-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1569
-- 
gitgitgadget
