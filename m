Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F7921847
	for <e@80x24.org>; Tue,  1 May 2018 23:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeEAXY0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 19:24:26 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32906 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeEAXYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 19:24:25 -0400
Received: by mail-wm0-f48.google.com with SMTP id x12so16509844wmc.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A8Qda2kbyxLdpSURuieTpnh2fWcEqoZmJbNvqrSdxog=;
        b=tRl3StgpxsJqesC/sOJg2pdQCcrvZtZfSrKZehMeOMdweQOAwuOvFgefIjBHfiaZy3
         Apr2aTeI02D3OjpQ0I2nLzspJHkUJT+h26eAHrT8qLHjEvpUimPl6yehTANaBmk+XJxA
         fyq6NGsKbX/kPwVmO/TPM3KIP7cHIJlZziKcWJKYnbYhYk2ESl4BNta43u5S1BaIAY9v
         cbzXgZ7DL5GbiAL/bEr8levF8L4Bf4hJSdH+AUe7j9p43GbZCybRjBcGrVwSmGXYc1CG
         K5VWftWRQzmlLhWC6aaWemedaEgdCXM9N45U/URv5tIQesfxi4AUL6hbIhFFevk87vRG
         KVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A8Qda2kbyxLdpSURuieTpnh2fWcEqoZmJbNvqrSdxog=;
        b=RfPIZmBdNIiBI0M8jU5+T6ExSXRvF3uQx+uywRbZb8Hom2Mj7pd3PURMOIt+3r5HB8
         T2naZd8YJ2Ir6qW321FEKCtOmWuJgoIKVL2HbdU38ArZxSn99SNx6LCx7xJ5MmQ+3peJ
         nXsSJpi8xxa7i2Pg+KwCx1XWw64WaayKBI1Vd/bPCxHHYTuwPy4c3gJmsNByNc/C2t+8
         fbq6GY1McNUvG7ncPEAk3AQ62x14OyyJySVQp8oAnpcS4ARcrjrqezXudKvpoL4A4Q7l
         mtD08YnWMKo6m5rb+8oo5Rf5l24op1aKdxnSsypmtQylIpzVFfuIblW3Rmi8WP64fDaA
         MSog==
X-Gm-Message-State: ALQs6tCq0y0FFj/mEYYLnu9QFfFpOYei09pG7I6PaTaP6Y8cODSPJLwc
        2urtFzy5PPK3E1AvaIONMB4=
X-Google-Smtp-Source: AB8JxZoxGOYdAe6ibYXzbyXk91RGxgzt/AwA8SeLCaKPssOvrhR1xExBVXaCwc9o4rw7k2YLB5naIg==
X-Received: by 10.28.210.193 with SMTP id j184mr10481090wmg.14.1525217064104;
        Tue, 01 May 2018 16:24:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w31-v6sm20416915wrb.93.2018.05.01.16.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 16:24:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Wink Saville <wink@saville.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
        <20180501165931.25515-1-wink@saville.com>
        <87zi1jxjqn.fsf@evledraar.gmail.com>
        <CA+P7+xry-dE0-TMtRzNjiJpR1ZVmGXDy5ObfMxKyWA+eR8XMsQ@mail.gmail.com>
Date:   Wed, 02 May 2018 08:24:22 +0900
In-Reply-To: <CA+P7+xry-dE0-TMtRzNjiJpR1ZVmGXDy5ObfMxKyWA+eR8XMsQ@mail.gmail.com>
        (Jacob Keller's message of "Tue, 1 May 2018 12:45:56 -0700")
Message-ID: <xmqqh8nrx8m1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I also agree, I'd prefer if we aim for the mapping to be something
> which works for all refs in the future, even if such support isn't
> added now, which is why i've proposed using "refs/remote/<name>/" so
> that a tag would go from
>
> refs/tags/v1.7
>
> to
>
> refs/remote/<name>/tags/v1.7
>
> Ideally, we could work to update "refs/remotes/<name>" to go to
> "refs/remote/<name>/heads" as well.

This is *not* imcompatible with having refs/remote-tags/* as an
interim solution.  

We'll have to support refs/remotes/<name>/<branch> anyway long after
we start using refs/remote/<name>/heads/<branch> by (1) switching
the fetch refspecs newer "git clone" writes to the latter format,
and (2) extending the dwim table to try both formats.  Having Wink's
solution as an interim step adds one more entry to (2) but the
machinery is already there.  And it does not change (1), either.

