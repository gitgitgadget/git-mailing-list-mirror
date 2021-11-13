Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048CC433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C87610FE
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhKMDwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKMDwu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:52:50 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE378C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 19:49:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d10so28881294ybe.3
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 19:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V1red2i8nJHY2uoMjp9gHY/BtlX87O3xo45UlsZ1lZ0=;
        b=fC52JgdiE0+MhapXLqd5LL8EGidaqqU1nlvgkt0SyjJro6Z4zzFQGAPSZYAYOgoaWH
         ny6XpedbPYpbbMLNZx3fP57+Wwjpo2dbb6178xkv9rzkPJS2IUQL7gBU+xCR18kiccuG
         4WPeqStc+f+8WKmfFV0H1EamNYukrvNRfO7LLldd9Eskq0DvCRvBzwiyDgxidptoYTNR
         eSlsfvz2QZHtAKK7M6BZndWWS27Qymg7h0wcUZqN0LQu+mj7wfg/6P0jXpeMsUcAJC+j
         zrjypwQtakUc+muj6rkDmxxOwl7VooiSY1MB7Xs9DV9ivZmXJe62Mr23hLIyUtEE3pz2
         8KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V1red2i8nJHY2uoMjp9gHY/BtlX87O3xo45UlsZ1lZ0=;
        b=H8iMcKD1gyKVXEuxbwcOi+jOsq4EXk+B3Sh7EfsugUabfsaACAHaF7OP97PMOf6vk9
         /RJ4U1ngGPYy6cHrTqcWXEpJPN6uxDH2V6ZgDmmJxGP4vJr+/rEPqVPrNizhf4o5/SXh
         KBkkMV71cWgViHlujYDwocEy6d0R7wbul6zSMl6aImW4Cb7TQFSIn2a5MqYEyu3y+AdY
         C5fOjqrsid+GRmFZkSzRVeXTgllr/2L+FJIcUeq/kp6m1YFVcyOGT48+i1TShf7yg2ep
         uYCRic0aMkzy/NnQdqRx5tYqHFIGEOrJ/2iNR1YjjAjJcEJFnMttQ1lFB643McpMOXLX
         gOFw==
X-Gm-Message-State: AOAM533XW3jY3JtF7nMfq8a2VO/BOXfuse1Q1Tot2uByOp6p1qMGztNs
        7bYAlcyd0rYMclOTWj6Yc6/jS9Uuxz0JT0KwdG9CWiReZ0Y=
X-Google-Smtp-Source: ABdhPJwTolGgV4uT+3zWZixKYl0C0P4LXLqj364mxjuH1uYd4q+k7CjAahzGiyPXcSbQMZ7t4NA6B1lpjn8O5ru+ouk=
X-Received: by 2002:a25:ae64:: with SMTP id g36mr22006389ybe.45.1636775398021;
 Fri, 12 Nov 2021 19:49:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJcz5TVsv20+FmHR67_UhL_7rhEGvfPHeP3RMiRtnSGAEKiwBg@mail.gmail.com>
 <5aa1fb67-6bd8-6de3-8271-369722b6ebef@gmail.com> <da873a08-c73a-cc30-6b7d-dd5cd3bacb22@gmail.com>
In-Reply-To: <da873a08-c73a-cc30-6b7d-dd5cd3bacb22@gmail.com>
From:   Michael Schiff <schiff.michael@gmail.com>
Date:   Fri, 12 Nov 2021 19:49:47 -0800
Message-ID: <CAJcz5TXy37s=Ez-SwKHGS6ps_+oGSsyjXSVCC0=qnoPx2BE1QA@mail.gmail.com>
Subject: Re: Possible merge bug
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Saksham Mittal <saksham.mittal000@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script includes an extra new-line, turing the final change into a
2 line diff, which is caught correctly.  Modified to:
--- 8< ---
git --version --build-options

rm -rf sample
mkdir sample
cd sample
git init
echo -e "a\nb\nc" > test
git add .
git commit -m "abc"

git branch b1
git switch b1

echo -e "b\na\nc" > test
git add .
git commit -m "bac"

git switch master
git branch b2
git switch b2

echo -e "b\nc\na" > test
git add .
git commit -m "bca"

git switch master
echo "----- Merging b1 -----"
git merge b1
cat test
echo "----- Merging b2 -----"
git merge b2
echo "----- Content of test -----"
cat test
--- 8< ---

The only meaningful difference being the removal of the trailing \n
from the first echo.  Running it produces the output:

git version 2.34.0.rc0.377.g6d82a21a3b
cpu: x86_64
built from commit: 6d82a21a3b699caf378cb0f89b6b0e803fc58480
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
hint: Using 'master' as the name for the initial branch. This default
branch name
hint: is subject to change. To configure the initial branch name to use in =
all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint: git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this comman=
d:
hint:
hint: git branch -m <name>
Initialized empty Git repository in /Users/michaelschiff/Desktop/sample/.gi=
t/
[master (root-commit) 8d6bc12] abc
 1 file changed, 3 insertions(+)
 create mode 100644 test
Switched to branch 'b1'
[b1 b5328d8] bac
 1 file changed, 1 insertion(+), 1 deletion(-)
Switched to branch 'master'
Switched to branch 'b2'
[b2 98603f6] bca
 1 file changed, 1 insertion(+), 1 deletion(-)
Switched to branch 'master'
----- Merging b1 -----
Updating 8d6bc12..b5328d8
Fast-forward
 test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
b
a
c
----- Merging b2 -----
Auto-merging test
Merge made by the 'ort' strategy.
 test | 1 +
 1 file changed, 1 insertion(+)
----- Content of test -----
b
a
c
a



Happy to provide any other info that helps

On Thu, Nov 11, 2021 at 6:28 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Michael,
>
> Le 2021-11-11 =C3=A0 06:20, Saksham Mittal a =C3=A9crit :
> > Hello there,
> >
> > I wrote a small script as well that automates testing this use case as =
well, but I don't really know what the policy is on attachments in git, see=
ing as how it's my first time contributing to git.
>
> I used the script from Saksham (slightly modified to not depend on any Gi=
t configuration)
> and could not reproduce either with Git built from the same commit as you=
.
> Maybe some setting in your ~/.gitconfig is at play ?
>
> For the record, my edited version of the reproducer:
>
> --- 8< ---
> #!/bin/sh
>
> export PATH=3D"/path/to/built/git/bin-wrappers:$PATH"
> export GIT_AUTHOR_NAME=3DJ
> export GIT_AUTHOR_EMAIL=3Dj@l.com
> export GIT_COMMITTER_NAME=3DJ
> export GIT_COMMITTER_EMAIL=3Dj@l.com
> export HOME=3D
>
> git --version --build-options
>
> rm -rf sample
> mkdir sample
> cd sample
> git init
> echo -e "a\nb\nc\n" > test
> git add .
> git commit -m "abc"
>
> git branch b1
> git switch b1
>
> echo -e "b\na\nc" > test
> git add .
> git commit -m "bac"
>
> git switch master
> git branch b2
> git switch b2
>
> echo -e "b\nc\na" > test
> git add .
> git commit -m "bca"
>
> git switch master
> echo "----- Merging b1 -----"
> git merge b1
> cat test
> echo "----- Merging b2 -----"
> git merge b2
> echo "----- Content of test -----"
> cat test
> --- 8< ---
>
>
> Running it ends with this output:
>
>
> ----- Merging b1 -----
> Updating 5e00de3..02910cf
> Fast-forward
>   test | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> b
> a
> c
> ----- Merging b2 -----
> Auto-merging test
> CONFLICT (content): Merge conflict in test
> Automatic merge failed; fix conflicts and then commit the result.
> ----- Content of test -----
> b
> a
> c
> <<<<<<< HEAD
> =3D=3D=3D=3D=3D=3D=3D
> a
> >>>>>>> b2
>
>
> Cheers,
> Philippe.
>
