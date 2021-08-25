Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE44C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52234610CD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhHYMwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhHYMwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 08:52:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C48C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 05:51:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lc21so18958626ejc.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=p19a9UuiRUKRixnjD9X4WOwNV8NZOCafSJu3TtBM6QU=;
        b=sPIMAmsv+foEnMhpB/EbmCtiaQUsc0biMAi9FXkD+mfeZ9HWuzpqeOUeNgvL5DS0q5
         thA30/4c/LAXoyLHP/6pbpO5cyqsjVAMbxRYiDafbK7lWuwPzHvUYZk2QNj/mOI4mMYt
         2Ofn0tz7d4Brfyfy8mf8k8lWWJuYlTC/azUaWL+rGKWUeJ7UlNAxI9rOMqdjsP8JfEd5
         w2rvMatjJAk9FUKFAQSTbeN0QjpbZo8XLsxINsyw15qaV0rYxt5hQbVpvyxS/C57G6wB
         yKyho4IsipWOQ2eWhJEj0fOH7zDBWK6yYrLwVrcLkkF3dWOCGAUQ6ag43/IXmQj1duR7
         9RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=p19a9UuiRUKRixnjD9X4WOwNV8NZOCafSJu3TtBM6QU=;
        b=hfMtrZaqytbbegyYaNnL7yvkRdxkvsOhU/f/7g8eCS/uEHGn07c2YNh9AfC6YL3TWC
         eK4WwXWJgm1Yvis6FEyxdeQO7aBFVp7H91IjUh9nDJlnsJnLlvgcGeYPHe9UbCnJ8Gch
         BF+dQeXobQEYR9q6MJIDGNd0dAyY11OHuHK6jyRJgNIBiOpsFgcUOClg/i14c8S3hZvK
         lmgKmadRJUXXQoV9Xi63JX4HH40qGT4sWc9FQd0DTvanLRmRB0P1iFqIsgt6QFOkhnA/
         NV3SaxPgq7xCc2GlfKD6pVzaUc99/ZLuXNHfj5qgL5aTJ8q0jEYMInisARo3L1iIdt3C
         0M2g==
X-Gm-Message-State: AOAM533cGvbuzjMN8cvOOKJTJ9qFFKCH/2SLkN5FvpkcvhNPKE8UQHLA
        nTwaBJW/qkvkdozSxeT5ctg=
X-Google-Smtp-Source: ABdhPJzmNT/P2vtpGj4Eq+mr0h36pehmhDgWL/x450OEPeKSrlck55WqN1OMdtM1L4J/qoTg59qWPw==
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr47103849ejy.532.1629895916100;
        Wed, 25 Aug 2021 05:51:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ay3sm11184358ejb.0.2021.08.25.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 05:51:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-rebase unnecessarily change mtime of files
Date:   Wed, 25 Aug 2021 14:45:30 +0200
References: <7d29b582ef44785015e631251da8499b197ff4bc.camel@yandex.ru>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <7d29b582ef44785015e631251da8499b197ff4bc.camel@yandex.ru>
Message-ID: <87sfyxd6vo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Konstantin Kharlamov wrote:

> Suppose your branch has *one* commit that modified file `myfile`. When you
> interactively-rebase to that commit, mtime of that file will change even =
if
> though you did not change the file (i.e. commit you are on has changed th=
e file,
> but since you're *at* this commit, not before this, there shouldn't have =
been
> any change to the file).
>
> This might be bad for performance; however what concerns me personally th=
e most
> is that my editor keeps asking me "file was changed on the disk, are you =
sure
> you wanna modify the file?", which is confusing and annoying.
>
> I am also not completely sure, but it might be a regression, because I do=
n't
> seem to remember having that before.
>
> # Steps to reproduce
>
>  =CE=BB mkdir foo
>  =CE=BB cd foo
>  =CE=BB git init
> hint: Using 'master' as the name for the initial branch. This default bra=
nch
> name
> hint: is subject to change. To configure the initial branch name to use i=
n all
> hint: of your new repositories, which will suppress this warning, call:
> hint:
> hint:   git config --global init.defaultBranch <name>
> hint:
> hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
> hint: 'development'. The just-created branch can be renamed via this comm=
and:
> hint:
> hint:   git branch -m <name>
> Initialized empty Git repository in /tmp/foo/.git/
>  =CE=BB echo hello1 > file1 && git add file1 && git commit -m "1st commit"
> [master (root-commit) f1cc312] 1st commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 file1
>  =CE=BB echo hello2 > file2 && git add file2 && git commit -m "2nd commit"
> [master 8bed9e1] 2nd commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 file2
>  =CE=BB echo hello3 > file3 && git add file3 && git commit -m "3rd commit"
> [master e6d5aab] 3rd commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 file3
>  =CE=BB stat -c %y file2
> 2021-08-25 12:37:19.008378563 +0300
>  =CE=BB rebase-at e HEAD~2     # that is `git rebase -i HEAD~2`, then [e]=
dit the
> commit
> Stopped at 8bed9e1...  2nd commit
> You can amend the commit now, with
>
>   git commit --amend
>
> Once you are satisfied with your changes, run
>
>   git rebase --continue
>  =CE=BB stat -c %y file2
> 2021-08-25 12:37:37.375537063 +0300
>
>
> ## Expected
>
> The mtime of the file did not change
>
> ## Actual
>
> The mtime of the file changed by 18 seconds

I don't know if this is a bug or feature, I suspect the latter.

I think you'll find that if you use a TODO list like:

    pick X <commit changes 'foo'>
    break
    pick Y <commit changes 'bar'>

You'll find that if your "foo" won't be changed, but it would with:

    edit X <commit changes 'foo'>
    pick Y <commit changes 'bar'>

This is because, as you'll see with GIT_TRACE=3D1 we actually check out X~
and then apply it with "edit", but with "break" we'll check out X
itself.

I didn't dig further than that, maybe it's a bug, maybe not. The code in
d87d48b2e03 (sequencer: learn about the special "fake root commit"
handling, 2018-05-04) may or may not be involved, I didn't dig much.
