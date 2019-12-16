Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5728C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63E3206CB
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NA+sNGKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLPNW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:22:57 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46687 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfLPNW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 08:22:57 -0500
Received: by mail-lj1-f175.google.com with SMTP id z17so6739033ljk.13
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xM8E6vvoY+dpil5yHWluQvmhlybyKRChJU6H1he1ef0=;
        b=NA+sNGKRIxWOuz83P9mEMe9o6RwULrnXkTpQVzWU4U8mRLBJ7zwv1ejz+Sv/OVG8AO
         /RLcDnPlkmCJScFZ2CCN7qwa5M4k+Lv3bVnqFSrqV8yDkNZiJmVDC3ASCnZHOWrwY1Rx
         vhfoEAd2eS1h0wgn7w1NM2erVFnDYSYBTJQbiOtSuJSqgfqrAcX6z4zC+qYC8pCDsqa+
         B8fBkxVWAUnicCDnc21Wp5SrITpcWSyuComMOwL+ttN5K/s4w6fYGA5PdZHmq2cUUkFz
         NYE3ZEJUgiMmh1MsxM98oa1eaza8AHMBsF2LYJKbSIsXQG9pKqFmLK8DpxvTwkNcN3va
         tnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xM8E6vvoY+dpil5yHWluQvmhlybyKRChJU6H1he1ef0=;
        b=Yh4pUG2xnme7FLhJunaGMYOgcNSeFv9j9dzzxNbi36/gRDO335DW+fhHUY2/nMF31I
         UkacnqSDTdeG+C2kB4o10CrMmIrPEpOBQEOW4b+vgci13BwbCjcU+thpqfvNUqlNTlmD
         DDWatW1x40ehqi7YP6+MFLKY0eCnpC5mtvtao1xHLPx4EAdG7WyWKvwjE1pZIhlsuw3W
         +oA6S/B/SzlVzQNBalLf/BR5aH6gYne8FMopjHZoc3DD1blof2FvVE8DQcpNRyAsCOC8
         3YG4Ipoxbxefp1rUJOju2LOwlWhgxeTuVPrYsNDdw8K5tL6KQsPjv61LUHsDcbd+KxlU
         qjag==
X-Gm-Message-State: APjAAAWnVTiDkcukht8d6t6m4u7TiLpuP9kXTGOBgysu4l0Kf+FArSuq
        fX8uDLBZr91ce8s4kRP+n9C90/IJ7Q==
X-Google-Smtp-Source: APXvYqxxmSgMvvQX5CPahqGfbKUKvHlez7nGhKKfr4p6CmAc2dbr/Z5bs0AE/DaOZAfTGJSIcD9gMg==
X-Received: by 2002:a2e:a490:: with SMTP id h16mr290506lji.251.1576502575213;
        Mon, 16 Dec 2019 05:22:55 -0800 (PST)
Received: from ?IPv6:2a00:1370:8116:64e8:7d77:758a:8ff2:3432? ([2a00:1370:8116:64e8:7d77:758a:8ff2:3432])
        by smtp.gmail.com with ESMTPSA id o20sm10798576ljc.35.2019.12.16.05.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 05:22:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [BUG] Git bisect extends bisecting range on repeated good/bad
 data
From:   Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
In-Reply-To: <xmqq5zikkq6n.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 16 Dec 2019 16:22:52 +0300
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A220DC9-C654-40E9-8F04-7B9B3ED3318D@linaro.org>
References: <473FE927-FC11-46A0-8ABB-7A1FDC8C1A6C@linaro.org>
 <xmqq5zikkq6n.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Dec 13, 2019, at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org> writes:
>=20
>> Git bisect may /extend/ bisection range on repeated good/bad data.  =
Is this expected?
>=20
> It is not "repeated" that is an issue, but yes this is expected.
>=20
> The bisection works by finding a mid point to cut the graph into two
> pieces of roughly the same size, and the graph is defined by the
> set of good commits on the bottom (i.e. "we were told that all these
> good commits were good, so there is no point going back the history
> beyond any of them") and the single "bad" commit you gave the last.
>=20
> If you give 'bad' that is in the newer part of the history than the
> one that is already known to be bad, then you rewind that single
> "bad" commit, to force/allow the machinery to recompute the midpoint
> [*1*], and because the area to search would be wider when you do so,
> it is very much expected that you'd be offered to test more commits.
>=20
>=20
>=20
> [Footnote]
>=20
> *1* I said force/allow is because allowing the machinery to go back
>    and recompute is a way to recover when you gave a "bad" earlier
>    by mistake.
>=20

Hi Junio,

Thank you for the answer.

--
Maxim Kuvyrkov
https://www.linaro.org

