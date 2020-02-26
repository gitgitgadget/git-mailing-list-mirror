Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151BC4BA26
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2344224656
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="menUngXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgBZUJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:09:39 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:42685 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgBZUJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:09:38 -0500
Received: by mail-ed1-f48.google.com with SMTP id n18so46727edw.9
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GjQsFoxLSANPVQGUppKgzgkkd7/NX5LpPK5ozRRxv+A=;
        b=menUngXHZLMbyoLVzPzNYALE5cziNeSL52TiTNku1EDyWubh3YUQxUjdFc77QxgR7/
         T03lokAhHSjH+9zZcxRnvQmGtsY4+mJqSEhN1MEO3s2mCteN1wJ+a/WkpoLY9rHQ1p4K
         57oSRax+MyFBW8uirM+hwv6Bfi3bJ6lZMbiutPZE4Mhqvyy0FB2wvqT4hjdtTmZzdzv5
         VANoYWJnB0bSjevlphKwbdkiSOzOKW4vLmgi2iCm36RrEt6iM6boFiisFJ9kf+kBuJmr
         bzESu83mn2Aj5LZMvPolbl+9KnkTEHuEEzAnYwkTz/CMvjeNYWkUFKPCdQe5rFlTXdmM
         uE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GjQsFoxLSANPVQGUppKgzgkkd7/NX5LpPK5ozRRxv+A=;
        b=GNeMpIBNZ5kbOxI6/Rqn80ZcyVLsEADfueiZflWtF7KLK7kjHpDjdAytKnowL3uCn+
         MLrw5hyXEciHqL0RrJcPai6TGw6tiIu+v249Amk28PHZKF9lsIqlmuoz3y0a38MIYGap
         OLr3kbUdvJclJINtKAWd/1xg76oIWxGDpb7uaZvZD2CbeFyPSIbeCQDMuvQb2ytiwTFJ
         qdhT6c/pah9gnRWfCCUiqKG7j2EjFB6WRDCMs1oZQMpL6kioQRGSFuhDiVlD2YcMz2n8
         wSnVbP8L0GzywnJ7bQxX2FVkZrSyQJQVI5303iAWnrR8X613GXeX3sWhprfgiI1xEl4I
         u4DA==
X-Gm-Message-State: APjAAAUledr2Coq4TghqK5yLGOhxNSg/iLcsTAL4+gbWRTQ4Rlv7BSoO
        h+L4BH8hBCkNuF3XTfpvy3e8vsOA
X-Google-Smtp-Source: APXvYqyvzcaPjMAzVBDVWj42dDf8h+hFrlaGAkXmdJZ+Lirg61x86A+gI25dEKK00/TP5F3dUYN24Q==
X-Received: by 2002:a17:907:398:: with SMTP id ss24mr379045ejb.317.1582747776835;
        Wed, 26 Feb 2020 12:09:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba29sm202026edb.47.2020.02.26.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:09:36 -0800 (PST)
Message-Id: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 20:09:32 +0000
Subject: [PATCH 0/3] ci: upgrade to the latest Azure Pipelines agent pools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At least the Windows agents we use will go away on March 23rd, 2020
[https://devblogs.microsoft.com/devops/removing-older-images-in-azure-pipelines-hosted-pools/]
, in favor of newer, faster, better ones. We might just as well use the
latter already long before the cut-off date.

While at it, let's also update to a newer macOS pool. This necessitates two
distinct fixes, though:

 * Our ci/ scripts were ill-prepared to deal with System Integrity
   Protection [https://support.apple.com/en-us/HT204899]. This resulted in
   the p4d -V call seemingly "hanging" (Narrator's voice: it did not "hang",
   it actually opened a GUI dialog to ask the user whether it was okay to
   execute this quarantined executable).
   
   
 * Apparently nobody ever bothered running the Apache2-based tests (t5616,
   t5702 and t5703, probably more) on macOS. I say that because they don't
   work, over-relying on GNU-specific behavior of sed. I rewrote those sed 
   calls to use Perl instead.

Johannes Schindelin (3):
  t/lib-httpd: avoid using BSD's sed
  ci: prevent `perforce` from being quarantined
  Azure Pipeline: switch to the latest agent pools

 azure-pipelines.yml                | 37 +++++++++++++++++++----------
 ci/install-dependencies.sh         |  4 ++--
 t/lib-httpd.sh                     |  2 +-
 t/lib-httpd/apache.conf            |  6 ++---
 t/lib-httpd/apply-one-time-perl.sh | 27 +++++++++++++++++++++
 t/lib-httpd/apply-one-time-sed.sh  | 24 -------------------
 t/t5537-fetch-shallow.sh           | 10 ++++----
 t/t5616-partial-clone.sh           | 38 +++++++++++++++++-------------
 t/t5702-protocol-v2.sh             | 12 +++++-----
 t/t5703-upload-pack-ref-in-want.sh |  6 ++---
 10 files changed, 93 insertions(+), 73 deletions(-)
 create mode 100644 t/lib-httpd/apply-one-time-perl.sh
 delete mode 100644 t/lib-httpd/apply-one-time-sed.sh


base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-714%2Fdscho%2Fazure-pipelines-latest-pools-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-714/dscho/azure-pipelines-latest-pools-v1
Pull-Request: https://github.com/git/git/pull/714
-- 
gitgitgadget
