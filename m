Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9089C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbiBCSSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiBCSSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:18:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6815AC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:18:30 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id j2so11209674ejk.6
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L9tYILZa2Ui82uFY6A8l9jPG7PSKWYUpk6IocZzLmZk=;
        b=TjK6bnwhZZnYTp1rK7JNdZK5kEQ6wqGGXs3vu4KdDcT06CWGYMpzhf9CoAwldzLg3K
         4WUCFtw0ZeWYvIyxeLU1HQQh2PZuyz2CiwghsIY206QFBCME/Ly4wRcJLH0D31YiDXTf
         h6Et6FHGDQ2V1EtJd+E53cfSyjGFPic7Yt55vLd/kUKOE1IvnbnzxmEembusPh0T/Q5t
         v31VwFtfLZ09v6VjwBhNiXCEXVpgwvu0xnbSqr+ba7QtmJS2pbYlbyZ1e1puzj5GR7sR
         ADFTBHafxkZYMLfY3MQb8G43BYy0jsrxjyV2TDg7W5q4UComRzngaiRf02Kpti/8QUOR
         Gsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L9tYILZa2Ui82uFY6A8l9jPG7PSKWYUpk6IocZzLmZk=;
        b=vR4A0J14W4kBssq/X18HqMHXoNVsO5nog3Ecy7JcFn/IVIvyTjQ0Z0/b39WpFyoAvx
         AnkW7mkd4GHgso9imtp3bMRBc/85mqrfTU5TRlVi5g4grNjJJd6dWuOaUHH89K6TBTYm
         ze0H89lox25ONFvoGDkjbAe17YJStWgeIhiLlXfKwCkp5SIiZBc53yCDbqvX08pBfjy9
         rzKCFW7YRgxVxZuI22Ag25QIlAYXGYhwcOKNXU7LZWPm9BgHADRq/nGlAd5xuFB1qeII
         BQ6Lyjj3LJe9bRDaoHj3d26Tq9P80U7MHXpkMZfASzbLbnbTuBvoqB9C/thwy0znMpOz
         ZMXA==
X-Gm-Message-State: AOAM531/qbSmA6uPwZjFkMfkoXdR+0rC3lL8z9SW3vqDoGAgo/1pd+Kf
        U6DmyUFGS1A+k1aiqbAT3abtPPVSrRu2+2NlvMc=
X-Google-Smtp-Source: ABdhPJxZq1ZswAZHv50ouwjmZoUmgux4957I/TTrzp9gAtYZk84Ltv4LktW8ZP7Ne9D9S6tGrOQ8gKmlJO7SGyyJf3s=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr24856484ejc.328.1643912308628;
 Thu, 03 Feb 2022 10:18:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com> <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
 <CABPp-BHZYUmWBvzgFkRYddnUJQWrtah=JJ-yaW9Km8+qWcCfUw@mail.gmail.com>
 <220203.86wnic5lba.gmgdl@evledraar.gmail.com> <CABPp-BF8VoQ7F7yvfzrpQEZwErxHzb9x8M_R9PrrM7vWzw=wSw@mail.gmail.com>
 <220203.86bkzn6ea8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86bkzn6ea8.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 10:18:16 -0800
Message-ID: <CABPp-BEvQWbcwZw68P6d9Ud+AqrEnTrjXb4Tne5DMaCtfu_Tsg@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial shell
 for real merge function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 9:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Feb 03 2022, Elijah Newren wrote:
>
[...]
> > But that makes --write-tree a mandatory argument when trying to use
> > that mode, right?  If so, that is not a simpler way to do what I'm
> > trying to do at all; it breaks my intended usage.
> >
> > --write-tree is a documentation-only construct that users should never
> > have to pass.
> >
> > Also, what happens if we remove the --trivial-merge flag and its whole
> > mode after a sufficient deprecation period?  Would the --write-tree
> > parameter remain required in your model to select the only existing
> > mode, simply due to us having gone through a transition period?
>
> You can have your cake and eat it too by running parse_optionss() N
> number of times. Although perhaps in this case the end result isn't
> worth it.
>
> I was hoping this could be a simpler case of a subcommand dispatch, and
> perhaps it can still be generalized to that.
>
> If the "trivial" mode never takes options and always 3 argv elements, we
> could just run parse_options() for it with no options, after checking
> that we have 3 arguments, and none start with '-'.
>
> But the below is a generalization of this I tried out just now, it
> passes all your tests, and means that whenever you add new options you
> don't need to keep saying "no, not with the trivial mode" for each one.
>
> Basically we run parse_options() once with the full set of options, and
> save away argc/argv (note the lack of strvec_clear() there, that's a
> TODO memory leak).
>
> Then we've got a o.mode, which along with argc is the *only* thing we
> pay attention to at that point.
>
> Then we dispatch to the "trivial" or "write" functions, which do
> parse_options() again, this time with only their options.
>
> It means that e.g. this now works as expected:
>
>     ./git merge-tree --trivial-merge -z origin/{master,next,seen}
>     error: unknown switch `z'
>     usage: git merge-tree [--trivial-merge] <base-tree> <branch1> <branch=
2>
>
>         --trivial-merge       do a trivial merge only
>
> I.e. we error out, with your verison we'll just ignore the -z.
>
> Your "--trivial-merge is incompatible with all other options" doesn't
> work as you expect, and is buggy whether you want to go this route or
> not, as the added tests show.
>
> Basically it does nothing at all. Because if you add --foo we'll die
> before we get there, parse_options() will die for us.
>
> But if you do --trivial-merge -z your argc/argv will be trimmed, because
> -z is a known option. So your check is doing nothing.

Gah, good catch.  How did I get the check reversed??  I know I tested
it at one point.  Anyway, this fixes it:

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 58c0ddc5a3..fb25e3d10d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -505,19 +505,22 @@ int cmd_merge_tree(int argc, const char **argv, const=
 cha
r *prefix)
        };

        /* Parse arguments */
-       original_argc =3D argc;
+       original_argc =3D argc - 1; /* ignoring program name, i.e. argv[0] =
*/
        argc =3D parse_options(argc, argv, prefix, mt_options,
                             merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION=
);
        if (o.mode) {
                expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3);
                if (argc !=3D expected_remaining_argc)
                        usage_with_options(merge_tree_usage, mt_options);
+               if (o.mode =3D=3D 't')
+                       /* Removal of `--trivial-merge` is expected */
+                       original_argc_options--;
        } else {
                if (argc < 2 || argc > 3)
                        usage_with_options(merge_tree_usage, mt_options);
                o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
        }
-       if (o.mode =3D=3D 't' && original_argc < argc)
+       if (o.mode =3D=3D 't' && argc < original_argc)
                die(_("--trivial-merge is incompatible with all other
options"));

        /* Do the relevant type of merge */


and results in this error being shown when any other option is listed
with --trivial-merge.

> So, here it is in all its glory :) A bit nasty for sure, but IMO
> preferrable to an ever expanding list of "X isn't compatible with A".

Agreed...on both counts.  :-)

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 58c0ddc5a32..1d47912816d 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -12,6 +12,7 @@
>  #include "exec-cmd.h"
>  #include "merge-blobs.h"
>  #include "quote.h"
> +#include "strvec.h"
>
>  static int line_termination =3D '\n';
>
> @@ -371,13 +372,66 @@ static void *get_tree_descriptor(struct repository =
*r,
>         return buf;
>  }
>
> -static int trivial_merge(const char *base,
> -                        const char *branch1,
> -                        const char *branch2)
> +struct merge_tree_options {
> +       int mode;
> +       int allow_unrelated_histories;
> +       int show_messages;
> +       int exclude_modes_oids_stages;
> +};
> +
> +#define BUILTIN_MERGE_TREE_USAGE_WRITE \
> +               N_("git merge-tree [--write-tree] [<options>] <branch1> <=
branch2>")
> +#define BUILTIN_MERGE_TREE_USAGE_TRIVIAL \
> +               N_("git merge-tree [--trivial-merge] <base-tree> <branch1=
> <branch2>")
> +
> +#define BUILTIN_MERGE_TREE_OPT_CMDMODE_TRIVIAL \
> +               OPT_CMDMODE(0, "trivial-merge", &o.mode, \
> +                           N_("do a trivial merge only"), 't')
> +
> +#define BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE \
> +               OPT_CMDMODE(0, "write-tree", &o.mode, \
> +                           N_("do a real merge instead of a trivial merg=
e"), \
> +                           'w')
> +
> +#define BUILTIN_MERGE_TREE_OPT_WRITE \
> +               BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE, \
> +               OPT_BOOL(0, "messages", &o.show_messages, \
> +                        N_("also show informational/conflict messages"))=
, \
> +               OPT_SET_INT('z', NULL, &line_termination, \
> +                           N_("separate paths with the NUL character"), =
'\0'), \
> +               OPT_BOOL_F('l', "exclude-modes-oids-stages", \
> +                          &o.exclude_modes_oids_stages, \
> +                          N_("list conflicted files without modes/oids/s=
tages"), \
> +                          PARSE_OPT_NONEG), \
> +               OPT_BOOL_F(0, "allow-unrelated-histories", \
> +                          &o.allow_unrelated_histories, \
> +                          N_("allow merging unrelated histories"), \
> +                          PARSE_OPT_NONEG)
> +
> +static int trivial_merge(int argc, const char **argv, const char *prefix=
)
>  {
>         struct repository *r =3D the_repository;
>         struct tree_desc t[3];
>         void *buf1, *buf2, *buf3;
> +       struct merge_tree_options o =3D { 0 };
> +       const char * const usage[] =3D {
> +               BUILTIN_MERGE_TREE_USAGE_TRIVIAL,
> +               NULL,
> +       };
> +       struct option options[] =3D {
> +               BUILTIN_MERGE_TREE_OPT_CMDMODE_TRIVIAL,
> +               OPT_END()
> +       };
> +       const char *base, *branch1, *branch2;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage,
> +                            PARSE_OPT_STOP_AT_NON_OPTION);
> +       if (argc !=3D 3)
> +               BUG("should have ensured remaining argc =3D=3D 3 already!=
 Got %d", argc);
> +
> +       base =3D argv[0];
> +       branch1 =3D argv[1];
> +       branch2 =3D argv[2];;
>
>         buf1 =3D get_tree_descriptor(r, t+0, base);
>         buf2 =3D get_tree_descriptor(r, t+1, branch1);
> @@ -391,24 +445,34 @@ static int trivial_merge(const char *base,
>         return 0;
>  }
>
> -struct merge_tree_options {
> -       int mode;
> -       int allow_unrelated_histories;
> -       int show_messages;
> -       int exclude_modes_oids_stages;
> -};
> -
> -static int real_merge(struct merge_tree_options *o,
> -                     const char *branch1, const char *branch2,
> -                     const char *prefix)
> +static int real_merge(int argc, const char **argv, const char *prefix)
>  {
>         struct commit *parent1, *parent2;
>         struct commit_list *common;
>         struct commit_list *merge_bases =3D NULL;
>         struct commit_list *j;
> +       struct merge_tree_options o =3D { .show_messages =3D 1 };
>         struct merge_options opt;
>         struct merge_result result =3D { 0 };
>
> +       const char * const usage[] =3D {
> +               BUILTIN_MERGE_TREE_USAGE_WRITE,
> +               NULL,
> +       };
> +       struct option options[] =3D {
> +               BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE,
> +               BUILTIN_MERGE_TREE_OPT_WRITE,
> +               OPT_END()
> +       };
> +       const char *branch1, *branch2;
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage,
> +                            PARSE_OPT_STOP_AT_NON_OPTION);
> +       if (argc !=3D 2)
> +               BUG("should have ensured remaining argc =3D=3D 2 already!=
 Got %d", argc);
> +       branch1 =3D argv[0];
> +       branch2 =3D argv[1];
> +
>         parent1 =3D get_merge_parent(branch1);
>         if (!parent1)
>                 help_unknown_ref(branch1, "merge-tree",
> @@ -431,7 +495,7 @@ static int real_merge(struct merge_tree_options *o,
>          * merge_incore_recursive in merge-ort.h
>          */
>         common =3D get_merge_bases(parent1, parent2);
> -       if (!common && !o->allow_unrelated_histories)
> +       if (!common && !o.allow_unrelated_histories)
>                 die(_("refusing to merge unrelated histories"));
>         for (j =3D common; j; j =3D j->next)
>                 commit_list_insert(j->item, &merge_bases);
> @@ -440,8 +504,8 @@ static int real_merge(struct merge_tree_options *o,
>         if (result.clean < 0)
>                 die(_("failure to merge"));
>
> -       if (o->show_messages =3D=3D -1)
> -               o->show_messages =3D !result.clean;
> +       if (o.show_messages =3D=3D -1)
> +               o.show_messages =3D !result.clean;
>
>         puts(oid_to_hex(&result.tree->object.oid));
>         if (!result.clean) {
> @@ -453,7 +517,7 @@ static int real_merge(struct merge_tree_options *o,
>                 for (i =3D 0; i < conflicted_files.nr; i++) {
>                         const char *name =3D conflicted_files.items[i].st=
ring;
>                         struct stage_info *c =3D conflicted_files.items[i=
].util;
> -                       if (!o->exclude_modes_oids_stages)
> +                       if (!o.exclude_modes_oids_stages)
>                                 printf("%06o %s %d\t",
>                                        c->mode, oid_to_hex(&c->oid), c->s=
tage);
>                         else if (last && !strcmp(last, name))
> @@ -464,7 +528,7 @@ static int real_merge(struct merge_tree_options *o,
>                 }
>                 string_list_clear(&conflicted_files, 1);
>         }
> -       if (o->show_messages) {
> +       if (o.show_messages) {
>                 putchar(line_termination);
>                 merge_display_update_messages(&opt, &result, stdout);
>         }
> @@ -474,40 +538,32 @@ static int real_merge(struct merge_tree_options *o,
>
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -       struct merge_tree_options o =3D { .show_messages =3D -1 };
> +       struct merge_tree_options o;
>         int expected_remaining_argc;
> -       int original_argc;
> -
> +       int original_argc =3D argc;
> +       struct strvec original_args =3D STRVEC_INIT;
>         const char * const merge_tree_usage[] =3D {
> -               N_("git merge-tree [--write-tree] [<options>] <branch1> <=
branch2>"),
> -               N_("git merge-tree [--trivial-merge] <base-tree> <branch1=
> <branch2>"),
> +               BUILTIN_MERGE_TREE_USAGE_WRITE,
> +               BUILTIN_MERGE_TREE_USAGE_TRIVIAL,
>                 NULL
>         };
>         struct option mt_options[] =3D {
> -               OPT_CMDMODE(0, "write-tree", &o.mode,
> -                           N_("do a real merge instead of a trivial merg=
e"),
> -                           'w'),
> -               OPT_CMDMODE(0, "trivial-merge", &o.mode,
> -                           N_("do a trivial merge only"), 't'),
> -               OPT_BOOL(0, "messages", &o.show_messages,
> -                        N_("also show informational/conflict messages"))=
,
> -               OPT_SET_INT('z', NULL, &line_termination,
> -                           N_("separate paths with the NUL character"), =
'\0'),
> -               OPT_BOOL_F('l', "exclude-modes-oids-stages",
> -                          &o.exclude_modes_oids_stages,
> -                          N_("list conflicted files without modes/oids/s=
tages"),
> -                          PARSE_OPT_NONEG),
> -               OPT_BOOL_F(0, "allow-unrelated-histories",
> -                          &o.allow_unrelated_histories,
> -                          N_("allow merging unrelated histories"),
> -                          PARSE_OPT_NONEG),
> +               BUILTIN_MERGE_TREE_OPT_CMDMODE_TRIVIAL,
> +               BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE,
> +               BUILTIN_MERGE_TREE_OPT_WRITE,
>                 OPT_END()
>         };
>
> +       /* We only care about deciding "o.mode" here */
> +       o.mode =3D 0;
> +       /*
> +        * We need our original argv, and
> +        * PARSE_OPT_KEEP_{ARGV0,UNKNOWN} would do the wrong thing
> +        */
> +       strvec_pushv(&original_args, argv);
>         /* Parse arguments */
> -       original_argc =3D argc;
>         argc =3D parse_options(argc, argv, prefix, mt_options,
> -                            merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTI=
ON);
> +                            merge_tree_usage, 0);
>         if (o.mode) {
>                 expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3);
>                 if (argc !=3D expected_remaining_argc)
> @@ -517,12 +573,10 @@ int cmd_merge_tree(int argc, const char **argv, con=
st char *prefix)
>                         usage_with_options(merge_tree_usage, mt_options);
>                 o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
>         }
> -       if (o.mode =3D=3D 't' && original_argc < argc)
> -               die(_("--trivial-merge is incompatible with all other opt=
ions"));
>
>         /* Do the relevant type of merge */
>         if (o.mode =3D=3D 'w')
> -               return real_merge(&o, argv[0], argv[1], prefix);
> +               return real_merge(original_argc, original_args.v, prefix)=
;
>         else
> -               return trivial_merge(argv[0], argv[1], argv[2]);
> +               return trivial_merge(original_argc, original_args.v, pref=
ix);
>  }


Yeah, that's waaay more complex than my code which basically just
needs 6 lines to check the incompatibility; the basic patch for that
part (going back to before this patch we're commenting on) was just:

 +    original_argc =3D argc - 1;  /* ignore program name, i.e. argv[0] */
...
 +        if (o.mode =3D=3D 't')
 +            /* Removal of `--trivial-merge` is expected */
 +            original_argc_options--;
...
 +    if (o.mode =3D=3D 't' && argc < original_argc)
 +        die(_("--trivial-merge is incompatible with all other options"));


> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> index 4de089d976d..749bdb6862d 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -92,6 +92,18 @@ test_expect_success 'Barf on too many arguments' '
>         grep "^usage: git merge-tree" expect
>  '
>
> +for opt in $(git merge-tree --git-completion-helper-all)
> +do
> +       if test $opt =3D "--trivial-merge" || test $opt =3D "--write-tree=
"
> +       then
> +               continue
> +       fi
> +
> +       test_expect_success "usage: --trivial-merge is incompatible with =
$opt" '
> +               test_expect_code 129 git merge-tree --trivial-merge $opt =
side1 side2 side3
> +       '
> +done

Yep, I was clearly missing an important testcase.  Thanks for
providing one and for pointing out the error in my patch!  Very cool.
