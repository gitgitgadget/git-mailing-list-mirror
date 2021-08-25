Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B726C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23C16109E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhHYXj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:39:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BBCC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:39:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e21so1926853ejz.12
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RDdhiNUx8PCjn0zfKpaqMYNr8P2236ZnDO6U8H2trSc=;
        b=jXwYodzMgbBrzvCTOtn6yqM/Pt2tja3rgHmcUtOMO7Z/WbarHxHi9rOIScR8y6tw6o
         p3iXK8g0hCXWC/129sHxxnrSGbm7Abf3SpXeLYPOg+8j1WeqzoA+VahXC+uA5RkN/2nb
         2St2se4kPvGGWP+xFbsQKj/sNKbGjon2iqjdw+1TUyZSkqzUYqbYCph3YGg4KRWYskm9
         +NXBgbBj+WVUfAB0cgw3h77o5EtR5nB3TTSfbLVtW9O0BJ3KqgrUZUdMDAvcYKVpVYLZ
         8Gs4Wa8vRVbGpbtlsWTZI7TBudkB0XnQ4ymwOR/CwOIUiRdlC948P+dF4eKw5dtT7wFx
         9CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RDdhiNUx8PCjn0zfKpaqMYNr8P2236ZnDO6U8H2trSc=;
        b=j3XQK7dkg/472k8V6RqN2eEp1ChkQx2rLfsyCp4IuzCMyVK5xBj0VrNCnNAdEOvSU5
         6Al12mAXTQ1oAmyJDgAjPJFua2m4+WzZOym9YLkevR88v/19pU9oSMrHo2i2eDfv0yDH
         ssqLvKpQbTHvOiD22Ro+PY/axR1TzYek0YVIsBQ3PSrveP3K8zAYeAdufTh15UMi8UC/
         ieHJzpsL3FUHh3civwbgpRz/ZBzJgKqWjw6GviG4BprIUJ4TQd3TDVXWAVan1T2QdRaP
         RpBABN0X3UllcZsNyOcMoGHxzTpW1cvfeF0bx7RG2XouWfI9SXp1KqcD60VVoCQOAhZC
         p8+w==
X-Gm-Message-State: AOAM533p2jQ7gZqBrJM4IU5Ct4FbZgFSYixglCoVsIL9PMKRMPYiVeXo
        R+RFH8nSTRptk7zz/tKetrk=
X-Google-Smtp-Source: ABdhPJwseoHYwXVT1X6yY06uKvAx0N11Y/QPEkoLJjfPShX5Yv9YvEfowrardiMOE0qDxbkmdoC4YQ==
X-Received: by 2002:a17:906:6dc1:: with SMTP id j1mr1235353ejt.324.1629934748224;
        Wed, 25 Aug 2021 16:39:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i13sm725133edc.48.2021.08.25.16.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:39:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     peff@peff.net, allred.sean@gmail.com, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: [PATCH] checkout: make delayed checkout respect --quiet and
 --no-progress
Date:   Thu, 26 Aug 2021 01:35:20 +0200
References: <YF2b8LLhE0vjc7mg@coredump.intra.peff.net>
 <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
Message-ID: <87bl5lccx0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Matheus Tavares wrote:

> The test section of the patch is a bit long because it checks all the
> verbosity options related to the progress report, and it also tests both
> the check_updates() and checkout_worktree() code paths. If that is
> overkill, I can remove some tests.

More exhaustive tests are generally nice..

> +test_expect_success PERL 'setup for progress tests' '
> +	git init progress &&
> +	(
> +		cd progress &&
> +		git config filter.delay.process "rot13-filter.pl delay-progress.log clean smudge delay" &&
> +		git config filter.delay.required true &&
> +
> +		echo "*.a filter=delay" >.gitattributes &&
> +		touch test-delay10.a &&
> +		git add . &&
> +		git commit -m files
> +	)
> +'

This doesn't seem to depend on PERL, should this really be a skip_all at
the top if we don't have the TTY prereq, i.e. we shouldn't bother?

> +
> +for mode in pathspec branch
> +do
> +	case "$mode" in
> +	pathspec) opt='.' ;;
> +	branch) opt='-f HEAD' ;;
> +	esac
> +
> +	test_expect_success PERL,TTY "delayed checkout shows progress by default only on tty ($mode checkout)" '

All of the PERL,TTY can just be TTY, since TTY itself checks PERL.

> +		(
> +			cd progress &&
> +			rm -f *.a delay-progress.log &&
> +			test_terminal env GIT_PROGRESS_DELAY=0 git checkout $opt 2>err &&
> +			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
> +			grep "Filtering content" err &&

This seems to need TTY...

> +			rm -f *.a delay-progress.log &&
> +			GIT_PROGRESS_DELAY=0 git checkout $opt 2>err &&
> +			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
> +			! grep "Filtering content" err

But this one doesn't, perhaps it could be a non-TTY test?

> +		)
> +	'
> +
> +	test_expect_success PERL,TTY "delayed checkout ommits progress with --quiet ($mode checkout)" '
> +		(
> +			cd progress &&
> +			rm -f *.a delay-progress.log &&
> +			test_terminal env GIT_PROGRESS_DELAY=0 git checkout --quiet $opt 2>err &&
> +			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
> +			! grep "Filtering content" err
> +		)
> +	'
> +
> +	test_expect_success PERL,TTY "delayed checkout honors --[no]-progress ($mode checkout)" '
> +		(
> +			cd progress &&
> +			rm -f *.a delay-progress.log &&
> +			test_terminal env GIT_PROGRESS_DELAY=0 git checkout --no-progress $opt 2>err &&
> +			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
> +			! grep "Filtering content" err &&
> +
> +			rm -f *.a delay-progress.log &&
> +			test_terminal env GIT_PROGRESS_DELAY=0 git checkout --quiet --progress $opt 2>err &&
> +			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
> +			grep "Filtering content" err
> +		)
> +	'

It looks like these tests could be split into one helper function which
just passed params for e.g. whether the "Filtering content" grep was
negated, and what command should be run.

Also if possible the two sections of the test could be split up, and
then the "rm -rf" could just be a "test_when_finished" at the top...
