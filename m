Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD1D1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933008AbeCBUm1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 15:42:27 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44226 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeCBUm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 15:42:26 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so11340751wrc.11
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 12:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wis/d9SmO5uM2UCNcY8bvphvEp2cpnSRkkrTGF//dnE=;
        b=LBg7DKt+7U4oQp/bnsmZvtRgkzQlXposXzSb8XTwFrgfGSaN6v+u0Fs4ed8ixLn/1t
         u/nGKHdCdxjsT3KYkAQ558SgmfWY1omu5bbQ894nyM3Tc2Ag9PdxsfWIqZ12rA1vyKk9
         yVTht2tKRxNhA46IPR31bV5eGQdmbDmd6wScNqQxlSy/0ramVJSPbCUbmKrNMFmhFtT1
         FrN65jMlXHmD9dItIVYAJrx+vU7qnf/4J/lc46ZpJALlEV9wB/5GIthnkyVy5J0704Rq
         uMste7Q7wQqIHWeZkxikew68fBi0OLEEO7z6t4KfCcMw21Y6MRBAXWh0eH/Kx6p52QLG
         prbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wis/d9SmO5uM2UCNcY8bvphvEp2cpnSRkkrTGF//dnE=;
        b=CZAlkj1EQGNEO6uJdSDrrthg9TIADq3SXgFJO3Sn0X+U1uH2paB+c8OhgF1kSarDMq
         3LgB3DFecPTjSJOKVCbhPfqIg4jIp3D0v8skRjZMhQ+68MpMdvuK3CUnCYCsZfLGtrjL
         qqiOfygByWDF61eT6/sRXDh75cd65INJu22T/9gosb+X0LjaC4V9TJXmUyRTt5O0UKEg
         Sr67gYEeZqq0l5NQft9JPqvkbCcmZMcFGgM8O0KC3Se5i0AJOyJ1tvBUgtaVB5Auyiz6
         GUqOk0CUm3nooNM+ruDWxKWg9quQ8IrgPvHYfd4Pe90MaJdchj0z9hw5UjfGVVkAX7MU
         rurA==
X-Gm-Message-State: APf1xPDeolW4ABX+fK2A7TZAtzRBFwIH4HAggoZ0gioUYykMjWSnJCQe
        DoQcTUjMyDFAv3d5FVcWVyo=
X-Google-Smtp-Source: AG47ELsbnib1BSCMK3XBfzGspUoRlLimzwxL4UWUgd4sjnb1HSSGUDs6VRNzh+x9LqIvqgFNvn+54Q==
X-Received: by 10.223.184.26 with SMTP id h26mr6448540wrf.65.1520023344678;
        Fri, 02 Mar 2018 12:42:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f127sm1166904wmg.46.2018.03.02.12.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 12:42:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 12/35] serve: introduce git-serve
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-13-bmwill@google.com>
Date:   Fri, 02 Mar 2018 12:42:23 -0800
In-Reply-To: <20180228232252.102167-13-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:29 -0800")
Message-ID: <xmqq4llyciq8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> + Capabilities
> +~~~~~~~~~~~~~~
> +
> +There are two different types of capabilities: normal capabilities,
> +which can be used to to convey information or alter the behavior of a
> +request, and commands, which are the core actions that a client wants to
> +perform (fetch, push, etc).
> +
> +All commands must only last a single round and be stateless from the
> +perspective of the server side.  All state MUST be retained and managed
> +by the client process.  This permits simple round-robin load-balancing
> +on the server side, without needing to worry about state management.
> +
> +Clients MUST NOT require state management on the server side in order to
> +function correctly.

This somehow feels a bit too HTTP centric worldview that potentially
may penalize those who do not mind stateful services.

> + agent
> +-------
> +
> +The server can advertise the `agent` capability with a value `X` (in the
> +form `agent=X`) to notify the client that the server is running version
> +`X`.  The client may optionally send its own agent string by including
> +the `agent` capability with a value `Y` (in the form `agent=Y`) in its
> +request to the server (but it MUST NOT do so if the server did not
> +advertise the agent capability).

Are there different degrees of permissiveness between "The server
CAN" and "The client MAY" above, or is the above paragraph merely
being fuzzy?

I notice that, with the above "MUST NOT", it is impossible for a
server to collect voluntary census information from client without
revealing its own "version".  Because in principle it is not
sensible to allow one side to send random capabilities without first
making sure that the other side understands them, unsolicited
"agent" from the client over a channel where the server did not say
it would accept one is quite fine, and the server can always say
something silly like "agent=undisclosed" to allow the clients to
volunteer their own version, but the definition of this capability
smells like conflating two unrelated things (i.e. advertising your
own version vs permission to announce yourself).

