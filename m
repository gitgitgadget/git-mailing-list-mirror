Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDFBC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiFMWjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiFMWjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3D627D
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so8841374wra.5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4aDESi5mxBMrQ7OfnBCnHxItOAykOs0LN/Uv+i7eco=;
        b=drkcaAdOhxKYE641hrW5LnuXrh00OfVjfY6m1N9FOzceJhhqYFOwnFSji2q1/G7Biq
         lZuBBLJBlfUlpB9WolDDRzObpfX39AH1To4j6OLMKLNjoX6yly4iq/VJYtvVBk3lAL8Q
         ZkBY7RMXLT+kPtITAgAjVC/3lRykZBwRIXxEcI+zGJTyt59hyWmtrQO5d51Bb8BAj8D2
         YQS+eidKefS0Y5RDusVilNvKkqeyL/1phnlb0NeI+NVr6h8mq2ms8IfkIT9hULQ1/XX2
         IjrpqHF5PX7Axx+96D5PJZBZ1+jpeWQJbICegllHE1W4RTPxYkLqex9B68c5YaL6LZ7v
         TjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4aDESi5mxBMrQ7OfnBCnHxItOAykOs0LN/Uv+i7eco=;
        b=cJrrCPgj2kZZwY5E7+b86EVLvb4xXiyjOLBhgGnBbTbwuxdtncWJOavlKFuub9EDb9
         jMBLF4VSQlCiaBUbu5l+rO6c9l16dlegapm7uTVidYSYu1ShCM2PE41Pp0VxQ+U1/jRS
         5FVrHLfiSCkaoH1MJFn9uBaIp64hsmOub4sRl77fUpTn4bLUp1TNyGtFnaTO303gl2Dd
         g/Gfqjx5fGPFRFiKZMQ5mUmAd/eUgv5o9X3sbL43MELohb6ceRGmdw6qna+a1w81Z/yl
         icUIMnWzIcHRebBj3vqfdsxOaohQU7+VkUtXm4/fY37huLs2xN6JVnRwe6XOQuNiOavN
         pnfA==
X-Gm-Message-State: AJIora/j1Jy3SEUt5lMa3W8EM5El7qKoIdfsKWBI36iogAL5LxVM3KpW
        do9IwSlL4Dg1dqZFMvfYf50t1NVVlATK9g==
X-Google-Smtp-Source: AGRyM1ubLBb1lESZV/pvwE3OK3k6+5jQ1teJhMvgjqvlbg3CCXK+IylRbNL5FMJ2TGa8t/aMOnAgtQ==
X-Received: by 2002:a05:6000:2a4:b0:219:2aad:51ce with SMTP id l4-20020a05600002a400b002192aad51cemr1795292wry.719.1655159946943;
        Mon, 13 Jun 2022 15:39:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/12] submodule: make "git submodule--helper" behave like "git submodule"
Date:   Tue, 14 Jun 2022 00:38:51 +0200
Message-Id: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series:

 * Removes dead code from git-submodule.sh, or dead code where it was
   the last user.

 * Simplifies CLI parsing in git-submodule.sh, where it was doing
   something overly complex for no reason.

 * Brings "git submodule--helper" in line with the CLI interface of
   "git-submodule.sh", for a follow-up series to remove the latter, as
   we'll be able to make a new "git submodule" in C dispatch directly
   to our new "git submodule--helper" code.

 * Removes the "-v" option to "git submodule", which has been
   supported, but was a) never documented b) never did anything
   anyway, except as a way to negate an earlier "--quiet" option, as
   "verbose" was always the default.

 * The last couple of patches are cleanup that isn't strictly
   neccesary for the end-goal of "git submodule" in C, but cleans up
   some more shellscript code.

   The "say" function is removed from "git-sh-setup.sh", now that
   "git-submodule.sh" doesn't use it anymore (which happened before
   this series) we can replace the couple of remaining uses with
   "echo", and by having "git-subtree.sh" own the code that used to
   live in "git-sh-setup.sh".

The approach here was to combine bits of the two RFC series' Glen and
I sent out:

 - https://lore.kernel.org/git/pull.1275.git.git.1654820781.gitgitgadget@gmail.com/
 - https://lore.kernel.org/git/RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com/

My branch for this (and passing CI) are at:
https://github.com/avar/git/tree/avar/submodule-sh-dispatch-to-helper-directly-prep

The rest here is a reply to
https://lore.kernel.org/git/kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com/:

On Mon, Jun 13 2022, Glen Choo wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> [...]
>> That's quite the timing coincidence. I hacked this up yesterday,
>> thinking that the submodule topic had been too quiet for a while, and
>> wondering how hard it was to convert the rest of git-submodule.sh.
>>
>> It's more than 2x the length of yours, but gets to the point where we
>> can "git rm git-submodule.sh".
>
> Very cool. I've skimmed through all of the patches, which mostly look
> good except for ~1-2 things.
>
> Your series shows that there isn't any prohibitively difficult work left
> to finish the conversion, which is great! The real problem IMO is the
> potential for mechanical errors given how many lines this touches.

Yes, and as I've discovered in some further poking at the follow-up
work (not included here) we again lack quite a bit of testing.

> Here's a way of breaking apart the work that makes sense to me:
>
> - Reuse the patches that prepare git-submodule.sh for the conversion,
>   particularly 1-7/20 (create a "case" dispatch statement and its
>   preceding patches).
> - Keep my series that prepares "update", since that's the most tedious
>   one to convert. If I don't dispatch to the "case" statement, I don't
>   think it will even conflict with the preparatory series.
>
>   Some of your patches make more sense than mine, and I'll incorporate
>   them as necessary :)
> - Dispatch subcommands using the "case" dispatch, including "update". We
>   might have to do this slowly if we want things to be easy to eyeball.
> - "git rm git-submodule.sh"!

Hopefully there's no stepping on toes here, but I thought I'd send
this out now (I went back to the laptop) to avoid the duplicate work,
since I'd already attempted combining the two, and this is the result.

Obviously you may have different ideas about it, and I wouldn't at all
mind a v3 that goes in a different direction if you think it's needed.

As noted in the CL above I think this is more palatable for an initial
iteration, i.e. it's not doing any of the migration work yet, but
merely doing small changes to bring git-submodule.sh and "git
submodule--helper" in line with one another.

>>>   submodule--helper update: use one param per type
>>
>> Same as my 13/20, but I ended up doing it in a more narrow/smaller
>> way. I tried your way and ran into some bug, then figured I'd do it
>> more narrowly instead of debugging it.
>
> Yeah your approach is easier to eyeball, so I'll do this instead.

Hopefully you'll like the change I made here, I kept my commit which
narrowlry changes it so that we pass --checkout, --merge and --rebase
from git-submodule.sh.

Then after that comes a commit extracted from your change where we
make "git submodule--helper" use the same interface for passing
options to itself.

Both are good changes to make, but I think it makes sense to split
them up. One is needed for "git submodule" in C, the other is just
janitorial work in the "git submodule--helper" code.

I think it makes sense to do both, but splitting up the concerns makes
it a lot easier to review them IMO.

>>>   submodule update: remove -v, pass --quiet
>> [...]
>> I think at this point I've talked myself into "let's just remove it",
>> but maybe...
>
> On hindsight, what I did is definitely cheating ;)

Your removal of "-v" is in this series. I rewrote the commit message
to note exactly what we're changing, why it's thought to be OK etc.

> My series also breaks the way we'd handle --quiet in "git submodule",
> i.e.
>
>    git submodule --quiet update
>
> should be quiet, but isn't.
>
> Your approach actually handles --quiet as per the original shell script,
> which is a good enough reason to do it your way. We can think about
> removing it later.

We have some of these unfortunate "top-level" CLI options in other
places, e.g. "git commit-graph", it's probably not worth it to remove
them, as they're easy enough to support, and have been documented for
a long time.

>> Brief commentary on my patches, details in commit messages:
>>
>> Ævar Arnfjörð Bjarmason (20):
>>   git-submodule.sh: remove unused sanitize_submodule_env()
>>   git-submodule.sh: remove unused $prefix variable
>>   git-submodule.sh: remove unused --super-prefix logic
>>
>> I removed a bit more dead code here than yours.
>>
>>   git-submodule.sh: normalize parsing of "--branch"
>>   git-submodule.sh: normalize parsing of --cached
>>
>> This & various other prep commits (hereafter "easy prep") make
>> subsequent one-time conversions of whole cmd_*() easier.
>>
>>   submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>>   git-submodule.sh: create a "case" dispatch statement
>>
>> easy prep
>
> This would all make sense in a preparatory series, with the exception of 
> 3/20 git-submodule.sh: remove unused --super-prefix logic.
>
> We have several instances where we invoke submodule--helper directly
> with --super-prefix, e.g. inside sync_submodule():
>     
>     if (flags & OPT_RECURSIVE) {
>       struct child_process cpr = CHILD_PROCESS_INIT;
>
>       cpr.git_cmd = 1;
>       cpr.dir = path;
>       prepare_submodule_repo_env(&cpr.env_array);
>
>       strvec_push(&cpr.args, "--super-prefix"); /* Here */
>
> I even have a (as of now private) patch that replaces "update"'s
> --recursive-prefix with --super-prefix.
>
> This probably wasn't caught in the tests because this only affects how
> we calculate the submodule 'displayname'.

This is still in this series as 02/12. I think you've misunderstood
that code, it *is* invoking "git submodule--helper" with
"--super-prefix", but the option is passed as:

    git --super-prefix <path> submodule--helper

And not as:

    git submodule--helper --super-prefix <path>

This is thus handled by other code before builtin/submodule--helper.c,
and it doesn't need to handle it.

But anyway, this is confusing, so I updated the commit message (seen
in the range-diff below)>

>>   submodule--helper: pretend to be "git submodule" in "-h" output
>>
>> easy prep & bug fix for existing (on master) output bugs.
>>
>>   git-submodule.sh: dispatch "sync" to helper
>>   git-submodule.sh: dispatch directly to helper
>>   git-submodule.sh: dispatch "foreach" to helper
>>
>> These are easy conversions as the options 1=1 map after the above
>> prep.
>
> Yes, these are pretty easy. I'm worried about the number of lines
> changed and the potential for mechanical errors, but we can roll these
> more slowly if necessary.

All of this is left out here for now. FWIW I don't think it's hard to
review due to the line count, yes e.g. the 2nd patch there is ~300
lines changed, but it's just 5 lines removed/added if we omit the
mechanical deletion of the now-unused functions.

Maybe it would be better to omit that and do just one "git rm" at the
end? FWIW I thought doing it atomically so that we were left with no
dead code after each step made it easier to review.

>>   submodule--helper: have --require-init imply --init
>>   submodule--helper: understand --checkout, --merge and --rebase
>>     synonyms
>>   git-submodule doc: document the -v" option to "update"
>>   submodule--helper: understand -v option for "update"
>>
>> not-so-easy prep for "cmd_update()"
>>
>>   git-submodule.sh: dispatch "update" to helper
>>
>> Full cmd_update() migration in one go.
>
> Yeah, and since it's not-so-easy, it probably makes sense to continue to
> keep my series around. I'll borrow some of these patches if that's ok :)

The proposal in *this series* is to leave this aside for now, but
generally I wonder what part of it you find not-so-easy.

Personally I find it much harder to carefully review the way you
proposed to do it, i.e. to "buffer up" options that we "don't handle",
but actually need to sort-of handle, as we'd still like to die if we
have unknown options.

Particularly since shellscript quoting etc. is a pain with that sort
of thing, as it doesn't have any real list or key-value
datastructures.

Whereas getting it to the point where we're clearly just passing
options as-is through beforehand, and then simply dropping the wrapper
is, I think, much easier to review. You only need to trust or check
that e.g. "git submodule--helper update" also supports a "--progress"
option or whatever, and/or that we've got coverage for it.

>> [...]
>> Wait, a useBuiltin setting to switch between two built-ins? Yeah,
>> maybe it makes little sense, but here we get rid of the run_command()
>> overhead, and could generally use the built-in to experiment with
>> deeper integration between the two.
>>
>> ...
>
> Interesting approach. It looks ok to me, but if we break up this series,
> maybe this will be stale by the time we integrate the rest of the
> changes?

Yes, I think it's probably best to drop this idea of a useBuiltin
setting in this case entirely.

The reason we did it for "stash", "git add --interactive" etc. is that
we were (or are) dispatching to drastically different code, i.e. we
had or have an entire all-at-once re-implementation of the command or
feature.

Whereas for "git submodule" we've been doing it incrementally already,
and complexity-wise I think previous rounds to migrate to "git
submodule--helper" were much more likely have subtle breakages than
the relatively straightforward migration we've got left.

B.t.w. here is my WIP re-roll of the full thing, on top of these
patches:
https://github.com/avar/git/tree/avar/submodule-sh-dispatch-to-helper-directly-2

As covered in amended commits & tests there the v1 RFC (but not the
parts re-rolled here, just the later stuff) had some subtle behavior
changes. See the new "submodule tests: test usage behavior" commit
there & follow-ups to that.

I haven't found any bad bugs yet, but just obscure edge cases in
e.g. how we handle "git submodule --" before/after.

Glen Choo (2):
  submodule update: remove "-v" option
  submodule--helper: eliminate internal "--update" option

Ævar Arnfjörð Bjarmason (10):
  git-submodule.sh: remove unused sanitize_submodule_env()
  git-submodule.sh: remove unused $prefix var and --super-prefix
  git-submodule.sh: make "$cached" variable a boolean
  git-submodule.sh: remove unused top-level "--branch" argument
  submodule--helper: have --require-init imply --init
  submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
  submodule--helper: report "submodule" as our name in "-h" output
  submodule--helper: understand --checkout, --merge and --rebase
    synonyms
  git-submodule.sh: use "$quiet", not "$GIT_QUIET"
  git-sh-setup.sh: remove "say" function, change last users

 builtin/submodule--helper.c    | 127 +++++++++++++++++----------------
 contrib/subtree/git-subtree.sh |  15 +++-
 git-instaweb.sh                |   2 +-
 git-sh-setup.sh                |  16 -----
 git-submodule.sh               |  88 ++++++++---------------
 submodule.c                    |   2 +-
 t/t7406-submodule-update.sh    |   2 +-
 7 files changed, 112 insertions(+), 140 deletions(-)

Range-diff against v1:
 1:  0e9f13822ef !  1:  c5afc72e075 git-submodule.sh: remove unused sanitize_submodule_env()
    @@ Metadata
      ## Commit message ##
         git-submodule.sh: remove unused sanitize_submodule_env()
     
    -    The sanitize_submodule_env() function was last used in
    +    The sanitize_submodule_env() function was last used before
         b3c5f5cb048 (submodule: move core cmd_update() logic to C,
         2022-03-15), let's remove it.
     
 2:  8fcd832e58f <  -:  ----------- git-submodule.sh: remove unused $prefix variable
 3:  6c774505ac5 !  2:  e127803d59d git-submodule.sh: remove unused --super-prefix logic
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: remove unused --super-prefix logic
    +    git-submodule.sh: remove unused $prefix var and --super-prefix
     
    -    The "$prefix" variable has not been set since b3c5f5cb048 (submodule:
    -    move core cmd_update() logic to C, 2022-03-15), so we'd never pass the
    +    Remove the $prefix variable which isn't used anymore, and hasn't been
    +    since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
    +    2022-03-15).
    +
    +    Before that we'd use it to invoke "git submodule--helper" with the
    +    "--recursive-prefix" option, but since b3c5f5cb048 that "git
    +    submodule--helper" option is only used when it invokes itself.
    +
    +    Since we haven't used it since then we haven't been passing the
         --super-prefix option to "git submodule--helper", and can therefore
         remove the handling of it from builtin/submodule--helper.c as well.
     
    +    Note also that the still-existing code in builtin/submodule--helper.c
    +    to invoke other "git submodule--helper" processes with
    +    "--super-prefix" is not passing the option to
    +    "cmd_submodule__helper()", rather it's an argument to "git" itself.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc, const char **ar
      
      	die(_("'%s' is not a valid submodule--helper "
      	      "subcommand"), argv[1]);
    +
    + ## git-submodule.sh ##
    +@@ git-submodule.sh: files=
    + remote=
    + nofetch=
    + update=
    +-prefix=
    + custom_name=
    + depth=
    + progress=
    +@@ git-submodule.sh: cmd_add()
    + 		usage
    + 	fi
    + 
    +-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
    ++	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
    + }
    + 
    + #
    +@@ git-submodule.sh: cmd_init()
    + 		shift
    + 	done
    + 
    +-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
    ++	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
    + }
    + 
    + #
    +@@ git-submodule.sh: cmd_update()
    + 		${init:+--init} \
    + 		${nofetch:+--no-fetch} \
    + 		${wt_prefix:+--prefix "$wt_prefix"} \
    +-		${prefix:+--recursive-prefix "$prefix"} \
    + 		${update:+--update "$update"} \
    + 		${reference:+"$reference"} \
    + 		${dissociate:+"--dissociate"} \
 5:  124c062e3a1 !  3:  d5c8613c654 git-submodule.sh: normalize parsing of --cached
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: normalize parsing of --cached
    +    git-submodule.sh: make "$cached" variable a boolean
     
         Remove the assignment of "$1" to the "$cached" variable. As seen in
         the initial implementation in 70c7ac22de6 (Add git-submodule command,
         2007-05-26) we only need to keep track of if we've seen the --cached
    -    option. In 28f9af5d25e (git-submodule summary: code framework,
    -    2008-03-11) "$1" was assigned to it, but there was no reason to do
    -    so. Let's undo that.
    +    option, not save the "--cached" string for later use.
    +
    +    In 28f9af5d25e (git-submodule summary: code framework, 2008-03-11)
    +    "$1" was assigned to it, but since there was no reason to do so let's
    +    stop doing it. This trivial change will make it easier to reason about
    +    an eventual change that'll remove the cmd_summary() function in favor
    +    of dispatching to "git submodule--helper summary" directly.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ git-submodule.sh: cmd_summary() {
      		--files)
      			files="$1"
     @@ git-submodule.sh: do
    - 		GIT_QUIET=1
    + 		branch="$2"; shift
      		;;
      	--cached)
     -		cached="$1"
 4:  f27723aa0a2 !  4:  fd328329b68 git-submodule.sh: normalize parsing of "--branch"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: normalize parsing of "--branch"
    +    git-submodule.sh: remove unused top-level "--branch" argument
     
         In 5c08dbbdf1a (git-submodule: fix subcommand parser, 2008-01-15) the
         "--branch" option was supported as an option to "git submodule"
    @@ Commit message
         "--cache" added (or rather modified) in 496eeeb19b9 (git-submodule.sh:
         avoid "test <cond> -a/-o <cond>", 2014-06-10).
     
    -    But there's been a logic error in that check, this looked like it
    -    should be supporting:
    +    But there's been a logic error in that check, which at a glance looked
    +    like it should be supporting:
     
             git submodule --branch <branch> (add | set-branch) [<options>]
     
    @@ Commit message
         we have "--branch" here already we'll emit usage, even for "add" and
         "set-branch".
     
    -    Since nobody's complained about "--branch <branch>" not being
    -    supported as argument to "git submodule" itself, i.e. we want to
    -    support:
    +    So in addition to never having documented this form it hasn't worked
    +    since b57e8119e6e was released with v2.22.0 it's safe to remove this
    +    code. I.e. we don't want to support the form noted above, but only:
     
    -        git submodule (add | set-branch) --branch <branch>  [<options>]
    -
    -    But not the first form noted above. Let's just remove this code, we've
    -    never documented "--branch" as a top-level option (unlike "--quiet"),
    -    so this looks like it was an accident of the implementation, which we
    -    broke v2.22.0, so we also know it must not have been important to
    -    anyone.
    +        git submodule (add | set-branch) --branch <branch> [<options>]
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ git-submodule.sh: do
     -		branch="$2"; shift
     -		;;
      	--cached)
    - 		cached="$1"
    + 		cached=1
      		;;
     @@ git-submodule.sh: then
          fi
12:  57b9df29ea6 !  5:  ef3265a588e submodule--helper: have --require-init imply --init
    @@ Commit message
         --require-init option imply --init, rather than having
         "git-submodule.sh" add it implicitly.
     
    +    This change doesn't make any difference now, but eliminates another
    +    special-case where "git submodule--helper update"'s behavior was
    +    different from "git submodule update". This will make it easier to
    +    eventually replace the cmd_update() function in git-submodule.sh.
    +
    +    We'll still need to keep the distinction between "--init" and
    +    "--require-init" in git-submodule.sh. Once cmd_update() gets
    +    re-implemented in C we'll be able to variables and other code related
    +    to that, but not yet.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 -:  ----------- >  6:  025694644fc submodule update: remove "-v" option
 6:  b1ca1183885 !  7:  63155ab5026 submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
    @@ Commit message
         absorb-git-dir function, 2016-12-12).
     
         Having these two be different will make it more tedious to dispatch to
    -    "git submodule--helper" directly, so let's get rid of this needless
    +    eventually dispatch "git submodule--helper" directly, as we'd need to
    +    retain this name mapping. So let's get rid of this needless
         inconsistency.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ submodule.c: void absorb_git_dir_into_superproject(const char *path,
      			     "submodule--helper",
     -			     "absorb-git-dirs", NULL);
     +			     "absorbgitdirs", NULL);
    - 		prepare_submodule_repo_env(&cp.env_array);
    + 		prepare_submodule_repo_env(&cp.env);
      		if (run_command(&cp))
      			die(_("could not recurse into submodule '%s'"), path);
 7:  9f5cfbb864a <  -:  ----------- git-submodule.sh: create a "case" dispatch statement
 8:  0c1a5063653 !  8:  99ac52d810f submodule--helper: pretend to be "git submodule" in "-h" output
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: pretend to be "git submodule" in "-h" output
    +    submodule--helper: report "submodule" as our name in "-h" output
     
    -    Change the usage output for "git submodule--helper" so that it will
    -    pretend to be named "git submodule". This will allow us to dispatch
    -    further into "git submodule--helper" from git-submodule.sh while
    -    emitting the correct usage output.
    +    Change the rest of the usage output for "git submodule--helper" so
    +    that it will pretend to be named "git submodule", which it already did
    +    e.g. in the case of "status", "deinit" and "update".
    +
    +    This will allow us to eventually dispatch further into "git
    +    submodule--helper" from git-submodule.sh, while emitting the correct
    +    usage output.
    +
    +    This does make the usage output of "git submodule--helper" itself
    +    "incorrect", but since nothing user-facing invokes it directly it
    +    makes sense to continue to elide that difference entirely. A user
    +    isn't served by us exposing this internal implementation detail.
     
         This fixes a bug that's been there ever since "git submodule
         absorbgitdirs" was added in f6f85861400 (submodule: add absorb-git-dir
    @@ Commit message
                 usage: git submodule absorbgitdirs [<options>] [<path>...]
                 [.. same usage output ...]
     
    -    Note that in the case of "status", "deinit" and "update" we were
    -    already referring to ourselves as "git submodule" in
    -    builtin/submodule--helper.c.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 9:  bd0e4a4f8b8 <  -:  ----------- git-submodule.sh: dispatch "sync" to helper
10:  498a1fd275b <  -:  ----------- git-submodule.sh: dispatch directly to helper
11:  625320e13b9 <  -:  ----------- git-submodule.sh: dispatch "foreach" to helper
13:  20db979a094 !  9:  01c5eee67c7 submodule--helper: understand --checkout, --merge and --rebase synonyms
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
     +			SM_UPDATE_MERGE),
     +		OPT_SET_INT('r', "rebase", &update_type,
     +			N_("use the 'rebase' update strategy"),
    -+			SM_UPDATE_MERGE),
    ++			SM_UPDATE_REBASE),
      		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
      			   N_("reference repository")),
      		OPT_BOOL(0, "dissociate", &opt.dissociate,
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      						    &opt.update_strategy) < 0)
     
      ## git-submodule.sh ##
    -@@ git-submodule.sh: init=
    - require_init=
    +@@ git-submodule.sh: require_init=
    + files=
      remote=
      nofetch=
     -update=
     +rebase=
     +merge=
     +checkout=
    + custom_name=
      depth=
      progress=
    - dissociate=
     @@ git-submodule.sh: cmd_update()
      			force=$1
      			;;
14:  1cb40a5f42e <  -:  ----------- git-submodule doc: document the -v" option to "update"
15:  0c388eed1d1 <  -:  ----------- submodule--helper: understand -v option for "update"
16:  08abadda7c3 <  -:  ----------- git-submodule.sh: dispatch "update" to helper
17:  59a72296967 <  -:  ----------- git-submodule.sh: use "$quiet", not "$GIT_QUIET"
18:  c5796878f0b <  -:  ----------- git-submodule.sh: simplify parsing loop
19:  1423950de08 <  -:  ----------- submodule: make it a built-in, remove git-submodule.sh
20:  b2aaad5c008 <  -:  ----------- submodule: add a subprocess-less submodule.useBuiltin setting
 -:  ----------- > 10:  ac00a9599de submodule--helper: eliminate internal "--update" option
 -:  ----------- > 11:  875acae8550 git-submodule.sh: use "$quiet", not "$GIT_QUIET"
 -:  ----------- > 12:  31517345ae8 git-sh-setup.sh: remove "say" function, change last users
-- 
2.36.1.1239.gfba91521d90

