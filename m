Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B0320A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 08:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeLLInw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 03:43:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLInv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 03:43:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so16791190wrs.3
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 00:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xq7cvN+AKgRqDtyD8/+x1fVD/llAFTg/vU/FUBCtL1M=;
        b=J9l0Bfg4knTJcldDgMAciHYOq3cA/Vcxnp35TCMDZZYOvXVx99Ui6yNEMbMwvDCP+i
         ioRO/nKsONt0b4krPYRY+LKw2xBLBH8m/j9Eh/3EDWEIs5bmQOxxiOQPTDPQyqQXZHwx
         DApVZDqSVLZgk+yCsP5PXS/ODqWucQxrx9O45SWdYTM0Bh7DlYH37BtK3K5WaGRKtS0u
         aBYTJTyO8VkLxN4x27MXljEj6ukcT6omnDXnQEgTn7QGwHWanMHJP+qOWK1b3mkgF+Ko
         um9YeY3x0zs20DsuvW9GGZdJ3ZIfkkQ3/yDTAnPo/grh/Uxhv7v+5odohzRBoz1sAEn+
         x0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xq7cvN+AKgRqDtyD8/+x1fVD/llAFTg/vU/FUBCtL1M=;
        b=YcSzQ8fgcU1OcccUM5IVCu7/68n4inl8SPlCgvK1b1tMqbW4izsPq25yaLbuqcZ7oo
         gEct3vjhtixBhYV97GFoqY/lSGALH1RInLpFtdlaOEtLYPQn6kPQGBF25KotwH7yyNqa
         aUOuIUMMd+z47VBLBtp6crxIPnkHXHs41Q8x3N9pQO9RNW3GLFno9Wa9+aJKkfhR7TTF
         km4rYMpTbMMp6IRpcet9POyXHEWoZGVLgsmV8VaymovTtNnhq0xbBc3S/CiEvcHX1uqB
         sDtyYDwBUaGmb5QZkQCvU4hJka5SU0zElLmIT4g8/7BkzdkISldU+rK67jrCQRJxfCTJ
         Vw6Q==
X-Gm-Message-State: AA+aEWbJ1hVPkKdK/tKgeQzGP+rNVEdYS8BVP1fVQ/ATRjgukJuXscC9
        rJJZEDPWnqQuLNAqnRTgeCI=
X-Google-Smtp-Source: AFSGD/XtrImj4/8CX2iHDFePJ1kUsMdAnPlc8js6Zsp3quBPFkcM7UUXt4u1wdb3lKEdSKzK08oNmQ==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr17502955wra.100.1544604229553;
        Wed, 12 Dec 2018 00:43:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t18sm1523845wmt.35.2018.12.12.00.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 00:43:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com
Subject: Re: [PATCH v3 0/4] Unify pkt-line error handling and refactor smart-http
References: <20181116084427.GA31493@sigill.intra.peff.net>
        <cover.1544572142.git.steadmon@google.com>
Date:   Wed, 12 Dec 2018 17:43:48 +0900
In-Reply-To: <cover.1544572142.git.steadmon@google.com> (Josh Steadmon's
        message of "Tue, 11 Dec 2018 16:25:14 -0800")
Message-ID: <xmqqsgz3i18b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> This is a reroll of js/smart-http-detect-remote-error that also includes
> a fixed version of ms/proto-err-packet-anywhere [1].

Yay.  Thanks for reducing a topic I have to worry about by 1 ;-).

> The first patch clarifies the use of ERR messages in the pkt-line
> protocol and unifies error handling in pkt-line.c
>
> The second patch refactors smart-http discovery in remote-curl.c. Among
> other improvements, it makes more use of the pkt-line functions, which
> allows us to catch remote errors that were previously ignored.
>
> The third patch makes the version check in remote-curl more strict.
>
> The final patch adds a test to verify that the fix in patch #2 does
> actually catch remote HTTP errors.

Thanks.  All look sensible.  Will queue.

>
> [1]: https://public-inbox.org/git/20181127045301.103807-1-masayasuzuki@google.com/
>
> Jeff King (2):
>   remote-curl: refactor smart-http discovery
>   remote-curl: tighten "version 2" check for smart-http
>
> Josh Steadmon (1):
>   lib-httpd, t5551: check server-side HTTP errors
>
> Masaya Suzuki (1):
>   pack-protocol.txt: accept error packets in any context
>
>  Documentation/technical/pack-protocol.txt | 20 ++---
>  builtin/archive.c                         |  2 -
>  connect.c                                 |  3 -
>  fetch-pack.c                              |  2 -
>  pkt-line.c                                |  4 +
>  remote-curl.c                             | 93 ++++++++++++++---------
>  t/lib-httpd.sh                            |  1 +
>  t/lib-httpd/apache.conf                   |  4 +
>  t/lib-httpd/error-smart-http.sh           |  3 +
>  t/t5551-http-fetch-smart.sh               |  5 ++
>  t/t5703-upload-pack-ref-in-want.sh        |  4 +-
>  11 files changed, 89 insertions(+), 52 deletions(-)
>  create mode 100644 t/lib-httpd/error-smart-http.sh
