Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BBC6FA93
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 12:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiITMms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITMmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 08:42:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A906D559
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:42:46 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id g12so1282717ilj.5
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=DDBNEf5MgUoWUMDdAcF6h6S413znEGW+TAgzetAVmRA=;
        b=J+PpZ3a3mW6z0Yw3rxUNmgrn3VDRYKIVo66VkwoGsFv3JliFdY8GjzC6KjuZrgWB1B
         oO4+wXwgOtN2/l66UaE4ivvpMKtQiWDxRRq1gvucAKpDPQy4ZiJWBFiKmgEg7NZOf1r3
         okLyrNKngGGDJYbblhZIjCEbzz4n86IzW759tR+9QV1voi6u9RmB20CxkrcZDeNTUk7t
         vu79YEp2PQ3swTx/gXRtZD9knqeFoJvQ8H4lVb2MTFg9xwPg3qwKUSKkABV52nXtXGAT
         lnZ0+TWB//qjPWYAlmRbYkBqjUIGqm3rh21U5y0zfrjzxItp1WOALIACMUqRxs3h7HWI
         STdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=DDBNEf5MgUoWUMDdAcF6h6S413znEGW+TAgzetAVmRA=;
        b=1u6xsyDdNa1yv5wRSZ6KouB4S2NFt0K1Dbfriuijn9VhWb8JUABunTf8kMI6WnAO/m
         sciTNH+L0XOr3ciUHZk6r89AX3IKyM0r0FqkPZM8A8pG6Ui9kDU1VlKNlP6fxm+PKuLt
         rdzYDsJ8lvtoh54vnjZRdOl5KzS/xhK+eZj0oFcTg65o38KMiKcPFpQ0rHbjxuqfgLFV
         3wkbJPfFUA2w+bbAK9A0Kms9QFsYsuHKYb3Rl3zCqoEyKr+ihrG3DtysW4jV23LSg8vD
         n9mRNRRLVHvSuUkh592kfzeUzddqPGWsw1iLKrNWyTW5VY77OyeIKZ37jslCoDWhZVdJ
         joQg==
X-Gm-Message-State: ACrzQf0mu9PtPbCAaxF+x6LW5dtX5AEVNK5w1V0qGuyev2BdH3Tg7bRc
        0k/S/O017hvwSzOHjp+FCS562mghYYN90QUWP0JPUHE4IriBeWqx
X-Google-Smtp-Source: AMsMyM6YQaIztbI187BoLHkPozzaneEi4YvBh13iOvLBj1aA3m6aG4qgaqm6m8C9Wx0VXhENGbmgf/tUXuBkXEizPgg=
X-Received: by 2002:a05:6e02:174c:b0:2f1:62c8:787e with SMTP id
 y12-20020a056e02174c00b002f162c8787emr9801279ill.254.1663677765766; Tue, 20
 Sep 2022 05:42:45 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 20 Sep 2022 20:42:34 +0800
Message-ID: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
Subject: Question relate to collaboration on git monorepo
To:     Git List <git@vger.kernel.org>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, guys,

If two users of git monorepo are working on different sub project
/project1 and /project2 by partial-clone and sparse-checkout ,
if user one push first, then user two want to push too, he must
pull some blob which pushed by user one. I guess their repo size
will gradually increase by other's project's objects, so is there any way
to delete unnecessary blobs out of working project (sparse-checkout
filterspec), or just git pull don't really fetch these unnecessary blobs?

The large number of interruptions in git push may be another
problem, if thousands of probjects are in one monorepo, and
no one else has any code that would conflict with me in any way,
but I need pull everytime? Is there a way to make improvements
here?

Here's an example of how two users constrain each other when git push.

#!/bin/sh

rm -rf mono-repo
git init mono-repo -b main
(
  cd mono-repo
  mkdir project1
  mkdir project2
  for ((i=0;i<10;i++))
  do
    echo $i >> project1/file1
    echo $i >> project2/file2
  done
  git add .
  git commit -m init
)

rm -rf mono-repo.git
git clone --bare mono-repo

# user1
rm -rf m1
git clone --filter="blob:none" --no-checkout --no-local ./mono-repo.git m1
(
  cd m1
  git sparse-checkout set project1
  git checkout main
  for ((i=0;i<10;i++))
  do
    echo "data1-$i" >> project1/file1
    git add .
    git commit -m "c1 $i"
  done
)

# user2
rm -rf m2
git clone --filter="blob:none" --no-checkout --no-local ./mono-repo.git m2
(
  cd m2
  git sparse-checkout set project2
  git checkout main
  for ((i=0;i<10;i++))
  do
    echo "data2-$i" >> project2/file2
    git add .
    git commit -m "c2 $i"
  done
)

# user1 push
(
  cd m1
  git push
)

# user2 push failed, then pull user1's blob
(
  cd m2
  git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
blob_count1
  git push
  git -c pull.rebase=false pull --no-edit #no conflict
  git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
blob_count2
  diff blob_count1 blob_count2
)

--
ZheNing Hu
