Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A499C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED75A2187F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1hi88iO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgAGPHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:07:34 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53801 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGPHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:07:34 -0500
Received: by mail-wm1-f52.google.com with SMTP id m24so19321809wmc.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kZm043ll2+qWjnWExB5ZKIuexjALuf8aAJBgNJ53Rec=;
        b=Y1hi88iOsMoSGdMGl3M6uUKY0Cnibc3e5128euOZ+IURsIC8IzehAni35PEiHlM9XW
         Ae9jXR9ECaCFKhSzo/sG4lgi2RcXE6yBZMSalfu3epL1yyYWkWnJ6r76Gqff91/x74Xr
         iEIiW98h+z4UIXknnSkI5LLKoAFdh0mHThTsI7T2Uibb1Lg3vbYLRHZft6SMAH0kxAvw
         bEOxy2+LO0lMgAcsnZQ9Z9/Npm6LzuL1Gs40AFUq7Adx4hbe0LBdiZySvnVBFQEsPppV
         hT0iwBu6qWaeUuGYBo99EfrpgvNw18vnujUqs+4FBYtvg8vamo2bf6RC55/PBOiCXRk0
         +OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kZm043ll2+qWjnWExB5ZKIuexjALuf8aAJBgNJ53Rec=;
        b=SvQ++F71ZYqv2Y3gFegrfWUmG2JN7ew4cVNqDj4plaEtEcD5JHsZuimMfCubQdQKER
         vQHm7mwMt1zBQ1vuvnd3DKfSVAek0PVjPDsrdT+ccW8GOuQeaS5Z0Zv9CJCcd7rHC442
         Hu8aV3uacQkovSu+D0ZjyOq6ICnUT0wGivLQXK408/vK9BqGMp7e6HmBGhc3Pab6dE/I
         ePtFf5jJtak6ZwmbBWny9f39jCU3VVHuPygWX1ltkFqTnPchw5MJoRi92vYg/fEaLQas
         sA/y4s199rSQVMiVAgdXNm9wE1x/kKudLvHkD4tzCKpj77jfpq+BWhbvQkOEcprsN46I
         0Dlw==
X-Gm-Message-State: APjAAAU4j39Db3TlAa5yIQgaGC1iHhBh7N7pDWJch/YUgpuQZupWoFYf
        ZuTMtFg7otTO30CNsqzGdgzdXxgb
X-Google-Smtp-Source: APXvYqxYdgzoOT/KFGfAKU2VE5OROCIJU0eDE/RX4uLhbH3ycnacgW79JCWkWaDrmDL+hyWNAwR5Xg==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr40900100wmm.24.1578409652236;
        Tue, 07 Jan 2020 07:07:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm155353wrj.23.2020.01.07.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:07:31 -0800 (PST)
Message-Id: <pull.689.git.git.1578409650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 15:07:29 +0000
Subject: [PATCH 0/1] string-list: note in docs that callers can specify sorting function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simple change to the string-list docs to reflect the fact that string-list
now has a cmp member field these days that can be set to something other
than strcmp().

Elijah Newren (1):
  string-list: note in docs that callers can specify sorting function

 string-list.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-689%2Fnewren%2Fstring-list-update-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-689/newren/string-list-update-docs-v1
Pull-Request: https://github.com/git/git/pull/689
-- 
gitgitgadget
