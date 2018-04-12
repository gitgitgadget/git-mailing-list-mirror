Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC991F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeDLWTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:19:04 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51689 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeDLWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:19:03 -0400
Received: by mail-wm0-f47.google.com with SMTP id u189so1343864wmd.1
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J6i8iEklmg46i1YaAx+JZJmlKkaa9THG5yKj/qfdQqY=;
        b=OmGBemVnh2Ux4+MOS3enIHCrCP9YZA6DNRbFZfF0ly/5EEtn/OKUTgcXJUMyaJ+KGB
         VjAWeuJ7XvTTy/hlK6cgvaK9AdzTuHwQfdDX/DFPOKhhyIz55zt0Zb9yjkFrMES8d8Ah
         GyHz1i9lUftR8A9Ty7DmjNAVi3enwGNhke+uHs+AFTSF8ACQ6hkGRMP+yURrZ1iyVwZ6
         Y1/7eqfLXWF7l12EsNnlaNy1jfbIpjJHK/S22/qhHeHdBEERT2hNs3LPFcibVppvGYTU
         0TpAyqQNtXfBST7C2sUxMYukBZY5ANN+kRi3zohq96xTioT24stu+icaFRsUacXZQH5T
         Vngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J6i8iEklmg46i1YaAx+JZJmlKkaa9THG5yKj/qfdQqY=;
        b=Kpjzq84Mn4gECAN/ATfv2UtcFBHbGtW4rsGKeNmfky+KGk92C8kNTSUDM8DnpUzs9p
         KXiCTnEO8EqK9q6EHssM4GQkldVN7dbHZBrQ6HrHz1a0NJJGXU6i6RB7Cnb5WTvhPs13
         we1OdDjRs2J7hGROw3Fp74wy5zw5+8T505x1Q0njnAUb2zbo8qNwtrKcj7iXMxpobLNG
         zZzGHYcBvQ3dTr5Yu2BfAPvFMtZhPmg/QjfGMHxt3ZL+xtEYjtGU2dkRjqR1Rr4Vxqr6
         YXj+oZg2m2FWw68DT88CzsYadp411nj9rRfZYJ5V3y1EKUran+G5P4Od/sOrwdPKxTfw
         uhvQ==
X-Gm-Message-State: ALQs6tDhovU/m4ZL7fZ7f3BtBXsVaeQaZNkS2b0NIz+0wPYc68jEFxM7
        zIR3W60hVfLOgsEpfeoPyqtjK7M1fPlPb9JiaLmoeg==
X-Google-Smtp-Source: AIpwx4/t3yMvPx5Kncp3js1HMZ0S0cny4EG4PqysDKRpf2dvFhb4gQFFJ276BojdiZ2e764h1ivUGf78TZNTUO5HeSg=
X-Received: by 10.80.172.196 with SMTP id x62mr17470662edc.265.1523571542137;
 Thu, 12 Apr 2018 15:19:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Thu, 12 Apr 2018 15:18:41 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Apr 2018 15:18:41 -0700
Message-ID: <CA+P7+xrQhGdifOGVKCqw3bEBp-YVQwNNQiXzvECJfFpMRipu2g@mail.gmail.com>
Subject: git blame completion add <rev> completion?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I use git blame sometimes to blame against specific revisions, i.e.
"git blame <branch> -- <file>" and it would be nice if blame could
figure out how to complete the <branch> or revision reference..

I tried to take a stab at adding support for this, but I couldn't
figure out which completion function to use...

I want "git blame <TAB>" to complete files like normal, (as this is
the most general use case), but to have "git blame xyz<TAB>" to
complete revisions if there's any that match, (while still also
completing files). Additionally, it should only complete a revision
for the first argument, and go back to strict file names after.

In an *ideal* world, it'd be nice if it could figure out say:

git blame <branch> xyz<TAB>

and complete xyz as a file found in branch, not actually checking
local files but the ls-files of that branch instead. (i.e. it should
be able to complete a file that was deleted in the current checkout
but exists on that ref).

any ideas on where to start with that?

Thanks,
Jake
