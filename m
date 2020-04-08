Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC00C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60C92072F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTHYCZGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgDHT2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:28:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33155 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgDHT2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:28:25 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so1368701iof.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Frhyb2oRY2hoMJI/I75GFdnYR2bL8hiwl2ZP4E6zu+Q=;
        b=YTHYCZGvxv33GD/fAE5Og4Hrb6z/Q47eM7LApXPHI3hqbDImQumCtcovFQyLrR4Ckd
         FUmNdplSy/yOUKeYqy0sP/pQ51jlaMgcC0t92uGsqqkvjdd0kW9LJ/fMoIJMeZ7awI9/
         oVB5O8ONhCAVoAtnAv5rOHZTfIMnzl9RkoyNhSHb2t28Vl2lVNOiHbpHT8I+Ml9oKvWf
         DxFVnxOglDFOxFsFQdqjJYJl+jXX0CnbYpjPhVq0o35he86ygbNqaPLY183dLYPXwQ5M
         3/x9dquarhy59g5MQRojUD9ScAbpj7F2Yfut47VM3Lhq/AGVauPO2jX8SIsww9MQGb/l
         ftPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Frhyb2oRY2hoMJI/I75GFdnYR2bL8hiwl2ZP4E6zu+Q=;
        b=jXq9oXoKddl2rF/jVEitMZ4Okhd2gChcvL299w8AYmGzrKQm4pkuughZWSt5Hkz7X6
         44Vu8HoOnPtEyeKbsF6/3+cWCFTCQmta6m0W5/0Hb1s7rUIkG9EzM03doVBMLtj5MLj9
         1o2n5Z0TRTROElZXLGM8Cn1VJIIsElS0WmFrImoR/zX0zjQL6SQlSiYlLDDJfv9aBCwK
         gWyClSbwXa4fFbTC8TcqM5ANbPTP/MIU+mrnp1IbV1s3uTCM4aYTkY1FZ346Hnsz70F4
         11eaaDxHpXbN246/o4FZM6Utq1tSRpsuTcqsmmh5P/ACdNdDEMXf5ILpbOuntbz3vz/o
         B+lg==
X-Gm-Message-State: AGi0PubTFoeCQA4zQg9wMwkiJrCjYjvvg1j6547fCRp+X5cdtqM4j8Om
        Lqclv4yhre4C9qkiJuMvyG8lF1MyGkI82Gxom/5eYTPJ
X-Google-Smtp-Source: APiQypKiZSS49rHihT6R0ZNFYBnSsiXQI1jLhX7wnmyCEGxKLKLFDDFChslkywDKjam18z4IKiWMjwB8cGNp2IfCa88=
X-Received: by 2002:a02:1c07:: with SMTP id c7mr8157592jac.19.1586374099941;
 Wed, 08 Apr 2020 12:28:19 -0700 (PDT)
MIME-Version: 1.0
From:   Erwin Bonsma <erwin.bonsma@gmail.com>
Date:   Wed, 8 Apr 2020 21:28:09 +0200
Message-ID: <CAG5PFTvqnR-aeJ=+4W5A5WKqJ8Wq3JsD7J5QjwprE+Nws+=YBg@mail.gmail.com>
Subject: Commit includes rename which was not staged, nor actually performed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I encountered a problem with git version 2.24.1 (Apple Git-126). When
committing changes to a single file, the commit included a rename,
which was not staged, nor actually carried out.

More specifically:

> git status
On branch unwanted-rename
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
modified:   it.xliff

Untracked files:
  (use "git add <file>..." to include in what will be committed)
Pending/it.xliff.todo

> git commit -m "Some fixes"
[unwanted-rename 98098ab] Some fixes
 2 files changed, 792 insertions(+), 826 deletions(-)
 rename de.xliff => Pending/it.xliff.todo (56%)

> git log --name-only HEAD~1..HEAD
commit 98098abe5bc9c10a644009e6d185fa967941caca (HEAD -> unwanted-rename)
Author: Erwin Bonsma <eriban@users.sourceforge.net>
Date:   Wed Apr 8 20:47:09 2020 +0200

    Some fixes

Pending/it.xliff.todo
it.xliff

> ls de.*
de.xliff # The file is still present

> git status
On branch unwanted-rename
Untracked files:
  (use "git add <file>..." to include in what will be committed)
Pending/it.xliff.todo # The file is still untracked

> rm Pending/it.xliff.todo
> git checkout master
> git checkout unwanted-rename

Now let's inspect the resulting revision again.

> ls de.*
ls: de.xliff: No such file or directory # The file is now gone, as
commit suggested
> ls Pending/it.xliff.*
Pending/it.xliff.todo # The untracked, removed file was indeed added
to source control

The changes can be reproduced on the unwanted-rename branch available
at https://git.code.sf.net/p/grandperspectiv/localization

The branch includes the wrong commit. To reproduce it:
> git reset --soft HEAD~1
> git restore --staged de.xliff
> git restore --staged Pending/it.xliff.todo
> git restore de.xliff

Now working copy is ready for replay.
> git status
On branch unwanted-rename
Your branch is behind 'origin/unwanted-rename' by 1 commit, and can be
fast-forwarded.
  (use "git pull" to update your local branch)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
modified:   it.xliff

Untracked files:
  (use "git add <file>..." to include in what will be committed)
Pending/it.xliff.todo

> git commit -m "Some fixes"
[unwanted-rename 4d1368c] Some fixes
 2 files changed, 792 insertions(+), 826 deletions(-)
 rename de.xliff => Pending/it.xliff.todo (56%)

Cheers,
Erwin
