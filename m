Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD9DC43467
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04F1214D8
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJoeu1X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgJNQi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgJNQi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 12:38:28 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68539C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 09:38:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 65so201264otu.9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BB1rK3aX6G8OufH3rm5/F1iM4gyaVciOrt6OQSV85KU=;
        b=GJoeu1X8kaJLr1RWgimhcRTC9XZ8/EgIr9TM8+lGgWISTfMpK+dhNCBi2KHo/JX5Nt
         x6WAtJvzB7XH+Mi8HnsjCx/dayPgJDlpxKE6Nl8/nwJEpWo6Bdb2IHDo9ImKaqR33a89
         EEQd3eqnM8l79Z0AxLeWmjky9s9peHHI7zGcmRyIqB54VsSJAlV+vkORYEj1Dr1Ofi6D
         2604cj5KD3Yq8o9+GanNo0jkdhWVtUCPIVFWk3/4pCGeignMVoOGsse6PxzTpZNtTbLV
         qR/04jDQiA8NV5AfHsMPzERxamD5zDT5PlEN5SDBNI7SYFxwh10tJmgdlHNZ+7lCb3PB
         D39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BB1rK3aX6G8OufH3rm5/F1iM4gyaVciOrt6OQSV85KU=;
        b=drHJluJbP4tF8dVLVoBgHeOKB8wfzf+Q/f3YGk3ULPuvEwlfF2IjDiSEgIV/uHEGRH
         X7TpUmZxNICm5jQdwZeb/77aO0Bxb4N/rt9eqQMw0MEI6/SzXgjQW84Cn4ecFET4p0OO
         waFgyWORLlOwolIM69KmD0vvmc1DG1xpbSkW5cthq6s/cv/xB7kFM5r6xg1kAxQE28iY
         ofkSc2/vJsnfqrmYl4pMy12CvtTr8U/z+oGVg3dhcdh314f/CQk1rOgIKUBl5eVZ0Qj7
         Fmvcdjvg3rqivnZ92ordveJAOM6obTCSavJKsEugbKglMU0cOBosn9Po8JsRh/J2p8rQ
         0mtg==
X-Gm-Message-State: AOAM533mdjLe9KPTlnTxG5hqlVz8oh2h4aH+MmnkvZ4AadTOaak8NApw
        1qDJFtIC/YC3rQBKAitxLJxDLwvEwBYDbuwvkXqSZRKzvhYc/IUC
X-Google-Smtp-Source: ABdhPJzbirUk/mSSc3Qh3X6yOmfoeheAmX9JILMTy0VtE4ZHyanVrW8iz/01N9WN92FUaA6A1CuDPn0w35ei9jdEYC8=
X-Received: by 2002:a9d:2c4:: with SMTP id 62mr11182otl.102.1602693506361;
 Wed, 14 Oct 2020 09:38:26 -0700 (PDT)
MIME-Version: 1.0
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Wed, 14 Oct 2020 17:38:15 +0100
Message-ID: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
Subject: Partial clone fails with file:/// URI
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi friends,

When I run a git clone with --filter and a file:/// URI - it fails.

Repro steps:

I have the `git` repo cloned and built into the CWD at v2.28.0
git/git clone --filter=blob:none file:///home/nipunn/src/git git2

nipunn@nipunn-dbx:~/src$ git/git clone --filter=blob:none
file:///home/nipunn/src/git git2
Cloning into 'git2'...
warning: templates not found in /home/nipunn/share/git-core/templates
remote: Enumerating objects: 177110, done.
remote: Counting objects: 100% (177110/177110), done.
remote: Compressing objects: 100% (61436/61436), done.
Receiving objects: 100% (177110/177110), 62.58 MiB | 43.95 MiB/s, done.
remote: Total 177110 (delta 114305), reused 176904 (delta 114102), pack-reused 0
Resolving deltas: 100% (114305/114305), done.
fatal: the remote end hung up unexpectedly
fatal: protocol error: bad pack header
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry with 'git restore --source=HEAD :/'

It seems to work ok with a remote URI or w/o a --filter arg.
I was able to confirm that the "bad pack header" is a "-1" response
code PH_ERROR_EOF
Perhaps the `fatal: protocol error: bad pack header` - should include
the error code as well.
Thanks
--Nipunn
