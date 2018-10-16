Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62CA1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 04:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJPLtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 07:49:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36497 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPLtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 07:49:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so21585326wmf.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 21:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6GWTSIclRelUK/BePPAuGID5J3ez+UjX5lOFtvunwQI=;
        b=mj3VncVjbFIU5YdQjDLsZ5LrMUGG4U9thZoaSvgeoRu933zhnqnZW4sILN70cEtsfK
         TkODDTraIRa8gf2ZaTG+704bsxOC2rEqmYPSIfGM15p8rAgeXn+VtZyFhVV3pCLXoYQm
         ffITvVbMozVBc8HDR5U5upOnJD+SbPRf7RgN7hNqDM68snXSkhvoJHPfAXZ8v+5fcmJT
         H2h91kC3mkOGaQqUMp/xATnEVFOyBPyOmXRq2N++QAfilB0qhQZAKtTCmT3moEmgzB6a
         zTcdPTgC5Fkxtqz/c3H82DIUkrafsHm8PauZDb9viHhqvq6ZEwNvPw1tf9cVqVnR4OXl
         ZqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6GWTSIclRelUK/BePPAuGID5J3ez+UjX5lOFtvunwQI=;
        b=GM1DQGG0/dF279JQl+V4PphMdA4DH1jaqB15jsbj2r70TuFGlrHkpvWgukPdbus1ak
         lLfwnC2oLQdj+X8uTT/eIcuWl/Eh+Bh+Mf5PNJ/raKv+6EyIxcKpY5hP7IjbWrFyg22K
         maUZGABKBnwkxfzQUCtS7jf6KNUfo5yC6wPuKSinjLvyvEzHiWYw9v9CXZ5JKkYZs/xS
         IzXXuTBtwB4E3pvNydXWflXaG80zhVLeJFm8fTwAbfEEpdRzuGuQA6CE4dnU6nfaXHCM
         6KN/r40tINKwxdjbnwwc8MfrWj289P5+VYWN1iu1rOG3ZApb0rSuDqI5uSQYyqgwgEz8
         h9WQ==
X-Gm-Message-State: ABuFfogncEVOsWvYRtTg0XJDIjt5bz5eObiUpy/Gn4t+/Y4sd4IznNqt
        4igMITiaDyq3EuviGzqrx3U=
X-Google-Smtp-Source: ACcGV63YOJdJs9XtvqiCxKfZ9ecupjnKWqsvU6QnpBuH1XVZ1vKsEHgoSgZy+MLe1e+fcXCrv/f9AA==
X-Received: by 2002:a1c:1dc8:: with SMTP id d191-v6mr14718872wmd.27.1539662470533;
        Mon, 15 Oct 2018 21:01:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e14-v6sm11430277wrs.69.2018.10.15.21.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 21:01:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/13] Base SHA-256 implementation
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
Date:   Tue, 16 Oct 2018 13:01:07 +0900
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 15 Oct 2018 02:18:47 +0000")
Message-ID: <xmqq7eii35h8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  t/t0014-hash.sh                       |  54 ++++++++
>  create mode 100755 t/t0014-hash.sh

If I am not mistaken, 0014 is already used by another topic in
flight, and will cause test-lint failure on 'pu'.

