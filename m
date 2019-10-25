Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55CC1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 14:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfJYONj (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 10:13:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54629 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfJYONj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 10:13:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so2309991wmk.4
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tbReC92R6IZcUK9B7Nds9xV9az5gNGA8meC63mIdGHg=;
        b=djX5m/77WxtSs+d5QTpPuMQ+3HSZa0SGyENpiBbQ6Xc6H+uLnNSOXPU05zp+LtmXNH
         JnVohFRi79eUabBYDMUCUrnGq3zzyAviWziD9E9pFSMkQ6FwqmmyoBsV0z33CXK4c0/z
         sXVIKl48Xox7mzJ8hLCYChLWtanTZxtyDX+OX6UqT6xSU9wXiCK0Of9HK1uNb7c4a/EX
         r2Pyz6GKx8DXcy+pE7ZIHkN9XWWzJIeNdTFAyN6rFeN1fQbmnMDXezmrKBEEGXIZls9o
         SnYmJzO6Yguw3EL8HjIvPW7GnscopMm40ucGpPQnN6gNiyusOqfTGfGELS8decy+gyXD
         956g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tbReC92R6IZcUK9B7Nds9xV9az5gNGA8meC63mIdGHg=;
        b=GY5ecswrRnnoaIB46DpLcECaTjVxsrSrWCObgd60jdYk4ZY/I0K3L+1Ns/ZSnmWJwy
         Dw6e83v5p9W/TzqF/vmy9hsiK3TzXRyig47bj70iBVLNK5BX2PP+gfpxubooNg3DyAcF
         XHj4ktCIMBWX89dbs56RkAsFiyWwSIPTKObSMLmXAC+7BhFRjBVWhbofps3/5ecAA/iI
         jf1BH3GDpmvEaHS0JI6CbgaYzWKOU3HcqT1wXkYbYebR5Z+9IM/OAkf00KNTFnb5xbks
         eOHz94sVd2rvkVIfJayzpk0b+tjaRd9wCPgWqjOq8PqdAx3tPfurghHZJ4PwviEEWr7i
         nVxA==
X-Gm-Message-State: APjAAAXDrkyiz7c1aOwBc9YoHu5tHjB/R1dSfIdLvihU8+uN63NdoSld
        xsQh1SjcqAo3UfJnD1bugDx2QObb
X-Google-Smtp-Source: APXvYqyPqHFleBXRFyRitaYlF7CiXRQ/qzRacNzZnzU32sP/dGL0grNN+cffybUHD15lFaauSsIKpQ==
X-Received: by 2002:a1c:411:: with SMTP id 17mr1845126wme.122.1572012817314;
        Fri, 25 Oct 2019 07:13:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm2328812wrs.94.2019.10.25.07.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 07:13:36 -0700 (PDT)
Message-Id: <pull.427.git.1572012816.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Oct 2019 14:13:35 +0000
Subject: [PATCH 0/1] mingw: avoid a buffer overrun in needs_hiding()
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

On Unix, files are hidden from the output of ls by default when their names
start with a .. On Windows, there is an explicit flag that you need to set.

It is quite uncommon, though, to hide all of the "dot files" on Windows,
which is why Git hides only .git by default, and it has a setting to
override this default (core.hideDotFiles).

The code to determine whether that flag needs to be set for a given file had
a buffer overrun, though, if the path that was passed into the function
ended with a directory separator. This patch fixes this.

The original contribution by Alex is over at 
https://github.com/gitgitgadget/git/pull/414, and I worked with him to
evolve it into the current version.

Cc: Alexandr Miloslavskiy alexandr.miloslavskiy@syntevo.com
[alexandr.miloslavskiy@syntevo.com]

Johannes Schindelin (1):
  mingw: avoid a buffer overrun in `needs_hiding()`

 compat/mingw.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-427%2Fdscho%2Ffix-needs-hiding-buffer-overrun-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-427/dscho/fix-needs-hiding-buffer-overrun-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/427
-- 
gitgitgadget
