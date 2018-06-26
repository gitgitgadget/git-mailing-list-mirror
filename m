Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020E41F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeFZVJJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:09:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50583 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFZVJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:09:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so3435421wmd.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EqC9ubVPV5vDsU5ppMt5J1lMbW2K7u/PCK+dr7LGbnk=;
        b=WY6GIcI6hZE66dyGWxZissAlfbaCNjejdK8SrbnWCM4ugzH/zQaKRg2qNNGpiEre52
         28HkoOh42BWhIMExdSakwU9JQ6AJaqY1kDRIu5RdSEAWq0eHqSURnzVqnf0sD5UPShh4
         FC4cd/niUPokmKnKiyVr4BHomiBEQsqHC4Oq0QSnyuUTmnQIuK7zHhk+Qf9iL8IOYvaq
         eAAQQecpIMW/ksoVKstVJJobtCXLQpO1xtBj8qDEhFwAjgbfSOUkM3dfE71Zgg24qZQb
         Qa89Aq+JcWeQkgctWsGu6TjMyBRlrF7ubOU1/anOUkEhfWdi+G2bx7cSmb/AIh829Ygm
         UdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EqC9ubVPV5vDsU5ppMt5J1lMbW2K7u/PCK+dr7LGbnk=;
        b=ANFvkPHczmyFB6hriCNybtLbEOb7M93rAmnzMjtjJ1vxtqA69lyCLY4bLWySx9rNhH
         Sh/gA+AF3ocHU5yYL3E6skxZoh9ULtdHzGI4fe0K6NOg5Cirf7LxwHaAUhvMtRgtoszM
         wMWBbdtDlS38G5s3cRfExYAOlOApf/PpPm99jFMuYIWuE4EoV4/RJZ3eFQ8VvfcMYjlN
         ghKWyTqpyiay/QC9uGI6BZms8xPE+iw5G7hgD8mmEcNFEkcLEh2k4vb42QwAfV1iwZ5P
         TG297IFOKv/CmylGHx03fDu9YSyAZw2yjkK5InwdyPebrWIU/qbwSSzxeqO1/6Gg/R2G
         3CKg==
X-Gm-Message-State: APt69E0A0oziuts1bkCYyEl6UG4l5hWR6M9NxYY/JCJhobiDvoCdZBp7
        saoc+LQYv/FHqBYO8+N/QTo=
X-Google-Smtp-Source: AAOMgpcd6tVbrMMJcqNr2XpKooxZ94Y/6BVOmZEIxXEuVXsGmdfah4NJaiDtFSAJu4cYDCU2n+1jhw==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr2863905wmh.63.1530047346677;
        Tue, 26 Jun 2018 14:09:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137-v6sm5250772wmv.28.2018.06.26.14.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:09:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com>
        <20180626073001.6555-30-sunshine@sunshineco.com>
        <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
        <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
        <20180626201708.GA2341@sigill.intra.peff.net>
Date:   Tue, 26 Jun 2018 14:09:05 -0700
In-Reply-To: <20180626201708.GA2341@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 26 Jun 2018 16:17:08 -0400")
Message-ID: <xmqqy3f1i7bi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One way this series might be worse in practice is that we tend not to
> change process state too much outside of the subshells.
> ...
> Whereas once you start collapsing subshells into the main logic chain,
> there's a very high chance that the subshell is doing a "cd", since
> that's typically the main reason for the subshell in the first place.

Exactly.  I should have mentioned this when I responded to save a
round-trip.

