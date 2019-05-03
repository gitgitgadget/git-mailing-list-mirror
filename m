Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D59F1F453
	for <e@80x24.org>; Fri,  3 May 2019 10:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfECK3Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 06:29:16 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56256 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECK3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 06:29:15 -0400
Received: by mail-it1-f193.google.com with SMTP id i131so8282983itf.5
        for <git@vger.kernel.org>; Fri, 03 May 2019 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYH/21y9v0abGC/B9LRXu1pD12y7OyIUa5KfaC2e+EE=;
        b=T4VbOhPCou7vM26cx3GqXamUbcuCGaTgKvezL1u0aT+pvTgSoOxKYUPXmx/TFEm+8f
         mD5UaCN40ayRbhmDsxvdtZaRiRDEyT8pMwFmhW3CaDkat3qtSVbL3DWq4zVxlAW1Ywhy
         q3hnpvxkY/5ej8e7S+nUefnoOuN+/LoJvbqoOFCm3vrXZCx6osMvZhJtERFTcAoOI/XO
         uHO+v8dbyho1m9JU6lv4PMrAlmga6506eSrnx5KKJo/VXdgr8c+RuKBvmxSwY0m2DZzC
         oOL4rwb3nGBO7aJ4RYXNHitNrgs18Wcf/ftHnQkSl9z0U7CWrMipbrdQ0ymiS4kXUy89
         GLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYH/21y9v0abGC/B9LRXu1pD12y7OyIUa5KfaC2e+EE=;
        b=kR1abi5k7Ey6pFHyjm19qiYsx7iG2p8O1QOu/5XBBB1fyPFWExUY6Gp/DX53hXhPCU
         b9x8MkEJ7IFYvjYuxuD6f3oGKx2qnzno6CDfuWIrkA5Hzme7jXI6LCz15zKih2sx/DUu
         TdBz39BkyrLDTV3pujGVJXQjXdfpOOOpaccSJ6QMj+hNYQT7uTB6tv0Op+NRuefPwKWb
         iFhWkNoUFzGtochPUjz3z0+mZUDN46lpsCj7T9HgwvityAGzXxcT6CJSFDbD5I4SIm5p
         KBcbi7CYbmb8TxooYWP3o6suCsgeSkCtEphkIaFlkFHaiX4d69b0uIxbJw0/mGoTbGml
         DL2g==
X-Gm-Message-State: APjAAAUsUxmg1N8f13bnofxUXQSGp3ZkzkhMQxySgCkJlsSX85lec4ZA
        s3AtyJACwDHh0auT9HwW3+1xdX9sjveC/VBRCDhBng==
X-Google-Smtp-Source: APXvYqys8BhWYJTkSFKkN9Vn2Kz1xOt+oLj16KF5Cd7QHRt0384Vzo11pNwtv5ppXW81aDmtcHoQI1AMwKpgKC8+VEw=
X-Received: by 2002:a24:478a:: with SMTP id t132mr6118163itb.123.1556879354836;
 Fri, 03 May 2019 03:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <2e321dbe-42a3-7516-52aa-4bc50a3c403e@boxie.eu>
In-Reply-To: <2e321dbe-42a3-7516-52aa-4bc50a3c403e@boxie.eu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 May 2019 17:28:48 +0700
Message-ID: <CACsJy8ArJ9Lc1pA7SbJ1OE6hK+rprXpZViLDPUKPMcWG7Bre3A@mail.gmail.com>
Subject: Re: bug: git pull may delete untracked files in submodule without notice
To:     Christian Spanier <cspanier@boxie.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 3, 2019 at 5:25 PM Christian Spanier <cspanier@boxie.eu> wrote:
>
> Hi,
>
> I found a bug where Git may delete untracked files without notice in
> certain situations. This bug effects Git 2.21.0 both on Linux and Windows.
> In summary this happens when git pull merges a commit that replaces a
> submodule folder with a symlink. Any files within the folder are deleted
> without notice.

Maybe it's not the same, maybe it is. But Phillip recently did some
work protecting untracked files and I think he touched a test case
about submodule. Adding him so he can check, if he has time.

> Check out the script below for details.
>
> This happend on some developer's machine and deleted a repository
> containing about 200GiB of files and tons of uncommited local scripts,
> log files and whatever, just because some other dev accidentally
> commited a temporary change.
>
> Greetings,
> Christian Spanier
>
> ##### PREPARATION #####
>
> # New empty repository #1
> mkdir rep1
> cd rep1
> git init --bare .
> cd ..
>
> # New empty repository #2
> mkdir rep2
> cd rep2
> git init --bare .
> cd ..
>
> # Clone repository #1 and create initial commit
> git clone rep1 clone_rep1_user1
> cd clone_rep1_user1
> touch README
> git add README
> git commit -m "initial commit"
> git push
> cd ..
>
> # Clone repository #2 and create initial commit
> git clone rep2 clone_rep2
> cd clone_rep2
> touch README
> git add README
> git commit -m "initial commit"
> git push
> cd ..
>
> # Add repository #2 as a submodule to repository #1
> cd clone_rep1_user1
> git submodule add ../rep2
> git commit -m "add submodule"
> git push
> cd ..
>
> # User 2 also clones repository #1 and #2 recursively
> git clone --recursive rep1 clone_rep1_user2
>
> # User 2 starts working in his folder and adds an important local file
> which is
> # not yet committed inside the submodule folder.
> cd clone_rep1_user2/rep2
> echo "important work" > uncommitted_file
> cd ../../
>
> # Meanwhile, user 1 temporarily switch out folder /clone_rep1_user1/rep2
> with a
> # symbolic link to a different folder (for whatever reason, maybe a copy
> of an
> # older version or anything).
> mkdir rep2_alternative
> cd clone_rep1_user1
> mv rep2 ../rep2_backup
> ln -s ../rep2_alternative rep2
> # On Windows this can be done with 'mklink /D rep2 ../rep2_alternative',
> # which requires admin privileges. The bug is not reproducible when
> # using a directory junction with 'mklink /D /J ...'.
>
> # He does some work on rep1 but then accidently adds the symbolic link
> to his
> # next commit and pushes the changes. Notice the typechange of rep2.
> echo "some" > work
> git status
> # On branch master
> # Your branch is up to date with 'origin/master'.
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> directory)
> #
> #         typechange: rep2
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #         work
> #
> # no changes added to commit (use "git add" and/or "git commit -a")
> git add .
> git commit -m "do some work"
> git push
> cd ..
>
> # NOW THE BUG:
>
> # User 2 pulls the changes and loses his important work in
> # rep2/uncommitted_file because Git replaces the folder with a symlink
> # without checking for modified or uncommited files!
> # He should get an error in this case!
> cd clone_rep1_user2
> git pull
> cat rep2/uncommitted_file
> # cat: rep2/uncommitted_file: Not a directory
> # "important work" in rep2/uncommitted_file is gone :(



-- 
Duy
