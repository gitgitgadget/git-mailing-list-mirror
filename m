Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A35C4167B
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiKVTxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiKVTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:53:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895E8A145
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:53:27 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e8-20020a056a00162800b0056e953c5088so9822541pfc.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyTOXKF5eAJTbMZ8cmvZ06z7DPS8htao1M8Tz8MD9JE=;
        b=U29d1hP2fa/oD+s6n5PuR7Jk85gZdlAEMB15ipZT7kDGAZLk4XfljxeD62o4kH6AeR
         Ci9VE4rEHynE+OkaQEehqO7JeBnx7TmbmzOlls+mNxu19Np7oRJ54PXSzFsNjI5AT9S6
         8mdOoJkoo8VF/z/HeeoSGBxL/ybgfdggU6bPFYtbpP/r69N0d2G80jVF3ALoRSNbu8c7
         Q+DN2B3cZZeGl87byDrRqpDD99hPGp69JGDt6hQnd3jkIAkj4cyFwsVlxWB9AnYAhMtb
         x0emAR+yEdicUN1Q+SPag+GNAGHnWDWYcSY2R3Ks+ZnHiUKIr2yCROLYopHvSx9whKy7
         ZoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NyTOXKF5eAJTbMZ8cmvZ06z7DPS8htao1M8Tz8MD9JE=;
        b=Lp4uqsj9XQpwCzKHxnwAs8w3n1L0jJT/mUvfdhvbqKplRMN8AV54TcnLl3U9DBbN/k
         dEs+c3yY9xR7KHSKf2JinEZQkbthQPyxsaRa8b+zXP0yffLp0s7ix0jogd+s7DdBG70W
         TBkr0nLHKuDEPDXIbulhBRieyZH4NTuP4S7220BWz65wOj0JXqfH+POHPOsVIX0w63h4
         EiXMuMVCE7WUw2HiUHcDeaAoZ76a8iPUpW9Q1lVH1QcdUMUAkSy7d7bVM0qb4rf7gtyz
         z3577gT+mHdT76Ljp7h0jFGt/c/nZKLSC14Qcd/b5HDcfcp8UAoOOPWom8r5Z5EVeGe3
         mqBw==
X-Gm-Message-State: ANoB5pl8MJqdLAO0HMeo42IbBQQVC+ZuefLhgwIUFc4K0DtOIjEQqz02
        8Eomyf6Qgn+JSpmUKpeGIzkCC6GFVvP5Hw==
X-Google-Smtp-Source: AA0mqf46CadRwv/umX2Lsex9+zCJ81LHUZXLaLgWxGEKYWtH5L+lLipCdDYKOtPwrSDeeGSwIs3SWnY1AiR04Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9243:0:b0:56d:dd2a:f6b6 with SMTP id
 3-20020aa79243000000b0056ddd2af6b6mr7333456pfp.30.1669146806965; Tue, 22 Nov
 2022 11:53:26 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:53:25 -0800
In-Reply-To: <patch-v3-3.9-6e10a47c60a-20221119T122853Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <patch-v3-3.9-6e10a47c60a-20221119T122853Z-avarab@gmail.com>
Message-ID: <kl6lfseaepfu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 3/9] submodule--helper: don't use global --super-prefix
 in "absorbgitdirs"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The "fsmonitor--daemon" test adjusted here was added in [3]. To assert
> that it didn't run into the "--super-prefix" message it was asserting
> the output it didn't have. Let's instead assert the full output that
> we *do* have, which we can do here as this is based on a change[4] to
> make it predictable (until [4] it contained absolute paths).
>
> We could also remove the test entirely (as [5] did), but even though
> the initial reason for having it is gone we're still getting some
> marginal benefit from testing the "fsmonitor" and "submodule
> absorbgitdirs" interaction, so let's keep it.

I'm a bit ambivalent on this, especially since we're testing "submodule
absorbgitdirs" output in "fsmonitor" tests, but as you say, there is
some benefit in testing the interaction. I think we'll have to change
the test though...

> The change here to have either a NULL or non-"" string as a
> "super_prefix" instead of the previous arrangement of "" or non-"" is
> somewhat arbitrary. We could also decide to never have to check for
> NULL.
>
> As we'll be changing the rest of the "git --super-prefix" users to the
> same pattern, leaving them all consistent makes sense. Why not pick ""
> over NULL? Because that's how the "prefix" works[6], and having
> "prefix" and "super_prefix" work the same way will be less
> confusing. That "prefix" picked NULL instead of "" is itself
> arbitrary, but as it's easy to make this small bit of our overall API
> consistent, let's go with that.

Okay, I find consistency with "prefix" convincing, and I do hope that we
use "" someday :)

> index 4abc74db2bb..31526937d95 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -866,30 +866,11 @@ test_expect_success 'submodule always visited' '
>  # the submodule, and someone does a `git submodule absorbgitdirs`
>  # in the super, Git will recursively invoke `git submodule--helper`
>  # to do the work and this may try to read the index.  This will
> -# try to start the daemon in the submodule *and* pass (either
> -# directly or via inheritance) the `--super-prefix` arg to the
> -# `git fsmonitor--daemon start` command inside the submodule.
> -# This causes a warning because fsmonitor--daemon does take that
> -# global arg (see the table in git.c)

We've removed mentions of the "--super-prefix", as we should, since
fsmonitor doesn't need to care about "--super-prefix" any more...

> @@ -904,10 +885,12 @@ test_expect_success "stray submodule super-prefix w=
arning" '
> =20
>  	test_path_is_dir super/dir_1/dir_2/sub/.git &&
> =20
> -	GIT_TRACE2_EVENT=3D"$PWD/super-sub.trace" \
> -		git -C super submodule absorbgitdirs &&
> -
> -	! have_t2_error_event super-sub.trace
> +	cat >expect <<-\EOF &&
> +	Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1/dir_2=
/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
> +	EOF
> +	git -C super submodule absorbgitdirs >out 2>actual &&
> +	test_cmp expect actual &&
> +	test_must_be_empty out
>  '

So let's adjust the test to match what we're testing. It's not the
--super-prefix any more, it's the interaction between "submodule
absorbgitdirs" and "fsmonitor--daemon", so perhaps something like:

  diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
  index 31526937d9..9f947341f5 100755
  --- a/t/t7527-builtin-fsmonitor.sh
  +++ b/t/t7527-builtin-fsmonitor.sh
  @@ -868,7 +868,7 @@ test_expect_success 'submodule always visited' '
  # to do the work and this may try to read the index.  This will
  # try to start the daemon in the submodule.

  -test_expect_success "stray submodule super-prefix warning" '
  +test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
          test_when_finished "rm -rf super; \
                              rm -rf sub" &&

  @@ -888,9 +888,14 @@ test_expect_success "stray submodule super-prefix wa=
rning" '
          cat >expect <<-\EOF &&
          Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1=
/dir_2/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
          EOF
  -       git -C super submodule absorbgitdirs >out 2>actual &&
  +       GIT_TRACE2_EVENT=3D"$PWD/.git/trace_absorbgitdirs" \
  +               git -C super submodule absorbgitdirs >out 2>actual &&
          test_cmp expect actual &&
  -       test_must_be_empty out
  +       test_must_be_empty out &&
  +
  +       # Confirm that the trace2 log contains a record of the
  +       # daemon starting.
  +       test_subcommand git fsmonitor--daemon start <.git/trace_absorbgit=
dirs
  '

  # On a case-insensitive file system, confirm that the daemon
