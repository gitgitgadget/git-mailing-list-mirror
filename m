Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4DC433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 21:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FBF20717
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 21:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsy59I7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgGUVVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgGUVVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 17:21:08 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965DAC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 14:21:08 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p25so39563vsg.4
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gf1lH5gSYuvs2sbqe448TOkAoiJT1NV8i3lpBmNMAAk=;
        b=nsy59I7eduKsujt2yhryWxDmsVDBwbbSYLJQK0yqjTnFBwloaCKmhE9/nd8Hq3e792
         bHhMRqyCpigVsyHrLgJj7aJ6JZwwznRjRoLDIJ6JVag4CEeiP/SV7jPzJYkH8DqVMO3v
         ZmvXUC1eHt24Bz7oNDwEEYi13sLRLsylZH8zpzy10Ce+BFvOMvMHDOlu4e2eo5Bwzw82
         Tq9dPQki2uCiKxHdpbf1pmD/oPxT2K5Lz4lKsFBnb4C8Mih+OklguNQiowYvacRj2GhY
         gz6ADsHK/6t1uN4OIK0qBTvpuuW6YaFCdcw3CbpalonQT3W6YD/mS2WlO/IKUrPUEuR9
         pn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gf1lH5gSYuvs2sbqe448TOkAoiJT1NV8i3lpBmNMAAk=;
        b=oVFNIh2yL5P9hEiL98odgrATpVGU0XkviOmtxU9ArSPYRp4hN8inFoS29OfQYtS16j
         J1hMFetvg/N8Dmmqt76SERpQMH4AobWD84Dd6z3wwTUDKqrTbV2gPa2sLqH5r0Zlb4yt
         SJg0co3Dwm8R1D81DGsALGQZ9wkkaXLFFiMfrMvAbmxtWDigz+EskfDGZG/gqC+1PoAS
         fxvf5itauO1zjpLOjZShE7MUSQMI4xz95ZaBYtgMv9NfjS1FTFi/Qs/cWB1MZa6Oiup3
         4O9Vx51bpmzrAeCt9wh1COcrdNURf0xdZcS7pPGUUR7VL+6KCBpDjfAS5nbk+Dx4Btob
         aEUA==
X-Gm-Message-State: AOAM530ptuZNuFzz2pQ8589hywJg+C0nBQ1PjwD4X+a0VBGJeRXyPQhD
        vtN7K0Ww1ABTvsII3CAcaT28CFzyOsNiprqnLiGRI+SQXi0=
X-Google-Smtp-Source: ABdhPJxgU5k0xamfceAHG/ysWanijWwU3xS+OsUHTJH9GKDtXLNh5ov4f+wRzBtbN9x4WGgXtSPgBXS8NFn6JXFkC1A=
X-Received: by 2002:a67:7d01:: with SMTP id y1mr22681428vsc.38.1595366467216;
 Tue, 21 Jul 2020 14:21:07 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Marshall <joelmdev@gmail.com>
Date:   Tue, 21 Jul 2020 17:20:49 -0400
Message-ID: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
Subject: Possible issue with rebase's --rebase-merges option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
This is a difficult one to give proper steps to reproduce. The issue
is with rebase's --rebase-merges flag. We recently switched from using
rebase with the --preserve-merges option to --rebase-merges. Most of
the time the output is the same, but sometimes it is very different.
I'm unable to determine whether this is by design or a bug.

What did you expect to happen? (Expected behavior)
Resulting graph after running rebase --rebase-merges is the same as
running rebase --preserve-merges.

What happened instead? (Actual behavior)
Using --rebase merges tries to pick substantially more commits and
results in merge commits with no parent commit when viewing log in
reverse chronological order.

What's different between what you expected and what actually happened?
When the issue does occur (it doesn't for all rebases) it results in
two completely different logs and picks commits that are apparently
not part of the branch being rebased. eg, for a branch with 128
commits including merges, --preserve-merges picks 128 commits and the
resulting topology matches the original branch's topology.
--rebase-merges picked 183(?) commits in v2.24 and 202 commits in
v2.27, and in both cases resulted in a very strange topology.

Anything else you want to add:
Feel free to contact me at joel@tusksoft.com for additional details. I
would love to understand if this is by design or a legitimate bug.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.27.0.windows.1
cpu: x86_64
built from commit: 907ab1011dce9112700498e034b974ba60f8b407
sizeof-long: 4
sizeof-size_t: 8
uname: Windows 10.0 18363
compiler info: gnuc: 10.1
libc info: no libc information available


[Enabled Hooks]
