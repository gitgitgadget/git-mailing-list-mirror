Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19281F453
	for <e@80x24.org>; Fri, 15 Feb 2019 15:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfBOPRq (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 10:17:46 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33106 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfBOPRq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 10:17:46 -0500
Received: by mail-ed1-f54.google.com with SMTP id a2so8275635edi.0
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BxTbVJqaeBDLVP0H/E2enBB8m7PKD+VYj9vC+RnEXnw=;
        b=hQN/goav/yEw+Mr+tYC0i78EhbMnxmGWJicbwuVHp3lb+yxQauZaiPajoddoy4aRqn
         pyW2wK89koEvX+WytLBAb16Fqp0yqF7JdY8a/sHEoIPdgTULziqKe0XuYhwlQRicIbHI
         F+FGlH86qqb760UfsqiWU1lU7dM6JU6DYxQjEV1kmYgu9KgFYM1v8zoiAnviKFHSvSZI
         sGNa/Wj6Ko1VKKhcJSvE9R2MQJKMF87MNor4XSWFFtLa3mBM4YHAG1zt6nq38eJAH0gR
         Y46AYYsbLwTckBJFw9nJnaRVjN87XFI7fsNMz9EW3VJG/zYoBjbhZrs4tLHrdoGU29SU
         2Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BxTbVJqaeBDLVP0H/E2enBB8m7PKD+VYj9vC+RnEXnw=;
        b=tWTunRbCDnc+xSMsTQcwIJ/hcUhLbS3HKLgY4PRKzyL1+IT9yJ7q+pCRKgKJCBexNn
         SjkMBIbfiXPY+1rEexAyv6tElHP2hpV4ECY1widaf/lhMsE2H5w4ASBVmbSAu46PRMDR
         hLkqUvxEPkAMu5vUL8MWhNcjZXKAvODQbIaH7gkcTdemefhwRwaRMfEtW/VhM88WeerN
         A0QWdBZ+tcM2bs1J0KTy+Jc4IUHyQGpyzRY04giqHc/ehw7AS9D7Anz+II4oaP71qdBT
         22dA0zeYWY/h5Q4KRL6OiF2kcOOZrbxZE4SxnRZcNU78QQe/qGmcG/wcM1XlUvnhLdBO
         Eb4Q==
X-Gm-Message-State: AHQUAuYVFiSWcdEcDLrw+kHkbtf3W4TVoMZLSjtnj9OFHLJxMWTrogqd
        QINu0NHG8mzh0bAYMvDrYzrzJykA
X-Google-Smtp-Source: AHgI3IYepqaxTzKWlQZjaf7gT8OAMLGtc1fpsJb3nOXrm/5DZAyRB9o4ZS2NBhYAvSkKAniTdtwXAA==
X-Received: by 2002:a17:906:5048:: with SMTP id e8mr7097337ejk.214.1550243864980;
        Fri, 15 Feb 2019 07:17:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h25sm386442ejc.4.2019.02.15.07.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:17:44 -0800 (PST)
Date:   Fri, 15 Feb 2019 07:17:44 -0800 (PST)
X-Google-Original-Date: Fri, 15 Feb 2019 15:17:42 GMT
Message-Id: <pull.127.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Safe-guard the Windows code a bit more against getenv() problems
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

We saw a couple of getenv() cleanups, where we now immediately duplicate the
return value of getenv() in order to avoid problems. However, I am really
uncomfortable with the current value (30) of GETENV_MAX_RETAIN in 
compat/mingw.c: it strikes me as low, given that the average number of 
getenv() call per Git process in Git's test suite is already 40.

I'd really like to increase it, even if it won't help problems where 
getenv() is called in a loop whose number of iteration depends on user input
(like the problem fixed in 6776a84dae (diff: ensure correct lifetime of
external_diff_cmd, 2019-01-11)). It will still fend off plenty of other
cases, I believe.

And yes, it's in my TODOs to look back over those getenv() issues after
v2.21.0 (see https://github.com/git-for-windows/git/pull/2019 for my
progress).

Johannes Schindelin (1):
  mingw: safe-guard a bit more against getenv() problems

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 2d08f3deb9feb73dc8d21d75bfd367839fc1322c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-127%2Fdscho%2Fmingw-retain-more-getenv-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-127/dscho/mingw-retain-more-getenv-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/127
-- 
gitgitgadget
