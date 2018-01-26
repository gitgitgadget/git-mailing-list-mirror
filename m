Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45B51F404
	for <e@80x24.org>; Fri, 26 Jan 2018 22:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeAZWUQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 17:20:16 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:40118 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeAZWUP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 17:20:15 -0500
Received: by mail-yw0-f171.google.com with SMTP id j128so734949ywg.7
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 14:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N47fhsaQAQUnPJGOcUWP45QMHdGBo3YndVuNJuMrnoA=;
        b=kzgPBuPwwt4kx08tcUgcm3sNBTkovY8mVXBbc3SEMc6kwG0myVChj1B6FDeSppDvAd
         +mxJsdutSnKbTc2vt4KMNmhrVfXNyvOpX0NRbDA6s2lgkQd/O8VLrlvMXmNskjSUKhmo
         eMa+2OoTtQVKgFkhzTOHhlwo08evwmGGOxshTdFVfSBM4rZNBNLB7w4aLMZw4QK61unu
         b6493wFd8ENkOWg9ojKZ8CZOsk6GYcecVaPtUn0zW8sQFkGjPDXHD+XCy39i3DxuLrms
         bECeWlZ5/G2zxlj1NKCiG8jGtc5qLyXEIDfF+dQc71T6SPhCN4kajqotdzU3ag3Hi+lS
         jV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N47fhsaQAQUnPJGOcUWP45QMHdGBo3YndVuNJuMrnoA=;
        b=KZA4BwJ1qhAq5k5VTUL2FrqM+KrwjL89rarcV2QCQPQb8ihUijV3bB8k94YTnDYeMZ
         kH1/z/4n7gQZEYPOvYhD6/7xydMLua1SXViPKgUkrxElABFdx4JW/l2LUzl9bkZwk5gh
         jilint1NU5xm8Rez93baaeN4gQt7QyWH/1jNpLl5fZPg+45tamGXczSRc2eLxdCzfKdX
         P0mA78JedLAJat6TjpRGSXS8Okts5U9IES/1ziPtIamPEfHkTBPQ+8Ov7hNf7nQjYF1/
         P8WuMy4JQAkOl/a4ZKkHDggBTjtWscvQzz8762R92aXCqA03aWKYEMucRhgksgafmCOi
         XbaA==
X-Gm-Message-State: AKwxyten85NfAhnQ4nNSLvYkqoFUucvJ1t85FaXM3bwhTrDlPm5MSYTb
        OTIsSL+CRRLS2LBNzgByhfkkvC/S5a2oKj4fRdKFWA==
X-Google-Smtp-Source: AH8x225YN7zArgw1/Y81JNOuAWTfdEiBWazY6CneeSV8wgvGKgePOdIJbMkm2s71+GC1obGLZ0vLfLTDzAJGIL0grFI=
X-Received: by 10.13.220.3 with SMTP id f3mr12190898ywe.288.1517005214133;
 Fri, 26 Jan 2018 14:20:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 26 Jan 2018 14:20:12 -0800 (PST)
In-Reply-To: <20180125235838.138135-14-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-14-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Jan 2018 14:20:12 -0800
Message-ID: <CAGZ79kb14ciUoyHLAxmh0jGwwPYFVjGayrn9R2f+4+88A8=xsA@mail.gmail.com>
Subject: Re: [PATCH v2 13/27] ls-refs: introduce ls-refs server command
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:

> +ls-refs takes in the following parameters wrapped in packet-lines:
> +
> +    symrefs
> +       In addition to the object pointed by it, show the underlying ref
> +       pointed by it when showing a symbolic ref.
> +    peel
> +       Show peeled tags.

Would it make sense to default these two to on, and rather have
optional no-symrefs and no-peel ?

That would save bandwidth in the default case, I would think.

> +       cat >expect <<-EOF &&
> +       $(git rev-parse HEAD) HEAD
> +       $(git rev-parse refs/heads/dev) refs/heads/dev
> +       $(git rev-parse refs/heads/master) refs/heads/master
> +       $(git rev-parse refs/heads/release) refs/heads/release
> +       $(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
> +       $(git rev-parse refs/tags/one) refs/tags/one
> +       $(git rev-parse refs/tags/two) refs/tags/two

Invoking rev-parse quite a few times? I think the test suite is a
trade off between readability ("what we expect the test to do and test")
and speed (specifically on Windows forking is expensive);

I tried to come up with a more concise way to create this expectation
using git-rev-parse, but did not find a good way to do so.

However maybe

  git for-each-ref --format='%(*objectname) %(*refname)' >expect

might help in reproducing the expected message? The downside
of this would be to have to closely guard which refs are there though.
I guess the '--pattern' could help there as it may be the same pattern
as the input to the ls-refs. This might be too abstract for a test though.

I dunno.

Stefan
