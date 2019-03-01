Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C13202AA
	for <e@80x24.org>; Fri,  1 Mar 2019 19:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfCAT5s (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 14:57:48 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43000 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCAT5s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 14:57:48 -0500
Received: by mail-ed1-f44.google.com with SMTP id j89so20980806edb.9
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=v6Di+h3wqf7YTGZufDRdxzUFyvQ0ngXjKEdmNvA1UKg=;
        b=bUOSY/+RJk/8Fe8PK/92ZyufbLCdaAqIFP1Kxgzm+3vKdjC86mM2g9wll+AGv335Vb
         JVBnNXgswYlH2Z+fLDkQBrtrZY9agkCXK1AI7Ss0taYXLMdsFBAbYThBfAxW5o1qszl5
         MwytBA0dlznGI3n5s3LgUn1jHfRsZIx8v7b9dtxN01B5lKK5H/RiuWZi8mCz3nLWHtCO
         uZ6lzT/Zt3wmeg6PCPKasM1AfCSH5Y6D1a99tfqt3AvbiRJL2s2Q1y3Nx0/NwcXexhsu
         oWGYjXV2m33SS/EIpyufe85YfW7jkrL/M35LddEHs/Z1+Nj8cNoqNq9gJzYLnJtmzhYx
         cT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v6Di+h3wqf7YTGZufDRdxzUFyvQ0ngXjKEdmNvA1UKg=;
        b=i+L4UEZd2PsnIkBG0B6bTZPIgtVLVZAQgnEzZTITphDSjId0NQ6qYGciV3c5ilSXWR
         Np9cF9KskfQ4NGVNXqIcPI8TbNSaG1EFfSVz3kibxaNMAjqysAPSsnqjwNEtuLF4ZAOj
         0UlJinNjD/q6sWU3PnXusXprXnkA6PMYf7pJpS6xHBd5N7M2me6hJGdEA4VcrbW7aajg
         0xwWuH7nKQf1aT5amW2ww4j0gzEQKRlIRkJLHSLIgUHBZWQSpSoFxRLyfIp4dE9cPSFQ
         UrR9rlWmesV58rsZBtCjnX+IBt4HZ9lRaHt8pC5hMYqFFj1u5XwpwV7+l6jh0DsBtxzt
         YUaQ==
X-Gm-Message-State: APjAAAWLAzEEPIP+DYmXdgMwJ2mpvd50nPgXoPlyIm7M/b5LGBSasGAa
        KcKrM8Gf9mnMSmR0MdTFPp5o1RAC
X-Google-Smtp-Source: APXvYqwgfZIP2/5h131q7tQa2v5oJzvKRZ4Bmn2qfrLKveK9ZcuYCknPlkhglpv0XoLS1x4020sIzg==
X-Received: by 2002:a17:906:b350:: with SMTP id cd16mr4250323ejb.203.1551470266017;
        Fri, 01 Mar 2019 11:57:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm5525419edd.4.2019.03.01.11.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 11:57:45 -0800 (PST)
Date:   Fri, 01 Mar 2019 11:57:45 -0800 (PST)
X-Google-Original-Date: Fri, 01 Mar 2019 19:57:44 GMT
Message-Id: <pull.130.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Avoid calling find in the Makefile, if possible
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

I noticed this quite a bit of time ago, but did not get a chance to look
into it in detail: all of a sudden, make started really slowly over here.

The culprit turned out to be a find call, which was in the Makefile for
ages, so I was puzzled why it only caused problems recently.

After some digging, I found out that the hdr-check target is the culprit:
before it was introduced, $(LIB_H) did not need to be expanded, and as a
consequence the find call was not executed. Once hdr-check made it into 
master, though, $(LIB_H) must be expanded to define that rule.

Since I have tons of worktrees as subdirectories of my principal Git clone,
and since I also have a 3rdparty/ directory with tons of repositories I use
for various testing/contributing purposes, this find is quite a little slow
over here.

So here is my suggested fix. It is based on similar code we already had in
the Makefile, obviously also intended to avoid an expensive find invocation.

Johannes Schindelin (1):
  Makefile: use `git ls-files` to list header files, if possible

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: c65a2884eae159bad540135479bc8afe20ff62d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-130%2Fdscho%2Favoid-find-in-makefile-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-130/dscho/avoid-find-in-makefile-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/130
-- 
gitgitgadget
