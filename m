Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF88AC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiA0Tib (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiA0Tia (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:38:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C586C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:38:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id j2so8212675ejk.6
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9g0zLiWhvco3ZmFIc1Pp234D7esfZ/X8xucsdVFpsbU=;
        b=WaXF39Y0MW2O/z7i/mEqpUkzB+F8Q0HdpQcHuVzUvg4Y357cw+Zuux+GDNY4sD4cIf
         gTFZQSQqLTaWuWZRs/zqnHZyEADwh4cpn7tTJxli7BpKJBNcAaBAay//nrEf1VFM04L2
         UOtMqNYMHbgySzq92zdfnj22fVHBnJmjCXAM9YGBjBxXqu6Wx4Z2Uys5eHutB60pfMjR
         AHedIiXV924WMV4li7mBNGDyP27aVukfkNvCMT4HmerHyrIumzrX3tqMBN72vaA8E54y
         uvCjKzlbYiyE9kQ9lhrTj+1llz/Y+/9UhWBILKlI+e3byYY7uKycsN/Ii2krbkUyyas7
         q7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9g0zLiWhvco3ZmFIc1Pp234D7esfZ/X8xucsdVFpsbU=;
        b=s2oeTE6yFo3cTp0r5XGsJZTI8FPEpU1ZnA94yXE79au9Wnp72XIDLT4+5gdML9uT4u
         6ge5YYBsFw2p6hl6S5RdvkBax6WxUbRCr2aXQCjGvoAjJ1InC7BtdgMWm2NU1K4JgQo2
         +OhTZkSEQoAFnE2qfBEQe0gea1F+bPrlg9f4ilziv8JB+RpoHf0vSnZw0lRShS693Umw
         mfNukzUsofcjwshv2NdiBbv0/ouZ/t5hPixAV5++hX0pmwPWcZon/RDhrjoVVFUZwHIT
         ObkDyhskc2OWtfxAkOBZb3PyHSpwfp6Iby3lLh/gNpRJTrudY85xjsoUB+ZSPbpjLGh0
         g3jA==
X-Gm-Message-State: AOAM532Fp2KPzxlvGxxVkF+AHpQx5sLOBGpC3XH9F/Guu+bgtsljaScb
        zmwSNj81JTCa/QLDj47DBTN11lNZb/Qh6YEo19AnZ9k96XA=
X-Google-Smtp-Source: ABdhPJxg2PlTd+i1sPgWmLXssyHgStXW6LrK43xu9MWux3LPIDQhUD5SVYA8g7kw2SgPvA1+TkY/4hZjCJhUEVwfVGk=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr4073784ejc.493.1643312308668;
 Thu, 27 Jan 2022 11:38:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 11:38:16 -0800
Message-ID: <CABPp-BHob22kAHRWBX-QLyQFKWn-682xQnx5oehqW=WYO4PBDQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] Implement `scalar diagnose`
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 3:37 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Over the course of Scalar's development, it became obvious that there is
> a need for a command that can gather all kinds of useful information
> that can help identify the most typical problems with large
> worktrees/repositories.
>
> The `diagnose` command is the culmination of this hard-won knowledge: it
> gathers the installed hooks, the config, a couple statistics describing
> the data shape, among other pieces of information, and then wraps
> everything up in a tidy, neat `.zip` archive.
>
> Note: originally, Scalar was implemented in C# using the .NET API, where
> we had the luxury of a comprehensive standard library that includes
> basic functionality such as writing a `.zip` file. In the C version, we
> lack such a commodity. Rather than introducing a dependency on, say,
> libzip, we slightly abuse Git's `archive` command: Instead of writing
> the `.zip` file directly, we stage the file contents in a Git index of a
> temporary, bare repository, only to let `git archive` have at it, and
> finally removing the temporary repository.
>
> Also note: Due to the frequently-spawned `git hash-object` processes,
> this command is quite a bit slow on Windows. Should it turn out to be a
> big problem, the lack of a batch mode of the `hash-object` command could
> potentially be worked around via using `git fast-import` with a crafted
> `stdin`.

hash-object and update-index processes, right?  You spawn one of each
for each object.

I was you investigate the fast-import idea because it gets rid of the
N hash-object processes, the N update-index processes, and the
write-tree process, instead giving you a single fast-import process as
a preliminary to calling out to git archive.  It'd also have the
advantage of providing just one pack instead of many loose objects.

But Ren=C3=A9's suggestion to use and extend archive's ability to handle
untracked files sounds like a better idea.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 170 +++++++++++++++++++++++++++++++
>  contrib/scalar/scalar.txt        |  12 +++
>  contrib/scalar/t/t9099-scalar.sh |  13 +++
>  3 files changed, 195 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 1ce9c2b00e8..13f2b0f4d5a 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -259,6 +259,108 @@ static int unregister_dir(void)
>         return res;
>  }
>
> +static int stage(const char *git_dir, struct strbuf *buf, const char *pa=
th)
> +{
> +       struct strbuf cacheinfo =3D STRBUF_INIT;
> +       struct child_process cp =3D CHILD_PROCESS_INIT;
> +       int res;
> +
> +       strbuf_addstr(&cacheinfo, "100644,");
> +
> +       cp.git_cmd =3D 1;
> +       strvec_pushl(&cp.args, "--git-dir", git_dir,
> +                    "hash-object", "-w", "--stdin", NULL);
> +       res =3D pipe_command(&cp, buf->buf, buf->len, &cacheinfo, 256, NU=
LL, 0);
> +       if (!res) {
> +               strbuf_rtrim(&cacheinfo);
> +               strbuf_addch(&cacheinfo, ',');
> +               /* We cannot stage `.git`, use `_git` instead. */
> +               if (starts_with(path, ".git/"))
> +                       strbuf_addf(&cacheinfo, "_%s", path + 1);
> +               else
> +                       strbuf_addstr(&cacheinfo, path);
> +
> +               child_process_init(&cp);
> +               cp.git_cmd =3D 1;
> +               strvec_pushl(&cp.args, "--git-dir", git_dir,
> +                            "update-index", "--add", "--cacheinfo",
> +                            cacheinfo.buf, NULL);
> +               res =3D run_command(&cp);
> +       }
> +
> +       strbuf_release(&cacheinfo);
> +       return res;
> +}
> +
> +static int stage_file(const char *git_dir, const char *path)
> +{
> +       struct strbuf buf =3D STRBUF_INIT;
> +       int res;
> +
> +       if (strbuf_read_file(&buf, path, 0) < 0)
> +               return error(_("could not read '%s'"), path);
> +
> +       res =3D stage(git_dir, &buf, path);
> +
> +       strbuf_release(&buf);
> +       return res;
> +}
> +
> +static int stage_directory(const char *git_dir, const char *path, int re=
curse)
> +{
> +       int at_root =3D !*path;
> +       DIR *dir =3D opendir(at_root ? "." : path);
> +       struct dirent *e;
> +       struct strbuf buf =3D STRBUF_INIT;
> +       size_t len;
> +       int res =3D 0;
> +
> +       if (!dir)
> +               return error(_("could not open directory '%s'"), path);
> +
> +       if (!at_root)
> +               strbuf_addf(&buf, "%s/", path);
> +       len =3D buf.len;
> +
> +       while (!res && (e =3D readdir(dir))) {
> +               if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
> +                       continue;
> +
> +               strbuf_setlen(&buf, len);
> +               strbuf_addstr(&buf, e->d_name);
> +
> +               if ((e->d_type =3D=3D DT_REG && stage_file(git_dir, buf.b=
uf)) ||
> +                   (e->d_type =3D=3D DT_DIR && recurse &&
> +                    stage_directory(git_dir, buf.buf, recurse)))
> +                       res =3D -1;
> +       }
> +
> +       closedir(dir);
> +       strbuf_release(&buf);
> +       return res;
> +}
> +
> +static int index_to_zip(const char *git_dir)
> +{
> +       struct child_process cp =3D CHILD_PROCESS_INIT;
> +       struct strbuf oid =3D STRBUF_INIT;
> +
> +       cp.git_cmd =3D 1;
> +       strvec_pushl(&cp.args, "--git-dir", git_dir, "write-tree", NULL);
> +       if (pipe_command(&cp, NULL, 0, &oid, the_hash_algo->hexsz + 1,
> +                        NULL, 0))
> +               return error(_("could not write temporary tree object"));
> +
> +       strbuf_rtrim(&oid);
> +       child_process_init(&cp);
> +       cp.git_cmd =3D 1;
> +       strvec_pushl(&cp.args, "--git-dir", git_dir, "archive", "-o", NUL=
L);
> +       strvec_pushf(&cp.args, "%s.zip", git_dir);
> +       strvec_pushl(&cp.args, oid.buf, "--", NULL);
> +       strbuf_release(&oid);
> +       return run_command(&cp);
> +}
> +
>  /* printf-style interface, expects `<key>=3D<value>` argument */
>  static int set_config(const char *fmt, ...)
>  {
> @@ -499,6 +601,73 @@ cleanup:
>         return res;
>  }
>
> +static int cmd_diagnose(int argc, const char **argv)
> +{
> +       struct option options[] =3D {
> +               OPT_END(),
> +       };
> +       const char * const usage[] =3D {
> +               N_("scalar diagnose [<enlistment>]"),
> +               NULL
> +       };
> +       struct strbuf tmp_dir =3D STRBUF_INIT;
> +       time_t now =3D time(NULL);
> +       struct tm tm;
> +       struct strbuf path =3D STRBUF_INIT, buf =3D STRBUF_INIT;
> +       int res =3D 0;
> +
> +       argc =3D parse_options(argc, argv, NULL, options,
> +                            usage, 0);
> +
> +       setup_enlistment_directory(argc, argv, usage, options, &buf);
> +
> +       strbuf_addstr(&buf, "/.scalarDiagnostics/scalar_");
> +       strbuf_addftime(&buf, "%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0,=
 0);
> +       if (run_git("init", "-q", "-b", "dummy", "--bare", buf.buf, NULL)=
) {
> +               res =3D error(_("could not initialize temporary repositor=
y: %s"),
> +                           buf.buf);
> +               goto diagnose_cleanup;
> +       }
> +       strbuf_realpath(&tmp_dir, buf.buf, 1);
> +
> +       strbuf_reset(&buf);
> +       strbuf_addf(&buf, "Collecting diagnostic info into temp folder %s=
\n\n",
> +                   tmp_dir.buf);
> +
> +       get_version_info(&buf, 1);
> +
> +       strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktr=
ee);
> +       fwrite(buf.buf, buf.len, 1, stdout);
> +
> +       if ((res =3D stage(tmp_dir.buf, &buf, "diagnostics.log")))
> +               goto diagnose_cleanup;
> +
> +       if ((res =3D stage_directory(tmp_dir.buf, ".git", 0)) ||
> +           (res =3D stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
> +           (res =3D stage_directory(tmp_dir.buf, ".git/info", 0)) ||
> +           (res =3D stage_directory(tmp_dir.buf, ".git/logs", 1)) ||
> +           (res =3D stage_directory(tmp_dir.buf, ".git/objects/info", 0)=
))
> +               goto diagnose_cleanup;
> +
> +       res =3D index_to_zip(tmp_dir.buf);
> +
> +       if (!res)
> +               res =3D remove_dir_recursively(&tmp_dir, 0);
> +
> +       if (!res)
> +               printf("\n"
> +                      "Diagnostics complete.\n"
> +                      "All of the gathered info is captured in '%s.zip'\=
n",
> +                      tmp_dir.buf);
> +
> +diagnose_cleanup:
> +       strbuf_release(&tmp_dir);
> +       strbuf_release(&path);
> +       strbuf_release(&buf);
> +
> +       return res;
> +}
> +
>  static int cmd_list(int argc, const char **argv)
>  {
>         if (argc !=3D 1)
> @@ -800,6 +969,7 @@ static struct {
>         { "reconfigure", cmd_reconfigure },
>         { "delete", cmd_delete },
>         { "version", cmd_version },
> +       { "diagnose", cmd_diagnose },
>         { NULL, NULL},
>  };
>
> diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
> index f416d637289..22583fe046e 100644
> --- a/contrib/scalar/scalar.txt
> +++ b/contrib/scalar/scalar.txt
> @@ -14,6 +14,7 @@ scalar register [<enlistment>]
>  scalar unregister [<enlistment>]
>  scalar run ( all | config | commit-graph | fetch | loose-objects | pack-=
files ) [<enlistment>]
>  scalar reconfigure [ --all | <enlistment> ]
> +scalar diagnose [<enlistment>]
>  scalar delete <enlistment>
>
>  DESCRIPTION
> @@ -129,6 +130,17 @@ reconfigure the enlistment.
>  With the `--all` option, all enlistments currently registered with Scala=
r
>  will be reconfigured. Use this option after each Scalar upgrade.
>
> +Diagnose
> +~~~~~~~~
> +
> +diagnose [<enlistment>]::
> +    When reporting issues with Scalar, it is often helpful to provide th=
e
> +    information gathered by this command, including logs and certain
> +    statistics describing the data shape of the current enlistment.
> ++
> +The output of this command is a `.zip` file that is written into
> +a directory adjacent to the worktree in the `src` directory.
> +
>  Delete
>  ~~~~~~
>
> diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-sc=
alar.sh
> index 2e1502ad45e..ecd06e207c2 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -65,6 +65,19 @@ test_expect_success 'scalar clone' '
>         )
>  '
>
> +SQ=3D"'"
> +test_expect_success UNZIP 'scalar diagnose' '
> +       scalar diagnose cloned >out &&
> +       sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
> +       zip_path=3D$(cat zip_path) &&
> +       test -n "$zip_path" &&
> +       unzip -v "$zip_path" &&
> +       folder=3D${zip_path%.zip} &&
> +       test_path_is_missing "$folder" &&
> +       unzip -p "$zip_path" diagnostics.log >out &&
> +       test_file_not_empty out
> +'
> +
>  test_expect_success 'scalar reconfigure' '
>         git init one/src &&
>         scalar register one &&
> --
> gitgitgadget
>
