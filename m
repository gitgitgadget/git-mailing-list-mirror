Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4891F404
	for <e@80x24.org>; Fri, 26 Jan 2018 22:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeAZWpB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 17:45:01 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:47100 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeAZWpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 17:45:00 -0500
Received: by mail-wr0-f178.google.com with SMTP id g21so1764873wrb.13
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=evUZdVmbpqWHe9UxvVQsmz9NSMHibg6DMInOeX3vInI=;
        b=ukV9rqVaHBhVfIhXd+WcBGsFHu7WzMWPhh2ZMXg2ajE0rNP44fhjtt2HGf2CwJ1YJW
         dh3DPsKScJjFDKqsS/kVNwzZxRwuHJZGvc4J7zlZpy56G5NNuW7UKV4z8Kn1B0g+YD7u
         YRCsOWcI+uqbFdbtCMGH10m1ivkZQFU4DEedtY3rMBPCsxXvikol4fBjP15NAamQQ72/
         F/oYw+tQidZHVgUDtu6OuUn9u4i+cpBt2fNO0Kg8qmAFX943ExPEaCoXYK4VG2HvElAK
         VRJ11a8oqNSbB0t+CKWQfcz8JbYY3cCGfieVHsMhYv73NOdz6AsG+8Rmwq+ouXRe1EgM
         /EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=evUZdVmbpqWHe9UxvVQsmz9NSMHibg6DMInOeX3vInI=;
        b=d0OQhsz9Nb48QpyZwJZeowsImkDYhN/rfvItxikXsQBz//ey6DrjaBkjCBw1ucJvqV
         SyWgUCBYjlF/V8QvDWKezzm+Op6ZsbZu+xaivpTX9yDKOBDwT6I7jLR1QlbCsUIClPZj
         vzrvIOUWO7dRUfSxgZbHGx4ciJJSSGPU1A+nh32sonQ9uaOiTZJw8DNiFSN+JlIU7XOC
         WpFfksLZbthyMvPDYFTfj6eh7xWgcuBMfVbKZjqWRW4vk6Yw1aeLUPVOJzrda2DkVUPI
         CY1jp9VIRmyeH2Kv4Ggv6oHxv/ORL2I2tf1MaUzqPIPUNs0UGAlWxWDBohEfpoOgDBcu
         48qA==
X-Gm-Message-State: AKwxytcxBMIeYhHxUGXhbaU25pFBuG//aQ3wT6SZuo01e5n2Xwkj1R2h
        LVcOhx0LFiso8JfJHOM7ZoE=
X-Google-Smtp-Source: AH8x227wmNs2ssx02SNL7utBObo4aGpEp2aN0EZu10Yo1KBaFS3GYYEUwbQbTvIQNwvKZaAp1yL7Mg==
X-Received: by 10.223.159.3 with SMTP id l3mr3032946wrf.199.1517006699204;
        Fri, 26 Jan 2018 14:44:59 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5B56.dip0.t-ipconnect.de. [93.219.91.86])
        by smtp.gmail.com with ESMTPSA id z39sm8149454wrz.20.2018.01.26.14.44.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 14:44:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write shared index
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180122182717.21539-1-szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 23:44:56 +0100
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C0E7737-7FE0-48F0-8667-E3891D892249@gmail.com>
References: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com> <20180122182717.21539-1-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 Jan 2018, at 19:27, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
>=20
> On Thu, Jan 18, 2018 at 1:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Jan 18, 2018 at 6:36 PM, SZEDER G=C3=A1bor =
<szeder.dev@gmail.com> wrote:
>>> This series, queued as 'nd/shared-index-fix', makes the 32 bit Linux
>>> build job fail on Travis CI.  Unfortunately, all it can tell us =
about
>>> the failure is this:
>>>=20
>>>  Test Summary Report
>>>  -------------------
>>>  t1700-split-index.sh                             (Wstat: 256 Tests: =
23
>>>  Failed: 1)
>>>    Failed test:  23
>>>    Non-zero exit status: 1
>>>  Files=3D809, Tests=3D18491, 401 wallclock secs ( 7.22 usr  1.60 sys =
+ 263.16
>>>  cusr 49.58 csys =3D 321.56 CPU)
>>>  Result: FAIL
>>>=20
>>> because it can't access the test's verbose log due to lack of
>>> permissions.
>>>=20
>>>=20
>>>  https://travis-ci.org/git/git/jobs/329681826#L2074
>>=20
>> I may need help getting that log (or even better the trash directory
>> of t1700).=20
>=20
> Well, shower thoughts gave me an idea, see the included PoC patch =
below.
> I can't really decide whether it's too clever or too ugly :)

Creative :-)

Alternatively, we could store write access credentials [1] of a public
repo in Travis and upload the trash directory to it. This could
work "out-of-the-box" for git/git. Personal Travis environments (e.g.
larsxschneider/git) would need to setup that individually.

- Lars

[1] =
https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-=
in-Repository-Settings
    ^^^ that's the mechanism we use for the Windows build credentials=
