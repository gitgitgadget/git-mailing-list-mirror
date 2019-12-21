Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C07C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A52206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbHA5AOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLUWFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:05:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39647 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUWFD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:05:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so12021889eds.6
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ymv1Oh+IoC7UZmdyaSuJiInJv7EjTd95JhxnTaiwp94=;
        b=IbHA5AOYk7CWEn3e5U7THRD9pdO8dnoQpcGK1HABbWo4iqsopougW7j4eVYlF+dtul
         5Gq+VtS6NY1lRPxqGRPQANesKcN8AxZaf/UFg9lOQKJS985MtoQDLnoyG6kbQQ9amEw9
         Yfh9uRS9j9JwqqQIP9VOOyn9OoZzRvmOSB/YKDraID3rq4E3CifgZGbIROcOsXeenqy8
         2fvTiJVXHb2rBba86FHBbkuoNVnBUxRWhwAQL5/zF6tsuCeCZsmXTIVXyK8B+q69Ezgb
         SvNm8KybhJdKWZVuQ+CV7upHaejKLFeQ4qt1c+RM+bFvJ89xG9nZTxARNBVmYNBr9MV2
         yEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ymv1Oh+IoC7UZmdyaSuJiInJv7EjTd95JhxnTaiwp94=;
        b=GR/tAyfXC0UJOTIPXOBaMOuB5th1SbCyUc/TR00dJ1NosDU5Tl9GD62bb6F0LHwNeW
         h63w3yhjbBjrF3eluh+gaLsyQTMiSwmXpl0vXYkJQmZwGIT+dTdPjkneR7LOPlr+4OyP
         u7yU79X5nl/nIBO7KNgNsPz3CW2ikNabE7hvKlomczK9yHl4+RvhBcbjogCnz16xCyLY
         GT+FLwNQC9Vn29ZusT1qyN39kZojQpYdPKnDJTm8OSNJOUNwPEzxB/VXDPnx7YlWQX3o
         sxg2WAnCCxcycEt2FUIeKT5iUAYRVJSKzuIXemp9q1yO3W/HXjVUk8zXM3ZjqCG8MjeN
         xN6Q==
X-Gm-Message-State: APjAAAWdbdI3u0GoDlmwIfsD8YlEunvQMgFBhD8awN3Vlscqm3xc/j+C
        BKcoA/jVa6gjdRG8IxD3QN8zpyjg
X-Google-Smtp-Source: APXvYqzEbbXgz4XiZ9WW9R5lsLbdMW3YrVsP4jYylyEEHFW2X53VbV4ItZhfekRkt8UwnMeoQJx2Ug==
X-Received: by 2002:a05:6402:51a:: with SMTP id m26mr24058520edv.283.1576965902291;
        Sat, 21 Dec 2019 14:05:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26sm1608760edv.13.2019.12.21.14.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:05:01 -0800 (PST)
Message-Id: <pull.496.git.1576965901.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:04:59 +0000
Subject: [PATCH 0/2] Refuse to write to reserved filenames on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, for historical reasons, file names such as aux.c, nul.txt are
not allowed. For aux.c, attempts to write such a file will result in an
obscure error, for nul.txt the call will succeed but no such file will
appear, ever, instead the effect will be equivalent to writing to /dev/null 
on Linux/Unix.

Let's help users by refusing to create such files altogether, with an
informative error message.

Johannes Schindelin (2):
  mingw: short-circuit the conversion of `/dev/null` to UTF-16
  mingw: refuse paths containing reserved names

 compat/mingw.c        | 122 +++++++++++++++++++++++++++++++++++-------
 compat/mingw.h        |  11 +++-
 t/t0060-path-utils.sh |  13 ++++-
 3 files changed, 122 insertions(+), 24 deletions(-)


base-commit: 53a06cf39b756eddfe4a2a34da93e3d04eb7b728
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-496%2Fdscho%2Fmingw-reserved-filenames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-496/dscho/mingw-reserved-filenames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/496
-- 
gitgitgadget
