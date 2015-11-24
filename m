From: Stefan Beller <sbeller@google.com>
Subject: Re: Git clone fails during pre-commit hook due to GIT_WORK_TREE=.
 (regression 2.5 -> 2.6)
Date: Tue, 24 Nov 2015 09:57:35 -0800
Message-ID: <CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
	<CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Anthony Sottile <asottile@umich.edu>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 18:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Hqd-0000sE-6L
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 18:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbbKXR5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 12:57:39 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36040 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbbKXR5g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2015 12:57:36 -0500
Received: by ykdr82 with SMTP id r82so27678393ykd.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 09:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+uKUkVhLDkpVFxTYyuiPbgvViut2VMY91haesUKgITc=;
        b=XA+fsZiPZwK6YDGNnb2zjxcw4y8/iUalkdNTaiMC74zr9VjcvdicqvKyo8p5iCgEiT
         QzwIgZ03Oy+mRrc3rnzEjXmHAlCJQfIXywv0yNGhAkMXsoFln/CIbTgHMNrivKVEfw6v
         rgQ+T18Jn2jnXzYt+K6AFKV9FnnV0bLovwK70obsX9BS/XyCcGnfR1xfdyLh5748UkAK
         FJRdR+lSrzzVRtyxYM17LGaPfyXGOqWqo0AfGP0ZGQLwglfD3ZlEH12H4CNGA3TF8zyL
         ueE3SnKKcucQCN77SW++eA49D3FwkRMCNARz3mRPuxMCV7bmO9YsF5l8UDM+aGrW9eun
         Xjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+uKUkVhLDkpVFxTYyuiPbgvViut2VMY91haesUKgITc=;
        b=MXii74pFHUPYAXNpxwkyyeT7vG0SwvSro53drQw6OtI4Nn2ZWerpHfQ9sEVaCYy0I8
         PcPQ9WISsOfNDYR3VqLmf/HGPUsa4rXmKRoJaOtlFkKZAmNWolmNjEJC2pHvd+/W81sX
         Zx6QT+Q+vQKfT7c5pAHbvpfOZBJ6f3vNKnycFPLLdFdGAYFX6ncjGIn8wKKSwou3MdKG
         /2k2NgBkTKgPx7Z4dAkLB2QOb6C6SlGfXMYUK2+dWNE5TCHo13tlJ1FLm3wNtnxdESzl
         SjQjnEX/jPo3IxofHXZP60h3E7KgvYaQhDICRKrBslNx+l+ncJ+q9ayAtMKQ/1omxMrC
         4g1A==
X-Gm-Message-State: ALoCoQltIKG3ys1/oVRjgOycqMAK0UwUoWg5QGy2+tIJw3VvRlRgvJa2MnX9M23BoWYVxvyFdGzZ
X-Received: by 10.13.198.133 with SMTP id i127mr6364633ywd.252.1448387855380;
 Tue, 24 Nov 2015 09:57:35 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 24 Nov 2015 09:57:35 -0800 (PST)
In-Reply-To: <CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281621>

+to Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

On Mon, Nov 23, 2015 at 6:22 PM, Anthony Sottile <asottile@umich.edu> w=
rote:
> * Short description of the problem *
>
> It seems GIT_WORK_DIR is now exported invariantly when calling git
> hooks such as pre-commit.  If these hooks involve cloning repositorie=
s
> they will not fail due to this exported environment variable.  This
> was not the case in prior versions (such as v2.5.0).
>
> * Simple reproduction *
>
> ```
> $ cat test.sh
> #!/usr/bin/env bash
> set -ex
>
> rm -rf test
>
> # Exit non {0, 1} to abort git bisect
> make -j 8 > /dev/null || exit 2
>
> # Put our new git on the path
> PATH=3D"$(pwd):$PATH"
>
> git init test
>
> pushd test
> mkdir -p .git/hooks
> echo 'git clone git://github.com/asottile/css-explore css-explore' >
> .git/hooks/pre-commit
> chmod 755 .git/hooks/pre-commit
>
> git commit -m foo --allow-empty || exit 1
> ```
>
> * Under 2.6.3 *
>
> ```
> $ ./test.sh
>
> ...
>
> + git init test
> warning: templates not found /home/anthony/share/git-core/templates
> Initialized empty Git repository in /home/anthony/workspace/git/test/=
=2Egit/
> + pushd test
> ~/workspace/git/test ~/workspace/git
> + mkdir -p .git/hooks
> + echo 'git clone git://github.com/asottile/css-explore css-explore'
> + chmod 755 .git/hooks/pre-commit
> + git commit -m foo --allow-empty
> fatal: working tree '.' already exists.
> + exit 1
> ```
>
> * Under 2.5 *
>
> ```
> $ ./test.sh
>
> ...
>
> + git init test
> warning: templates not found /home/anthony/share/git-core/templates
> Initialized empty Git repository in /home/anthony/workspace/git/test/=
=2Egit/
> + pushd test
> ~/workspace/git/test ~/workspace/git
> + mkdir -p .git/hooks
> + echo 'git clone git://github.com/asottile/css-explore css-explore'
> + chmod 755 .git/hooks/pre-commit
> + git commit -m foo --allow-empty
> Cloning into 'css-explore'...
> warning: templates not found /home/anthony/share/git-core/templates
> remote: Counting objects: 214, done.
> remote: Total 214 (delta 0), reused 0 (delta 0), pack-reused 214
> Receiving objects: 100% (214/214), 25.89 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (129/129), done.
> Checking connectivity... done.
> [master (root-commit) 5eb999d] foo
> ```
>
>
> * Bisect *
>
> ```
> $ git bisect good v2.5.0
> $ git bisect bad origin/master
> $ git bisect run ./test.sh
>
> ...
>
> d95138e695d99d32dcad528a2a7974f434c51e79 is the first bad commit
> commit d95138e695d99d32dcad528a2a7974f434c51e79
> Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Date:   Fri Jun 26 17:37:35 2015 +0700
>
>     setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DI=
R
>
>     In the test case, we run setup_git_dir_gently() the first time to=
 read
>     $GIT_DIR/config so that we can resolve aliases. We'll enter
>     setup_discovered_git_dir() and may or may not call set_git_dir() =
near
>     the end of the function, depending on whether the detected git di=
r is
>     ".git" or not. This set_git_dir() will set env var $GIT_DIR.
>
>     For normal repo, git dir detected via setup_discovered_git_dir() =
will be
>     ".git", and set_git_dir() is not called. If .git file is used how=
ever,
>     the git dir can't be ".git" and set_git_dir() is called and $GIT_=
DIR
>     set. This is the key of this problem.
>
>     If we expand an alias (or autocorrect command names), then
>     setup_git_dir_gently() is run the second time. If $GIT_DIR is not=
 set in
>     the first run, we run the same setup_discovered_git_dir() as befo=
re.
>     Nothing to see. If it is, however, we'll enter setup_explicit_git=
_dir()
>     this time.
>
>     This is where the "fun" is.  If $GIT_WORK_TREE is not set but
>     $GIT_DIR is, you are supposed to be at the root level of the
>     worktree.  But if you are in a subdir "foo/bar" (real worktree's =
top
>     is "foo"), this rule bites you: your detected worktree is now
>     "foo/bar", even though the first run correctly detected worktree =
as
>     "foo". You get "internal error: work tree has already been set" a=
s a
>     result.
>
>     Bottom line is, when $GIT_DIR is set, $GIT_WORK_TREE should be se=
t too
>     unless there's no work tree. But setting $GIT_WORK_TREE inside
>     set_git_dir() may backfire. We don't know at that point if work t=
ree is
>     already configured by the caller. So set it when work tree is
>     detected. It does not harm if $GIT_WORK_TREE is set while $GIT_DI=
R is
>     not.
>
>     Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
>     Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds=
@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :100644 100644 9daa0ba4a36ced9f63541203e7bcc2ab9e1eae56
> 36fbba57fc83afd36d99bf5d4f3a1fc3feefba09 M    environment.c
> :040000 040000 1d7c4bf77e0fd49ca315271993cb69a8b055c3aa
> 145d85895cb6cb0810597e1854a7721ccfc8f457 M    t
> bisect run success
> ```
>
> Causing me a few headaches in
> https://github.com/pre-commit/pre-commit/issues/300
> I'm working around it in https://github.com/pre-commit/pre-commit/pul=
l/301
>
> Thanks,
>
> Anthony
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
