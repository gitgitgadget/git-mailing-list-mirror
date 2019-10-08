Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432E81F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJHSrq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:47:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41108 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSrp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:47:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so17745805qkg.8
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ/LhTmci3jWKjOCjOF7fqD4rCYbazIWRHRK1r4v6D4=;
        b=oJiubcbwPqdrtEcHSVud3B7EHazDgK5dRSDdnvL1f2c2wAAYjvbs5jbBHDiNeS2b42
         ZmIYFPTEhr2radexKhILPDI37sZQSTvjo9sIiZfx5889LzLXT52HXNqu2Q8MC2OhNkAK
         kTGuny9AvmC7EGO3xpJPHF+quqxWROT2Fa8EIT/XD9DBzv2A1TKp5ISTGO0YTyaVHOL7
         nMQhsejvoDwTccv0Ler0IZEUaVd9+z0w9eTuozC6TE3D3wb98QjSLxhg9MNANUFlfRca
         E08Ab/3bcRHR3KxwyzrsPb5zRg8F2+peTd/990puXPFpj+oOfxAyXEglDsvqehT5tA4g
         v6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ/LhTmci3jWKjOCjOF7fqD4rCYbazIWRHRK1r4v6D4=;
        b=b+8ClgbdoktePnxUbfG7j0HAEvhFB9yELuJrccjnpQtJ/vINVyT6LECMbeI3CXDB3K
         BUZem+MlHDIiorLKH32b+D/S1rtqTC9f9u4X9EbV9O90d3y1PHbA61YtrQCyhHdNOSpR
         ByJF/kRkOpJMS9/RH/Iv1tvemEr5/xsCXfKNjTSjLunV1/3EZBLHWvNLFS8bQRkpgE17
         1GwK4utyl4z1++/OikBbrPTjwmmuBZ67tyjrbuXUSZW5PIcq6pQqn8H/2QZ1tX6BowSe
         tbvQQ3aOgUvSjEflEX7/ng8jNW8kIsVrxGAxGKQNq151fzIefFtYUJLOSZIDbefaNU0N
         Fkhw==
X-Gm-Message-State: APjAAAVm613yiGAyBaMGpzSE90DBKcqOvhw5N4JmOnAjZZii2chmc+ge
        VH+4HPowdUbWOU/v7iCp00+5M4NX
X-Google-Smtp-Source: APXvYqzCQ3L/o59I0wLO6V5gflWGV4rMnbRUkRX0xUknEcqupHRFqL50gaYBmvWXqmhZZh5jYNrIEw==
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr31184463qkb.410.1570560463410;
        Tue, 08 Oct 2019 11:47:43 -0700 (PDT)
Received: from wall-e.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s16sm8185118qkg.40.2019.10.08.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:47:42 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     git@vger.kernel.org
Cc:     kernel-usp@googlegroups.com, rcdailey.lists@gmail.com,
        me@ttaylorr.com, peff@peff.net, matheus.bernardino@usp.br
Subject: [RFC WIP PATCH 0/3] tag: fix --edit and --no-edit flags
Date:   Tue,  8 Oct 2019 15:47:24 -0300
Message-Id: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches fixes the flags --edit and --no-edit. Currently,
--no-edit has no effect.

These patches implement the following behaviour:

- when --edit is provided, the editor will always be opened;

- when --no-edit is provided, the editor will not be opened (if possible),
  otherwise an error message will be displayed;

- when neither --edit nor --no-edit are provided, the editor is opened only if
  a message is not provided and there isn't a previous tag message.

In the future, the fix of these flags and the code factoring done in this
patchset will be used on the implementation of a new flag --amend, as discussed
on the mail thread started on
https://public-inbox.org/git/CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com/.

Lucas Oshiro (3):
  tag: factor out tag reading from write_tag_body()
  tag: factor out prepare tag template code
  tag: add full support for --edit and --no-edit

 builtin/tag.c  | 123 ++++++++++++++++++++++++++++++++++---------------
 t/t7004-tag.sh |   4 +-
 2 files changed, 88 insertions(+), 39 deletions(-)

-- 
2.23.0

