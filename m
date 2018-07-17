Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDFA1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeGQWGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:06:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35398 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeGQWGd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:06:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id y22-v6so772290wma.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=3FxAwiH/LxpThJ37RDNPGswHEXUlnsOnhNtC5xhS3Wc=;
        b=FJ2mxQ7STPNg7TIddisl7MiOblD0CoFL4i2PIvuh7DclrKysMNfh0yasyVfiDdtcW/
         AjMpIsZYnvHLHBHsI/mcfgxIg4qhr891dnOzHk2GJhY+YIqoZHzGDFmrz1YtjEHyaKdk
         RGxOLRRhcw8EMHBse1NpP3UdinMY1mtGXpvbfVNHbbS0AHSZ8dUdGC8+XKdg4RNWMbUZ
         D3xjGJ/LWHveVxDx5UTttWc9PDivyJu7FyG9E2Gp9h5iq2dRJ0f+52mPKHbzjNSlZPaR
         Lll/ef7jdHY6byK+43N5gZyvxdfRtKstBfyho6js5rRr+jJoNOhdz/ZwIGmb/oTqkQsO
         +euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=3FxAwiH/LxpThJ37RDNPGswHEXUlnsOnhNtC5xhS3Wc=;
        b=BMZF2LKUj+pnfV/g5PTaXECeqZnM/daExaWJafvZdc+T/BHwqNQcFyBCZy97P3UOb5
         VQSSE5m7CnHFNjBcmmC1AkSUrvs+LyODVizKFMD+4o20+YhZ4fHe0BjE2XAEjsedDc3N
         mCH7MIVkRs7F56mCs8PwrxSUucmCAaf1EteCn2MaLXd1fmfTgKPdM+rZAiidZhZgBwuj
         u+brorfus93z9aRZVzVCcrhgRSMay4hvskVgAJfddVagaAgulZlAsTplzZZxRiRrfJHr
         KtdvT1GIvWsAZJsdYqzZIH9aTIc0nB41NFdvWganTUXXdDMxYh71j5PA3l20RBDpr7m9
         c77w==
X-Gm-Message-State: AOUpUlFofH1CMgnkVWOPuUK2aeLsQ9xnECSP7gejY5KpQcCnkUxQm5Dq
        P8Sr+NQV8ezLsMQer3y250Q=
X-Google-Smtp-Source: AAOMgpf3JglXHlNjSlMmlNMRNb26MoboQC4CldGwIu1Fg68dP4j0DFkkXlMpA38Hg1n9/wZBJ4P7qQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202-v6mr2334618wme.148.1531863117906;
        Tue, 17 Jul 2018 14:31:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t140-v6sm1029059wmd.14.2018.07.17.14.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 14:31:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/7] t/t7510: check the validation of the new config gpg.format
References: <cover.1531831244.git.henning.schild@siemens.com>
        <cover.1531831244.git.henning.schild@siemens.com>
        <2f806c4fa4454af59344f0f0e77d1ae8048aa841.1531831244.git.henning.schild@siemens.com>
Date:   Tue, 17 Jul 2018 14:31:56 -0700
Message-ID: <xmqq7eltmtv7.fsf@gitster-ct.c.googlers.com>
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
>  t/t7510-signed-commit.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 6e2015ed9..7bdad570c 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -227,4 +227,13 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
>  	grep "gpg: Good signature" actual
>  '
>  
> +test_expect_success GPG 'check config gpg.format values' '
> +	test_config gpg.format openpgp &&
> +	git commit -S --amend -m "success" &&
> +	test_config gpg.format OpEnPgP &&
> +	test_must_fail git commit -S --amend -m "fail" &&

This second one is a good demonstration that the value for this
variable is case sensitive.

> +	test_config gpg.format malformed &&
> +	test_must_fail git commit -S --amend -m "fail"

And there is no longer a good reason to try another one.  Let's drop
this last/third case.

> +'
> +
>  test_done
