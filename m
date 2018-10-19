Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747F81F453
	for <e@80x24.org>; Fri, 19 Oct 2018 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeJTEsH (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 00:48:07 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44837 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeJTEsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 00:48:07 -0400
Received: by mail-ed1-f53.google.com with SMTP id z21-v6so32560042edb.11
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6lUeGaOWDDkYY1AgDBGSpVnTN97CuYcGuye/AVgvgI=;
        b=Y3P/gob4dEPP2DmRmyrR98vW8bIaY0Ej/dpgmzpPRXHS5eEjHZztClyJ9w4duxkztK
         XigelJTzs/t3VV+7Mm3L4jbRdZHUuVFe94XSy/3pYCK37dH2nVi1CzwKHsVujqoOazcg
         0E9uPzqmPu8sM7FZdyst0m6yhaIsPG2Lxvqcgdw5YhyAARMLbifEv9ajjFghLgwzBqi7
         96i8FdmZ9TvGp4uyEVER6UFmsVrgHwYQ6x7cXrES8Dbzpw+i73c9yieOyLWJkCuzmZgS
         YMjJtXfu9PY0r99F3IpwvSdDVZVIlOj9v+fC6T6oeadg/JUNB73s/MoKFmnOBNU1m58V
         OMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6lUeGaOWDDkYY1AgDBGSpVnTN97CuYcGuye/AVgvgI=;
        b=da1rKQwOb1NpKubb1pycQKZV+DLeTg5hDzGiqWPOswS7a6Ly4h+kUZqdPR2LBLFDWD
         cEaAB+95Z/eElUI8BuGSvo2goGUFp4t2X2wHJgkL1eurbJRAiv6sHuY+2+GUWR9nwv+X
         DbqjjhO4zY2j+VO7RUMjBYJ7TFz2+Xoz6E/I38jD89lTD8O6id3p31Zs54GGs1frb5Wh
         4icojG0bMnkU8yMuQUqOeCihrxl6NM99w/ZZ0+mlSjifG1BnHWFOo6TGzvJ01u6L2wAz
         j1SZEsSjK6OMZkVb9lElLv7OTzv7c5V9MMCayz1Q2hHZl3pm2yq6AjsMungxLF2HdkrT
         T3gw==
X-Gm-Message-State: ABuFfojArra7kkyjhBKZopqlrIYy7Ax9rLXCTTY7agZRTnzrGwbDJjtr
        qkwxLlNqwrnmsmPoj6LA3vcl4+dPiCjx+Q2hRFL8w0xwsG49HA==
X-Google-Smtp-Source: ACcGV6258stgRkMRsNlXcOGy8CbODXNAx/gmiWf2y5eZG14tgKaKFPTaS3yCC+0UuedRkBW3dSY24qJ/Z+Kyf4qvvYo=
X-Received: by 2002:a50:b607:: with SMTP id b7-v6mr6728438ede.215.1539981624565;
 Fri, 19 Oct 2018 13:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <c4792c95-9a19-fd0e-9171-fded095b78a6@jku.at>
In-Reply-To: <c4792c95-9a19-fd0e-9171-fded095b78a6@jku.at>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Oct 2018 13:40:13 -0700
Message-ID: <CAGZ79kZ4NSCknQTkpurdj_CzD+XvFzdaz1bdxPTFizjwV8=rpA@mail.gmail.com>
Subject: Re: Bug with "git mv" and submodules, and with "git submodule add
 something --force"
To:     juergen.vogl@jku.at
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 5:43 AM Juergen Vogl <juergen.vogl@jku.at> wrote:
>
> Hi there,
>
> tested on both, git 2.18 and git 2.19.1:
>
> moving a file with `git mv` from a project to a submodule results in an
> **undefined state** of the local repository.

Luckily we do have a submodule in git.git itself, so we can
try it out here as well (I'll use a separate worktree to not
hose my main repo):

  git worktree add ../testgit && cd ../testgit
  git checkout v2.19.1 && make install
  git --version
  git version 2.19.1
  git submodule update --init
  Cloning into '/home/sbeller/testgit/sha1collisiondetection'...
  Submodule path 'sha1collisiondetection': checked out
'232357eb2ea0397388254a4b188333a227bf5b10'
  git mv cache.h sha1collisiondetection/
  git status
HEAD detached at v2.19.1
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

deleted:    sha1collisiondetection
renamed:    cache.h -> sha1collisiondetection/cache.h

Untracked files:
  (use "git add <file>..." to include in what will be committed)

sha1collisiondetection/.gitignore
sha1collisiondetection/.travis.yml
sha1collisiondetection/LICENSE.txt
sha1collisiondetection/Makefile
sha1collisiondetection/README.md
sha1collisiondetection/lib/
sha1collisiondetection/src/
sha1collisiondetection/test/
sha1collisiondetection/vs2015/

> It breaks up the submodule (it's still in .gitmodules, but not
> accessable via `git submodule`), and is not reversible on local repository.

This seems like what I just did. However reversing can be done via:

  git checkout -f
  git status
HEAD detached at v2.19.1
nothing to commit, working tree clean
  git submodule status
232357eb2ea0397388254a4b188333a227bf5b10 sha1collisiondetection
(stable-v1.0.3-31-g232357e)

So I think it's just "git-mv" that doesn't respect submodule
boundaries, which we would want to address.

The man page of git mv
(https://git-scm.com/docs/git-mv)
actually has a short note about submodules, but that is about
moving *a* submodule not about moving things in and out.

Maybe for now we can do with just an update of the documentation/bugs
section and say we cannot move files in and out of submodules?



>
> Either `git mv submodule/file .`

which is just running the command in reverse, (i.e. swapping
destination and target),
  git mv cache.h sha1collisiondetection/
  git mv sha1collisiondetection/cache.h cache.h
  git status
HEAD detached at v2.19.1
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

deleted:    sha1collisiondetection

Untracked files:
  (use "git add <file>..." to include in what will be committed)

sha1collisiondetection/

which seems like the submodule is gone,

> nor deleting the folder works. For the
> locale repo the submodule is gone.

Yup, that seems to be the case.

> But: trying to add it with `git
> submodule add` also do not work and results in an error message (with
> and without `--force` flag):

Would checkout out a state where the submodule still exists
(such as HEAD) and then running "git submodule update --init"
fix it instead?

>
> $ git submodule add git@github.com:-----------/wiki-public.git public
> --force
> A git directory for 'public' is found locally with remote(s):
>   origin        git@github.com:-----------/wiki-public.git
> If you want to reuse this local git directory instead of cloning again from
>   git@github.com:-----------/wiki-public.git
> use the '--force' option. If the local git directory is not the correct repo
> or you are unsure what this means choose another name with the '--name'
> option.
>
> Therefore, it's in a undefined, broken state.
>
>
> Another bug I've got by testing upper line:
> * --force will be used as folder name * when used in `git submodule add
> git@github.com:someone/some.git --force`:

Yes, the order of arguments is important, the options
(such as --force) goes before the URL and path.

> /usr/libexec/git-core/git-submodule: line 273: cd: --: invalid option
> cd: usage: cd [-L|-P] [dir]
> Unable to checkout submodule '--force'

Gah! We'd need to escape the path after the options,
i.e. cd -- --force
would cd into that directory, but I am unsure if that
is accepted by all shells.

Thanks,
Stefan
