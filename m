Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668C5C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CD02075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO/y/Ldu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgAGMzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:55:55 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33398 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgAGMzz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:55:55 -0500
Received: by mail-wr1-f54.google.com with SMTP id b6so53863684wrq.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:mime-version
         :content-transfer-encoding;
        bh=pur6WsgA99DM90h1AlbrkDS1eoz8ph+YwuDTNA87sKU=;
        b=FO/y/LduqIeztsQGT1aMbkkDG1qHj0SFE501thdV4lz4aKrXly+FGZF4TSV5uOAIQo
         ab5lLkB8CGj7Xz5J/yu/agQZsoiryHQy3ruvAIXEW72ZrEK3WhEZkz4zW7O0qeukzn5A
         Zno9YtDx9q8PdmNTt1So2ZNrw/0P2bI+vGcjEemmS6uRxm4oRA3abC/FhrEYXZ19LWt+
         hGtaf4BkEiQph/rsLnPzrU43TunuQFVqv5SnmY+Hlbdm6ZMNQ+9W4bQ1qXmGI4ZOoRKj
         1HdIHoElAiYBOh/SOyauxlZHNam4EE6KuKqjHKpsbbPCJUoolxfZbAx/ld3P68b3f6FG
         dFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :mime-version:content-transfer-encoding;
        bh=pur6WsgA99DM90h1AlbrkDS1eoz8ph+YwuDTNA87sKU=;
        b=Tk/Y2t5TLvQDJdM1AFlrxO9mGY/X6r4DvRRxi7DTaSm1giJQU2qI7O90lf8vDz7IQE
         MHfOGaGghCtDIQTCnUphWlttShpgS/7v8xIxPXiI0L5HlrGSREOWGqBMPAm65rh6AoAA
         AcuCrBWwomAzoyRbZlGBqaQSbApTeqnN/VlIsnaxDfWufEUiVTXE4jOMlDywai8D8+mL
         Clmf7jo2rxvkSTXBcZWULaz8oSm50FPPnENC+xvlZymyj/zWupZeMM1KS8YN4WqoEE1z
         IRPx6jylGLmKBGEE05kNMXGAj84WPZ9Fp02rvkmaPET8ae47/nY2aSHjaG9yrZBe6A7p
         DNhA==
X-Gm-Message-State: APjAAAVXALrqt52wfeWM8VjoNkDpwEyvjHwqunlLvHy+Dj/Z/RlaPUl2
        sjzGTqXnv7EfRiH/hzhe2xZeJZDY
X-Google-Smtp-Source: APXvYqz5oLx4R0oUMbtBcnI/83LTQSUNO9uxRH2CQB1qfQkJOmQRUFEuWb23uqg8E9ZCDhxPgQaL5Q==
X-Received: by 2002:adf:f803:: with SMTP id s3mr107967139wrp.7.1578401751652;
        Tue, 07 Jan 2020 04:55:51 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id s16sm76791237wrn.78.2020.01.07.04.55.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 04:55:51 -0800 (PST)
Message-ID: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
Subject: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     git@vger.kernel.org
Date:   Tue, 07 Jan 2020 13:55:50 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

as written here https://git-scm.com/community I should sent reports to
this list - if I am mistaken please tell me where to direct this
question / problem I've encountered.

I've got a problem with a git branch and as this is the second time now
(I never hit that problem before I've started using the "new" git
restore --staged command - but since I am using it its the second time
now - maybe by accident, maybe related - I don't know).

Maybe someone can help me with this matter.

I am using 2.24.1 git and my starting point was a local branch and I
wanted to removed some files from the last commit I made.
So I did this:

1. git reset --soft HEAD~1

Now I had all my files from the last commit in the staging area and to
remove some of them I did:

2. git restore --staged $my-files

This worked too - now those files were moved to the working tree in git
status and were untracked and the rest looked still fine in the staging
area.

3. git commit

Now I made my commit - had a look on that with git show and it looks
fine.

But now I've hit the problem - looking with "git status" I was left now
with 6 files in the staging area all marked as deleted - still they are
in the working tree.
But I did never deleted them and the most annoying part now - I can't
fix that.

I tried:

1. git restore --staged

Does not change anything, still deleted in the staging area.

2. git stash

Does create a stash entry (did not look at the content though yet) but
staging area still unchanged.

3. git commit

Does create a commit but the whole commit is empty - nothing from the
tracked staging area is there and "git status" is unchanged - still 6
tracked deleted files.

I don't know what went wrong and I am unable to fix it - help
appreciated.
I can't share the whole git repository but I can try whatever git
command or other tool output may help here to shed some light on this -
as written I don't have a clear reproducer, I just have my branch with
a borked staging area.

thx and kind regards

Torsten

PS: Of cause I can delete the whole repo and clone it again or remove
the branch and start from a fresh new one ;) but I want to analyse
this.


