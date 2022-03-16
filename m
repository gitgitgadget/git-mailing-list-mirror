Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3D6C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 11:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355354AbiCPLgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCPLgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 07:36:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57E275CE
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:34:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5969bdf31so19304497b3.8
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ix78CkOhWZFpPLo/L/s7SWD8+Ih8y+dWjAD3zjzSVLI=;
        b=YW7WtB+D3hYgFGs/l0CuvLBTsmEkD36Wd6abDL61eWCqqyQS6YDhF9KND+fzpaJlvY
         hUGey8FIfOElxq1yReRl5TatmnrpEkPj08oPTKhZcunEBDUaAfnnVb9jAf1z6VUBwR2z
         rdB9wbtorY0ihTuWNYEa6FIe6DiUq8I/JOrHGqHcV1ruBLuMAlDdI2P5JnXApbr8dbRT
         BuVhME92D4AR7psW/faIU8MmKsHLFuZnavgnW8fjpj058ghx7Dw9MtaDC1yzLyQB/i59
         15j/0xiQKCkWYJNi3KtyG045poWS7NomGRbEInl9tSbK108shOxL1SbgtEEjb4jPqpi+
         KFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ix78CkOhWZFpPLo/L/s7SWD8+Ih8y+dWjAD3zjzSVLI=;
        b=tqgNFa2EZMuK6e66Hgw2WfO6r4qukpS66PaN5a6yEfGboCDc7kfSNiJuvaIQJdPJaP
         xtv6iCS91lV9RopUS2j8kje351SCvUiTtohVfHPkZIytm+WKI3tU6iOu7ATGLXmQCgHD
         U5HZ35rceFhpX3bcG/ANOkzd1geS7ZNpyrdt2qSnQ488XobxM7FSRtmjckAYDhfy/own
         SiqQn+Z2HKI426Mjx8Nno9gwWg7k+6aS7JmncftcBk/78sPsh0t4+nStog4M2syCdox6
         YtEgmnSTjDSGJixExR76dolI+u/pnJQ9JFdcdGxF2Oky1bzM4mw1jKvvsxrmPvFN2IxL
         vmsA==
X-Gm-Message-State: AOAM531SIUgNaSm1KFnfxOisjry79YQ2jqSO408ceMM1CBAUJM+kouMv
        aR6KHjTuoPJ5xYov/rohTC6Lcm7Bn4Oo5AnYXLRb9i2YZDs=
X-Google-Smtp-Source: ABdhPJxvAMVIbe0XeOfzkXEiTzLQ4wzMPF9tP0NkFNFKafikNF6v34Aep295bv9nN5CxZeooQaztsbdauBagApWaATo=
X-Received: by 2002:a81:3a0a:0:b0:2dd:d8:4936 with SMTP id h10-20020a813a0a000000b002dd00d84936mr29418425ywa.368.1647430489992;
 Wed, 16 Mar 2022 04:34:49 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Zhang <zhgdrx@gmail.com>
Date:   Wed, 16 Mar 2022 19:36:25 +0800
Message-ID: <CAJcwCMMMm=ZnkV3Xxbf+CpJqhRGx1KrdUzh90W-9dEPJ+i40xg@mail.gmail.com>
Subject: understand Diff Formatting --cc flag?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

understand Diff Formatting --cc flag?

hi,

  It is really too hard to understand Diff Formatting --cc flag.

  It is hard to understand"...hunks whose contents in the parents have
only two variants..".

  My question is:
   1)what does "variant" mean here?
   2)what about all the other cases? 0 variants, 1 variants, and 3
variants and even more?

   3)Can I understand "--cc" as simply as: "--cc lists only hunks
which were modified from all parents."


  Any comments, hinits are welcome!  Thank you in advance!


//---------------------------------------------------------------------
Here is the help from the command: git help log

   Diff Formatting
       Listed below are options that control the formatting of diff
output. Some of them are specific to git-rev-list(1), however other
diff options may be given. See git-diff-files(1) for more options.

       -c
           With this option, diff output for a merge commit shows the
differences from each of the parents to the merge result
simultaneously instead of showing pairwise diff between a parent and
the
           result one at a time. Furthermore, it lists only files
which were modified from all parents.

       --cc
           This flag implies the -c option and further compresses the
patch output by omitting uninteresting hunks whose contents in the
parents have only two variants and the merge result picks one of
           them without modification.

       -m
           This flag makes the merge commits show the full diff like
regular commits; for each merge parent, a separate log entry and diff
is generated. An exception is that only diff against the first
           parent is shown when --first-parent option is given; in
that case, the output represents the changes the merge brought into
the then-current branch.
