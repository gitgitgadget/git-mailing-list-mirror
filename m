Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7162420401
	for <e@80x24.org>; Wed, 14 Jun 2017 07:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbdFNHfk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 03:35:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35433 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdFNHfj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 03:35:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so6154349wrb.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HmHrAr190GJZfySMf4X/KkhlnbtKuk+AnDtPC0cLUNM=;
        b=Y8ySmwJlmNPMmWDhlNRub9ydGKdoFW1nmaHRvD94NmKo5M4g2EDyNUlFsa8YznUbpC
         HpSuVXlCtRuvKjNt3RK2o3J61DOEKqD21e3NhzeE5bP6ouz58EX9OO5VV0nWRw8DoSfO
         0cOFQ742Dkg12DXB/wW7LIotnSAJM2nZ7z4fgWXKO264BCz5RAv2dtmdjdU4ebf8gij2
         J2wuSBlxqwGOEfehNW2OCMQHihycTPWabbwAnX6kVjIHmNAWUlzpUM6/rQuMFrmqDcc7
         YJaPWQLrAlYUiXIjzKLwTM1eggk6y6JAkUTH8fXOlW9t56cdEgcLUTdRAqacEn+P5UqO
         oZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HmHrAr190GJZfySMf4X/KkhlnbtKuk+AnDtPC0cLUNM=;
        b=Aszstf48gh9zdrp7NmKsmzaAuCjQYh58ig92pswxLD2T5RykMHDvhSjTETtAJftBUl
         FptxPLnj0X6cA+FFvHY5zxGExy4VOflaVpOpjRutWPkb+ifXNIjLFor/oTXUDUMRQdjH
         X1bWxG/TUDYwp5jatBdYmGXVmu91ypyeZHJp2xD8kpHGsQH70PoLT65kZdCZA5nMYtiX
         cwANPRHdKnUW77Ychq0YBSbJ0rS8r8aP4N5xwEIupRkm78ximyprATddhd9Vq05mtyZ8
         7w6OP45CwOjRII/UmwdZUeSBn+WvisL+oY1+r0Ml0Gy8p/WQSDU/0xi2eq1DYB5FVRNh
         hTCg==
X-Gm-Message-State: AKS2vOzbALvWkw3UCR3w2O8MSrgILi5Wq6o4j8D5KT4h9ZMFubKvB4nK
        hAV9egZvJ+eaArzI
X-Received: by 10.223.144.69 with SMTP id h63mr5299172wrh.187.1497425737581;
        Wed, 14 Jun 2017 00:35:37 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4E74.dip0.t-ipconnect.de. [93.219.78.116])
        by smtp.gmail.com with ESMTPSA id 201sm1088543wmr.4.2017.06.14.00.35.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 00:35:36 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, philipoakley@iee.org, jrnieder@gmail.com,
        avarab@gmail.com, peff@peff.net
Subject: [PATCH v3] Configure Git contribution guidelines for github.com
Date:   Wed, 14 Jun 2017 09:35:36 +0200
Message-Id: <20170614073536.45498-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many open source projects use github.com for their contribution process.
Although we mirror the Git core repository to github.com [1] we do not
use any other github.com service. This is unknown/unexpected to a
number of (potential) contributors and consequently they create Pull
Requests against our mirror with their contributions. These Pull
Requests become stale. This is frustrating to them as they think we
ignore them and it is also unsatisfactory for us as we miss potential
code improvements and/or new contributors.

GitHub contribution guidelines and a GitHub Pull Request template that
is visible to every Pull Request creator can be configured with special
files in a Git repository [2]. Let's make use of this!

[1] https://github.com/git/git
[2] https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

changes since v2:
* removed mailing list address, added link with mailing list explanations
* fixed grammar nits

You can see a preview here:
https://github.com/larsxschneider/git/compare/master...larsxschneider-patch-1?quick_pull=1

Thanks,
Lars


Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/ba3e711f9e
    Checkout: git fetch https://github.com/larsxschneider/git contrib-guide-v3 && git checkout ba3e711f9e

    Interdiff (v2..v3):

    diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
    index fc397bb8fc..5a0fb679b1 100644
    --- a/.github/CONTRIBUTING.md
    +++ b/.github/CONTRIBUTING.md
    @@ -1,8 +1,8 @@
     ## Contributing to Git

    -Thanks for taking the time to contribute to Git! Please be advised, that the
    +Thanks for taking the time to contribute to Git! Please be advised that the
     Git community does not use github.com for their contributions. Instead, we use
    -a mailing list (git@vger.kernel.org) for code submissions, code
    +a [mailing list](https://git-scm.com/community/) for code submissions, code
     reviews, and bug reports.

     Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
    diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
    index 2b617f4c25..c81bfb343f 100644
    --- a/.github/PULL_REQUEST_TEMPLATE.md
    +++ b/.github/PULL_REQUEST_TEMPLATE.md
    @@ -1,7 +1,7 @@
    -Thanks for taking the time to contribute to Git! Please be advised, that the
    -Git community does not use github.com for their contributions. Instead, we use
    -a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
    -bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
    -Requests commits to our mailing list.
    +Thanks for taking the time to contribute to Git! Please be advised that the
    +Git community does not use github.com for their contributions. Instead,
    +we use a mailing list for code submissions, code reviews, and bug reports.
    +Nevertheless, you can use submitGit to conveniently send your Pull Requests
    +commits to our mailing list.

     Please read the "guidelines for contributing" linked above!


 .github/CONTRIBUTING.md          | 19 +++++++++++++++++++
 .github/PULL_REQUEST_TEMPLATE.md |  7 +++++++
 2 files changed, 26 insertions(+)
 create mode 100644 .github/CONTRIBUTING.md
 create mode 100644 .github/PULL_REQUEST_TEMPLATE.md

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
new file mode 100644
index 0000000000..5a0fb679b1
--- /dev/null
+++ b/.github/CONTRIBUTING.md
@@ -0,0 +1,19 @@
+## Contributing to Git
+
+Thanks for taking the time to contribute to Git! Please be advised that the
+Git community does not use github.com for their contributions. Instead, we use
+a [mailing list](https://git-scm.com/community/) for code submissions, code
+reviews, and bug reports.
+
+Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
+conveniently send your Pull Requests commits to our mailing list.
+
+Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
+to learn how the Git project is managed, and how you can work with it.
+In addition, we highly recommend you to read [our submission guidelines](../Documentation/SubmittingPatches).
+
+If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q4&feature=youtu.be&t=6m4s)
+might be useful to you as the presenter walks you through the contribution
+process by example.
+
+Your friendly Git community!
diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
new file mode 100644
index 0000000000..c81bfb343f
--- /dev/null
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -0,0 +1,7 @@
+Thanks for taking the time to contribute to Git! Please be advised that the
+Git community does not use github.com for their contributions. Instead,
+we use a mailing list for code submissions, code reviews, and bug reports.
+Nevertheless, you can use submitGit to conveniently send your Pull Requests
+commits to our mailing list.
+
+Please read the "guidelines for contributing" linked above!

base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
--
2.13.0

