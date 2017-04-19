Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0001FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 18:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030600AbdDSSIO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 14:08:14 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33687 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030594AbdDSSIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 14:08:13 -0400
Received: by mail-yb0-f179.google.com with SMTP id 81so11235407ybp.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YnlClpd+8RCOMCEn7q74vHGf8ADuWa69+4rCIJaELO8=;
        b=hHSfjremkoiYUWWcYYbkPPYmFK0Esdzs9QdC7T7kH+zZvcBEiXF3O8zF1l5tjhInVl
         XkeS/btakU+HID2tUULB06XtXGjG8WgC2Nikw568ybOWaoihpqTuG6Luh+QXTjnrGKKa
         GXa/8K1yVQDBZtgqM02bqPASVsP08mdOayeOmrWUdEk2l2FfvgO12SB1Swtf4o+6ei1S
         hNVhLTTdygNIEjMueLOtg2tYl0wPL/z1euPpr42X+oR6ERTX9GTpnrqi+x+AAeK23Gu9
         DyOFEguUdxnvPHJd1XuaHamXdBtIwBvdrvOVvcr0CvFLiwkUP/9j1y4VW1yjhkR0X/wc
         UvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YnlClpd+8RCOMCEn7q74vHGf8ADuWa69+4rCIJaELO8=;
        b=KzEC9YKZ42Yj6DlIizdCP18h8VZ1ShLRXYX4BECRKsTekLE52tAIfKzgAF2B0RR1ST
         2jh+OCtQP5RxpASzVBC7PytrYWQzRaR8Wx/iCOau+/HYkSNpeUjZ3/QnnxvApHeBfRwb
         xr0/XfOjUO57oyHSIHcGOtL5CzNcM10WVcO3+x271yRejsFpvdUKDoj2M9qMS+6Y56Um
         M/i6R/FHzcVeHeuNQp3GcL+q3ZUaOxnL0bpBWeR5veSJAh0WjBzQ+UrsBDJWbkuFZYC6
         vAmm9VVZWNVfneyAcyauaaNss7VxOrvpB1vezLB3OT7+jHrdRMYNgwOSONsTDzdtaf9f
         rj6Q==
X-Gm-Message-State: AN3rC/5vpAIwkBwH8B10J76g09XxOaXVAisguvMifiTxchxSyMNI45Ke
        y+8xMQ8FwpGZ4+FGvjS5XY4lB4YxRpOJj161Ew==
X-Received: by 10.84.236.4 with SMTP id q4mr5353562plk.12.1492625291777; Wed,
 19 Apr 2017 11:08:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 11:08:11 -0700 (PDT)
In-Reply-To: <20170419170513.16475-1-pc44800@gmail.com>
References: <20170419170513.16475-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 11:08:11 -0700
Message-ID: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH] submodule: port subcommand foreach from shell
 to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 10:05 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule foreach a builtin. This is the very
> first step taken in this direction. Hence, 'foreach' is ported to
> submodule--helper, and submodule--helper is called from git-submodule.sh.

cool :)


> The code is split up to have one function to obtain all the list of
> submodules and a calling function that takes care of running the command
> in that submodule, and recursively perform the same when --recursive is
> flagged.
>
> The First function module_foreach first parses the options present in
> argv, and then with the help of read_cache, generates the list of
> submodules present in the current working tree. Traversing through the
> list, foreach_submodule function is called for each entry.

I wonder if we could re-use module_list here?

> The second function foreach_submodule, generates a submodule struct sub
> for $name, $path values and then later prepends name=sub->name;
> path=sub-> path; and other value assignment to an argv_array structure.
> Also the <command> of submodule-foreach is appended to this structure
> and finally, using run_command_v_opt the commands are executed in a
> single but separate shell.

As noted below, I would use a struct child_process as that seems to make life
easier here.


When applying the patch git-am says:
Applying: submodule: port subcommand foreach from shell to C
.git/rebase-apply/patch:177: trailing whitespace.
                           if (out && out[0] == '/' && !out + 1)
warning: 1 line adds whitespace errors.

>
>  builtin/submodule--helper.c | 153 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  40 +-----------

cool. :)

> +
> +       /* Only loads from .gitmodules, no overlay with .git/config */

Why would we not overlay the .gitmodules config with .git/config?

> +       gitmodules_config();
> +
> +       if (prefix && get_super_prefix()) {
> +               die("BUG: cannot have prefix and superprefix");
> +       } else if (prefix) {
> +               displaypath = xstrdup(relative_path(prefix, path,  &sb));
> +       } else if (get_super_prefix()) {
> +               strbuf_addf(&sb, "%s/%s", get_super_prefix(), path);
> +               displaypath = strbuf_detach(&sb, NULL);
> +       } else {
> +               displaypath = xstrdup(path);
> +       }
> +
> +       sub = submodule_from_path(null_sha1, path);
> +
> +       if (!sub)
> +               die(_("No url found for submodule path '%s' in .gitmodules"),
> +                     displaypath);
> +       strbuf_add_unique_abbrev(&sub_sha1, sha1 , 40);
> +

> +
> +                       if (argc == 1) {
> +                               struct argv_array argcp1 = ARGV_ARRAY_INIT;

Oh the case of argc=1 is interesting. 1c4fb136db (submodule foreach:
skip eval for more than one argument, 2013-09-27) explains why.



> +
> +                               strbuf_addstr(&cmd, "name=");
> +                               strbuf_addstr(&cmd, sub->name);
> +                               strbuf_addstr(&cmd, "; ");
> +                               strbuf_addstr(&cmd, "toplevel=");
> +                               strbuf_addstr(&cmd, toplevel);
> +                               strbuf_addstr(&cmd, "; ");
> +                               strbuf_addstr(&cmd, "sha1=");
> +                               strbuf_addstr(&cmd, sub_sha1.buf);
> +                               strbuf_addstr(&cmd, "; ");
> +                               strbuf_addstr(&cmd, "path=");
> +                               strbuf_addstr(&cmd, sub->path);
> +                               strbuf_addstr(&cmd, "; ");
> +                               strbuf_addstr(&cmd, argv[0]);

Instead of prefixing the command with these variables, we can set them
as environment variables; Then we do not have to add semicolons ourselves as the
environment variable infrastructure does that for us.

    struct child_process cp = CHILD_PROCESS_INIT;
    argv_array_pushf(&cp.env_array, "name=%s", sub->name);
    argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
    ...

> +
> +                               argv_array_push(&argcp1, cmd.buf);
> +                               run_command_v_opt(argcp1.argv, RUN_USING_SHELL);

Oh, you use run_command_v_opt, which is a wrapper around the struct
child_process.
I would suggest to use the struct child_process directly as then we
can set the environment
ourselves in an easier way. To set this flag we'd do

    cp.use_shell = 1;

> +       if (!chdir(path)) {
> +               if (!access_or_warn(".git", R_OK, 0)) {

The same applies to changing directories. Here in this code we chdir
(path) and later
chdir (toplevel), but this process doesn't need to change its
directories but it can stay at
the toplevel directory. Only the child process needs chdir to the
correct path, which can
be done via

    cp.dir = path;


> +                       } else {
> +                               run_command_v_opt(argv, RUN_USING_SHELL);
> +                       }
> +
> +                       if (recursive) {
> +                               struct argv_array argcp = ARGV_ARRAY_INIT;
> +
> +                               argv_array_push(&argcp, "git");
> +                               argv_array_push(&argcp, "--super-prefix");
> +                               argv_array_push(&argcp, displaypath);
> +                               argv_array_push(&argcp, "submodule--helper");

Good call, the recursing still needs to create a new child process of its own
instead of just calling the function recursively, as we do not have
access to the
nested submodule data here.

> +
> +                               if (quiet)
> +                                       argv_array_push(&argcp, "--quiet");
> +                               argv_array_push(&argcp, "foreach");
> +                               argv_array_push(&argcp, "--recursive");
> +
> +                               for (i = 0; i < argc; i++)
> +                                       argv_array_push(&argcp, argv[i]);
> +
> +                               run_command_v_opt(argcp.argv, RUN_USING_SHELL);

I'd also suggest to use the struct child_process directly here instead
of a wrapper
as then we have access to all the knobs ourselves.

> +
> +       struct option module_foreach_options[] = {
> +               OPT__QUIET(&quiet, N_("Suppress output of Entering each submodule command")),
> +               OPT_BOOL(0, "recursive", &recursive,
> +                        N_("Traverse submodules ercursively and apply the command for all nested submodules")),

s/ercursively/recursively/
Also wording: Do you apply a command or do you run a command? Maybe in
a shorter version:
   N_("recurse into nested submodules")


> +       const char *const git_submodule_helper_usage[] = {
> +               N_("git submodule--helper foreach [--recursive] <command>"),

and [--quiet] as well


> +       for (i = 0; i < active_nr; i++) {
> +               const struct cache_entry *ce = active_cache[i];
> +
> +               if (!S_ISGITLINK(ce->ce_mode))
> +                               continue;
> +
> +               ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
> +               list.entries[list.nr++] = ce;
> +               while (i + 1 < active_nr &&
> +                       !strcmp(ce->name, active_cache[i + 1]->name))
> +                        /*
> +                         * Skip entries with the same name in different stages
> +                         * to make sure an entry is returned only once.
> +                         */
> +                       i++;
> +       }
> +
> +       for (i = 0; i < list.nr; i++) {
> +               if (prefix) {
> +                       const char *out = NULL;
> +                       if (skip_prefix(prefix, list.entries[i]->name, &out)) {
> +                               if (out && out[0] == '/' && !out + 1)
> +                                       return 0;
> +                       }
> +               }

The lines up to here are the functional equivalent of
    git submodule--helper list --prefix "$wt_prefix"

Would it make sense to get the list via calling

    int argc = 0;
    char *argv = {NULL}; /* it has to be null terminated, I think */

    struct pathspec pathspec;
    /* no need to init this, as module_list_compute will do that via
      parse_pathspec */

    struct module_list list = MODULE_LIST_INIT

    if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
       die("BUG: module_list_compute should not choke on empty pathspec");

    for (i = 0; i < list.nr; i++)
        foreach_submodule(...);

>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>                            const char *depth, struct string_list *reference,
>                            int quiet, int progress)
> @@ -1168,6 +1320,7 @@ static struct cmd_struct commands[] = {
>         {"relative-path", resolve_relative_path, 0},
>         {"resolve-relative-url", resolve_relative_url, 0},
>         {"resolve-relative-url-test", resolve_relative_url_test, 0},
> +       {"foreach", module_foreach, SUPPORT_SUPER_PREFIX},

Having SUPPORT_SUPER_PREFIX makes sense as we want to print out
path from outside the repo for example.


> +       git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"

I think we'd want to drop the "quotes" around the last $@ such that the
arguments are not passed in as one long string, but one by one.
(Then the submodule--helper code can differentiate between the
number of arguments, just as the shell code does below)

Thanks,
Stefan
