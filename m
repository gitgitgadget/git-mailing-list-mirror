Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300CC433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2186661108
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhDJA4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhDJA4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 20:56:48 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681FC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 17:56:34 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so1763651ool.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mq3m3vCnPWXHkywyMtPiTnSV8S5aRDYDdnWnT5K8m3g=;
        b=HyQzpP1CXnDpBk1+PKYL55noB9IuGo89CVZ4oJ/6wWif6sMXbWWHvs41uCtqJZ/r3c
         6EhNEToW9Lp0VE9UTGmPj4rOLai0RCU9giSEu482hPX1rVARt/6u85H/5nXTC4IRr/XF
         BC4ceQ/yaHcuDvgOFqNMY+6XyHFW3l+R9lXve2Uw79Tv0cO6ZMXwfGMDo6zHzv5vjmRF
         CSdV2jFmYngRRYZU+u9ox2+X3cBofmc6G2N+J0I3DUgkiIDCnKoxO8bcXE4e+0eFhSD+
         ZQ+5FurPiMat7WoxRhRv3ARTFYLbxP7QrOMtV5Eee811/CUuYdRZj0nj67alT68Xdh1w
         75Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mq3m3vCnPWXHkywyMtPiTnSV8S5aRDYDdnWnT5K8m3g=;
        b=icgkwa3VHddjc511rxcTduufSdaZdJfZerasFyp3KSOE7sYk0KUJ74+CNFtz36quqr
         WfNvQ4AFmAwe5ZdZ/sKEHhszP1sdLtT3V9G23L7J2yZ2iELM3SW/wDxxXeaq3CRAchuo
         NePdNR3lEIO2LTfVvr0sVponJ5lZdYcjS70IXyTCwpgr2Slt9jllI0AbVJ+1w84bi4Ag
         3RPRu4wSvV7tT2kJlWq66f21EJfzFq9b4c836WCMe+Ner4N8ha3tOIAx2DBgLQFfqr90
         DEahi1sl9D+Q6FIx4D17VliyFwQQUhga3Qb1bokJaL6c8bwEPavOa5AR3z1aFuIxZA7s
         y9KQ==
X-Gm-Message-State: AOAM532eJlHFTANGv3/JQFIlygbD4DNBet7E3BW7pLEBuAOeNJKpyXPO
        2ulgKJTP2/DaSvWpVoiEr6Q=
X-Google-Smtp-Source: ABdhPJxQV0o8YUDItPx8ejRiFRYDPDhsOm1UB26K+JQvYK7tHTRmzKiWzlYNft3dsRZSUGGpfF2uOg==
X-Received: by 2002:a4a:e9a2:: with SMTP id t2mr13985396ood.15.1618016193779;
        Fri, 09 Apr 2021 17:56:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e556:d73b:6b67:5b9f? ([2600:1700:e72:80a0:e556:d73b:6b67:5b9f])
        by smtp.gmail.com with ESMTPSA id f29sm963225ots.22.2021.04.09.17.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 17:56:33 -0700 (PDT)
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
 <87o8eqjx0w.fsf@evledraar.gmail.com> <87im4yjspp.fsf@evledraar.gmail.com>
 <243a0aa1-7c0a-d2ab-49ff-8ea8cacc1b81@gmail.com>
 <87im4vgsvx.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36aa6837-722c-9ef0-84cc-77e982db9f6e@gmail.com>
Date:   Fri, 9 Apr 2021 20:56:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87im4vgsvx.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2021 3:28 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Apr 09 2021, Derrick Stolee wrote:
> 
>> On 4/7/2021 6:26 AM, Ævar Arnfjörð Bjarmason wrote:
>>> I think converting the whole thing to something like the WIP/RFC patch
>>> below is much better and more readable.
>>
>> This is an interesting approach. I don't see you using the ERR that you
>> are inputting anywhere, so that seems like an unnecessary bloat to the
>> consumers. But maybe I haven't discovered all of the places where this
>> would be useful, but it seems better to pipe stderr to a file for later
>> comparison when needed.
> 
> Yes, it's probably not a good default here. For the test-lib.sh tests
> there's check_sub_test_lib_test and check_sub_test_lib_test_err, most of
> the tests only test stdout.
> 
>>> +test_expect_process_tree () {
>>> +	depth= &&
>>> +	>actual &&
>>> +	cat >expect &&
>>> +	cat <&3 >expect.err
>>> +	while test $# != 0
>>> +	do
>>> +		case "$1" in
>>> +		--depth)
>>> +			depth="$2"
>>> +			shift
>>> +			;;
>>> +		*)
>>> +			break
>>> +			;;
>>> +		esac
>>> +		shift
>>> +	done &&
>> Do you have an example where this is being checked? Or can depth
>> be left as 1 for now?
> 
> It can probably be hardcoded, but I was hoping someone more familiar
> with trace2 would chime in, but I'm fairly sure there's not a way to do
> it without parsing the existing output with either some clever
> grep/awk-ing of the PERF output, or stateful parsing of the JSON.
> 
> I thought that for git maintenance tests perhaps something wanted to
> assert that we didn't have maintenance invoking maintenance, or that
> something expected to prune refs really invoked the relevant prune
> command via "gc".
> 
>>> +	log="$(pwd)/proc-tree.txt" &&
>>> +	>"$log" &&
>>> +	GIT_TRACE2_PERF="$log" "$@" 2>actual.err &&
>>> +	grep "child_start" proc-tree.txt >proc-tree-start.txt || : &&
>>> +	if test -n "$depth"
>>> +	then
>>> +		grep " d$depth " proc-tree-start.txt >tmp.txt || : &&
>>> +		mv tmp.txt proc-tree-start.txt
>>> +	fi &&
>>> +	sed -e 's/^.*argv:\[//' -e 's/\]$//' <proc-tree-start.txt >actual &&
>>> +	test_cmp expect actual &&
>>> +	test_cmp expect.err actual.err
>>> +} 7>&2 2>&4
>>
>> I think similar ideas could apply to test_region. Giving it a try
>> now.
> 
> Probably, I didn't even notice that one...

I gave this a few hours today, and I'm giving up. I'm the first to
admit that I don't have the correct scripting skills to do some of
these things.

I've got what I tried below. It certainly looks like it would work.
It solves the problem of "what if the test is flaky?" by ensuring that
all subcommands (at depth 0) match the inputs exactly.

However, the problem comes when trying to make that work for all of
the maintenance tests, specifically the 'incremental-repack' task.
That task dynamically computes a --batch-size=X parameter, and that
is not stable across runs of the script.

This was avoided in the past by only checking for the first of three
subcommands when verifying that the 'incremental-repack' task worked.
That is, except for the EXPENSIVE test that checks that the --batch-size
maxes out at 2g.

The thing that might make these changing parameters work is to allow
the specified lines be a _prefix_ of the actual parameters. Or, let
each line be a pattern that is checked against that line. Issues come
up with how to handle this line-by-line check that I was unable to
overcome.

The good news is that the idea of adding a '--prefetch' option to
'git fetch' makes the change to t7900-maintenance.sh much easier,
making this change to test_subcommand less of a priority.

I include my attempt here as a patch. Feel free to take whatever
you want of it, or none of it and start over. I do think that it
makes the test script look much nicer.

Thanks,
-Stolee

-- >8 --

From 449d098f2a13860f44b2e6fb96fb2dd5872b511b Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 9 Apr 2021 08:42:26 -0400
Subject: [PATCH 1/2] test-lib: add test_subcommands
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test_subcommand helper in test-lib-functions.sh satisfied a need to
check for certain subcommands in Git processes. This is especially
needed in t7900-maintenance.sh to ensure that the maintenance builtin
properly calls certain subcommands based on command-line options, config
values, and the state of the repository.

However, test_subcommand has some complexities in its use that can be
improved. First, it requires that the caller knows to create a log file
with GIT_TRACE2_EVENT then supply that to test_subcommand. Further, it
only checks that some exact subcommands exist or do not exist. It does
not guarantee that the list of subcommands exactly matches a given list.
Because of this drawback, the tests that check a subcommand does _not_
run are particularly flaky to slight changes in behavior.

Introduce a new helper, test_subcommands, that resolves these drawbacks:

1. It runs the supplied command and handles the trace log itself.

2. It takes a list of commands overs stdin and compares this to the
   complete list of subcommands run from the top-level command.

The helper does not test that the full subcommand tree matches, because
that would cause tests to be too fragile to changes unrelated to the
component being tested. This could easily be extended to allow the full
tree with an option, if desired.

To ensure we only check the first level, use GIT_TRACE2_PERF output and
scan for " d0 " in the rows that include the "child_start" event. The
last column includes a way to scrape the subcommand itself from the
trace. Sometimes arguments are quoted, such as when passing a refspec
with '*' to the subcommand. This makes it difficult to create a matching
string within the single-quoted test definitions, so strip these single
quotes from the arguments before matching the input.

Only modify one test in t7900-maintenance.sh. The rest of the callers to
test_subcommand will be converted to test_subcommands in a later change.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7900-maintenance.sh  | 16 +++++++---------
 t/test-lib-functions.sh | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c0..e170ab7862 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -30,15 +30,13 @@ test_expect_success 'help text' '
 '
 
 test_expect_success 'run [--auto|--quiet]' '
-	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" \
-		git maintenance run 2>/dev/null &&
-	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" \
-		git maintenance run --auto 2>/dev/null &&
-	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
-		git maintenance run --no-quiet 2>/dev/null &&
-	test_subcommand git gc --quiet <run-no-auto.txt &&
-	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
-	test_subcommand git gc --no-quiet <run-no-quiet.txt
+	test_subcommands git maintenance run --quiet <<-EOF &&
+	git gc --quiet
+	EOF
+	test_subcommands git maintenance run --auto --quiet </dev/null &&
+	test_subcommands git maintenance run --no-quiet <<-EOF
+	git gc --no-quiet
+	EOF
 '
 
 test_expect_success 'maintenance.auto config option' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..53ffeb07f8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1658,6 +1658,30 @@ test_subcommand () {
 	fi
 }
 
+# Run a command and ensure it succeeds. Use the
+# GIT_TRACE2_PERF logs to ensure that every subcommand
+# run by this top-level Git process is exactly the
+# set supplied over stdin.
+#
+# Redirects stderr to a file named "err". This can
+# be used by tests, but it also provides consistent
+# use of isatty(2) which can affect subcommand calls.
+test_subcommands () {
+	local log line &&
+
+	cat >expect &&
+
+	log="$(pwd)"/subcommand-trace.txt &&
+
+	GIT_TRACE2_PERF="$log" "$@" 2>err &&
+	grep "child_start" "$log" | grep " d0 " >processes || : &&
+
+	sed -e 's/^.*argv:\[//' -e 's/\]$//' -e "s/'//g" <processes >actual &&
+	test_cmp expect actual &&
+
+	rm -f "$log" expect actual processes
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
2.31.1.vfs.0.0

--- >8 ---

And here is the follow-up that attempts to change the rest of
the tests in t7900-maintenance.sh. However, this leads to flaky
tests because of the --batch-size changes.

--- >8 ---

From 61f142ba7fcde8ae2a84f18005f384a4544b7741 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 9 Apr 2021 11:13:42 -0400
Subject: [PATCH 2/2] t7900: convert to test_subcommands

Replace the remaining uses of test_subcommand with test_subcommands,
allowing us to delete the old helper.

Most of these replacements are straightforward. However, some are a bit
more subtle, specifically because we now are checking the full ordered
set of subcommands. Some places we were only testing one of multiple
subcommands that would be run by a task. These are expanded to include
the full set.

When working with the prefetch task, the refspecs that are passed to the
subcommand are normally quoted with single quotes in the GIT_TRACE2_PERF
output, but those characters are removed in test_subcommands, allowing
our tests in t7900-maintenance.sh to avoid escaping such quotes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7900-maintenance.sh  | 285 +++++++++++++++++++---------------------
 t/test-lib-functions.sh |  33 -----
 2 files changed, 133 insertions(+), 185 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e170ab7862..8861435dcf 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -40,78 +40,65 @@ test_expect_success 'run [--auto|--quiet]' '
 '
 
 test_expect_success 'maintenance.auto config option' '
-	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand git maintenance run --auto --quiet <default &&
-	GIT_TRACE2_EVENT="$(pwd)/true" \
-		git -c maintenance.auto=true \
-		commit --quiet --allow-empty -m 2 &&
-	test_subcommand git maintenance run --auto --quiet  <true &&
-	GIT_TRACE2_EVENT="$(pwd)/false" \
-		git -c maintenance.auto=false \
-		commit --quiet --allow-empty -m 3 &&
-	test_subcommand ! git maintenance run --auto --quiet  <false
+	test_subcommands git commit --allow-empty -m 1 <<-EOF &&
+	git maintenance run --auto --no-quiet
+	EOF
+	test_subcommands git -c maintenance.auto=true \
+		commit --allow-empty -m 2 <<-EOF &&
+	git maintenance run --auto --no-quiet
+	EOF
+	test_subcommands git -c maintenance.auto=false \
+		commit --allow-empty -m 3 </dev/null
 '
 
 test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
-	GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run 2>err &&
-	test_subcommand ! git gc --quiet <run-config.txt &&
-	test_subcommand git commit-graph write --split --reachable --no-progress <run-config.txt
+
+	# This also verifies that "git gc" is not run.
+	test_subcommands git maintenance run --quiet <<-EOF
+	git commit-graph write --split --reachable --no-progress
+	EOF
 '
 
 test_expect_success 'run --task=<task>' '
-	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
-		git maintenance run --task=commit-graph 2>/dev/null &&
-	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" \
-		git maintenance run --task=gc 2>/dev/null &&
-	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
-		git maintenance run --task=commit-graph 2>/dev/null &&
-	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
-		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
-	test_subcommand ! git gc --quiet <run-commit-graph.txt &&
-	test_subcommand git gc --quiet <run-gc.txt &&
-	test_subcommand git gc --quiet <run-both.txt &&
-	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
-	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
-	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
+	test_subcommands git maintenance run --task=commit-graph <<-EOF &&
+	git commit-graph write --split --reachable --no-progress
+	EOF
+	test_subcommands git maintenance run --task=gc <<-EOF &&
+	git gc --quiet
+	EOF
+	test_subcommands git maintenance run --task=commit-graph --task=gc <<-EOF
+	git gc --quiet
+	git commit-graph write --split --reachable --no-progress
+	EOF
 '
 
 test_expect_success 'core.commitGraph=false prevents write process' '
-	GIT_TRACE2_EVENT="$(pwd)/no-commit-graph.txt" \
-		git -c core.commitGraph=false maintenance run \
-		--task=commit-graph 2>/dev/null &&
-	test_subcommand ! git commit-graph write --split --reachable --no-progress \
-		<no-commit-graph.txt
+	test_subcommands git -c core.commitGraph=false maintenance \
+		run --task=commit-graph <<-EOF
+	EOF
 '
 
 test_expect_success 'commit-graph auto condition' '
 	COMMAND="maintenance run --task=commit-graph --auto --quiet" &&
+	cat >did-run.txt <<-EOF &&
+	git commit-graph write --split --reachable --no-progress
+	EOF
 
-	GIT_TRACE2_EVENT="$(pwd)/cg-no.txt" \
-		git -c maintenance.commit-graph.auto=1 $COMMAND &&
-	GIT_TRACE2_EVENT="$(pwd)/cg-negative-means-yes.txt" \
-		git -c maintenance.commit-graph.auto="-1" $COMMAND &&
+	test_subcommands git -c maintenance.commit-graph.auto=1 $COMMAND </dev/null &&
+	test_subcommands git -c maintenance.commit-graph.auto="-1" $COMMAND <did-run.txt &&
 
 	test_commit first &&
 
-	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
-		git -c maintenance.commit-graph.auto=0 $COMMAND &&
-	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
-		git -c maintenance.commit-graph.auto=1 $COMMAND &&
+	test_subcommands git -c maintenance.commit-graph.auto=0 $COMMAND </dev/null &&
+	test_subcommands git -c maintenance.commit-graph.auto="1" $COMMAND <did-run.txt &&
 
 	git commit --allow-empty -m "second" &&
 	git commit --allow-empty -m "third" &&
 
-	GIT_TRACE2_EVENT="$(pwd)/cg-two-satisfied.txt" \
-		git -c maintenance.commit-graph.auto=2 $COMMAND &&
-
-	COMMIT_GRAPH_WRITE="git commit-graph write --split --reachable --no-progress" &&
-	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-no.txt &&
-	test_subcommand $COMMIT_GRAPH_WRITE <cg-negative-means-yes.txt &&
-	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-zero-means-no.txt &&
-	test_subcommand $COMMIT_GRAPH_WRITE <cg-one-satisfied.txt &&
-	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
+	test_subcommands git -c maintenance.commit-graph.auto=3 $COMMAND </dev/null &&
+	test_subcommands git -c maintenance.commit-graph.auto=2 $COMMAND <did-run.txt
 '
 
 test_expect_success 'run --task=bogus' '
@@ -138,10 +125,11 @@ test_expect_success 'prefetch multiple remotes' '
 	git -C clone2 switch -c two &&
 	test_commit -C clone1 one &&
 	test_commit -C clone2 two &&
-	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
+	test_subcommands git maintenance run --task=prefetch <<-EOF &&
+	git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/*
+	git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/*
+	EOF
 	test_path_is_missing .git/refs/remotes &&
 	git log prefetch/remote1/one &&
 	git log prefetch/remote2/two &&
@@ -215,24 +203,23 @@ test_expect_success 'loose-objects task' '
 
 test_expect_success 'maintenance.loose-objects.auto' '
 	git repack -adk &&
-	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
-		git -c maintenance.loose-objects.auto=1 maintenance \
-		run --auto --task=loose-objects 2>/dev/null &&
-	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
+	test_subcommands git -c maintenance.loose-objects.auto=1 maintenance \
+		run --auto --task=loose-objects </dev/null &&
 	printf data-A | git hash-object -t blob --stdin -w &&
-	GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
-		git -c maintenance.loose-objects.auto=2 \
-		maintenance run --auto --task=loose-objects 2>/dev/null &&
-	test_subcommand ! git prune-packed --quiet <trace-loA &&
+	test_subcommands git -c maintenance.loose-objects.auto=2 \
+		maintenance run --auto --task=loose-objects </dev/null &&
 	printf data-B | git hash-object -t blob --stdin -w &&
-	GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
-		git -c maintenance.loose-objects.auto=2 \
-		maintenance run --auto --task=loose-objects 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <trace-loB &&
-	GIT_TRACE2_EVENT="$(pwd)/trace-loC" \
-		git -c maintenance.loose-objects.auto=2 \
-		maintenance run --auto --task=loose-objects 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <trace-loC
+
+	test_subcommands git -c maintenance.loose-objects.auto=2 \
+		maintenance run --auto --task=loose-objects <<-EOF &&
+	git prune-packed --quiet
+	git pack-objects --quiet .git/objects/pack/loose
+	EOF
+
+	test_subcommands git -c maintenance.loose-objects.auto=2 \
+		maintenance run --auto --task=loose-objects <<-EOF
+	git prune-packed --quiet
+	EOF
 '
 
 test_expect_success 'incremental-repack task' '
@@ -307,38 +294,40 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
 	git maintenance run --task=loose-objects &&
 
 	# Now run the incremental-repack task and check the batch-size
-	GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
-		--task=incremental-repack 2>/dev/null &&
-	test_subcommand git multi-pack-index repack \
-		 --no-progress --batch-size=2147483647 <run-2g.txt
+	test_subcommands git maintenance run \
+		--task=incremental-repack <<-EOF
+	git multi-pack-index repack --no-progress --batch-size=2147483647
+	EOF
 '
 
 test_expect_success 'maintenance.incremental-repack.auto' '
 	git repack -adk &&
 	git config core.multiPackIndex true &&
 	git multi-pack-index write &&
-	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
-		-c maintenance.incremental-repack.auto=1 \
-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
-	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
+	test_subcommands git -c maintenance.incremental-repack.auto=1 \
+		maintenance run --auto --task=incremental-repack </dev/null &&
+
 	test_commit A &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
 	EOF
-	GIT_TRACE2_EVENT=$(pwd)/trace-A git \
-		-c maintenance.incremental-repack.auto=2 \
-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
-	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
+
+	test_subcommands git -c maintenance.incremental-repack.auto=2 \
+		maintenance run --auto --task=incremental-repack </dev/null &&
+
 	test_commit B &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
 	EOF
-	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
-		-c maintenance.incremental-repack.auto=2 \
-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
-	test_subcommand git multi-pack-index write --no-progress <trace-B
+
+	test_subcommands git -c maintenance.incremental-repack.auto=2 \
+		maintenance run --auto --task=incremental-repack <<-EOF
+	git multi-pack-index write --no-progress
+	git multi-pack-index expire --no-progress
+	git multi-pack-index repack --no-progress --batch-size=469
+	EOF
 '
 
 test_expect_success 'pack-refs task' '
@@ -346,11 +335,12 @@ test_expect_success 'pack-refs task' '
 	do
 		git branch -f to-pack/$n HEAD || return 1
 	done &&
-	GIT_TRACE2_EVENT="$(pwd)/pack-refs.txt" \
-		git maintenance run --task=pack-refs &&
+	test_subcommands git maintenance run --task=pack-refs <<-EOF &&
+	git pack-refs --all --prune
+	EOF
+
 	ls .git/refs/heads/ >after &&
-	test_must_be_empty after &&
-	test_subcommand git pack-refs --all --prune <pack-refs.txt
+	test_must_be_empty after
 '
 
 test_expect_success '--auto and --schedule incompatible' '
@@ -371,26 +361,26 @@ test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
 	git config maintenance.incremental-repack.enabled true &&
 	git config maintenance.incremental-repack.schedule weekly &&
 
-	GIT_TRACE2_EVENT="$(pwd)/hourly.txt" \
-		git maintenance run --schedule=hourly 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <hourly.txt &&
-	test_subcommand ! git commit-graph write --split --reachable \
-		--no-progress <hourly.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress <hourly.txt &&
+	cat >hourly <<-EOF &&
+	git prune-packed --quiet
+	EOF
 
-	GIT_TRACE2_EVENT="$(pwd)/daily.txt" \
-		git maintenance run --schedule=daily 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <daily.txt &&
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <daily.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress <daily.txt &&
+	cat >daily <<-EOF &&
+	git prune-packed --quiet
+	git commit-graph write --split --reachable --no-progress
+	EOF
 
-	GIT_TRACE2_EVENT="$(pwd)/weekly.txt" \
-		git maintenance run --schedule=weekly 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <weekly.txt &&
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <weekly.txt &&
-	test_subcommand git multi-pack-index write --no-progress <weekly.txt
+	cat >weekly <<-EOF &&
+	git prune-packed --quiet
+	git multi-pack-index write --no-progress
+	git multi-pack-index expire --no-progress
+	git multi-pack-index repack --no-progress --batch-size=655
+	git commit-graph write --split --reachable --no-progress
+	EOF
+
+	test_subcommands git maintenance run --schedule=hourly <hourly &&
+	test_subcommands git maintenance run --schedule=daily <daily &&
+	test_subcommands git maintenance run --schedule=weekly <weekly
 '
 
 test_expect_success 'maintenance.strategy inheritance' '
@@ -402,58 +392,49 @@ test_expect_success 'maintenance.strategy inheritance' '
 	test_when_finished git config --unset maintenance.strategy &&
 	git config maintenance.strategy incremental &&
 
-	GIT_TRACE2_EVENT="$(pwd)/incremental-hourly.txt" \
-		git maintenance run --schedule=hourly --quiet &&
-	GIT_TRACE2_EVENT="$(pwd)/incremental-daily.txt" \
-		git maintenance run --schedule=daily --quiet &&
-	GIT_TRACE2_EVENT="$(pwd)/incremental-weekly.txt" \
-		git maintenance run --schedule=weekly --quiet &&
-
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <incremental-hourly.txt &&
-	test_subcommand ! git prune-packed --quiet <incremental-hourly.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress \
-		<incremental-hourly.txt &&
-	test_subcommand ! git pack-refs --all --prune \
-		<incremental-hourly.txt &&
-
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <incremental-daily.txt &&
-	test_subcommand git prune-packed --quiet <incremental-daily.txt &&
-	test_subcommand git multi-pack-index write --no-progress \
-		<incremental-daily.txt &&
-	test_subcommand ! git pack-refs --all --prune \
-		<incremental-daily.txt &&
-
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <incremental-weekly.txt &&
-	test_subcommand git prune-packed --quiet <incremental-weekly.txt &&
-	test_subcommand git multi-pack-index write --no-progress \
-		<incremental-weekly.txt &&
-	test_subcommand git pack-refs --all --prune \
-		<incremental-weekly.txt &&
+	# Modify this default for simplicity
+	git config maintenance.prefetch.enabled false &&
+
+	test_subcommands git maintenance run --schedule=hourly <<-EOF &&
+	git commit-graph write --split --reachable --no-progress
+	EOF
+
+	test_subcommands git maintenance run --schedule=daily <<-EOF &&
+	git prune-packed --quiet
+	git multi-pack-index write --no-progress
+	git multi-pack-index expire --no-progress
+	git multi-pack-index repack --no-progress --batch-size=655
+	git commit-graph write --split --reachable --no-progress
+	EOF
+
+	test_subcommands git maintenance run --schedule=weekly <<-EOF &&
+	git prune-packed --quiet
+	git multi-pack-index write --no-progress
+	git multi-pack-index expire --no-progress
+	git multi-pack-index repack --no-progress --batch-size=655
+	git commit-graph write --split --reachable --no-progress
+	git pack-refs --all --prune
+	EOF
 
 	# Modify defaults
 	git config maintenance.commit-graph.schedule daily &&
 	git config maintenance.loose-objects.schedule hourly &&
 	git config maintenance.incremental-repack.enabled false &&
 
-	GIT_TRACE2_EVENT="$(pwd)/modified-hourly.txt" \
-		git maintenance run --schedule=hourly --quiet &&
-	GIT_TRACE2_EVENT="$(pwd)/modified-daily.txt" \
-		git maintenance run --schedule=daily --quiet &&
-
-	test_subcommand ! git commit-graph write --split --reachable \
-		--no-progress <modified-hourly.txt &&
-	test_subcommand git prune-packed --quiet <modified-hourly.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress \
-		<modified-hourly.txt &&
-
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <modified-daily.txt &&
-	test_subcommand git prune-packed --quiet <modified-daily.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress \
-		<modified-daily.txt
+	test_subcommands git maintenance run --schedule=hourly <<-EOF &&
+	git prune-packed --quiet
+	EOF
+
+	test_subcommands git maintenance run --schedule=daily <<-EOF &&
+	git prune-packed --quiet
+	git commit-graph write --split --reachable --no-progress
+	EOF
+
+	test_subcommands git maintenance run --schedule=weekly <<-EOF
+	git prune-packed --quiet
+	git commit-graph write --split --reachable --no-progress
+	git pack-refs --all --prune
+	EOF
 '
 
 test_expect_success 'register and unregister' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 53ffeb07f8..444dd3c6c7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1625,39 +1625,6 @@ test_path_is_hidden () {
 	return 1
 }
 
-# Check that the given command was invoked as part of the
-# trace2-format trace on stdin.
-#
-#	test_subcommand [!] <command> <args>... < <trace>
-#
-# For example, to look for an invocation of "git upload-pack
-# /path/to/repo"
-#
-#	GIT_TRACE2_EVENT=event.log git fetch ... &&
-#	test_subcommand git upload-pack "$PATH" <event.log
-#
-# If the first parameter passed is !, this instead checks that
-# the given command was not called.
-#
-test_subcommand () {
-	local negate=
-	if test "$1" = "!"
-	then
-		negate=t
-		shift
-	fi
-
-	local expr=$(printf '"%s",' "$@")
-	expr="${expr%,}"
-
-	if test -n "$negate"
-	then
-		! grep "\[$expr\]"
-	else
-		grep "\[$expr\]"
-	fi
-}
-
 # Run a command and ensure it succeeds. Use the
 # GIT_TRACE2_PERF logs to ensure that every subcommand
 # run by this top-level Git process is exactly the
-- 
2.31.1.vfs.0.0



