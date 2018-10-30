Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96F51F454
	for <e@80x24.org>; Tue, 30 Oct 2018 21:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeJaGvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 02:51:39 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45933 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 02:51:39 -0400
Received: by mail-ed1-f49.google.com with SMTP id t10-v6so11884586eds.12
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Iut2MXHlp/K7c2jUOrjvZoVNansXTn0eXcw43KGvhy0=;
        b=Pcu9qbqcjfA02csak4AWJWBlsDjbGiDYTGNa72VqAdNXU5WeyFnUAsKIaUwMA1FANF
         /gzLcz5/kwcbYMSeI4YG5iN7uQptWeaD/jv800ERp7vsP+PRJNOJtnS55WykU1Q6dGnN
         Fel2FfInIZBu4/PXeuweiVGWzm5cBTRrnQLorp3vC03T5N3Ca1f+qCs4B2VLYRL2Acfp
         +XzYQOOUeGA3Zh/r4LRGy01PGCbuqS/ZErcWNW52+vJ4gzNDi5/sWB+HY/8oDCva1hEd
         emxajiZ8JFXcHO7yG2BSRF5MAqYCT8jTPi6kGwV3qJFEB2UVZnL75z4PrjE5dxaDtnVY
         qmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Iut2MXHlp/K7c2jUOrjvZoVNansXTn0eXcw43KGvhy0=;
        b=FkJhEJveqMtOJ1eh+eiZ6cwzNR4DcaZAgeqehwzc2AQXSjzN+AMURH1+sUGTh9SXnH
         2I5rPIAxsE0+nsolwONepheqtkDKmfbay7XkdC523p7j7JsEjOJQLmYpFtNw9z3/pRAs
         0nnV+xLVPWaej9IzekqE7zRW/OqECErSzG6BkYISCzZTLPYlWCmkT3k3+Cli0rPR3IrP
         6vMhqRGQ/wLY0bcb+lXf4StMVEF7AlFJonKbQ+B1elNHQmHTKdJF3nnHyOOl5uuQAGBo
         Eg5Y389njOKB3z6P846PcGNA4SO5jx9nPDNeHLMkoZ6wJIqkzen0SvYal5hjkLVSffrv
         kFFQ==
X-Gm-Message-State: AGRZ1gLBO1qcDgjmio5p5J3Cm9NTYfuknWCctOLOYE5RD0LdAopGuXNI
        dw1xX8XXWD8gocBmV2VgQ90=
X-Google-Smtp-Source: AJdET5fAlGF9+jLpj98zfHjrsDH1s3xfBDBXHgJl6ptJpYEz9HK9PJfNXGCJujzHq2sDezBfy+6cug==
X-Received: by 2002:a50:896c:: with SMTP id f41-v6mr230993edf.130.1540936585590;
        Tue, 30 Oct 2018 14:56:25 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id g92-v6sm740747ede.71.2018.10.30.14.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 14:56:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Infinite loop regression in git-fsck in v2.12.0
References: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net> <878t2fkxrn.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <878t2fkxrn.fsf@evledraar.gmail.com>
Date:   Tue, 30 Oct 2018 22:56:22 +0100
Message-ID: <877ehzksjd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 30 2018, Ævar Arnfjörð Bjarmason wrote:

> The test is easy, just add a 'git fsck' at the end of t5000-tar-tree.sh,
> but more generally it seems having something like GIT_TEST_FSCK=true is
> a good idea. We do a bunch of stress testing of the object store in the
> test suite that we're unlikely to encounter in the wild.
>
> Of course my idea of how to do that in my
> <20181030184331.27264-3-avarab@gmail.com> would be counterproductive,
> i.e. it seems we want to catch all the cases where there's a bad fsck,
> just that it returns in a certain way.
>
> So maybe a good approach would be that we'd annotate all those test
> whose fsck fails with "this is how it should fail", and run those tests
> under GIT_TEST_FSCK=true, and GIT_TEST_FSCK=true would also be asserting
> that no tests other than those marked as failing the fsck check at the
> end fail it.

WIP patch for doing that:

    diff --git a/Makefile b/Makefile
    index b08d5ea258..ca624c381f 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -723,6 +723,7 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
     TEST_BUILTINS_OBJS += test-dump-split-index.o
     TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
     TEST_BUILTINS_OBJS += test-example-decorate.o
    +TEST_BUILTINS_OBJS += test-env-bool.o
     TEST_BUILTINS_OBJS += test-genrandom.o
     TEST_BUILTINS_OBJS += test-hashmap.o
     TEST_BUILTINS_OBJS += test-index-version.o
    diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
    index 5df8b682aa..c4481085c4 100644
    --- a/t/helper/test-tool.c
    +++ b/t/helper/test-tool.c
    @@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
     	{ "dump-fsmonitor", cmd__dump_fsmonitor },
     	{ "dump-split-index", cmd__dump_split_index },
     	{ "dump-untracked-cache", cmd__dump_untracked_cache },
    +	{ "env-bool", cmd__env_bool },
     	{ "example-decorate", cmd__example_decorate },
     	{ "genrandom", cmd__genrandom },
     	{ "hashmap", cmd__hashmap },
    diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
    index 71f470b871..f7845fbc56 100644
    --- a/t/helper/test-tool.h
    +++ b/t/helper/test-tool.h
    @@ -13,6 +13,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
     int cmd__dump_fsmonitor(int argc, const char **argv);
     int cmd__dump_split_index(int argc, const char **argv);
     int cmd__dump_untracked_cache(int argc, const char **argv);
    +int cmd__env_bool(int argc, const char **argv);
     int cmd__example_decorate(int argc, const char **argv);
     int cmd__genrandom(int argc, const char **argv);
     int cmd__hashmap(int argc, const char **argv);
    diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
    index 635918505d..92fbce2920 100755
    --- a/t/t1305-config-include.sh
    +++ b/t/t1305-config-include.sh
    @@ -313,4 +313,8 @@ test_expect_success 'include cycles are detected' '
     	test_i18ngrep "exceeded maximum include depth" stderr
     '

    +GIT_FSCK_FAILS=true
    +GIT_FSCK_FAILS_TEST='
    +	test_i18ngrep "exceeded maximum include depth" fsck.err
    +'
     test_done
    diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
    index 14520913af..06abf84ef4 100755
    --- a/t/t3103-ls-tree-misc.sh
    +++ b/t/t3103-ls-tree-misc.sh
    @@ -22,4 +22,10 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
     	test_must_fail git ls-tree -r HEAD
     '

    +GIT_FSCK_FAILS=true
    +GIT_FSCK_FAILS_TEST='
    +	test_i18ngrep "invalid sha1 pointer in cache-tree" fsck.err &&
    +	test_i18ngrep "broken link from" fsck.out &&
    +	test_i18ngrep "missing tree" fsck.out
    +'
     test_done
    diff --git a/t/test-lib.sh b/t/test-lib.sh
    index 897e6fcc94..d4ebb94998 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -454,6 +454,8 @@ GIT_EXIT_OK=
     trap 'die' EXIT
     trap 'exit $?' INT

    +GIT_FSCK_FAILS=
    +
     # The user-facing functions are loaded from a separate file so that
     # test_perf subshells can have them too
     . "$TEST_DIRECTORY/test-lib-functions.sh"
    @@ -790,6 +792,25 @@ test_at_end_hook_ () {
     }

     test_done () {
    +	if test_have_prereq TEST_FSCK
    +	then
    +		desc='git fsck at end (due to GIT_TEST_FSCK)'
    +		if test -n "$GIT_FSCK_FAILS"
    +		then
    +			test_expect_success "$desc (expected to fail)" '
    +				test_must_fail git fsck 2>fsck.err >fsck.out
    +			'
    +			test_expect_success "$descriptor (expected to fail) -- assert failure mode" "
    +				test_path_exists fsck.err &&
    +				test_path_exists fsck.out &&
    +				$GIT_FSCK_FAILS_TEST
    +			"
    +		else
    +			test_expect_success "$desc" '
    +				git fsck
    +			'
    +		fi
    +	fi
     	GIT_EXIT_OK=t

     	if test -z "$HARNESS_ACTIVE"
    @@ -1268,3 +1289,5 @@ test_lazy_prereq CURL '
     test_lazy_prereq SHA1 '
     	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
     '
    +
    +test_lazy_prereq TEST_FSCK 'test-tool env-bool GIT_TEST_FSCK'

Could be made prettier by turning that work in test_done() into a
utility function, but is (I think) worth the effort to do.

Jeff: Gotta turn in for the night, but maybe Something you're maybe
interested in carrying forward for this fix? It's not that much work to
mark up the failing tests, there's 10-20 of them from some quick
eyeballing.
