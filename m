Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7252A1D8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133050; cv=none; b=fHsT32rXOlKS75R7C0u6RBI94XFkntKFGLWm4OY15wsp0PRghWpkuWccTE6veqQc6WVUvsbJE7WUDRl+46zbxt97/D+icOb+4FUz+sPdKbiEdnSUoUJS3l+d4gcLVqGq5+duLb246MhRPkocO+AJb9mJzWot6k9VtfuxzT9/fT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133050; c=relaxed/simple;
	bh=aKuIW1ZJ1BxTYvN8th350iR0lCuBFPspcLOKEeAjfOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL3ITb6rszU38/zY0I6Ho0/yTQBVSNMdi9iGFMBWAVgeq6q9aSeY6Z4qYo2WxGKXaKjMPDEN++vHHhx+fIdytAvXPsrKGUp65jMkAMIUYfR+F75wx5SU3yxsEYhD5OyIAVErvpNZ5yjzdCDv2pcJQAQIVPpbhh6Qa3X0bOc2Q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfhz5haP; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfhz5haP"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f860c6015so47161839f.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723133047; x=1723737847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rj1VZLM+pge0EQWyaTVO7WNbHA9zKyE/62nNfDXfZQ=;
        b=gfhz5haPLRfkHMMWxKS7vs2HpS511+AN49FjwKJWW8g1RUl3bWWI1Za7+pzWRWMN6f
         2Fm4mlJpi5SU3aty9NkynlcoQvVHmhqG12vMwloe/hlYOygJFOEHJo9Qp62lMoSFozU4
         Ul2BnVThz+UBT8fFUU2eWJtmb1q3YJpv9rYM/AQnZ4gbGjIyrFxIVyWgvL5osNYImEeW
         S8KUcj7R0ydjSdEx2n2ZHoeenwNJqxFJ4fa8ktZTTwMivCj1QjLibMU6k+bnHU8gwC8J
         NfZ9LRsICFDKFcThKmVNh/vObJxKpohWMP1tG6KHKB0XxputakkfSG/dLntJWlVPBSE+
         oY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133047; x=1723737847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rj1VZLM+pge0EQWyaTVO7WNbHA9zKyE/62nNfDXfZQ=;
        b=XQdS62GaCScrKQmHKIO7KkX0luF4F+H1ENiRuLycOU7yRisAzFQU8u3zzHIVpNfkBD
         EU1gHGHUpIdPV7ZCkqyeREi7HtEoCVQOv22aIJcEOq6Ngf02J7uebo08/Md747wH/mXr
         Vy1VOaB0iwcxNHaRiaHh0Ms7fNr82Gjip+/bLtAa/heo1TPl6PvZS/GSTCk0NE7peZG9
         lNkG2xAR/wIMNpf2yhSd41MR4QSLvT+kfAcjtOYNYbVgyK4H1RHnD2zNYhOPf7p4KXp/
         ke5pAC0N4nOV9UOM4RgF76M9SaF8l0TJBZ2bLOhh/BbD2LcYnSbPgjdyowu+onsb8Nqp
         VXUg==
X-Gm-Message-State: AOJu0YyzsM5WVAUJXK6Zyh4lKPuw9a66UGNT1OcYX2zU4UdzKiJOH28y
	MNvWqij1gej1ZAKXdJC5sS7npnoNB7pAWNtIadYi1pUJvNQJvT7FfJfhVK9oML6WgJjSQRvHVlR
	zagOMZ+TpHWsj6QsH+6Ra9a+YHt8=
X-Google-Smtp-Source: AGHT+IFGq7I4/6wo7rl6ZgQrg37lk8xy1sNSddJ4+IAimNncS+4RQwOOfKeq4759byMVBPiRasbpC/V2y/DGXcO11DA=
X-Received: by 2002:a05:6602:2d90:b0:822:4344:5b6a with SMTP id
 ca18e2360f4ac-822537d96f3mr372498539f.10.1723133047296; Thu, 08 Aug 2024
 09:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
In-Reply-To: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 8 Aug 2024 09:03:53 -0700
Message-ID: <CABPp-BGo7-P+3w=Y2Mifox4xztzMhgLKBtnrrF9R1XM9ZDPqqw@mail.gmail.com>
Subject: Re: [PATCH] diff-tree: fix crash when used with --remerge-diff
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>, 
	Xing Xin <xingxin.xx@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:20=E2=80=AFAM blanet via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Xing Xin <xingxin.xx@bytedance.com>
>
> When using "git-diff-tree" to get the tree diff for merge commits with
> the diff format set to `remerge`, a bug is triggered as shown below:
>
>     $ git diff-tree -r --remerge-diff 363337e6eb
>     363337e6eb812d0c0d785ed4261544f35559ff8b
>     BUG: log-tree.c:1006: did a remerge diff without remerge_objdir?!?

Wow, this bug is around for 2.5 years, and then we both independently
notice and fix it within 3 weeks of each other:
https://github.com/git/git/commit/e5890667c7598e813edee0ac4e76d6e3cdd525ec

My patch is incomplete as it's missing a testcase, and you submitted
first, so let's stick with your fix, though.

> This bug is reported by `log-tree.c:do_remerge_diff`, where a bug check
> added in commit 7b90ab467a (log: clean unneeded objects during log
> --remerge-diff, 2022-02-02) detects the absence of `remerge_objdir` when
> attempting to clean up temporary objects generated during the remerge
> process.
>
> After some further digging, I find that the remerge-related diff options
> were introduced in db757e8b8d (show, log: provide a --remerge-diff
> capability, 2022-02-02), which also affect the setup of `rev_info` for
> "git-diff-tree", but were not accounted for in the original
> implementation (inferred from the commit message).
>
> This commit fixes the bug by adding initialization logic for
> `remerge_objdir` in `builtin/diff-tree.c`, mirroring the logic in
> `builtin/log.c:cmd_log_walk_no_free`. A final cleanup for
> `remerge_objdir` is also included.

The commit message from my patch also included an explanation for why
diff-tree was the only caller that was missing the necessary logic
(see the last paragraph, which kind of references the one before it as
well).

> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>     diff-tree: fix crash when used with --remerge-diff
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1771%2F=
blanet%2Fxx%2Ffix-diff-tree-crash-on-remerge-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1771/blane=
t/xx/fix-diff-tree-crash-on-remerge-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1771
>
>  builtin/diff-tree.c     | 13 +++++++++++++
>  t/t4069-remerge-diff.sh | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 0d3c611aac0..813be486dad 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -9,6 +9,7 @@
>  #include "repository.h"
>  #include "revision.h"
>  #include "tree.h"
> +#include "tmp-objdir.h"

The includes other than this one are in alphabetical order; can you
move this a line before?

Also, as an aside, folks in this project often just put includes at
the end, but I think it's a bad practice.  Whenever someone needs to
backport fixes or merge separate patch topics into seen/next/etc. or
even merge not-yet-upstream topics with newer upstream versions, this
practice increases the odds of unnecessary conflicts.  And it makes it
harder for the next person who comes along to spot whether a header is
already included (and sometimes leaves us including headers twice).
While each case is a small amount of toil so we tend to overlook it,
it's totally unnecessary toil in many cases.  Putting includes in
alphabetical order (other than the one include required to be first,
git-compat-util.h or its documented stand-ins) can often remove this
unnecessary toil.  Anyway, thanks for letting me vent.  :-)

>  static struct rev_info log_tree_opt;
>
> @@ -166,6 +167,13 @@ int cmd_diff_tree(int argc, const char **argv, const=
 char *prefix)
>
>         opt->diffopt.rotate_to_strict =3D 1;
>
> +       if (opt->remerge_diff) {
> +               opt->remerge_objdir =3D tmp_objdir_create("remerge-diff")=
;
> +               if (!opt->remerge_objdir)
> +                       die(_("unable to create temporary object director=
y"));
> +               tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
> +       }
> +
>         /*
>          * NOTE!  We expect "a..b" to expand to "^a b" but it is
>          * perfectly valid for revision range parser to yield "b ^a",
> @@ -230,5 +238,10 @@ int cmd_diff_tree(int argc, const char **argv, const=
 char *prefix)
>                 diff_free(&opt->diffopt);
>         }
>
> +       if (opt->remerge_diff) {
> +               tmp_objdir_destroy(opt->remerge_objdir);
> +               opt->remerge_objdir =3D NULL;
> +       }
> +
>         return diff_result_code(&opt->diffopt);
>  }

Your fix exactly matches mine, other than the header include location.

> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 07323ebafe0..ca8f999caba 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -110,6 +110,41 @@ test_expect_success 'can filter out additional heade=
rs with pickaxe' '
>         test_must_be_empty actual
>  '
>
> +test_expect_success 'remerge-diff also works for git-diff-tree' '
> +       # With a clean merge
> +       git diff-tree -r -p --remerge-diff --no-commit-id bc_resolution >=
actual &&
> +       test_must_be_empty actual &&
> +
> +       # With both a resolved conflict and an unrelated change
> +       cat <<-EOF >tmp &&
> +       diff --git a/numbers b/numbers
> +       remerge CONFLICT (content): Merge conflict in numbers
> +       index a1fb731..6875544 100644
> +       --- a/numbers
> +       +++ b/numbers
> +       @@ -1,13 +1,9 @@
> +        1
> +        2
> +       -<<<<<<< b0ed5cb (change_a)
> +       -three
> +       -=3D=3D=3D=3D=3D=3D=3D
> +       -tres
> +       ->>>>>>> 6cd3f82 (change_b)
> +       +drei
> +        4
> +        5
> +        6
> +        7
> +       -eight
> +       +acht
> +        9
> +       EOF
> +       sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> +       git diff-tree -r -p --remerge-diff --no-commit-id ab_resolution >=
tmp &&
> +       sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'setup non-content conflicts' '
>         git switch --orphan base &&

Test looks good too.

I'll be happy to add my Reviewed-by if you fix the header include order.
