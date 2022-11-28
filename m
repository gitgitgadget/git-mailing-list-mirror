Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E7C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiK1NDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiK1NDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:03:49 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C7BF6E
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:48 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z17so5576627pff.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id4eCs1sr7d1dGqZ3baN9QDh8eJ6t2ViitjCenr1lQw=;
        b=ObGv/WJb0krBKx24ACXXAUDxtwUDp34q750tCTWyFfqH+PZvGFZZzejuJC3zdCP1ed
         +iz88ssLny6+n5s9ieOIwsfAVEeHdMe2q7n0YD7Nt0R18BzywvHjQkgxTQ8G2+J/8TYw
         pANNyDK3fH+aCOa+e1pnYdzEdVwPgZBwQ9khQTqlPJBKhuLQodFycU3IsW3n8GRx3UyD
         1GTSubMnsQh0dMk7AzaAGJhcYzxEpSLH9T1wFmnpB4ukLTzsm4V9B40IkrJE9yv0di0H
         qpif7OnYuZcX4RGZM3YC6ShgqrqYGMUH0sNmEPNYsuhjEi3VOSU6QLttpNOs7kKnAhyU
         T09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id4eCs1sr7d1dGqZ3baN9QDh8eJ6t2ViitjCenr1lQw=;
        b=JK9gquu9dLsHoFJKbLPNwxkyiU0MiJo7srWpVh3v9B/mDTQusF+B9Dqh6YtdaZg5tC
         ywL7IpFxb7nnPzAZldJafAatIakI0NjIU4T1InJmqEkDE84Jq1NkKbUFsXVa9LW23wqE
         WdXVNhs5YaZU/QlCUkwHfyoUa9r7ak3PiTQllbI0qdnG2LdffzluLFm8wr42PAeprmjJ
         yJ0jnzosg0QRx9TYZxVOsn6uajsgDyS9vQEsc5nY2BTXxSensrO5v0g3asCUX6IlN2s9
         3w9zAuwf0tvhb9GEn0JpkqqsyAAOTJ3bdkCR8YWN7tmUIVz2aViCYyIGGH4Plz7f7k5W
         o30w==
X-Gm-Message-State: ANoB5pkTnHREXvjbpowHdGOD3eksMkVfRv12kLA47ZRQTtyLD/cDYY/d
        HvxTOvdQJzixm+Wa/BYqXbaNpJHnjvY=
X-Google-Smtp-Source: AA0mqf6nasfLP0xoXi2l9Kkk9+SS1TFuI+qOgbCRiMe3TdpNgbDPFls/+ZmhZ0ajJB01GCKS2XLC+w==
X-Received: by 2002:a63:2361:0:b0:477:b603:f683 with SMTP id u33-20020a632361000000b00477b603f683mr24344298pgm.93.1669640606063;
        Mon, 28 Nov 2022 05:03:26 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0057409583c09sm7977301pfb.163.2022.11.28.05.03.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:03:25 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/3] t1301: various updates
Date:   Mon, 28 Nov 2022 21:03:20 +0800
Message-Id: <20221128130323.8914-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v1

The first version is based on the "master" branch, and this v2
revsion is based on the "maint" branch. Because only master
branch has the commit 93e02b6e1e (tests: don't assume a .git/info
for .git/info/grafts, 2022-06-03), we need add a "-p" option for
mkdir in patch 3/3.

It's very interesting. Just because the "mkdir .git/info" changes
in the above commit conflicts with our internal reference-transaction
hook which will automatically create a ".git/info" directory to
create some files inside, I found the wrong template issue in t1301
which is fixed in patch 1/3.

Other changes see the following range-diff.


## Range-diff v1...v2

1:  876709e3c8 ! 1:  bc68ffb41c t1301: fix wrong template dir for git-init
    @@ Metadata
      ## Commit message ##
         t1301: fix wrong template dir for git-init
     
    -    The template dir parepared in test case "forced modes" is not used as
    +    The template dir prepared in test case "forced modes" is not used as
         expected because a wrong template dir is provided to "git init". This is
         because the $CWD for "git-init" command is a sibling directory alongside
         the template directory. Change it to the right template directory and
2:  515f6a5619 ! 2:  ae2b2f8afc t1301: use test_when_finished for cleanup
    @@ Metadata
      ## Commit message ##
         t1301: use test_when_finished for cleanup
     
    +    Refactor several test cases to use "test_when_finished" for cleanup.
    +
    +    1. For first of these, we used to clean-up outside the test, but instead
    +       let's use test_when_finished for that.
    +
    +    2. For the second, we used to leave "new" after we are done, but not use
    +       it at all later. Now we do clean up.
    +
    +    3. For the rest, these child.git test repositories used to follow
    +       "initialize what we are going to use to a known state before we use"
    +       pattern, which is not wrong per-se, but now we use "clean up the
    +       cruft we made after we are done" pattern, which may arguably be
    +       better simply because the test that makes cruft should know what
    +       cruft it created better than whatever comes later that may not know.
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t1301-shared-repo.sh ##
3:  17a318c30d < -:  ---------- t1301: wrap the statements in the for loop
4:  4738ad6f8b ! 3:  f1bf255e5a t1301: do not change $CWD in "shared=all" test case
    @@ Commit message
         test case, all subsequent test cases will have different working
         directory.
     
    -    Since the test case "shared=all" and all subsequent will work properly
    -    in the default test repository, we don't need to create and change to
    -    the "sub" directory in the test case "shared=all".
    +    Besides, all subsequent test cases assuming they are in the "sub"
    +    directory do not run any destructive operations in their parent
    +    directory (".."), and will not make damage out side of $TRASH_DIRECTORY.
     
    +    So it is a safe change for us to run the test case "shared=all" in
    +    current repository instead of creating and changing to "sub".
    +
    +    For the next test case, we no longer run it in the "sub" repository
    +    which is initialized from an empty template, we should not assume the
    +    path ".git/info" is missing. So add option "-p" to mkdir.
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t1301-shared-repo.sh ##
    @@ t/t1301-shared-repo.sh: do
      	git init --template= --shared=all &&
      	test 2 = $(git config core.sharedrepository)
      '
    +@@ t/t1301-shared-repo.sh: test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
    + 	git add a1 &&
    + 	test_tick &&
    + 	git commit -m a1 &&
    +-	mkdir .git/info &&
    ++	mkdir -p .git/info &&
    + 	umask 0277 &&
    + 	git update-server-info &&
    + 	actual="$(ls -l .git/info/refs)" &&

--

Jiang Xin (3):
  t1301: fix wrong template dir for git-init
  t1301: use test_when_finished for cleanup
  t1301: do not change $CWD in "shared=all" test case

 t/t1301-shared-repo.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.39.0.rc0


