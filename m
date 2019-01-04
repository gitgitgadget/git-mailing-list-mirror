Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED211F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 20:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfADUNE (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 15:13:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38517 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADUND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 15:13:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so2296651wml.3
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tfZ9YSsfFg/W2eEehsd/I+dJcHiFdoXmwv2r1DrF3I0=;
        b=SSSpLENyY4qLbkyG3clXOw5t4HhzimCcvPq1kzMOAATXaSIuAoPxn6z4X8QnPwU4JX
         nZVpxulKn6nHUauL0n2PrdkQRiUaVrLZXF0A7Qh9pDenB375/lmytrf2oHYQRQbCyQ0b
         WrNxOvnpx2+zfwgJpTwqekznezisb/zUYcbYeRzj8MycyE3BUrGu/fjoGK+mENwUc/cZ
         Vylc4NYX8U+YadmZW+zGpkGIRMJyTVGy4rrNJ1aimSKC5B0wDrmai1qSNbQZ74y2TAn3
         CHUkKEreP3brKQ6kTLSNvgOLwB8z6buFfXCN2s76mNWZAeukZH6YSEAjN6nzQvKKQLKn
         +O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tfZ9YSsfFg/W2eEehsd/I+dJcHiFdoXmwv2r1DrF3I0=;
        b=o/tNhQarnzQ37Fo8FMYt0umy5i1P9Vrq72rQ33gVKJmxGMYGHLkcQ/Lbf0g2KkIlfl
         Om5Hty8o+S+6ReCotLp4B0tKuQ6Co9lWTDY5r2vyRZfZzYO7gAOPiNwVs6BB5BEA6vRB
         cfw1OCZfShh6fcokYZ9HpInwfOvXxD2zD/GAFEHFVYoSbO/iLP2JlCfQCG0HeHjgYyLl
         c7jlGUcjjKLYJ11yzy8Kkrsw3V6LZMBcywRvaFmQUIcaylkPiPfxJRUcmvT2KHhMFUSf
         eAd1vWFKdBmAUODJIeDz6sZEng7c9AL4YYjaKZeZLQ5WzdQ7TzyPv530es7jk3XUYbuy
         zvTA==
X-Gm-Message-State: AJcUukdESpg3aTdSf41245FvIBC+tdXtzAiJmZa+h7lNakAJRNsevoAo
        TSsCzVkRMG5xCAmPijYroBk=
X-Google-Smtp-Source: ALg8bN5eahz0tn/hIujZ15sv3umSe/+ZH/bkRpDSV3Qpa475hXkaLqMFVYTaUP0CbPMYlGp3nV6enA==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr2310892wmb.80.1546632781581;
        Fri, 04 Jan 2019 12:13:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j14sm40277465wrv.96.2019.01.04.12.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 12:13:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] Change how HTTP response body is returned
References: <20181228014720.206443-1-masayasuzuki@google.com>
        <20181229194447.157763-1-masayasuzuki@google.com>
        <20181229194447.157763-2-masayasuzuki@google.com>
        <xmqqtviph835.fsf@gitster-ct.c.googlers.com>
        <20190104101149.GA26185@sigill.intra.peff.net>
Date:   Fri, 04 Jan 2019 12:13:00 -0800
In-Reply-To: <20190104101149.GA26185@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 4 Jan 2019 05:11:50 -0500")
Message-ID: <xmqqsgy8b2r7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The most robust thing would perhaps be:
>
>   fflush(dest->file);
>   ftruncate(fileno(dest->file), 0);
>
> which leaves the handle intact.

An added benefit of that approach is that there is no need for
the filename field in the dest structure.

Having a separate filename field could be a positive flexibility (it
could be used to open a file, store its FILE* in dest->file, while
storing the name of another file in dest->filename), but also a
negative flexibility (dest->file possibly pointing to a file
different from dest->filename is a source of confusion).  As I do
not think any current caller that wants such a flexibility, or
callers in any immediate future, it probably is an overall plus if
we do not have to add the dest->filename field.

> (I agree with the rest of your review, especially that it would be
> easier to read if this were split into separate refactor and
> change-behavior steps).
>
> -Peff
