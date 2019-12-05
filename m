Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FBCC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 03:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4186206DB
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 03:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdgxY9Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLEDpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:45:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51755 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLEDpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 22:45:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so2023562wme.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 19:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lhceolk5m9r1YQ5NZF80oS1b4WCRepn4rgSMRUTD3gk=;
        b=CdgxY9Io45eTqjCCRsdk47ldU044XoarQ6UZITgBdR9o++7pA8h3S4I5zWEM5v+2J5
         ZK3c4Nr7OIQ3YH0h+x82+Igg//OEDkaOEZVWfsWRHpTbFKa0v0+GTo1fENvihGFEhpeV
         PPLRD0g8G/0zEflISrik3zh0OrBzQkQtloCqag5bvsLuwopVtfOY+MvrKNVm58q9V3wN
         g6ZfCw6gToMjAAsX//OJX15TeeTooct2uK/9jxuuxmI/wDONEGQcbqvSZKfsudSySOF9
         pd+oY/WAP78StrDNf6AwyIA+zaA7otJ3/zhdiJ+P0wHrzSiwhzDED9jmAl7Qv7ms6F5O
         JF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lhceolk5m9r1YQ5NZF80oS1b4WCRepn4rgSMRUTD3gk=;
        b=GEOcJTMbjsKpccZcSDSzYohsXY3r54qh3s4WtxD38NOwyU6VpCWE168OYjLs5hj05f
         LWYAjx2o7fCyir5HJsFo465m/ItZFHNlFv1oRJRgl/O/rTBCKs72WNiWyNBvLKDl5B8P
         0SVg9Rd8033dDXJd/xqJqXTHmWRwiHHXy7jktl9ejecDQA4yLzZvaNh5Vo3fTLQDkOu7
         ZN2WiWQUcbtTi2gaimLhAlnD56P0qBEZy/EwTvDeHeE8yVgOscLqv247pxqq5yFUd1Zm
         8/+I3GwhvPu26jhXrQyBDwKQ/dkzTiXvG1Yf3FLfWLfGJTyjYQNGXKDC8Q6ETSjKK3c/
         P0hg==
X-Gm-Message-State: APjAAAUeSvWJXZETU3hzj+WjoKmDH0kY+gJLle6TOScdbVyfa9fm3Kk5
        jzFIP5P+fqrnr9phQw/xNJSI32/C
X-Google-Smtp-Source: APXvYqwVA9BaS/PZXP6I1yVmB0urEJz2wzAr+4FwOkCgZh6gKMJBrw54/Jeaf9M8qKtGihpUc9r+aw==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr2735099wmm.85.1575517504493;
        Wed, 04 Dec 2019 19:45:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm10429881wrr.87.2019.12.04.19.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 19:45:03 -0800 (PST)
Message-Id: <pull.482.git.1575517503.gitgitgadget@gmail.com>
From:   "ryenus via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 03:45:02 +0000
Subject: [PATCH 0/1] fix-typo: consecutive-word duplications
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

This fixes unintentional duplication(s) of words, such as the the, and can
can etc. I also take the chance to make a few wording tweaks to avoid
suspicious duplication(s).

ryenus (1):
  fix-typo: consecutive-word duplications

 Documentation/RelNotes/2.13.0.txt | 2 +-
 Documentation/RelNotes/2.7.3.txt  | 2 +-
 Makefile                          | 2 +-
 convert.c                         | 2 +-
 graph.c                           | 2 +-
 submodule-config.c                | 2 +-
 t/t5314-pack-cycle-detection.sh   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)


base-commit: 228f53135a4a41a37b6be8e4d6e2b6153db4a8ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-482%2Fryenus%2Ffix-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-482/ryenus/fix-typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/482
-- 
gitgitgadget
