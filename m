Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63063C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 12:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiBTMyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 07:54:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiBTMyI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 07:54:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89A335DEF
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:53:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s24so17540792edr.5
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3zCeaIqmjSTP43PSC28eSGsha3ZIJmMEuVtwIXJ6UfA=;
        b=XERvxVizmtjOLi7Z6Gh4ANyWjqsUVkb4PYMvqYuOehzy1NO39TW/lhtE1rXtLO42l5
         LF5aWmoRkPLlScTuUGrESg6wJHBpVF5TTjQGzzQhsesuTWypxYyweXIzSocmCd7y3kDS
         G7An+L0yl2e6fpn2+kzwhXKjeUmYcpHN2FWs6BHIL95xPaj3z/91Yzfo1eSPYTP9wfZe
         YlOqv9lTlPExU7SJFNolJHS2Eh1cCkh2ZJ5qEQNgPMXqWhfUDVSj9jQGtuM9WEVjVVcH
         LYZWsVcxHsHOKX3thJ0j1wBOtSbSaLNcONjxpPItJaF5H1C5IGxnRTqZ+dvUdNUtayHh
         G5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3zCeaIqmjSTP43PSC28eSGsha3ZIJmMEuVtwIXJ6UfA=;
        b=FqiWjMMoD4MCCoC6M1N0zmxiX70Tm/jBeM6A9gsmD8i5ndJAiDi1EZRCKLfpBxzioT
         /dGCv8MyuV46m7NV1SFcXsNC6aGOIaNayWKUkfvSSXUD0YsjWcZQj05/vPVtPob/2EJJ
         2jmG1kLyaNxbGdFa+grDMJSiznTnTsLdyBMwCHfEUTri30Ly8o0YDR+q9flgfW+iwLeJ
         Inkb6ChCQTJVWBwCTOXtKhSfeJnobYeKb/W7G9qyEO3f+6/Rf3FogHHIWFI55sHRtFRY
         DJEDeB+CC5Ku7bc2DAjlY3L8E973NpHo0qqloPNG/cjqFskFZqBQtBI1ABXerniyRtIq
         QeUQ==
X-Gm-Message-State: AOAM5324e6Z8Y+IMjM9V5JCkQuFJFvyUJPZbc9l5GtlVwK2jk0w2Oo59
        T5ODCSr8e9ssM66UhX1l0m4=
X-Google-Smtp-Source: ABdhPJwKhlwzS1QXXXJD+/1l6jnR5a0mnsiFdA/g1u03ZW8s5BYaBViAG+3+NnMuy2LFr7jd4XpZxA==
X-Received: by 2002:a50:cd59:0:b0:410:ac25:e570 with SMTP id d25-20020a50cd59000000b00410ac25e570mr16438188edj.252.1645361622925;
        Sun, 20 Feb 2022 04:53:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3sm4168145ejd.129.2022.02.20.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 04:53:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLlif-005MTu-L4;
        Sun, 20 Feb 2022 13:53:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Sun, 20 Feb 2022 13:47:57 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
Message-ID: <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 20 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> I notice that you did not take this into `seen` yet. I find that a little
> sad because it would potentially have helped others to figure out the
> failure in the latest `seen`:
> https://github.com/git/git/runs/5255378056?check_suite_focus=3Dtrue#step:=
5:162
>
> Essentially, a recent patch introduces hard-coded SHA-1 hashes in t3007.3.

I left some feedback on your submission ~3 weeks ago that you haven't
responded to:
https://lore.kernel.org/git/220127.86ilu5cdnf.gmgdl@evledraar.gmail.com/

I think you should really reply to that before this moves forward,
i.e. it's not trivial concerns. I think to get from our current "X" to
your aims of "Y" your way of doing that (for part of this series) is
really an overly complex way of getting there that we can do much
simpler, and the simpler way integrates much better with the GitHub CI
UI.

The feedback I left is on the part of this that's not directly relevant
to what you're pointing out here (which is the grouping of the per-test
failure output), but if your series is picked-up as-is we'd need to undo
rather big parts of it to get to what I consider a better state for the
"grouping" of the "make" v.s. "make test" etc. output.

I can just submit my version of that & we can hash out what direction
makes sense there, how does that sound? I've been running with it for
about a month, and really think that part of the failure output is much
better.

Here's an example of that part:
https://github.com/avar/git/runs/5259000590?check_suite_focus=3Dtrue

I.e. note how we'll now just have a "make" and "make test" step, and we
failed there on the "make".

So we'd get to the point of simply invoking those build steps as 1=3D1
mapped CI steps, as opposed to "improving" ci/run-build-and-tests.sh to
emulate that (I've just git rm'd it in my version).

>
> On Mon, 24 Jan 2022, Johannes Schindelin via GitGitGadget wrote:
>
>>
>> Background
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Recent patches intended to help readers figure out CI failures much quic=
ker
>> than before. Unfortunately, they haven't been entirely positive for me. =
For
>> example, they broke the branch protections in Microsoft's fork of Git, w=
here
>> we require Pull Requests to pass a certain set of Checks (which are
>> identified by their names) and therefore caused follow-up work.
>>
>> Using CI and in general making it easier for new contributors is an area=
 I'm
>> passionate about, and one I'd like to see improved.
>>
>>
>> The current situation
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Let me walk you through the current experience when a PR build fails: I =
get
>> a notification mail that only says that a certain job failed. There's no
>> indication of which test failed (or was it the build?). I can click on a
>> link at it takes me to the workflow run. Once there, all it says is "Pro=
cess
>> completed with exit code 1", or even "code 2". Sure, I can click on one =
of
>> the failed jobs. It even expands the failed step's log (collapsing the o=
ther
>> steps). And what do I see there?
>>
>> Let's look at an example of a failed linux-clang (ubuntu-latest) job
>> [https://github.com/git-for-windows/git/runs/4822802185?check_suite_focu=
s=3Dtrue]:
>>
>> [...]
>> Test Summary Report
>> -------------------
>> t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 F=
ailed: 1)
>>   Failed test:  49
>>   Non-zero exit status: 1
>> t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Fai=
led: 0)
>>   TODO passed:   45, 47
>> Files=3D957, Tests=3D25489, 645 wallclock secs ( 5.74 usr  1.56 sys + 86=
6.28 cusr 364.34 csys =3D 1237.92 CPU)
>> Result: FAIL
>> make[1]: *** [Makefile:53: prove] Error 1
>> make[1]: Leaving directory '/home/runner/work/git/git/t'
>> make: *** [Makefile:3018: test] Error 2
>>
>>
>> That's it. I count myself lucky not to be a new contributor being faced =
with
>> something like this.
>>
>> Now, since I am active in the Git project for a couple of days or so, I =
can
>> make sense of the "TODO passed" label and know that for the purpose of
>> fixing the build failures, I need to ignore this, and that I need to foc=
us
>> on the "Failed test" part instead.
>>
>> I also know that I do not have to get myself an ubuntu-latest box just to
>> reproduce the error, I do not even have to check out the code and run it
>> just to learn what that "49" means.
>>
>> I know, and I do not expect any new contributor, not even most seasoned
>> contributors to know, that I have to patiently collapse the "Run
>> ci/run-build-and-tests.sh" job's log, and instead expand the "Run
>> ci/print-test-failures.sh" job log (which did not fail and hence does not
>> draw any attention to it).
>>
>> I know, and again: I do not expect many others to know this, that I then
>> have to click into the "Search logs" box (not the regular web browser's
>> search via Ctrl+F!) and type in "not ok" to find the log of the failed t=
est
>> case (and this might still be a "known broken" one that is marked via
>> test_expect_failure and once again needs to be ignored).
>>
>> To be excessively clear: This is not a great experience!
>>
>>
>> Improved output
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Our previous Azure Pipelines-based CI builds had a much nicer UI, one th=
at
>> even showed flaky tests, and trends e.g. how long the test cases ran. Wh=
en I
>> ported Git's CI over to GitHub workflows (to make CI more accessible to =
new
>> contributors), I knew fully well that we would leave this very nice UI
>> behind, and I had hoped that we would get something similar back via new,
>> community-contributed GitHub Actions that can be used in GitHub workflow=
s.
>> However, most likely because we use a home-grown test framework implemen=
ted
>> in opinionated POSIX shells scripts, that did not happen.
>>
>> So I had a look at what standards exist e.g. when testing PowerShell
>> modules, in the way of marking up their test output in GitHub workflows,=
 and
>> I was not disappointed: GitHub workflows support "grouping" of output li=
nes,
>> i.e. marking sections of the output as a group that is then collapsed by
>> default and can be expanded. And it is this feature I decided to use in =
this
>> patch series, along with GitHub workflows' commands to display errors or
>> notices that are also shown on the summary page of the workflow run. Now=
, in
>> addition to "Process completed with exit code" on the summary page, we a=
lso
>> read something like:
>>
>> =E2=8A=97 linux-gcc (ubuntu-latest)
>>    failed: t9800.20 submit from detached head
>>
>>
>> Even better, this message is a link, and following that, the reader is
>> presented with something like this
>> [https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue]:
>>
>> =E2=8F=B5 Run ci/run-build-and-tests.sh
>> =E2=8F=B5 CI setup
>>   + ln -s /home/runner/none/.prove t/.prove
>>   + run_tests=3Dt
>>   + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>>   + group Build make
>>   + set +x
>> =E2=8F=B5 Build
>> =E2=8F=B5 Run tests
>>   =3D=3D=3D Failed test: t9800-git-p4-basic =3D=3D=3D
>> =E2=8F=B5 ok: t9800.1 start p4d
>> =E2=8F=B5 ok: t9800.2 add p4 files
>> =E2=8F=B5 ok: t9800.3 basic git p4 clone
>> =E2=8F=B5 ok: t9800.4 depot typo error
>> =E2=8F=B5 ok: t9800.5 git p4 clone @all
>> =E2=8F=B5 ok: t9800.6 git p4 sync uninitialized repo
>> =E2=8F=B5 ok: t9800.7 git p4 sync new branch
>> =E2=8F=B5 ok: t9800.8 clone two dirs
>> =E2=8F=B5 ok: t9800.9 clone two dirs, @all
>> =E2=8F=B5 ok: t9800.10 clone two dirs, @all, conflicting files
>> =E2=8F=B5 ok: t9800.11 clone two dirs, each edited by submit, single git=
 commit
>> =E2=8F=B5 ok: t9800.12 clone using non-numeric revision ranges
>> =E2=8F=B5 ok: t9800.13 clone with date range, excluding some changes
>> =E2=8F=B5 ok: t9800.14 exit when p4 fails to produce marshaled output
>> =E2=8F=B5 ok: t9800.15 exit gracefully for p4 server errors
>> =E2=8F=B5 ok: t9800.16 clone --bare should make a bare repository
>> =E2=8F=B5 ok: t9800.17 initial import time from top change time
>> =E2=8F=B5 ok: t9800.18 unresolvable host in P4PORT should display error
>> =E2=8F=B5 ok: t9800.19 run hook p4-pre-submit before submit
>>   Error: failed: t9800.20 submit from detached head
>> =E2=8F=B5 failure: t9800.20 submit from detached head
>>   Error: failed: t9800.21 submit from worktree
>> =E2=8F=B5 failure: t9800.21 submit from worktree
>>   =3D=3D=3D Failed test: t9801-git-p4-branch =3D=3D=3D
>>   [...]
>>
>>
>> The "Failed test:" lines are colored in yellow to give a better visual c=
lue
>> about the logs' structure, the "Error:" label is colored in red to draw =
the
>> attention to the important part of the log, and the "=E2=8F=B5" characte=
rs indicate
>> that part of the log is collapsed and can be expanded by clicking on it.
>>
>> To drill down, the reader merely needs to expand the (failed) test case's
>> log by clicking on it, and then study the log. If needed (e.g. when the =
test
>> case relies on side effects from previous test cases), the logs of prece=
ding
>> test cases can be expanded as well. In this example, when expanding
>> t9800.20, it looks like this (for ease of reading, I cut a few chunks of
>> lines, indicated by "[...]"):
>>
>> [...]
>> =E2=8F=B5 ok: t9800.19 run hook p4-pre-submit before submit
>>   Error: failed: t9800.20 submit from detached head
>> =E2=8F=B7 failure: t9800.20 submit from detached head
>>       test_when_finished cleanup_git &&
>>       git p4 clone --dest=3D"$git" //depot &&
>>         (
>>           cd "$git" &&
>>           git checkout p4/master &&
>>           >detached_head_test &&
>>           git add detached_head_test &&
>>           git commit -m "add detached_head" &&
>>           git config git-p4.skipSubmitEdit true &&
>>           git p4 submit &&
>>             git p4 rebase &&
>>             git log p4/master | grep detached_head
>>         )
>>     [...]
>>     Depot paths: //depot/
>>     Import destination: refs/remotes/p4/master
>>
>>     Importing revision 9 (100%)Perforce db files in '.' will be created =
if missing...
>>     Perforce db files in '.' will be created if missing...
>>
>>     Traceback (most recent call last):
>>       File "/home/runner/work/git/git/git-p4", line 4455, in <module>
>>         main()
>>       File "/home/runner/work/git/git/git-p4", line 4449, in main
>>         if not cmd.run(args):
>>       File "/home/runner/work/git/git/git-p4", line 2590, in run
>>         rebase.rebase()
>>       File "/home/runner/work/git/git/git-p4", line 4121, in rebase
>>         if len(read_pipe("git diff-index HEAD --")) > 0:
>>       File "/home/runner/work/git/git/git-p4", line 297, in read_pipe
>>         retcode, out, err =3D read_pipe_full(c, *k, **kw)
>>       File "/home/runner/work/git/git/git-p4", line 284, in read_pipe_fu=
ll
>>         p =3D subprocess.Popen(
>>       File "/usr/lib/python3.8/subprocess.py", line 858, in __init__
>>         self._execute_child(args, executable, preexec_fn, close_fds,
>>       File "/usr/lib/python3.8/subprocess.py", line 1704, in _execute_ch=
ild
>>         raise child_exception_type(errno_num, err_msg, err_filename)
>>     FileNotFoundError: [Errno 2] No such file or directory: 'git diff-in=
dex HEAD --'
>>     error: last command exited with $?=3D1
>>     + cleanup_git
>>     + retry_until_success rm -r /home/runner/work/git/git/t/trash direct=
ory.t9800-git-p4-basic/git
>>     + nr_tries_left=3D60
>>     + rm -r /home/runner/work/git/git/t/trash directory.t9800-git-p4-bas=
ic/git
>>     + test_path_is_missing /home/runner/work/git/git/t/trash directory.t=
9800-git-p4-basic/git
>>     + test 1 -ne 1
>>     + test -e /home/runner/work/git/git/t/trash directory.t9800-git-p4-b=
asic/git
>>     + retry_until_success mkdir /home/runner/work/git/git/t/trash direct=
ory.t9800-git-p4-basic/git
>>     + nr_tries_left=3D60
>>     + mkdir /home/runner/work/git/git/t/trash directory.t9800-git-p4-bas=
ic/git
>>     + exit 1
>>     + eval_ret=3D1
>>     + :
>>     not ok 20 - submit from detached head
>>     #
>>     #        test_when_finished cleanup_git &&
>>     #        git p4 clone --dest=3D"$git" //depot &&
>>     #        (
>>     #            cd "$git" &&
>>     #            git checkout p4/master &&
>>     #            >detached_head_test &&
>>     #            git add detached_head_test &&
>>     #            git commit -m "add detached_head" &&
>>     #            git config git-p4.skipSubmitEdit true &&
>>     #            git p4 submit &&
>>     #            git p4 rebase &&
>>     #            git log p4/master | grep detached_head
>>     #        )
>>     #
>>   Error: failed: t9800.21 submit from worktree
>>   [...]
>>
>>
>> Is this the best UI we can have for test failures in CI runs? I hope we =
can
>> do better. Having said that, this patch series presents a pretty good st=
art,
>> and offers a basis for future improvements.
>>
>> Johannes Schindelin (9):
>>   ci: fix code style
>>   ci/run-build-and-tests: take a more high-level view
>>   ci: make it easier to find failed tests' logs in the GitHub workflow
>>   ci/run-build-and-tests: add some structure to the GitHub workflow
>>     output
>>   tests: refactor --write-junit-xml code
>>   test(junit): avoid line feeds in XML attributes
>>   ci: optionally mark up output in the GitHub workflow
>>   ci: use `--github-workflow-markup` in the GitHub workflow
>>   ci: call `finalize_test_case_output` a little later
>>
>>  .github/workflows/main.yml           |  12 ---
>>  ci/lib.sh                            |  81 ++++++++++++++--
>>  ci/run-build-and-tests.sh            |  11 ++-
>>  ci/run-test-slice.sh                 |   5 +-
>>  t/test-lib-functions.sh              |   4 +-
>>  t/test-lib-github-workflow-markup.sh |  50 ++++++++++
>>  t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
>>  t/test-lib.sh                        | 128 ++++----------------------
>>  8 files changed, 287 insertions(+), 136 deletions(-)
>>  create mode 100644 t/test-lib-github-workflow-markup.sh
>>  create mode 100644 t/test-lib-junit.sh
>>
>>
>> base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1117%2=
Fdscho%2Fuse-grouping-in-ci-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1117/dsch=
o/use-grouping-in-ci-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1117
>> --
>> gitgitgadget
>>
>>

