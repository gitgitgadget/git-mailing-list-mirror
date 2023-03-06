Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FFC64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCFQeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFQeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 11:34:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA030193
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 08:33:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw28so41124486edb.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678120346;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IysOtuxrah2iNcix9cethtRBQGxaLpFUEnKI85m83TY=;
        b=WBl3CupZ9Dl8WBwjnivyn4IteiQKfYFdPr3fjd7Roo5C48YgJZpN5h2Wm18gI2byRT
         v+3hXTWWVgoT9ygpq7RCMCK84JtpBGj6t53jI02RSmIZY1IRC6p4pdmHUSt3W2nLWe9M
         AWlSgEl6mUjrrqRGRgpY8H+3/nBsC2DdhqTlsDnYu0bkUGZEwuYMW2PoR3dnpxMPieN7
         su5ScBvDOPMv43b619hoLoBt2lzBCljNAqL92UyB1v5TSNXoWs525uRFJTjKVgzyL88E
         n5IoWb+Uy4ioAQNj8T6MJm+0IjAUrLoE2xKBRF9L36igLgtOe4sBS4SKV4LVbXVM0x7U
         x2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678120346;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IysOtuxrah2iNcix9cethtRBQGxaLpFUEnKI85m83TY=;
        b=aYuV1ZslPJSYljJN2YxpIP8f84y0oMeffKZ3b0JqBjREXTG0KTHYl3Okv+2Uvwreew
         bJHRG0dHS8BhRFIm5A5AsW3adp4fO4/9Kr9ZMDWopc+aCVtCG6sipB6fT7dgkdeeq2pp
         7OHkIwZ8MKN9iL/bwn+XtteTHb9X+8DvJ2PVqZMZPiavh1zdQ50aFEQkxoOhhofxNno4
         lHKxFPMZLT2Thkk4Kx1cyFOw7ztlNRN9aO0tbCvOZJvRPWDcz4cD+d60Moc1Hb0G5zbL
         n8fHd+/ZFAofyzfT3SpWYnu4ebLj4TxzDXykTXbKKOmIHEwYg2HQ4kt8P5Yf76m35Y8q
         w0nQ==
X-Gm-Message-State: AO0yUKUvlDbkOOH7u/6Ub++Tt9XcaZS5fIWNKnfYhaLhCDkiWIDjxzt2
        RgWKpiOyLiOQzIr17a/qGnkQ7pxuBLE=
X-Google-Smtp-Source: AK7set9Byh1GzEUZumGnjAzGP8u4qorm9jgCrQ4ClTze3vD61/z8SfMNUrIzcpOeQxVizR7YfNBMrg==
X-Received: by 2002:a5d:4044:0:b0:2c5:c71:4a84 with SMTP id w4-20020a5d4044000000b002c50c714a84mr7824916wrp.68.1678119883645;
        Mon, 06 Mar 2023 08:24:43 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c30d300b003db06224953sm10267115wmn.41.2023.03.06.08.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:24:43 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4f313373-25c5-06d4-6d1b-89a0e595dfa1@dunelm.org.uk>
Date:   Mon, 6 Mar 2023 16:24:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com>
In-Reply-To: <20230305050709.68736-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 05/03/2023 05:07, Alex Henrie wrote:
> This patch series introduces a rebase.rebaseMerges config option to
> accommodate users who would like --rebase-merges to be on by default and
> to facilitate turning on --rebase-merges by default without
> configuration in a future version of Git. It also cleans up and
> documents the behavior of the --rebase-merges command line option to
> avoid confusion about how the config option and the command line option
> interact.
> 
> Changes from v5:
> - Add commit message note about --no-rebase-merges having always worked
> - Add commit message note about the test for --no-rebase-merges being
>    somewhat contrived
> - Rephrase the documentation to avoid using the phrase "By default" with
>    two different meanings, and in so doing clarify that --rebase-merges
>    without an argument is not the same as --no-rebase-merges and not
>    passing --rebase-merges is not the same as passing
>    --rebase-merges=no-rebase-cousins
> - Add commit message note about keeping --rebase-merges="" for now out
>    of an abundance of caution
> - Rephrase the warning about --rebase-merges="" to recommend
>    --rebase-merges without an argument instead, and clarify that that
>    will do the same thing
> - Remove the test for --rebase-merges=""
> - Rename the config option from rebase.merges to rebase.rebaseMerges and
>    explain why in the commit message
> - Add commit message note about why "true" is a valid option for
>    rebase.rebaseMerges and why --rebase-merges without an argument does
>    not clobber the mode specified in rebase.rebaseMerges
> - Rephrase the documentation to clarify that --rebase-merges without an
>    argument does not clobber the mode specified in rebase.rebaseMerges
> - Add another test for incompatible options
> 
> Suggestions on v5 not incorporated in v6:

Thanks for adding this, it is really helpful to see what did not change 
as well as what did change. It is also helpful to briefly explain why 
you disagree with the suggestions so others can understand why you 
decided not to make these changes.

> - Make --rebase-merges without an argument clobber the mode specified in
>    rebase.rebaseMerges

I'm still confused as to why we want the config value to change the 
behavior of --rebase-merges. Is it for "git pull --rebase=merges"? If 
that's the case then I think a better approach is for pull to parse 
rebase.merges and pass the appropriate argument to rebase. That way we 
don't break the expectation that command line arguments override config 
values.

> - Remove the test for --rebase-merges=no-rebase-cousins overriding
>    rebase.rebaseMerges=rebase-cousins
> - In the tests, check the graph itself instead of checking that the
>    graph has not changed by checking that the commit hash has not changed

I'm not sure what value the existing test has if it only checks that 
HEAD is unchanged after the rebase. It could be unchanged because the 
rebase fast-forwarded or because it did nothing.

Best Wishes

Phillip

> Thanks to Glen, Calvin, Junio, Jonathan, Elijah, and Phillip for your
> feedback on v5. As before, if you feel strongly about one of the
> suggestions that I have not incorporated into v6, or if you see
> something else amiss, let's continue the discussion.
> 
> Alex Henrie (3):
>    rebase: add documentation and test for --no-rebase-merges
>    rebase: deprecate --rebase-merges=""
>    rebase: add a config option for --rebase-merges
> 
>   Documentation/config/rebase.txt        | 11 ++++
>   Documentation/git-rebase.txt           | 19 ++++---
>   builtin/rebase.c                       | 75 ++++++++++++++++++-------
>   t/t3422-rebase-incompatible-options.sh | 17 ++++++
>   t/t3430-rebase-merges.sh               | 78 ++++++++++++++++++++++++++
>   5 files changed, 174 insertions(+), 26 deletions(-)
> 
> Range-diff against v5:
> 1:  76e38ef9f8 ! 1:  bf08c03ba7 rebase: add documentation and test for --no-rebase-merges
>      @@ Metadata
>        ## Commit message ##
>           rebase: add documentation and test for --no-rebase-merges
>       
>      +    As far as I can tell, --no-rebase-merges has always worked, but has
>      +    never been documented. It is especially important to document it before
>      +    a rebase.rebaseMerges option is introduced so that users know how to
>      +    override the config option on the command line. It's also important to
>      +    clarify that --rebase-merges without an argument is not the same as
>      +    --no-rebase-merges and not passing --rebase-merges is not the same as
>      +    passing --rebase-merges=no-rebase-cousins.
>      +
>      +    A test case is necessary to make sure that --no-rebase-merges keeps
>      +    working after its code is refactored in the following patches of this
>      +    series. The test case is a little contrived: It's unlikely that a user
>      +    would type both --rebase-merges and --no-rebase-merges at the same time.
>      +    However, if an alias is defined which includes --rebase-merges, the user
>      +    might decide to add --no-rebase-merges to countermand that part of the
>      +    alias but leave alone other flags set by the alias.
>      +
>           Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>       
>        ## Documentation/git-rebase.txt ##
>      @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>       +	resolved/re-applied manually. `--no-rebase-merges` can be used to
>       +	countermand a previous `--rebase-merges`.
>        +
>      - By default, or when `no-rebase-cousins` was specified, commits which do not
>      - have `<upstream>` as direct ancestor will keep their original branch point,
>      +-By default, or when `no-rebase-cousins` was specified, commits which do not
>      +-have `<upstream>` as direct ancestor will keep their original branch point,
>      +-i.e. commits that would be excluded by linkgit:git-log[1]'s
>      +-`--ancestry-path` option will keep their original ancestry by default. If
>      +-the `rebase-cousins` mode is turned on, such commits are instead rebased
>      +-onto `<upstream>` (or `<onto>`, if specified).
>      ++When rebasing merges, there are two modes: `rebase-cousins` and
>      ++`no-rebase-cousins`. If the mode is not specified, it defaults to
>      ++`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
>      ++`<upstream>` as direct ancestor will keep their original branch point, i.e.
>      ++commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
>      ++option will keep their original ancestry by default. In `rebase-cousins` mode,
>      ++such commits are instead rebased onto `<upstream>` (or `<onto>`, if
>      ++specified).
>      + +
>      + It is currently only possible to recreate the merge commits using the
>      + `ort` merge strategy; different merge strategies can be used only via
>       
>        ## t/t3430-rebase-merges.sh ##
>       @@ t/t3430-rebase-merges.sh: test_expect_success 'with a branch tip that was cherry-picked already' '
> 2:  c6099e6dee ! 2:  26f98b8400 rebase: deprecate --rebase-merges=""
>      @@ Commit message
>       
>           The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
>           empty string argument) has been an undocumented synonym of
>      -    --rebase-merges=no-rebase-cousins. Deprecate that syntax to avoid
>      -    confusion when a rebase.merges config option is introduced, where
>      -    rebase.merges="" will be equivalent to --no-rebase-merges.
>      +    --rebase-merges without an argument. Deprecate that syntax to avoid
>      +    confusion when a rebase.rebaseMerges config option is introduced, where
>      +    rebase.rebaseMerges="" will be equivalent to --no-rebase-merges.
>      +
>      +    It is not likely that anyone is actually using this syntax, but just in
>      +    case, deprecate the empty string argument instead of dropping support
>      +    for it immediately.
>       
>           Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>       
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>       +			warning(_("--rebase-merges with an empty string "
>       +				  "argument is deprecated and will stop "
>       +				  "working in a future version of Git. Use "
>      -+				  "--rebase-merges=no-rebase-cousins "
>      -+				  "instead."));
>      ++				  "--rebase-merges without an argument "
>      ++				  "instead, which does the same thing."));
>        		else if (!strcmp("rebase-cousins", rebase_merges))
>        			options.rebase_cousins = 1;
>        		else if (strcmp("no-rebase-cousins", rebase_merges))
>      -
>      - ## t/t3430-rebase-merges.sh ##
>      -@@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless asked for' '
>      - 	EOF
>      - '
>      -
>      -+test_expect_success '--rebase-merges="" is deprecated' '
>      -+	git rebase --rebase-merges="" HEAD^ 2>actual &&
>      -+	grep deprecated actual
>      -+'
>      -+
>      - test_expect_success 'refs/rewritten/* is worktree-local' '
>      - 	git worktree add wt &&
>      - 	cat >wt/script-from-scratch <<-\EOF &&
> 3:  95cba9588c ! 3:  402365256c rebase: add a config option for --rebase-merges
>      @@ Commit message
>           rebase: add a config option for --rebase-merges
>       
>           The purpose of the new option is to accommodate users who would like
>      -    --rebase-merges to be on by default and to facilitate possibly turning
>      -    on --rebase-merges by default without configuration in a future version
>      -    of Git.
>      +    --rebase-merges to be on by default and to facilitate turning on
>      +    --rebase-merges by default without configuration in a future version of
>      +    Git.
>      +
>      +    Name the new option rebase.rebaseMerges, even though it is a little
>      +    redundant, for consistency with the name of the command line option and
>      +    to be clear when scrolling through values in the [rebase] section of
>      +    .gitconfig.
>      +
>      +    In the future, the default rebase-merges mode may change from
>      +    no-rebase-cousins to rebase-cousins. Support setting rebase.rebaseMerges
>      +    to the nonspecific value "true" for users who do not need or want to
>      +    care about the default changing in the future. Similarly, for users who
>      +    have --rebase-merges in an alias and want to get the future behavior
>      +    now, use the specific rebase-merges mode from the config if a specific
>      +    mode is not given on the command line.
>       
>           Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>       
>      @@ Documentation/config/rebase.txt: rebase.rescheduleFailedExec::
>        rebase.forkPoint::
>        	If set to false set `--no-fork-point` option by default.
>       +
>      -+rebase.merges::
>      ++rebase.rebaseMerges::
>       +	Whether and how to set the `--rebase-merges` option by default. Can
>       +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
>       +	true is equivalent to `--rebase-merges` without an argument, setting to
>       +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
>       +	`--rebase-merges` with that value as its argument, and setting to false
>       +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
>      -+	command line without an argument overrides a `rebase.merges=false`
>      -+	configuration but does not override other values of `rebase.merge`.
>      ++	command line without an argument overrides a `rebase.rebaseMerges=false`
>      ++	configuration, but the absence of a specific rebase-merges mode on the
>      ++	command line does not counteract a specific mode set in the configuration.
>       
>        ## Documentation/git-rebase.txt ##
>       @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>      @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
>        	manual amendments in these merge commits will have to be
>        	resolved/re-applied manually. `--no-rebase-merges` can be used to
>       -	countermand a previous `--rebase-merges`.
>      -+	countermand both the `rebase.merges` config option and a previous
>      ++	countermand both the `rebase.rebaseMerges` config option and a previous
>       +	`--rebase-merges`.
>        +
>      - By default, or when `no-rebase-cousins` was specified, commits which do not
>      - have `<upstream>` as direct ancestor will keep their original branch point,
>      + When rebasing merges, there are two modes: `rebase-cousins` and
>      +-`no-rebase-cousins`. If the mode is not specified, it defaults to
>      +-`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
>      +-`<upstream>` as direct ancestor will keep their original branch point, i.e.
>      +-commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
>      +-option will keep their original ancestry by default. In `rebase-cousins` mode,
>      +-such commits are instead rebased onto `<upstream>` (or `<onto>`, if
>      +-specified).
>      ++`no-rebase-cousins`. If the mode is not specified on the command line or in
>      ++the `rebase.rebaseMerges` config option, it defaults to `no-rebase-cousins`.
>      ++In `no-rebase-cousins` mode, commits which do not have `<upstream>` as direct
>      ++ancestor will keep their original branch point, i.e. commits that would be
>      ++excluded by linkgit:git-log[1]'s `--ancestry-path` option will keep their
>      ++original ancestry by default. In `rebase-cousins` mode, such commits are
>      ++instead rebased onto `<upstream>` (or `<onto>`, if specified).
>      + +
>      + It is currently only possible to recreate the merge commits using the
>      + `ort` merge strategy; different merge strategies can be used only via
>       
>        ## builtin/rebase.c ##
>       @@ builtin/rebase.c: struct rebase_options {
>      @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
>        		return 0;
>        	}
>        
>      -+	if (!strcmp(var, "rebase.merges")) {
>      ++	if (!strcmp(var, "rebase.rebasemerges")) {
>       +		opts->config_rebase_merges = git_parse_maybe_bool(value);
>       +		if (opts->config_rebase_merges < 0) {
>       +			opts->config_rebase_merges = 1;
>      @@ builtin/rebase.c: static int parse_opt_empty(const struct option *opt, const cha
>       +			warning(_("--rebase-merges with an empty string "
>       +				  "argument is deprecated and will stop "
>       +				  "working in a future version of Git. Use "
>      -+				  "--rebase-merges=no-rebase-cousins "
>      -+				  "instead."));
>      -+			arg = "no-rebase-cousins";
>      ++				  "--rebase-merges without an argument "
>      ++				  "instead, which does the same thing."));
>      ++			return 0;
>       +		}
>       +		parse_rebase_merges_value(options, arg);
>       +	}
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>       -			warning(_("--rebase-merges with an empty string "
>       -				  "argument is deprecated and will stop "
>       -				  "working in a future version of Git. Use "
>      --				  "--rebase-merges=no-rebase-cousins "
>      --				  "instead."));
>      +-				  "--rebase-merges without an argument "
>      +-				  "instead, which does the same thing."));
>       -		else if (!strcmp("rebase-cousins", rebase_merges))
>       -			options.rebase_cousins = 1;
>       -		else if (strcmp("no-rebase-cousins", rebase_merges))
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>       +			if (options.autosquash == -1 && options.config_autosquash == 1)
>        				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
>       +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
>      -+				die(_("apply options are incompatible with rebase.merges.  Consider adding --no-rebase-merges"));
>      ++				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
>        			else if (options.update_refs == -1 && options.config_update_refs == 1)
>        				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
>       +			else if (is_merge(&options))
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>        	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
>       
>        ## t/t3422-rebase-incompatible-options.sh ##
>      +@@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
>      + 		test_must_fail git rebase $opt --reapply-cherry-picks A
>      + 	"
>      +
>      ++	test_expect_success "$opt incompatible with --rebase-merges" "
>      ++		git checkout B^0 &&
>      ++		test_must_fail git rebase $opt --rebase-merges A
>      ++	"
>      ++
>      + 	test_expect_success "$opt incompatible with --update-refs" "
>      + 		git checkout B^0 &&
>      + 		test_must_fail git rebase $opt --update-refs A
>       @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
>        		grep -e --no-autosquash err
>        	"
>        
>      -+	test_expect_success "$opt incompatible with rebase.merges" "
>      ++	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
>       +		git checkout B^0 &&
>      -+		test_must_fail git -c rebase.merges=true rebase $opt A 2>err &&
>      ++		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
>       +		grep -e --no-rebase-merges err
>       +	"
>       +
>      @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
>        		git -c rebase.autosquash=true rebase --no-autosquash $opt A
>        	"
>        
>      -+	test_expect_success "$opt okay with overridden rebase.merges" "
>      ++	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
>       +		test_when_finished \"git reset --hard B^0\" &&
>       +		git checkout B^0 &&
>      -+		git -c rebase.merges=true rebase --no-rebase-merges $opt A
>      ++		git -c rebase.rebaseMerges=true rebase --no-rebase-merges $opt A
>       +	"
>       +
>        	test_expect_success "$opt okay with overridden rebase.updateRefs" "
>      @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
>        		git checkout B^0 &&
>       
>        ## t/t3430-rebase-merges.sh ##
>      -@@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated' '
>      - 	grep deprecated actual
>      +@@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless asked for' '
>      + 	EOF
>        '
>        
>      -+test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
>      -+	test_config rebase.merges rebase-cousins &&
>      ++test_expect_success '--rebase-merges="" is deprecated' '
>      ++	git rebase --rebase-merges="" HEAD^ 2>actual &&
>      ++	grep deprecated actual
>      ++'
>      ++
>      ++test_expect_success 'rebase.rebaseMerges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
>      ++	test_config rebase.rebaseMerges rebase-cousins &&
>       +	git checkout -b config-rebase-cousins main &&
>       +	git rebase HEAD^ &&
>       +	test_cmp_graph HEAD^.. <<-\EOF
>      @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
>       +	EOF
>       +'
>       +
>      -+test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
>      -+	test_config rebase.merges no-rebase-cousins &&
>      ++test_expect_success '--no-rebase-merges overrides rebase.rebaseMerges=no-rebase-cousins' '
>      ++	test_config rebase.rebaseMerges no-rebase-cousins &&
>       +	git checkout -b override-config-no-rebase-cousins E &&
>       +	git rebase --no-rebase-merges C &&
>       +	test_cmp_graph C.. <<-\EOF
>      @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
>       +	EOF
>       +'
>       +
>      -+test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
>      -+	test_config rebase.merges rebase-cousins &&
>      ++test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.rebaseMerges=rebase-cousins' '
>      ++	test_config rebase.rebaseMerges rebase-cousins &&
>       +	git checkout -b override-config-rebase-cousins main &&
>       +	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
>       +	test_cmp_graph HEAD^.. <<-\EOF
>      @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
>       +	EOF
>       +'
>       +
>      -+test_expect_success '--rebase-merges overrides rebase.merges=false' '
>      -+	test_config rebase.merges false &&
>      ++test_expect_success '--rebase-merges overrides rebase.rebaseMerges=false' '
>      ++	test_config rebase.rebaseMerges false &&
>       +	git checkout -b override-config-merges-false E &&
>       +	before="$(git rev-parse --verify HEAD)" &&
>       +	test_tick &&
>      @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
>       +	test_cmp_rev HEAD $before
>       +'
>       +
>      -+test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
>      -+	test_config rebase.merges rebase-cousins &&
>      ++test_expect_success '--rebase-merges does not override rebase.rebaseMerges=rebase-cousins' '
>      ++	test_config rebase.rebaseMerges rebase-cousins &&
>       +	git checkout -b no-override-config-rebase-cousins main &&
>       +	git rebase --rebase-merges HEAD^ &&
>       +	test_cmp_graph HEAD^.. <<-\EOF
