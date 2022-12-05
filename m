Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A5C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 15:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLEPZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiLEPYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 10:24:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FD20BC2
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 07:22:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u12so18139671wrr.11
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLau+qIhzW/SXSG/PNNdJ3LhYY8u2yR75M4pTlheKbM=;
        b=NIWzz3CcsTsn8ZcelqBijFTGdPlc0U+os+wO+lGPVS++DVkT2Tj0B1IfQzPIY+cx6n
         JlMnx/Kjhy5gxDMgzhmvrcD0ey3z/j9tQ2d+s90Wghvt2COoisyP7exr3LkBLeooYxvw
         3sKL9pdN/ANl3a9bytnxEpkf39O89TxEbTkg2PhX+o2i6ZaWsPNaiW8g8wr48OU2RAjz
         AV9Ov/sJw8tkLb8C3cKJImzz7JeIxw36QExZxkN73QF+nVleVH8i/mzliZBeeOXREZtq
         Jv0hoL3b5JZ+xDVi9aFNyBlRaSklBvP59K9io85tTGggmoxt+z1FbIM+JkDg4Vw830vv
         jnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dLau+qIhzW/SXSG/PNNdJ3LhYY8u2yR75M4pTlheKbM=;
        b=wNqjZSyKpbvw5hAi9U0E0Jjh5IJr6JoI2mQ9k+yH9idLQeOmqYGFSmQ4cgVbTKLMoL
         6D6MnCKuxMcrmnm09EOs2J+MbGCxVvdV4kCN/9v2rsuYhwVW0eADWC/1XZFez+XurMxl
         rrv1NOc45cPk3ozy0rDb9zkWJBJ4U/lFxi2ObrH2Rrec6JXsw4jU3Qc2iJOh2DC9Yqgl
         O014UGbdgrX2y3P5hhhSk2aNicmmqa2A39vAJx8uaizwIGa+wk5dOL3WiX4bDyZ56ffG
         onoBqQ3RsTohCZp77n+Y97TWZ4S3A15mNxscA9UqjKnfsWup9kmz8FmATSRIef9G54UR
         7FLA==
X-Gm-Message-State: ANoB5pm+aYo5nitwPC9kY2jpu9fwo7RH2mm8EloKyyGjLC0yKuMMn803
        M+0nZJITMelU2I60jKCMRABoYMLaez47eQ==
X-Google-Smtp-Source: AA0mqf7YRWGDpZScqkxY66y2iQ8EIlA34RGhnKLrGA9+Rim0o2gksr32Wu/XXTuD/59OWdGML8NanA==
X-Received: by 2002:a5d:4e83:0:b0:242:63de:2f58 with SMTP id e3-20020a5d4e83000000b0024263de2f58mr3245790wru.28.1670253727001;
        Mon, 05 Dec 2022 07:22:07 -0800 (PST)
Received: from [10.1.3.207] (mail.ies.it. [95.171.48.4])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b003c6c3fb3cf6sm19706903wms.18.2022.12.05.07.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 07:22:06 -0800 (PST)
Message-ID: <cddbcbea-61c5-50c6-624f-5c7708b27f79@gmail.com>
Date:   Mon, 5 Dec 2022 16:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
From:   Flavio Stanchina <flavio.stanchina@gmail.com>
To:     git@vger.kernel.org
Subject: Possible BUG: git stash -m picks branch name from submodule
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a repository with one submodule:
   $ cat .gitmodules
   [submodule "foo"]
     path = foo
     url = https://gitlab.xx.yy/zz/foo.git
     branch = xxx

After I clone the main repo and run "git submodule init" + "git 
submodule update", the submodule is in a detached state:
   $ (cd foo && git status)
   HEAD detached at cb52389b
   nothing to commit, working tree clean

I was expecting it to be on the branch spelled out in the configuration, 
but I guess this is working as designed: that's the correct commit, so 
nothing to worry about yet.

At this point, if I create a stash in the main repo with -m, the stash 
comment correctly says it was on master:
   $ git stash -m "test prestazioni filtri RFID"
   Saved working directory and index state On master:
   test prestazioni filtri RFID

   $ git stash list
   stash@{0}: On master: test prestazioni filtri RFID

Now I explicitly check out the submodule by branch name, in preparation 
for work in the submodule itself:
   $ (cd foo && git checkout xxx)
   Switched to branch 'xxx'
   Your branch is up to date with 'origin/xxx'.

   $ (cd foo && git log -1)
   commit cb52389b (HEAD -> xxx, origin/xxx)
   Author: Flavio Stanchina [...]

I create a stash in the main directory with exactly the same command as 
before:
   $ git stash -m "test prestazioni filtri RFID"
   Saved working directory and index state On xxx:
   test prestazioni filtri RFID

   $ git stash list
   stash@{0}: On xxx: test prestazioni filtri RFID

As you can see, the stash took the branch name from the submodule (there 
is no branch with that name in the main repo, and it's still on master 
anyway).

This doesn't happen if I just run "git stash" without -m:
   $ git stash
   Saved working directory and index state WIP on master:
   7bf81a83 [...]

   $ git stash list
   stash@{0}: WIP on master: 7bf81a83 [...]

Is this expected? I don't think so.

Am I not supposed to touch the submodule directory in any way? Even if 
that's the case, why would it make sense to pick the branch name from 
the submodule when stashing in the main directory?

Running on Debian 11 in a WSL instance:
   $ git --version
   git version 2.30.2

   $ dpkg -s git
   ...
   Version: 1:2.30.2-1
   ...


-- 
Ciao, Flavio

