Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2ED21F404
	for <e@80x24.org>; Tue, 10 Apr 2018 01:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeDJBW3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 21:22:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44724 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeDJBW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 21:22:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id u46so11269509wrc.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jSEzHkaiRty3SAZNFmH1XMVZEhWkNqL7hdH0yezpbnw=;
        b=RYBWiLQb7dl3MxdtSEdWabeYf/K6Fdspgb1/fIYmFeg7HNpt4POMC0rBmQm6tEaxw6
         spW9jPgf8EO7h1RaZCZ2gpa8x5p4jCvWpnl2uFKduTbxGV+TH6czx4rddo1m6x4e/0ef
         wkjVHzXUxJpw+WUmCN1uuPo0rJLWzpF+lGL2kvSFLaW17r8Sjq3AbP+6frnqGYGPLZO+
         BK89LicRF0Bmwfg++YSntw7Kj4O/9/kAArcIxR1nNwxJnrt76ANbNuegr8+nNpk1LfvG
         Y3aaV/9vgtExbTKXaMyiiKdmNbtQpdlmQtK4fbJ6efxvaR0okUREEWh+BE1E5rj0UwDD
         AOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jSEzHkaiRty3SAZNFmH1XMVZEhWkNqL7hdH0yezpbnw=;
        b=iHkztk8sFOB6rsIaqSn1Va6YutzQM2ZOnSHfA5ZCyv4OstB4S2CMS/eE8dA6Qee1NN
         Fa36Az3BS34ZrV0xamwALTONhhg/yZ9j3/whsrd8ELWIne2uv7oNHNSCrc6xke8hqmA2
         kyUm968QZaRQv+hvH7ikJukwNBPvyAqVsDBO2sXcKxaKA05F7/32rCFaRrdxTdggAQGq
         K2xI0t8a95xuPG8PUGNRn7l3Xrgt4Zjx7it8wUr8bOHaol0kpGY7hqWNOch52LVecUvT
         w6fH8j4lkcGs4Nl5qJfPGcJKY5vX61W8FeOBqx1iMvcc428qITJlX0AxOvgK1dy2hvR6
         GaVw==
X-Gm-Message-State: AElRT7FwdzMOGO3iRnPF1vy+xYemYHUBg2OgDbPvpMmA7symgfs6eJfk
        rRK8hj3l86lTAvXd33SWnNrFlTJ5heg=
X-Google-Smtp-Source: AIpwx4/XMdftPGb3Igmfr9cItLYWAXpN9ElANlJffJ/XL/2jvk7KAomN43nfpB0GaX7ycLN5lJDPUQ==
X-Received: by 10.223.225.17 with SMTP id d17mr25973231wri.51.1523323347340;
        Mon, 09 Apr 2018 18:22:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a63sm2127994wrc.22.2018.04.09.18.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 18:22:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, ericsunshine@sunshineco.com
Subject: Re: [PATCH v7 1/2] builtin/config.c: treat type specifiers singularly
References: <20180328234719.595-1-me@ttaylorr.com>
        <cover.1523313730.git.me@ttaylorr.com>
        <20180409224654.GB34547@syl.local>
Date:   Tue, 10 Apr 2018 10:22:25 +0900
In-Reply-To: <20180409224654.GB34547@syl.local> (Taylor Blau's message of
        "Mon, 9 Apr 2018 15:46:54 -0700")
Message-ID: <xmqqy3hv4zzi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Internally, we represent `git config`'s type specifiers as a bitset
> using OPT_BIT. 'bool' is 1<<0, 'int' is 1<<1, and so on. This technique
> allows for the representation of multiple type specifiers in the `int
> types` field, but this multi-representation is left unused.
>
> In fact, `git config` will not accept multiple type specifiers at a
> time, as indicated by:
>
>   $ git config --int --bool some.section
>   error: only one type at a time.
>
> This patch uses `OPT_SET_INT` to prefer the _last_ mentioned type
> specifier, so that the above command would instead be valid, and a
> synonym of:
>
>   $ git config --bool some.section
>
> This change is motivated by two urges: (1) it does not make sense to
> represent a singular type specifier internally as a bitset, only to
> complain when there are multiple bits in the set. `OPT_SET_INT` is more
> well-suited to this task than `OPT_BIT` is. (2) a future patch will
> introduce `--type=<type>`, and we would like not to complain in the
> following situation:
>
>   $ git config --int --type=int

The above does not exactly argue for adopting the last-one-wins
semantics, and still leaves it unclear if we want to complain
against

    $ git config --bool --type=int

Is it intentionally left vague if we want to (or not want to)
complain when such a conflicting specification is given?

We could keep the traditional behaviour of "only one type at a time"
error and still move away from the bitset representation that does
not make sense, if we wanted to.  Initialize the "type" variable to
an unset value, and use a callback to ensure either the variable is
set to the unset value, or the value being set is already in the
variable.  I think if you use OPT_CMDMODE(), it would do all of that
for you automatically.

I suspect that it may be OK to switch to last-one-wins, but then we
should give a justification that is a bit stronger than "we want to
avoid complaining against --int --type=int" (i.e. "we want to switch
to last-one-wins for such and such reasons").

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 4f8e6f5fde..24de37d544 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1611,4 +1611,15 @@ test_expect_success '--local requires a repo' '
>  	test_expect_code 128 nongit git config --local foo.bar
>  '
>  
> +cat >.git/config <<-\EOF &&
> +[core]
> +number = 10
> +EOF
> +
> +test_expect_success 'later legacy specifiers are given precedence' '
> +	git config --bool --int core.number >actual &&
> +	echo 10 >expect &&
> +	test_cmp expect actual
> +'

And this expects more than we gave justifications for in the
proposed log message.  I do not think it is necessarily a bad idea
to switch to last-one-wins, but if that is where we really want to
go, the proposed log message is being misleading.  It is true that
OPT_SET_INT is more suited to complain when two conflicting things
are given than OPT_BIT, but this example actually tells us that you
no longer want to catch an error to give conflicting requests.

