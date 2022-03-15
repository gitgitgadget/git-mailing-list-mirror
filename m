Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774EC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 16:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiCOQIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 12:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiCOQIy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 12:08:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3E56416
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 09:07:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t2so17762799pfj.10
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qou3vtryxJdM1pc8Uvg619tuBerfCLcaG782ABonRQM=;
        b=G2wNvySFWzsyt2q+/Nps3J0YGAVavo5FzW+u5m6/KF2z5g8zs9lTZOsYNJalfAlKTT
         mZUzTHJAXAlkQSXACtXM0Liejo6NGRWTAud5m1eHAe8MRMd3YgOy1FjOy56TV0mHrt71
         ux3yJyurW052H+R2z4gQTBtZUkyKblxBgv3ylFnDfkoyjQaF6kl6tz1Oaw49Vx/DLxs+
         XNMF63I6XxYGr2hxFk5v+jYz8kiUJ5ekkeKBK89nfl/+pbg35F8LLETJHAozZZrkV9i3
         OF+GkU+bJE+kSyt7rL+u+EcPZr3QnjQy9FQ/VYKDWPJMeBIioKoTrwlpU5TuOzw+MQio
         GzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qou3vtryxJdM1pc8Uvg619tuBerfCLcaG782ABonRQM=;
        b=IqFqd71A4F9MWPmWY1izc2vdX4X2E1/ZScVDvfhz+EZsXw0U/OHtTjGzzfQ2oKqEnN
         zTK8SNHe/d/E3cltIiUQu1c+taNTWZxwz75Pz1a+IbPCK2tl37ZS3w3d4WsK5bkFiiQO
         xw4WRuZgTSvV2VU6Pa9+o/WC3p53zlKi9yLV4oMsPt4CGAjgque+Gp5HfJr9H/UOpnxw
         GLySrDiF6tt5jnOswqCLycgG7hTHXMJmtPnzaBphBDOW1yAFoPhhS8YIqmsgv0HcyLMH
         oWVgpmEZc11loRXE20a1437IukeEbzztEH14eRIROR20bVATaR/Us4+qobvDN8YBbMEv
         c6Xw==
X-Gm-Message-State: AOAM532ywvNe62DDKHXvLMO4HFNqeRJHSfFYuHkNMs0gSFKM3U41l3LZ
        fOU+R1K+wL0eqr28xEmExesOFMuO2yNx
X-Google-Smtp-Source: ABdhPJwdJiK8pUVQNBLwK5onMUyNtuNZQ5Bgsb903zH3nQSTaT33m0UqgGeea9h/TbY9Xo2fEsLAYA==
X-Received: by 2002:a62:8387:0:b0:4f7:9ac8:9074 with SMTP id h129-20020a628387000000b004f79ac89074mr20112268pfe.16.1647360457332;
        Tue, 15 Mar 2022 09:07:37 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm3465183pjc.56.2022.03.15.09.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:07:36 -0700 (PDT)
Message-ID: <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
Date:   Tue, 15 Mar 2022 09:07:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                             |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 

Hi Shaoxuan! 

I'll answer your question "are the tests on the right track?" [1] inline
with the tests here. 

[1] https://lore.kernel.org/git/20220315100145.214054-1-shaoxuan.yuan02@gmail.com/

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 83a465ba83..111360ebf5 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -138,6 +138,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +
>  	argc = parse_options(argc, argv, prefix, builtin_mv_options,
>  			     builtin_mv_usage, 0);
>  	if (--argc < 1)
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 2a04b532f9..0a8164c5f6 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1521,4 +1521,38 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
>  	test_cmp full-checkout-err sparse-index-err
>  '
>  
> +test_expect_success 'mv' '
> +	init_repos &&
> +

In 't1092', I've tried to write test cases around some of the
characteristics relevant to sparse checkout/sparse index. For example:

- files inside vs. outside of sparse cone (e.g., 'deep/a' vs 'folder1/a')
- "normal" directories vs. sparse directories (e.g., 'deep/' vs. 'folder1/')
- directories inside a sparse directory vs. "toplevel" sparse directories
  (e.g., 'folder1/0/' vs. 'folder1/')
- options that follow different code paths, especially if those code paths
  interact with the index differently (e.g., 'git reset --hard' vs 'git
  reset --mixed')
- (probably not relevant for 'git mv') files with vs. without staged changes
  in the index

I've found that exercising these characteristics provides good baseline
coverage for a sparse index integration, not leaving any major gaps. I'll
also typically add cases specific to any workarounds I need to add to a
command (like for 'git read-tree --prefix' [2]).

Also, if some of the information about the test repos (e.g., what's inside
vs. outside cone, or what's in the repos in the first place) isn't clear,
I'm happy to give a deeper dive into how they're set up.

With all of that in mind, let's go over the cases you have so far.

[2] https://lore.kernel.org/git/90ebcb7b8ff4b4f1ba09abcbe636d639fa597e74.1646166271.git.gitgitgadget@gmail.com/

> +	# test first form <source> <destination>
> +	test_all_match git mv deep/a deep/a_mod &&
> +	test_all_match git mv deep/deeper1 deep/deeper1_mod &&
> +	test_all_match git mv deep/deeper2/deeper1/deepest2/a \
> +	deep/deeper2/deeper1/deepest2/a_mod &&
> +

This is a good basis for "inside cone" to "inside cone" moves. That said, I
don't think you need all three (since they're all testing effectively the
same inside-to-inside cone move). I'd suggest instead adding cases like: 

	test_all_match git mv <inside cone> <outside cone> &&
	test_all_match git mv <outside cone> <inside cone> &&
	test_all_match git mv <outside cone> <outside cone> &&

to see how the sparse index behaves when files are moved in and out of
sparse directories. Similarly, you may want to try 'git mv <sparse
directory> <somewhere else>' to see if that triggers any unintended
behavior.

Additionally, I don't *think* 'git mv' prints out the state of the index, so
you'll probably want to follow these cases with:

	test_all_match git status --porcelain=v2 &&

which prints the status info in a machine-readable format.

> +	run_on_all git reset --hard &&
> +
> +	test_all_match git mv -f deep/a deep/before/a &&
> +	test_all_match git mv -f deep/before/a deep/a &&
> +

Good! The '-f' option will allow one file to overwrite another in the index,
which is definitely interesting in a sparse index. Same as above, though,
you should verify 'git status --porcelain=v2'.

> +	run_on_all git reset --hard &&
> +
> +	test_all_match git mv -k deep/a deep/before/a &&
> +	test_all_match git mv -k deep/before/a deep/a &&
> +

The '-k' option might be interesting in the context of the index, since it
pushes past errors that would normally make it exit early. However, if it
just skips things that fail rather than exiting with an error, it probably
isn't testing anything more than the 'git mv' cases. 

> +	run_on_all git reset --hard &&
> +
> +	test_all_match git mv -v deep/a deep/a_mod &&
> +	test_all_match git mv -v deep/deeper1 deep/deeper1_mod &&
> +	test_all_match git mv -v deep/deeper2/deeper1/deepest2/a \
> +	deep/deeper2/deeper1/deepest2/a_mod &&
> +

Looking at 'builtin/mv.c', the '-v' "verbose" option only controls whether
some verbose printouts are emitted. This might be relevant if the printouts
were printing index information that didn't match between 'full-checkout',
'sparse-checkout' and 'sparse-index', but if you haven't seen that, I'd
leave these cases out.

> +	# test second form <source> ... <destination directory>
> +	run_on_all git reset --hard &&
> +	run_on_all mkdir deep/folder &&
> +	test_all_match git mv deep/a deep/folder &&
> +	test_all_match git mv -v deep/deeper1 deep/folder &&
> +	test_all_match git mv -f deep/deeper2/deeper1/deepest2/a deep/folder

This is a good variation on the standard "inside cone" to "inside cone", and
I'd like to see something similar done inside sparse directories. And,
similar to above, I don't think '-v' needs to be tested.

> +'
> +
>  test_done

Overall, this is a great start! You've got a good pattern set up (it's very
clear to follow), I think it mainly needs some more variety to the test
cases. Also, if you find that this test gets way too large after adding more
cases, feel free to split it into multiple named tests if one gets too long
(e.g. "mv", "mv -f"). 

My recommendations:

- add tests covering outside-of-sparse-cone 'mv' arguments
- add tests covering 'mv' attempting to move directories (in-cone and
  sparse)
- add some "test_must_fail" tests to see what happens when you do something
  "wrong", e.g. to try to overwrite a file without '-f' (I've found some
  really interesting issues in the past where you expect something to fail
  and it doesn't)
- add 'git status --porcelain=v2' checks to confirm that the 'mv' worked the
  same across the different checkouts
- remove multiples of test cases that test the same general behavior (e.g.,
  'git mv <in-cone file> <in-cone file>' only needs to be done once)
- double-check whether '-v' and '-k' have the ability to affect
  full-checkout/sparse-checkout/sparse-index differently - if not, you
  probably don't need to test them

Thanks for working on this, and I hope this helps!
