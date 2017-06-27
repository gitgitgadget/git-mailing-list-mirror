Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B70207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 02:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdF0CvP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 22:51:15 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36145 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdF0CvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 22:51:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so9191710pfl.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 19:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=luwb5EA1dI1K6DykW0auJ6PCs0rFG8DcsgzkBp9tNKs=;
        b=WZzJm07fE1sQH3prOZgriKg0Uu5s9snru8QkH8vW2xVLSIFcFtGGiu0p8ZV52tIQs3
         +7fX1fbLb8bqjtAsaQvNi5JlLHO8K26+ShiijMuWuOFiC3opiyx/LVHEzlwRGEKszNml
         DUonyHy5vcBhnvmi/lo7TL3KwpZT8eGwwjRiV/OuFuZhn0kfX3Cpg9fzV+v3ZOxjQlKT
         UpbjGm7i8dQ1Y9MJ+x0utDWQFty9NvwVafKtCMta/SHM0rTJszG6vn84EhggjcZ8pfQA
         Ffn4LgkzgdfQH4WRu78JkWyJ0NOJ/k0WzcYWIp+8PwsNaziKhf5DGIwJDfcajE6CggH+
         qzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=luwb5EA1dI1K6DykW0auJ6PCs0rFG8DcsgzkBp9tNKs=;
        b=UEm5afgTP5NUGnaBfcSxuXBJnzvKnJ2FrRUo8ufoC+9uI25jZ21dCuQV0L80xE/GN8
         gs7PJe6pMkXk3pPgP5Zpj9Gr0M1U9pB4ROsMD0pSC9rH+90YvRBM7o2z9PIoKLdhbdBh
         nW+nXU4g0Gvg8fZCcrdWHl0ZQeunTiwHOmcAlFMrLUXMyDhXkBLljP+WEYJgmpAXEm67
         V2/h+PWzAmx//OFXhDO2/q1NrkHeH6fKEMgas2hpuXQ9XJgruMENHIHEqGC+O74z9zrW
         N/eo9GFtlNEacEGIqLteRq8U1U4EYT+LSH9sBZ7cQGafF3BbK10PwgroOuGq3+9hLOZL
         U8RA==
X-Gm-Message-State: AKS2vOy6EexF42kn7l6sw80T3cmDBz6FRqYhLsVpBCRu4JTvAzmhCJvB
        2HG0mRTwsWhtLbOhZmbaTEayGU+vejR9
X-Received: by 10.98.69.76 with SMTP id s73mr3042972pfa.94.1498531873136; Mon,
 26 Jun 2017 19:51:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 26 Jun 2017 19:51:12 -0700 (PDT)
In-Reply-To: <xmqqmv8u63aj.fsf@gitster.mtv.corp.google.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com>
 <20170625182125.6741-6-larsxschneider@gmail.com> <xmqqmv8u63aj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Jun 2017 19:51:12 -0700
Message-ID: <CAGZ79kZEff1WUmgmzWKt=K8j45tOn6xy6ik8_CUp0awRep8jSw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] convert: move multiple file filter error handling
 to separate function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2017 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Not about this patch, but viewing this with
>
>         git show -w --color-moved=zebra
>
> gives an interesting result.  The bulk of the part moved are
> re-indented, and the comment string gets zebra stripes, as if the
> line movement detection code does not realize that these came from
> the same place.
>

Thanks for the pointer, I'll include the whitespace-less comparison in tests.

Thanks,
Stefan
