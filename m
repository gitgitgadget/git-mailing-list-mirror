Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB6C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 04:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiLTEAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 23:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiLTEAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 23:00:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2728515A3B
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 20:00:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o12so11126926pjo.4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 20:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vh6Xw4aWFGjvuc+9FU45RkSDjPgu46rAbNKTorHx9xU=;
        b=jJ/bB5pydsgNteugw341xvrF22WIdcXWa+dZE9a5H3+XW1EyEmEZFZBhHNuYNljibS
         ur55G0+EzhZQF5l9pj2BUf67hXyCLvacrwPLj1Lr8UP/olx/mMObPiTnJyOQb38rgAEw
         +T/vNfdftwiGIR5IJ59veH47nDVyiq7T27Cin625jBq9HMpkSmjQ2C/Rvrk0v6xvpMv4
         E7j7kINoFZu7pU09imvvaC4plBu/KmqsdzDkJ43+2eDpwi/35z/aTBpB+b+QWaDx2v/s
         Attv+XpJGOtZFtUjk5M0GTsHp5Xsxjk5uVI8rO0vMPg/PuEXB/QeUoiGkKHMv4ypG2o2
         G05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vh6Xw4aWFGjvuc+9FU45RkSDjPgu46rAbNKTorHx9xU=;
        b=hqwswlrG3HAVgtLIaIgTriHZTcg+uHiHnAv42O66UhZlOQ86j7l1BtCDHs08vIUrvd
         1JU8MhHdft0o+Rx+36c7qxY29jpbZOAl46Z49AoBAlTbD04zy9d7a3c+RebJlUJ4Vg7C
         9oqfvCfIzIEJf7gJDh4e7rqUNtAEdUmoH9J70vHma3rRd8JZ/fLE6b9UsEB+CcpFAw8T
         190l9DmB8W6xCWQ5PIiSumifD8FvI3Q3Xg8L4A/BxNe5l5Ptd1uWJl5wxlDYJRJs+s0G
         Zx+AP55Gs23JBV0GovraPuCtIQ3Nv3rkaqY0DPsEUBgDJJdpOcorNII0Inp7NCm2H6nc
         DNkg==
X-Gm-Message-State: ANoB5pnSrN156Qo+O3J+QZ9A1XsJg6nRElt7yimNFFUGqauULA9BV+uS
        qNgjTSwsIhbjlmGV9rFAhXkq2aclxOkYzg==
X-Google-Smtp-Source: AA0mqf6s/Pq1HcMp8JSQieE3pPtLt2NMNnkLAlq4VSX/XMncDtQzEfjt5j1BmRXOk3GyS9QhUtimjA==
X-Received: by 2002:a17:903:251:b0:189:7891:574d with SMTP id j17-20020a170903025100b001897891574dmr52467736plh.47.1671508809597;
        Mon, 19 Dec 2022 20:00:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902868100b0016d9b101413sm8024032plo.200.2022.12.19.20.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 20:00:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 2/4] worktree add: refactor opt exclusion tests
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221220023637.29042-3-jacobabel@nullpo.dev>
Date:   Tue, 20 Dec 2022 13:00:08 +0900
In-Reply-To: <20221220023637.29042-3-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Tue, 20 Dec 2022 02:37:43 +0000")
Message-ID: <xmqqsfhawwqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Pull duplicate test code into a function so that additional opt
> combinations can be tested succinctly.
>
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>  t/t2400-worktree-add.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

OK.

> +# Helper function to test mutually exclusive options.
> +test_wt_add_excl() {

Have SP on both sides of (), i.e.

	test_wt_add_excl () {

> +	local opts="$@" &&
> +	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
> +		test_must_fail git worktree add $opts
> +	'
> +}

In this particular case with the given arguments, it does not make a
difference, but make it a habit to think twice if "$*" is what you
want when you write "$@".  "$@" does a lot more than just concatenate
$1, $2, ... with SP in between, and the use of $opts in the message
merely wants the "concatenate with SP" behaviour, which is what "$*"
is for.

I actually would write the above if I were doing this patch:

    test_wt_add_excl () {
	test_expect_success "'worktree add' with $* has mutually exclusive options" '
		test_must_fail git worktree add "$@"
	'
    }

Notice the use of "$@" on the "git worktree add" invocation?  This
allows callers of test_wt_add_excl pass parameters with SP in it,
thanks to the magic "$@".  Again, as I said earlier, for these
callers ...

> +test_wt_add_excl -b poodle -B poodle bamboo main
> +test_wt_add_excl -b poodle --detach bamboo main
> +test_wt_add_excl -B poodle --detach bamboo main

... the distinction does not matter, but 

    helper --lock --reason "my reason with multiple words" bamboo main

must be written with "$@", like so:

    helper () {
	git worktree add "$@"
    }

not

    helper () { # BAD
	local opt="$@"
	git worktree add $opt
    }

$opt in this case is a SP-concatenated string

	opt="--lock --reason my reason with multiple words bamboo main"

and passing it without quotes around it to "git worktree add"
will give only "my" as the parameter to the option "--reason",
with three extra words on the comand line.
