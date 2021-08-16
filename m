Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB1C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9AB60E76
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhHPRGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhHPRGg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 13:06:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A54C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:06:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g138so11983251wmg.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jlq6IMmO7Ek/Y/CJGIjPfOSmj+GbdxJFsJdyR9MSkgw=;
        b=E3hDgOLHP9MMgsN1KQDFp4aRpUtgJUrRZZyx7FWEswjlB6Pi2Cv8Ndc6zkbWWN1PLI
         k8OMGjgDA8qpgbUW713cE79kCbA0VV6I8XU5OfTwAzmVwJ++SxsIhAycl851+NUgLapZ
         cvIBRer5BG7s7SAI4+muqJWokHr8p1kd9UtkvBqZ0/rxIWqCyU3jJbbJcmFpTQ0Cs7hl
         jE5oABQWo6tWCCQbDr//7C8kq4SJa3vMd83uqbDvsBy+Q4Isi4/R+SwDRyjWpsVkjOye
         LtnfEubp2HuM1rLQdvaI7wEpAHtOzD85Anh2IXGlOx70/iEAT0omkLNGHCgfjO5l4d4h
         olEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jlq6IMmO7Ek/Y/CJGIjPfOSmj+GbdxJFsJdyR9MSkgw=;
        b=AD7t30PS2EMZWpwJLGSj7SV3NtkV9B4J1PQxadnyZdnIkjijReMEbHEGjK8Qu/rLE9
         7yZYdsy9tPVuvoHvT34DCANeGA3o5srHTZdU8IKD1xzcCNKLzEf+zhqCuQAw96wasxQ6
         CZ99F+lgi7fWPoS68Sq2f+xYnA4+Cfq8jryDxzT9phatcA9bMAB/fqQwzTLl3PWkjVXO
         ggsoe58SofG9E5bPNPS2qJYAwWt8nlOdDG608irlirGgBwm57GnQ/LK0J4y823bS/Dbt
         96InzBrvr5AfFDE5Qtt+tVzUM2OKPjlIbAB9mVaydsIlENwyS20b9tSWCQl1mTfpUgrY
         X6Mg==
X-Gm-Message-State: AOAM5337saQn9NVRyfR11v/qvBbgP5lF2tGVj42wGLdSQfDSmv0MGmDK
        tz34K0UtGinTjis8LApq3mm1N1JVSn4=
X-Google-Smtp-Source: ABdhPJzCHzG/kJY2xpdqxyaNDumVj472WXonLQOLB3dQ3tjZAVx7+JH5rx69lNsKAb0/4NN8T/B+DA==
X-Received: by 2002:a1c:29c3:: with SMTP id p186mr133814wmp.22.1629133562755;
        Mon, 16 Aug 2021 10:06:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19sm133218wma.0.2021.08.16.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:06:02 -0700 (PDT)
Message-Id: <pull.1066.git.git.1629133561.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 17:05:59 +0000
Subject: [PATCH 0/2] packfile: freshen the mtime of packfile by bump file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

packfile: freshen the mtime of packfile by bump file

We've talked about the cache reload through earlier patches(
https://lore.kernel.org/git/pull.1043.git.git.1625943685565.gitgitgadget@gmail.com),
and we stopped because no further evidence can tell NFS client will reload
the page caches if the file mtime changed. So our team have done these
experiments:

Step1: prepare git servers which mount the NFS disk and a big repo

We prepared 3 vms named c1, s1 and s2, we also have a NFS server named n1.
s1 and s2 mount the NFS disk from n1 by:

    mount -t nfs -o vers=3,timeo=600,nolock,noatime,lookupcache=postive,\
    actimeo=3 <n1 ip addr>:/repositories /mnt/repositories


We setup git server services on s1 and s2, so we can clone repos from s1 by
git commands. Then we created a repository under /mnt/repositories, and
pushed large files to the repository, so we can find a large .pack file in
the repository with about 1.2 GB size.

Step2: do first git clone from client after drop caches of s1

First we drop the caches from s1 by:

    sync; echo 3 > /proc/sys/vm/drop_caches


Then we run git command in c1 to clone the huge repository we created in
Step1, at the same time we run the two commands in s1:

    tcpdump -nn host <n1 ip addr> -w 1st_command.pcap
    nfsiostat 1 -p /mnt/repositories


try to get the result and check what happends.

Step3: do new git clones without drop caches of s1

After Step2, we called new git clone command in c1 to clone the huge
repository for serveral times, and also run the commands at the same time:

    tcpdump -nn host <n1 ip addr> -w lots_of_command.pcap
    nfsiostat 1 -p /mnt/repositories


Step4: do new git clones with packfile mtime changed

After Step2 and Step3, we try to touch all the ".pack" files from s2, and we
call a new git clone in c1 to download the huge repository again, and run
the two command in s1 at the same time:

    tcpdump -nn host <n1 ip addr> -w mtime_changed_command.pcap
    nfsiostat 1 -p /mnt/repositories


Result:

We got a about 1.4GB big pcap file during Step2 and Step4, we can find lots
of READ request and response after open it with wireshark. And by
'nfsiostat' command we can see the 'ops/s' and 'KB/s' of 'read' in the
output shows a relatively large value for a while.

But we got a 4MB pcap file in Step3, and open it with wireshark, we can only
find GETATTR and FSSTAT requests and response. And we the 'nfsiostat' always
show 0 in 'ops/s' and 'KB/s' of 'read' part in the output.

We have done Step1 to Step4 serveral times, each time the result are same.

So we can make sure the NFS client will reload the page cache if other NFS
client changes the mtime of the large .pack files. And for git servers which
use filesystem like NFS to manage large repositories, reload large files
that only have mtime changed result big NFS server IOPS pressure and that
also makes the git server slow because the IO is the bottleneck when there
are too many client requests for the same big repositries.

And I do think the team who manage the git servers need a configuration
choise which can enhance the mtime of packfile through another file which
should be small enough or even empty. It should be backward compatibility
when it is in default value, but just as metioned by Ævar before, maybe
somepeople what to use it in mixed-version environment, we should warn them
in documents, but such configuration do big help for some team who run some
servers mount the NFS disks.

Sun Chao (2):
  packfile: rename `derive_filename()` to `derive_pack_filename()`
  packfile: freshen the mtime of packfile by bump file

 Documentation/config/core.txt   |  11 +++
 builtin/index-pack.c            |  19 +----
 cache.h                         |   1 +
 config.c                        |   5 ++
 environment.c                   |   1 +
 object-file.c                   |  30 +++++++-
 packfile.c                      |  25 ++++++-
 packfile.h                      |   7 ++
 t/t5326-pack-mtime-bumpfiles.sh | 118 ++++++++++++++++++++++++++++++++
 9 files changed, 198 insertions(+), 19 deletions(-)
 create mode 100755 t/t5326-pack-mtime-bumpfiles.sh


base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1066%2Fsunchao9%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1066/sunchao9/master-v1
Pull-Request: https://github.com/git/git/pull/1066
-- 
gitgitgadget
