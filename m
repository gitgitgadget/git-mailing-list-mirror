Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F96C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D8D60F35
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhIISdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhIISdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:33:11 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABB2C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:32:02 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id x21so1513876uan.6
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=96xbPU10d16tTz6GulOONmehRxk6eRo3nxxqkO2kgeg=;
        b=jzOTpt9EXSVVn8zss25hbYEH5RRyUToLO3OFQ1xX0dDY2tCIWs16YKz5Uj66lt3K1Q
         XjCF4io+vN4NbboIMfSWQWatoZOHR/x1P9Haykfkc6kAIumXHUxNSqB6kpBjczrtIJzn
         7/8UR42SFMFwLv5Sr6TqzVAG2xCBw0vHYdDMgFabOFsEpmVlxkJXhKmJXWrGqR2Bo2hh
         YnxRs94mJnq+NdncXSXWTu+4PdSGY9GXtkxAnLWGpbNGc0+UiRSCJArcCaPzQd7hqWxT
         HpOVydkdv6Jbk2PKjVnkUd9fdqSft5v4y32M1bg0ahDbr//qMI0wTJmCb7ArKC7pTzV4
         pP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=96xbPU10d16tTz6GulOONmehRxk6eRo3nxxqkO2kgeg=;
        b=ipsyHwidlxmXFWRv5U6JS7opeSM0WBuVs2uPI+u37Z1jZoyTkwtJynJOPSCOdwm3no
         msxBxIW5z/7jPcFDNzwD9mVTBVsF61PM8/dANIyCzwyX9c1/bxx5i2MFMWzHg+MpZjzN
         9rwmYRxp/3t/xkAVXBT81nnjya+1TqfM4LzXVXgFS4EsQIWPL3YA9xGAv5dJj7VBLTAU
         uFt3rltg/OSdMkjBjjfQ5jgT2Uuozv+3PVYLhCu5FUhJcOJ+XEqadDARWsiOxMIVxPnx
         Kferp9At6UcNcyvsecrPFMzUtR0f7a0NKLIq2XjQs+0A0fUQn0L4jMiS1xfd0y5ccMx9
         GvKg==
X-Gm-Message-State: AOAM531NNkLQtnwV4yJg6cKrwXCyqrUFbcm9rzMKo6fhLLy1+jHPWPPB
        txKv++qbALU35sX6AjgZ2LNvYL60xzQh1UucRU8VnJg6R+8=
X-Google-Smtp-Source: ABdhPJzKlQzIabzCzgCOuq1dNodJesZQHZMd8n/KLbRkyYpt5uX8cspdbqsyn2OgTenOvIQKDieFYgRW4Yl3E+7UIRc=
X-Received: by 2002:a9f:2070:: with SMTP id 103mr2953525uam.34.1631212320705;
 Thu, 09 Sep 2021 11:32:00 -0700 (PDT)
MIME-Version: 1.0
From:   Lucas Araki <lucas.t.araki@gmail.com>
Date:   Thu, 9 Sep 2021 14:31:34 -0400
Message-ID: <CALM-bLiWrJQnU3M5ToQo+72hvToHRknfvH5RVy2zHUgnnsdpXg@mail.gmail.com>
Subject: Error: error converting ".git" to absolute: EvalSymlinks: too many links
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Attempted push operation

What did you expect to happen? (Expected behavior)
push operation success, no error message

What happened instead? (Actual behavior)
Push operation failed with error message:
Error: error converting ".git" to absolute: EvalSymlinks: too many links
ref feature/feature_name:: EvalSymlinks: too many links
error: failed to push some refs to 'https://my_server_name/my_project.git'

In addition, lfs/ directory was created in project folder instead of
.git folder.

What's different between what you expected and what actually happened?
Did not expect lfs/ directory to be created in project folder.
Don't expect error on push operation.

Anything else you want to add:
After reading issues #4050 and #4012, attempted:
`git lfs env` and got output:
git-lfs/2.13.3 (GitHub; windows amd64; go 1.16.2; git a5e65851)
git version 2.33.0.windows.2

Error: error converting ".git" to absolute: EvalSymlinks: too many links
Endpoint=https://my_server_name/my_project.git/info/lfs (auth=basic)
LocalWorkingDir=
LocalGitDir=
LocalGitStorageDir=
LocalMediaDir=lfs\objects
LocalReferenceDirs=
TempDir=lfs\tmp
ConcurrentTransfers=8
TusTransfers=false
BasicTransfersOnly=false
SkipDownloadErrors=false
FetchRecentAlways=false
FetchRecentRefsDays=7
FetchRecentCommitsDays=0
FetchRecentRefsIncludeRemotes=true
PruneOffsetDays=3
PruneVerifyRemoteAlways=false
PruneRemoteName=origin
LfsStorageDir=lfs
AccessDownload=basic
AccessUpload=basic
DownloadTransfers=basic,lfs-standalone-file
UploadTransfers=basic,lfs-standalone-file
GIT_EXEC_PATH=C:/Program Files/Git/mingw64/libexec/git-core
git config filter.lfs.process = "git-lfs filter-process"
git config filter.lfs.smudge = "git-lfs smudge -- %f"
git config filter.lfs.clean = "git-lfs clean -- %f"


Realized that project was in Box drive folder, set to keep local copy,
but based on issues #4050 and #4012, decided to try moving project to
a different local location.
I copied entire project directory our of Box folder, then re-ran `git
lfs env` and got output:
git-lfs/2.13.3 (GitHub; windows amd64; go 1.16.2; git a5e65851)
git version 2.33.0.windows.2

Endpoint=https://git.elsys.gtri.org/scm/tads/tads-suite-test-plan.git/info/lfs
(auth=basic)
LocalWorkingDir=C:\Users\username\myProject
LocalGitDir=C:\Users\username\myProject\.git
LocalGitStorageDir=C:\Users\username\myProject\.git
LocalMediaDir=C:\Users\username\myProject\.git\lfs\objects
LocalReferenceDirs=
TempDir=C:\Users\username\myProject\.git\lfs\tmp
ConcurrentTransfers=8
TusTransfers=false
BasicTransfersOnly=false
SkipDownloadErrors=false
FetchRecentAlways=false
FetchRecentRefsDays=7
FetchRecentCommitsDays=0
FetchRecentRefsIncludeRemotes=true
PruneOffsetDays=3
PruneVerifyRemoteAlways=false
PruneRemoteName=origin
LfsStorageDir=C:\Users\username\myProject\.git\lfs
AccessDownload=basic
AccessUpload=basic
DownloadTransfers=basic,lfs-standalone-file
UploadTransfers=basic,lfs-standalone-file
GIT_EXEC_PATH=C:/Program Files/Git/mingw64/libexec/git-core
git config filter.lfs.process = "git-lfs filter-process"
git config filter.lfs.smudge = "git-lfs smudge -- %f"
git config filter.lfs.clean = "git-lfs clean -- %f"

Noticed that LocalGitDir looked correct and was no longer blank.
Re-tried `git push` from new project location and push operation succeeded.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.0.windows.2
cpu: x86_64
built from commit: 8735530946cced809cc6cc4c2ca3b078cdb3dfc8
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
post-commit
post-checkout
post-merge
pre-push
