Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021DC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiGYUvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGYUvo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:51:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1E3140B8
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:51:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31e623a4ff4so123101597b3.4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=dujqwb34d8aPQlrnmdNTXuRVSE0AQFQTakpkP2+zsCM=;
        b=cUf9ABoUD3Z09CsjBgvikkPBferYeTnSIXnjNNCQIckRhU/Xh75lEo9z2MMlVF2Ap4
         I7G1Z2H9FlC9AWvqSEcv3kvfMBCk9v3BCFeNUloR7y+RZ9fbCEkfvHeeKHVUXydRF+zM
         jehslDSLCqbyUUIDnx3f579Lz7ueFGaYM34ypbCIUw6ZapRAjXqZUNoqDVh3zhNcVuNc
         gKw8vepVXbFVzFojb+yxsoBFg4Eqzd5kliFsQwDXlwp2rXnbWnDFN/rx5oVJ0GKpxcKp
         bx1V4sWBybj7Vd4Ts2sQva7xeKsHCd1B64VGP2A2ED0wpEOj8ejo+jVRLOvgvCXX3iG2
         46Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dujqwb34d8aPQlrnmdNTXuRVSE0AQFQTakpkP2+zsCM=;
        b=yF4b1eNTJZ5bWMoCq/o//ZLL8sbiESdopHhMSDxhNGGYMsFbpydyekzyRoVRPFn6r+
         ar3DAiIpfk5yb4QWfxAVHTdPtjMJQSuWR4Gt/JNNWNQxHTdACGxsLQeytG+Zr1Z69a+T
         FwSJqjOCzpHKUBoah0fUVnm6u2Znne+AGg+9jsDrt2LDjVAUzuHJqyLJZ7wSiuct5MFk
         JEwz/Jigm4B404KI7ZLUqIyFrQLdOxbY7mTXQ1L9FgeQaoMi74ZRfEsRoAjvNT2p4e/d
         HLmWRAZtmDjE5kdSqBRmXZ7lmPmAVy7myu7MyWWu1ooVjPpnAerFrkkQK3e1HyslhP89
         CS5A==
X-Gm-Message-State: AJIora95S7W8sZGJRv/dqtaT1LhRt7hcL0n7Nl/6/5RjWbjpb+iL+TEr
        v+lIHBuBBUuQDAhAvM7IBf9rzNLcTrgS9qMarjiWILJXlb2txQ==
X-Google-Smtp-Source: AGRyM1u8nQg1dlcN9Qg8qlUyDiUSvp3qhBk5pzmKPJs6uWrkQMksnNSls3V47sliHhtIgAGyToMtmJi8mD5S+YgMTZM=
X-Received: by 2002:a0d:f607:0:b0:31b:b1d2:37bf with SMTP id
 g7-20020a0df607000000b0031bb1d237bfmr11732449ywf.313.1658782302614; Mon, 25
 Jul 2022 13:51:42 -0700 (PDT)
MIME-Version: 1.0
From:   Elie Obeid <elieobeid7@gmail.com>
Date:   Tue, 26 Jul 2022 00:51:09 +0400
Message-ID: <CAFWJc9_QM1CQ69yXCOHTi4KSZJffhty5s=egUUx-6RTjUVF9+w@mail.gmail.com>
Subject: How to specify a remote branch in git worktree?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I have two remote branches prod and beta, I want to create one
worktree for prod and one for beta.


mkdir app && cd app
git clone --bare repo .git
git worktree add --checkout beta beta
git worktree add --checkout prod prod
cd prod
git pull
Mege conflict



As you can see, I get a merge conflict  right after I clone the repo,
create  the worktree and do a git pull, maybe the worktree is trying
to do a pull from master, I have no idea
How to fix that?


Best Regards.
