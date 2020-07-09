Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442EC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4C420772
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkaWXnbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGILU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGILU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:20:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E1C061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:20:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 22so1396239wmg.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q9P5csMcdrV5XcVs5xn3/SouvJn++yM+7G3kZji4JUM=;
        b=tkaWXnbRA1Vaorq1AVD4e9LWZjNG7/RpXXgcSlqGdqUqyLwGyRsXnCPuWncZIu4c9b
         5UOY8NNlowOKi4X9rh5vZ832aRCkHe6Laj4Hpyg6vE4aZoj9mO10xPA1v0PPbs9K2ofR
         chMOqnKI6PzuhKdQwgUgPhpWFU17Qp4pWjsg8MnFIxJcV74npgIczMOelxYtfcUlm4CV
         +UvbXfyl8vqIRYH5vSAru6HfEhXJcY1WXod5WtiNQU36firedlZEIVy+lyp1K8CKf+B2
         UWvMdw+tEXQM3V4N0n/ASSYcpQ6diD/EVeknqfzS/vWHhhVPlMPSLmjmDEYcfCQxJnrE
         i1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q9P5csMcdrV5XcVs5xn3/SouvJn++yM+7G3kZji4JUM=;
        b=KR10V39B14EyEQ1KtAaKKPers7ckLqRo7KWtjjeDvfjIdHtROiYz2772jBAVzVQo4D
         pb9MK96eFAL0jUi0D4KJiQG90HZPvlc/5Czkl6u53StxFMrJs35ayAVToUawUSSwQtVx
         K20tydYBFMH8O/11X4F1xdYkNgla7lKEOMrtHHrf20IHVe2EnDTXShm6cbYkZ8DqO3a6
         SvumHqshVMA10XMyGUsNdAhFpNlvp5T9MAKORh518V4HBTP3MwHwqSnEobP9Kk030TaG
         Sdq0t/xj9qcCRecYY/FsHPVdegDYPrMg3mlikv6rOiLOJB5dcY9AV1FHr+xraHh3O/zz
         H1fQ==
X-Gm-Message-State: AOAM5324GhvYssOWyEupMFgkOmiYcpKNTuqwPZK9uY7Ysl7F40LQ1Tu3
        mKfb/IQu2nFwx7L68Rpf3gRWedXv9U/wNUpNy5gTBrJP73M=
X-Google-Smtp-Source: ABdhPJzFA/VMzmF3m61U42gRA0VMPrdj3sXhO/43ICkwkV6Ld5jeU1JZ8kIk46o3CtvMZ7JGUquPYazjrRYgaeDSW6Q=
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr14201456wme.107.1594293656945;
 Thu, 09 Jul 2020 04:20:56 -0700 (PDT)
MIME-Version: 1.0
From:   Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Date:   Thu, 9 Jul 2020 21:20:47 +1000
Message-ID: <CACKP9csQxeWeKjEB8RPa=hdMpOAFtXt3_WErxk8cdR1soNu+Fw@mail.gmail.com>
Subject: Tagging from within a worktree causes fatal: tag already exists
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have been using git and worktree for about 8 months and getting my
team upto speed, with absolute success. Thanks for your help during my
initial stages.

I am in the production readiness phase and wanted to merge the branch
into master, tag and deploy into UAT.

When I run "git tag -l" on any worktree, they all list the tag created
in proj1 (1.0.0-1).
But when I run "git show 1.0.0-1" it is associated only with proj1
(see listing below)
The issue is, I am unable to create a tag 1.0.0-1 in any other worktree.

In summary, I performed the following steps.  proj1 & proj2 are two
different git repositories.
1. Checked out master (proj1) into a local-directory-proj1-master using worktree
2. Merged the dev-branch into master
3. Pushed the change to central server
4. From the local-directory-proj1-master, I created a tag (1.0.0-1)
5. pushed the tag  to central server

6.  Checked out master (proj2) into a local-directory-proj2-master
using worktree
     Performed steps 2 & 3 above for proj 2

7.  From the local-directory-master (proj2) , I created a tag (1.0.0-1)
     fatal: tag '1.0.0-1' already exists

Your assistance is greatly appreciated.

Thanks
Lakshman



Please find detail steps below

proj1 => remote (origin)
Local_proj1-DEV => Development Branch
proj1/master    => Remote Tracking branch

git worktree add --checkout c:\source\proj1-master -b
Local-proj1-master proj1/master

cd c:\source\proj1-master

C:\Source\proj1-master>git merge Local_proj1-DEV

C:\Source\proj1-master>git push proj1 HEAD:master

C:\Source\proj1-master>git tag -a -m "Initial release candidate" 1.0.0-1

C:\Source\proj1-master>git show 1.0.0-1
tag 1.0.0-1
Tagger: Lakshman <sadsd>
Date:   Thu Jul 9 17:38:23 2020 +1000

Initial release candidate

commit 99fe92 (HEAD -> Local-proj1-master, tag: 1.0.0-1, proj1/master,
proj1/dev, Local_proj1-DEV)

git push proj1 1.0.0-1




cd c:\source\proj2-master

C:\Source\proj2-master>git tag 1.0.0-1
fatal: tag '1.0.0-1' already exists

c:\source\proj2-master>git show 1.0.0-1
tag 1.0.0-1
Tagger: Lakshman <sadsd>
Date:   Thu Jul 9 17:38:23 2020 +1000

Initial release candidate

commit 99fe92 (tag: 1.0.0-1, proj1/master, proj1/dev, Local_proj1-DEV,
Local-proj1-master)
