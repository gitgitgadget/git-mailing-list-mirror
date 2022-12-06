Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65DC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 19:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLFTSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLFTR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 14:17:59 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4F36C7C
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 11:17:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so8667153ejc.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 11:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCvH/HCCNhnoupqAmqIweCNMaIoM3p4LFQDYSritYQE=;
        b=l+OMNT5X7LaBPg19z6zG/O4bd3z15MUTOvUFgTD1/215kAQlnUut/wLZvEkvL91DvR
         cZkkt6kPcMnkM9V6Tksb/k6oZyjOMXmmRkTdObm8H/u7i3wrPg85QQybTFUQBCwHNcpb
         9ddYOS/EPJvnnsWRjEtq1/IB/eiIIyeixAVm9nu8Tgw2feg1pMUSVLFA2C9TpNpFl20b
         IBbYFmy0WwSwbl9Vet6KRm4bJbvXkZjVgeNeEKyLpV+w/1yIAC4QRkvmk1knYOOhOQ9X
         K8druruF++YnHXneGz3uEkE8Eg7tOLwD3KZehPfAFEw07WIc6pIhYxp84UelFPcGd83Y
         H1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCvH/HCCNhnoupqAmqIweCNMaIoM3p4LFQDYSritYQE=;
        b=4OZK9mc8GYnAIGrRQ4ypcQRQFM/oqyhDzIkwZi2yMjo2OrnUpJOeABkIn3VsrFAJxl
         E2zfm5RKDxmFVEo10oNUAT7Tfih3XxlzILWMsqFbck8sl8T2cV3kyRlSE7eRKlyFxbJH
         s4UiKxbPKwcxCmzEMdVKPNioverLSQhlnG/VJedLmqfsSc9KQ8aXHz8afBHVdUvkOKZh
         9gYRzqqzjbL7pStb4+Md1R0agH21kYd05qXO2uHsMXxn+wwjsNfoSV+FqTWrrbe9hVqi
         tpidxBrKJgS6Y1hRzMv8lG4pMv6ZADvc9BLekjKuzpUJc2Tn+65xkKIVnjkMKT4Eziye
         s7Fg==
X-Gm-Message-State: ANoB5pmLYHW4Ii8mHWukfGMIpqqf32Z3Y/BVtlC8K804dHj1GNXsSAAM
        tZ9sy/Um//ZKutejqQkqdKxJRwK+g7ZCKA==
X-Google-Smtp-Source: AA0mqf5WKW8dieaPS0VJ4/HDfK23xBuyVdgXVoghItHTyXznKSc9crGVoMMFn118pB2quqIX5Fv0HQ==
X-Received: by 2002:a17:906:6681:b0:7ae:732d:bc51 with SMTP id z1-20020a170906668100b007ae732dbc51mr12237338ejo.549.1670354276636;
        Tue, 06 Dec 2022 11:17:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906305600b007c0e6d6bd10sm3417792ejd.132.2022.12.06.11.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:17:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2dRz-0043Sc-1u;
        Tue, 06 Dec 2022 20:17:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Date:   Tue, 06 Dec 2022 19:55:43 +0100
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
 <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
Message-ID: <221206.86sfhsbau4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> The reason why this approach was not even considered in Git for Windows
> is that in 2007, there was already a motion on the table to use Git's
> own diff machinery to perform comparisons in Git's test suite, but it
> was dismissed in https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/

I think you mixed up your links there, that's the "no, that should be
fine" from 2022, but it contains the link to the 2007 message you seem
to be talking about.

> as undesirable because tests might potentially succeed due to bugs in
> the diff machinery when they should not succeed, and those bugs could
> therefore hide regressions that the tests try to prevent.
>
> By the time Git for Windows' `mingw-test-cmp` in C was finally
> contributed to the Git mailing list, reviewers agreed that the diff
> machinery had matured enough and should be used instead.

I think it's fine to dogfood it like this, but I've been pointing out to
you[1] that this will hide segfaults etc. in "git" as we negate the exit
code of "test_cmp" in some places.

E.g. let's produce this stack overflow:

	diff --git a/diff-no-index.c b/diff-no-index.c
	index 9a8b09346bd..1c4a9e5c351 100644
	--- a/diff-no-index.c
	+++ b/diff-no-index.c
	@@ -279,6 +279,7 @@ int diff_no_index(struct rev_info *revs,
	 
	 	fixup_paths(paths, &replacement);
	 
	+	revs++;
	 	revs->diffopt.skip_stat_unmatch = 1;
	 	if (!revs->diffopt.output_format)
	 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;

Then compiling with SANITIZE=address and running:

	GIT_TEST_CMP="GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --" ./t9351-fast-export-anonymize.sh --run=1,17 -vixd

Will produce (less relevant bits elided):
	
	expecting success of 9351.17 'idents are shared': 
		[...]
		test_line_count = 1 unique &&
		! test_cmp authors committers
	
	[...]
	+ test 1 = 1
	+ test_cmp authors committers
	+ test 2 -ne 2
	+ eval GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol -- "$@"
	+ GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol -- authors committers
	=================================================================
	==2865782==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffc6d64d0f4 at pc 0x00000077fa4d bp 0x7ffc6d64bcc0 sp 0x7ffc6d64bcb8
	WRITE of size 4 at 0x7ffc6d64d0f4 thread T0
	    #0 0x77fa4c in diff_no_index diff-no-index.c:292
	[...]
	ok 17 - idents are shared
	
	# passed all 17 test(s)
	1..17

I.e. we'll proclaim "all tests passed", even though we segfaulted. I
think this direction will fix it for you:

	diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
	index 77047e250dc..29a2d3a03a7 100755
	--- a/t/t9351-fast-export-anonymize.sh
	+++ b/t/t9351-fast-export-anonymize.sh
	@@ -133,7 +133,7 @@ test_expect_success 'idents are shared' '
	 	git log --all --format="%cn <%ce>" >committers &&
	 	sort -u committers >unique &&
	 	test_line_count = 1 unique &&
	-	! test_cmp authors committers
	+	test_cmp ! authors committers
	 '
	 
	 test_done
	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
	index 452fe9bc8aa..d640b4b7881 100644
	--- a/t/test-lib-functions.sh
	+++ b/t/test-lib-functions.sh
	@@ -1239,8 +1239,25 @@ test_expect_code () {
	 # - not all diff versions understand "-u"
	 
	 test_cmp () {
	+	local negate= &&
	+	local exit_code= &&
	+	if test "$1" = "!"
	+	then
	+		negate=t &&
	+		shift
	+	fi &&
	 	test "$#" -ne 2 && BUG "2 param"
	-	eval "$GIT_TEST_CMP" '"$@"'
	+	if test -n "$GIT_TEST_CMP_BUILTIN"
	+	then
	+		if test -n "$negate"
	+		then
	+			test_must_fail env GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol -- "$@"
	+		else
	+			GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol -- "$@"
	+		fi
	+	else
	+		eval "$GIT_TEST_CMP" '"$@"'
	+	fi
	 }
	 
	 # Check that the given config key has the expected value.
	diff --git a/t/test-lib.sh b/t/test-lib.sh
	index f8c6205e08f..0a5f8e7c7fc 100644
	--- a/t/test-lib.sh
	+++ b/t/test-lib.sh
	@@ -1546,7 +1546,7 @@ case $uname_s in
	 	test_set_prereq SED_STRIPS_CR
	 	test_set_prereq GREP_STRIPS_CR
	 	test_set_prereq WINDOWS
	-	GIT_TEST_CMP="GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --"
	+	GIT_TEST_CMP_BUILTIN=t
	 	;;
	 *CYGWIN*)
	 	test_set_prereq POSIXPERM

I.e. it's fine to start invoking "git" in one of the
test-lib-functions.sh, but it's not OK to do so without also ensuring
that we're properly checking its exit code.

The above diff fixes it only for t9351-fast-export-anonymize.sh, we'd
also need to change "! test_cmp " to "test_cmp ! " elsewhere, but that's
a rather easy mechanical replacement.

1. https://lore.kernel.org/git/221119.86wn7rdugi.gmgdl@evledraar.gmail.com/
