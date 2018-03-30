Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA681F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC3SG0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:06:26 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33741 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbeC3SGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:06:25 -0400
Received: by mail-wr0-f169.google.com with SMTP id z73so8623596wrb.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hfObI7ipVboRiIZ2jCHmmqCZE53mQa+t3s5A77dTaXo=;
        b=CxEQg+e8yaCIeqATO8+YUAfZtD1c1pLlWUIUfrH3zwInaUZlzySTXQFwmpcvZtZgbl
         D4qtF9WgZYhx9uWa/RxJkh2rElZ7ULnAaqG43iAwkunnNxANArzlgC5BtkFEs/ZFBVbo
         BKUofYkRkTnOwQs+ezLpFTeWE5JhyGeL3a7DRQU7p7Cww1lkvD6kkTc8irCiDpggphTK
         Ov/tw6e5t3VtXme4BLjxGn/xmrVtpN3/M0RIop6BSltl2wbWOX+2XLB1eNZ/cp9MQ4aY
         KuXox/C7mSIeKW6lVUd1K5zWmFhDGod4KF+dEAuyfgQlPFObBaEgIz0juwqNaKh58SLj
         5/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hfObI7ipVboRiIZ2jCHmmqCZE53mQa+t3s5A77dTaXo=;
        b=ZrppZ4CXKBbhuz7yos9vh5HGJDAyK+0uG1prlEDKOUdg436kBQW1sg8Qqv0kNyULRu
         gE5VnP5hbRWmLmr9QXu/qg0wSNKJnPStRY3zBkIM/Lp/1bKQ11ryguLdC6yj8wmArjiZ
         1Jkggk4t6XBlxCLdfeuq2De12fKJu367fPpJOuiamPRTkpqpUFoPk6a3LO/8ZlwWS4RU
         8Rl7hwX8vQOaoUsfFPgYkdvaXyD4mxKf0FJPLq9qF5F/4dEpcag+aNI2xG8swuqU0WXd
         HbQISpeTpRs/QO0O2DMxoJ+7mcZiLuLnJiq4KBNY8mPmhGU3LT1GwLg9xhuAgn+E1Clw
         7niA==
X-Gm-Message-State: AElRT7GTCHmWPGiG+P/pH99tadxZJRmR/KVZFoRPhvxfvlcNHXaXCWMD
        I1HIBMRGt59FotyiLz4XOp8=
X-Google-Smtp-Source: AIpwx4/thLNzhM1hwiQAaF8gFkV8bq0ctdQZIDlQhOAsyh8peZBDyeWJZynDEbKcEQyvKh1aTdg0SA==
X-Received: by 10.223.184.56 with SMTP id h53mr10179769wrf.87.1522433183967;
        Fri, 30 Mar 2018 11:06:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 134sm7574017wmm.42.2018.03.30.11.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 11:06:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] builtin/config: introduce `--default`
References: <20180324005556.8145-1-me@ttaylorr.com>
        <20180329011634.68582-1-me@ttaylorr.com>
        <20180329011634.68582-2-me@ttaylorr.com>
Date:   Fri, 30 Mar 2018 11:06:22 -0700
In-Reply-To: <20180329011634.68582-2-me@ttaylorr.com> (Taylor Blau's message
        of "Wed, 28 Mar 2018 18:16:32 -0700")
Message-ID: <xmqqy3i930bl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> For some use cases, callers of the `git-config(1)` builtin would like to
> fallback to default values when the slot asked for does not exist. In
> addition, users would like to use existing type specifiers to ensure
> that values are parsed correctly when they do exist in the
> configuration.
> ...
> +--default value::
> +  When using `--get`, and the requested slot is not found, behave as if value
> +  were the value assigned to the that slot.

For "diff.<slot>.color", the above is OK, but in general,
configuration variables are not called "slot".  s/slot/variable/.
