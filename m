Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68661F404
	for <e@80x24.org>; Tue,  6 Mar 2018 02:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeCFCRh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 21:17:37 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38119 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeCFCRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 21:17:36 -0500
Received: by mail-pl0-f67.google.com with SMTP id m22-v6so7468494pls.5
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QIQ4DjTAJGQQ/5bD4UiQuvu5RfBywYHntl51JjWvzW8=;
        b=QcnU4L5vXXO4Rn4rX+V7wHAVe+tGzZhfjesAoJ2cAJ2XUVsoqkGlTvtDN9D2pYjiPs
         WI9YTcqB9lWSUsE6Vb+MMgXHt9PRZC95bKXcdePkg92xP2u8Dv2kX2c19GgkLkSapytT
         sjSS37tQ5drdZlC9nhInsrXmTN62bnVyUzHeQMZj2Lyw2CV7OJscsEuKiiHpsikPGfaY
         w4xlSjzRXHhzIEUtGaCZ97AvkYxBu1cEdrKpt5A3qjWjQ1Q7xepQoNOua6BgFqOeXTBF
         PW2momCFl0EQNVZ4KAVF1DNMagcnd6m3+W9H/kQi0YNPOuBc1jkk8FcIArCFCpgY6gBl
         UNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QIQ4DjTAJGQQ/5bD4UiQuvu5RfBywYHntl51JjWvzW8=;
        b=Y7caYiZYCZBe6dUCXoqEgsgCtwCK5raSfaPJiKd04kXHnQlzHOODOj78eKZwvleoqv
         N7GpV/juctrrxE30vDjLiFrgKskQ7I94w8w02aZshvmmloN5b0YhP3n9V+JpR95JOOJe
         dRfdtQBsgfJ9We09s+umPB0vXCPUyNnKddkjpvEtonz7QPPhkvvRG2/euX/8CWiDnE6m
         xnI1kvsIpmkMl/hdSaAK+dHWfXBBgqNA6FIozbRBN7Pgmi1O3DAAR77SQLFFlTUGxhxW
         jiMV1bgc4tcdnnLLq518I2I8pNP4VZsSUikmpCoMAROewbhHNo9xWSQdDL3p/pN+KMtv
         ZCjA==
X-Gm-Message-State: AElRT7FUzQa7SBg5+Lz1IwK+Pf+Ld2mZevQvuIrvPPRP3rvduS9NzlkU
        cubb0UEi+XPUpYhXI13WrS1SgKtXjX4=
X-Google-Smtp-Source: AG47ELtOa0keMQyfsBGHMm/FI8zX2V2VQxfCkWyl8piv95fif6gyP7fv9kRtXpPKjxSoNYtRvKSkjQ==
X-Received: by 2002:a17:902:8d92:: with SMTP id v18-v6mr7653811plo.21.1520302655713;
        Mon, 05 Mar 2018 18:17:35 -0800 (PST)
Received: from localhost ([2601:602:9500:3a4f:8042:ad20:287d:7753])
        by smtp.gmail.com with ESMTPSA id t126sm23443752pgb.85.2018.03.05.18.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 18:17:34 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/4] Teach `--default` to `git-config(1)`
Date:   Mon,  5 Mar 2018 18:17:25 -0800
Message-Id: <20180306021729.45813-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.15.1.354.g95ec6b1b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a patch series to introduce `--default` and `--color` to the
`git-config(1)` builtin with the aim of introducing a consistent interface to
replace `--get-color`.

Thank you in advance for reviewing this series; I will be more than happy to
respond to any feedback seeing as I am still quite new to working on Git itself.

Thanks,
Taylor

Taylor Blau (4):
  builtin/config: introduce `--default`
  Documentation: list all type specifiers in config prose
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `--color` type specifier

 Documentation/git-config.txt |  21 +++++---
 builtin/config.c             |  36 +++++++++++++
 config.c                     |  10 ++++
 config.h                     |   1 +
 t/t1300-repo-config.sh       |  16 ++++++
 t/t1310-config-default.sh    | 119 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 197 insertions(+), 6 deletions(-)
 create mode 100755 t/t1310-config-default.sh

--
2.15.1.354.g95ec6b1b3

