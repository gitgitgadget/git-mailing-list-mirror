Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGYRQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYRQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 13:16:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F89FE007
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 10:16:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy29so21708645ejc.12
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rOXOWhGC31cQTccQwOTduv6zgBqMlw6d+mjcUgEpGV4=;
        b=X7nDRDCauQzbH1OdU/D82Fc8M72SxRiFchCG8Jo25eeJLu043S0FwqgM27L+y/te8U
         uje4s4vVafouQrEKg1VnALN6jTXUlhisjupGoXLSpDF3n1JogtMe/HpOTRZ1tyFDiKtf
         W4MiiEQo5CUO4uH0ghf4gZs7+HEPQXRZzLzkUZMt+RpLY2YQDYNiGzkn4XAAqts4LAU7
         IPsZP1/3Wk8Jnravm3os0BcGL7BOuX+X31gei8XYuBDFg8/WDkGlYKwvielUbxzpjij6
         oKZM1t4m/bcwmeN/UGq52REnRibbBgr4ej5UMlk3pEJ9E/85ZjFAO0yVgvpXPl3x70Nr
         0Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rOXOWhGC31cQTccQwOTduv6zgBqMlw6d+mjcUgEpGV4=;
        b=cDAFo8y5E55iow/OUHpSt9ae2421GneT3uBdmS94ss+A1iU443hgPUOxrT4QOpWJUp
         uDB7dJLbVcudS2MdukAOe4mQAm6J1+MMK1A5Ptzgh0QVueMwm84cLKrDKD5zpho6I2pp
         L/umx50Zue9Ypc4sFAaX6BwJynsRyg1fGOZb8C4qFKaE1YOnlnaCpOzL0yOzCGX7+1Q6
         kiWsC7UqiM6VaUbva0TUznpLZ7tK9jYzcqs9TRLLHFlefY6etP6emDSwtVCa9q/1U55+
         mnzfC8s8N+zGUajkfKYjgTHakRHo7qZpp1yakhN8F7PuFKxrmmWw8vT18hf2MqUy0shC
         hmMQ==
X-Gm-Message-State: AJIora82MhQ0qR4w1jHyMHSFGfTf7faEArpGAXYMT2GzleHWss+9oi5G
        LkAsG1TKMVdbph0V2whqz0nnKnZX9Pw=
X-Google-Smtp-Source: AGRyM1s56zzkwJ0Wq1PloG1gcyPcmTdphKFE1vAU8LwEbUe62E2/BrTbn2HLmd+iE7PPoEj10sq2tw==
X-Received: by 2002:a17:906:cc46:b0:72b:83d4:de11 with SMTP id mm6-20020a170906cc4600b0072b83d4de11mr10420485ejb.428.1658769382356;
        Mon, 25 Jul 2022 10:16:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709066d4f00b0072f0a9a8e6dsm5591901ejt.194.2022.07.25.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 10:16:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oG1gr-005ocL-6b;
        Mon, 25 Jul 2022 19:16:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
Date:   Mon, 25 Jul 2022 19:13:13 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725123857.2773963-1-szeder.dev@gmail.com>
Message-ID: <220725.865yjlp0yi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, SZEDER G=C3=A1bor wrote:

> Several Git commands have subcommands to implement mutually exclusive
> "operation modes", and they usually parse their subcommand argument
> with a bunch of if-else if statements.

On this series in general, quoting from 19/20:

> Note also that this change "hides" the '-h' option in 'git stash push
> -h' from the parse_option() call in cmd_stash(), as it comes after the
> subcommand.  Consequently, from now on it will emit the usage of the
> 'push' subcommand instead of the usage of 'git stash'.  We had a
> failing test for this case, which can now be flipped to expect
> success.

This is good!

>  	/* Assume 'stash push' */
>  	strvec_push(&args, "push");
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2a4c3fd61c..376cc8f4ab 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -25,7 +25,7 @@ test_expect_success 'usage on main command -h emits a s=
ummary of subcommands' '
>  	grep -F "or: git stash show" usage
>  '
>=20=20
> -test_expect_failure 'usage for subcommands should emit subcommand usage'=
 '
> +test_expect_success 'usage for subcommands should emit subcommand usage'=
 '
>  	test_expect_code 129 git stash push -h >usage &&
>  	grep -F "usage: git stash [push" usage
>  '

This fixes the TODO test I left in ca7990cea5a (stash: don't show "git
stash push" usage on bad "git stash" usage, 2021-12-16), it probably
makes sense to link to that in the commit message, as it shows exactly
the output you're referring to.

After our recent off-list discussion about this topic I thought it would
make sense to lead with some testing of this behavior, so I had created
this WIP:
https://github.com/git/git/compare/master...avar:git:avar-szeder/add-usage-=
tests

Some of that is adding tests for the behavior of commands you're
modifying in this series, many of them suffer from the same caveat as
"git stash" did before this fix, and it would be nice to test for that.

But on the other hand maybe we're confident enough with this being a
standard API that it's just tested once, and we don't need to reapeat
for every command that uses it that "git commit-graph write -h" or
whatever returns usage that's a subset of "git commit-graph -h" etc.

I left some nits here & there, and would like to have more time to
review 10/20 in particlar (as well as others).

But this series is a bit winding, in that it's doing at least these N
unrelated things:

 * Fixes to parse-options docs
 * Tests for existing parse options behavior
 * Nits here & there, e.g. 08/20
 * The meaty change in 10/20
 * For 11-20 some of it's one-to-one with existing behavior, and some of
   it's changing behavior (but all in a good way, I think!), per the
   above some of which we don't have tests for.

Personally I'm fine with just bundling this all together, just some
reading notes from going over this...


