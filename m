Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCBBC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 02:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE0022E00
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 02:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbhASCkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387817AbhASCkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 21:40:21 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF7CC061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 18:39:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id v126so20577187qkd.11
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 18:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lYY/licN46JRZj8qphZO/N4HRyjnxyfTorR8BtoJ66M=;
        b=kNVeR/LHi1YXyaiJTIQn/I8Ffp6aF+bq383eP+12ru28NbRx6MeUteqyrFARCfcAwV
         Pg3LLlNhH2fr15m7ObodqDf7rAeVW72D4SlLrill8P6jkizCuN1Ff39YWG7yq4xKyFET
         QTcigmqotgKn8yq5uEADAk/6KjLsy1N1d9uBodSz9WJckyoAnsxKPT/t+j/Ejtuwn93C
         El1AHqA8hl7PpzK+yJTOPa8UbWJFHJSwABYSsVd2oPmTCl29r+k32DymZ/TBkB2APuvL
         Sz+01Ibsil2MHlSe1ZikE/ERHwA4gBmFcxTdL2+v+EZaaYYSiV+qkLNOdBG0NglbivLM
         Sycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lYY/licN46JRZj8qphZO/N4HRyjnxyfTorR8BtoJ66M=;
        b=A9jnh3zRVD0G0CKY5VlV+3F/vBgQVXvvouztd+WEDtBJ/E+D//OJOlKRLdhME6klp5
         ZLy77jCdhwewSCx77aeCreJAZnqxZwLBgYMfP43paE/8If4A/4hIDk1pRUKKhFjl03GB
         EZHxQUQ+nw2zyCPBrbuwucQ9LDBpo1tQBxKFTvH0/0Qy7kGAzgHZHvnFmx2g8b2y4dhR
         BuUM6dTEcA2HtqFPIDkegbT4ZDBTtm2RfPmC7av70NcNK0DrrCACvUByLKPHdYeOvrPg
         YmfNWOt5ROTtH3dkYxSmpuVAtohJnpGJwOSoAhOWZEder8fWRgO1GbLn42DZQ6Fo/f2T
         tIow==
X-Gm-Message-State: AOAM532KRpvol7mtywyy94LyEs5txxUb4mKgS8Q1Fx7QnA5pK3eae6nI
        M5Dbn5tjsSCXivtq1g+BJgNNk1jrPbM=
X-Google-Smtp-Source: ABdhPJwdkVPDAK5dSLqYrmptYDBsRTAiOysJXNLkr7tOr4oeIGd9R3+e5xl+Si7CgiZeF8GDlOTW/A==
X-Received: by 2002:a37:38e:: with SMTP id 136mr2462716qkd.102.1611023979890;
        Mon, 18 Jan 2021 18:39:39 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c079:252a:4324:9b45? ([2600:1700:e72:80a0:c079:252a:4324:9b45])
        by smtp.gmail.com with UTF8SMTPSA id a9sm11985447qkk.39.2021.01.18.18.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 18:39:39 -0800 (PST)
Subject: Re: DEVEL: Help with feature implementation
To:     Antonio Russo <aerusso@aerusso.net>,
        Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
 <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
 <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e5ece7c-3f34-caa1-db87-084b42c1cb62@gmail.com>
Date:   Mon, 18 Jan 2021 21:39:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/2021 7:54 PM, Antonio Russo wrote:
> On 1/18/21 1:58 PM, Derrick Stolee wrote:
>> On 1/18/2021 2:31 PM, Aiyee Bee wrote:
>>> Hi Antonio and Derrick!
>>>
>>>> I think what you really want is --full-history --simplify-merges [1]. This
>>>> will show the merges that "fork" the history into parallel tracks where
>>>> at least two of them contain interesting commits.
>>>
>>> It doesn't look like the implementation of --simplify-merges helps much
>>> here. That makes its decision on basis of the parents of the commit, which is
>>> simple to do as it's information attached freely to each commit. I think the
>>> problem here would be figuring out, given any commit, how many of its children
>>> are "relevant" commits.
>>
>> You should definitely give this a try instead of assuming things about the
>> implementation. The algorithm uses a lot of "simplifying" that makes it look
>> like the decision is a local one. However, I assure you that is not the case.
> 
> As a side note, would this list be willing to look at patches that remove
> the need to use revs->limited?  Adding new features would be much easier if
> we could restrict git to use streaming algorithms for these simplifications.

I would _love_ to see patches that remove that bit (without modifying
the behavior).

Fair warning: I definitely spent a few weeks attempting to do any amount
of reducing the depth one needs to walk in order to compute the
--simplify-merges history, but a sufficiently-complicated branch history
makes it nearly impossible to gain a benefit.

>> Please assemble a test case that demonstrates the behavior you want and how
>> that is different from what is present in --simplify-merges.
> 
> I can't figure out how to get the behavior from --simplify-merges, which is
> described as
> 
> 	Additional option to --full-history to remove some needless
> 	merges from  the resulting history, as there are no selected
> 	commits contributing to this merge.
> 
> It seems that the desired behavior is to include commits which are parents to
> multiple branches.  Here is an example:

Thank you for these examples. They clearly show that I misread your
ask, because you're not looking for "merge commits" but instead you
are looking to show the "merge bases" as history is walking.

Sorry for misinterpreting your request, then doubling down on it.

> test_commit() {
>  echo >> file
>  git add file
>  git commit "$@"
> }
> 
> git init
> test_commit -m a
> test_commit -m b
> test_commit -m c
> git checkout -b fork
> test_commit -m y
> test_commit -m z
> git switch master
> test_commit -m d
> test_commit -m e
> test_commit -m f
> 
> git log --graph --oneline master fork
> 
> * 08029fd f
> * 55b09fe e
> * 83b7801 d
> | * efc204e z
> | * 316219e y
> |/  
> * 3594039 c
> * 4321987 b
> * bd44220 a
> 
> git log --graph --oneline --full-history --simplify-merges master fork
> 
> * 08029fd f
> * 55b09fe e
> * 83b7801 d
> | * efc204e z
> | * 316219e y
> |/  
> * 3594039 c
> * 4321987 b
> * bd44220 a
> 
> git log --graph --oneline --simplify-by-decoration --full-history --simplify-merges master fork
> 
> * 08029fd f
> | * efc204e z
> |/  
> * bd44220 a
> 
> git log --graph --oneline --full-history --simplify-merges master fork
> 
> * 08029fd f
> * 55b09fe e
> * 83b7801 d
> | * efc204e z
> | * 316219e y
> |/  
> * 3594039 c
> * 4321987 b
> * bd44220 a
> 
> git --version
> git version 2.30.0
> 
> I can't seem to get commit c, the crucial fork, to show up with simplifications with this mechanism.
> Am I missing something here?

In your example, you are not specifying a path. In this case, you are
really looking for "git merge-base master fork". You could also use
"git log --boundary master...fork" to show everything up to and
including 'c'.

Now, if you specify a pathspec, then 'git merge-base' isn't going to
help. That becomes a technically interesting problem.

The biggest reason that "git log" doesn't show this commit 'c' easily
is because...it's not really that important. When that commit was
created, it didn't "know" that it would be a common base of two
diverging branches. By surfacing the commit, we are very unlikely to
present the user with information that is helpful.

One way to expose the "first layer" of these merge bases is with the
--boundary option.

Here is an example of two branches in the Git ecosystem that can
present an interesting real example: code in builtin/gc.c has been
changed in both 'master' from origin (https://github.com/git/git) and
in 'main' from windows (https://github.com/git-for-windows/git):

$ git log --no-decorate --oneline --graph origin/master...windows/main  -- builtin/gc.c
* b2ace18759c Merge branch 'ds/maintenance-part-4'
* c977ff44073 Merge branch 'pk/subsub-fetch-fix-take-2'
*   95124ead43a Merge branch 'main' into maintenance-and-headless
|\  
| * ff61c9b1f49 Start the merging-rebase to v2.30.0-rc2
| * afb16063390 Start the merging-rebase to v2.30.0-rc0
| * 13c9d54a45b Start the merging-rebase to v2.29.0-rc0
| * c00a524ea88 strvec: rename struct fields
| * a864a84f1ee strvec: fix indentation in renamed calls
| * 12922aa02db strvec: convert builtin/ callers away from argv_array name
| * 86f1b0f0e04 strvec: rename files from argv-array to strvec
* 5bef0904826 git maintenance: avoid console window in scheduled tasks on Windows

Something that is hard to see from this picture is that the first two
commits are not actually connected to the third. This is more visible
when adding --boundary:

$ git log --no-decorate --oneline --graph --boundary origin/master...windows/main -- builtin/gc.c
*   b2ace18759c Merge branch 'ds/maintenance-part-4'
|\  
* \   c977ff44073 Merge branch 'pk/subsub-fetch-fix-take-2'
|\ \  
| | | *   95124ead43a Merge branch 'main' into maintenance-and-headless
| | | |\  
| | | | *   ff61c9b1f49 Start the merging-rebase to v2.30.0-rc2
| | | | |\  
| | | | | *   afb16063390 Start the merging-rebase to v2.30.0-rc0
| | | | | |\  
| | | | | | *   13c9d54a45b Start the merging-rebase to v2.29.0-rc0
| | | | | | |\  
| | | | | | | * c00a524ea88 strvec: rename struct fields
| | | | | | | * a864a84f1ee strvec: fix indentation in renamed calls
| | | | | | | * 12922aa02db strvec: convert builtin/ callers away from argv_array name
| | | | | | | * 86f1b0f0e04 strvec: rename files from argv-array to strvec
| | | * | | | | 5bef0904826 git maintenance: avoid console window in scheduled tasks on Windows
| | |/ / / / /  
| | | | | | o 47ae905ffb9 Git 2.28
| | | | | o d98273ba77e Git 2.29-rc0
| | | | o 1c52ecf4ba0 Git 2.30-rc0
| | | o 4a0de43f492 Git 2.30-rc2
| o | 898f80736c7 Git 2.29.2
|  /  
o / 71ca53e8125 Git 2.30
 /  
o 3797a0a7b7a maintenance: use Windows scheduled tasks

Notice that all these boundaries are actually adding "uninteresting"
bases _and_ merges.

Probably, the suggested --show-forkpoints would need to start from
something like this and simplify it further.

The problem that I see as well is what happens as the history itself
branches repeatedly. Consider the history of builtin/gc.c again, this
time with a single starting ref. (I have inserted places where your
fork points might add commits to the first few results.)

$ git log --no-decorate --oneline --graph origin/master -- builtin/gc.c
*   b2ace18759c Merge branch 'ds/maintenance-part-4'
|\  
| * 3797a0a7b7a maintenance: use Windows scheduled tasks
| * 2afe7e35672 maintenance: use launchctl on macOS
| * 31345d5545e maintenance: extract platform-specific scheduling
* | 66dc0a3625e gc: fix handling of crontab magic markers
* |   f2a75cb312d Merge branch 'rs/maintenance-run-outside-repo'
|\ \  
| * | e72f7defc4f maintenance: fix SEGFAULT when no repository
* | |   d702cb9e890 Merge branch 'ds/maintenance-part-3'
|\ \ \  
| * | | 483a6d9b5da maintenance: use 'git config --fixed-value'
* | | |   1c04cdd424b Merge branch 'ab/gc-keep-base-option'
|\ \ \ \  
| |_|/ /  
|/| | |   

* | | |  (some fork point here)

| * | | 793c1464d3e gc: rename keep_base_pack variable for --keep-largest-pack
* | | | a1c74791d5f gc: fix cast in compare_tasks_by_selection()
| |/ /  
|/| |   

* | |    (some fork point here)

* | |   7660da16182 Merge branch 'ds/maintenance-part-3'
|\ \ \  
| | |/  
| |/|   

| * |    (some fork point here)

| * | 61f7a383d3b maintenance: use 'incremental' strategy by default
| * | a4cb1a2339c maintenance: create maintenance.strategy config
| * | 2fec604f8df maintenance: add start/stop subcommands
| * | 0c18b700810 maintenance: add [un]register subcommands
| * | b08ff1fee00 maintenance: add --schedule option and config
* | |   902f358555c Merge branch 'rs/clear-commit-marks-in-repo

When using file history simplification, there is actually a very
simple way to detect whether a commit is a fork point (assuming
that you are walking in generation number order):

- As you walk and see that commit C is not TREESAME to commit D,
  increment a "walked indegree" count on D. (Note: this would be
  different from the current "indegree" slab used in topo-order
  calculations.)

- As you visit a commit, check its indegree. If this is larger
  than 1, then it is a forkpoint of two "interesting" histories.

This entire procedure relies on the fact that simplified history
only visits multiple parents if the merge commit is not TREESAME
to _any_ parent. Otherwise, it walks only to its first TREESAME
parent, "simplifying away" the other parents.

To implement your fork-points in the case of --full-history
or --simplify-merges would require something much more sophisticated.

   (taking an extra pause here to shift gears)

But I think the --show-forkpoints option needs to be justified a
bit better. I'm still not convinced that this is actually
interesting information, unless you are literally looking for a
merge base or a log boundary, in which case there are ways to
expose those values.

The example of --show-pulls has such a justification:

  If a user wants to see which merge commits introduced the
  interesting commits into this history, then --show-pulls
  presents those merges. Such merges might have extra
  information in their commit messages, such as pull request
  IDs, topic branch names, or information about tricky merge
  conflict resolutions.

Is there something similar to justify --show-forkpoint?

Thanks,
-Stolee
