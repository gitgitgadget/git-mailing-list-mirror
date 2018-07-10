Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809411F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeGJQzC (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:55:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37917 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933275AbeGJQzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:55:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so24942233wmf.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fEge9r3iSrsHPJb235nEAHeMQWYAfAHKxcDqMoZZSZ8=;
        b=X5xrIPJyrGw2xJ7zi/5ywxvsJwap+KuUm7bEKVjBYi57kD4gyaUDTAipMm/f27ELRj
         jh0vsF5hF0y52jTqb9om67CyLBKPlCKtENfEGeL5I5qGWALyW2HrAIYgHZISUoqCXg5y
         TV9GeSW7nPIh5/8te/6Jv1HQcw2ME7BoljzJHOm+kuJ/9NAZIV5yCWpajFuKA/zkrQzl
         lGUhyb++Dkz3F7/3c3Ji+XEeLBK1yGU+B3LdAURQ7fZWVozT1KPlgreBU74/bnX88/hr
         CNoBqg42/epQuFN5obYJeRtkk0M5alYsN+akFM+f0fo3TaNcnkvR/cRgTnfjSONz3kjn
         3JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fEge9r3iSrsHPJb235nEAHeMQWYAfAHKxcDqMoZZSZ8=;
        b=lifMxzQwXbKgj1iZuDPzoIKu2l6dPFCGeEcqm1CpbaX6CfzFciI+Rg+A0qcui6xnh7
         5Vk0MpGbtlICfv7iepLJBaMz5QEFSq97s+uiMnLlRMa2yIT7ijl4WKZV62AxtLDuQ9ex
         emjon7PKXgN0uBM1b/5GB3PCMVI0F+b9j8YU9rzxwXK7V2EGAhrbOFEXn/J89yZM81Pj
         UzMxHBNcz8jM9OH3L08b2gQfNV7+nXfmav09zAEplDcGCjiUMgBc8S9231ZIJ1tm7Iaj
         Vbn2Hz0XjSl++2pNX++tSwGI++B1Xd8/GjwHEAKzfXxDcvEza5TXaJepnH783xKGON0P
         bfBw==
X-Gm-Message-State: APt69E0BG947LNzGI1Z9NIEJ1LxoqCRY0YbbSau6Ra2o+0N3piR6guox
        XVrQXaoPYK2qnQ4gG21mK9s=
X-Google-Smtp-Source: AAOMgpfYznnro6Z9pnSo+1BpjPcQs1c2BB2l274qiKD/kbW+Tor+MFQ4j70N/gl5eYoXYBqZRh33Aw==
X-Received: by 2002:a1c:d78c:: with SMTP id o134-v6mr14729576wmg.115.1531241700113;
        Tue, 10 Jul 2018 09:55:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c18-v6sm22592825wrq.17.2018.07.10.09.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:54:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/9] t/t7510: check the validation of the new config gpg.format
References: <cover.1531208187.git.henning.schild@siemens.com>
        <cover.1531208187.git.henning.schild@siemens.com>
        <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
Date:   Tue, 10 Jul 2018 09:54:59 -0700
In-Reply-To: <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 10 Jul 2018 10:52:26 +0200")
Message-ID: <xmqqr2kb81zw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Test setting gpg.format to both invalid and valid values.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/t7510-signed-commit.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 6e2015ed9..7e1e9caf4 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
>  	grep "gpg: Good signature" actual
>  '
>  
> +test_expect_success GPG 'check config gpg.format values' '
> +	rm .git/config &&

Please don't.  .git/config has stuff that are more important than
just collection of random configuration these days, and we can even
expect that future versions of Git may not store its config in a
flat file .git/config but in a different mechanism "git config"
command knows how to access.  A low-level test for "git config"
command's operation may have to be implemented by inspecting the
resulting .git/config, but as this test is not about "git config"'s
inner workins but is about one feature "git commit" command has,
we prefer not to depend too much on the internal implementation
detail such as "local config is stored in .git/config file".

Let's hear why you want to remove this file; what things that have
previously been placed in the file do you want not to see, before
performing the following actions?  Once we know that, we can suggest
a way to do so better than removing the entire file.

> +	test_config gpg.format openpgp &&
> +	git commit -S --amend -m "success" &&
> +	test_config gpg.format OpEnPgP &&
> +	git commit -S --amend -m "success" &&
> +	test_config gpg.format malformed &&
> +	test_must_fail git commit -S --amend -m "fail" 2>result
> +'
> +
>  test_done
