Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E929C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645156146D
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhCaKQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhCaKQG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 06:16:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD9C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:16:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hq27so29211650ejc.9
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uoopxdM0WtpLwY5KEiti7O8s5lwf0QuJlGAbedqtE8s=;
        b=kBlRObNkFls768X9vT94s9JxbqAGKx1LzSxWkyxlc5dMmPy/NXf5LOHYYQYUODGMLl
         k/fUD6rfiVtZq3OTf3T2NPMz6W/wLlVi0wklhWcvpY3kprd+buIjYj1JNwWPSgX30Ydg
         Av17zvdAe/uklp46a7wwRKrmSL19z/HZWNwvujacMSMil6l3CV5KsVpJjZwLLU6UODsY
         VsLGca0z4G63c59QyOQnFhjlPL45SYsT4EqmSDmXcK+miFNzLNQvfQyZ7raghh7+2xqu
         tMgyuApbV6fGHyTSj0IhL/fRLPe2Ey4GJ3aqVlykzXYnbCSxnoBxMuBkjw7IwlFufs1K
         Sjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uoopxdM0WtpLwY5KEiti7O8s5lwf0QuJlGAbedqtE8s=;
        b=Ct0YyoDSZgAX6EzOl8Y+ZRnhn2YwMEt8f6A2YV1yHXAhhvtzmreX/AI9C+x6401pxN
         ux8qrxmDrLSXasLrs2/xLNLMqPp1QQifTdyrkDIfCSm0k5JiLeG1rcGNUORnTpbzXmt6
         d0w8wjIznLkxZcI3Su3xvrof9kXGKIhVyZL8o2ONEqVlQjgYz76XSjwvjcw5yxTfBzp8
         v1h83+bm0/orH5aU5VJSwXZv7TPXaVsuiwg7IwaqDXAYwsRFHewSgYhv9g0crKjJcTNu
         njRXakEHMzuFNs3TQzB/7skjPTQ2iRrWuXcRy/BdGmM1SRoSrPRusrZ3S8ValLZAFrvv
         4NTw==
X-Gm-Message-State: AOAM530uGrCS0xCzvO9/aKO7AMovNesxqRWZ4slx2PrwtXUvwng+vBO0
        JUypj/kHEatwO0AZ+MHRxa4=
X-Google-Smtp-Source: ABdhPJy4jMCahF77DCtUXlvHhALBk3fHjERJLpng5qnKzdteE5VnhmhR9bf4w5asMHCMoYqyPwZJUQ==
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr2622675ejv.383.1617185764278;
        Wed, 31 Mar 2021 03:16:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g1sm1243202edv.6.2021.03.31.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 03:16:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2021, #08; Tue, 30)
References: <xmqqv99889hh.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqv99889hh.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 12:16:03 +0200
Message-ID: <87y2e3ljbw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 31 2021, Junio C Hamano wrote:

Notes on my outstanding things that you've picked up:

> * ab/userdiff-tests (2021-03-23) 10 commits
>  - blame tests: simplify userdiff driver test
>  - blame tests: don't rely on t/t4018/ directory
>  - userdiff: remove support for "broken" tests
>  - userdiff tests: list builtin drivers via test-tool
>  - userdiff tests: explicitly test "default" pattern
>  - userdiff: add and use for_each_userdiff_driver()
>  - userdiff style: normalize pascal regex declaration
>  - userdiff style: declare patterns with consistent style
>  - userdiff style: re-order drivers in alphabetical order
>  - userdiff: refactor away the parse_bool() function
>
>  A bit of code clean-up and a lot of test clean-up around userdiff
>  area.
>
>  A reroll promised "at some point".
>  cf. <87im5gp2ze.fsf@evledraar.gmail.com>

Sooner than later FWIW, have it on my "do it soon!" todo list.

> * ab/make-tags-quiet (2021-03-27) 1 commit
>  - Makefile: add QUIET_GEN to "tags" and "TAGS" targets

FWIW I think the status on your side (and I'll re-roll) is "waiting on
re-rolled commit message", per
https://lore.kernel.org/git/xmqqpmzjom7n.fsf@gitster.g/

> * ab/fsck-api-cleanup (2021-03-28) 19 commits
>  - fetch-pack: use new fsck API to printing dangling submodules
>  - fetch-pack: use file-scope static struct for fsck_options
>  - fetch-pack: don't needlessly copy fsck_options
>  - fsck.c: move gitmodules_{found,done} into fsck_options
>  - fsck.c: add an fsck_set_msg_type() API that takes enums
>  - fsck.c: pass along the fsck_msg_id in the fsck_error callback
>  - fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
>  - fsck.c: give "FOREACH_MSG_ID" a more specific name
>  - fsck.c: undefine temporary STR macro after use
>  - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
>  - fsck.h: re-order and re-assign "enum fsck_msg_type"
>  - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
>  - fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
>  - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
>  - fsck.c: remove (mostly) redundant append_msg_id() function
>  - fsck.c: rename variables in fsck_set_msg_type() for less confusion
>  - fsck.h: use "enum object_type" instead of "int"
>  - fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
>  - fsck.c: refactor and rename common config callback
>
>  Fsck API clean-up.
>
>  Will merge to 'next'?
>  cf. <xmqq5z1alnmu.fsf@gitster.g>

Hopefully :)

> * ab/unexpected-object-type (2021-03-27) 10 commits
>  - tag: don't misreport type of tagged objects in errors
>  - object tests: add test for unexpected objects in tags
>  - object.c: add and use oid_is_type_or_die_msg() function
>  - object.c: add a utility function for "expected type X, got Y"
>  - tree.c: fix misindentation in parse_tree_gently()
>  - object-name.c: make dependency on object_type order more obvious
>  - object-file.c: make oid_object_info() return "enum object_type"
>  - object.c: make type_from_string() return "enum object_type"
>  - object.c: refactor type_from_string_gently()
>  - object.c: stop supporting len == -1 in type_from_string_gently()
>
>  Error reporting upon object type mismatch has been improved
>
>  cf. <YGBL88lYheyFmwCg@coredump.intra.peff.net>
>  ... we would be much better off to say something like "somebody
>  expected X to be a commit, but now somebody else expects it to be a
>  blob", which is all that we can reliably say.

I suggested in
https://lore.kernel.org/git/87r1jym6d0.fsf@evledraar.gmail.com/ that my
code is fine and I shouldn't change anything, but let's see what Jeff
King thinks :)

You also had a nit/refactoring suggestion in
https://lore.kernel.org/git/xmqq35wdfaw5.fsf@gitster.g/ will wait on
Jeff's reply though...

> * ab/describe-tests-fix (2021-03-01) 10 commits
>  - test-lib: return 1 from test_expect_{success,failure}
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated-tag option to "test_commit"
>  - describe tests: always assert empty stderr from "describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>
>  Various updates to tests around "git describe"
>
>  Expecting a reroll.
>  cf. <xmqq1rcj6hzr.fsf@gitster.g>

Yes, I said in the last What's Cooking I'd do this soon, still
outstanding sorry, ...

> * ab/pickaxe-pcre2 (2021-02-18) 24 commits
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: support early exit in xdiff_outf()
>  - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
>  - pickaxe -S: slightly optimize contains()
>  - pickaxe: rename variables in has_changes() for brevity
>  - pickaxe -S: support content with NULs under --pickaxe-regex
>  - pickaxe: assert that we must have a needle under -G or -S
>  - pickaxe: refactor function selection in diffcore-pickaxe()
>  - perf: add performance test for pickaxe
>  - pickaxe/style: consolidate declarations and assignments
>  - diff.h: move pickaxe fields together again
>  - pickaxe: die when --find-object and --pickaxe-all are combined
>  - pickaxe: die when -G and --pickaxe-regex are combined
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - test-lib functions: add --printf option to test_commit
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib-functions: document and test test_commit --no-tag
>  - grep/pcre2 tests: reword comments referring to kwset
>  - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
>  - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.
>
>  Needs (hopefully the final round of) review.

That's the note from the last What's Cooking, but since then you've
reviewed it in
https://lore.kernel.org/git/20210216115801.4773-1-avarab@gmail.com/

Needs a re-roll per that, just noting the changed status here.
