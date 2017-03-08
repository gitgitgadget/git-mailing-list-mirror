Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FAF1202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbdCHTCZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 14:02:25 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33575 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbdCHTCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 14:02:24 -0500
Received: by mail-pg0-f43.google.com with SMTP id 25so16402506pgy.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t2pL9qcKVTlPtgleaj2D+UN0YA8ukvLc+zoC+kjTMBo=;
        b=rxIcP8q28Siv/FpsV/cP15rtJ/J7dVJhbgIRkBnWYLbieMnnJhYuzqnWxsfQt6jSeU
         IVrNtyoItTYku4E7IULmKQVp0slyjKUOIN1KsgjJdjsqel2wKIzTG6MyOPv2AfGjxaiv
         IHX9fpGcpkd9w5W2kgVyNF1LxVbw3J9f+hWrTKmqnhZGcEPuobNS7/dzFeaaFpDoOfKk
         UHZSl7mQMlO1PxBt2IsIHExnYSH/xoQUbVgr0wipkXaNrAwaldIGGIF4QDIlV66udwC/
         XSTjgrqrbf4nAP0dtX1Hia2frKOshzdCvSIYWy8nqnKRmdPD+du3dFg44GUzK81v7Jar
         1HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t2pL9qcKVTlPtgleaj2D+UN0YA8ukvLc+zoC+kjTMBo=;
        b=QXUskhkrF5QPJY3U6ruC9DgZLZpnGTLutBKFcoGOKweya3gP7D9fHynccNKVF0OOnQ
         D3WwcZofM1Tgxz2KfKl3Whe5+9JEAtguvi7Lck7xJWCiA9qhptSCcaUSuUOCNlv+hwgk
         YEz+NmlSa9eTrNqUVL+ZPBD6qg5w+sxF191q0rguU5daz9baomayfHV4VJ+LY5Vv10gf
         h745mgX03BbTWIhYIiJn7LFQAfLATkm+av0FcW/pd9tUxgmQof8kfJxaxoEt0yGTO+v0
         1B4uCZq3jagLPKhQA2NlvjgcU2Ab2Xi+aR1CpRmF4ema5U9idiK7hNaF5uxiNZMVtyNm
         be4Q==
X-Gm-Message-State: AMke39k2nAJ72xrhYeATWb1DouQBSNjutvnd8g4AHMZZ0tOvWaH142kevRKNg/JfmhXTrhHVGaeece/P28/dUo9K
X-Received: by 10.84.195.129 with SMTP id j1mr10657883pld.88.1488999237409;
 Wed, 08 Mar 2017 10:53:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 10:53:56 -0800 (PST)
In-Reply-To: <20170308174449.24266-1-me@vtolstov.org>
References: <20170308174449.24266-1-me@vtolstov.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 10:53:56 -0800
Message-ID: <CAGZ79kYJ9he-jhnA35m6az-T5Z58efmKsUaBw--_KzdGJPZb-Q@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
To:     Valery Tolstov <me@vtolstov.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 9:44 AM,  <me@vtolstov.org> wrote:
> From: Valery Tolstov <me@vtolstov.org>
>
> Remove code fragment from module_clone that duplicates functionality
> of connect_work_tree_and_git_dir in dir.c
>
> Signed-off-by: Valery Tolstov <me@vtolstov.org>
> ---
>>> I think we can reuse code from module_clone that writes .git link.
>>> Possibly this code fragment needs to be factored out from module_clone
>>
>> That fragment already exists, see dir.h:
>> connect_work_tree_and_git_dir(work_tree, git_dir);
>> Maybe another good microproject is to use that in module_clone.
>
> By suggestion of Stefan Beller I would like to make this micro
> improvement as my microproject for GSoc.

Thanks for looking into this code deduplication!

Well these two parts of the code are subtly different, though.
When applying this patch to origin/master (3bc53220cb2 is the
last time I fetched from Junio), then

    $ make
    $ cd t
    $ prove --timer --jobs 25 ./t[0-8][0-9]*.sh
... lots of output...
 Test Summary Report
-------------------
./t3600-rm.sh                               (Wstat: 256 Tests: 79 Failed: 24)
  Failed tests:  39-40, 43-59, 61-65
  Non-zero exit status: 1
./t4059-diff-submodule-not-initialized.sh   (Wstat: 256 Tests: 8 Failed: 5)
  Failed tests:  4-8
  Non-zero exit status: 1
./t7001-mv.sh                               (Wstat: 256 Tests: 47 Failed: 7)
  Failed tests:  39-45
  Non-zero exit status: 1
./t7412-submodule-absorbgitdirs.sh          (Wstat: 256 Tests: 11 Failed: 6)
  Failed tests:  3-7, 9
  Non-zero exit status: 1
./t7400-submodule-basic.sh                  (Wstat: 256 Tests: 90 Failed: 13)
  Failed tests:  46-47, 49, 75, 79-87
  Non-zero exit status: 1
./t7406-submodule-update.sh                 (Wstat: 256 Tests: 52 Failed: 14)
  Failed tests:  5, 28-31, 33-34, 36-39, 43, 45-46
  Non-zero exit status: 1

When then running one of them with debug output
(See t/README for the debug flags, I remember divx,
the video format as a sufficient set of flags to get enough debug output)

    $ ./t7406-submodule-update.sh -d -i -v -x
...
++ cd foo
++ git submodule deinit -f sub
Cleared directory 'sub'
Submodule 'foo/sub' (/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t7406-submodule-update/withsubs/../rebasing) unregistered
for path 'sub'
++ git submodule update --init sub
+ test_eval_ret_=1
+ want_trace
+ test t = t
+ test t = t
+ set +x
error: last command exited with $?=1
not ok 5 - submodule update --init from and of subdirectory
#
# git init withsubs &&
# (cd withsubs &&
# mkdir foo &&
# git submodule add "$(pwd)/../rebasing" foo/sub &&
# (cd foo &&
#  git submodule deinit -f sub &&
#  git submodule update --init sub 2>../../actual2
# )
# ) &&
# test_i18ncmp expect2 actual2
#

$ cd trash\ directory.t7406-submodule-update/withsubs/foo/
$  git submodule deinit -f sub
Cleared directory 'sub'
Submodule 'foo/sub' (/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t7406-submodule-update/withsubs/../rebasing) unregistered
for path 'sub'

$ git submodule update --init sub
Submodule 'foo/sub' (/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t7406-submodule-update/withsubs/../rebasing) registered for
path 'sub'
fatal: could not get submodule directory for
'/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t7406-submodule-update/withsubs/foo/sub'
Failed to clone 'foo/sub'. Retry scheduled
fatal: could not get submodule directory for
'/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t7406-submodule-update/withsubs/foo/sub'
Failed to clone 'foo/sub' a second time, aborting


So I think we're missing to create the directory? (Just guessing)

Maybe we need to have 2293f77a081
(connect_work_tree_and_git_dir: safely create leading directories,
part of origin/sb/checkout-recurse-submodules, also found at
https://public-inbox.org/git/20170306205919.9713-8-sbeller@google.com/ )
first before we can apply this patch.

Thanks,
Stefan

>
>  builtin/submodule--helper.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 899dc334e..cda8a3bc1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -579,7 +579,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         const char *name = NULL, *url = NULL, *depth = NULL;
>         int quiet = 0;
>         int progress = 0;
> -       FILE *submodule_dot_git;
>         char *p, *path = NULL, *sm_gitdir;
>         struct strbuf rel_path = STRBUF_INIT;
>         struct strbuf sb = STRBUF_INIT;
> @@ -653,27 +652,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>                 strbuf_reset(&sb);
>         }
>
> -       /* Write a .git file in the submodule to redirect to the superproject. */
> -       strbuf_addf(&sb, "%s/.git", path);
> -       if (safe_create_leading_directories_const(sb.buf) < 0)
> -               die(_("could not create leading directories of '%s'"), sb.buf);
> -       submodule_dot_git = fopen(sb.buf, "w");
> -       if (!submodule_dot_git)
> -               die_errno(_("cannot open file '%s'"), sb.buf);
> -
> -       fprintf_or_die(submodule_dot_git, "gitdir: %s\n",
> -                      relative_path(sm_gitdir, path, &rel_path));
> -       if (fclose(submodule_dot_git))
> -               die(_("could not close file %s"), sb.buf);
> -       strbuf_reset(&sb);
> -       strbuf_reset(&rel_path);
> -
> -       /* Redirect the worktree of the submodule in the superproject's config */
>         p = git_pathdup_submodule(path, "config");
>         if (!p)
>                 die(_("could not get submodule directory for '%s'"), path);
> -       git_config_set_in_file(p, "core.worktree",
> -                              relative_path(path, sm_gitdir, &rel_path));
> +
> +       /* Connect module worktree and git dir */
> +       connect_work_tree_and_git_dir(path, sm_gitdir);
>
>         /* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
>         git_config_get_string("submodule.alternateLocation", &sm_alternate);
> --
> 2.12.0.190.g250ed7eaf
>
