From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 4 May 2016 10:58:26 -0700
Message-ID: <CAGZ79kZUbhhjwV83_FQKfJR45K6QsZUN_-HJVJmefZUbJEDYYQ@mail.gmail.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 19:58:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay14R-0000wv-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 19:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbcEDR6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 13:58:35 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34867 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbcEDR6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 13:58:32 -0400
Received: by mail-io0-f182.google.com with SMTP id d62so61936862iof.2
        for <git@vger.kernel.org>; Wed, 04 May 2016 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=L3nFnTYCDdTxALPV1v07gxQTSnWg/KqUeph8pCLe1UE=;
        b=cgACaO19BQKwaCADvmH0MMev2M/aa7rUOivOXYPJGVBhJiL/ROQIowPpTmSvHv1tzh
         u8F68y2CccKye8HE8P6dmSn2fcTsyyQlGcg6zL5kvkP6EsyYfi9cGV3Cy18i0zIBV8lO
         +LbFk9XuLvYfUO6IyIBnyQ5+3txf8gmekQG8iJz7ZNrOaCk0ANCfqkEtiBtYTAeuWgPQ
         4vWyXPaCZcc+cX9/bbAbtBxk+Idsd7VwrQxVBr6Se5pp+yTwvOU5o6fDIRdAPuvt5r6b
         B4jnzlnLmxAt7IZ1gV74KOloRvcJDCAT9GQiucQczm4851SBsWjsiCH0bFNNiNXYb765
         PV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=L3nFnTYCDdTxALPV1v07gxQTSnWg/KqUeph8pCLe1UE=;
        b=bTxBwMshvlXjyCIMzz9WkSIIgZNoFeRebr3N0eX2HQm8eXxrTWBqbs6rqaFWAzy99I
         vlwQCayxsSX7qZDDTuUGdXV1AH1QsD63NTIQDgu6QAIULQEtAGYxOSuS0SSAFi/a6WvI
         Ft2qW0AOuqOBLS+zw0+ymD5+gR+MIrVzswoXUu8RVvaBivv+X6JuEycmTH4D7mqP0Yf5
         Cv0+WtD/akigVygoSIKQXLIivLx+m9Ksj1lzyZ3A9+gERo0DLuIYovwr4teuK2sUqloF
         AdHfwa02935l0+JQ73OK8mdLB6lSN1fpAgJrAdx6LhFFgSXVGfEFOHyuxixEgGhFaPTI
         PtEw==
X-Gm-Message-State: AOPr4FVleaP5RXVSYwe+iCGlhDgaijXAbQt8cgT6P3X7V5NS+0NdrhHmZ6P3Gqq/EF1E8btFZDM+EQsdHpPdJglo
X-Received: by 10.107.174.205 with SMTP id n74mr12146360ioo.96.1462384706532;
 Wed, 04 May 2016 10:58:26 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 10:58:26 -0700 (PDT)
In-Reply-To: <20160504080047.GA2436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293557>

On Wed, May 4, 2016 at 1:00 AM, Jeff King <peff@peff.net> wrote:
> [+cc Stefan and Jacob since this is really resuming that earlier thread]
>
> On Wed, May 04, 2016 at 03:45:59AM -0400, Jeff King wrote:
>
>> On Wed, May 04, 2016 at 02:26:18AM -0400, Jeff King wrote:
>>
>> > >   submodule: pass on http.extraheader config settings
>> >
>> > IMHO this should come on top of jk/submodule-config-sanitize-fix (I was
>> > surprised at first that your test worked at all, but that is because it
>> > is using "clone", which is the one code path that works).
>> >
>> > But I think we are waiting on going one of two paths:
>> >
>> >   1. drop sanitizing entirely
>> >
>> >   2. fix sanitizing and add more variables to it
>> >
>> > If we go the route of (2), then we'd want my fix topic and this patch.
>> > And if not, then we don't need any of it (just a patch dropping the
>> > filtering, which AFAIK nobody has written yet).
>>
>> Actually, I think this last bit is not quite true. If we want to go back
>> to "nothing gets passed to submodules", we can drop all of my patches,
>> but I don't think anybody wants to do that.
>>
>> But if we want "everything gets passed to submodules", then we do need
>> something like my patch series, because every use of local_repo_env
>> needs to be come "local_repo_env excluding GIT_CONFIG_PARAMETERS". I
>> don't think we want to simply drop that variable from local_repo_env
>> (which would also mean that it would be propagated to a local
>> git-upload-pack, for example, along with any third-party scripts that
>> use rev-parse --local-env-vars).
>>
>> So I think we'd actually want my series as a preliminary fix, followed
>> by dropping the whitelist entirely on top of that, and then probably
>> simplifying the shell sanitize_submodule_env() on top of that (it would
>> be correct without the whitelist, but you can also trivially implement
>> it without having to call submodule--helper at all).
>
> I think we'd actually do it all in one, and that patch looks something
> like the one below (on top of jk/submodule-config-sanitize-fix).
>
> I don't feel that strongly about going either direction with this, but I
> figure it doesn't hurt to make the patch so we know what the actual
> option looks like.
>
> -- >8 --
> Subject: [PATCH] submodule: stop sanitizing config options
>
> The point of having a whitelist of command-line config
> options to pass to submodules was two-fold:
>
>   1. It prevented obvious nonsense like using core.worktree
>      for multiple repos.
>
>   2. It could prevent surprise when the user did not mean
>      for the options to leak to the submodules (e.g.,
>      http.sslverify=false).
>
> For case 1, the answer is mostly "if it hurts, don't do
> that". For case 2, we can note that any such example has a
> matching inverted surprise (e.g., a user who meant
> http.sslverify=true to apply everywhere, but it didn't).
>
> So this whitelist is probably not giving us any benefit, and
> is already creating a hassle as people propose things to put
> on it. Let's just drop it entirely.

Just to recap:
Before jk/submodule-config-sanitize-fix (jk/submodule-c-credential actually)
we passed nothing down to the commands operating on submodules.

Then we decided to pass on some of it based on a curated list.

Curating the list is too hard, so we pass on everything now, because
it is easy to maintain and easy to explain. And when the user is hurt,
they're holding it wrong?

>
> Note that we still need to keep a special code path for
> "prepare the submodule environment", because we still have
> to take care to pass through $GIT_CONFIG_PARAMETERS (and
> block the rest of the repo-specific environment variables).

So when running `git -c foo=bar command --recurse-submodules`
the `-c` parsing calls git_config_push_parameter, which
exports that string `foo=baz` into the environment variable
GIT_CONFIG_PARAMETERS.

When the submodule command is called, sanitize_submodule_env
just wipes all the Git related configurations except those in
GIT_CONFIG_PARAMETERS as they are set again after
clear_local_git_env wiped it.

I wonder about the implementation detail, if we rather want to introduce
a `git rev-parse --repo-only-local-env-vars` which is
`git rev-parse --local-env-vars` without the GIT_CONFIG_PARAMETERS.
such that clear_local_git_env does the right thing and we don't
have to have 2 functions for it (i.e. clear_local_git_env and
sanitize_submodule_env, which is the newer not as strict version of it)

But as Jeff once put it, rev-parse is already a messy kitchensink,
so adding another option there may also not the right way?

>
> We can do this easily from within the submodule shell
> script, which lets us drop the submodule--helper option
> entirely (and it's OK to do so because as a "--" program, it
> is entirely a private implementation detail).

Yeah that -- program may change any time in no backwards
compatible way.

Do we want to add documentation for the new behavior though?
    Before: pass not -c arguments to submodules
    Now: Pass all the -c arguments to submodules

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/submodule--helper.c  | 17 -----------------
>  git-submodule.sh             |  4 ++--
>  submodule.c                  | 40 +---------------------------------------
>  t/t7412-submodule--helper.sh | 26 --------------------------
>  4 files changed, 3 insertions(+), 84 deletions(-)
>  delete mode 100755 t/t7412-submodule--helper.sh
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index de3ad5b..48cfc48 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -246,22 +246,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> -static int module_sanitize_config(int argc, const char **argv, const char *prefix)
> -{
> -       struct strbuf sanitized_config = STRBUF_INIT;
> -
> -       if (argc > 1)
> -               usage(_("git submodule--helper sanitize-config"));
> -
> -       git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
> -       if (sanitized_config.len)
> -               printf("%s\n", sanitized_config.buf);
> -
> -       strbuf_release(&sanitized_config);
> -
> -       return 0;
> -}
> -
>  struct submodule_update_clone {
>         /* index into 'list', the list of submodules to look into for cloning */
>         int current;
> @@ -522,7 +506,6 @@ static struct cmd_struct commands[] = {
>         {"list", module_list},
>         {"name", module_name},
>         {"clone", module_clone},
> -       {"sanitize-config", module_sanitize_config},
>         {"update-clone", update_clone}
>  };
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3a40d4b..c9d53e1 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -197,9 +197,9 @@ isnumber()
>  # of the settings from GIT_CONFIG_PARAMETERS.
>  sanitize_submodule_env()
>  {
> -       sanitized_config=$(git submodule--helper sanitize-config)
> +       save_config=$GIT_CONFIG_PARAMETERS
>         clear_local_git_env
> -       GIT_CONFIG_PARAMETERS=$sanitized_config
> +       GIT_CONFIG_PARAMETERS=$save_config
>         export GIT_CONFIG_PARAMETERS
>  }
>
> diff --git a/submodule.c b/submodule.c
> index 4e76b98..072ea82 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1131,50 +1131,12 @@ int parallel_submodules(void)
>         return parallel_jobs;
>  }
>
> -/*
> - * Rules to sanitize configuration variables that are Ok to be passed into
> - * submodule operations from the parent project using "-c". Should only
> - * include keys which are both (a) safe and (b) necessary for proper
> - * operation.
> - */
> -static int submodule_config_ok(const char *var)
> -{
> -       if (starts_with(var, "credential."))
> -               return 1;
> -       return 0;
> -}
> -
> -int sanitize_submodule_config(const char *var, const char *value, void *data)
> -{
> -       struct strbuf *out = data;
> -
> -       if (submodule_config_ok(var)) {
> -               if (out->len)
> -                       strbuf_addch(out, ' ');
> -
> -               if (value)
> -                       sq_quotef(out, "%s=%s", var, value);
> -               else
> -                       sq_quote_buf(out, var);
> -       }
> -
> -       return 0;
> -}
> -
>  void prepare_submodule_repo_env(struct argv_array *out)
>  {
>         const char * const *var;
>
>         for (var = local_repo_env; *var; var++) {
> -               if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
> -                       struct strbuf sanitized_config = STRBUF_INIT;
> -                       git_config_from_parameters(sanitize_submodule_config,
> -                                                  &sanitized_config);
> -                       argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
> -                       strbuf_release(&sanitized_config);
> -               } else {
> +               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>                         argv_array_push(out, *var);
> -               }
>         }
> -
>  }
> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> deleted file mode 100755
> index 149d428..0000000
> --- a/t/t7412-submodule--helper.sh
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) 2016 Jacob Keller
> -#
> -
> -test_description='Basic plumbing support of submodule--helper
> -
> -This test verifies the submodule--helper plumbing command used to implement
> -git-submodule.
> -'
> -
> -. ./test-lib.sh
> -
> -test_expect_success 'sanitize-config clears configuration' '
> -       git -c user.name="Some User" submodule--helper sanitize-config >actual &&
> -       test_must_be_empty actual
> -'
> -
> -sq="'"
> -test_expect_success 'sanitize-config keeps credential.helper' '
> -       git -c credential.helper=helper submodule--helper sanitize-config >actual &&
> -       echo "${sq}credential.helper=helper${sq}" >expect &&
> -       test_cmp expect actual
> -'
> -
> -test_done
> --
> 2.8.2.600.g439cdc9
>
