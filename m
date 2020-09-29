Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C8C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 17:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BF4208B8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFy8FAEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgI2Rax (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2Rax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 13:30:53 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8340C061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 10:30:52 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q4so5728811ils.4
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ksKGksV37iD20ehLX0M+pLKTZ0bNEYZxdQ81wEhBkFY=;
        b=vFy8FAEICss0+LRZpAgojIrDYRcllAHHM1BSowkRJlzk0EP0+fculQCOOLw2cVbyOR
         27/+W9gwMwyJW+m4N5yo/ocNWRsjzyuSEQAcOscsOuQpshxseTxg1igDqARpuU/lELgm
         sLo/L3wBQM2PyoHA6ua/GwVwgvsw+tRvRoMXae0AQXT6bUYb5qRVAEN39jxzwLLgioXz
         c9Kwrc2yCoYiuD9KMyeG782geLdISL2heXVlIYpUavr5ZZn3+Rdgbq3UvhIyA5pCQ4N+
         tJpC/+HHOJbdo4lJ5lG4Z64ZUjTjzTwr8bXtf+3ABCqSlEq9ceX65UsUzUfhTNgGqRcQ
         E/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ksKGksV37iD20ehLX0M+pLKTZ0bNEYZxdQ81wEhBkFY=;
        b=SdJpQJc1PmbnihAS4gpArMjxrmDaVitjuN82Bhg+Ji5gfDOwVc+FfbUfflM0ct1llo
         gIO1Fn3Sai2BrHp4jCmxcgngykr2brlc/pd+tAEler7RgieHXxltqYG7jlUDHBQSEiSp
         29S/sUSzRUGs1jloETojdltVFRL5kVrGfUFeWLnpxCm5SMEtcmvck/8sFXz4eoPd2K0D
         j0gUvjXMF4WOLfZTDhxgOpEo9ZEo4QNBHWSk8MRZ+pnpo77OjphnraotSD6K5dRV2YgR
         JXV4ySTTC4ZzaLphJPYB/glaPFLJxGEHr2g3LGS4DCZHT2K605I+z99H54EE4WR12fKw
         Pb1w==
X-Gm-Message-State: AOAM531Q3Xrd/lHZo43XHJylbCeMnYtKPArxwPAXpj+I4GFA+1yG8jfi
        0QGPn64C9sD0M+iLWW/8dEmUmNCh0ixm7XOREMWlxfK7Kq0r
X-Google-Smtp-Source: ABdhPJzsZ9lCyMui0+0BpsHd9TbxSupd0AmZfJzR5efuG1KaPBdvB820iTf0sofKNLB9bJ+Im596uJVEu1bh1TM1pwc=
X-Received: by 2002:a92:cd06:: with SMTP id z6mr3942937iln.252.1601400651667;
 Tue, 29 Sep 2020 10:30:51 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Date:   Tue, 29 Sep 2020 19:30:40 +0200
Message-ID: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
Subject: GIT_DIR output from git worktree list
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When you do move the .git folder somewhere else:

git init Test && cd Test && mv .git .git-b

and then do

cd Test &&
git --git-dir=.git-b --work-tree . worktree list

the output is :
..../Test/.git-b  0000000 [master]

Why is the output a .git Dir and not a worktree. I expected `.../Test`.

Thanks for the help.
BR Gabriel
