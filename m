Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D931F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbeGJVNz (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 17:13:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbeGJVNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 17:13:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so16016502wrn.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K08m7hlsatIzjauXziaUMWgMawSsj3GOWG4AsjNCkMI=;
        b=SUFb8RSAhKlU239UbjwAszZu3EHV7zc3lUlkyCc10gVGKXV75fUTawSquH8Zm6RFf5
         29C1fv7TbtT/ywwv6u5BQHPOjp64gq5a7P0pm9St2OymB6aXtaJXDfH5L4CIVH5f5CQ2
         cTjFJH5UjiO5YkhHYQuH1L+8SQcfjQ3ahxK24JHEW1JTMwW01Wd94FuBgs9NzTDXDEfL
         unNqTYrVPdZjdcQuIkUa/Oa98XqA+cPbG8fMuJPCk4NlOkil2UMbIfunYdfPNAcG5Wxu
         c6XUjq5hex34WPipiIz0pQEKVeZpsQgbTv2ViSBHiL+WoF77njStTsbt4iEX4zsD7Tpj
         A+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K08m7hlsatIzjauXziaUMWgMawSsj3GOWG4AsjNCkMI=;
        b=jbSyLAYxCkO1zsKhmIQeKnPRlpAoc1HOf0k5+bVVnK6f+0saZRNrYW45Qrgw+h9K/z
         7f3BIKk4gKDvnJTYmF2uPo6waQkxxSjFmUS7V1hvPoSo/j5W8UTCNgzwRHA8K2plXkJG
         vYxEwewpcXihqKFUeLf2d/edZy0J1H5GWLfa9/cn8Sh6ftxXQ39tiYCgDnpO/j7gb06+
         S6kQ092t0CGugdfMBQ5ThPo46NgvmwCC3XsxVCa+98aEo4Sb6HOYqoPeQ8IQLltbVAyQ
         9zRYkI3rUxeWZ2bCp7kljfakKTX5YwkDEyaTjyawF+88Jx3KBACuT5eqC31t7tuiJ8Nw
         2LhA==
X-Gm-Message-State: APt69E0FTK0JTXn7pmxlWi1+cdaiZcEw3IdsKk0Zfzl13GD1ELRFikRs
        08kLhLAM+ED3mB+Fn/7zKQo=
X-Google-Smtp-Source: AAOMgpcQm/Ec0K6Nw6dHtQjjPzA9ZQNx4K9kt9vZvC/4sW8b6UQ+0iWEh8kf1dB28MO1MOh1FeWwuQ==
X-Received: by 2002:adf:868d:: with SMTP id 13-v6mr17451380wrx.281.1531257178546;
        Tue, 10 Jul 2018 14:12:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z62-v6sm236401wmc.10.2018.07.10.14.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 14:12:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests with GPGSM
References: <cover.1531208187.git.henning.schild@siemens.com>
        <cover.1531208187.git.henning.schild@siemens.com>
        <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
Date:   Tue, 10 Jul 2018 14:12:57 -0700
In-Reply-To: <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 10 Jul 2018 10:52:31 +0200")
Message-ID: <xmqqlgai6bhi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Add test cases to cover the new X509/gpgsm support. Most of them
> resemble existing ones. They just switch the format to x509 and set the
> signingkey when creating signatures. Validation of signatures does not
> need any configuration of git, it does need gpgsm to be configured to
> trust the key(-chain).
> We generate a self-signed key for committer@example.com and configure
> gpgsm to trust it.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/lib-gpg.sh               |  9 ++++++-
>  t/lib-gpg/gpgsm-gen-key.in |  6 +++++
>  t/t4202-log.sh             | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  t/t5534-push-signed.sh     | 52 ++++++++++++++++++++++++++++++++++++
>  t/t7003-filter-branch.sh   | 15 +++++++++++
>  t/t7030-verify-tag.sh      | 47 +++++++++++++++++++++++++++++++--
>  t/t7600-merge.sh           | 31 ++++++++++++++++++++++
>  7 files changed, 223 insertions(+), 3 deletions(-)
>  create mode 100644 t/lib-gpg/gpgsm-gen-key.in

I saw my post-integration tests taking forever to finish for 'pu'
and "ps x" output showed that many tests (I ran tests in parallel)
were stuck and all of them were running gpgsm. 

For now, I've ejected the topic out of 'pu', as I want to finish
today's integration run with all the other topics first before
coming back to this topic.


