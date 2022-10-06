Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E729C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiJFQH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJFQH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:07:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F71098
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:07:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m3so3469447eda.12
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCTEH1jG0/tYcnv3J4KVyE2dsX48lw+XkxndmQbkoq8=;
        b=JKeFn3DtsAKh7DZ4OyFRCABc5zddfz9yi1DQu4muwsBvLl90QuKJEvBGjGrF21H9o0
         BGiIxiMWfiv5VJhxFdraf+A6C7DnMk9coimJnu/DWZevMkCChBCU91OMbLwAkrvQdqjT
         OJ+dObYcRloRav4ScxCpG+QEGiiCV4M9iyYzuD7rtiapkNTNbLSAVJ1R1piJQmy4C8CO
         QB3AZQ5ZmehLka5pJW7+LPbhq1snYhg2tVJ4CrRG/gCooK47n1ko/PCQnlx0e0F0U3h7
         41ZpT+hBZvUGO3XiCzErJuR9cmALlHTphCnyIgmMBFgZNO1QLnufgLMfFp9Bi62Rsvpr
         M0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCTEH1jG0/tYcnv3J4KVyE2dsX48lw+XkxndmQbkoq8=;
        b=pB3WZ70b8gYQUqnSf6+2L9LPzFnc+TSNa0CNa/KI1k2PGn4F9pijwxTCkXcOpMeL8n
         oiiRmOiyknTQP4HVqcpUXgUVN3HI3M5LfsKoRPwgy/5QWku31TSL0vY50R5zDYy6tQtc
         SdZOi1aCTP1YVbezX9hEZ50SbpRGKAoLoi4nQSswIffJyRi3A/Aih3EMXBdo2fLgJDXc
         8wpoOYvc3p0bL+d/GdNYhAKuNg+bS6A2UwOJyVo/mS4bTa10pOFhuysux5s8IpTgwUka
         UeRVMyVd4IdUktJmiCaAcnS6zvpTu3581OVRPPCm65Ik7SxcM+9T7n5FMXIdB/a4uik/
         RU2g==
X-Gm-Message-State: ACrzQf3tRUJ4BK84vi1lkaxBZriWXQ9hutQjkFWlVoZReQwY/zHD9M+l
        d82HKwo4eWlWPsEQojig0MK0t1qwdSs=
X-Google-Smtp-Source: AMsMyM4qyAi1ZGeAH6s0e3cUKoloFECfjJDIhnorl+NBesbNIUN5T8I8RoWMQDL6wQI4/MNRN3Zs5Q==
X-Received: by 2002:aa7:cd92:0:b0:456:cbb5:2027 with SMTP id x18-20020aa7cd92000000b00456cbb52027mr498817edv.384.1665072473086;
        Thu, 06 Oct 2022 09:07:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7c64a000000b00459ad800bbcsm3463819edr.33.2022.10.06.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:07:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogTPb-002xj7-2Y;
        Thu, 06 Oct 2022 18:07:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] [RFC] test_todo: allow [verbose] test as the command
Date:   Thu, 06 Oct 2022 18:02:23 +0200
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <c0d955c2d1fa234ad2e4a8aad467b991030ccf47.1665068476.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c0d955c2d1fa234ad2e4a8aad467b991030ccf47.1665068476.git.gitgitgadget@gmail.com>
Message-ID: <221006.86zge9q6js.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> For simplicity test_todo() allows verbose to precede any valid
> command.  As POSIX specifies that a return code greater than one is an
> error rather than a failed test we take care not to hide that.
>
> I'm in two minds about this patch. Generally it is better to use one
> of our test helpers such as test_cmp() rather than calling test
> directly.  There are so few instances of test being used within
> test_expect_failure() (the conversions here are not exhaustive but
> there are not many more) that it would probably be better to convert
> the tests by using the appropriate helper rather than supporting
> calling test as the command to test_todo().

I think that we might want to salvage parts of this, but we really
shouldn't be spending review time on carrying forward a bad pattern that
hides segfaults.

I.e. whatever we do about "test_todo"'s interaction with "test" let's
first change things like...

> -test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
> +test_expect_success CASE_INSENSITIVE_FS 'add (with different case)' '
>  	git reset --hard initial &&
>  	rm camelcase &&
>  	echo 1 >CamelCase &&
> @@ -108,7 +108,7 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
>  	git ls-files >tmp &&
>  	camel=$(grep -i camelcase tmp) &&
>  	test $(echo "$camel" | wc -l) = 1 &&
> -	test "z$(git cat-file blob :$camel)" = z1
> +	test_todo test "z$(git cat-file blob :$camel)" = z1

...this to e.g.:

	echo z1 >expect &&
	git cat-file blob :$camel >actual &&
	test_cmp expect actual

Or whatever, then let's see if migrating "verbose" is worthwhile, in the
post-image you end up with no real users of it, only your tests.

I've wanted to just remove it for a while, all its users seem to be
either bad uses like that, or we'd get much better bang for the buck out
of it by having a t/verbose-bin/ or whatever, which would just wrap
arbitrary commands like "grep" and the like (i.e. ones where we could
provide useful context).
