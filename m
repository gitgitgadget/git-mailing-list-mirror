Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F095C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 04:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACB520658
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 04:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqGXi6NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgCQEpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:45:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36861 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQEpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 00:45:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so20421160oib.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 21:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wuq2paxvWL4xv+P4477K6C1bfyh2yI63KvdRtSg968k=;
        b=WqGXi6NFFpng8hoP2W/Rn3U1dOiqEA5abMAzncOQZOH/j7Qk8PLwmZL7XTEbIGMMYz
         AfHtZyZofKEa09baAAtMb+lzY04/o5r6/KGEWYrd/jeMNzg06S/Mf0Gu3T/995ieQLgW
         qobzdy2RytMwo993z8G2pWQVCx/q5R5Ko5I1x3fSFfw4lZ9iZf0qG6nfpvuepNISxYgE
         H9OrEGWRT0XQpQklFycr14+DtplnuCYj+pxgl2Nr0SI1M9U015sDkHtKjqxJ8Fpzyv3U
         hduSMMZFxPExcYvEP3QVsojo61phNRhf3BrJYLuW5bp+tq4Fl8pHUre+CGm7gV+WeVMF
         ZkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wuq2paxvWL4xv+P4477K6C1bfyh2yI63KvdRtSg968k=;
        b=qvP24PML777wQwucnt3Hs1UUrSkTYUP8ibqGVHAPLP1cxiHHxq7/IU3rM4FkK14Non
         ho9qW4W1tmIhbepvYAbuRVAvxhoal3Z9IOG4b1Fnk5T6fpDx2ncqbiIfRf1JqM6MQoEw
         oo+MUoXjqMFHBL6AkrzvWjQCLf2XiepHXTYqB+8L6ZJblSW6cNwjOw6X8wyxcWvyqrR4
         c2PxNPRZlNBRa27E/r6rzh9vHPIbK828VxJTMxFfKJLesHhQcc0/Ltc8tI3YDHddiGcj
         5yTB10zwekBJJgWZTc86T2LVImKVu/bwwLbBXhsoY+5yKKlrhnyHeBdv+Jh8dYcpzGyV
         tVtA==
X-Gm-Message-State: ANhLgQ3rMx4iHBO7Rt3qOufyAiaRKUU+SuOxB3bP+90kTOBSD0pt9fLu
        cKqB78MtXB3Ovpt4JoAaEQphWfu2u2mregAFTWw=
X-Google-Smtp-Source: ADFU+vv8PbAemDxNPp4KqzYqo0JARVN3Td7kXiMs8Jk5wZHGTE5hEbeUFNInD/VMEt6jXVuLkjdFt98jxEyKhFmccbU=
X-Received: by 2002:a54:4416:: with SMTP id k22mr2225859oiw.167.1584420321522;
 Mon, 16 Mar 2020 21:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com> <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com> <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <20200312175548.GC120942@google.com> <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
 <20200312184621.GD120942@google.com> <CABPp-BHSAbJzWEsPSTM5Q6MPdmu4VSuOx-=6-MJkHUovg3_1=g@mail.gmail.com>
 <20200317025808.GB31380@google.com>
In-Reply-To: <20200317025808.GB31380@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Mar 2020 21:45:10 -0700
Message-ID: <CABPp-BGvatgaTkorJEErvYbVvci2b5AQgCH6Q0z81426tKZ04A@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, Mar 16, 2020 at 7:58 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Elijah Newren wrote:
> > On Thu, Mar 12, 2020 at 11:46 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> Sorry for the lack of clarity.  I mean allowing
> >>
> >>         [rebase]
> >>                 backend = am
> >>                 backend = apply
> >>                 backend = futuristic
> >>
> >> with behavior
> >>
> >> - on "git" that understands am but not apply or futuristic, use the am
> >>   backend
> >> - on "git" that understands apply but not am or futuristic, use the
> >>   apply backend
> >> - on "git" that understands apply and futuristic, use the futuristic
> >>   backend
> >>
> >> That way, a single config file is usable on all three versions of Git.
> >
> > Ah, gotcha, that makes sense though we'd need to make the thing
> > multi-valued which is a bit late for 2.26.  But we could at least
> > extend the logic in that way for 2.27.
>
> Here's a patch implementing that.  I'm not convinced it's worth the
> complexity, mostly because I'm not convinced that rebase is going to
> have to select between additional new backends in the future.  But if
> you think it will, then I think this would be a reasonable thing to do
> (maybe even without the documentation part of the patch).
>
> Thoughts?

Thanks for investigating what's involved.  If there will be new rebase
backends, then this does look like nice future proofing to me.  As for
whether there will be...

Personally, I would rather decrease the number of backends than
increase, and if it was up to just me, I'd like to drive the number of
backends to one and then keep it there.  But it feels hard to know for
sure.

> Thanks,
> Jonathan
>
> -- >8 --
> Subject: rebase: allow specifying unrecognized rebase.backend with a fallback
>
> In 8295ed690bf (rebase: make the backend configurable via config
> setting, 2020-02-15), Git learned a new rebase.backend setting that
> can be used to specify which implementation should be used for
> non-interactive rebases: "am" (now called "apply"), which uses "git
> am", or "merge", which uses the three-way merge machinery.
>
> Most likely those are the only two backends that rebase will ever need
> to learn, so this level of configurability would be sufficient.  At
> some point the "apply" backend would be retired, and the setting would
> be removed altogether.
>
> Suppose, though, that rebase learns another backend --- e.g. "faster".
> In that case, a user might set configuration to request it:
>
>         [rebase]
>                 backend = faster
>
> If their configuration is shared between multiple versions of Git
> (think "home directory on NFS shared between machines"), this would
> produce errors when read by older versions of Git:
>
>         fatal: Unknown rebase backend: faster
>
> On the other hand, if we ignore unrecognized rebase backend settings,
> then Git would fail to realize that
>
>         [rebase]
>                 backend = appply
>
> is a typo, producing a confusing user experience.  Let's do something
> in between: when a rebase backend setting is unrecognized, fall back
> to the last earlier recognized value, but if no value was recognized,
> print an error message allowing the user to catch their typo.
>
> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/config/rebase.txt |  5 ++
>  builtin/rebase.c                | 52 +++++++++++++++---
>  t/t3435-rebase-backend.sh       | 97 +++++++++++++++++++++++++++++++++
>  3 files changed, 146 insertions(+), 8 deletions(-)
>  create mode 100755 t/t3435-rebase-backend.sh
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 7f7a07d22f8..c92adbdcc69 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -10,6 +10,11 @@ rebase.backend::
>         'apply' or 'merge'.  In the future, if the merge backend gains
>         all remaining capabilities of the apply backend, this setting
>         may become unused.
> ++
> +If set multiple times, the last value corresponding to a recognized
> +backend is used. This is for forward compatibility, as it allows
> +specifying a rebase backend that Git does not know about yet along
> +with a backend known today as a fallback.
>
>  rebase.stat::
>         Whether to show a diffstat of what changed upstream since the last
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ffa467aad52..5b0fab9741f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -56,10 +56,18 @@ enum empty_type {
>         EMPTY_ASK
>  };
>
> +enum rebase_backend {
> +       BACKEND_UNSPECIFIED = 0,
> +       BACKEND_UNRECOGNIZED,
> +       BACKEND_APPLY,
> +       BACKEND_MERGE,
> +};
> +
>  struct rebase_options {
>         enum rebase_type type;
>         enum empty_type empty;
> -       const char *default_backend;
> +       enum rebase_backend configured_backend;
> +       const char *last_specified_backend;
>         const char *state_dir;
>         struct commit *upstream;
>         const char *upstream_name;
> @@ -100,7 +108,6 @@ struct rebase_options {
>  #define REBASE_OPTIONS_INIT {                          \
>                 .type = REBASE_UNSPECIFIED,             \
>                 .empty = EMPTY_UNSPECIFIED,             \
> -               .default_backend = "merge",             \
>                 .flags = REBASE_NO_QUIET,               \
>                 .git_am_opts = ARGV_ARRAY_INIT,         \
>                 .git_format_patch_opt = STRBUF_INIT     \
> @@ -1224,6 +1231,15 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
>         return status ? -1 : 0;
>  }
>
> +static enum rebase_backend parse_rebase_backend(const char *value)
> +{
> +       if (!strcmp(value, "apply"))
> +               return BACKEND_APPLY;
> +       if (!strcmp(value, "merge"))
> +               return BACKEND_MERGE;
> +       return BACKEND_UNRECOGNIZED;
> +}
> +
>  static int rebase_config(const char *var, const char *value, void *data)
>  {
>         struct rebase_options *opts = data;
> @@ -1264,7 +1280,18 @@ static int rebase_config(const char *var, const char *value, void *data)
>         }
>
>         if (!strcmp(var, "rebase.backend")) {
> -               return git_config_string(&opts->default_backend, var, value);
> +               enum rebase_backend val;
> +               if (!value)
> +                       return config_error_nonbool(var);
> +               val = parse_rebase_backend(value);
> +               if (opts->configured_backend == BACKEND_UNSPECIFIED)
> +                       opts->configured_backend = val;
> +               else if (val == BACKEND_UNRECOGNIZED)
> +                       ; /* Unrecognized rebase backend. Ignore it. */
> +               else
> +                       opts->configured_backend = val;
> +               opts->last_specified_backend = value;
> +               return 0;
>         }
>
>         return git_default_config(var, value, data);
> @@ -1903,14 +1930,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 }
>         }
>
> +       if (options.configured_backend == BACKEND_UNRECOGNIZED)
> +               die(_("unknown rebase backend: %s"),
> +                   options.last_specified_backend);
> +
>         if (options.type == REBASE_UNSPECIFIED) {
> -               if (!strcmp(options.default_backend, "merge"))
> +               switch (options.configured_backend) {
> +               case BACKEND_UNSPECIFIED:
> +               case BACKEND_MERGE:
>                         imply_merge(&options, "--merge");
> -               else if (!strcmp(options.default_backend, "apply"))
> +                       break;
> +               case BACKEND_APPLY:
>                         options.type = REBASE_APPLY;
> -               else
> -                       die(_("Unknown rebase backend: %s"),
> -                           options.default_backend);
> +                       break;
> +               default:
> +                       BUG("unexpected backend %d",
> +                           (int) options.configured_backend);
> +               }
>         }
>
>         switch (options.type) {
> diff --git a/t/t3435-rebase-backend.sh b/t/t3435-rebase-backend.sh
> new file mode 100755
> index 00000000000..8b9ba6f1894
> --- /dev/null
> +++ b/t/t3435-rebase-backend.sh
> @@ -0,0 +1,97 @@
> +#!/bin/sh
> +
> +test_description='rebase.backend tests
> +
> +Checks of config parsing for the [rebase] backend setting.  We detect
> +which backend was used by checking which directory was created to hold
> +state.'
> +
> +. ./test-lib.sh
> +
> +# usage: test_backend_choice <expectation> <command>
> +#
> +# Tests that the chosen backend for rebase command <command>
> +# is <expectation> ("merge" or "apply").
> +test_backend_choice () {
> +       expect=$1 &&
> +       shift &&
> +
> +       test_must_fail git "$@" master topic &&
> +       case $expect in
> +       apply)
> +               test_path_is_dir .git/rebase-apply &&
> +               test_path_is_missing .git/rebase-merge
> +               ;;
> +       merge)
> +               test_path_is_dir .git/rebase-merge &&
> +               test_path_is_missing .git/rebase-apply
> +               ;;
> +       *)
> +               error "unrecognized expectation $expect"
> +       esac
> +}
> +
> +test_expect_success 'setup' '
> +       test_commit base &&
> +       test_commit sidea conflict.txt myway &&
> +       git checkout -b topic base &&
> +       test_commit sideb conflict.txt thehighway
> +'
> +
> +test_expect_success '--apply uses apply backend' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice apply rebase --apply
> +'
> +
> +test_expect_success '--merge uses merge backend' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice merge rebase --merge
> +'
> +
> +test_expect_success 'default to merge backend' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice merge rebase
> +'
> +
> +test_expect_success 'config overrides default' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice apply -c rebase.backend=apply rebase
> +'
> +
> +test_expect_success 'option overrides config' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice merge -c rebase.backend=apply rebase --merge
> +'
> +
> +test_expect_success 'last config value wins' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice merge \
> +               -c rebase.backend=apply \
> +               -c rebase.backend=merge \
> +               rebase
> +'
> +
> +test_expect_success 'last config value wins' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice merge \
> +               -c rebase.backend=apply \
> +               -c rebase.backend=merge \
> +               rebase
> +'

Um, copy-and-paste-and-forget-to-edit?  This test is identical to the
one above it and thus is not useful; I think you meant to flip the
order of config options and flip the result (and maybe give a slightly
different test name to it)?

> +
> +test_expect_success 'misspelled backend without fallback is diagnosed' '
> +       test_must_fail \
> +               git -c rebase.backend=appply rebase master topic 2>message &&
> +       test_i18ngrep "unknown rebase backend" message &&
> +       grep appply message
> +'
> +
> +test_expect_success 'forward compatibility by skipping unrecognized values' '
> +       test_when_finished "git rebase --abort" &&
> +       test_backend_choice apply \
> +               -c rebase.backend=apply \
> +               -c rebase.backend=futuristic \
> +               rebase
> +'
> +
> +test_done

Didn't spot anything other than that one test issue in looking over things.
