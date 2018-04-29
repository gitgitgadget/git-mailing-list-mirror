Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CAB1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754486AbeD2WSl (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:18:41 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35719 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754456AbeD2WSi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:18:38 -0400
Received: by mail-wm0-f45.google.com with SMTP id o78so11423594wmg.0
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JERZk9e96JcHEun5/xR7CL+R+Gf9wofBCqtXpqzY01M=;
        b=gsbHZrqgJFiZ9UHx6Uqw2NuHvSaL7nXmqKhum82Xs8+h+dD/4sj1v3xnu7BOIONSVf
         b2Su0oEHLa91uBwW46Fo12TJLmj6TOMIfV9pLhmGyb8xTNBs7cvtRkfLWtBN9rkX0qwN
         wfMmA+JytLq8ZXRhaZ8LmfRf6gIzROg1xZ8pCbMPwwwFZTaTiOgNu9PPwH/Uu7e8DVgF
         s7CIhcAvxiC3xc58rEF61BMw3OYSv1VfXNtRlrrSypICJGYAE93bm0m7iv4vSya6AnKu
         21G8r9izGvytxilu5bRi1tXjS9voGJwKLOWT+Vc3yPkCNpBknB9n3VQx/URJ2/Z6FLUU
         9tdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=JERZk9e96JcHEun5/xR7CL+R+Gf9wofBCqtXpqzY01M=;
        b=DxK+/aSvb/EpdzjFR7z7HOOgmJmj62f+cUjgtSzPXYqrGkIUZ+YSa6xr8jHjGoK46D
         jCjI/YxakNMWaJcGxa7k+AOXMoQXa8WLERFgyl9OTwo/VioglvPlVrxYYadgf8GYKpk2
         bjC+acNppFsfkijeeXAhnM4hfjeVy9j+vfjbSWjU5hiJsSJaOFTJntzT5og16HdboU5U
         E9RoXqbAxEFC6SDATE0OCXikahEmRbOJsPs77l9uZivgAKzWzi2SIhDgGTT2+SVqzibU
         6voSwaLBgXzmia9IWe0qPpGp6IieYA2zZGbCbDp348emOSKa+sulxr2KHrwfSN+40hVJ
         azbw==
X-Gm-Message-State: ALQs6tCoEHkfZjDEezj17dq4TSeBTAFyn2i0//wGPf5u1BUUxjTYMzHl
        jd/hJuAh4vKg2WyqUbF01lCFGuSu
X-Google-Smtp-Source: AB8JxZp9IMBcsI/BtTlIeiojHl4KFtEto5DPPwoJ1kTuf7oUb5RjC/pWrCsiRX3vjyRUUDSuMqRDhw==
X-Received: by 10.28.32.132 with SMTP id g126mr6837619wmg.52.1525040317733;
        Sun, 29 Apr 2018 15:18:37 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id 76sm7642599wmj.0.2018.04.29.15.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 15:18:36 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/10] commit-graph: always load commit-graph information
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-6-dstolee@microsoft.com>
Date:   Mon, 30 Apr 2018 00:18:33 +0200
In-Reply-To: <20180425143735.240183-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:58 +0000")
Message-ID: <86y3h5hd1i.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Forgot about one thing]

Derrick Stolee <dstolee@microsoft.com> writes:

> Create new load_commit_graph_info() method to fill in the information
> for a commit that exists only in the commit-graph file.

The above sentence is a bit hard to parse because of ambiguity: is it
"the information" that exists only in the commit-graph file, or "a
commit" that exists only in the commit-graph file?

>                                                          Call it from
> parse_commit_buffer() after loading the other commit information from
> the given buffer. Only fill this information when specified by the
> 'check_graph' parameter.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

--=20
Jakub Nar=C4=99bski
