Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1ECC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhKVHy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVHyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:54:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FFC061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:51:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso15872650wms.2
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aTtXESWDCzNqUuPmDw40nF4tKIcSHQ/pFYmejQhrkuY=;
        b=YTS4AVijUKEqrCAUrTDiqGdar0xGjwwPI7wms20oVN1A+ARfkdwQ2ll61pfwI2lSUc
         eBcDIk60Bb3ZZgO99bdNqfoLxE5RrvJO04SkNklgZxx186iZGv4LFkYL6ogeZbe0gWDX
         Wqydob0CZomGPzVAj19KWBEjVDuVie7Lk2xjudut2rK3ixeSUrbSPNHdszcQysHGcqVo
         lqynfotf81MHgN+2m+WSDw5ScoGJrJO7qQv8QiXH3B2bdSbeIc6NAUJ7ob1eczx5fFzm
         ojOpcshUtdbMmjYbWblzbOmKp89UX22E3+ISStlsa79aIjZXaQ7Ee5h2a7l9iGq1hwoZ
         g/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=aTtXESWDCzNqUuPmDw40nF4tKIcSHQ/pFYmejQhrkuY=;
        b=wKiVHyJHAQgOIFfXqKfiIBiqSiKSypQsj1LSHZd4J9UwYXy5FND8CVLCbc27v0Kw94
         yPBi8H1d7aKYI743XEZyUHx4J15siCvDzlYHVx5JJ3obuY7njgOeNGflmhrqzkBis6ib
         a+iDrP6aDcClrzWJk2jMSRqBFVkj3LN07FWyN3EXbtouvGJdES60Gndd8O62yHqjoOp/
         he0p/skR9pQkmu4Tli+DD7NfUABnLudleNbqu39jkCH8Wjs69xrEUlWWiNdOrbxfDqDg
         WhElLUeq9pgk70TaTmIrQdBGrvrPhnsoGJjUXmrvOl1wmWPPsiu0DUTQJtj4fJAai7cl
         higg==
X-Gm-Message-State: AOAM533E5nckfV33u5MX33osUojzmc7GzB6lyr4T/b1gHjYTh5p4H89Q
        RDGXrzp9OelzJzn7MD7TMUom0anKHPM=
X-Google-Smtp-Source: ABdhPJxgLHsmAS7Sfd8oSO368uI5tyS/x/PeQn8aEoW/4XryVJuSW7UHRFdV6j/gMtUgFhGdghub9g==
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr27748442wmq.102.1637567472438;
        Sun, 21 Nov 2021 23:51:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm9475926wmq.12.2021.11.21.23.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:51:12 -0800 (PST)
Message-Id: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
References: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 07:51:09 +0000
Subject: [PATCH v10 0/2] am: support --empty=(die|drop|keep) option to handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

cc: René Scharfe l.s.r@web.de cc: Phillip Wood phillip.wood123@gmail.com cc:
Aleen 徐沛文 pwxu@coremail.cn

Aleen (2):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches

 Documentation/git-am.txt           |  8 +++++
 Documentation/git-format-patch.txt |  6 +++-
 builtin/am.c                       | 55 +++++++++++++++++++++++++++---
 t/t4150-am.sh                      | 49 ++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 6 deletions(-)


base-commit: ca35af825273b98fc8dc11527488952f5db8eb80
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v9:

 1:  3b41ca3dec7 ! 1:  59bce7131da doc: git-format-patch: describe the option --always
     @@
       ## Metadata ##
     -Author: Aleen 徐沛文 <aleen42@vip.qq.com>
     +Author: Aleen <aleen42@vip.qq.com>
      
       ## Commit message ##
          doc: git-format-patch: describe the option --always
     @@ Commit message
          This commit has described how to use '--always' option in the command
          'git-format-patch' to include patches for commits that emit no changes.
      
     -    Signed-off-by: Aleen 徐沛文 <aleen42@vip.qq.com>
     +    Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
       ## Documentation/git-format-patch.txt ##
      @@ Documentation/git-format-patch.txt: SYNOPSIS
 2:  d2ec18b36af ! 2:  5025ad30ba7 am: support --empty=<option> to handle empty patches
     @@
       ## Metadata ##
     -Author: Aleen 徐沛文 <aleen42@vip.qq.com>
     +Author: Aleen <aleen42@vip.qq.com>
      
       ## Commit message ##
          am: support --empty=<option> to handle empty patches
     @@ Commit message
          those empty patches. In this commit, we have implemented three
          valid options ('die', 'drop' and 'keep').
      
     -    Signed-off-by: Aleen 徐沛文 <aleen42@vip.qq.com>
     +    Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
       ## Documentation/git-am.txt ##
      @@ Documentation/git-am.txt: SYNOPSIS

-- 
gitgitgadget
