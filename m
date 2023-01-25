Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A404C27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 14:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjAYOR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjAYORT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 09:17:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14F58945
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 06:17:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1390475wmc.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 06:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MflkRzZrjo98yANPBv4uqOwrjniLZq2obOUqmYRrMF8=;
        b=j9j7VrPgFlWKJniW6NMCcm+Z7G+Krp3Tr8cviaW2+0UPkvtwDqpNXBpX6R8o1Sseb7
         hNgfHPMu5xWWJCnaUN0beX8dVzPrs4q1vA5x/o42T3/PuV60oq8Q2Ro7Gf0ChjLw+7ij
         nYdgkqJe7QWPdXWXLPZYqeAXyfCpdDB3q8dvKk21fxHT8YTaMXB7U+d0h/Bi5DuHkvNX
         yHAjFjHH2wF7H/eoOZePuG1EyZrISwkkaRbnjN2k2cZ/TMubnms8fNHdyQcKbOdW1H2z
         CsukYSyOwUfLKmtbTpbdtir9u1CX1AiaYHo7SaDC+CNaTyKttdjA0l8xxxCCDiWpHZHd
         Zc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MflkRzZrjo98yANPBv4uqOwrjniLZq2obOUqmYRrMF8=;
        b=56+yYOVHuq00hd6cMS2IPh/6zRDg7VShS67qj6KGe4OYBk/KPcV5LfMpc8KESf1Elg
         32/2MQ8az52bcpOmh04JjRwR+G+MCKuwSoGfgszNPwNpDC1D5AEWUrSXLsl9vjCHYFfu
         YTV29ymnmv4MaR0q1ZMTgSDt50jOBr2JOI8CVBPvU8m9C2YJcLCYRy+AODha4ntG7puC
         A9N11ZCaGIwXsuvfvFseERvrpQwnSHw1lbyYinUqJiB4GC9Y+0ODm6JQMaYhd+u6KhEi
         74c6dm6wMkFSg/XUIokQZ40QNSNRy7cx6wsJI4kCwktOa/NjkCtwBzxzSXx+TAoZtQmH
         cJEA==
X-Gm-Message-State: AFqh2kpWoBNAcyeUn3TYMCIdMq5XMqY0F3ag28qWLEw2mU/19N1Hn1gX
        MSZXAMi0yp24f9Tm8MDbYtQ=
X-Google-Smtp-Source: AMrXdXsRAm8nV50LSlztzEbwXvIB/RGw4jPNsNXhZU27L5JOcbVxLSZfpX93wPb6inUvuxMeibWJwA==
X-Received: by 2002:a05:600c:3c92:b0:3d3:4007:9c88 with SMTP id bg18-20020a05600c3c9200b003d340079c88mr32386041wmb.18.1674656233334;
        Wed, 25 Jan 2023 06:17:13 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003d9fb04f658sm2140582wmq.4.2023.01.25.06.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:17:13 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d82b463e-1d94-64fa-a90f-0a4d919ca27c@dunelm.org.uk>
Date:   Wed, 25 Jan 2023 14:17:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 00/10] rebase: fix several code/testing/documentation
 issues around flag incompatibilities
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 25/01/2023 04:03, Elijah Newren via GitGitGadget wrote:
> We had a report about --update-refs being ignored when --whitespace=fix was
> passed, confusing an end user. These were already marked as incompatible in
> the manual, but the code didn't check for the incompatibility and provide an
> error to the user.
> 
> Folks brought up other flags tangentially when reviewing an earlier round of
> this series, and I found we had more that were missing checks, and that we
> were missing some testcases, and that the documentation was wrong on some of
> the relevant options. So, I ended up getting lots of little fixes to
> straighten these all out.

This version looks good to me. Thanks for working on it - it turned out 
to be quite a bit of work in the end but it is nice improvement, 
especially the last patch.

Best Wishes

Phillip


> Changes since v4:
> 
>   * Pulled out the changes regarding incompatibility detection for
>     --[no-]reapply-cherry-picks into a separate patch. Phillip helped a lot
>     with understanding the behavior, suggesting changes, and getting the
>     wording right, and I think it deserves its own patch with its own
>     explanation.
> 
> Changes since v3:
> 
>   * Corrected the code surrounding --[no-]reapply-cherry-picks, and extended
>     the testcases (Thanks to Phillip for pointing out my error)
>   * I went ahead and implemented the better error message when the merge
>     backend is triggered solely via config options.
> 
> Changes since v2:
> 
>   * Remove the extra patch and reword the comment in t3422 more thoroughly.
>   * Add tests for other flag incompatibilities that were missing
>   * Add code that was missing for checking various flag incompatibilities
>   * Fix incorrect claims in the documentation around incompatible options
>   * A few other miscellaneous fixups noticed while doing all the above
> 
> Changes since v1:
> 
>   * Add a patch nuking the -C option to rebase (fixes confusion around the
>     comment in t3422 and acknowledges the fact that the option is totally and
>     utterly useless and always has been. It literally never affects the
>     results of a rebase.)
> 
> Signed-off-by: Elijah Newren newren@gmail.com
> 
> Elijah Newren (10):
>    rebase: mark --update-refs as requiring the merge backend
>    rebase: flag --apply and --merge as incompatible
>    rebase: remove --allow-empty-message from incompatible opts
>    rebase: fix docs about incompatibilities with --root
>    rebase: fix incompatiblity checks for --[no-]reapply-cherry-picks
>    rebase: add coverage of other incompatible options
>    rebase: clarify the OPT_CMDMODE incompatibilities
>    rebase: fix formatting of rebase --reapply-cherry-picks option in docs
>    rebase: put rebase_options initialization in single place
>    rebase: provide better error message for apply options vs. merge
>      config
> 
>   Documentation/git-rebase.txt           | 77 ++++++++++++-------------
>   builtin/rebase.c                       | 79 +++++++++++++++++++-------
>   t/t3422-rebase-incompatible-options.sh | 71 +++++++++++++++++++++--
>   3 files changed, 163 insertions(+), 64 deletions(-)
> 
> 
> base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1466%2Fnewren%2Frebase-update-refs-imply-merge-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1466/newren/rebase-update-refs-imply-merge-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1466
> 
> Range-diff vs v4:
> 
>    1:  8a676e6ec1a =  1:  8a676e6ec1a rebase: mark --update-refs as requiring the merge backend
>    2:  cc129b87185 =  2:  cc129b87185 rebase: flag --apply and --merge as incompatible
>    3:  9464bbbe9ba =  3:  9464bbbe9ba rebase: remove --allow-empty-message from incompatible opts
>    4:  b702f15ed7c =  4:  b702f15ed7c rebase: fix docs about incompatibilities with --root
>    -:  ----------- >  5:  3a8429f3d2b rebase: fix incompatiblity checks for --[no-]reapply-cherry-picks
>    5:  5e4851e611e !  6:  2777dd2788a rebase: add coverage of other incompatible options
>       @@ Commit message
>        
>            The git-rebase manual noted several sets of incompatible options, but
>            we were missing tests for a few of these.  Further, we were missing
>       -    code checks for some of these, which could result in command line
>       +    code checks for one of these, which could result in command line
>            options being silently ignored.
>        
>            Also, note that adding a check for autosquash means that using
>       @@ Commit message
>        
>            Signed-off-by: Elijah Newren <newren@gmail.com>
>        
>       - ## Documentation/git-rebase.txt ##
>       -@@ Documentation/git-rebase.txt: are incompatible with the following options:
>       -  * --exec
>       -  * --no-keep-empty
>       -  * --empty=
>       -- * --reapply-cherry-picks
>       -+ * --[no-]reapply-cherry-picks
>       -  * --edit-todo
>       -  * --update-refs
>       -  * --root when used without --onto
>       -
>         ## builtin/rebase.c ##
>       -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>       - 		if (options.fork_point < 0)
>       - 			options.fork_point = 0;
>       - 	}
>       -+	/*
>       -+	 * The apply backend does not support --[no-]reapply-cherry-picks.
>       -+	 * The behavior it implements by default is equivalent to
>       -+	 * --no-reapply-cherry-picks (due to passing --cherry-picks to
>       -+	 * format-patch), but --keep-base alters the upstream such that no
>       -+	 * cherry-picks can be found (effectively making it act like
>       -+	 * --reapply-cherry-picks).
>       -+	 *
>       -+	 * Now, if the user does specify --[no-]reapply-cherry-picks, but
>       -+	 * does so in such a way that options.reapply_cherry_picks ==
>       -+	 * keep_base, then the behavior they get will match what they
>       -+	 * expect despite options.reapply_cherry_picks being ignored.  We
>       -+	 * could just allow the flag in that case, but it seems better to
>       -+	 * just alert the user that they've specified a flag that the
>       -+	 * backend ignores.
>       -+	 */
>       -+	if (options.reapply_cherry_picks >= 0)
>       -+		imply_merge(&options, options.reapply_cherry_picks ? "--reapply-cherry-picks" :
>       -+								     "--no-reapply-cherry-picks");
>       -+
>       - 	/*
>       - 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
>       - 	 * commits when using this option.
>       -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>       - 	if (options.empty != EMPTY_UNSPECIFIED)
>       - 		imply_merge(&options, "--empty");
>       -
>       --	/*
>       --	 * --keep-base implements --reapply-cherry-picks by altering upstream so
>       --	 * it works with both backends.
>       --	 */
>       --	if (options.reapply_cherry_picks && !keep_base)
>       --		imply_merge(&options, "--reapply-cherry-picks");
>       --
>       - 	if (gpg_sign)
>       - 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
>       -
>        @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>         	if (options.update_refs)
>         		imply_merge(&options, "--update-refs");
>       @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
>        +		test_must_fail git rebase $opt --empty=ask A
>        +	"
>        +
>       -+	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
>       -+		git checkout B^0 &&
>       -+		test_must_fail git rebase $opt --no-reapply-cherry-picks A
>       -+	"
>       -+
>       -+	test_expect_success "$opt incompatible with --reapply-cherry-picks" "
>       -+		git checkout B^0 &&
>       -+		test_must_fail git rebase $opt --reapply-cherry-picks A
>       -+	"
>       -+
>       - 	test_expect_success "$opt incompatible with --update-refs" "
>       + 	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
>         		git checkout B^0 &&
>       - 		test_must_fail git rebase $opt --update-refs A
>       + 		test_must_fail git rebase $opt --no-reapply-cherry-picks A
>    6:  21ae9e05313 !  7:  0d0541ea243 rebase: clarify the OPT_CMDMODE incompatibilities
>       @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>        @@ Documentation/git-rebase.txt: are incompatible with the following options:
>          * --no-keep-empty
>          * --empty=
>       -  * --[no-]reapply-cherry-picks
>       +  * --[no-]reapply-cherry-picks when used without --keep-base
>        - * --edit-todo
>          * --update-refs
>          * --root when used without --onto
>    7:  74a216bf0c0 =  8:  01808cf84a8 rebase: fix formatting of rebase --reapply-cherry-picks option in docs
>    8:  a8adf7fda61 =  9:  f646abee524 rebase: put rebase_options initialization in single place
>    9:  5cb00e5103b = 10:  328f5a1d534 rebase: provide better error message for apply options vs. merge config
> 
