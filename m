Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A241FD09
	for <e@80x24.org>; Sun, 28 May 2017 17:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdE1R4b (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 13:56:31 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33246 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdE1R4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 13:56:30 -0400
Received: by mail-qt0-f181.google.com with SMTP id t26so37484286qtg.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oXbi+ga9Ws02scue4rn2jeJCOH9jcY2S+iCzMJnyqGs=;
        b=GrBvmJ3hvtcITq7zW8Ea2jqXJOj9PP9uBsN0gJdPJkImkNUPgj+uaNq89i7RtYj6Cv
         X7kDa/jCSzwvfNS+Gc/xVlKaUHUYWanThur6se6MNstYosCNM+b5D9MAMgu5VaZ9zudz
         c7qwN8BmGwJCkqMzQjnaUvM8qSnirrx98TnW4j6u//NI28LlgEQuYjDRYxTETaQVYyY0
         AxZHEmkY4AQ64gZUryzucP9dpD46RBqgtqWqk8ifJGaGqUJol6PRSrUeYFJOoHrk5tYP
         ufgPI1EceDg2ztpWtiw6ZVIl6cxGuU/oTjdn5KUIdrAlJ6wbwq5sICc1wIJELl5wOQIM
         jo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oXbi+ga9Ws02scue4rn2jeJCOH9jcY2S+iCzMJnyqGs=;
        b=m1BJsWx1Jomg/fBKAENhxUo3YPiY2skWnxCOMc3qNzNu3rcXi78W+0QGn2MZih1aYE
         ARv9GbCBJPRVphPsTK741wNcrPSmh6WUww45Ro3unTDWvwNOdMyAZwcwFiWqNFXQxtqV
         gw62Ov48T0LqKpeu62HCYFT9bpjlnzZrpyxZ4tRQ1cAm6ZHZT043dri0/C+ro1af/NYH
         AiVsxftLwQK8MHplsWNHMaMJKDbEKBSrsfJXaft/S6oQTKJSvc3kSIZG+1H98UuRacLC
         qXnkv0kDnS3eMXt30GLJe95pNa33/OhujP3HCS/8zWWX+3DOjLL0mM5YOP6Ae0dtbInO
         o1MA==
X-Gm-Message-State: AODbwcATdWyLAYXfuOusuAjzz3ALWESDxes50nigu9gfSurP4WgDwfcy
        s7KqNSdPVMdiC7T5BVox2/R6Ll9n5A==
X-Received: by 10.237.60.4 with SMTP id t4mr15542627qte.116.1495994189289;
 Sun, 28 May 2017 10:56:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Sun, 28 May 2017 10:56:28 -0700 (PDT)
In-Reply-To: <20170528165642.14699-5-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 28 May 2017 19:56:28 +0200
Message-ID: <CAP8UFD26oR2Y4hTYmZLBeKA8MTVe8ZTG3pJxfS9Xv8JUExbcKA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:

[...]

> +int untracked_files(struct strbuf *out, int include_untracked,
> +               const char **argv)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       cp.git_cmd = 1;
> +       argv_array_push(&cp.args, "ls-files");
> +       argv_array_push(&cp.args, "-o");
> +       argv_array_push(&cp.args, "-z");

You might want to use argv_array_pushl(), for example:

       argv_array_pushl(&cp.args, "ls-files", "-o", "-z", NULL);

> +       if (include_untracked != 2)
> +               argv_array_push(&cp.args, "--exclude-standard");
> +       argv_array_push(&cp.args, "--");
> +       if (argv)
> +               argv_array_pushv(&cp.args, argv);
> +       return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}
> +
> +static int check_no_changes(const char *prefix, int include_untracked,
> +               const char **argv)
> +{
> +       struct argv_array args1;
> +       struct argv_array args2;
> +       struct strbuf out = STRBUF_INIT;
> +
> +       argv_array_init(&args1);
> +       argv_array_push(&args1, "diff-index");
> +       argv_array_push(&args1, "--quiet");
> +       argv_array_push(&args1, "--cached");
> +       argv_array_push(&args1, "HEAD");
> +       argv_array_push(&args1, "--ignore-submodules");
> +       argv_array_push(&args1, "--");

Here and in other places also you could use argv_array_pushl().

> +       if (argv)
> +               argv_array_pushv(&args1, argv);
> +       argv_array_init(&args2);
> +       argv_array_push(&args2, "diff-files");
> +       argv_array_push(&args2, "--quiet");
> +       argv_array_push(&args2, "--ignore-submodules");
> +       argv_array_push(&args2, "--");
> +       if (argv)
> +               argv_array_pushv(&args2, argv);
> +       if (include_untracked)
> +               untracked_files(&out, include_untracked, argv);
> +       return cmd_diff_index(args1.argc, args1.argv, prefix) == 0 &&
> +                       cmd_diff_files(args2.argc, args2.argv, prefix) == 0 &&
> +                       (!include_untracked || out.len == 0);
> +}
> +
> +static int get_stash_info(struct stash_info *info, const char *commit)
> +{
> +       struct strbuf w_commit_rev = STRBUF_INIT;
> +       struct strbuf b_commit_rev = STRBUF_INIT;
> +       struct strbuf i_commit_rev = STRBUF_INIT;
> +       struct strbuf u_commit_rev = STRBUF_INIT;
> +       struct strbuf w_tree_rev = STRBUF_INIT;
> +       struct strbuf b_tree_rev = STRBUF_INIT;
> +       struct strbuf i_tree_rev = STRBUF_INIT;
> +       struct strbuf u_tree_rev = STRBUF_INIT;
> +       struct strbuf commit_buf = STRBUF_INIT;
> +       struct strbuf symbolic = STRBUF_INIT;
> +       struct strbuf out = STRBUF_INIT;
> +       struct object_context unused;
> +       char *str;
> +       int ret;
> +       const char *REV = commit;

We use lower case variable names.

> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       info->is_stash_ref = 0;
> +
> +       if (commit == NULL) {
> +               strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
> +               REV = commit_buf.buf;
> +       } else if (strlen(commit) < 3) {
> +               strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
> +               REV = commit_buf.buf;
> +       }
> +       info->REV = REV;

Also the "REV" member of struct stash_info could be lower cased.

> +       strbuf_addf(&w_commit_rev, "%s", REV);
> +       strbuf_addf(&b_commit_rev, "%s^1", REV);
> +       strbuf_addf(&i_commit_rev, "%s^2", REV);
> +       strbuf_addf(&u_commit_rev, "%s^3", REV);
> +       strbuf_addf(&w_tree_rev, "%s:", REV);
> +       strbuf_addf(&b_tree_rev, "%s^1:", REV);
> +       strbuf_addf(&i_tree_rev, "%s^2:", REV);
> +       strbuf_addf(&u_tree_rev, "%s^3:", REV);
> +
> +

Spurious new line above.

> +       ret = (
> +               get_sha1_with_context(w_commit_rev.buf, 0, info->w_commit.hash, &unused) == 0 &&
> +               get_sha1_with_context(b_commit_rev.buf, 0, info->b_commit.hash, &unused) == 0 &&
> +               get_sha1_with_context(i_commit_rev.buf, 0, info->i_commit.hash, &unused) == 0 &&
> +               get_sha1_with_context(w_tree_rev.buf, 0, info->w_tree.hash, &unused) == 0 &&
> +               get_sha1_with_context(b_tree_rev.buf, 0, info->b_tree.hash, &unused) == 0 &&
> +               get_sha1_with_context(i_tree_rev.buf, 0, info->i_tree.hash, &unused) == 0);
> +
> +       if (!ret) {
> +               fprintf_ln(stderr, _("%s is not a valid reference"), REV);
> +               return 1;

Maybe use "return error(_("%s is not a valid reference"), REV);"

> +       }
> +
> +

Spurious new lines above.

> +
> +static void stash_create_callback(struct diff_queue_struct *q,
> +                               struct diff_options *opt, void *cbdata)
> +{
> +       int i;
> +
> +       for (i = 0; i < q->nr; i++) {
> +               struct diff_filepair *p = q->queue[i];
> +               const char *path = p->one->path;
> +               struct stat st;
> +               remove_file_from_index(&the_index, path);
> +               if (!lstat(path, &st))
> +                       add_to_index(&the_index, path, &st, 0);
> +

Spurious new line above.

> +       }
> +}
> +
> +/* Untracked files are stored by themselves in a parentless commit, for
> + * ease of unpacking later.
> + */

This comment should rather be like:

/*
 * Untracked files are stored by themselves in a parentless commit, for
 * ease of unpacking later.
 */

> +static int save_untracked(struct stash_info *info, struct strbuf *out,
> +               int include_untracked, const char **argv)
> +{
> +       struct child_process cp2 = CHILD_PROCESS_INIT;
> +       struct strbuf out3 = STRBUF_INIT;
> +       struct strbuf out4 = STRBUF_INIT;

Please try to find more meaningful names for such variables.

> +       struct object_id orig_tree;
> +
> +       set_alternate_index_output(stash_index_path);
> +       untracked_files(&out4, include_untracked, argv);
> +
> +       cp2.git_cmd = 1;
> +       argv_array_push(&cp2.args, "update-index");
> +       argv_array_push(&cp2.args, "-z");
> +       argv_array_push(&cp2.args, "--add");
> +       argv_array_push(&cp2.args, "--remove");
> +       argv_array_push(&cp2.args, "--stdin");
> +       argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
> +
> +       if (pipe_command(&cp2, out4.buf, out4.len, NULL, 0, NULL, 0))
> +               return 1;
> +
> +       discard_cache();
> +       read_cache_from(stash_index_path);
> +
> +       write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0, NULL);
> +       discard_cache();
> +
> +       read_cache_from(stash_index_path);
> +
> +       write_cache_as_tree(info->u_tree.hash, 0, NULL);
> +       strbuf_addf(&out3, "untracked files on %s", out->buf);
> +
> +       if (commit_tree(out3.buf, out3.len, info->u_tree.hash, NULL, info->u_commit.hash, NULL, NULL))
> +               return 1;
> +
> +       set_alternate_index_output(".git/index");

Isn't there a variable, a function or a constant that could be used
instead of the hard coded ".git/index"?

> +       discard_cache();
> +       read_cache();
> +
> +       return 0;
> +}
> +
> +static int save_working_tree(struct stash_info *info, const char *prefix,
> +               const char **argv)
> +{
> +       struct object_id orig_tree;
> +       struct rev_info rev;
> +       int nr_trees = 1;
> +       struct tree_desc t[MAX_UNPACK_TREES];
> +       struct tree *tree;
> +       struct unpack_trees_options opts;
> +       struct object *obj;
> +
> +       discard_cache();
> +       tree = parse_tree_indirect(info->i_tree.hash);
> +       prime_cache_tree(&the_index, tree);
> +       write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0, NULL);
> +       discard_cache();
> +
> +       read_cache_from(stash_index_path);
> +
> +       memset(&opts, 0, sizeof(opts));
> +
> +       parse_tree(tree);
> +
> +       opts.head_idx = 1;
> +       opts.src_index = &the_index;
> +       opts.dst_index = &the_index;
> +       opts.merge = 1;
> +       opts.fn = oneway_merge;
> +
> +       init_tree_desc(t, tree->buffer, tree->size);
> +
> +       if (unpack_trees(nr_trees, t, &opts))
> +               return 1;

In general I think we tend to return -1 instead of 1 in case of errors in C.

[...]

> +static int do_create_stash(struct stash_info *info, const char *prefix,
> +       const char *message, int include_untracked, int patch, const char **argv)
> +{
> +       struct object_id curr_head;
> +       char *branch_path = NULL;
> +       const char *branch_name = NULL;
> +       struct commit_list *parents = NULL;
> +       struct strbuf out = STRBUF_INIT;
> +       struct strbuf out3 = STRBUF_INIT;
> +       struct pretty_print_context ctx = {0};
> +
> +       struct commit *c = NULL;
> +       const char *hash;
> +       struct strbuf out2 = STRBUF_INIT;
> +
> +       read_cache_preload(NULL);
> +       refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
> +       if (check_no_changes(prefix, include_untracked, argv))
> +               return 1;
> +
> +       if (get_sha1_tree("HEAD", info->b_commit.hash))
> +               die(_("You do not have the initial commit yet"));
> +
> +       branch_path = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
> +
> +       if (branch_path == NULL || strcmp(branch_path, "HEAD") == 0)
> +               branch_name = "(no branch)";
> +       else
> +               skip_prefix(branch_path, "refs/heads/", &branch_name);
> +
> +       c = lookup_commit(info->b_commit.hash);
> +
> +       ctx.output_encoding = get_log_output_encoding();
> +       ctx.abbrev = 1;
> +       ctx.fmt = CMIT_FMT_ONELINE;
> +       hash = find_unique_abbrev(c->object.oid.hash, DEFAULT_ABBREV);
> +
> +       strbuf_addf(&out, "%s: %s ", branch_name, hash);
> +
> +       pretty_print_commit(&ctx, c, &out);
> +
> +       strbuf_addf(&out3, "index on %s\n", out.buf);
> +
> +       commit_list_insert(lookup_commit(info->b_commit.hash), &parents);
> +
> +       if (write_cache_as_tree(info->i_tree.hash, 0, NULL))
> +               die(_("git write-tree failed to write a tree"));
> +
> +       if (commit_tree(out3.buf, out3.len, info->i_tree.hash, parents, info->i_commit.hash, NULL, NULL))
> +               die(_("Cannot save the current index state"));
> +
> +
> +       if (include_untracked) {
> +               if (save_untracked(info, &out, include_untracked, argv))
> +                       die(_("Cannot save the untracked files"));
> +       }
> +
> +

Spurious new line above.

> +       if (patch) {
> +               if (patch_working_tree(info, prefix, argv))
> +                       die(_("Cannot save the current worktree state"));
> +       } else {
> +               if (save_working_tree(info, prefix, argv))
> +                       die(_("Cannot save the current worktree state"));
> +       }
> +       parents = NULL;
> +
> +       if (include_untracked) {
> +               commit_list_insert(lookup_commit(info->u_commit.hash), &parents);
> +       }

Braces can be removed above.

> +       commit_list_insert(lookup_commit(info->i_commit.hash), &parents);
> +       commit_list_insert(lookup_commit(info->b_commit.hash), &parents);
> +
> +       if (message != NULL && strlen(message) != 0)
> +               strbuf_addf(&out2, "On %s: %s\n", branch_name, message);
> +       else
> +               strbuf_addf(&out2, "WIP on %s\n", out.buf);
> +
> +       if (commit_tree(out2.buf, out2.len, info->w_tree.hash, parents, info->w_commit.hash, NULL, NULL))
> +               die(_("Cannot record working tree state"));
> +
> +       info->message = out2.buf;
> +
> +       free(branch_path);
> +
> +       return 0;
> +}
> +
> +static int create_stash(int argc, const char **argv, const char *prefix)
> +{
> +       int include_untracked = 0;
> +       const char *message = NULL;
> +       struct stash_info info;
> +       struct option options[] = {
> +               OPT_BOOL('u', "include-untracked", &include_untracked,
> +                        N_("stash untracked filed")),
> +               OPT_STRING('m', "message", &message, N_("message"),
> +                        N_("stash commit message")),
> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                                git_stash_create_usage, 0);
> +
> +       if (argc != 0) {
> +               struct strbuf out = STRBUF_INIT;
> +               int i;
> +               for (i = 0; i < argc; ++i) {
> +                       if (i != 0) {
> +                               strbuf_addf(&out, " ");
> +                       }

Braces can be removed.

[...]

> +static int store_stash(int argc, const char **argv, const char *prefix)
> +{
> +       const char *message = NULL;
> +       const char *commit = NULL;
> +       struct object_id obj;
> +       struct option options[] = {
> +               OPT_STRING('m', "message", &message, N_("message"),
> +                        N_("stash commit message")),
> +               OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +               OPT_END()
> +       };
> +       argc = parse_options(argc, argv, prefix, options,
> +                                git_stash_store_usage, 0);
> +
> +       if (message == NULL)
> +               message = "Create via \"git stash store\".";

Maybe you could have initialized "message" when you declared the variable above.

> +       if (argc != 1)
> +               die(_("\"git stash store\" requires one <commit> argument"));
> +
> +       commit = argv[0];
> +
> +       if (get_sha1(commit, obj.hash)) {
> +               fprintf_ln(stderr, _("fatal: %s: not a valid SHA1"), commit);
> +               fprintf_ln(stderr, _("cannot update %s with %s"), ref_stash, commit);
> +               return 1;

Maybe use error() or warning().

> +       }

[...]

> +static int do_push_stash(const char *prefix, const char *message,
> +               int keep_index, int include_untracked, int patch, const char **argv)
> +{
> +       int result;
> +       struct stash_info info;
> +
> +       if (patch && include_untracked) {
> +               fprintf_ln(stderr, _("can't use --patch and --include-untracked or --all at the same time"));
> +               return 1;

error()?

> +       }
> +
> +       if (!include_untracked) {
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               struct strbuf out = STRBUF_INIT;
> +
> +               cp.git_cmd = 1;
> +               argv_array_push(&cp.args, "ls-files");
> +               argv_array_push(&cp.args, "--error-unmatch");
> +               argv_array_push(&cp.args, "--");
> +               if (argv)
> +                       argv_array_pushv(&cp.args, argv);
> +               result = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
> +               if (result)
> +                       return 1;
> +       }
> +
> +       read_cache_preload(NULL);
> +       refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
> +       if (check_no_changes(prefix, include_untracked, argv)) {
> +               printf(_("No local changes to save\n"));
> +               return 0;
> +       }
> +
> +       if (!reflog_exists(ref_stash)) {
> +               if (do_clear_stash())
> +                       die(_("Cannot initialize stash"));
> +       }
> +
> +

Spurious new line.

> +       do_create_stash(&info, prefix, message, include_untracked, patch, argv);
> +       result = do_store_stash(prefix, 1, info.message, info.w_commit);
> +
> +       if (result == 0 && !quiet) {
> +               printf(_("Saved working directory and index state %s"), info.message);
> +       }

Braces can be removed.

I stopped skimming here.

Thanks,
Christian.
