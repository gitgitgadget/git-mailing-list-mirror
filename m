Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6CC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD872075D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCdl9LBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgHET3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgHERKf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:35 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5DC0086B9
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:02:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so27954934qtq.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOfTO3nkNrpXzqhwrtXN4K6JD41RtRz52ebPNyfEpsA=;
        b=bCdl9LBXxfW6wJUfj2a2uK3OVB3Iy0ZtZaykrWhuoFE/cDpZjIfsRIKIEF3B+Kkz/d
         65q8byasLHTCWIojxosex7kKMWK7Opr7Jvjy+b1GQFE3bmfJuhjvemb5gIgszsvmh3rR
         PgvlwhjEjdAvmeLsnIEbdHMq1T2lvFc/THEkcSwYjwHcPq88xm+5WOW4VuCd299M/Zom
         nzt6MerfDc2Ae6OYaArtIRG/E0cfaM4K1/Hm8bxoHXRbdYKvzDUhI+dr/WH6YbnKC2b2
         vQWOPi6NE9qFG9VtRIwLj6CEgBIMWoiHj7PnwGinCoPXRYTkJdeKlW4Zkc5jW3LIW9Qm
         yjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOfTO3nkNrpXzqhwrtXN4K6JD41RtRz52ebPNyfEpsA=;
        b=Tft80IwuLLrHup1NnX3y+KLfrTD0aoRCqOpdjZ/6nnFBNxsASjbeBEzzKfwQ7xjYqb
         PvwfMMoDh8YI1iX/pa8rEhXlrYkz2Gr9h7A3OQzhsRRktEYK6SS+n4hzu/HyhXvue4Tt
         M+YXo7YUWlBcGRzHF33/QDTcWDldn5Y/h0XlxrnY701EQhjmSxlrHeQmYGPQ7g6Qf17W
         1zRZ8bBKdR464fesEEvN/rF9nQ2pEJj1YsB63NFpJbojxoVLryUg41iGLSlleP9TIbVm
         /3BWoK8fR9wmpiKph6ZDJoVrrO8UmxSNY5eX4avoWh7n4jJIM7ljSJFOpQ8pEuUBFCge
         xwxw==
X-Gm-Message-State: AOAM531KvhjRBaB8r/UeWFwGH+UwL1JpB/j4XcbR6WCYXIkoy9Xh2PwJ
        q1fAZ+dwa1aq7b4e+v+9dztw8Amr5YY//g==
X-Google-Smtp-Source: ABdhPJyy0IeCGvnfKkutCUzuOaD7SdQC1cUlI9LYOzqN1152YL2/kGniizNYH7rpRL3bcldHPMJAhQ==
X-Received: by 2002:ac8:1201:: with SMTP id x1mr3528877qti.95.1596639745299;
        Wed, 05 Aug 2020 08:02:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2c68:49ab:a5c1:6501? ([2600:1700:e72:80a0:2c68:49ab:a5c1:6501])
        by smtp.gmail.com with ESMTPSA id q126sm1579094qke.34.2020.08.05.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 08:02:24 -0700 (PDT)
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ca0c449-033b-545e-4338-ca187946d63d@gmail.com>
Date:   Wed, 5 Aug 2020 11:02:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200803174654.GA2473576@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 1:46 PM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
>> On 7/30/2020 8:30 PM, Jonathan Nieder wrote:
>>> Derrick Stolee wrote:
>>>> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:

Revisiting the first part of this thread, as it got lost in the discussion
about trace2 and JSON parsing...

>>>>> [jrnieder] How do I supply the tasks on the command line?  Are they
>>>>> parameters to this subcommand?  If so, it could make sense for this to
>>>>> say something like
>>>>>
>>>>> 	run <task>...::
>>>>
>>>> Hopefully this is documented to your satisfaction when the ability
>>>> to customize the tasks is implemented.
> [...]
>> I mean that there is only one task right now. Until the commit-graph
>> task is implemented, there is no need to have a --task=<task> option.
> 
> Ah, that wasn't clear to me from the docs.
> 
> You're saying that "git maintenance run" runs the "gc" task?  Can the
> documentation say so?

In this patch, the documentation says

	Run tasks to optimize Git repository data

the plural is a bit incorrect at this point, but not a huge deal.

The run subcommand says "Run one or more maintenance tasks" which again
is a bit misleading since "or more" is not technically possible. This
becomes a bit obvious when we see that the task list only contains a 'gc'
task.

So no, the documentation in this patch doesn't say "Run the 'gc' task"
because that could be gathered from context _and_ it will be incorrect
by the time this patch is integrated as part of the series.

So I struggle with finding a way to improve the documentation in this
patch to satisfy your concerns. Any change made here will just be un-done
by a later patch in the same series.

I'd rather have something vague now and improve the documentation
incrementally along with the implementation.

Another point you made earlier, but seems to be dropped in this email:
you wanted the return code documented. This also seems like wasteful
text, because the best I can think of is

  This command will return 0 unless a maintenance task failed in an
  unrecoverable way, or other typical failure cases such as incorrect
  usage or the command being run outside of a Git repository.

Please recommend something better, because that description suffers from
being too generic/obvious when talking about the maintenance task and
being an obvious repetition of Git's existing error code behavior.

Perhaps this would be easier if there was an established pattern of
documenting the return code. So, I went digging.

The examples I could find are:

 1. 'git cat-file -e'
 2. 'git check-ref-format'
 3. 'git commit-graph --object-dir=<dir>'
 4. 'git cvsimport'
 5. 'git fast-import'
 6. 'git filter-branch'
 7. 'git grep --quiet'
 8. 'git gui citool'
 9. 'git ls-remote --exit-code'
10. 'git merge-base --is-ancestor'
11. 'git push --recurse-submodules'
12. 'git reflog exists'
13. 'git rev-parse --parseopt'
14. 'git update-index --test-untracked-cache' 

Most of these are for specific options, and the exit code is documented
with relation to how that specific option may lead to a non-zero exit
code (1, 3, 7, 8, 9, 10, 11, 12, 13, 14).

The one that is most clearly part of the main description is for
the plumbing command 'git check-ref-format':

	Checks if a given 'refname' is acceptable, and exits with
	a non-zero status if it is not.

This seems appropriate for something intended for use as a helper
in script, with a very simple behavior. The exit code is the only
way it provides any feedback to the caller! This use of the exit
code as the only output is used by some other cases (1, 7, 9, 10,
11, 12, 13, 14).

Of course, we also have examples like this in git-cvsimport.txt:

	Otherwise, success is indicated the Unix way, i.e. by simply
	exiting with a zero exit status.

This phrase should be _assumed_ as part of Git itself, instead of
written in the documentation for specific commands.

The documentation for 'git fast-import' is more useful here:

	If fast-import is supplied invalid input it will terminate
	with a non-zero exit status and create a crash report...

But, you can see that the exit code is not the focus, but the
crash report _is_ important to document.

'git filter-branch' has a special exit code for the case that no
commits were found to update.

'git gui citool' returns an error code if the window is closed
before the command can complete. This is also not a core feature,
so is not a good example.

My only conclusion from this investigation is that the exit code
is documented when it is useful, but otherwise the standard Unix
pattern is assumed and not worth documenting.

If this is something we want to change, then I don't think it
valuable to have that discussion here. Instead, let's start that
discussion elsewhere with a series that updates existing docs to
catch up to a new standard of documenting the exit code.

[1] https://git-scm.com/docs/git-cat-file#Documentation/git-cat-file.txt--e
[2] https://git-scm.com/docs/git-check-ref-format#_description
[3] https://git-scm.com/docs/git-commit-graph#Documentation/git-commit-graph.txt---object-dir
[4] https://git-scm.com/docs/git-cvsimport#_output
[5] https://git-scm.com/docs/git-fast-import#_crash_reports
[6] https://git-scm.com/docs/git-filter-branch#_exit_status
[7] https://git-scm.com/docs/git-grep#Documentation/git-grep.txt---quiet
[8] https://git-scm.com/docs/git-gui#Documentation/git-gui.txt-codegitguicitoolcode
[9] https://git-scm.com/docs/git-ls-remote#Documentation/git-ls-remote.txt---exit-code
[10] https://git-scm.com/docs/git-merge-base#Documentation/git-merge-base.txt---is-ancestor
[11] https://git-scm.com/docs/git-push#Documentation/git-push.txt---recurse-submodulescheckon-demandonlyno
[12] https://git-scm.com/docs/git-reflog
[13] https://git-scm.com/docs/git-rev-parse#_parseopt
[14] https://git-scm.com/docs/git-update-index#Documentation/git-update-index.txt---test-untracked-cache

> [...]
>>>>>> +static struct maintenance_opts {
>>>>>> +	int auto_flag;
>>>>>> +} opts;
>>>>>
>>>>> Packing this in a struct feels a bit unusual.  Is the struct going to
>>>>> be passed somewhere, or could these be individual locals in
>>>>> cmd_maintenance?
>>>>
>>>> This will grow, and I'd rather have one global struct than many
>>>> individual global items. It makes it clearer when I use
>>>> "opts.auto_flag" that this corresponds to whether "--auto" was
>>>> provided as a command-line option.
>>>
>>> That doesn't seem idiomatic within the Git codebase.
>>>
>>> Can they be locals instead?
>>
>> Which part do you want to be idiomatic? The fact that the parse-options
>> library typically refers to static global values or the fact that the
>> data is not organized in a struct?
> 
> parse-options has no requirement about the values being global.  Some
> older code does that, but newer code tends to use locals when
> appropriate.

You're right. Global is not required. The struct needs to be 'static'
or initialized for compilation.

While trying to get rid of globals based on your recommendation, I
see that the callback functions in the option-parsing _do_ require
global state. This is used in "maintenance: add --task option" with
the global tasks array, but it also uses a global count of "how many
tasks have been selected" currently in the struct. Two ways to get
around that issue include (1) making a global int, or (2) looping
through the task list to count how many have been selected so far.

Neither of these solutions is clean. (In the diff below, I chose
option 2.)

> Putting it in a struct is fine as long as that struct is being passed
> around.  What isn't idiomatic in Git is using a global struct for
> namespacing.

In my opinion, using a global struct would be better than the existing
pattern of a bunch of global variables, but I get your point about
precedence. More on this below.

> [...]
>> The natural thing to do to "fix" that situation is to create a struct
>> that holds the information from the parsed command-line arguments. But
>> then why is it a local parameter that is passed through all of the
>> local methods instead of a global (as presented here in this patch)?
> 
> I'm having trouble parsing that last sentence.  You're saying a global
> is preferable over passing around a pointer to a local "opts" struct?

Using a "singleton" like the opts struct here, the code is definitely
much simpler to read. There is only ever one instance, because the struct
definition comes along with the instance declaration.

By making it a local instance, we then need to pass around the struct as
a parameter to all of the static methods in the builtin, even though there
is only ever one instance of this struct per process.

The two points above are the ones that led me to use the global instance
in the first place.

To get back to your point about being idiomatic, these builtins use a
struct to group options, then pass it around as a parameter:

* cat-file (struct batch_options)
* checkout (struct checkout_opts)
* rebase (struct rebase_options)
* tag (struct create_tag_options)
* worktree (struct add_opts)

Unfortunately, there _is_ an example of the behavior I was following in
this series: my own example in the sparse-checkout builtin. So, I'm just
repeating my own mistakes that were not challenged before.

I updated my v4-in-progress branch with that change, and the tip-to-tip
diff is below. It required some non-trivial care around the --task=<task>
callback (which can't see the local options struct) and other cases.

Thanks,
-Stolee

--- 

diff --git a/builtin/gc.c b/builtin/gc.c
index 1f0c519d14..3e473a1293 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -709,11 +709,10 @@ static const char * const builtin_maintenance_usage[] = {
 	NULL
 };
 
-static struct maintenance_opts {
+struct maintenance_opts {
 	int auto_flag;
 	int quiet;
-	int tasks_selected;
-} opts;
+};
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -789,7 +788,7 @@ static int should_write_commit_graph(void)
 	return result;
 }
 
-static int run_write_commit_graph(void)
+static int run_write_commit_graph(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -797,13 +796,13 @@ static int run_write_commit_graph(void)
 	strvec_pushl(&child.args, "commit-graph", "write",
 		     "--split", "--reachable", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
 	return !!run_command(&child);
 }
 
-static int run_verify_commit_graph(void)
+static int run_verify_commit_graph(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -811,24 +810,24 @@ static int run_verify_commit_graph(void)
 	strvec_pushl(&child.args, "commit-graph", "verify",
 		     "--shallow", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
 	return !!run_command(&child);
 }
 
-static int maintenance_task_commit_graph(void)
+static int maintenance_task_commit_graph(struct maintenance_opts *opts)
 {
 	struct repository *r = the_repository;
 	char *chain_path;
 
 	close_object_store(r->objects);
-	if (run_write_commit_graph()) {
+	if (run_write_commit_graph(opts)) {
 		error(_("failed to write commit-graph"));
 		return 1;
 	}
 
-	if (!run_verify_commit_graph())
+	if (!run_verify_commit_graph(opts))
 		return 0;
 
 	warning(_("commit-graph verify caught error, rewriting"));
@@ -840,14 +839,14 @@ static int maintenance_task_commit_graph(void)
 	}
 	free(chain_path);
 
-	if (!run_write_commit_graph())
+	if (!run_write_commit_graph(opts))
 		return 0;
 
 	error(_("failed to rewrite commit-graph"));
 	return 1;
 }
 
-static int fetch_remote(const char *remote)
+static int fetch_remote(const char *remote, struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -855,7 +854,7 @@ static int fetch_remote(const char *remote)
 	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
 		     "--no-write-fetch-head", "--refmap=", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
 	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
@@ -871,7 +870,7 @@ static int fill_each_remote(struct remote *remote, void *cbdata)
 	return 0;
 }
 
-static int maintenance_task_prefetch(void)
+static int maintenance_task_prefetch(struct maintenance_opts *opts)
 {
 	int result = 0;
 	struct string_list_item *item;
@@ -886,23 +885,23 @@ static int maintenance_task_prefetch(void)
 	for (item = remotes.items;
 	     item && item < remotes.items + remotes.nr;
 	     item++)
-		result |= fetch_remote(item->string);
+		result |= fetch_remote(item->string, opts);
 
 cleanup:
 	string_list_clear(&remotes, 0);
 	return result;
 }
 
-static int maintenance_task_gc(void)
+static int maintenance_task_gc(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
 	strvec_push(&child.args, "gc");
 
-	if (opts.auto_flag)
+	if (opts->auto_flag)
 		strvec_push(&child.args, "--auto");
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 	else
 		strvec_push(&child.args, "--no-quiet");
@@ -911,14 +910,14 @@ static int maintenance_task_gc(void)
 	return run_command(&child);
 }
 
-static int prune_packed(void)
+static int prune_packed(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
 	strvec_push(&child.args, "prune-packed");
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
 	return !!run_command(&child);
@@ -977,7 +976,7 @@ static int write_loose_object_to_stdin(const struct object_id *oid,
 	return ++(d->count) > d->batch_size;
 }
 
-static int pack_loose(void)
+static int pack_loose(struct maintenance_opts *opts)
 {
 	struct repository *r = the_repository;
 	int result = 0;
@@ -996,7 +995,7 @@ static int pack_loose(void)
 	pack_proc.git_cmd = 1;
 
 	strvec_push(&pack_proc.args, "pack-objects");
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&pack_proc.args, "--quiet");
 	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
 
@@ -1027,9 +1026,9 @@ static int pack_loose(void)
 	return result;
 }
 
-static int maintenance_task_loose_objects(void)
+static int maintenance_task_loose_objects(struct maintenance_opts *opts)
 {
-	return prune_packed() || pack_loose();
+	return prune_packed(opts) || pack_loose(opts);
 }
 
 static int incremental_repack_auto_condition(void)
@@ -1061,14 +1060,14 @@ static int incremental_repack_auto_condition(void)
 	return count >= incremental_repack_auto_limit;
 }
 
-static int multi_pack_index_write(void)
+static int multi_pack_index_write(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "multi-pack-index", "write", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
 	if (run_command(&child))
@@ -1077,7 +1076,7 @@ static int multi_pack_index_write(void)
 	return 0;
 }
 
-static int rewrite_multi_pack_index(void)
+static int rewrite_multi_pack_index(struct maintenance_opts *opts)
 {
 	struct repository *r = the_repository;
 	char *midx_name = get_midx_filename(r->objects->odb->path);
@@ -1085,17 +1084,18 @@ static int rewrite_multi_pack_index(void)
 	unlink(midx_name);
 	free(midx_name);
 
-	return multi_pack_index_write();
+	return multi_pack_index_write(opts);
 }
 
-static int multi_pack_index_verify(const char *message)
+static int multi_pack_index_verify(struct maintenance_opts *opts,
+				   const char *message)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "multi-pack-index", "verify", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
 	if (run_command(&child)) {
@@ -1106,14 +1106,14 @@ static int multi_pack_index_verify(const char *message)
 	return 0;
 }
 
-static int multi_pack_index_expire(void)
+static int multi_pack_index_expire(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
 	close_object_store(the_repository->objects);
@@ -1164,14 +1164,14 @@ static off_t get_auto_pack_size(void)
 	return result_size;
 }
 
-static int multi_pack_index_repack(void)
+static int multi_pack_index_repack(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
 
-	if (opts.quiet)
+	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
 	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
@@ -1185,7 +1185,7 @@ static int multi_pack_index_repack(void)
 	return 0;
 }
 
-static int maintenance_task_incremental_repack(void)
+static int maintenance_task_incremental_repack(struct maintenance_opts *opts)
 {
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_multi_pack_index) {
@@ -1193,22 +1193,22 @@ static int maintenance_task_incremental_repack(void)
 		return 0;
 	}
 
-	if (multi_pack_index_write())
+	if (multi_pack_index_write(opts))
 		return 1;
-	if (multi_pack_index_verify("after initial write"))
-		return rewrite_multi_pack_index();
-	if (multi_pack_index_expire())
+	if (multi_pack_index_verify(opts, "after initial write"))
+		return rewrite_multi_pack_index(opts);
+	if (multi_pack_index_expire(opts))
 		return 1;
-	if (multi_pack_index_verify("after expire step"))
-		return !!rewrite_multi_pack_index();
-	if (multi_pack_index_repack())
+	if (multi_pack_index_verify(opts, "after expire step"))
+		return !!rewrite_multi_pack_index(opts);
+	if (multi_pack_index_repack(opts))
 		return 1;
-	if (multi_pack_index_verify("after repack step"))
-		return !!rewrite_multi_pack_index();
+	if (multi_pack_index_verify(opts, "after repack step"))
+		return !!rewrite_multi_pack_index(opts);
 	return 0;
 }
 
-typedef int maintenance_task_fn(void);
+typedef int maintenance_task_fn(struct maintenance_opts *opts);
 
 /*
  * An auto condition function returns 1 if the task should run
@@ -1275,9 +1275,9 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 	return b->selected_order - a->selected_order;
 }
 
-static int maintenance_run(void)
+static int maintenance_run(struct maintenance_opts *opts)
 {
-	int i;
+	int i, found_selected = 0;
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
@@ -1291,7 +1291,7 @@ static int maintenance_run(void)
 		 * recursive process stack. Do not report an error in
 		 * that case.
 		 */
-		if (!opts.auto_flag && !opts.quiet)
+		if (!opts->auto_flag && !opts->quiet)
 			error(_("lock file '%s' exists, skipping maintenance"),
 			      lock_path);
 		free(lock_path);
@@ -1299,23 +1299,26 @@ static int maintenance_run(void)
 	}
 	free(lock_path);
 
-	if (opts.tasks_selected)
+	for (i = 0; !found_selected && i < TASK__COUNT; i++)
+		found_selected = tasks[i].selected;
+
+	if (found_selected)
 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
 
 	for (i = 0; i < TASK__COUNT; i++) {
-		if (opts.tasks_selected && !tasks[i].selected)
+		if (found_selected && !tasks[i].selected)
 			continue;
 
-		if (!opts.tasks_selected && !tasks[i].enabled)
+		if (!found_selected && !tasks[i].enabled)
 			continue;
 
-		if (opts.auto_flag &&
+		if (opts->auto_flag &&
 		    (!tasks[i].auto_condition ||
 		     !tasks[i].auto_condition()))
 			continue;
 
 		trace2_region_enter("maintenance", tasks[i].name, r);
-		if (tasks[i].fn()) {
+		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
 		}
@@ -1349,17 +1352,15 @@ static void initialize_task_config(void)
 static int task_option_parse(const struct option *opt,
 			     const char *arg, int unset)
 {
-	int i;
+	int i, num_selected = 0;
 	struct maintenance_task *task = NULL;
 
 	BUG_ON_OPT_NEG(unset);
 
-	opts.tasks_selected++;
-
 	for (i = 0; i < TASK__COUNT; i++) {
+		num_selected += tasks[i].selected;
 		if (!strcasecmp(tasks[i].name, arg)) {
 			task = &tasks[i];
-			break;
 		}
 	}
 
@@ -1374,13 +1375,14 @@ static int task_option_parse(const struct option *opt,
 	}
 
 	task->selected = 1;
-	task->selected_order = opts.tasks_selected;
+	task->selected_order = num_selected + 1;
 
 	return 0;
 }
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
+	static struct maintenance_opts opts;
 	static struct option builtin_maintenance_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
@@ -1408,7 +1410,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 
 	if (argc == 1) {
 		if (!strcmp(argv[0], "run"))
-			return maintenance_run();
+			return maintenance_run(&opts);
 	}
 
 	usage_with_options(builtin_maintenance_usage,
