Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861721F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeCORPQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:15:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34267 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbeCORPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:15:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id a20so24049775wmd.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0+e26t2/uzwcaHbOU0F7qcZFXg04OwPxtwhbnc0pACE=;
        b=NPbDl0vK2UwTRtBfHDE1bUsU6Y8tlu+mmW+IFuKQLL80C2zhNFd3CeGFeeg0szRDuH
         Cv4XXntlSC7SMOyC3PVbbdPTdCIg4KDEXkLs4byMgLrghOBAr4b2kIQ0bkRtWq95zPVp
         doUpVrXoVEeu8vXCx6cpDO+IsvAVLAclhR8kUewxbma3fKrwGYBLlxGSoi/aSJw1Nbfx
         eRbNgyQwdSW8d3MNsYRKyHpsem8fHami22alK+6T0LtgDF7EF5nvyIN4IxmGEL05Gfti
         Rl4EgyKPHaOz/Ts6lJB6nlSjCxGP3Ixc+Tc1rW93hxpVIO1JOE7du9u7tmHlrYWROr88
         qlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0+e26t2/uzwcaHbOU0F7qcZFXg04OwPxtwhbnc0pACE=;
        b=CYn0LeO7WuRZjdvwESLgcA67VKorDAILiBKcXyU8QfH/wjtWVXadVEL3E/OrDqYPDU
         TZAcb5uiEFBeKBbiK35gnq8pSPUpzkAA7aFhs3LxcZxIaeZTRSPEjGggL8zp5WrQvbNd
         0ZHCm0Jethm/I6LooLlERxFm7z72Qmx48TQN535T2eqTE1pFaiEnxMnHiXwVs6agh2ti
         3QyPy9/+NgAfp9kUtJQA3LJk4UanU74fLUWkkZ7KMJgRSGkZDD9nSWrB3nGfuOWzujI4
         KqnUhVe47fhOFH5R/7Ig9O0UeVsTACbAi0DcKmKBrPi9h/h34Ppoj9y5UsL+MX/w6Nt3
         ey6A==
X-Gm-Message-State: AElRT7FPXQ5/hE6OxUsE5rV3RxeMIhNXHSK3yCk82PLwzL00LNJwK7Mz
        SZF/TdX2AYwcp+cPBeyms0bINjju2zE=
X-Google-Smtp-Source: AG47ELsuw5LlJs9DYneP3NP/lxLgjXoCeboRksMbeQXyjZ2DsKejKOLXvmTHU81wXporeKYWIvjHVQ==
X-Received: by 10.28.137.14 with SMTP id l14mr5134235wmd.137.1521134113830;
        Thu, 15 Mar 2018 10:15:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r136sm3478497wmf.18.2018.03.15.10.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:15:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] fetch-pack: do not check links for partial fetch
References: <cover.1521052825.git.jonathantanmy@google.com>
        <cover.1521052825.git.jonathantanmy@google.com>
        <c2f59866a1b1dc5f11713e1922eac2521ef98b07.1521052825.git.jonathantanmy@google.com>
        <xmqqwoyexqy4.fsf@gitster-ct.c.googlers.com>
        <20180314152429.df14adfb49b028e2e2a9001a@google.com>
Date:   Thu, 15 Mar 2018 10:15:12 -0700
In-Reply-To: <20180314152429.df14adfb49b028e2e2a9001a@google.com> (Jonathan
        Tan's message of "Wed, 14 Mar 2018 15:24:29 -0700")
Message-ID: <xmqqo9jp5kgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Our only definition (currently) for the "partial" fetch boundary is
> whether an object in a promisor packfile (a packfile obtained from the
> promisor remote) references it, so I think that checking for crossing a
> "partial" fetch boundary does not add anything.

Ah, that's a perfect answer. When we find a link that leads to a
missing object in a pack after receiving it from a remote repository
that gives us promises, the missing object must be available from
the remote repository by definition.  Makes perfect sense ;-)

Thanks.
