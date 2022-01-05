Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D04EC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 03:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiAEDkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 22:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiAEDkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 22:40:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB00C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 19:40:18 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a1so36232260qtx.11
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 19:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NGg0xsq8Wqz0yqkGUQsNY+fYebxmF0N+8VJ/2OFl6rE=;
        b=nszi0ZUNr2T+AnJImCsLtKwAB+VJANRzU1Y9qawc6wynvVkaNcRZ6FFNMWryUZbgd0
         TYD+OhIMvKHhNjzmgf6KOgLIPTMMqwF5D2bMBSzZRJs92xYNK6BYY4mfSUO6iDEn1bXg
         140LSqnKsUbMUH2sYTmDiW0iXRB5iRRQziLzOjAJ44/JZRqf3jzEn+3XPYuS+AnrgZDc
         bsy/xusWjuRb82ZCO1FpkDtp0mjdUjM9cMGda+DJKXuDzL1Wf052P3Dy4EshU9q3k9Qq
         LAE1VzAaXjpOyyHSxlZR+Rin23d9yULoV3wyF7fYtgJTix9CLunZ5EVhCdDDSYRwY+hr
         Kp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NGg0xsq8Wqz0yqkGUQsNY+fYebxmF0N+8VJ/2OFl6rE=;
        b=flUHLgKZ9OOjsNCxc62AZph4/5eUArKDKVXKpOcgy/K4DUCFzEXLUBFisJ0vOXNGxH
         bVQM2pj7DQ/tU54XP/KB62Zvpyanlqlvyq3UeKVmlrg1WAWao/NOLvhkguBQhSBw6CmA
         kPif7U7NlxQpG+T+DAHNNW/jtRbuAG97Fpbc4l/ximFYmo1w0ijuIuzwRd5u92tK7lAj
         NNXgHoKFoJHwbw5x9CseHTbbFJwSfTxsoXYSSkOKXjt8atUArskjPQ3qewioNjTnWZ6+
         R68IgCEsw5rZye45umN5zzZ3qzLf8QndqdgG+bwCQ49pcTdftSjqCxpHbffFIGoDHkdY
         u3tw==
X-Gm-Message-State: AOAM531LLIx3OoyMQjK8KBhlSmpGkXd5URg1W30TSpbo5JAZkSim3hA2
        UYqVisyHv/K4npJIIQjOAAcjlwGqD/4=
X-Google-Smtp-Source: ABdhPJzucp6WJYwlxMTqkqdQ8NXP34GYhUuPfBsivNDQoSJ9v3AMogs/FsrTEwogn1UJ8x7w/1uzYw==
X-Received: by 2002:ac8:5946:: with SMTP id 6mr46274974qtz.373.1641354017142;
        Tue, 04 Jan 2022 19:40:17 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id t11sm31458246qkm.96.2022.01.04.19.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 19:40:16 -0800 (PST)
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
To:     John Cai <johncai86@gmail.com>, git@vger.kernel.org
Cc:     Tilman Vogel <tilman.vogel@web.de>
References: <20220104214522.10692-1-johncai86@gmail.com>
 <20220104214522.10692-2-johncai86@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <fe0b7337-3005-d09c-a3b6-65a100799676@gmail.com>
Date:   Tue, 4 Jan 2022 22:40:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104214522.10692-2-johncai86@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

Le 2022-01-04 à 16:45, John Cai a écrit :
> A bug in pull.c causes merge and rebase functions to ignore
> rebase.autostash if it is only set in the config.

The reported bug only affects fast-forwards as far as I understand, so I
don't think "merge and rebase" is the best wording here. Also, 'functions' is
not super clear. The actual functions in the code are 'run_rebase'
and 'run_merge', if that is what you are referring to. If you
mean the different underlying "modes" of 'git pull', I'd phrase
it more like "the underlying 'merge' or 'rebase' invocations"
or something like that - but again, only the underlying 'git merge'
is affected, and only for fast-forwards.

> 
> There are a couple of different scenarios that we need to be mindful of:
> 1. --autostash passed in through command line
> $ git pull --autostash
> merge/rebase should get --autostashed passed through
> 
> 2. --rebase passed in, rebase.autostash set in config
> $ git config rebase.autostash true
> $ git pull --rebase
> 
> merge/rebase should get --autostash from config
> 
> 3. --no-autostash passed in
> $ git pull --no-autostash
> --no-autostash should be passed into merge/rebase
> 
> 4. rebase.autostash set but --rebase not used
> 
> $ git config rebase.autostash true
> $ git pull
> --autostash should not be passed into merge but not rebase

Usually we start the commit message by a description of the current behaviour,
so in the case of a bugfix like here, a description of the exact behaviour
that triggers the bug. As Tilman reported, this only affects fast-forwards,
so that should be mentioned in your commit message.
While what you wrote is not wrong per se (although I'm not sure what you meant
with point 4), almost all of the behaviour is
correct, apart from the (rebase + ff) case, so I would focus on that.

> 
> This change adjusts variable names to make it more clear which autostash
> setting it is modifying, and ensures --autostash is passed into the
> merge/rebase where appropriate.

As Junio already pointed out, I'm not sure the changes you propose
are really clearer... I agree that adding yet another variable is unneeded.

> 
> Reported-by: "Tilman Vogel" <tilman.vogel@web.de>
> Co-authored-by: "Philippe Blain" <levraiphilippeblain@gmail.com>

As I remarked in the other thread, I'd prefer if you remove that trailer.

> Signed-Off-by: "John Cai" <johncai86@gmail.com>
> ---
>   builtin/pull.c          | 15 ++++++------
>   t/t5521-pull-options.sh | 51 +++++++++++++++++++++++++++++++++++++++++

The existing tests for 'git pull --autostash' are in t5520, so I think it
might make more sense to add any new tests there instead of t5521.

> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 66cfcb09c5..28f551db8e 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -251,5 +251,56 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
>   	test_commit -C src two &&
>   	test_must_fail git -C dst pull --no-ff --no-verify --verify
>   '
> +test_expect_success 'git pull --rebase --autostash succeeds on ff' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src "initial" file "content" &&
> +	git clone src dst &&
> +	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
> +	echo "dirty" >>dst/file &&
> +	git -C dst pull --rebase --autostash >actual 2>&1 &&
> +	grep -q "Fast-forward" actual &&
> +	grep -q "Applied autostash." actual
> +'

This seems to test the same thing as  t5520's "--rebase --autostash fast forward",
so I don't think it's necessary to add this one.

> +
> +test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src "initial" file "content" &&
> +	git clone src dst &&
> +	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
> +	echo "dirty" >>dst/file &&
> +	test_config -C dst rebase.autostash true &&
> +	git -C dst pull --rebase  >actual 2>&1 &&
> +	grep -q "Fast-forward" actual &&
> +	grep -q "Applied autostash." actual
> +'

OK, this is the actual test that was failing.

> +
> +test_expect_success 'git pull --rebase --autostash succeeds on non-ff' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src "initial" file "content" &&
> +	git clone src dst &&
> +	test_commit -C src --printf "src_content" file "src content\ncontent\n" &&
> +	test_commit -C dst --append "dst_content" file "dst content" &&
> +	echo "dirty" >>dst/file &&
> +	git -C dst pull --rebase --autostash >actual 2>&1 &&
> +	grep -q "Successfully rebased and updated refs/heads/main." actual &&
> +	grep -q "Applied autostash." actual
> +'

This seems to test the same thing as t5520's "pull --rebase --autostash & rebase.autostash unset"

> +
> +test_expect_success 'git pull --rebase with rebase.autostash succeeds on non-ff' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src "initial" file "content" &&
> +	git clone src dst &&
> +	test_commit -C src --printf "src_content" file "src content\ncontent\n" &&
> +	test_commit -C dst --append "dst_content" file "dst content" &&
> +	echo "dirty" >>dst/file &&
> +	test_config -C dst rebase.autostash true &&
> +	git -C dst pull --rebase >actual 2>&1 &&
> +	grep -q "Successfully rebased and updated refs/heads/main." actual &&
> +	grep -q "Applied autostash." actual
> +'

This seems to test the same thing as t5520's
"pull --rebase succeeds with dirty working directory and rebase.autostash set".


Thanks for working on this ! :)

Philippe.
