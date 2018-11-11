Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5F71F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 14:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKKXs5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 18:48:57 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36166 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeKKXs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 18:48:57 -0500
Received: by mail-ed1-f50.google.com with SMTP id a2-v6so5296628edt.3
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8TInDzzrHXHoOGRrrhy9SN+MSmhc4a8FUpz2lxqv4s0=;
        b=hX7c31Krv/aF5PiIzAw8S/vQNCqtWh/zWovLrNmZ2PWeh9gDJLslr/xAZf8OM4LD2H
         oq6tSDcEK91L6hFDQu4xzv5gYEYN38xu47VQf/3BVvGgqbebHjfroRG/L0+lsr7Zn2gP
         pUi943DY30+euyVgR4r2TCbO8xxEsTcXcuiUGTZkfu/2s0bdZTghaClYM5tyzkvi+Txt
         yxG95g7V8/11tVQrqlBa07BnnMigzlsTMg321oEF3XVZifW2eCUdJ8ZFL/UKbZbUIonA
         CUZsb+tSte611mQeze+tBxKmZzgwfuxNO/WZxyBwuGUST/qL5zzXrK5RTHAM9pfQhQiL
         o+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8TInDzzrHXHoOGRrrhy9SN+MSmhc4a8FUpz2lxqv4s0=;
        b=YkrPARkcP/yoK6yE0jpp+AtoPRW2atkc8/Wy2B3vhMfNPJWz91qUzUbeUjcpGsxfdA
         xUGykIFt06xkepsqTxOzu4dqVqbRP4PM7+V/v8+bJbbFAR2wXK1M/ERY48W5ROB/Wu1k
         cTd0ZouBWRSWqN8uze+u0ZPL6Wf4vXzyDm7kUr/B+CU8ZkDwlGhX3hps4oZMgI1XBGG8
         vavG0UcEYdb2zKzs+F8eNm8epSPDF/IN7obG6ytOzLUHdjw4ipWo+EEyXHoqf92zS3Gb
         d96er2qzWhZtyhq68Q1E28Xx2mZL+GSJEosJgkI/C023ZPoxdeixTWLx+rsoURhjIJoF
         b19w==
X-Gm-Message-State: AGRZ1gKL3O2p+NIbDkBEEQphPSZfIfDskQ+6hnDLr9XqyY3vpwfLaAGu
        69+olEYyCh2o6nwEIuveT1T6YhqE
X-Google-Smtp-Source: AJdET5cx2FfXUIgGfOt92aDG38ni1NkjYpKWyH76MyLxp1dUhXJgcVHWmqoyac4M3/J/78JejLfvAQ==
X-Received: by 2002:aa7:c2c2:: with SMTP id m2-v6mr8858826edp.79.1541944816838;
        Sun, 11 Nov 2018 06:00:16 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b39-v6sm3939815ede.42.2018.11.11.06.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 06:00:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Federico Lucifredi <flucifredi@acm.org>
Cc:     git@vger.kernel.org
Subject: Re: BUG REPORT: git clone of non-existent repository results in request for credentials
References: <708E1759-B2E3-436C-9D54-214159655B1B@acm.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <708E1759-B2E3-436C-9D54-214159655B1B@acm.org>
Date:   Sun, 11 Nov 2018 15:00:15 +0100
Message-ID: <87y39z3ea8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 11 2018, Federico Lucifredi wrote:

> git clone of non-existent repository results in request for credentials
>
> REPRODUCING:
> sudo apt install git
> git clone https://github.com/xorbit/LiFePo4owered-Pi.git    #this repo does not exist
>
> Git will then prompt for username and password on Github.
>
> I can see a valid data-leak concern (one could probe for private repository names in a brute-force fashion), but then again the UX impact is appalling. Chances of someone typing an invalid repo name are pretty high, and this error message has nothing to do with the actual error.
>
> RESOLUTION:
> The error message should indicate that the repository name does not exist.

This is a legitimate thing to complain about, but it has nothing to do
with git itself maintained on this mailing list, but the response codes
of specific git hosting websites. E.g. here's two issues for fixing this
on GitLab:

https://gitlab.com/gitlab-org/gitlab-ce/issues/50201
https://gitlab.com/gitlab-org/gitlab-ce/issues/50660

These hosting platforms are intentionally producing bad error messages
to not leak information, as you note.

So I doubt it's something they'll ever change, the bug I have open with
this on GitLab is to make this configurable for privately run instances.
