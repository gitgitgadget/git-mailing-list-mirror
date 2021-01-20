Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E205C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BBF23441
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbhATULd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbhATULX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 15:11:23 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D30C061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 12:10:43 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 19so3203131qkh.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 12:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqhDACIoKR2LAQyi9YCW2vJvNOuvf7jN7aP2tBhrHuo=;
        b=jefLWhc5J273592E2H1D+c2yOwjvKkEryPOIZWKvmqjCavsPwamhr8An3+uAOuM8yb
         AWXnRENZ7DHKenrhEHehr6CHUuh1EPnhj/8oJ9yVB6RYgzQKjpXpqFnNAneyjXbg+Muq
         G2EBmqDk1CxQiqlrLXv2JOvEroEKNFDYnU1I8uloIfKn3uPacscWeLJvBruVjnNE9AeV
         Cp7pW8DP+buzWO83jPAhxCwW7tDghNFkB+CaYVNiRqDXV2N2nSubdHi/bMTqqv3qOIfD
         XQr+Rr5gdsaiNMXqPsxhKG/670uym15yDLxxfcskC+Xzs673mp95vAfkR0+pQYjLfS9r
         oCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqhDACIoKR2LAQyi9YCW2vJvNOuvf7jN7aP2tBhrHuo=;
        b=fkFtBR9j3Nb6X61o0lUlQ2zTQp05RKcSKPV04A0di3RQmlcPBCZOWh7HG8ThGG716r
         pxr6VGue2NpYbw/cKAAdqk/Zyl43g/jS6u+lBpNlLCpQ+bnRYpeyJCPDC3+lZ2dgPPDg
         YSz3Ajw7F2CLP+MEdL+9bfzE4wXUZNg78XDY1Dtoi7jAikQ3ov3KVXO9Ud+z3oRopNgA
         qsVkVu7T3wffxfxtzXquVg+jHbMi1nhEO0taCzQlgDH/GJIn5O26BvEdb9hbHRf24kPg
         KZdLARXL1ipr+A7IZfgdduxZmdY8x5L55rWl1+i1TXDkQ/0pOhrKQit32g9a0+NawRBW
         HJ8w==
X-Gm-Message-State: AOAM532dTLjd3GCYpNFA+Q9R97/zA+KU348/EbFdKfnX5sTvwdkCtWfW
        x2vKrdHs+42yyqDMF4YEwsKTLG4WDBROdQ==
X-Google-Smtp-Source: ABdhPJz3LasgtFyakxqtYve1qgLhvBBFuyhx/YGY2UcPDD9wtNPqTxv17UEgzT9MGfEkVOa87buLNA==
X-Received: by 2002:a37:6242:: with SMTP id w63mr11512928qkb.490.1611173442372;
        Wed, 20 Jan 2021 12:10:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7d49:7932:5c79:ddd4])
        by smtp.gmail.com with ESMTPSA id o67sm1937151qte.9.2021.01.20.12.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:10:41 -0800 (PST)
Date:   Wed, 20 Jan 2021 15:10:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] refs: switch peel_ref() to peel_iterated_oid()
Message-ID: <YAiOPzOT52v+dOgL@nand.local>
References: <YAiIK+/hSRxaUx/K@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAiIK+/hSRxaUx/K@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 02:44:43PM -0500, Jeff King wrote:
> This has been bugging me for years, and came up again in:
>
>   https://lore.kernel.org/git/YAhXw9Gvn5Pyvacq@coredump.intra.peff.net/
>
> so I decided to finally do something about it. There's a minor textual
> conflict with the caller being touched in that thread, but it's easy to
> resolve. So I think it's OK to consider the two independent.
>
> The commit message turned out rather long. I hope that doesn't scare
> anybody away, but I wanted to cover all of the bases.

Thanks for all of the detail. Suffice it to say, I was not scared away,
and am in fact quite comfortable with this direction.

Sorry for sending such a short response to such a long email, but I
agree with the discussion in the patch message, and I don't have
anything to add other than my approval and a:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
