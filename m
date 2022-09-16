Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB66ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 21:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIPVAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPVAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 17:00:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50032B198
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 13:59:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f23so6298117plr.6
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vzWXB+EdfEVGHXTXISyuCf1voHMei3Io1IQztYy79TM=;
        b=KaYMg+CFe7gCQtQiYHMnkdhSDV6nYA+FevzsEtjS1XArBoAOcuMwo8ncWNzX95FwsB
         juAQXpvtMM4pus3ry7NDORl2/KJ6P67yCLp4mIQ266M3YbWqcKIh3vBWcFOBOYXf1+R/
         IwmPAUadFEx3z5ByKR/cwOOp36X/X2KaVyH7QTI2iwuMSECQAqYPGt+jjnv4alchi4rE
         w851MdiPd0/bfn/ELztoVZSzMnUfiRQenKax/wTjVazxZeDRszp4omsEocq5zZWj9wPQ
         WvLSHSFz0dBrHofscYAvU6Qo79m0ZCCtw31QZRzULzEzjTBIbS8ItOTQzjGZMX+d0DxP
         YRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vzWXB+EdfEVGHXTXISyuCf1voHMei3Io1IQztYy79TM=;
        b=TLcgWPpmBgIWohQjf/Yja5/6/160Qcf78lRgrzlHMaZOZZe/3bezfVgYYAOYtKf0nw
         Wsf9Q2UYqX+PaHijTcEABkd6gRnr74EnRptDRUDz9NZI/IsZq0klXXqaFvAepMp+Trro
         /Zmrp8C0Cm0LNDOmO32ILxDRz1hd4HjfQqocHqJ1Fnd5jy5i3TdlnU0nv0bIKzgavQ2v
         5A3DKgEFqUisqw4ewbJ2XYjMLsXq43loEacRiXzDtZV2HzzjqB4rirR+YJEVjE1m792O
         EDcL49fmyqWdX65nq7DavNRSFE4dEFT7kwTgPOp5S+bgn7k4kvDOAkZWAg4U5VlvRkIp
         RL6A==
X-Gm-Message-State: ACrzQf3Z3G4u18LsbJBxch4aZvl0LPzlwH4qf/OiL+sbirQohzFpdmdp
        2W6dlnUQ0g1z1+/CaxHk2YgSmjuQVA5Wlg==
X-Google-Smtp-Source: AMsMyM6MBPJ8iUkKAvI51hugAyaA86Zcr/EWuLmoIKfKdFKhNpVAFAHsI0z2Ua9fmEqCL0jkgdlFiA==
X-Received: by 2002:a17:90b:4b84:b0:202:ec40:8643 with SMTP id lr4-20020a17090b4b8400b00202ec408643mr18003816pjb.86.1663361996746;
        Fri, 16 Sep 2022 13:59:56 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e81:25b3:3dbb:95ec:385b:406f])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a3d0900b002002fb120d7sm1961568pjc.8.2022.09.16.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:59:56 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/3] Add mailmap mechanism in --batch-check options
Date:   Sat, 17 Sep 2022 02:29:43 +0530
Message-Id: <20220916205946.178925-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0.3.g53c2677cac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

I am working as a GSoC mentee with GitLab organization. My projects aims
to add mailmap support in GitLab. The patch for adding mailmap support
in git cat-file is already merged. So, using git cat-file
`--use-mailmap` with either `-s` and `--batch-check option`, like the
following is allowed:

* git cat-file --use-mailmap -s <commit/tag object sha>
* git cat-file --use-mailmap --batch-check

The current implementation will return the same object size irrespective
of the mailmap option, which is not as useful as it could be. When we
use the mailmap mechanism to replace idents, the size of the object can
change `-s` and `--batch-check` options would be more useful if they
show the size of the changed object. This patch series implemets that.

In this patch series we didn't want to change that how '%(objectsize)`
always show the size of the original object even when `--use-mailmap` is
set because first we are going to unify how the formats for git cat-file
and other commands work. And second existing formats like the "pretty
formats" used by `git log` have different options for fields respecting
mailmap or not respecting it (%an is for author name while %aN is for
author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch improves the documentation  `--batch`, `--batch-check` and
  `--batch-command` options by adding they can be combined with
  `--use-mailmap` options.
- The second patch makes -s option to return updated size of the <commit/tag>
  object, when combined with `--use-mailmap` options, after replacing the idents
  using the mailmap mechanism.
- The third patch makes --batch-check option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` options,
  after replacing the idents using the mailmap mechanism.


Siddharth Asthana (3):
  doc/cat-file: allow --use-mailmap for --batch options
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option

 Documentation/git-cat-file.txt | 26 ++++++++++++++------------
 builtin/cat-file.c             | 26 ++++++++++++++++++++++++++
 t/t4203-mailmap.sh             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.38.0.rc0.3.g53c2677cac

