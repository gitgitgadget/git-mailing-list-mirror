Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2495C4332F
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 20:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJPUvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 16:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJPUvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 16:51:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB682D1F3
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 13:51:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l5so10301382oif.7
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1WtrQiNlg1/nrOit+WMv7vykjJD632x4wVWUv/MPi6c=;
        b=bJb+I35uXXyXdIf3sIpEUf92625kKtcxpPtuxrEYgMIlaNAgFh2QCfLyyQXH+NlxK8
         Qn46H+Jjzlt46fbqJPmcTsYBs+ODQ/RS6Jb6H8AhBGr47WpRF3vE8XdTYKr2vQja5zvm
         Wa8Gq5/3eTi9VO8tRywynBsHMBmTO9Xt4ZdBxKLAPDrQ9w9aX0r0FmxFN5tEGR+pFLcC
         HLZkUBPGB+PhNuY/bjTS7nnmyJgIrk9P6p0ruopDYN1IsIOo/94Xi30XT2oTt+1e5DUe
         cPhf8C1b67SGGryg8sKY0vRJFKZaeW/MUhfArqqgZeUdm6haVEBoVw8lan1bICEMQVET
         uMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WtrQiNlg1/nrOit+WMv7vykjJD632x4wVWUv/MPi6c=;
        b=j5pMTuvx4xOCCbSvkzIbMfAQLBFvIdthRykoDYWVBr3JvHfG1TKkk6+GYfoGSEs2Bf
         nF9r9EYfG1NX+8PgG5dw4hWEjS3KTCCXdguPVNDYKNsAbZxFz5TRDX+TntHCKUWQmEyq
         G58URCJ81O6q5hT/LkdgbHjyh7koQKz4K1EH5P64ffG1J+6aBPNWEsNgGhjQrnIkhJPH
         8gmxhiegZfXj0ME2jmNRRFWifZhtiNXsZX8WT/R73nyorCEuhM187nR2hWz9mwzB2Fti
         tD2TsIwGdAXa2a+EG92LZd3iBqPXksw2rs8qpQXDW/ERMqDELUd3tP6ZQfVrEDwHFXD1
         BFJQ==
X-Gm-Message-State: ACrzQf2+0LdcEavfQddDOPU+OY/OxhC24J3aI18YF+B2iWfkvsgsqZSV
        G3TrCUMy1xEKvAVivx7VIJcwysYIj6QcYbF1SWD1oF1ghe0=
X-Google-Smtp-Source: AMsMyM43fCXpkaVPcKpasYLGKnvY0457TaNLBhV6aZQ3cNzAlycqvVRgs9/ZcHAMdw/4ZFB2oJOMDPRcoT/CYgUYisE=
X-Received: by 2002:a05:6808:1507:b0:355:3ec:3109 with SMTP id
 u7-20020a056808150700b0035503ec3109mr3761789oiw.263.1665953459549; Sun, 16
 Oct 2022 13:50:59 -0700 (PDT)
MIME-Version: 1.0
From:   Bob van der Linden <bobvanderlinden@gmail.com>
Date:   Sun, 16 Oct 2022 22:50:50 +0200
Message-ID: <CALOmz0vW-jZo-60+mq-5zJtrX-1HtU3Afvmx1A4Z2bPSdehAyg@mail.gmail.com>
Subject: Re: [PATCH] completion: support amend and reword in git commit fixup option
To:     gitgitgadget@gmail.com
Cc:     Bob van der Linden <bobvanderlinden@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmm, I cannot figure out why `CI / win+VS test` is failing on GitHub CI.
The logs do indicate `Result: FAIL`, but I cannot see which test is failing.
It's surprising, as my changes seem totally unrelated to Windows.

Could anyone help out?
