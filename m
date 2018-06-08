Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23DD1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 12:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeFHMAG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 08:00:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38008 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeFHMAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 08:00:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so3223597wmf.3
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6RtMIHDczr2TIWPkbgU8qNf1p4NWO1azGheeqbu36PQ=;
        b=r8dGN/dLC00xLDcJNQsxXT39aZKR6fScvcvY8UTxtomhOGPwj6dQVlJYT74yOKnsFx
         4kFcwiErDYrQ++bpOX4xQzFy4d+XioeCYnk5ukLSEukd5ntwK6RP4kEPdu/xf6FCcATm
         PJkUCr2eiJaMb2ZwlHImMxzHwAsLIRCX9JBgsoqZ5stVRKayL1vI/rKcNxlXAXI8z20l
         59h1NlXQNzCNby0m4eTe1L7uQLM37K3o8/MWJqswk7H4IZqBskXK71zo1eR4fw9GN8U9
         opiBXnWVh+ipav85Xfs/Qz/w96EMkkvV91EHSa17bRMeValI/liues5PgntHy3joxEdT
         SJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=6RtMIHDczr2TIWPkbgU8qNf1p4NWO1azGheeqbu36PQ=;
        b=Hcm3CXjKMYvnf1E5kbg1+xGyUgZx/D1oAeqlq5+o+xUh9jkntZnf+rcxLSu7coyELi
         9AlzwLNR+rNKJmv+HK2MTT9F1tT4pQhGA26awxvV6IBZqIFxhdw89ojZYVDtzZQDLUDv
         fBYpj/qxZMxjAE8u5Y+qozhz5bRePzK17ebXN+nUirhgCBKEBSqfWWmMQU/aof0jn1zQ
         zBq5dlMECroodfj1VOD2BdCAEi4G4IA13MyRTuXr84cul+8t/lcREUvxWLwimmiEHHA1
         NZzrIV+SZdvtAkS6iUSXP7Ha69NMBjsBgk7Vaur3Y3jPTW8emuUNe4Fa0NinXgoPm5Us
         9hlg==
X-Gm-Message-State: APt69E3GPVkfWBdHE6LeK5rVK/4hlEeUvmxHedDamOShor64PXQosIzS
        FmerJ8Be7Tfm0G2FvYuEVu4DdPSZ
X-Google-Smtp-Source: ADUXVKK15reKm/TEFjZTFy6Kj0ivcrlUbtVZOUrBdKiEdMIthWLXsts9ZqHAHL7xfoAqKevPdlAoEw==
X-Received: by 2002:a1c:eecd:: with SMTP id j74-v6mr1476814wmi.137.1528459203240;
        Fri, 08 Jun 2018 05:00:03 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ehi77.neoplus.adsl.tpnet.pl. [83.21.98.77])
        by smtp.gmail.com with ESMTPSA id c53-v6sm72785800wrg.12.2018.06.08.05.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 05:00:01 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo
References: <20180531174024.124488-1-dstolee@microsoft.com>
Date:   Fri, 08 Jun 2018 13:59:56 +0200
In-Reply-To: <20180531174024.124488-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 31 May 2018 17:40:39 +0000")
Message-ID: <867en9pjyb.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file stores a condensed version of the commit history.
> This helps speed up several operations involving commit walks. This
> feature does not work well if those commits "change" using features like
> commit grafts, replace objects, or shallow clones.

I like to think about those features as providing an overlay for the
commit graph (similar to overlay filesystems, like overlayfs); in the
case of git-replace quite literally.

I will be calling all those features "history-altering features", for
short.

> Since the commit-graph feature is optional, hidden behind the
> 'core.commitGraph' config option, and requires manual maintenance (until
> ds/commit-graph-fsck' is merged), these issues only arise for expert
> users who decided to opt-in.
>
> This RFC is a first attempt at rectify the issues that come up when
> these features interact. I have not succeeded entirely, as I will
> discuss below.

What I would like to see here in cover letter is a generic description
of _strategy_ to deal with those history-altering features.

From what I understand you have the following options for each of
replacements, shallow clones and grafts:
 - turn off serialized commit-graph if given history-altering feature is
   present, as if core.commitGraph was set to false
 - invalidate and optionally refresh commit-graph file if given
   history-altering feature is present (maybe only if it changed the
   view of the history, is such check is possible)

For automatic invalidation you would need to have either:
 - cover all possible ways by which given history-altering feature can
   change the view of history, or
 - keep state of history-altering change for which commit-graph was
   created (e.g. in proposed VAL4 chunk) and compare with current view
   of history if it changed

For automatic turning off you would need only to check if
history-altering feature is present.


Let us examine each of those history-altering features that Git
supports:

* shallow clone

  - shallow clone usually means having shorter history, so serialized
    commit-graph is not needed as much; also changing the depth
    screws-up assumptions about generation numbers

  - there are only a few entry points changing the view of history,
    namely fetch and push with shallow options (--depth=<depth>,
    --deepen=<depth>, --shallow-since=<date>, --update-shallow,
    --shallow-exclude=<revision>, --unshallow)

  - it is easy to check for presence of shallow clone feature by
    chacking of $GIT_DIR/shallow exists and is not empty

  - different contents of $GIT_DIR/shallow means different view of
    history

  - NOTE: internally uses grafts mechanism (emulated grafts)

* replacements (replace objects, git-replace)

  - git-replace can be used to join current development repository with
    historical repository, in which case we would certainly want to make
    use of serialied commit graph; on the other hand the replacements do
    not necessary alter the view of the history

  - theoretically you could create replacement refs by hand, but in
    practice there are TWO ways of getting them:

    - using git-replace command to create, edit/change and delete
      replacement objects'
      '
    - fetching or having pushed-to refs in refs/replace/* namespace

  - you need to check if there are any refs in refs/replace/* namespace
    to check if the feature is used (but it doesn't necessarily mean
    that it altered project history)

  - changed list of refs in refs/replace/* namespace (which you can get
    with for-each-ref command/API) does not necessarily mean that the
    view of the history changed: you can replace non-commit object, you
    can replace commits and not change their parents; it is not as easy
    as checking if file exists

  - NOTE: the feature can be turned off manually with
    GIT_NO_REPLACE_OBJECTS environment variable and with
    --no-replace-objects option to git wrapper.

    Also when pushing, fetching and fsck-ing this feature is turned off
    and refs in refs/replace/* namespace are treated as ordinary refs.

    This may mean that we would want to create commit-graph with
    replacements for ordinary non-bare repository, and without
    replacements for server-side bare repository.

* grafts

  - subset of uses of git-replace, older and *obsolete* feature (because
    it is unsafe to use; that is you need to be careful with it).

  - edited by hand, no automatic entry points

  - if $GIT_DIR/info/grafts file is present, then feature is enabled
    (barring some corner cases, like empty file or file consisting only
    of comments)

  - changed contents of this file means changed view of history (well,
    except for reordering lines, or removing/adding empty lines and
    comments)

>
> The first two "DO NOT MERGE" commits are not intended to be part of the
> main product, but are ways to help the full test suite run while
> computing and consuming commit-graph files. This is acheived by calling
> write_commit_graph_reachable() from `git fetch` and `git commit`. I
> believe this is the only dependence on ds/commit-graph-fsck. The other
> commits should only depend on ds/commit-graph-lockfile-fix.

That's clever way of increasing coverage.

> Running the full test suite after these DO NO MERGE commits results in
> the following test failures, which I categorize by type of failure.
>
> The following tests are red herrings. Most work by deleting a commit
> from the object database and trying to demonstrate a failure. Others
> rely on how certain objects are loaded. These are not bugs, but will
> add noise if you run the tests suite with this patch.
>
> t0410-partial-clone.sh		Failed tests:  5, 8
> t5307-pack-missing-commit.sh		Failed tests:  3-4
> t6011-rev-list-with-bad-commit.sh	Failed test:  4
> t6024-recursive-merge.sh		Failed test:  4

Does this means that those tests should be in the end (i.e. when
core.commitGraph is turned on by defult) be simply run with
core.commitGraph explicitly disabled for the test?

> The following tests are fixed in "commit-graph: enable replace-object
> and grafts".

Would it make sense to split this commit into two dealing separately
with replace objects and with grafts?  Or do they use the same
underlying API?

> t6001-rev-list-graft.sh		Failed tests:  3, 5, 7, 9, 11, 13

O.K.  It might be good idea to add separate test that does the same, but
with git-replace instead of grafts, though.

> t6050-replace.sh			Failed tests:  11-15, 23-24, 29

The t6050-replace.sh does not test changing the DAG of revision
(excluding changing the SHA-1 of commit), if I read it correctly.  It
would be good to test using git-replace to change committer date, and to
change parents: shortening or lengthening history (e.g. emulating
joining two independent lines of development in the latter case).

See also comment about t6001 above.

>
> The following tests involve shallow clones.
>
> t5500-fetch-pack.sh			Failed tests:  30-31, 34, 348-349
> t5537-fetch-shallow.sh		Failed tests:  4-7, 9
> t5802-connect-helper.sh		Failed test:  3
>
> These tests are mostly fixed by three commits:
>
> * commit-graph: avoid writing when repo is shallow
> * fetch: destroy commit graph on shallow parameters

Seems O.K. from the subject, but I'd have to check the details.

> * commit-graph: revert to odb on missing parents

I wonder if reverting to using object database is a good solution, and
if it wouldn't be better to invalidate / delete commit-graph file
instead...

>
> Each of these cases cover a different interaction that occurs with
> shallow clones. Some are due to a commit becoming shallow, while others
> are due to a commit becoming unshallow (and hence invalidating its
> generation number).

Why do not simply check if repository is shallow?

>
> After these changes, there is one test case that still fails, and I
> cannot understand why:
>
> t5500-fetch-pack.sh			Failed test:  348
>
> This test fails when performing a `git fetch --shallow-exclude`. When I
> halt the test using `t5500-fetch-pack.sh -d -i` and navigate to the
> directory to replay the fetch it performs as expected. After struggling
> with it for a while, I figured I should just put this series up for
> discussion. Maybe someone with more experience in shallow clones can
> point out the obvious issues I'm having.
>
> Thanks,
> -Stolee
>
> Derrick Stolee (6):
>   DO NOT MERGE: compute commit-graph on every commit
>   DO NOT MERGE: write commit-graph on every fetch
>   commit-graph: enable replace-object and grafts
>   commit-graph: avoid writing when repo is shallow
>   fetch: destroy commit graph on shallow parameters
>   commit-graph: revert to odb on missing parents
>
>  builtin/commit.c  |  5 +++++
>  builtin/fetch.c   | 10 +++++++++
>  builtin/gc.c      |  2 +-
>  builtin/replace.c |  3 +++
>  commit-graph.c    | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  commit-graph.h    |  9 ++++++++
>  commit.c          |  5 +++++
>  environment.c     |  2 +-
>  8 files changed, 95 insertions(+), 6 deletions(-)
