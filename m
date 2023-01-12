Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB50C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbjALKC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjALKA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 05:00:56 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9ED9A
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:00:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bt23so27623221lfb.5
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QfwtLsrVSSRoOeQHm06susddDybgnX+ySGL1sCRlDoQ=;
        b=PHFByplJW4zbxGMuZ0AfJxESb3Qf2hbwU9a5dABgWId002NIJF1dQNKARfaL61HqJR
         ej6VpruJXactZ0409QyAJOa+nkd1fQh47lAvp2pwNVDabFbRbxwi3AcaclF8Q2X1D4Yp
         lroq8KCjSpK4B6n+XZ2aFBt1J9Y48xR6XqkY4zAHx0K60ujxyQq9vR+rE0EmHBv2f96c
         boc7HbZ/K1KJXp4agbFPKFAJo5CRhXfg605xuw0vBeoLcc8PdyjhgqCyRwPXGD+AGDV4
         9l/SYox/3fGnGjqZPjd6OpCVStEtOV7dbadi2JxJQtgA13KYlHvdg8hx4Er3A/H+QcXx
         J1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfwtLsrVSSRoOeQHm06susddDybgnX+ySGL1sCRlDoQ=;
        b=tXCST0hx2hPmBfOati8HaXxgSBYyYpH88p64+msqnkunp4HGc8pcxRPMQycbbyNBlR
         w8668XHJnoU6T9wCcrQxz/b1axpb5HzuUgRzQ+snw4CLdNJurzXsgSrMGCf6wurAul/G
         LJxfn3zv7PnlIIFx0QRvzred2OzQFJDojxeryxhyU2hwNSqts8LuRgeTUeL031wu94vO
         gm6Qpcfnxt5VauH8vWQ5+h3VwbiKQzIow3Z0+ewpr1NzL2ziZSB5kqeK1qXw7CXvYQmv
         bgbW1jIyl5JQqv+kurM2iED3lFYMo2OEym6Adrqx9/mwxQQXONi3Nc026TWrGI5+rsIX
         rkqA==
X-Gm-Message-State: AFqh2kqTshcIKGP8GTIupoF2S3krTl4P5Di2As845dzHlkTTZYrFeJ16
        HV6mOGo7QKx0x0vDZQXn4iUvpUANIOtVTTTssGc=
X-Google-Smtp-Source: AMrXdXtxZEhgVwCywv1R8DeQ0Bq0I1WKQi664PMzTeR++v8i1TgFTdNxoAfnBxF7I8I1TUm0uqrJMASDLRhtULcKW2g=
X-Received: by 2002:a05:6512:241:b0:4cb:1fdb:ceb with SMTP id
 b1-20020a056512024100b004cb1fdb0cebmr2448806lfo.65.1673517616105; Thu, 12 Jan
 2023 02:00:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Jan 2023 02:00:03 -0800
Message-ID: <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 7:42 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Because sometimes we want to check if the files in the
> index match the sparse specification by using
> `git ls-files -t`, but `-t` option have semi-deprecated,

Where `semi-deprecated` was explicitly "suggest other functionality in
preference, but do not ever remove"[1].  The "suggest other
functionality in preference" for "ls-files -t" came about because
people got confused about staged files which have (a) no unstaged
changes, vs. (b) unstaged content changes, vs. (c) unstaged deletion
of the file.  Such users accidentally presumed that "H" (defined
simply as "cached") should only refer to class (a) when it refers to
the fact that the file is tracked (and not conflicted) and thus refers
to any of (a), (b), and (c)[2].  (I wonder if changing the definition
of "H" in the manual from "cached" to "tracked-and-not-conflicted"
would fix this confusion.)  In contrast, comparing tracked vs.
not-tracked-because-skip-worktree files, the distinction between "H"
and "S" makes lots of sense and naturally you want "H" to represent
all 3 of (a), (b), and (c).  So, for the skip-worktree bit usecase,
"ls-files -t" doesn't cause the same confusion.  (Perhaps the fact
that we have a tri-state of "M" (unmerged) vs "S" (skip-worktree) vs.
"H" (all other tracked files) could cause minor confusion, but in
practice the possibility of "M" just hasn't seemed to have caused
issues for sparse-checkout users or scripts.)

Further, since sparse-checkouts and monorepos really started taking
off 4-5 years ago, "git ls-files -t" has been used *heavily* (but
mostly by low-level script things rather than user-facing UI).  If we
wanted to come up with a better place to report on the skip-worktree
bit and have scripts rely on that, we probably should have made such a
change back then...if not another 8-9 years earlier.  At this point,
"ls-files -t" simply cannot be removed, even if we wanted to.

[1] As per this quote from 5bc0e247c4 ("Document ls-files -t as
semi-obsolete.", 2010-07-28):
    "git ls-files -t" is [...] badly documented, hence we point the
    users to superior alternatives.
    The feature is marked as "semi-obsolete" but not "scheduled for removal"
    since it's a plumbing command, scripts might use it, and Git testsuite
    already uses it to test the state of the index.
[2] https://lore.kernel.org/git/fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com/
(a.k.a. gmane:126516 from the commit message referenced above)

> So introduce "%(skipworktree)" atom to git ls-files
> `--format` option.

Given my above comments, I personally don't buy this as justification
for adding a new way of reporting on the skip-worktree bit.  It may
still make sense to add this feature or something like it, but I
personally think it deserves separate justification from "`ls-files
-t` is semi-deprecated".

(Others, of course, may disagree with me, but if this is the only
justification for this change, then I'm more likely to want to fix the
ls-files manual to remove the "semi-deprecated" notice and fix the
definition of "H" to be less misleading than to make a change like
this.)

> When we use this option, if the file
> match the sparse specification and removed from working
> tree...

The "and removed from working tree" portion of this sentence is
superfluous.  (And actually makes it harder to understand, I had to
try to think through a bunch of cases to try to figure out why you
might be trying to add some extra qualifier.)

> ...it will output "yes", othewise, output "no".

typo in "otherwise".

Also, your commit message claims output different from what your code
below implements and what your testcase shows.  ("yes"/"no" vs.
"true"/"false")

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[...]
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 440043cdb8e..0e50307121d 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -260,6 +260,12 @@ eolattr::
>         that applies to the path.
>  path::
>         The pathname of the file which is recorded in the index.
> +skipworktree::
> +       If the file in the index marked with SKIP_WORKTREE bit.
> +       It means the file do not match the sparse specification
> +       and removed from working tree.
> +       See link:technical/sparse-checkout.txt[sparse-checkout]
> +       for more information.

Should the actual wording be included here? (i.e. "yes"/"no",
"true"/"false", or whatever you end up using)?

>  EXCLUDE PATTERNS
>  ----------------
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index a03b559ecaa..d1a27f28f01 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
>                               data->pathname));
>         else if (skip_prefix(start, "(path)", &p))
>                 write_name_to_buf(sb, data->pathname);
> +       else if (skip_prefix(start, "(skipworktree)", &p))
> +               strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
> +                             "true" : "false");
>         else
>                 die(_("bad ls-files format: %%%.*s"), (int)len, start);
>
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> index efb7450bf1e..ac8b865c275 100755
> --- a/t/t3013-ls-files-format.sh
> +++ b/t/t3013-ls-files-format.sh
> @@ -92,4 +92,26 @@ test_expect_success 'git ls-files --format with --debug' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'git ls-files --format with skipworktree' '

Should probably add a
    test_when_finished "git sparse-checkout disable" &&
at the beginning of this test, otherwise you are potentially causing
confusion to future developers who try to add additional testcases to
this file.

> +       mkdir dir1 dir2 &&
> +       echo "file1" >dir1/file1.txt &&
> +       echo "file2" >dir2/file2.txt &&
> +       git add dir1 dir2 &&
> +       git commit -m skipworktree &&
> +       git sparse-checkout set dir1 &&
> +       git ls-files --format="%(path) %(skipworktree)" >actual &&
> +       cat >expect <<-\EOF &&
> +       dir1/file1.txt false
> +       dir2/file2.txt true
> +       o1.txt false
> +       o2.txt false
> +       o3.txt false
> +       o4.txt false
> +       o5.txt false
> +       o6.txt false
> +       o7.txt false
> +       EOF
> +       test_cmp expect actual
> +'

To be honest, I don't yet see any compelling reason to use this new
option.  Even if this patch is accepted, I'd just continue using "git
ls-files -t" (both directly and in scripts) in preference to this.
However, you have inspired me to try to fix up the ls-files
documentation and remove the "semi-deprecated" label for the -t
option.  Patches over here:
https://github.com/gitgitgadget/git/pull/1463 ; I'll submit them in
the next few days.
