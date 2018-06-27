Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F6A1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 19:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeF0TUh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 15:20:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39089 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeF0TUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 15:20:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so3112119wro.6
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XQmVbdSVrR/yJoeYDMeM7XoQSpGj3ZktZXMdbxDZwhQ=;
        b=qnjc6b0KXfgc9vhoNxqAZcx6ZtXKuxajzpwEAMUmYuS63MMmmtLileDaMBpDGZakdm
         pkxCqpB/t+shzkwRYUt9VJgD4LZMzSZIna/rrbAwRAEGFfpA5cUMOWeWe+TGR/sSvtet
         4rpbVSXjxiftws0AAn2pbV4E4NsTQB+8VK89SkylZqgsdctxveDa8jaRyngkFPWxTYFV
         qwozT9K69zLROyh4gGQPCUzKKFNt8kVdTT/Y2PcYoDvVq1tK5JxpogoiwmBpqA7L0V6R
         n7p8LBCaztk5yuyH5sfqu52vu7iorD54t6LOT3maDjDbHTZABKuNREq2k4jxBb5Ra9FX
         09DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XQmVbdSVrR/yJoeYDMeM7XoQSpGj3ZktZXMdbxDZwhQ=;
        b=KJhwhNSiWncvDsAOaZffilJbXepTZNBf8GpF8Q24ImRkXAQ26DZ70CkWNnTtE6byFq
         pHYKUgjCfYyudRc3Idv35Er+V9ANBq1RjlyKdgzs2MiXLSmTWcaOaJNus03VvTgijz3G
         LDIGgm/mhN/G+XVewy4qLo2gHu4FEVnIKCZMgJuxQ+sy9/FbsH6CISH4dNPiH+qQX8xl
         CIot0D/azt6VRYyWuOOaTUsQNVJL9/EyJq/aZ67DFFMRjZpWHKHnA0JydviejyqOmEM9
         WkABHhv3dZ14TTu9AJ8K138vFypKnzvrKNV2donFdu63lTel1M0OOxNOquXEmjyYCkPn
         HSCQ==
X-Gm-Message-State: APt69E3MSLT10bRo/Z4M//NO0DQRNdvCP9TFPiMsxcl1cMGmXOAq/KgA
        13+tYCdKnI7yo8KaOnY1+h0=
X-Google-Smtp-Source: AAOMgpfI2YC3yn06lvRfd40BjejeFXQDZqi1maq9QNVNgF/QkOWBzvN8yh3S80zZecxG6Mg7BQ6l0g==
X-Received: by 2002:adf:b909:: with SMTP id k9-v6mr6243349wrf.116.1530127235351;
        Wed, 27 Jun 2018 12:20:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z18-v6sm3816176wrp.59.2018.06.27.12.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:20:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase -i and strategy options
References: <20180607050845.19779-1-newren@gmail.com>
        <20180627073623.31725-1-newren@gmail.com>
        <20180627073623.31725-2-newren@gmail.com>
        <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
        <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
        <xmqqh8logofg.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
        <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org>
Date:   Wed, 27 Jun 2018 12:20:34 -0700
In-Reply-To: <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org> (Johannes Sixt's
        message of "Wed, 27 Jun 2018 20:17:41 +0200")
Message-ID: <xmqqr2ksdojh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Pitfalls ahead!

Thanks.  I said "at least the latter" for this exact reason ;-).

> 	PATH=... git rebase ...
>
> is OK, but
>
> 	PATH=... test_must_fail git rebase ...
>
> is not; the latter requires the subshell, otherwise the modified PATH
> variable survives the command because test_must_fail is a shell
> function. Yes, it's silly, but that's how it is.

Or you could do

	test_must_fail env VAR=VAL git rebase ...

which I am not particularly fond of, but seems to be used quite
often.
