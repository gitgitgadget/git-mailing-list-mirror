Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77971F597
	for <e@80x24.org>; Fri, 27 Jul 2018 15:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbeG0RSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:18:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37010 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbeG0RSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:18:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so5531736wrd.4
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zqbLBiIytcqeuYHwR4i6EzSewx1q5VywOJItgCr4S74=;
        b=Y6xV+mVtw1QaRMov5C57rLzMvFK0v3l8yXAmNC/w0XJczIU2kGDh7Tx9uefo7vbLWK
         K9mXLKWGKzZTGArggREuUZmKc+9478iyUXokVFukVYcejTnbbWND1WaZ1g79ptry92Df
         COfeqWvuRhUBkQ0kbBNyq8UA7g2Yk2gu93zwh8ypH8J6fiBlLTAav31PqJm7GDm6oKqw
         QpaYoC2W7Mm8u7PPEUPhw1zOTbKh1H/FnGEF87ZMXw0LwH1gdSa31y31krbLL5cZ6F1K
         W0gelijh2dd3eetV77m8GnHdJmA+BIVRECfcN6f6WLsz91fpTVUlsBfAj3tQIme9dNGQ
         t+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zqbLBiIytcqeuYHwR4i6EzSewx1q5VywOJItgCr4S74=;
        b=V/AlLuYeNM30tyHPIAIGpBQrfVq6iENnVv04j9OvfKg1apquFPmXGy8i8tf4GMMeox
         jxG8nXFE7m9tmnA37fS8kQ9gF2EFxfCWNON+xyIvTETdJ6TplYOJdOgrW4rsGXMRCHkx
         q0ObvRbWgh8RGVvLyv/e2tcM4YtC0r1j4l3126CtBG2tL1XgUi3FePtfw7PLqHQWihgI
         cD6ez9LhrKoRSL+Gfi40o/H2his4FsSi43ONMJNjXMoa+xDcsxzZUjW0mkR8RQm0d733
         5thqpLFGGy/ezKkbqsouA4I0VP+Lm342VQ+pL+cpeWwnhyiQrG0/3tn3NZCsgyFsMl/x
         yVuQ==
X-Gm-Message-State: AOUpUlGmJ9UwEo4O5b/9FAsf4RZ++P6/Ndsyz1rKH02/tspEwMTuOfSs
        l25pqMx6chq545BgZezoY/g=
X-Google-Smtp-Source: AAOMgpeuCD97KWwqztBESfjtvDi8UV46zrKhm/nQOyF+kiaYLl0AAibspRviho98M33sh1hfT6CIog==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr5692735wrb.155.1532706958409;
        Fri, 27 Jul 2018 08:55:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v5-v6sm8307730wrp.87.2018.07.27.08.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 08:55:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     peff@peff.net, git@vger.kernel.org,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH v2] name_rev: add support for --cherry-picks
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
        <20180726143930.GW1934745@devbig577.frc2.facebook.com>
        <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
        <20180726153714.GX1934745@devbig577.frc2.facebook.com>
        <xmqqr2jpq0s1.fsf@gitster-ct.c.googlers.com>
        <20180727084039.GB11932@sigill.intra.peff.net>
        <CAOS58YNjyLLDLpoDDB=oAKn3P_FLLD2WZrygBy6J+TV=E480NQ@mail.gmail.com>
Date:   Fri, 27 Jul 2018 08:55:57 -0700
In-Reply-To: <CAOS58YNjyLLDLpoDDB=oAKn3P_FLLD2WZrygBy6J+TV=E480NQ@mail.gmail.com>
        (Tejun Heo's message of "Fri, 27 Jul 2018 10:47:25 -0400")
Message-ID: <xmqq8t5wpt9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> ... After all, calling the program twice isn't all that
> difficult.

As long as we all agree on that, I think we can move forward.
Because I think this ...

>> ... But it feels like
>> "reverse-map the cherry-picks" is orthogonal to the idea of name-rev.

... is a better way of saying what I've been feeling (i.e. the
feature indeed is useful, but does it belong to "name-rev"?), and
none among three of us would mind running "name-rev" to see the
simplest way to reach the primary commit you are interested in from
tags, and another "reverse-map the cherry-picks" command (and in
"git show -s --notes=reverse-cherry-pick" may be that command) to
get the data from that orthogonal feature.

And obviously, "git log --notes=reverse-cherry-pick" would give the
information if we take that "use notes to record reverse map for
cherry-picks" route; adding support for "name-rev --cherry-pick"
would not help such a use case.
