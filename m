Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999DCCA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349457AbjIKVdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbjIKUMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 16:12:09 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFCE185
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694463113; x=1695067913; i=l.s.r@web.de;
 bh=rYEWK1Twlc8mdAUKAu6jpSDFR5EM6zKCMW4fBZ4cY3c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TlqtuKpJqSFHKQDHQsHjcxAYM/5qVlDPO+CIoHBjuwmRdNNKaulM5zEaYqEBDjc7xWjkSwI
 cM+k/Cfbszg79J4k07jgR/Y7ozjt2fDsqAiqixFXjp9jTT2kQ0Veee9MDhS16mk7Vo8zAlcNt
 TBuYdwwcvfhGtFmEmABns2iGEkYxuN1xYhrUc1Jm97r/VCkLBz4XI0ioZiHFHRMNJbVkkrgIi
 Nfad8VeBOIU+nl6guN10GpbSYM81kcWCyZQM4/lVjCsSFvEUTMssByrpspukHPQ9SACLEeHvE
 2uOvSTB4GCy+o3Bj/LLHlh6AbQ11KnelwqLWc/ZaPDuiI6aIyO5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.145.34]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Lg-1qZizX0fh8-006ZY5; Mon, 11
 Sep 2023 22:11:53 +0200
Message-ID: <54475801-0387-468e-bd90-a5ea0d677bca@web.de>
Date:   Mon, 11 Sep 2023 22:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <xmqqedj4v808.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqedj4v808.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPWcWLdo54sf10/93b+WhLLza09Pz76Pg/HcQ91lgIGp90E1N3y
 +lEC3TalhN0iqCGAiHEhqypbK/YBN+MuP+lLNh6B2dDcnjtSScVmJruSgGa0uz9Ke8lf9tU
 DRcXrlcVD1xPsInNCnS0+kuREaF56KdwXQ0H1Z5ruWNRewYWB1+9UpYrRMVPDYZe9Na+FRA
 Wb1dE8x0a1L/obOPoE61Q==
UI-OutboundReport: notjunk:1;M01:P0:3MyKbwgI9qk=;wIvwrJfbAZmHouIBiKq6hqkt41F
 FqkcdNqbj9tUaoYG/RdcKVuiMT5Kl0qdHLo5DUSMD/B5HifIGAJOExJlxXdQgxzx9LofZfigE
 456+4BJCNbEfpj7hB6oJDkAPjC0snm308Sh4wNFqyComDFH7ONvBCQp7H/XT1uhUupDexL6Si
 Qq26MXrccn+rDblaRDbPaJXtBPCCwQdMeCmxSymrGCNUhox0Q1uHHqnJvQkmefSd/IEixkiSq
 +lUYMKAei7ncpcPlVqNsNPmh62cxsyV9jziq13a5/d0pvtK3bJpal7sZVFfd/TsdL4nmUfpSD
 ZsO/G5lI0t5ERPBJfZ0IIYGbtU+caKyaMAdYgFB4IcFhKogWnZiXVqN6pE1+jD3HTlMGS8qZ9
 OudlXjqopKacvoze12SwrO4s9QzJq3PusTuTeyuW3HEaKycrC/0LhqVWKbLMzTfjAhdbC8mmR
 uhX022c4ABPbm1mIH6p+BfImInECNf0JMwTg6xW3v5zaU+1bu2MaDmYz7VuBlrutwaTDui3ar
 YPndc+IWrL30ddtRWfC1o23FDkEjGC7XlUTXahBsbcqtb6E5q1Z91f2gG8b2QIHjRR4wJHPsM
 r/t+uinx3M3OwQegeFg6o9cinHco3fO+TrvT48uIrKAMakAUR0om+f4BqEGoK1Pd3hI3aB7Fd
 VAwAz0feV68Alwbj7PXuW7e7j8jMAmhRtXDwDcspblRoKxJTynTggWTiUqO0WTSmDHFZKrj7i
 2tnw/Y3gq5Ib+4UW1adRccTXMyLt0sNMGXGaPqiG0yacvQVClu0aVE0jd4842Fjp6p+8XMfE5
 SXGObDXjgm3KrQb+ITGbPFWQU/i6KWO51QY6giNOutkZsKkRiq88Nl9jLsxVpTIN/TBnB+j/l
 RPkaTSZfE+/Zf6eDUSYjTsFZPRN1wI3ArD3PhhfRWi63uZex0tlTQK47ldy3jcSLS188wvKcz
 +wDy5w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 11.09.23 um 21:12 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Some uses of OPT_CMDMODE provide a pointer to an enum.  It is
>> dereferenced as an int pointer in parse-options.c::get_value().  These
>> two types are incompatible, though -- the storage size of an enum can
>> vary between platforms.  C23 would allow us to specify the underlying
>> type of the different enums, making them compatible, but with C99 the
>> easiest safe option is to actually use int as the value type.
>>
>> Convert the offending OPT_CMDMODE users and use the typed value_int
>> point in the macro's definition to enforce that type for future ones.
>
> Interesting.  I wondered if this means that applying [1/2] alone
> will immediately break these places that [2/2] fixes, but the answer
> is no, as the previous step did not make these places use the typed
> pointer.  But it also means that with this step alone to use "int",
> instead of various "enum" types that can have representations that
> are different from "int", would already "fix" the current code
> while still casing back and forth from (void *)?

Yes and yes.  And the change to use value_int on its own makes the type
mismatch visible via compiler warnings.  It guards against future
violations.

Ren=C3=A9
