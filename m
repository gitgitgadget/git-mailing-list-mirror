Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEAFC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010C2208C7
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYNKEHPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgFRQsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgFRQsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551AC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 09:48:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b5so3028587pfp.9
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mrOpbZXuYTMZV85/VVYg9R4lwdDwP/SYp390EWTnXKM=;
        b=ZYNKEHPm+r/FBuiEIfQpCDpfIVd5kv7InyOCOC6FDgpvTsBFw2Mg2pTdmdIl1uhpED
         8nMRkkLPUrFoQdPPHGerIZaCB2pV9/ZGJVUtFvfjCx4nfXpSjdHYWrVNIWQOYzOzXqAV
         qcBsujN7hyEg/O9y1Sj9EvvTGnJSuFRZj9NPO+pRI2jET1bFMBk8yzp0hWUAgXTD0nA5
         AdiVe63iJBwLuQ1Nn1qxlJcYPFOBj4dDFYY+eTszYDCq4rNV/wUXBjLdjgdtmV+Bk1FW
         sqKk3733gsDJdv94VsmMxPTGue7uYws84PZT1e2EHfQVUDzbMXOLEoMZpt3/GD2f0+8E
         bGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mrOpbZXuYTMZV85/VVYg9R4lwdDwP/SYp390EWTnXKM=;
        b=LCjRKSTHMzN5icMmgqJSja4ddDuPuQR6XHm7+n+w1tLHJUs2a5+d39o6+iiXuySZxz
         Nd3FQkn2B1AYU+wlBqaJrIJp1r1kd8urAUVhig/cjFEvOuSDkvmiJZrBy/N3fXoODect
         jXmRNLktAmHOddUqLS0lLdJvXt+0q8FdroZ3MGnb8whjsoWFD42RnEsaHmTQKmbV8RGf
         ihh5VC+r/gJLYPyZuOi70UH02C77SLtKo8QvNej16teqiGhl5Qky1lTVdveR5AGlbI+Y
         9ABRVQsxk+UfnM5OeS09TwGfIXRIUzw+C0x/AkdkgLFSJEzV/ulc5hNRBD/9L5wk/FWF
         B68w==
X-Gm-Message-State: AOAM533iADIgIQhqe6b4KpcnuFGCteTj3D/vH2YjvhgJvq87DtBA3swF
        Af5PQGze7YKcS+Mxz2NqmCVpyVtcdiLTGN60mrd1Lo1d
X-Google-Smtp-Source: ABdhPJxYDdIvwqg+NbE2dUS33PKX4N8i25Xd1f7EmGvFoPIygw8VsnqkwFbTSZqgpzJw0jcLmhIgoCpsMc3SXXTaW4M=
X-Received: by 2002:a63:4911:: with SMTP id w17mr3957573pga.13.1592498899378;
 Thu, 18 Jun 2020 09:48:19 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>
Date:   Thu, 18 Jun 2020 18:48:08 +0200
Message-ID: <CAHbriek39i9NSHRw6DZm0dftk-GkeAYR74c0xyss0vbeDHu1Hw@mail.gmail.com>
Subject: git init --separate-git-dir doesn't play nice with linked working trees
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have identified two potential problems when using git init
--separate-git-dir with a repo that has linked working trees (created
using git worktree add).
1. Moving the gitdir of a main working tree doesn't inform linked
working trees that their gitdir has moved. It seems to me that if I do
cd main-worktree && git init --separate-git-dir=.git_repo, the git
init command should go to all the linked working trees and change
their Git links to point at main-worktree/.git_repo. But perhaps
there's some use case I'm not aware of where you'd want to change only
the gitdir path of the main working tree, and not those of linked
working trees.
2. Attempting to move the gitdir of a linked working tree breaks the
linked working tree entirely.
It seems to me that if I do cd linked-worktree && git init
--separate-git-dir=.git_repo, it should fail, or warn, or do something
other than break the linked working tree. (I note that
linked-worktree/{.git,.git_repo/commondir,.git_repo/gitdir} all point
at the wrong thing after this operation; manually fixing them restores
functionality, though it loses the link to the main working tree.)
