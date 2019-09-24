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
	by dcvr.yhbt.net (Postfix) with ESMTP id 885741F463
	for <e@80x24.org>; Tue, 24 Sep 2019 02:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394611AbfIXC7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 22:59:14 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39052 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389682AbfIXC7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 22:59:14 -0400
Received: by mail-qt1-f170.google.com with SMTP id n7so422122qtb.6
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=PlTkWNN9OyUFfdj4jNZqScniOeIvLdURNon2XrkS430=;
        b=P8o6VoXHVXcGw5TU206xI7elKVTC6kj5jgjhDcTanapYDARDppCebrPQ+cPZ5Pt1J5
         NguiKbhbkv9aYCidLlrX1xir8QCxQHCCMGkKNgMBKAnPriBpfeIVy5m30p1c0Z00oiYt
         /2esMLXK+fLiv8ty1ljxv3UxnPt1zSI+WNdyX8DrLRLYirlNIuN5sWltTIaeKjsAkrW3
         O9fhSIBxF6eh8aArvDckHRxUk4MAaopculPa+iuT6HWUH/T2YBgRA3e6CmUd5DlpsE2k
         LaQnznnixL5nHYInGWd2GxpzH3uIPLi3cCnrRNZd1KEfJ4iDClF2Ng1P3/ERl3RkN9Zp
         e2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=PlTkWNN9OyUFfdj4jNZqScniOeIvLdURNon2XrkS430=;
        b=Kj/14vSXc7ivgJAqDrnWqT5Oq460dtRUK/aHyoxNnVQPcqr3ISGrIV+4pm0mRaZ4ZR
         ACCuWDg07EYvMQpEBDwayRCKbVR9i/4IiqzsddOIhsOhfShCuaZgqc1/dw+0DZb/vGKQ
         RdbRQNLY36gGoAcMi8DvLSTlprelbSJfvzfoyJq9kgyTia1z4UtdKS7fCCFTNvB7QBmq
         QhZPW6XdEeH5VMnxz/LLlb/KZkUCE+eICK+x9vnzc9IVRiBmHbHTBDLyw/iXpElt9XSN
         3veJN9Srzi8Nid9bNJTj/pcONGoHoxG4BQlMFycZkv5IaX5sQS85FRhVGbwilJZucmtr
         tQyg==
X-Gm-Message-State: APjAAAVSAdw7IYOOqvFVTKhaHyO2LPR1Te9lYVPqpnl34ozU0+wmNZ3Z
        P1UolaGKtaS+Lovu+kDVUsnhQVXB
X-Google-Smtp-Source: APXvYqz0GTWmdSXl+XzSrDksrJkMoeoogp1fXm9HJzlas55IEDhwcLD0T3pA/nrAkTW5uBZ5NrXplw==
X-Received: by 2002:aed:32c6:: with SMTP id z64mr673914qtd.202.1569293951491;
        Mon, 23 Sep 2019 19:59:11 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id d133sm375440qkg.31.2019.09.23.19.59.10
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 19:59:10 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [BUG] Adding a submodule containing submodules in a branch and checkout --recurse-submodules
Message-Id: <7437BB59-4605-48EC-B05E-E2BDB2D9DABC@gmail.com>
Date:   Mon, 23 Sep 2019 22:59:08 -0400
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I think I have found a bug in the implementation of `git checkout =
=E2=80=94recurse-submodules $branch` in the case of nested submodules. =
When I add a submodule that has submodules in a feature branch of the =
main project, checkout the master branch and then checkout my feature =
branch again, the submodule is not in the expected state.

As an illustration, the following sequence of commands will not leave =
the submodule brooklyn in the right state:

mkdir test
cd test
git init
git touch file
git add file
git commit -m "initial commit" # add a commit on master
git checkout -b add-sub # create feature branch
git submodule add http://github.com/apache/brooklyn # this repo has =
submodules itself
git submodule update --init --recursive # initialize all nested =
submodules
git commit -m "add brooklyn"
git checkout --recurse-submodules master # this removes the brooklyn =
directory, as expected
GIT_TRACE=3D1 git checkout --recurse-submodules add-sub # this fails to =
checkout the nested submodules correctly
22:38:13.885971 git.c:439               trace: built-in: git checkout =
--recurse-submodules add-sub
22:38:13.895776 run-command.c:663       trace: run_command: cd brooklyn; =
unset GIT_PREFIX; GIT_DIR=3D.git git --super-prefix=3Dbrooklyn/ =
read-tree -u --reset 4b825dc642cb6eb9a060e54bf8d69288fbee4904
22:38:13.909366 git.c:439               trace: built-in: git read-tree =
-u --reset 4b825dc642cb6eb9a060e54bf8d69288fbee4904
22:38:13.918464 run-command.c:663       trace: run_command: cd brooklyn; =
unset GIT_PREFIX; GIT_DIR=3D.git git --super-prefix=3Dbrooklyn/ =
read-tree --recurse-submodules -u --reset =
30f3d2754a98670d57d142193ba51af3038555af
22:38:13.935402 git.c:439               trace: built-in: git read-tree =
--recurse-submodules -u --reset 30f3d2754a98670d57d142193ba51af3038555af
22:38:13.940017 run-command.c:663       trace: run_command: cd =
brooklyn-client; unset GIT_INTERNAL_SUPER_PREFIX GIT_PREFIX; =
GIT_DIR=3D.git git --super-prefix=3Dbrooklyn/brooklyn-client/ read-tree =
--recurse-submodules -n --reset 05031a79d4724b867db76b7c4afe55190666c7af
fatal: exec '--super-prefix=3Dbrooklyn/brooklyn-client/': cd to =
'brooklyn-client' failed: No such file or directory
error: Submodule 'brooklyn-client' could not be updated.
error: Submodule 'brooklyn/brooklyn-client' cannot checkout new HEAD.
error: Submodule 'brooklyn' could not be updated.
22:38:13.947005 run-command.c:663       trace: run_command: cd brooklyn; =
unset GIT_PREFIX; GIT_DIR=3D.git git status --porcelain=3D2
22:38:13.962706 git.c:439               trace: built-in: git status =
--porcelain=3D2
M	brooklyn
Switched to branch 'add-sub=E2=80=99

After that, git status says "modified content" for brooklyn; cd-ing into =
brooklyn and doing git status show everything as deleted, and also some =
errors related to the git dir of the nested submodules :=20
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    .gitattributes
	deleted:    .gitignore
	deleted:    .gitmodules
	deleted:    .mvn/jvm.config
	deleted:    Dockerfile
	deleted:    Jenkinsfile
	deleted:    LICENSE
	deleted:    NOTICE
	deleted:    README.md
	deleted:    brooklyn-client
	deleted:    brooklyn-dist
	deleted:    brooklyn-docs
	deleted:    brooklyn-library
	deleted:    brooklyn-server
	deleted:    brooklyn-ui
	deleted:    doap_Brooklyn.rdf
	deleted:    pom.xml

fatal: not a git repository: 'brooklyn-client/.git'
fatal: not a git repository: 'brooklyn-dist/.git'
fatal: not a git repository: 'brooklyn-docs/.git'
fatal: not a git repository: 'brooklyn-library/.git'
fatal: not a git repository: 'brooklyn-server/.git'
fatal: not a git repository: 'brooklyn-ui/.git'
Submodule changes to be committed:

* brooklyn-client 05031a7...0000000:

* brooklyn-dist 3a30944...0000000:

* brooklyn-docs 2b06e96...0000000:

* brooklyn-library a94f7d8...0000000:

* brooklyn-server e601350...0000000:

* brooklyn-ui 503d74e...0000000:

To get back to the state I was on branch add-sub before checking out =
master, I need to do "git submodule update --recursive --force". I =
don=E2=80=99t think this is expected behaviour, it is rather confusing.

Cheers,
Philippe Blain.=
