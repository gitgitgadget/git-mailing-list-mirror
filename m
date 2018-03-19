Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263BD1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967723AbeCSRyg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:54:36 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36908 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965422AbeCSRw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:52:56 -0400
Received: by mail-wr0-f178.google.com with SMTP id z12so19566832wrg.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zNm6+eNm39WhLXmvLwdzPwbM7cQfOtxWp2zURAu0iLk=;
        b=PtTzBYWIaT9KRqdG+OQy5riB3kO3/CUE/hPSrh6rNdxQVYPmpcPmkpQLwGjLNYSq+E
         hI596y19NfAx0+6cfzFmA4Pd3aQDG+9VF3JSjnv+FRDdJ+AD/BeouEagRNCTOj74tnqS
         xAEok/E+masC46i2vdrED3SoFimQ5pZ5EIXF/jhN3Xm+lduUj4wARsIPGYsZCrY3BOLn
         2ZKc7AJnRKsuH0jlm13k8marYSj5yz6lNDrZ3px1j6S8BeBeoNN3h6hn2LN71D7Jw5jH
         V+oAF1JeB6lfxg8MQXLLOLR+SSkG+Gc3FUf1VzWbWXZVDaMpB+Ee0Uoib3sXkb8kF9Tu
         V36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zNm6+eNm39WhLXmvLwdzPwbM7cQfOtxWp2zURAu0iLk=;
        b=Nj1KkjrlrEy2js4oWdN+uUTzPlUNVe1mG0wwHflHB2ddq9/X4GLysLLWFYpvc0xSYV
         +q5mxjp/ljoNtaSBQ+9p7JAMHzyQKdIlVhFGVXH15RYm3V3t2Qq12zkMKvBTFq5J2q2j
         1KDj4XRhAnUl0BR2qFbulmtET9VXIr7RWhJGwOaXCD92NaR6XEgQ6fyo925TuTOOxR1M
         dVyaxpmBU2IOLythUexjq6+HDZZSV5Zy4h0mLxDWNM4BGhEXhRO94dTmq6h+0ErPPnAD
         XNmfTnIzFUNLvlAp5+GTpzlsWtEPhzt00RJO9PMk4cJZB02A5j6mwTuPHZzZKiJ1JSY4
         hNdA==
X-Gm-Message-State: AElRT7G+vCQYtAkwCwFOV5EoXmORTXSktANwHJYPCLJjR6KhNwrZ5jye
        otakwhvvTK1mzjl+A02h6vE=
X-Google-Smtp-Source: AG47ELvdOKIgfXHZwtq7/ps6x40a19shBCyh/Ry6qeRwqL41+8kUlClTCSQyrhlyxjKwW9oPQ2a0SA==
X-Received: by 10.223.160.157 with SMTP id m29mr10161579wrm.119.1521481974193;
        Mon, 19 Mar 2018 10:52:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c34sm687683wrc.60.2018.03.19.10.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 10:52:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mingw: abort on invalid strftime formats
References: <66189602d022dd1911b5f5d98594506b80bb81ff.1521478106.git.johannes.schindelin@gmx.de>
Date:   Mon, 19 Mar 2018 10:52:52 -0700
In-Reply-To: <66189602d022dd1911b5f5d98594506b80bb81ff.1521478106.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 19 Mar 2018 17:49:22 +0100
        (STD)")
Message-ID: <xmqqy3iouf4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, strftime() does not silently ignore invalid formats, but
> warns about them and then returns 0 and sets errno to EINVAL.
>
> Unfortunately, Git does not expect such a behavior, as it disagrees
> with strftime()'s semantics on Linux. As a consequence, Git
> misinterprets the return value 0 as "I need more space" and grows the
> buffer. As the larger buffer does not fix the format, the buffer grows
> and grows and grows until we are out of memory and abort.

Yuck, it is bad that the callers assume 0 is always "need more
space", as "If a conversion specification does not correspond to any
of the above, the behavior is undefined." is what we get from POSIX.

> So let's just bite the bullet and override strftime() for MINGW and
> abort on an invalid format string. While this does not provide the
> best user experience, it is the best we can do.

As long as we allow arbitrary end-user input passed to strftime(),
this is probably a step in the right direction.  

As to the future direction, I however wonder if we can return an
error from here and make the caller cooperate a bit more.  Of
course, implementation of strftime() that silently ignore invalid
formats would not be able to return correct errors like an updated
mingw_strftime() that does not die but communicates error to its
caller would, though.

My "git grep" is hitting only one caller of strftime(), which is
strbuf_addftime(), which already does some magic to the format
string, so such a future enhancement may not be _so_ bad.

Will apply, thanks.  I do not think there is no reason to cook this
in 'next', and would assume this can instead go directly to 'master'
to be part of v2.17-rc1 and onward, right?
