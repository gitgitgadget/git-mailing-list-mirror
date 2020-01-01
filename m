Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35017C2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 05:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED377206DA
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 05:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm61MDa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgAAFVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 00:21:01 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37343 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgAAFVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 00:21:01 -0500
Received: by mail-ed1-f49.google.com with SMTP id cy15so36499501edb.4
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 21:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kb2WbeImAq8PD5O8QuA+8mGN/H+Euqm8LWN1PZHuEXo=;
        b=jm61MDa9Qodu0m9TvoyY4ZNT5VEOHasZm9te8er+xupqi9qs1oDrtuLhbdNqTmjr06
         S2GmmYl8ZuTwS7NKcHagkz0s1Sgud08dciAr/uRRiqVuqh0RG8QkqmWQYhwNBOeHvcZM
         oA4OyzsJzUGHrpEd0BZEczMYYrExVJJ8V6Icxi/sha90X71zkpi5QXUAQTwHeS7cCr8s
         q6D5s6lT6gwFLuD/qTIWccs1XeKoci+7MHZcdz1wkujEU7tf4mFjx7m6PaY/8ntd7eMI
         +Bos97iQnONT8l3fxYVo8wEKr9gv6OVFWIb7jfO+ksaYEakiWTtlGwAzHaY/xYh/ZG54
         7Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kb2WbeImAq8PD5O8QuA+8mGN/H+Euqm8LWN1PZHuEXo=;
        b=XINJGp/xEbzRfWjwUFIT6VlOp2wNFvOYVXiOK8DUvNUrcMYShcIjYaVuc8uTCUFbh8
         5Nz+K1Tjb79ZF1ZR7vGvLNCFIQHK1WR6OM4MNC4id6m1fe4v1joE1WmSA41cYB8eYRw9
         MheSPBWZsswtPu1wRstVoU/EnkX91gEdC74JXrtmysQq1HhZ1B+ulUXFup/AKWqurFub
         bWqEgLOFfdTsJ0z1szsBXdGV/ut4iXIt0y9CdY3URMN7yVCxu+f0h08k33nJ/Z3kGHBm
         vXbDho3wikD2iXFfpO0qR5aCLExT3to+zyOvj6ZGywLxx+l2zatfJ8Lhdkq7U3Q7iGwt
         Uinw==
X-Gm-Message-State: APjAAAWizY6BK9myk99ey2FQlt3rfVYc9ZBixWVWT8NeAFJGsLZ980RO
        VY6tj60dQ33CbgrbmuQQQPkRZfxb
X-Google-Smtp-Source: APXvYqzNN1ELh44nJJRJsnz1LsCyZcMQN32tSs+eAhSorcyib6oiFy9Zo5i8+hHNiUZYmCeeadCCgQ==
X-Received: by 2002:aa7:d412:: with SMTP id z18mr78800984edq.6.1577856059087;
        Tue, 31 Dec 2019 21:20:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm6109121edj.33.2019.12.31.21.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 21:20:58 -0800 (PST)
Message-Id: <pull.685.git.git.1577856057.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jan 2020 05:20:56 +0000
Subject: [PATCH 0/1] merge-recursive: remove unnecessary oid_eq function
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

merge-recursive has an unnecessary wrapper for oideq. Remove it.

Elijah Newren (1):
  merge-recursive: remove unnecessary oid_eq function

 merge-recursive.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-685%2Fnewren%2Fremove_oid_eq_wrapper-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-685/newren/remove_oid_eq_wrapper-v1
Pull-Request: https://github.com/git/git/pull/685
-- 
gitgitgadget
