Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11921F42D
	for <e@80x24.org>; Thu, 31 May 2018 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbeEaSd0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 14:33:26 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46283 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbeEaSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 14:33:25 -0400
Received: by mail-yb0-f195.google.com with SMTP id p22-v6so7905122yba.13
        for <git@vger.kernel.org>; Thu, 31 May 2018 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mHEWUfkKGo+QohKL3rG0naWZi95xh7RKMyG/hKfFcaU=;
        b=MS+aDlXs7BxTadJzefCXroBHgrYXTQ3yhc6RIZOyAQKVkPNzkwvG4Mgl4Y89fRyeSx
         htk2tonyXuqksNlLpOOJih0hMFDgojqgRZ3yBH91yFDNhRD3/fYxYBYZxf63tydeDCQY
         f8qaEWxl8ln3vxhKPTpszo/qPRj7Ifh2N90yghhPvOjfZkDbMZg/1bYQtSTcAaodO56e
         woAyfj2B8q9ZeBhgz++PB0suYo6deyy6Jxt+G6CPUcI0rj21cEsmYP7dyYaTmalhQDDu
         1UFOcqrgPhjoflL3NnDADsXJWqOu+L/aJ71/1/UOj1cT/DMkWoLFnEeFKWK41t1MMg3N
         dYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mHEWUfkKGo+QohKL3rG0naWZi95xh7RKMyG/hKfFcaU=;
        b=QVURqrqdg8/my7J3JU5lSeGbipWyB79n1dxtliuzD/TrpRVxDajdrGz55fOZAxmfoa
         w/ULqnwlaopZvzMKIUjYOjdaiG0ls1cPdZ4UqsP8qaPSy7f6yLflBi1jSutu8ksXXqvX
         1eKyI+WrBPOrDWlvPsfJwchi9Lgix0YiZHA+8SlHJGeMDGO2ifOFSJeLVc1pce5b7+21
         CcmnqcnpLetL7IXHi3AmUjkoPDM5enG9kFZhd5c7gYahGCMOvxOLGM1JrdybYCxfrdi9
         8tjCA4VXsPYSKqUmdCxJMIGsONaky20KLNH7eSXjUjw54AwXF2x9gSocH9SgrwW4G65Q
         kthw==
X-Gm-Message-State: ALKqPwefd80O9F8lv35FR9Rmae5ONwVKQFVyGU7us1wJ+shMtyjYZNnh
        8ShiFDoUZqr87YTeeERR07yBIjahYlknZ2A9lHvjkw==
X-Google-Smtp-Source: ADUXVKKXa4pCwaHHLmyCDZahZ+3QTs//Xnqs2ooFfYEWviuTTnIrmPs2ubUVXW4Ud/pqdBqU3Hg8OHYlP6tf1bFxIMc=
X-Received: by 2002:a25:d707:: with SMTP id o7-v6mr4478928ybg.292.1527791604466;
 Thu, 31 May 2018 11:33:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 11:33:23 -0700 (PDT)
In-Reply-To: <20180531174024.124488-1-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 11:33:23 -0700
Message-ID: <CAGZ79kYCi_=LRuq35Fh0jGYw9kiW9i=6t1YwLuNj7MfezywZDw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 10:40 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> The commit-graph file stores a condensed version of the commit history.
> This helps speed up several operations involving commit walks. This
> feature does not work well if those commits "change" using features like
> commit grafts, replace objects, or shallow clones.
>
> Since the commit-graph feature is optional, hidden behind the
> 'core.commitGraph' config option, and requires manual maintenance (until
> ds/commit-graph-fsck' is merged), these issues only arise for expert
> users who decided to opt-in.
>
> This RFC is a first attempt at rectify the issues that come up when
> these features interact. I have not succeeded entirely, as I will
> discuss below.
>
> The first two "DO NOT MERGE" commits are not intended to be part of the
> main product, but are ways to help the full test suite run while
> computing and consuming commit-graph files. This is acheived by calling
> write_commit_graph_reachable() from `git fetch` and `git commit`. I
> believe this is the only dependence on ds/commit-graph-fsck. The other
> commits should only depend on ds/commit-graph-lockfile-fix.

I applied these patches on top of ds/commit-graph-fsck
(it would have been nice if you mentioned that it applies there)
Running the test suite with all patches applied results in:

./t0410-partial-clone.sh                    (Wstat: 256 Tests: 15 Failed: 2)
  Failed tests:  5, 8
./t5307-pack-missing-commit.sh              (Wstat: 256 Tests: 5 Failed: 2)
  Failed tests:  3-4
./t5500-fetch-pack.sh                       (Wstat: 256 Tests: 353 Failed: 1)
  Failed test:  348
./t6011-rev-list-with-bad-commit.sh         (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  4
./t6024-recursive-merge.sh                  (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  4

which you identified as 4x noise and t5500 as not understood.

$ GIT_TRACE=1 ./t5500-fetch-pack.sh -d -i -v -x
[...]
expecting success:
git -C shallow12 fetch --shallow-exclude one origin &&
git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
test_write_lines three two >expected &&
test_cmp expected actual

++ git -C shallow12 fetch --shallow-exclude one origin
trace: built-in: git fetch --shallow-exclude one origin
trace: run_command: unset GIT_PREFIX; 'git-upload-pack
'\''/u/git/t/trash directory.t5500-fetch-pack/shallow-exclude/.'\'''
trace: run_command: git --shallow-file  pack-objects --revs --thin
--stdout --shallow --progress --delta-base-offset --include-tag
trace: built-in: git pack-objects --revs --thin --stdout --shallow
--progress --delta-base-offset --include-tag
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 0), reused 0 (delta 0)
trace: run_command: git --shallow-file  unpack-objects --pack_header=2,4
trace: built-in: git unpack-objects --pack_header=2,4
Unpacking objects: 100% (4/4), done.
trace: run_command: git rev-list --objects --stdin --not --all --quiet
trace: built-in: git rev-list --objects --stdin --not --all --quiet
trace: run_command: unset GIT_PREFIX; 'git-upload-pack
'\''/u/git/t/trash directory.t5500-fetch-pack/shallow-exclude/.'\'''
trace: run_command: git pack-objects --revs --thin --stdout --progress
--delta-base-offset
trace: built-in: git pack-objects --revs --thin --stdout --progress
--delta-base-offset
remote: Total 0 (delta 0), reused 0 (delta 0)
trace: run_command: git unpack-objects --pack_header=2,0
trace: built-in: git unpack-objects --pack_header=2,0
trace: run_command: git rev-list --objects --stdin --not --all --quiet
trace: built-in: git rev-list --objects --stdin --not --all --quiet
From file:///u/git/t/trash directory.t5500-fetch-pack/shallow-exclude/.
 * [new tag]         one        -> one
 * [new tag]         two        -> two
run_processes_parallel: preparing to run up to 1 tasks
run_processes_parallel: done
trace: run_command: git gc --auto
trace: built-in: git gc --auto
++ git -C shallow12 log --pretty=tformat:%s origin/master
trace: built-in: git log '--pretty=tformat:%s' origin/master
++ test_write_lines three two
++ printf '%s\n' three two
++ test_cmp expected actual
++ diff -u expected actual
--- expected 2018-05-31 18:14:25.944540810 +0000
+++ actual 2018-05-31 18:14:25.944540810 +0000
@@ -1,2 +1,3 @@
 three
 two
+one
error: last command exited with $?=1
not ok 348 - fetch exclude tag one
#
# git -C shallow12 fetch --shallow-exclude one origin &&
# git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
# test_write_lines three two >expected &&
# test_cmp expected actual
#


> After these changes, there is one test case that still fails, and I
> cannot understand why:
>
> t5500-fetch-pack.sh                     Failed test:  348
>
> This test fails when performing a `git fetch --shallow-exclude`. When I
> halt the test using `t5500-fetch-pack.sh -d -i` and navigate to the
> directory to replay the fetch it performs as expected.

What is "as expected" ?

When I insert a test_pause before that first line, such that:

test_expect_success 'fetch exclude tag one' '
    test_pause &&
    git -C shallow12 fetch --shallow-exclude one origin &&
    git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
    test_write_lines three two >expected &&
    test_cmp expected actual
'

and then run

  rm "shallow-exclude/.git/objects/info/commit-graph

the test works after exiting the test_pause.

Note how the shallow-exclude is the *remote* of the fetch.
So I think you also want to introduce the destruction
of commit graphs in upload-pack.c which is the remote counter part to fetch.

Why do you think these other tests are noice?

Thanks,
Stefan
