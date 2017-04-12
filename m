Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0F01FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbdDLWpu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 18:45:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33728 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754864AbdDLWps (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 18:45:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id r36so4832280lfi.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v+aNxMjhxnAPC2gSVDVzoetGs2Grhw871FYfyGnOSFo=;
        b=SPAICMPYsl8V+FlsQy2NYKr+4rQ2lsTvs+/KE/NvAVD8fvLv6LKY4t62uPGYFh1tGo
         DOEp2KRcVjh4uG/tUkHy3Knsvt/6Y9NxLaKrev2LtyG3vUoTtPhKgyhoEQ+D1+ahaCZ9
         JYDXHhqkWL8295t/bm0BNVG+4tXF1Oi9a3yrWng3Ukgfh9lLCghgkSBy5KNGTmN40tIH
         B0+QzmxYoKa7PXDItMlSdq6x1foxRc63hw1Dzurp0cYWpkEx+ceICK81/NYDTeGBnnsS
         WWSQz/aS8ZXCvmD7fc02xWFjZJvTvW/ZCDwmfpFK0cleeYF/hK5rKBDNb/pfkJFjqeQa
         1v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v+aNxMjhxnAPC2gSVDVzoetGs2Grhw871FYfyGnOSFo=;
        b=jTizUTzqA2wM3nk30VehdOZTqrUwzoBxVHH74P0e0s/fM190pfJ2ENz919FKkwxz5m
         8/1iK2uBM9jpmtltjJY+RywKobd+8jg0hcNfFQyCFc/wnmCqJq2joCuVActup7d2tmME
         eQbbEvtpw3Wb11PUaTYP0T9g4Zts4MeGvyxpZKBeJdzgG/5arHRETPinr/+lDXLf29nv
         7RrxVnML0BjoKu1BkSFbWZj82EQbOIjrOMGEkG71sKFe9l7k9rPnGwIJnr1DceYL/b7i
         r19J7FUhlMYAYJLsqPw3osuwYlT2UcmJkR4smU+7znIl8BeYZC5fsK7KsNKO5NdkonX4
         0ZkA==
X-Gm-Message-State: AN3rC/5oAqu3yv2ih8K2CNCLdrLBatyD4uZVa6oJs0p5QdQwAJuvo97m
        zuwN89+lqYm4SwvVTl8IhCPl7JGSmDK7
X-Received: by 10.46.76.9 with SMTP id z9mr7684lja.135.1492037146182; Wed, 12
 Apr 2017 15:45:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Wed, 12 Apr 2017 15:45:25 -0700 (PDT)
In-Reply-To: <20170412165851.GA79499@google.com>
References: <20170412003911.1142-1-jacob.e.keller@intel.com> <20170412165851.GA79499@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 12 Apr 2017 15:45:25 -0700
Message-ID: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
Subject: Re: [PATCH] ls-files: properly prepare submodule environment
To:     Brandon Williams <bmwill@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 9:58 AM, Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Jacob Keller wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Since commit e77aa336f116 ("ls-files: optionally recurse into
>> submodules", 2016-10-07) ls-files has known how to recurse into
>> submodules when displaying files.
>>
>> Unfortunately this code does not work as expected. Initially, it
>> produced results indicating that a --super-prefix can't be used from
>> a subdirectory:
>>
>>   fatal: can't use --super-prefix from a subdirectory
>>
>> After commit b58a68c1c187 ("setup: allow for prefix to be passed to git
>> commands", 2017-03-17) this behavior changed and resulted in repeated
>> calls of ls-files with an expanding super-prefix.
>>
>> This recursive expanding super-prefix appears to be the result of
>> ls-files acting on the super-project instead of on the submodule files.
>>
>> We can fix this by properly preparing the submodule environment when
>> setting up the submodule process. This ensures that the command we
>> execute properly reads the directory and ensures that we correctly
>> operate in the submodule instead of repeating oureslves on the
>> super-project contents forever.
>>
>> While we're here lets also add some tests to ensure that ls-files works
>> with recurse-submodules to catch these issues in the future.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> I found this fix on accident after looking at git-grep code and
>> comparing how ls-files instantiated the submodule. Can someone who knows
>> more about submodules explain the reasoning better for this fix?
>> Essentially we "recurse" into the submodule folder, but still operate as
>> if we're at the root of the project but with a new prefix. So then we
>> keep recursing into the submodule forever.
>
> The reason why this fix is required is that the env var GIT_DIR is set
> to be the parents gitdir.  When recursing the childprocess just uses the
> parents gitdir instead of its own causing it to recurse into itself
> again and again.  The child process's environment needs to have the
> GIT_DIR var cleared so that the child will do discovery and actually
> find its own gitdir.

Right. That makes sense, but that raises the question of how or where
this worked in the first place?

>
>>
>> I also added some tests here, and I *definitely* think this should be a
>> maintenance backport into any place which supports ls-files
>> --recurse-submodules, since as far as I can tell it is otherwise
>> useless.
>>
>> There were no tests for it, so I added some based on git-grep tests. I
>> did not try them against the broken setups, because of the endless
>> recursion.
>
> There are tests for ls-files --recurse-submodules in
> t3007-ls-files-recurse-submodules.sh, though it looks like this
> particular case (which triggers this bug) maybe didn't have any tests.
> I'm actually unsure of why the existing tests didn't catch this (I'm
> probably just bad at writing tests).

It seems to me like this would be a problem for any setup with
submodules, no? Or is it specific case for me? I have a submodule
within a submodule and I'm not setting GIT_DIR manually myself. I want
to isolate exactly what scenario fails here so that the commit
description can be accurate and we know for sure the test cases cover
it.

Thanks,
Jake

>
>
>>
>>  builtin/ls-files.c                     |   4 +
>>  t/t3080-ls-files-recurse-submodules.sh | 162 +++++++++++++++++++++++++++++++++
>>  2 files changed, 166 insertions(+)
>>  create mode 100755 t/t3080-ls-files-recurse-submodules.sh
>>
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index d449e46db551..e9b3546ca053 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -15,6 +15,7 @@
>>  #include "string-list.h"
>>  #include "pathspec.h"
>>  #include "run-command.h"
>> +#include "submodule.h"
>>
>>  static int abbrev;
>>  static int show_deleted;
>> @@ -203,6 +204,9 @@ static void show_gitlink(const struct cache_entry *ce)
>>       struct child_process cp = CHILD_PROCESS_INIT;
>>       int status;
>>
>> +     prepare_submodule_repo_env(&cp.env_array);
>> +     argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
>
> Yes these lines need to be included in order to prepare the environment.
> Thanks for catching that.
>
>> +
>>       if (prefix_len)
>>               argv_array_pushf(&cp.env_array, "%s=%s",
>>                                GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
>> diff --git a/t/t3080-ls-files-recurse-submodules.sh b/t/t3080-ls-files-recurse-submodules.sh
>> new file mode 100755
>> index 000000000000..6788a8f09635
>> --- /dev/null
>> +++ b/t/t3080-ls-files-recurse-submodules.sh
>> @@ -0,0 +1,162 @@
>> +#!/bin/sh
>> +
>> +test_description='Test ls-files recurse-submodules feature
>> +
>> +This test verifies the recurse-submodules feature correctly lists files across
>> +submodules.
>> +'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup directory structure and submodule' '
>> +     echo "foobar" >a &&
>> +     mkdir b &&
>> +     echo "bar" >b/b &&
>> +     git add a b &&
>> +     git commit -m "add a and b" &&
>> +     git init submodule &&
>> +     echo "foobar" >submodule/a &&
>> +     git -C submodule add a &&
>> +     git -C submodule commit -m "add a" &&
>> +     git submodule add ./submodule &&
>> +     git commit -m "added submodule"
>> +'
>> +
>> +test_expect_success 'ls-files correctly lists files in a submodule' '
>> +     cat >expect <<-\EOF &&
>> +     .gitmodules
>> +     a
>> +     b/b
>> +     submodule/a
>> +     EOF
>> +
>> +     git ls-files --recurse-submodules >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ls-files and basic pathspecs' '
>> +     cat >expect <<-\EOF &&
>> +     submodule/a
>> +     EOF
>> +
>> +     git ls-files --recurse-submodules -- submodule >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ls-files and nested submodules' '
>> +     git init submodule/sub &&
>> +     echo "foobar" >submodule/sub/a &&
>> +     git -C submodule/sub add a &&
>> +     git -C submodule/sub commit -m "add a" &&
>> +     git -C submodule submodule add ./sub &&
>> +     git -C submodule add sub &&
>> +     git -C submodule commit -m "added sub" &&
>> +     git add submodule &&
>> +     git commit -m "updated submodule" &&
>> +
>> +     cat >expect <<-\EOF &&
>> +     .gitmodules
>> +     a
>> +     b/b
>> +     submodule/.gitmodules
>> +     submodule/a
>> +     submodule/sub/a
>> +     EOF
>> +
>> +     git ls-files --recurse-submodules >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ls-files using relative path' '
>> +     test_when_finished "rm -rf parent sub" &&
>> +     git init sub &&
>> +     echo "foobar" >sub/file &&
>> +     git -C sub add file &&
>> +     git -C sub commit -m "add file" &&
>> +
>> +     git init parent &&
>> +     echo "foobar" >parent/file &&
>> +     git -C parent add file &&
>> +     mkdir parent/src &&
>> +     echo "foobar" >parent/src/file2 &&
>> +     git -C parent add src/file2 &&
>> +     git -C parent submodule add ../sub &&
>> +     git -C parent commit -m "add files and submodule" &&
>> +
>> +     # From top works
>> +     cat >expect <<-\EOF &&
>> +     .gitmodules
>> +     file
>> +     src/file2
>> +     sub/file
>> +     EOF
>> +     git -C parent ls-files --recurse-submodules >actual &&
>> +     test_cmp expect actual &&
>> +
>> +     # Relative path to top
>> +     cat >expect <<-\EOF &&
>> +     ../.gitmodules
>> +     ../file
>> +     file2
>> +     ../sub/file
>> +     EOF
>> +     git -C parent/src ls-files --recurse-submodules .. >actual &&
>> +     test_cmp expect actual &&
>> +
>> +     # Relative path to submodule
>> +     cat >expect <<-\EOF &&
>> +     ../sub/file
>> +     EOF
>> +     git -C parent/src ls-files --recurse-submodules ../sub >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ls-files from a subdir' '
>> +     test_when_finished "rm -rf parent sub" &&
>> +     git init sub &&
>> +     echo "foobar" >sub/file &&
>> +     git -C sub add file &&
>> +     git -C sub commit -m "add file" &&
>> +
>> +     git init parent &&
>> +     mkdir parent/src &&
>> +     echo "foobar" >parent/src/file &&
>> +     git -C parent add src/file &&
>> +     git -C parent submodule add ../sub src/sub &&
>> +     git -C parent submodule add ../sub sub &&
>> +     git -C parent commit -m "add files and submodules" &&
>> +
>> +     # Verify grep from root works
>> +     cat >expect <<-\EOF &&
>> +     .gitmodules
>> +     src/file
>> +     src/sub/file
>> +     sub/file
>> +     EOF
>> +     git -C parent ls-files --recurse-submodules >actual &&
>> +     test_cmp expect actual &&
>> +
>> +     # Verify grep from a subdir works
>> +     cat >expect <<-\EOF &&
>> +     file
>> +     sub/file
>> +     EOF
>> +     git -C parent/src ls-files --recurse-submodules >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_incompatible_with_recurse_submodules ()
>> +{
>> +     test_expect_success "--recurse-submodules and $1 are incompatible" "
>> +             test_must_fail git ls-files --recurse-submodules $1 2>actual &&
>> +             test_i18ngrep -- '--recurse-submodules unsupported mode' actual
>> +     "
>> +}
>> +
>> +test_incompatible_with_recurse_submodules --deleted
>> +test_incompatible_with_recurse_submodules --others
>> +test_incompatible_with_recurse_submodules --unmerged
>> +test_incompatible_with_recurse_submodules --killed
>> +test_incompatible_with_recurse_submodules --modified
>> +
>> +test_done
>> --
>> 2.12.2.776.gded3dc243c29.dirty
>>
>
> --
> Brandon Williams
