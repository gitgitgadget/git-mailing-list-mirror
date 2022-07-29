Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A66C19F2A
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiG2T3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiG2T3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB35F11C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m13so3183336wrq.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zRe+c26NX/jt2YLc31abVNgVt4yiW6mdqLiqH2ts6Wo=;
        b=N5j5G+s6mvy6ozMgMS4YEqjSoRHj+2b/f6/6w7CqxiKd5ZprRPtIdJXVzBur9ERIq9
         WRypI6ZPT4ejrJJa5GCT5VmoXzVY1oCi1qZEBmFpQrZ/888IhZPOikCwVgsNrqL+6JzZ
         JJ0YRhwbqqIQ7Pfnx9OS++0DZR9m8nERJJM/CuGjftZ4KQFZC7Nav6smdhCBzv6snYpw
         mBnWk9LiM3kRaS/fwNmLs4c7RArUjL8qI4bzMd/cowP9qzISF9DtukHNdO6WfvW/kEy3
         PPgMvlHWT+lxxgiqJbQIXpL63rtkXOlPqu6E0ZXB613+HRtPBTQYb82Lb4xl3d4XiZiL
         5jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zRe+c26NX/jt2YLc31abVNgVt4yiW6mdqLiqH2ts6Wo=;
        b=ZwBzydbdpgVJqPtaFkJa0C8rxhtgI2XspX7VlLRfpGnTXxL8jsvx3Ge8A7obnb1qr5
         AsmSErjh5J7kIsLYuyDOs8B5yM9VvyQKVVauCAdq0WpG4cJFPqjMQxGz6IKPQfhe9+vO
         QkmXwJXio0c1EYQk+G9rZea9+dWFQPpKpazRzlPZc3prwTsVWLh2uVdJsk7GAnwU8Az9
         RvMJUYsslbSrO2AdX9lLrNqTHJDzPwjsZlmx5XvITApdYpxKV3YMaIILL1KxsvL16M9f
         xfrlkfepSVwaSdB3Oud1iwocSqGkw59HrAVB6j/KKKoQWjhlsV6XB/n/BMf5K/U+AIBD
         w2Ig==
X-Gm-Message-State: ACgBeo18ZgWqO883PyMwbwoNfQ2LvD/1LGyhJlK91nTi5DZe4Rf5b8yA
        ggRPHCl2bnlv6GXXK5ObwMVRJDqwTR8=
X-Google-Smtp-Source: AA6agR5viOIS19/oVHycMvqdYhy1ID7083wi21e063ryU/N5vl12JDg72I9ATC3gEGhVNR41cgToPQ==
X-Received: by 2002:a5d:52c4:0:b0:21e:428a:912b with SMTP id r4-20020a5d52c4000000b0021e428a912bmr3315172wrv.395.1659122980948;
        Fri, 29 Jul 2022 12:29:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020adfe507000000b0021d65675583sm4511411wrm.52.2022.07.29.12.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:40 -0700 (PDT)
Message-Id: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:29 +0000
Subject: [PATCH v2 00/10] log: create tighter default decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git log', the default is to report any refs within refs/* as
decorations. This series reduces the default set to be more specific to a
set of known-useful namespaces.

This was previously reduced by adding the log.excludeDecoration config
option and modifying that config in git maintenance's prefetch task (to hide
refs/prefetch/*). I then followed that pattern again for the bundle URI
feature [1], but this caught some reviewers by surprise as an unfortunate
side-effect. This series is a way to roll back the previous decision to use
log.excludeDecoration and instead use tighter filters by default.

[1]
https://lore.kernel.org/git/a217e9a0640b45d21ef971d6e91cee3f1993f383.1656535245.git.gitgitgadget@gmail.com/

The current design ignores the new filters if there are any
previously-specified filters. This includes the
log.excludeDecorations=refs/prefetch/ set by the git maintenance command.
This means that users who ran that command in their repo will not get the
benefits of the more strict filters. While we stop writing
log.excludeDecorations, we don't remove existing instances of it. This
should be fine at least for the refs/bundles/ namespace in the future, since
those refs will typically be created for new clones that have not yet had
the log.excludeDecoration setting.

To make it easy for users to opt-in to the previous behavior, add a new git
log --decorate-all option and log.decorateFilter=all config option.


Updates in v2
=============

 * As discussed in the previous version, there are a lot of places that care
   about different subsets of the special ref namespaces. This version
   creates a new ref_namespaces array that centralizes and describes how
   these known ref namespaces interact with other Git features.

 * Some patches are added to help centralize previously-unrelated features
   onto the ref_namespaces array.

 * One thing that I noticed while doing this work was that notes come from a
   commit history that is pointed by a single ref, not multiple refs in a
   namespace. Also, that ref can change based on config and environment
   variables. This version updates that knowledge to allow our
   ref_namespaces[NAMESPACE_NOTES] value change with these settings. Since
   there is only one ref, I also chose to remove it from the default
   decorations. As Junio mentioned, this should not make any difference
   since a user won't see it unless they purposefully start git log from the
   notes ref.

 * Despite feedback to the opposite, I maintain my opinion that this default
   filter should be a small list of known-useful namespaces. For expert
   users who use other namespaces, I added patches that make it easier to
   show custom namespaces (specifically --decorate-all and
   log.decorateFilter=all). The logic for creating the default filter now
   uses the ref_namespaces array in such a way that it would be simple to
   reverse this decision, and I include that alternate implementation in a
   commit message.

 * This version includes several code and test style improvements.

 * The final patch demonstrates how we can remove some duplicate string
   literals for these namespaces. It is focused on the prefetch namespace
   (and an adjacent use of the tags namespace) because of how this series
   changes our handling of that namespace in particular. This makes it
   easier for a future change to modify the namespace via config or
   environment variables. There are opportunities to do this kind of update
   more widely, but I don't want to set that as a critical refactor to do
   right now.

Thanks, -Stolee

Derrick Stolee (10):
  refs: allow "HEAD" as decoration filter
  t4207: test coloring of grafted decorations
  refs: add array of ref namespaces
  refs: use ref_namespaces for replace refs base
  log-tree: use ref_namespaces instead of if/else-if
  log: add default decoration filter
  log: add --decorate-all option
  log: create log.decorateFilter=all
  maintenance: stop writing log.excludeDecoration
  fetch: use ref_namespaces during prefetch

 Documentation/config/log.txt                  |   5 +
 Documentation/git-log.txt                     |  14 +-
 builtin/fetch.c                               |   6 +-
 builtin/gc.c                                  |   6 -
 builtin/log.c                                 |  87 +++++++++---
 builtin/replace.c                             |   3 +
 cache.h                                       |   1 -
 environment.c                                 |   5 +-
 log-tree.c                                    |  28 ++--
 notes.c                                       |   1 +
 refs.c                                        |  88 +++++++++++-
 refs.h                                        |  46 ++++++
 t/t4013-diff-various.sh                       |   2 +
 t/t4013/diff.log_--decorate=full_--all        |   2 +-
 ...f.log_--decorate=full_--decorate-all_--all |  61 ++++++++
 t/t4013/diff.log_--decorate_--all             |   2 +-
 .../diff.log_--decorate_--decorate-all_--all  |  61 ++++++++
 t/t4202-log.sh                                | 134 +++++++++++++++++-
 t/t4207-log-decoration-colors.sh              |  59 ++++++++
 t/t7900-maintenance.sh                        |  21 ---
 t/t9902-completion.sh                         |   3 +
 21 files changed, 568 insertions(+), 67 deletions(-)
 create mode 100644 t/t4013/diff.log_--decorate=full_--decorate-all_--all
 create mode 100644 t/t4013/diff.log_--decorate_--decorate-all_--all


base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1301%2Fderrickstolee%2Fdecorations-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1301/derrickstolee/decorations-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1301

Range-diff vs v1:

  1:  c2e5a0b3a50 =  1:  c2e5a0b3a50 refs: allow "HEAD" as decoration filter
  -:  ----------- >  2:  b5eb110958b t4207: test coloring of grafted decorations
  -:  ----------- >  3:  d7486390d57 refs: add array of ref namespaces
  -:  ----------- >  4:  8da0b0a3181 refs: use ref_namespaces for replace refs base
  -:  ----------- >  5:  53b15a0b793 log-tree: use ref_namespaces instead of if/else-if
  2:  6b40b84773c !  6:  bec532fb8c6 log: add default decoration filter
     @@ Commit message
      
          * The HEAD ref
          * Branches (refs/heads/)
     -    * Notes (refs/notes/)
     -    * Stashes (refs/stash/)
     +    * Stashes (refs/stash)
          * Tags (refs/tags/)
          * Remote branches (refs/remotes/)
     +    * Replace refs (refs/replace/ or $GIT_REPLACE_REF_BASE)
     +
     +    Each of these namespaces was selected due to existing test cases that
     +    verify these namespaces appear in the decorations. In particular,
     +    stashes and replace refs can have custom colors from the
     +    color.decorate.<slot> config option.
     +
     +    While one test checks for a decoration from notes, it only applies to
     +    the tip of refs/notes/commit (or its configured ref name). Notes form
     +    their own kind of decoration instead. Modify the expected output for the
     +    tests in t4013 that expect this note decoration.  There are several
     +    tests throughout the codebase that verify that --decorate-refs,
     +    --decorate-refs-exclude, and log.excludeDecoration work as designed and
     +    the tests continue to pass without intervention.
      
          However, there are other refs that are less helpful to show as
          decoration:
     @@ Commit message
          * Rebase refs (refs/rebase-merge/ and refs/rebase-apply/)
          * Bundle refs (refs/bundle/) [!]
      
     +    [!] The bundle refs are part of a parallel series that bootstraps a repo
     +        from a bundle file, storing the bundle's refs into the repo's
     +        refs/bundle/ namespace.
     +
          In the case of prefetch refs, 96eaffebbf3d0 (maintenance: set
          log.excludeDecoration durin prefetch, 2021-01-19) added logic to add
          refs/prefetch/ to the log.excludeDecoration config option. Additional
     @@ Commit message
          from log.excludeDecoration, then checks if the list of pattern
          modifications are empty. If none are specified, then the default set is
          restricted to the set of inclusions mentioned earlier (HEAD, branches,
     -    etc.).
     +    etc.).  A previous change introduced the ref_namespaces array, which
     +    includes all of these currently-used namespaces. The 'decoration' value
     +    is non-zero when that namespace is associated with a special coloring
     +    and fits into the list of "expected" decorations as described above,
     +    which makes the implementation of this filter very simple.
      
          Note that the logic in ref_filter_match() in log-tree.c follows this
          matching pattern:
     @@ Commit message
          refs outside of the defaults while also excluding some using
          log.excludeDecoration.
      
     +    Another alternative would be to exclude the known namespaces that are
     +    not intended to be shown. This would reduce the visible effect of the
     +    change for expert users who use their own custom ref namespaces. The
     +    implementation change would be very simple to swap due to our use of
     +    ref_namespaces:
     +
     +            int i;
     +            struct string_list *exclude = decoration_filter->exclude_ref_pattern;
     +
     +            /*
     +             * No command-line or config options were given, so
     +             * populate with sensible defaults.
     +             */
     +            for (i = 0; i < NAMESPACE__COUNT; i++) {
     +                    if (ref_namespaces[i].decoration)
     +                            continue;
     +
     +                    string_list_append(exclude, ref_namespaces[i].ref);
     +            }
     +
     +    The main downside of this approach is that we expect to add new hidden
     +    namespaces in the future, and that means that Git versions will be less
     +    stable in how they behave as those namespaces are added.
     +
     +    It is critical that we provide ways for expert users to disable this
     +    behavior change via command-line options and config keys. These changes
     +    will be implemented in a future change.
     +
          Add a test that checks that the defaults are not added when
          --decorate-refs is specified. We verify this by showing that HEAD is not
          included as it normally would.  Also add a test that shows that the
     @@ Commit message
          refs/rebase-merge,
          and refs/bundle.
      
     -    There are several tests throughout the codebase that verify that
     -    --decorate-refs, --decorate-refs-exclude, and log.excludeDecoration work
     -    as designed and the tests continue to pass without intervention.
     -
     -    [!] The bundle refs are part of a parallel series that bootstraps a repo
     -    from a bundle file, storing the bundle's refs into the repo's
     -    refs/bundle/ namespace.
     -
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-log.txt ##
     @@ Documentation/git-log.txt: OPTIONS
       	override a match in `log.excludeDecoration`.
      ++
      +If none of these options or config settings are given, then references are
     -+used as decoration if they match `HEAD`, `refs/heads/`, `refs/notes/`,
     -+`refs/remotes/`, `refs/stash/`, or `refs/tags/`.
     ++used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
     ++`refs/stash/`, or `refs/tags/`.
       
       --source::
       	Print out the ref name given on the command line by which each
     @@ builtin/log.c: static void cmd_log_init_defaults(struct rev_info *rev)
       
      +static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
      +{
     ++	int i;
     ++	struct string_list *include = decoration_filter->include_ref_pattern;
      +	const struct string_list *config_exclude =
     -+		repo_config_get_value_multi(the_repository, "log.excludeDecoration");
     ++			git_config_get_value_multi("log.excludeDecoration");
      +
      +	if (config_exclude) {
      +		struct string_list_item *item;
     @@ builtin/log.c: static void cmd_log_init_defaults(struct rev_info *rev)
      +					   item->string);
      +	}
      +
     -+	if (!decoration_filter->exclude_ref_pattern->nr &&
     -+	    !decoration_filter->include_ref_pattern->nr &&
     -+	    !decoration_filter->exclude_ref_config_pattern->nr) {
     -+		/*
     -+		 * No command-line or config options were given, so
     -+		 * populate with sensible defaults.
     -+		 */
     -+		string_list_append(decoration_filter->include_ref_pattern,
     -+				   "refs/heads/");
     -+		string_list_append(decoration_filter->include_ref_pattern,
     -+				   "refs/notes/");
     -+		string_list_append(decoration_filter->include_ref_pattern,
     -+				   "refs/stash/");
     -+		string_list_append(decoration_filter->include_ref_pattern,
     -+				   "refs/tags/");
     -+		string_list_append(decoration_filter->include_ref_pattern,
     -+				   "refs/remotes/");
     -+		string_list_append(decoration_filter->include_ref_pattern,
     -+				   "HEAD");
     ++	if (decoration_filter->exclude_ref_pattern->nr ||
     ++	    decoration_filter->include_ref_pattern->nr ||
     ++	    decoration_filter->exclude_ref_config_pattern->nr)
     ++		return;
     ++
     ++	/*
     ++	 * No command-line or config options were given, so
     ++	 * populate with sensible defaults.
     ++	 */
     ++	for (i = 0; i < NAMESPACE__COUNT; i++) {
     ++		if (!ref_namespaces[i].decoration)
     ++			continue;
     ++
     ++		string_list_append(include, ref_namespaces[i].ref);
      +	}
      +}
      +
     @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, cons
       		if (decoration_style)
       			rev->show_decorations = 1;
      
     + ## t/t4013/diff.log_--decorate=full_--all ##
     +@@ t/t4013/diff.log_--decorate=full_--all: Date:   Mon Jun 26 00:06:00 2006 +0000
     + 
     +     Rearranged lines in dir/sub
     + 
     +-commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
     ++commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0
     + Author: A U Thor <author@example.com>
     + Date:   Mon Jun 26 00:06:00 2006 +0000
     + 
     +
     + ## t/t4013/diff.log_--decorate_--all ##
     +@@ t/t4013/diff.log_--decorate_--all: Date:   Mon Jun 26 00:06:00 2006 +0000
     + 
     +     Rearranged lines in dir/sub
     + 
     +-commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
     ++commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0
     + Author: A U Thor <author@example.com>
     + Date:   Mon Jun 26 00:06:00 2006 +0000
     + 
     +
       ## t/t4202-log.sh ##
      @@ t/t4202-log.sh: test_expect_success 'decorate-refs-exclude HEAD' '
       	! grep HEAD actual
     @@ t/t4202-log.sh: test_expect_success 'log --decorate includes all levels of tag a
       '
       
      +test_expect_success 'log --decorate does not include things outside filter' '
     -+	reflist="refs/prefetch/ refs/rebase-merge/ refs/bundle/" &&
     ++	reflist="refs/prefetch refs/rebase-merge refs/bundle" &&
      +
      +	for ref in $reflist
      +	do
     -+		mkdir -p .git/$ref &&
     -+		echo $(git rev-parse HEAD) >.git/$ref/fake || return 1
     ++		git update-ref $ref/fake HEAD || return 1
      +	done &&
      +
      +	git log --decorate=full --oneline >actual &&
  -:  ----------- >  7:  64ee889369d log: add --decorate-all option
  -:  ----------- >  8:  8142b32f023 log: create log.decorateFilter=all
  3:  84fbf16613d =  9:  318269dfe27 maintenance: stop writing log.excludeDecoration
  -:  ----------- > 10:  8599bb55045 fetch: use ref_namespaces during prefetch

-- 
gitgitgadget
