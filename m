Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D586B1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 13:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbeLUNRi (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 08:17:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37485 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbeLUNRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 08:17:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so4654195edb.4
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 05:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CORceYnLPUShLiZVIxhJkv+VBLQzKZ77DMQS6CYOb24=;
        b=gOi6wzpae7I1WWDXBgN03OWuRzVI6UXhyOZN2aiUGjgtIPqinAlHqA6udAooYU2zce
         HQT/w0eIFZ+0ZVpeBiF6PLKPCjn7uOpXvvt6UDnUex7PSS+yIIZjXNLRX+0etg+Plj5V
         JIvA0hUuHVZ+KggejeTRUkWWmvHFAu8UunZ6rRg7xPlzQc2+De19QPai03RZyWeF1J3W
         B9aDuiJ8BLXcR/Ae++C3qzt22AWUW6yCCqxJWj1irrMDkd/HYZSWQywvkQ0QxgNgIVvU
         U2CcobZh0V35KSBUz3SCbk8KYUZnRAizwKxzw+q988n+AJBH+V2Pw4lyifRvgb+bB6mJ
         lWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CORceYnLPUShLiZVIxhJkv+VBLQzKZ77DMQS6CYOb24=;
        b=Ezl976VjG+hoO6pbn3gPcQcgzr3rDmEmNYmTHnT89CbcHz/CZ1wIPiiQ5vDCNYxWaD
         HB5Ujn5c1z9UjtOcqtVjLUPpoxw61794LiEjkiCrRwwMNoi/oXTxtfGVKzw32qFEk3Rr
         pYV8G/KEocbe833NWTj77WIiCukzmnMyhmWI60mgbECNdjthedbIantngv9TUl91sZo7
         LBRyCX6Hm3ePfFUL76NuLf7/s7tJeCW3OSg6jyd5KfzTij5SDZsZPIeYTNEN2b/odKI2
         WkTRzW+CrAWBqefV1nnn63R/PCake3i8zh6L6zQ0ohapnBti7AQlhXwEkfLJy/TOUb8O
         3Pzg==
X-Gm-Message-State: AA+aEWbWtFCwiKhYl+XDXNvf++AQyPCiJ8x/ThueoTGuVvgLyS3bXBLF
        upAwvP/+EkqyxH2VGT/kB+DZ/pu68ztVJg==
X-Google-Smtp-Source: AFSGD/W4XuZ3l9EJBrlJooqvYJru1Tl+NXYUBfMKqSsGRUl1/32nDJi+C2m00FiLPNw1aPhspyamvg==
X-Received: by 2002:a17:906:4ed9:: with SMTP id i25-v6mr2044685ejv.75.1545398256078;
        Fri, 21 Dec 2018 05:17:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm6595942edt.6.2018.12.21.05.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:17:35 -0800 (PST)
Date:   Fri, 21 Dec 2018 05:17:35 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 13:17:30 GMT
Message-Id: <pull.24.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] Let the builtin rebase call the git am command directly
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

Especially on Windows, where Unix shell scripting is a foreign endeavor, and
an expensive one at that, we really want to avoid running through the Bash.

This not only makes everything faster, but also more robust, as the Bash we
use on Windows relies on a derivative of the Cygwin runtime, which in turn
has to jump through a couple of hoops that are sometimes a little too tricky
to make things work. Read: the less we rely on Unix shell scripting, the
more likely Windows users will be able to enjoy our software.

Johannes Schindelin (4):
  rebase: move `reset_head()` into a better spot
  rebase: avoid double reflog entry when switching branches
  rebase: teach `reset_head()` to optionally skip the worktree
  built-in rebase: call `git am` directly

 builtin/rebase.c | 428 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 309 insertions(+), 119 deletions(-)


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-24%2Fdscho%2Fbuiltin-rebase--am-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-24/dscho/builtin-rebase--am-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/24
-- 
gitgitgadget
