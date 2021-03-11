Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E135CC433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E564FC9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 11:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhCKLoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhCKLoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 06:44:20 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B3C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 03:44:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bm21so45580374ejb.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 03:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7Z7SE0YofjIwUP4smcNc4rur+g0v0lF/Bj/Vhe+dM3o=;
        b=P82t9heRiSkfjnne/11ZvE5YvPhAOSVACQZDrDVqGrTFCr2K2RmKjsP5bC8hb/k1sK
         PQnz8oGhFwTI894VuvU3ktZ0UxGp160ezJPtH2gPDmiSpSBbuIHT6pEZkwkhT9/VDCxy
         /MEj1OBzQPwLONR7nXqEokQbaisUBJlnciK2OxXSElwSVWL4w2FNDoan2OgtwaJxgS8f
         TEAPg1CGDFPlSX7dZ09u2Np2h7TWio0+muL9orLo36Xq5GALHG9GiMXq+WzBSQhB9RAj
         EKBJs3gsMYzkzmRKdvSPxLjkv4DLavzaBDPWsXXLa9LvqX8KtvZ4ZtD6zOl67k9Tyuuo
         yNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7Z7SE0YofjIwUP4smcNc4rur+g0v0lF/Bj/Vhe+dM3o=;
        b=BvmH67Sb8mflDOe4NmOpOpb+GKSyjQVSp4q4Mz6qqF523D3MEZ/5D+7MSW68IWyxTR
         5MAV6Nd4ggMHA+ZDfVY6S51/Z/rjHnwLTNbuU/LFAktzGh6/NmTtGzPxnlN+s7mlJdxe
         A15WI7/YCE82DASLENrc+tDmyhs99vBbnyjHSGWQl6hwOo0tWbT+DriVb77AthAgVq8S
         jMEKtiK/Noh3kGYhFbdwZLNaRf/PNc22oYqBfNV/Uc+rQTchzo6qCmeY5w8tM9Vmetzp
         tccHFhNXyelyqAbdfh7dRFREKuckqmI0n9rhK+SaE0efGBXZS3ciQ9pc+90Wp56fw+O7
         Qu7g==
X-Gm-Message-State: AOAM531zHB7OLbVFs6fV2TuDm8W3hLjE8zHgEgdj0yaiF2jKNcEesPD5
        tjih9y8qaoMY2/cWcetjA84=
X-Google-Smtp-Source: ABdhPJxTw9O57ClbJHHWUMmnbineZDTESVayoGZBQKv05u9vOzgGi3q6iOw5zxquZCHNxFoRMq5j3A==
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr2684712ejf.25.1615463058948;
        Thu, 11 Mar 2021 03:44:18 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s18sm1170818ejc.79.2021.03.11.03.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:44:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
References: <xmqqmtvafl62.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqmtvafl62.fsf@gitster.g>
Date:   Thu, 11 Mar 2021 12:44:17 +0100
Message-ID: <87r1klhq3y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Junio C Hamano wrote:

Some notes, mostly on my own topics:

> * ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
>  - tests: get rid of $_x05 from the test suite
>  - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
>  - test-lib: remove unused $_x40 and $_z40 variables
>  - git-bisect: remove unused SHA-1 $x40 shell variable

FWIW (mostly for other readers) I suggested in
https://lore.kernel.org/git/87tupigf02.fsf@evledraar.gmail.com/ just now
that we drop 4/4.

I thought we had better testing for --abbrev (turns out only I do with
local patches), so unrelated to this we've had some regressions in its
handling due to lack of testing (which this would remove more of...).

>  Will merge to 'next'.
>  In the longer term, we might want to remove filter-branch and nudge
>  folks to more modern tools.

Did we ever have a re-discussion of adding Elijah's
git-filter-replacement-whose-name-I-always-forget to git.git? :)

> [...]
> [Graduated to 'master']
>
> * jt/transfer-fsck-across-packs-fix (2021-03-05) 1 commit
>   (merged to 'next' on 2021-03-07 at c79f295216)
>  + fetch-pack: do not mix --pack_header and packfile uri

LGTM, see below about ab/fsck-api-cleanup though...

>  The code to fsck objects received across multiple packs during a
>  single git fetch session has been broken when the packfile URI
>  feature was in use.  A workaround has been added by disabling the
>  codepath that avoids keeping a packfile that is too small.
>
> [...]
> * hn/reftable (2021-03-08) 17 commits
>  - SQUASH??? calloc(nmemb,size)
>  - SQUASH??? allow t0031 to run with any default branch name
>  - Add "test-tool dump-reftable" command.
>  - git-prompt: prepare for reftable refs backend
>  - Reftable support for git-core
>  - reftable: rest of library
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: add LICENSE
>  - init-db: set the_repository->hash_algo early on

It would be nice to have a post-release revival of this, Han-Wen, any
plans for that?

> * ab/fsck-api-cleanup (2021-02-18) 10 commits
>  - fsck.h: update FSCK_OPTIONS_* for object_name
>  - fsck.c: give "FOREACH_MSG_ID" a more specific name
>  - fsck.c: undefine temporary STR macro after use
>  - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
>  - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
>  - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
>  - fsck.c: move definition of msg_id into append_msg_id()
>  - fsck.c: rename variables in fsck_set_msg_type() for less confusion
>  - fsck.h: use "enum object_type" instead of "int"
>  - fsck.h: indent arguments to of fsck_set_msg_type
>
>  Preliminary fsck API clean-up.
>
>  Expecting a reroll.
>  cf. <xmqqczwxc8bw.fsf@gitster.g>

I think this note at least needs to be updated to say the re-roll exists
at https://lore.kernel.org/git/20210306110439.27694-1-avarab@gmail.com/

You suggested that it needed to consider,
jt/transfer-fsck-across-packs-fix, that's landed now (per your above
note) and the two topics work nicely together.

So RC period and all that, but I'd be keen to have that version picked
up, the cleanup is making any subsequent patching of fsck.[ch] hard...

> * ab/make-cocci-dedup (2021-03-05) 4 commits
>  - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>  - Makefile/coccicheck: allow for setting xargs concurrency
>  - Makefile/coccicheck: speed up and fix bug with duplicate hunks
>  - Makefile/coccicheck: add comment heading for all SPATCH flags
>
>  An attempt to speed up the coccicheck target with incorrect
>  results.
>
>  A reroll exists to address correctness issue, but not picked up.

Any reason for not picked up other than "rc period etc...". I'm
confident the patch at
https://lore.kernel.org/git/20210306192525.15197-1-avarab@gmail.com/
addresses the intra-series bug, and the whole thing solves outstanding
bugs on master.

> * ab/read-tree (2021-03-08) 6 commits
>  - tree.h API: remove "stage" parameter from read_tree_recursive()
>  - tree.h API: remove support for starting at prefix != ""
>  - ls-files: refactor away read_tree()
>  - ls-files: don't needlessly pass around stage variable
>  - tree.c API: move read_tree() into builtin/ls-files.c
>  - ls-files tests: add meaningful --with-tree tests
>
>  Code simplification by removing support for a caller that is long gone.
>
>  Looked good.

Thanks, I'm confident in the correctness of that one (unlike some of my
other outstanding stuf...) :)

> * ab/unexpected-object-type (2021-03-08) 7 commits
>  - tag: don't misreport type of tagged objects in errors
>  - object tests: add test for unexpected objects in tags
>  - object.c: add a utility function for "expected type X, got Y"
>  - tree.c: fix misindentation in parse_tree_gently()
>  - oid_object_info(): return "enum object_type"
>  - object.c: make type_from_string() return "enum object_type"
>  - object.c: refactor type_from_string_gently()
>
>  Error reporting upon object type mismatch has been improved
>
>  Looked good.

It still loks scary to me :)

I also plan at least a minor re-roll, based on current feedback.

But I've had no feedback on 7/7, which is the real meaty chang in the
series:
https://lore.kernel.org/git/20210308200426.21824-8-avarab@gmail.com/

It would be nice to know if that's beacuse others have nothing to add,
or it just hasn't been looked over.

This whole "we have !obj->parsed objects around, and don't really know
what they are, and later have to correct ourselves" logic is existing,
and AFAICT the best way around it in this narrow case is 7/7.

But maybe there's some more ideal way around having the funny-looking
lookup_{commit,blob,tree,tag}_type() API functions. Or maybe not...

> * ab/remote-write-config-in-camel-case (2021-02-24) 2 commits
>   (merged to 'next' on 2021-03-01 at a01bd0d8e4)
>  + remote: write camel-cased *.pushRemote on rename
>  + remote: add camel-cased *.tagOpt key, like clone
>
>  Update C code that sets a few configuration variables when a remote
>  is configured so that it spells configuration variable names in the
>  canonical camelCase.
>
>  Will cook in 'next'.

Just a point of clarification, are all the "Will cook in 'next'" lines
here to be read equivalently to "Unless something comes up, will be in
the first major post-release merge down to master?".

I.e. no pre-release merge of next->master is expected.

I think that's fine b.t.w., I've just been wondering if I could better
understand (and hopefully document) the flow around releases vis-a-vis
topics, I find myself scouring your Git Google Calendar & "git log"
around releases every time, and then forgetting .. :)

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
>  Needs review.
>  cf. <20210216115801.4773-1-avarab@gmail.com>

If anyone would like faster pickaxe reviews of this would be most
welcome. It's not faster yet with this, but it's the required prep work.

Alternatively, what do you think about picking this up up to 15/22?:
https://lore.kernel.org/git/20210216115801.4773-16-avarab@gmail.com/

Up until that point it's all trivial code changes and testing.

> [...]
> * rs/pretty-describe (2021-03-01) 4 commits
>   (merged to 'next' on 2021-03-01 at bee9248828)
>  + pretty: document multiple %(describe) being inconsistent
>  + t4205: assert %(describe) test coverage
>   (merged to 'next' on 2021-02-25 at 2347ed8fe6)
>  + pretty: add merge and exclude options to %(describe)
>  + pretty: add %(describe)
>
>  "git log --format='...'" learned "%(describe)" placeholder.

As an aside did anyone look into making most of ./builtin/describe.c a
new ./describe.c library? I had a quick aborted attempt at doing that,
but it didn't seem like it would be all that hard...
