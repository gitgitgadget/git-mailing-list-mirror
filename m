Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6A41F7D2
	for <e@80x24.org>; Sat,  3 Jun 2017 02:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbdFCCNv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 22:13:51 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35813 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFCCNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 22:13:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id 8so14166868pgc.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7D2OSoOxwQVggTyCMR5E20t/vjujjt+YZc5OPhhZ0L4=;
        b=smkJuuMhvwpfEVh+nyBnb/VZaeFHr2XBKn9YHP8ZE3py9CXZs6JTwAmzPPGncqKYO7
         qDlybFw17+zFNXPiyMjVbP/u7bjERSkjE8zts1cPUwHKvEgJ2oH5xV/1jrgxg/Chclbo
         gDan3brSVT+qQA7rZqD4cHJClQWQTV1nTe/g33cgbtAZiG8AFEN+4sZs5eVyzqkvdOKV
         B2UiJh+jJJXgRoulgZiyv01kmuJV22HkGJmWrOTj2THu5NV47FpBeOv0EzcVGSPm+ks+
         1CRPSu9Qv3NI3WjQGcPqEQVMAdN7GBPXx7WUWvFa5uesFl12kJWdZFg29Of+W27CpXJy
         fXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7D2OSoOxwQVggTyCMR5E20t/vjujjt+YZc5OPhhZ0L4=;
        b=kamrmyWdMIgyohdsq3trc+R7VYXFmIqJIECYEahVJU/BeSP2sEOadiZJssaUzHAcbQ
         5LoOq/13hSLZMCRfC6wIDamL0AqGOk1S3CCL/MFz90uh255OytDpakRgAgCH10SaZ9Le
         3kUe3XrklIHTwXIQlmtPRNUEE8asDVo858M96iSu26EnD1nTne0oRCRPxQmY8J8SgJij
         7vYpzKwY7AIaKej1FlUesW7Ml2BeN+FYUohIwg8Zlqgcp7nCownKTedWoeC0K/Yt7C+U
         MrZb2K0vvCVvw5yT02h1PQWBpdRpIdMetYbsfnc0c2oCje3SWOqVkKM+iPrp9suYMmLn
         XC3Q==
X-Gm-Message-State: AODbwcDPrjAY+EWe1lQK/+ZJ94/4odE67MiWJdj0q4t2ywxMaxvMJZT4
        r/UZHaOFg/E7yQHmsvv/BvN8BqwU0/k1FdFSaw==
X-Received: by 10.84.232.198 with SMTP id x6mr2918213plm.245.1496456029518;
 Fri, 02 Jun 2017 19:13:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 2 Jun 2017 19:13:48 -0700 (PDT)
In-Reply-To: <20170602112428.11131-2-pc44800@gmail.com>
References: <48149a4a-c7e3-d70e-7894-369681587372@ramsayjones.plus.com>
 <20170602112428.11131-1-pc44800@gmail.com> <20170602112428.11131-2-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Jun 2017 19:13:48 -0700
Message-ID: <CAGZ79kbDpyO5uRCPnhCWmaFKhyLEUN7mYO9PhU3xF0f=W35ofw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v6 2/2] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 4:24 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule foreach a builtin. This is the very
> first step taken in this direction. Hence, 'foreach' is ported to
> submodule--helper, and submodule--helper is called from git-submodule.sh.
> The code is split up to have one function to obtain all the list of
> submodules. This function acts as the front-end of git-submodule foreach
> subcommand. It calls the function for_each_submodule_list, which basically
> loops through the list and calls function fn, which in this case is
> runcommand_in_submodule. This third function is a calling function that
> takes care of running the command in that submodule, and recursively
> perform the same when --recursive is flagged.
>
> The first function module_foreach first parses the options present in
> argv, and then with the help of module_list_compute, generates the list of
> submodules present in the current working tree.
>
> The second function for_each_submodule_list traverses through the
> list, and calls function fn (which in case of submodule subcommand
> foreach is runcommand_in_submodule) is called for each entry.
>
> The third function runcommand_in_submodule, generates a submodule struct sub
> for $name, value and then later prepends name=sub->name; and other
> value assignment to the env argv_array structure of a child_process.
> Also the <command> of submodule-foreach is push to args argv_array
> structure and finally, using run_command the commands are executed
> using a shell.
>
> The third function also takes care of the recursive flag, by creating
> a separate child_process structure and prepending "--super-prefix displaypath",
> to the args argv_array structure. Other required arguments and the
> input <command> of submodule-foreach is also appended to this argv_array.
>

Is the commit message still accurate?
You describe the changes between the versions below the --- line,
that is not recorded in the permanent commit history.

In the commit message is less important to write "what" is happening,
because that can easily be read from the patch/commit itself, but rather
"why" things happen, such as design choices, maybe:

    This aims to make git-submodule foreach a builtin. This is the very
    first step taken in this direction. Hence, 'foreach' is ported to
    submodule--helper, and submodule--helper is called from git-submodule.sh.

    We'll introduce 3 functions, one that is exposed to the command line
    and handles command line arguments, one to iterate over a set of
    submodules, and finally one to execute an arbitrary shell command
    in the submodule.

    Attention must be paid to the 'path' variable, see 64394e3ae9
    (git-submodule.sh: Don't use $path variable in eval_gettext string,
    2012-04-17) details. The path varialbe is not exposed into the environment
    of the invoked shell, but we just give "path=%s;" as the first argument.

    We do not need to condition on the number of arguments as in 1c4fb136db
    (submodule foreach: skip eval for more than one argument, 2013-09-27)
    as we will run exactly one shell in the submodules directory.

    Sign-off-...

>
> Other than that, additionally the case of no. of arugments in <command>
> being equal to 1 is also considered separetly.
> THe reason of having this change in the shell script was given in the
> commit 1c4fb136db.
> According to my understanding, eval "$1" executes $1 in same shell,
> whereas "$@" gets executed in a separate shell, which doesn't allow
> "$@" to access the env variables $name, $path, etc.
> Hence, to keep the ported function similar, this condition is also
> added.

This paragraph would be a good candidate for the commit message, too.
However as we rewrite it in C, we will spawn exactly one shell no matter
how many arguments we have (well for 0 we have no shell, but for 1 or more
arguments we'll spawn exactly one shell?)

> +       } else if (prefix) {
> +               struct strbuf sb = STRBUF_INIT;
> +               char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +               strbuf_release(&sb);
> +               return displaypath;

Note to self (or any other that is interested in long term clean code):
    I have seen this pattern a couple of times, a strbuf just to appease
    the argument list of relative_path.
    (init_submodule, prepare_to_clone_next_submodule,
    resolve_relative_path in submodule--helper
    cmd_rev_parse in builtin/rev-parse
    connect_work_tree_and_git_dir in dir.c
    write_name_quoted_relative in quote.c
    get_superproject_working_tree in submodule.c
    cmd_main in test-path-utils;
    actually all uses of this function :( )
    We should really make a relative_path function that can work
    without the need of a strbuf, maybe just wrap the 3 lines into a new
    function, or remove the strbuf from the argument list.
    (The potential memleak is horrible to fix though. But as seen here
    we could just always return an allocated string and
    mandate the caller to free it)

> +struct cb_foreach {
> +       int argc;
> +       const char **argv;
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int recursive: 1;
> +};
> +#define CB_FOREACH_INIT { 0, NULL, NULL, 0, 0 }
> +
> +static void runcommand_in_submodule(const struct cache_entry *list_item,
> +                                   void *cb_data)

As we only ever use list_item->name, we could also change
the argument list to take a "const char *[submodule_]path".

> +       prepare_submodule_repo_env(&cp.env_array);
> +       cp.use_shell = 1;
> +       cp.dir = list_item->name;
> +
> +       if (info->argc == 1) {
> +               argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> +               argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
> +               argv_array_pushf(&cp.env_array, "sha1=%s",
> +                                oid_to_hex(&list_item->oid));
> +               argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
> +
> +               argv_array_pushf(&cp.args, "path=%s; %s", list_item->name,
> +                                info->argv[0]);

In the argc != 1 case we also want to have the env_array filled with
useful variables. (It seems we do not have tests for that?)
To test for that we'd need a test similar as in 1c4fb136d,
just with
    git submodule foreach echo \$sm_path \$dpath
for example.

So I think you can move the pushes to the env array outside this condition.
As we set cp.use_shell unconditionally, we do not need to construct
the first argument specially with path preset, but instead we can just prepend
it in the array:

    argv_array_pushf(&cp.env_array, "name=%s", sub->name);
    ... // more env stuff

    argv_array_pushf(&cp.args, "path=%s;", list_item->name);
    for (i = 0; i < info->argc; i++)
        argv_array_push(&cp.args, info->argv[i]);

should do?


> +
> +       if (info->argv[0] && run_command(&cp))
> +               die(_("run_command returned non-zero status for %s\n."),

This would rather be
    die(_("Stopping at '%s'; script returned non-zero status."), displaypath);
to imitate the shell version faithfully?


> +
> +               if (run_command(&cpr))
> +                       die(_("run_command returned non-zero status while"
> +                             "recursing in the nested submodules of %s\n."),
> +                             displaypath);

same here. As the inner process would have already printed the "Stopping..."
we would not need to repeat it, though.

So maybe

    /* no need to report error, child does: */
    run_command(&cpr);

The rest below looks good. :)

Thanks,
Stefan
