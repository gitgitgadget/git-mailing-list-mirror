Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B84DC433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 00:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B64961935
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 00:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCZANh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhCZANI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 20:13:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BCC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 17:13:08 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so3956791oiw.13
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iVZFYJobonprl6urFTYov9JikbyvYSKhbjaESg8PZFY=;
        b=cS2/6Dofp0gaFh8QIUPhiUlZQGBZ75KTCRcjChmICkT2rq4bgB4hw1Zqyt+M4FpwQ9
         qM052W/KeybJM/WBjOdhDr+5g4bmvXgtyRe36FdGLEKjobUeJhiT7fsZV+04o63BMdys
         GFGdLMbOe1fLAABvkFlWxYWnHmU74iIir1bari8TLGtEevTsgc9DxUy8ZphfXrVT+UWv
         CtrgVR6QOPBbT/2luGhdihaJuWM5VcjDY6RQ3sYCVZrpbftj/5daVKhpS+zoVbNhzBlD
         fx0YcBM5kiKiqx3l6H8wMgFL4iRWAwp/Z7SfJ3Zg7OJSsHq3F3ohyBbSzm6ZWZpgKqis
         MSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iVZFYJobonprl6urFTYov9JikbyvYSKhbjaESg8PZFY=;
        b=gpg0WtUAYoPZ00P4PsOhrIM/48eFWaS1QIm3EIhQQtSsN3f+4dtGKUCbotzuQbkO3Y
         1TwxnHK1GkQ92wqiGfQMjqv5bnPZE843qkLgWN32sdO19OypnNe9Qux1HNkik2lzOI76
         T9Z2QZDlcYEr/j8hsTAxjxN7i+ijDGHfWIOcRTg/4RTCeEeiFm+JegrxTETlHxBYvH8f
         0cCHy6qP+wLZFcVpFGXWtDcj+ygxbquesfLlmOw4pgBA0dQJau0JCJz6yZsDtfeU6OGW
         4R2t1olXrK5l2lLgg9JQY9AD/1hPXtBtW1zwTz5/DbJ7ZyEmbNpABeqYNNgsjlc+B8ou
         HdRw==
X-Gm-Message-State: AOAM530eTbYRFr6BSlBc6XmIDBz7OEa72DO98Uaj+KrXng7v4NSsXvZk
        W+xv6g0zvtVy3QGCQDR7X0WuK7URikhHVIHluNU=
X-Google-Smtp-Source: ABdhPJyphKfuCg6z8VgkhJyQuVekMojCSI5WeghnAWZLOXzPz3JmqYN7NXgpKFQE86a6CLIx1Tb+UqraRmfwrrj8jLY=
X-Received: by 2002:aca:6545:: with SMTP id j5mr7728783oiw.31.1616717587292;
 Thu, 25 Mar 2021 17:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com> <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com> <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
 <874kgzq4qi.fsf@evledraar.gmail.com>
In-Reply-To: <874kgzq4qi.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Mar 2021 17:12:55 -0700
Message-ID: <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 24, 2021 at 8:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Mar 24 2021, Derrick Stolee wrote:
>
> > On 3/23/21 9:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> On Tue, Mar 23 2021, Derrick Stolee via GitGitGadget wrote:
> >>
> >>> From: Derrick Stolee <dstolee@microsoft.com>
> >>>
...
> >> It's not so much that I still disagree as I feel like I'm missing
> >> something. I haven't gone through this topic with a fine toothed comb,
> >> so ...
> >>
> >> If and when these patches land and I'm using this nascent sparse
> >> checkout support why wouldn't I want ls-files or another not-a-test-to=
ol
> >> to support extracting this new information that's in the index?
> >>
> >> That's why I sent the RFC patches at
> >> https://lore.kernel.org/git/20210317132814.30175-2-avarab@gmail.com/ t=
o
> >> roll this functionality into ls-files.
> >
> > And I recommend that you continue to pursue them as an independent
> > series, but I'm not going to incorporate them into this one. I'm
> > not going to distract from this internal data structure with changes
> > to user-facing commands until I think it's ready to use. As the design
> > document describes the plan, I don't expect this to be something I
> > will recommend to users until most of "Phase 3" is complete, making
> > the most common Git commands aware of a sparse index. (I expect to
> > fast-track a prototype to willing users that covers that functionality
> > while review continues on the mailing list.)
>
> This series is 20 patches. Your current derrickstolee/sparse-index/wip
> is another 36, and from skimming those patches & your design doc those
> 56 seem to be partway into Phase I of IV.
>
> So at the rate things tend to get reviewed / re-rolled & land in git.git
> it seems exceedingly likely that we'll have some part-way implementation
> of this for at least a major release or two. No?
>
> Which is why I'm suggesting/asking if we shouldn't have something like
> this debugging helper as part of installed tooling, because people are
> going to try it, it's probably going to have bugs and do other weird
> things, and I'd rather not have to manually build some test-tool to
> debug some local sparse checkout somewhere.

I'm curious why you feel it's critical that this particular piece of
debugging machinery needs to be prioritized early and exposed; in
particular, I'm not sure I follow the "people are going to try it"
assertion.  Are you the one who is going to try it or are you going to
give it to your users?  If so, what do you need out of the debugging
tool?

You are correct that this will span multiple releases; Stolee already
said he was planning to be working on this for most of 2021.  But just
because pieces of the code exist and are shipped doesn't mean it'll be
announced or supported.  For example, the git-2.30 and git-2.31
release notes were completely silent about merge-ort.  It existed in
both releases; in fact, the version that ships in git-2.31, could
theoretically be used successfully by the vast majority of users for
their daily workflow.  (But it does have known shortcomings and test
failures so I definitely did *not* want it to be announced at that
time.)

> > Making a change to a builtin is _forever_, and since the only
> > purpose right now is to expose the data in a test environment, I
> > don't want to adjust the builtin until either there is a real user
> > need or the feature has otherwise stabilized. If you want to take on
> > that responsibility, then please do.
>
> That's just not the case, we have plenty of unstable debug-esque options
> in various built-in commands, in fact ls-files already has a --debug
> option whose docs say:
>
>     This is intended to show as much information as possible for manual
>     inspection; the exact format may change at any time.
>
> It was added in 84974217151 (ls-files: learn a debugging dump format,
> 2010-07-31) and "just tacks all available data from the cache onto each
> file's line" so in a way not adjusting it and using it would be a
> regression, after all this is new data in the cache, so it should print
> it :)
>
> There's also PARSE_OPT_HIDDEN for other such in-tree use. Whatever the
> sanity/merits of me suggesting that this specific thing be in ls-files
> instead of a test-helper, it seems far fetched that something like that
> hidden behind a GIT_TEST_* env var (or hidden option, --debug etc.) is
> something we'd need to worry about backwards compatibility for.
>
> So, whatever you think about the merits of including this functionality
> in ls-files I think your stance of this being a no-go for adding to the
> builtin is based on a false premise. It's fine to have
> unstable/transitory/debug output in the builtins. We just name &
> document them as such.
>
> I also had some feedback in that series and on the earlier iteration
> that I think is appropriate to be incorporated into a re-roll of this
> one, which doesn't have anything to do with the question of whether we
> use ls-files or the helper in the tests. Such as us showing more stuff
> into the read-cache.c test-tool v.s. splitting it up making that code
> needlessly convoluted.

Well:
  * you seem to be strongly opposed to test-read-cache.c containing
this code (though I don't quite follow why)
  * Stolee seems to be strongly opposed to modifying
builtin/ls-files.c until he has time to think through how builtins
should work.

So putting it in another test file that looks slightly duplicative of
test-read-cache.c might indeed be a good way out of this conundrum.
:-)

(I'm not opposed to any of the three solutions, I'm mostly chiming in
here because I'm worried about possible bubbling frustration; see
below.)

> I don't see how recommending that I pursue that as an independent series
> is productive for anyone. So as you re-roll this I should submit another
> series on top to refactor your in-flight code & tests?

Your tone suggests some frustration; I have a suspicion there's some
lack of understanding or misreading that has occurred (perhaps on my
part too), and before that misunderstanding morphs into motive
questioning, let me see if I might be able to help...

So far, you have advocated for:
  A) Moving the checks to ls-files with a permanent new flag (--sparse)
  B) Duplicating test-read-cache.c (which is admittedly pretty small)
and then modifying the duplicate to have the new behavior, or
alternatively:
  C) Just stating files to get the information
  D) Creating new debug option(s) to ls-files so that end users can
use this in the next few releases before the feature is ready for
prime time
You also mentioned you had read just part of the series.

Option D comes with the problem that it's not at all clear who these
end-users are, why they want the option, or how we should design it.
Personally, I'm totally onboard that ls-files should generally have
the ability to show information in the index (e.g. if there are tree
entries in addition to blob entries, it should be able to show both),
but I'm not following the reasoning for why it needs to be there as
part of the early stages of development of the sparse-index feature
and who it's supposed to be helping in these next few releases.

The progression also suggests that Option B might have just been a
step along the way and that you were advocating for Option D now.  I
think it'd be easy to miss that you still had option B open and
considered it equivalently good to option D (or am I misreading?),
much like you missed how option C wasn't even relevant to the problem
at hand or option A would have introduced perpetual confusion as a
mere duplicate of --stage (in the best case scenario, anyway).
They're all easy misunderstandings.

> Either my suggestions are just bad, and we shouldn't do them at all, or
> it makes sense to incorporate relevant feedback in re-rolls. I'll let
> other reviewers draw their own conclusions on that.

I think that's a bit unfair; Stolee has been incorporating feedback.
He even called out fixing up things at your suggestion in v4 of his
re-roll.

> That's not a snarky "I'm right" b.t.w., I may honestly be full of it on
> this particular topic.
>
> But if those suggested changes are worth doing at all, then doing them
> in that way seems like a massive waste of time for everyone involved, or
> maybe I'm not getting what you're suggesting by pursuing them as an
> independent series.

I think you should instead read it as he has no idea why this needs to
be exposed in ls-files, who these users are you are asserting will be
using it, or how to cater for their needs.  Shouldn't the person who
implements this understand those pieces to avoid a massive waste of
time?

> > Otherwise, I will need to eventually handle "git ls-files" being
> > sparse-aware when eventually removing 'command_requires_full_index',
> > (Phase 4) so that would be a good opportunity to adjust the
> > expectations.
>
> At which point you'd be adjusting your tests that expect ls-tree format
> output to using ls-files output, instead of using ls-files-like output
> from the beginning?

I don't understand what you're getting at here.  I was the one who
requested Stolee make the output look like ls-trees in his original
RFC series, so if there's a problem with this style of output, I'm to
blame.  But, what is exactly the problem?  Old-style ls-files output
just isn't relevant anymore.  ls-tree prints four things: mode, type,
hash, and filename.  ls-files prints all of those except "type".  The
reason ls-files never included type before was because it was always
"blob".  This series changes that, and adds "tree" to the mix.  Once
you have different types included in the index, then ls-files has to
print all the same fields that ls-tree does...so why not make it look
similar?

> At the end of this E-Mail is a patch on top that adds an undocumented
> --debug-sparse in addition to the existing --debug. Running that in the
> middle of one of your tests:
>
>     $ ~/g/git/git ls-files --debug -- a folder1
>     a
>       ctime: 1616641434:474004002
>       mtime: 1616641434:474004002
>       dev: 2306     ino: 28576528
>       uid: 1001     gid: 1001
>       size: 8       flags: 0
>     folder1/a
>       ctime: 0:0
>       mtime: 0:0
>       dev: 0        ino: 0
>       uid: 0        gid: 0
>       size: 0       flags: 40000000
>     $ ~/g/git/git ls-files --debug --debug-sparse -- a folder1
>     a
>       ctime: 1616641434:474004002
>       mtime: 1616641434:474004002
>       dev: 2306     ino: 28576528
>       uid: 1001     gid: 1001
>       size: 8       flags: 0
>     folder1/
>       ctime: 0:0
>       mtime: 0:0
>       dev: 0        ino: 0
>       uid: 0        gid: 0
>       size: 0       flags: 40004000
>     $ ~/g/git/git ls-files --stage -- a folder1
>     100644 e79c5e8f964493290a409888d5413a737e8e5dd5 0       a
>     100644 e79c5e8f964493290a409888d5413a737e8e5dd5 0       folder1/a
>     $ ~/g/git/git ls-files --stage --debug-sparse -- a folder1
>     100644 e79c5e8f964493290a409888d5413a737e8e5dd5 0       a
>     040000 f203181537ff55dcf7896bf8c5b5c35af1514421 0       folder1/
>
> I.e. it gives you everything your helper does and more with a trivial
> addition of a --debug-sparse (which we can later just remove, it's a
> debug option...).
>
> See e.g. my recent 15c9649730d (grep/log: remove hidden --debug and
> --grep-debug options, 2021-01-26) which is already in a release, and
> AFAICT nobody has noticed or cared.
>
> I don't know if that's the stat() information you wanted (your WIP
> branch doesn't have such a change), but presumably it either is the info
> you want, or ls-files's --debug would want to emit any such such info
> that's now missing too.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 13bcc2d8473..e691512d4f8 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -34,6 +34,7 @@ static int show_valid_bit;
>  static int show_fsmonitor_bit;
>  static int line_terminator =3D '\n';
>  static int debug_mode;
> +static int debug_sparse_mode;
>  static int show_eol;
>  static int recurse_submodules;
>  static int skipping_duplicates;
> @@ -242,9 +243,17 @@ static void show_ce(struct repository *repo, struct =
dir_struct *dir,
>                 if (!show_stage) {
>                         fputs(tag, stdout);
>                 } else {
> +                       unsigned int mode =3D ce->ce_mode;
> +                       if (debug_sparse_mode && S_ISSPARSEDIR(mode))
> +                               /*
> +                                * We could just do & 0177777 all the
> +                                * time, just make it clear this is
> +                                * for --debug-sparse.
> +                                */
> +                               mode &=3D 0177777;
>                         printf("%s%06o %s %d\t",
>                                tag,
> -                              ce->ce_mode,
> +                              mode,
>                                find_unique_abbrev(&ce->oid, abbrev),
>                                ce_stage(ce));
>                 }
> @@ -667,6 +676,7 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
>                         N_("pretend that paths removed since <tree-ish> a=
re still present")),
>                 OPT__ABBREV(&abbrev),
>                 OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data=
")),
> +               OPT_BOOL(0, "debug-sparse", &debug_sparse_mode, N_("show =
sparse debugging data")),
>                 OPT_BOOL(0, "deduplicate", &skipping_duplicates,
>                          N_("suppress duplicate entries")),
>                 OPT_END()
> @@ -681,9 +691,6 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
>                 prefix_len =3D strlen(prefix);
>         git_config(git_default_config, NULL);
>
> -       if (repo_read_index(the_repository) < 0)
> -               die("index file corrupt");
> -
>         argc =3D parse_options(argc, argv, prefix, builtin_ls_files_optio=
ns,
>                         ls_files_usage, 0);
>         pl =3D add_pattern_list(&dir, EXC_CMDL, "--exclude option");
> @@ -700,6 +707,10 @@ int cmd_ls_files(int argc, const char **argv, const =
char *cmd_prefix)
>                 tag_skip_worktree =3D "S ";
>                 tag_resolve_undo =3D "U ";
>         }
> +       if (debug_sparse_mode) {
> +               prepare_repo_settings(the_repository);
> +               the_repository->settings.command_requires_full_index =3D =
0;
> +       }
>         if (show_modified || show_others || show_deleted || (dir.flags & =
DIR_SHOW_IGNORED) || show_killed)
>                 require_work_tree =3D 1;
>         if (show_unmerged)
> @@ -743,6 +754,12 @@ int cmd_ls_files(int argc, const char **argv, const =
char *cmd_prefix)
>                 max_prefix =3D common_prefix(&pathspec);
>         max_prefix_len =3D get_common_prefix_len(max_prefix);
>
> +       /*
> +        * Read the index after parse options etc. have had a chance
> +        * to die early.
> +        */
> +       if (repo_read_index(the_repository) < 0)
> +               die("index file corrupt");
>         prune_index(the_repository->index, max_prefix, max_prefix_len);
>
>         /* Treat unmatching pathspec elements as errors */
