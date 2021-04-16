Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD72C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD79E610A8
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhDPX7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhDPX7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 19:59:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F252C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:58:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so28203316wrr.2
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bmLdd12sSTLu1m2M1GAO18oqxs8ewe+p9c1u08l8Q5s=;
        b=ec9JPHPhMLHw1BX+zIjJ8rg/dGTC9zvrDMOnn/OcGWKRfiHqVPVTmEExAxFQ4FvSf6
         MvbIIgIZW3IyvUCQxOZNXMHNAHO34G7Ksm0cWjKc93e2H9gDaSSHHPJwnBaMIkTDGj9J
         xJSLB6W18vEa8yDUtkiPfX7USwIzFVV0KdeQhTJZ50efWf7lq1Nv2vF40fRw1T6x4Kh+
         63F3FE+YaxOv0zJYfxkzBrur8ywSZOZ4FGvg3iFXQ2k29Az3t9KWryLMMU4YcpJI3DKz
         Jx2cAxGE33JW8T1tXwtUgWhqoyrw4z8isKcbKy0zFbdZVdsmV0D9qIn9cCw1jLwKMeTN
         mjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bmLdd12sSTLu1m2M1GAO18oqxs8ewe+p9c1u08l8Q5s=;
        b=DMs0a3kk4k/FM3YxMTjPSl4grcQtMD6acNymnHLRx+voETw9YYrp9Ku5sPMjuoMbv+
         zOPD2l+AkYilYCVy/ZMYM0WcFqzxgDu2J2aCe63bWuKUFMskhh0HLdtSe7mDIDZmjI2m
         m+TmqZifBQDnSPANbX3m6fvSU5sUtfm+qWFETlTpew61GUsxCDh8HXzupD+mtnhyaoyp
         +6fM55gInOkrvJvjBhgpRNfXAessgvvEF5SjruyHuMds6enLY7oZU+WNsEmY803TxFjs
         iJk879jwkiesBSzkTs6b2J4yAByzdwsvNeV182yU2hUqS3zIcvdzq7AMidCMhjuiVxtW
         Gajw==
X-Gm-Message-State: AOAM532YQ7B6sFXkvztO2zt+eheDLWsToFNW+58kwL2NnEoOmH+IniXb
        BVl1wTR8laOTqtIJVBoE2GSoPi4Io5jwOHmDxwzJVIr9BIM=
X-Google-Smtp-Source: ABdhPJyKHWojTMLKU0pO8xhXS8eUKzTGqLsQf11Bd8X3I3LJhvBiSOMzD/W39rWSPAzS6fi4NoOYSkDCvKnb3qmcSWc=
X-Received: by 2002:a5d:6d48:: with SMTP id k8mr1554402wri.93.1618617533919;
 Fri, 16 Apr 2021 16:58:53 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Timothy Kennerly <mtkennerly@gmail.com>
Date:   Fri, 16 Apr 2021 19:58:43 -0400
Message-ID: <CAKqNo6TFudrXnuPzQcOaVQrRpq_0K_fxyyMA5god-WQL7y=RcQ@mail.gmail.com>
Subject: If the initial commit is empty, it is not shown in "git log --simplify-by-decoration"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This seems like a bug to me, but maybe there's a good reason for it. I
reproduced it using Git 2.27.0 on Windows initially, and then I
upgraded to 2.31.1 to confirm that it was still present.

After committing with "--allow-empty", the initial commit is not shown
in "git log --simplify-by-decoration", although it is shown with "git
log". I would have expected it to be shown in both cases:

---
$ git init
Initialized empty Git repository in C:/tmp/repro/.git/

$ git commit --allow-empty -m init
[master (root-commit) bc54978] init

$ git log --simplify-by-decoration

$ git log
commit d7814029effeb7e824e480ca52e30f5a9d1e8058 (HEAD -> master)
Author: mtkennerly <mtkennerly@gmail.com>
Date:   Fri Apr 16 19:48:06 2021 -0400

    init
---

However, if the first commit is not empty, then it is shown with or
without "--simplify-by-decoration", as expected:

---
$ git init
Initialized empty Git repository in C:/tmp/repro2/.git/

$ echo hi > foo.txt

$ git add .

$ git commit -m init
[master (root-commit) 35b6427] init
 1 file changed, 1 insertion(+)
 create mode 100644 foo.txt

$ git log --simplify-by-decoration
commit 35b6427461fe48c0e918dfea2bc5ddab9dc8844d (HEAD -> master)
Author: mtkennerly <mtkennerly@gmail.com>
Date:   Fri Apr 16 19:51:06 2021 -0400

    init

$ git log
commit 35b6427461fe48c0e918dfea2bc5ddab9dc8844d (HEAD -> master)
Author: mtkennerly <mtkennerly@gmail.com>
Date:   Fri Apr 16 19:51:06 2021 -0400

    init
---

For context, this was reported to me on GitHub here:
https://github.com/mtkennerly/dunamai/issues/14

Regards,

MTK
