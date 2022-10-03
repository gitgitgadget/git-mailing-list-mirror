Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE3C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 15:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiJCP2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJCP2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 11:28:20 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9262716D
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 08:28:19 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id z9-20020a4a4909000000b0047651b95fbdso6961459ooa.5
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=tE+fGYzUjruqwKpdBvGrlDefOADj6Q/h8LUqhA+UThU=;
        b=quF625fYBEWCLEkCglr1Q1QXCJwnW9SZ/auw1B6ClEoj5KJOryCsMTwPHrTHzqBefP
         UE21NBMnKA2PtMGhibEYmeUvNwYvibTOid7Sd4iCd6kVZEvOkWo8zfXLyjayyS3z8HEl
         fviitEyPZy3Z/h6wu+r2VITjOSRIcD1GgVQQrcNAK3dT95HhAq3vNyA2VcaDbgPIiidx
         cJcB7WB9r8Bqa5SuwreB6FOoJSddAPD2uhKCMo52ygar8n7BRLxJbZmhRTCNrPT50xBH
         oEPUCQm7fLBchbYZKO3Vk/kFKliiVsC8LY4vAJnRJyNFLXQSyOgP4D/56SxSAt6P8QDc
         qLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tE+fGYzUjruqwKpdBvGrlDefOADj6Q/h8LUqhA+UThU=;
        b=1/+jYv/mlWhBKTc5mAarxIj9xIJcfk1AvqOyZzvstiLpR0XsFMeECpviKCnlh/5G9h
         VnJf08Eb+cVSd2rlyOSqbpcUw4ze+M36nFerBsh2N2I6qaDvIKv6mDRyn2RjK8ZUNZ2q
         fvuls0dizF2U0yQ/k2KLlMi5uApVfPIikOPATReAAK9zwbCKYH/qznv458Pk4ahyHLGL
         b8TFc/bEucbLJCdeDKPX4iOACbMzXeM8ZjUghoLrkv1MBjOPmH+T9gpuKwRW1QBp4PQ+
         sJBUwO3uUJrW+7V5kHcke5Wm/hAxZkWRJFnhzWIS+AnfYRHCpuxtKxVMfiL6fcAcHWPG
         ELoA==
X-Gm-Message-State: ACrzQf05263H/l1FB/YlefH2p1ICkjREgVJGIC29QkaitrKTT6DRGQvp
        RFTdCXx87Xn3jjPgolxiFmF4FlT7uO4OrRua0KyhlQkc4X5/wA==
X-Google-Smtp-Source: AMsMyM4Ff65yfL7UMlcq4vb5lLzwZCUAui6fD4Iid2ddzLy8jIinM5mAPTUzucJP5eRsQ1OlyFvWg3ufUYydKfc8TR4=
X-Received: by 2002:a05:6830:610b:b0:65b:eb36:6336 with SMTP id
 ca11-20020a056830610b00b0065beb366336mr8031413otb.131.1664810898123; Mon, 03
 Oct 2022 08:28:18 -0700 (PDT)
MIME-Version: 1.0
From:   Alastair Douglas <alastair.douglas@gmail.com>
Date:   Mon, 3 Oct 2022 16:28:06 +0100
Message-ID: <CADTs3HEn8JQzfWGP-rq_BBLvwGD163=c2i_7vFK17g+wAVec+Q@mail.gmail.com>
Subject: Bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have found no solution to the issue below. Apologies if it has
already been addressed.

What did you do before the bug happened? (Steps to reproduce your issue)

Have an existing git config with rebase = preserve

What did you expect to happen? (Expected behaviour)

Merges to be preserved when rebasing, without a warning about an option I am
not using.

What happened instead? (Actual behaviour)

I received a warning as though I had used the option on the command line:

warning: git rebase --preserve-merges is deprecated. Use
--rebase-merges instead.

I didn't do that, so I can't follow the advice. There appears to be no
alternative config setting for the new option.

What's different between what you expected and what actually happened?

I expected rebase=preserve to now use --rebase-merges instead of
--preserve-merges, or for a new config setting to be made available to use
--rebase-merges. Ideally the first, because the semantics are clear.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-47-generic #51-Ubuntu SMP Thu Aug 11 07:51:15 UTC
2022 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
