Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97641F453
	for <e@80x24.org>; Tue,  5 Feb 2019 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBESFC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 13:05:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52928 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfBESFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 13:05:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4655217wml.2
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 10:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/luJxdk1p3Dmd9yt6uYh0ZJkFp9UXWeWgksbMsp5KXY=;
        b=F7H0hBnX3jUWA7HP8AVnnFlExGoz5aDi/92XPwnJICsXZwVdB1kex9gN6sD1JKaZIs
         /je30fPTfkPco7zIOAoT01ZyvBTl3p6FrxsECzRsvVZUpsdZD00AR5Zn/e7quN/AY7WA
         Sz55EXLYPO5gjQpknRxmkjvB/gyanijxasx+ONZflSZHXQZFcyNb2GDMgMX8I22dSBNx
         xPMkKZ0IaDC1nBLE9StNK3dTyH0/qbSDDVZ2QBygTjRAI4DLiPuVcxklzjLpcp6oiSTB
         0/8TQA4X+vMHmrWuJ8jdwTApX1IFrGWHl3mb4qdXbu4Npa2o97qaerZ5VVIKmjC+YHRV
         vCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/luJxdk1p3Dmd9yt6uYh0ZJkFp9UXWeWgksbMsp5KXY=;
        b=WyHIZoCG30iBhe9EbJq7l1ZRbcGJvMHXqSw5/Lge26BUN9ZzKRsZUImBqmYVP5RgaC
         ytfgWzjiQKDr70IwYdwLckRSupAHa8um/LGpsebOozhXZnl08PO3VsAp5U2gmHbZXsdX
         8jXIgKS1u8srRU+O0wCA0giHFQAQYxi1QTSW6EPdfXjEosn9vFmKgRh2j4leudeDKrlN
         sTocLYkKTKMzniKu09aUPeQejbUaMKto34aimFEulWJq4ExjKS35LA7PhFvOfn6u0v31
         yJ4qBcT/Ij7hjpjFjhJDnfyTwDLjHRodNKcgyqu3KBR5jN7qWfSwDW83vyxZDJZ3R26n
         EXFA==
X-Gm-Message-State: AHQUAuaD06blR3uQaz6o8MNe1+cyt3YzOB1fOMnsc5iH83FC4M4ZUroA
        s5fubC0klPp9TjiIJIK3VK4=
X-Google-Smtp-Source: AHgI3Ia8rYp97xYfHz3aQWen+iMD38pUpPONlQQ3HRfKDu+NTYCvVuWAf0wQSI/IovP+5lJWF2X0OQ==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr4948085wme.101.1549389900618;
        Tue, 05 Feb 2019 10:05:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v22sm4727763wml.37.2019.02.05.10.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:04:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
References: <20190126221811.20241-1-newren@gmail.com>
        <20190204200754.16413-1-newren@gmail.com>
        <nycvar.QRO.7.76.6.1902051045460.41@tvgsbejvaqbjf.bet>
        <CABPp-BGQ62Mj1jym8-xu5XKN6mJ65yq-QUqXjR-xx=AWFZgNbw@mail.gmail.com>
Date:   Tue, 05 Feb 2019 10:04:59 -0800
In-Reply-To: <CABPp-BGQ62Mj1jym8-xu5XKN6mJ65yq-QUqXjR-xx=AWFZgNbw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 5 Feb 2019 07:54:38 -0800")
Message-ID: <xmqqr2cmru0k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I don't want to get rid of them; the initial reviews of my original
> patch thought the format was ambiguous and would mishandle files with
> tabs in them.  But yeah, I can definitely add a few testcases without
> FUNNYNAMES.  Sorry for the headache; I'll fix this up.

Thanks, both.  I was about to squash the fix from Dscho in, but I
agree that it is a much better idea to cover the basics in separate
tests that would run without FUNNYNAMES.  Will hold and wait for
your updates.

Thanks.
