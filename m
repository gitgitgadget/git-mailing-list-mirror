Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB69C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28301206A1
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAmQ/MUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD1NTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgD1NTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 09:19:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA75C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:19:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k13so24644534wrw.7
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=mi+jIozVBKFBPMpuwefiCesBf3J6EHOLzWo1kV2Dgzg=;
        b=iAmQ/MUjWBacYQ8b7z2F8dSh4eR6X12VB6ZISTxS84LfSLwtQR5Y0WguubgmlPEqGC
         KRrV1lIG9KqLu7nD0RovvhJOs63YCsIakYvxkl2V47Iff8niBhf0B6iOWMWEblCkfwCC
         sY+DjF+rWFW2wttc2zTh1zgaiXnIHh6Lyh7McN7DreWni7GwaQz+AVPM3agU4xDzPip8
         KzahgMH/zGQYmNECsFzM7nSQp46+ZAEJ8grEPY2CsbP5LcunbLOqpexJHpqpJ4YOTqfo
         BM4AT1AVJCKQr03lTmosogB9LdAtsmOlCgPtTWVvAePccrkrfsurrxERTdMLVG0mnFdX
         cxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=mi+jIozVBKFBPMpuwefiCesBf3J6EHOLzWo1kV2Dgzg=;
        b=LR3bH1TnCTRdjuZy1PwCROjjhIxYr/3aNB1Gus1eIitZ9tRqHVsjP7oTZk/iTq1IGh
         Q0IGUitPzXuaoWHi6N+7LRJTlI/+p3Rw9tR26Dm/EU5Bvn4CjO2IhVhagSAPefLr2Kkd
         MNnRzvOfsWvJTvCba+KfXj2VbOjvUUVIn5kxDddXSvgMgJoLkRE1UJUIdaDkS2/9VNq8
         dtoQKN9ShAXTRTDAMNrBDMuZRw4EmOfYmp6ya0ZTX5uRXqyCBAFue278ab27BI8XQ8nq
         iYrHH3fK5AM8l50ZBNmXWATGM/1BnDJh705oRPqUpuf3GT7Fdk2KXEJ6cvOuUBm/1Z+S
         UvKA==
X-Gm-Message-State: AGi0Puavic57s0tCd0fEQeggWJtBkp2JViU9w556Ij98y+aCGqqZylcc
        BKRlYqlwG4xY6rpggi3NLm5eUBnSoi4=
X-Google-Smtp-Source: APiQypLdAF0tVobpr17Zmc5+29W1NkjmOjNVBjzx0/mmQf63nP3+NqGAve8JPx3crwogWbFOOIqryg==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr32134801wrn.209.1588079947761;
        Tue, 28 Apr 2020 06:19:07 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:74c6:846b:f036:3655? ([2a02:a210:ca2:9c00:74c6:846b:f036:3655])
        by smtp.gmail.com with ESMTPSA id l5sm25184953wrm.66.2020.04.28.06.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 06:19:07 -0700 (PDT)
From:   Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Git Stash brake splitIndex
Message-Id: <EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com>
Date:   Tue, 28 Apr 2020 15:19:06 +0200
Cc:     Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I am on git version 2.26.2.526.g744177e7f7 (latest next)
When you do a git stash while using splitIndex, it seems like the index =
will get corrupted

Using configs:
core.splitindex=3Dtrue
splitindex.maxpercentchange=3D50
splitindex.sharedindexexpire=3Dnow

Reproduce steps:

mkdir repo
cd repo && git init
echo a > a
commit -a -m 'add a'
echo b > b
git add b
git stash
Saved working directory and index state WIP on master: 1955b62 add a
fatal: .git/sharedindex.8ddd8dad6ccb4858f27d4ff20f4d8bf6654441e0: index =
file open failed: No such file or directory

Some traces:
master ~/test/git/repo> GIT_TRACE2=3D1 GIT_TRACE2_NESTING=3D5 git stash
15:18:15.442295 common-main.c:48                  version =
2.26.2.526.g744177e7f7
15:18:15.442914 common-main.c:49                  start git stash
15:18:15.443284 repository.c:134                  worktree =
/Users/sluongngoc/test/git/repo
15:18:15.443491 git.c:442                         cmd_name stash (stash)
15:18:15.448579 run-command.c:735                 child_start[0] git =
update-index --ignore-skip-worktree-entries -z --add --remove --stdin
15:18:15.455972 common-main.c:48                  version =
2.26.2.526.g744177e7f7
15:18:15.456514 common-main.c:49                  start =
/Users/sluongngoc/libexec/git-core/git update-index =
--ignore-skip-worktree-entries -z --add --remove --stdin
15:18:15.456788 repository.c:134                  worktree =
/Users/sluongngoc/test/git/repo
15:18:15.456927 git.c:442                         cmd_name update-index =
(stash/update-index)
15:18:15.458444 git.c:672                         exit elapsed:0.004021 =
code:0
15:18:15.458457 trace2/tr2_tgt_normal.c:123       atexit =
elapsed:0.004039 code:0
15:18:15.458774 run-command.c:990                 child_exit[0] pid:1813 =
code:0 elapsed:0.010169
Saved working directory and index state WIP on master: 1955b62 add a
15:18:15.461082 run-command.c:735                 child_start[1] git =
reset --hard -q --no-recurse-submodules
15:18:15.467260 common-main.c:48                  version =
2.26.2.526.g744177e7f7
15:18:15.467553 common-main.c:49                  start =
/Users/sluongngoc/libexec/git-core/git reset --hard -q =
--no-recurse-submodules
15:18:15.467931 repository.c:134                  worktree =
/Users/sluongngoc/test/git/repo
15:18:15.468071 git.c:442                         cmd_name reset =
(stash/reset)
15:18:15.468555 usage.c:64                        error =
.git/sharedindex.8ddd8dad6ccb4858f27d4ff20f4d8bf6654441e0: index file =
open failed: No such file or directory
fatal: .git/sharedindex.8ddd8dad6ccb4858f27d4ff20f4d8bf6654441e0: index =
file open failed: No such file or directory
15:18:15.468587 usage.c:68                        exit elapsed:0.002714 =
code:128
15:18:15.468595 trace2/tr2_tgt_normal.c:123       atexit =
elapsed:0.002726 code:128
15:18:15.468889 run-command.c:990                 child_exit[1] pid:1814 =
code:128 elapsed:0.007797
15:18:15.468930 git.c:672                         exit elapsed:0.028400 =
code:1
15:18:15.468947 trace2/tr2_tgt_normal.c:123       atexit =
elapsed:0.028418 code:1
exit 1

Cheers,
Son Luong.=
