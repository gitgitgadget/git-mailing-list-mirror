Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD3C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeGQQ6x (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 12:58:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51307 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeGQQ6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 12:58:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so2147028wmc.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aKIC4xDhI7Or4xDidh3aW5iokVoRcyCArC6va926KwU=;
        b=I01IRxWpPuIu6wuTy51eEeL7Ur2t0tCiRs0/8VY0UBrkqRixmVGfZCZlu5xN60uP38
         5gNUxjDQpoheqSBClMdAHBmTvLJ8OBl0ZgmsD3kwG/QfpxmYjrICCl4DclpZLlpTR9Ud
         KJx+xgInXvDNCQ0clOyNRep+OPhIWDGaZuYXqehOJQsq+XY6lefg7wmpG7O484f31d7h
         emEeSkOgkQ+67Hk/Rdpvx3FYIG/hp6Dm4nNqjV0fTAcYCIz2vlI9QQ23TInfMrzddWYM
         s4vlloyCjSGf/iiJlSo5KNaXO4tJj1PSCdCqnpVsCCV5MteQKQgC0msS+HnFn568Ph60
         RX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aKIC4xDhI7Or4xDidh3aW5iokVoRcyCArC6va926KwU=;
        b=MRA8sAxj6WV7NGrDkhVP50kc/KsOPjurODqk2bjwb5EK/Bgj0ug8/gtHr4LSuLE0Rj
         sox2QIRNuwkI9qwISseO8ioizpEZ78YD5lE1ius8gF74oyurrqeCyYp3szq3eRl3A308
         pzwb6P/7QxnxevsvLeFouhrjtjWbKjOai0DzNQGf5iNlOxln6LtcQFBsYY9dhLNRS4eW
         S8H6B8gkCxEGOkHCBZFtvGw8JlR91yCvlZjCCDWA4OkIXpHw/w5FeJO+lUKzOkN9pNRy
         eJ6ee6G5nv1lI7PDkmNCyc25A/0kf9edbdl40C1/pUaQQfwI0JQO6HNvoZzdAJzlxAKN
         fMbQ==
X-Gm-Message-State: AOUpUlFAM64bod1efbRRBjooRBt2j10DL/zF7Im7APM1PQuCdOQGpOvG
        n6X+wH7JftqPLyohPRAT5Lw=
X-Google-Smtp-Source: AAOMgpdV4SPEI/A6wEQGlmlBT29Wm/kQIqYG/mLXaA+5zME5JVvIuWBDINhXV1Ribp7KkABOu3AvVA==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr1866562wmd.36.1531844725533;
        Tue, 17 Jul 2018 09:25:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c5-v6sm1990665wrh.36.2018.07.17.09.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 09:25:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
References: <pull.9.git.gitgitgadget@gmail.com>
        <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
        <20180713203140.GB17670@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
        <20180716173636.GA18636@sigill.intra.peff.net>
Date:   Tue, 17 Jul 2018 09:25:24 -0700
In-Reply-To: <20180716173636.GA18636@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 16 Jul 2018 13:36:36 -0400")
Message-ID: <xmqqh8kxrfrf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm OK with having a partial fix, or one that fixes immediate pain
> without doing a big cleanup, as long as it doesn't make anything _worse_
> in a user-visible way. And that's really my question: is pruning here
> going to bite people unexpectedly (not rhetorical -- I really don't
> know)?

Yeah, that matches the general guideline I follow when reviewing a
patch that claims to make existing things better.  And I do not
think I can explain to a third person why pruning here is a good
idea and won't cause problems, after seeing these patches and
the discussion from the sideline.

> Right, I think "git gc" is absolutely the place to do such cleanups. My
> only complaint was that having it as part of repack may be unexpected.

