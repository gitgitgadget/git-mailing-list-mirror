Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9964C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C17564E11
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhA2UU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:20:26 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35432 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhA2UUY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:20:24 -0500
Received: by mail-ed1-f54.google.com with SMTP id j13so12050856edp.2
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 12:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xexIrL5CSByHk+NbqIO/snKp+pJx8gvkKD2IilkhYfs=;
        b=eImmEUjK6FMTcbO5PhAVYWvjl9SwyBBbboNYsztUz7Obi3eaDE5ZtpC6vyRPI9Yrif
         eCT6qYT/Kmj3Vj+HK0a1tKJkZcRAAImuniM+8PUdcXourklYM2oTSu/vUrjOUlJimfwh
         KTGbgho6BdwVrwydH9T/W0ssIspCh7/kuXDtl6bltcQOk275FotkAgAcmko9bHzYgCfs
         5CvMaN9u0FDsKRwnT6EFczBCp3lJz/Wsylqq2Kqjt8BQXcdfAg+tL79IBY3ryKSMyMAB
         f/0sfdiVoPW2invA0upYeRy2YsBvbSKbW7g6dueoEoJq+tT45LYxTM6OsQCBpQAX0p/w
         uXGA==
X-Gm-Message-State: AOAM5330HerUORTBOYPDP0TNXGti3utmX+acLXv8RM/EKherRYTTdwCK
        HXEN7kvORiKZmjeU0Y2/sk2KpLjOtrwLA8LqJLyJ4LGefFs=
X-Google-Smtp-Source: ABdhPJwuhJzmMxSWJ+1SV0X1zMM+TzQ/RkVXRRRwvu9Ex8VNdkhO4GDk7V01JP3G8UGR7zkToEqkv5qnx3ys6h0wiOI=
X-Received: by 2002:a05:6402:3088:: with SMTP id de8mr7066116edb.221.1611951582523;
 Fri, 29 Jan 2021 12:19:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611098616.git.me@ttaylorr.com> <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com> <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
 <YBRqOI84MkU+HNzt@coredump.intra.peff.net>
In-Reply-To: <YBRqOI84MkU+HNzt@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Jan 2021 15:19:31 -0500
Message-ID: <CAPig+cTc3RGEu4anOmnYBBQxXgB0UL8Z_vJfnV=FoNTOFYEpTQ@mail.gmail.com>
Subject: Re: [PATCH] p5303: avoid sed GNU-ism
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 3:07 PM Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] p5303: avoid sed GNU-ism
>
> Using "1~5" isn't portable. Nobody seems to have noticed, since perhaps
> people don't tend to run the perf suite on more exotic platforms. Still,
> it's better to set a good example.

It's not just exotic platforms on which this can be a problem. BSD
lineage `sed`, such as stock `sed` on macOS, doesn't understand this
notation.

Thanks for eliminating this particular GNU-ism.
