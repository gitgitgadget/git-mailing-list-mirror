Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC20C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbjD0OCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0OCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 10:02:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFBDAF
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 07:02:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so12659455a12.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682604149; x=1685196149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+l1C3YxZkjZsRWNJdRNG2smv2QYE/3rZKb9Woda59Y=;
        b=AtSXfdKham66NoWk7gVSVzZDGAD/N0ferCr+IZz6mFaUKzaJLgOy6bzE6TuYdd6WtG
         sluLE2wOol87izm/dHr6NOiBseC1kcReZJSLwcvuY7D4hEmz5yVonDqI0+u2DxEMdFBW
         6+fwP5QSzDsP8PQQxnlMY2In+QD2G4zJ0CmevTG3B6XJHAMDpf7TJq7/4iacymh38QKg
         //vWbJUHf0zoLl8NcVRW6oF7lOp8mZDA2DA2P/idxwSuCbba0R5GskmHUa0ToL4zlz/I
         jEX8ONAGm8/bfiXiaX05RRsWbhVdWU1bzenzFoTaZauXKCZksNi8z6Pw9btvtdgzUlku
         zM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604149; x=1685196149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+l1C3YxZkjZsRWNJdRNG2smv2QYE/3rZKb9Woda59Y=;
        b=mBEifeKCcTsZ4is3ZJ4e2uAvSOSrwmJ1VZ/a7b7jsj3Jto3ZHvHKV9d942wRFbEZ3p
         1hcDSDeisDd7hwK3YFphHAFhQcD4fuuZ6+Gy9V3Dw0KYy+frXEP7OvroG7XcwXShLjCC
         wWRUgJrqNovJGPjFqe9ftT2CAxg9AckcHY4p70LsJXkzCjWaZtbKpuJQaxm1wcY2Jflu
         mCoNnimLbffztLvaCo21g1KivG/cekd7eaVOZmAjYgXDRsqVf2oHOj0wUxz8H0t2PWy1
         XANJXOPoFGmxZqa/vvOGoM7vrZ7LmRHLVI1Dkw+Ui45vsH1FZFXePdocdzOH7lJhyPdO
         mkYg==
X-Gm-Message-State: AC+VfDwrgFpeejY1/w8zLlH/pwbcxnNXqIVuiH/lwCC13rnHWvP/NTF/
        yu+/wmtF5dJiJPZvZQSz0i1vGmsU9fVKSxRIECk=
X-Google-Smtp-Source: ACHHUZ4t46MIml6fpDxkrnTRdPFBiI77eBh1ra81CznmUesSDED3RSwVddgMtchYmkjwBSkbnMcW1Ks1+SW1G9rJ/Vw=
X-Received: by 2002:aa7:c586:0:b0:504:9349:7901 with SMTP id
 g6-20020aa7c586000000b0050493497901mr1524002edq.38.1682604148515; Thu, 27 Apr
 2023 07:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1470.git.git.1679109928556.gitgitgadget@gmail.com> <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com>
In-Reply-To: <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Apr 2023 16:02:16 +0200
Message-ID: <CAP8UFD1YG-NnHbG4kBmh7L=O3wVnYKHCd94xD6Up_+AwK1ABPQ@mail.gmail.com>
Subject: Re: [PATCH v2] attr: teach "--attr-source=<tree>" global option to "git"
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 7:44=E2=80=AFPM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> Undo most of the UI change the commit made, while keeping the
> internal logic to read attributes from a given tree-ish.  Expose the
> internal logic via a new "--attr-source=3D<tree>" command line option
> given to "git", so that it can be used with any git command that
> runs internally.

I am not sure what are the git commands that run internally. You mean
any builtin command? Actually from the sentence below it looks like it
means any command running as part of the main git process.

> Additionally, add an environment variable GIT_ATTR_SOURCE that is set
> when --attr-source is passed in, so that subprocesses use the same value
> for the attributes source tree.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>     attr: teach "--attr-source=3D" global option to "git"

Not sure you can do something about it but it looks like "<tree>" has
been removed after "--attr-source=3D" in the above sentence. It might be
that the commit subject wasn't properly quoted in the tool chain and
mistaken for an HTML or XML tag.

>     [1] aimed to allow gitattributes to be read from bare repositories wh=
en
>     running git-diff(1). Through discussion, a more general solution emer=
ged
>     (represented by this patch), which allows the attribute machinery to
>     read attributes from a source passed in through a git flag.
>
>     This version is the same as v1. Just changed the author to Junio as h=
e
>     contributed most of the code.
>
>      1. https://lore.kernel.org/git/pull.1459.git.git.1678758818.gitgitga=
dget@gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-147=
0%2Fjohn-cai%2Fjc%2Fattr-source-git-flag-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1470/j=
ohn-cai/jc/attr-source-git-flag-v2
> Pull-Request: https://github.com/git/git/pull/1470
>
> Range-diff vs v1:

>      -    Add an environment variable GIT_ATTR_SOURCE that is set when
>      -    --attr-source is passed in, so that subprocesses use the same v=
alue for
>      -    the attributes source tree.
>      +    Additionally, add an environment variable GIT_ATTR_SOURCE that =
is set
>      +    when --attr-source is passed in, so that subprocesses use the s=
ame value
>      +    for the attributes source tree.
>
>      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>           Signed-off-by: John Cai <johncai86@gmail.com>

If the patch is from Junio, I think you should keep his Signed-off-by. If y=
ou

> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -212,6 +212,9 @@ If you just want to run git as if it was started in `=
<path>` then use
>         nohelpers (exclude helper commands), alias and config
>         (retrieve command list from config variable completion.commands)
>
> +--attr-source=3D<tree-ish>::
> +       Read gitattributes from <tree-ish> instead of the worktree.

Nit: maybe something like "See gitattributes(5)." could help beginners here=
.

> diff --git a/attr.c b/attr.c
> index 657ee52229e..2539309b92f 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -1166,11 +1166,43 @@ static void collect_some_attrs(struct index_state=
 *istate,
>         fill(path, pathlen, basename_offset, check->stack, check->all_att=
rs, rem);
>  }
>
> +static const char *default_attr_source_tree_object_name;

I think we are trying to avoid global variables, but I guess there is
no infrastructure yet to put these kinds of variables into a global
struct.

> +static void compute_default_attr_source(struct object_id *attr_source)
> +{
> +       if (!default_attr_source_tree_object_name)
> +               default_attr_source_tree_object_name =3D getenv(GIT_ATTR_=
SOURCE);

I wonder what happens if the env variable is set to an empty string,
instead of unset...

> +       if (!default_attr_source_tree_object_name || !is_null_oid(attr_so=
urce))
> +               return;
> +
> +       if (get_oid_treeish(default_attr_source_tree_object_name, attr_so=
urce))
> +               die(_("bad --attr-source object"));

... so it seems that in the case of an empty string, we will just die
with "bad --attr-source object". That doesn't seem very user friendly
to me as users might not know or remember about the GIT_ATTR_SOURCE
variable when they get the error.

> +}
> +
> +static struct object_id *default_attr_source(void)
> +{
> +       static struct object_id attr_source;
> +
> +       if (is_null_oid(&attr_source))
> +               compute_default_attr_source(&attr_source);
> +       if (is_null_oid(&attr_source))
> +               return NULL;

It looks like is_null_oid(&attr_source) can happen when
default_attr_source_tree_object_name is NULL, Ok.

> +       return &attr_source;
> +}
> +


> --- a/git.c
> +++ b/git.c
> @@ -5,6 +5,7 @@
>  #include "run-command.h"
>  #include "alias.h"
>  #include "replace-object.h"
> +#include "attr.h"
>  #include "shallow.h"
>
>  #define RUN_SETUP              (1<<0)
> @@ -308,6 +309,9 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
>                         } else {
>                                 exit(list_cmds(cmd));
>                         }
> +               } else if (skip_prefix(cmd, "--attr-source=3D", &cmd)) {
> +                       set_git_attr_source(cmd);
> +                       setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);

This seems a strange to me as it looks like other similar options
require code like the following:

               } else if (!strcmp(cmd, "--super-prefix")) {
                       if (*argc < 2) {
                               fprintf(stderr, _("no prefix given for
--super-prefix\n" ));
                               usage(git_usage_string);
                       }
                       setenv(GIT_SUPER_PREFIX_ENVIRONMENT, (*argv)[1], 1);
                       if (envchanged)
                               *envchanged =3D 1;
                       (*argv)++;
                       (*argc)--;
               } else if (skip_prefix(cmd, "--super-prefix=3D", &cmd)) {
                       setenv(GIT_SUPER_PREFIX_ENVIRONMENT, cmd, 1);
                       if (envchanged)
                               *envchanged =3D 1;

>                 } else {
>                         fprintf(stderr, _("unknown option: %s\n"), cmd);
>                         usage(git_usage_string);

I haven't taken a look at the tests but the rest of the code looks good to =
me.

Thanks!
