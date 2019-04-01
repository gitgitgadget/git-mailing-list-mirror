Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEB620248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDAKrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:47:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38795 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:47:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so10793708wmc.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=eHCIxRB0PCB2p/0Fr4re1zh7CqSxoe+RroVrhUJxjnU=;
        b=lXMxczJXlTZNdqTgyguVJQLFKTnmGwcgxNRRTjD6ASl4C0iTeDbKDXlYW2qIxpi9PI
         NT8FfrTP1t5Cgz7x8XqC36uMHy1gphEMGaI09bHYtiHt7TLxCCo0pBGk/nmFyDy2qIs4
         d+sd5dBFDDiwsGdhETaX0oPOYDk+kxYIK6RcYYjPBMhPRoZFa7cqcGu0Bl+pLgxIxH07
         pgfWnYDS0GqI2NMUGlcQWH9ewkrAuFUWq2/rw5m4iKiH81K87yiQtlu2bb1cZ9wJ82pj
         FYr2pUmnbqFgHo6eOXVD6CO4fC9aB73C3HCj9eFpeX1thZ+Ps2n7Wm007YKArIUCBRN3
         8/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=eHCIxRB0PCB2p/0Fr4re1zh7CqSxoe+RroVrhUJxjnU=;
        b=ct/1yTB818PI6mkrfBgvbKaL6H60Njf19L3TEK72hLunL8RXeFotFe4q+YUyDjyuHU
         4f36lJ35Vl+NV/1LikukYJOTK8h2mCFDRVxj/X9fZG2PsjocI5nXGf5gOC3COQmtRFKf
         a5lHPxsH8XDmnMCQaIqCKCfIWMJiI2lwHa/RO/csRG6VH6hltxzfXzyIcyb7oqUYYSGy
         DV7xgs7xaeaMsUE4FwJtUNL0N7drdzsk3+KqEU21bnPr0gzfzDsazyhingy1uEkuHSaF
         py5lcZhJlvFBs7efLTVWjF1PpVUDjaBNRDtxGGd9HRK1oXcK7fPcZRVPvhbq6OiLu1hu
         ANIw==
X-Gm-Message-State: APjAAAV8Ls8E0llbadGPfk9jZUOtmbtIvMcDqN/I3hCp3A9558mMUqkn
        X3MCzdH+ITWlhwS0S6cdhQc=
X-Google-Smtp-Source: APXvYqyp2yBoNaiKGN2BKsB+VojIwAYsdLXoMFhkSu4gposhckLEEjWV1YlNASS6tG6cEobStTYT7A==
X-Received: by 2002:a1c:7ec2:: with SMTP id z185mr13009131wmc.69.1554115636236;
        Mon, 01 Apr 2019 03:47:16 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y127sm8812706wmg.29.2019.04.01.03.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:47:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
References: <pull.167.git.gitgitgadget@gmail.com>
        <20190325202329.26033-2-avarab@gmail.com>
        <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com>
Date:   Mon, 01 Apr 2019 19:47:14 +0900
Message-ID: <xmqqtvfiuhn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I don't get why having a configuration option is better for defending
> scripts against this problem than a simple environment variable. It
> seems easier for the script prologue to contain:
>
>     GIT_TEST_ABBREVIATED_OPTIONS=false
>     export GIT_TEST_ABBREVIATED_OPTIONS
>
> than for it to muck about with git-config or use "git -c
> core.abbreviatedOptions=false ..." everywhere. The commit message
> doesn't do a good enough job of justifying the configuration option
> over the environment variable.

Absolutely.

One thing that big brotherly types would find config attractive is
to install centrally managed /etc/gitconfig so that they can tell
the tracing machinery to log all git command invocations centrally;
with environment only system, it is not easy to arrange.

But this one under discussion is probably a use case that is at the
other end of the extreme from that.

Users (1) may use scripts written by third-parties, (2) may also
develop their own scripts, and (3) even may run Git commands
interactively.

It is a laudable goal to introduce a mechanism to "notice use of
abbreviated options that happen to be unique right now but may not
stay unique forever and warn against it".  But (2) among the above
three uses is the only use case that wants the protection, which
makes the configuration a poor fit for the purpose.




