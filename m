Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E4C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352290AbiCPSJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346985AbiCPSJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:09:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE729403F0
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:08:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so3653542wme.5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tH27rNu0hNyc7bHDBDuYSkt4bkdkU0iBtFAFF114fyQ=;
        b=bcCxHWJYfSUxZ9qLwfolIxdSl7zl/qJ/Wkr7l7Dg3pRjL6bed3skMCCDx9plF+t5SP
         CDMMBhlkuQ+zIaRZE2Yr6kiFJX1oTWQMJjd9WIIpD/MBMoVIDOqanrVfzJ+9/Ey+8MZ2
         RWCT8os3D0V16Cj/BwO3oP2lSAcYEawdGF22cuYMADp3kRhCxd7oe30y384o87/M8nJH
         UQtUw+Yg41UaM6AuLTYPhtHJPSJ6jidqAjBxi9RSNRzZmBFeRlvuyTgluYrUiPxioc20
         wtViHNvGNfMFFkEwz2i9H6p1dywgRFtb9RnZCpwXY2OtE4zOAcuIt6G8JNSLKPge09BR
         XOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tH27rNu0hNyc7bHDBDuYSkt4bkdkU0iBtFAFF114fyQ=;
        b=PI7Gy98SyOiLNGXZ2tO/aSGSxbNaXE+f5rzWTe+CK7rLd5MtrdxCZylalnSPIQeaMx
         WM9bJ1ZKKG2SxI1lUq5fcHdirEE2sMkDqTRMMy0nX1Mdvvz3bjFLH0C/Yod5QSmv/qd5
         L5nrKuBAo11SOhmjThrKQUGs7upGQO4DPnGnvEq92JrM62qQuHzGvl+Rrmz67hOu4S0N
         9XMqLFKbASu5EhFuS9MaBC7Mki4pXd3DR9GwWr9ljPBb/+tWvMkUOKk7qRPC3Z8CzXxs
         eWz5YUbQKsP1uDeBf3akSJHKRhGTi/DPO304t+T/yZ+jvnKFXo4iwYhtdiVu5EuOw7GW
         LKVQ==
X-Gm-Message-State: AOAM532cTDwEkzqsNgGRwQfBc497xbc4nYeo8GXEWYFxE/gCc0g5vrVA
        arJlU1BYn4NAEjYMTryYQs/K9zLMZfgri3XCJApnzass1Tk=
X-Google-Smtp-Source: ABdhPJz4hNh1EzrrO6BYENy7rLt0JOQtABXTMxBTNEaRr1VvEb5Q4qZlgw/9I1VzvvqZsyseWMGKHgDbpX3wsQqQ9YQ=
X-Received: by 2002:a05:600c:298:b0:38a:f22:700e with SMTP id
 24-20020a05600c029800b0038a0f22700emr8502035wmk.128.1647454113271; Wed, 16
 Mar 2022 11:08:33 -0700 (PDT)
MIME-Version: 1.0
From:   Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date:   Wed, 16 Mar 2022 19:08:22 +0100
Message-ID: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
Subject: Git has two ways to count modified lines
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I check the number of lines modified by my commits by hand,
and today I had a surprising count :

1) I commit and get the following count
laurent@laurent-GL73-8SD:~/ReposGit/flow$ git commit
[master c068911] Task CU-21ph8h7 add buttons in PresenceList: "Tout
d=C3=A9plier", "Tout replier", for this the useState for showDetail
(boolean) in Presence is replaced by a useState for showDetails (Set
of ids) in PresenceList; correction missing tr between thead and ths
in PresenceList.
 2 files changed, 88 insertions(+), 48 deletions(-)
 rewrite src/apps/logs/components/PresenceList.js (61%)

2) I check the diff by hand, it doesn't match.
I check on github, it agrees with my manual count.

3) I try to get the same answer again in command-line.
laurent@laurent-GL73-8SD:~/ReposGit/flow$ git log -1 --shortstat
commit c068911547bddbf7bfc4ddc7a68ee8482421ed5c (HEAD -> master,
origin/master, origin/HEAD)
Author: Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date:   Wed Mar 16 18:40:25 2022 +0100    Task CU-21ph8h7 add buttons
in PresenceList: "Tout d=C3=A9plier", "Tout replier",
    for this the useState for showDetail (boolean) in Presence is replaced
    by a useState for showDetails (Set of ids) in PresenceList;
    correction missing tr between thead and ths in PresenceList. 2
files changed, 71 insertions(+), 31 deletions(-)

How comes git has two ways to count modified lines ?
How can I make git output again the same numbers than just after commit ?
How can I check how it computed these numbers in the first place ?

Thanks, best regards,
    Laurent Lyaudet
