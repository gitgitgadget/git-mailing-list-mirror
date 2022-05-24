Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A7BC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiEXWHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbiEXWG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:06:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632612FE58
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:06:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f21so24397198ejh.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9nNLe7Z1ToHfqSXiGNKlbvdEYyna50pwKFmolzilPl0=;
        b=odZqWpklrF+rh3s+lZ+r5GZ7DPQbFY8fwozOCzoFmr6tO0n/IkdlfURpqIadN1/gEt
         sRKASCnu2P11oNpmKCeVvLG2Bh8HY3KwETs96XE9P8666kFYazkwo0AM+vxRADsH3+Tp
         jMOZHue3SBFn3tUxm4zJetptSpkvFgiQg2+9JdADJJWTmZbEBM/qT/HyE45FxTM429ZZ
         CDW5ZQlFZdGlv7y4pmR6+pc/KJapOPv/fFV5BSVGp8WPR/zPram2Ln6rLstDBrN6xXtk
         5Pz2d9fD4GwoWjUxv2t3eBjVNlGOGQGMMZpEkgG0+8DkVbtkEQneOmrnazmlEY4lWca8
         ytqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9nNLe7Z1ToHfqSXiGNKlbvdEYyna50pwKFmolzilPl0=;
        b=OnUyxIoQpqrVN6S1kzENX1U3W/m8ZrwAZaREyqFBXVzvP3xcTLw1el/KwEp+aRje0P
         KV/geL8WXakh9wjhzdRajXcubtxfBV8WAchFHr1naU8sc7nUnmaGECU5nQl/PW55gj2S
         N3hCKTKzP6lu6nofDsZBNoqde7MPIKULO0Bv1glOp0F7uTm5xCsCd/oROY0U0F6HnXZH
         7CnuBmNyG8pI3dvhXFdjD3m4R9WJC96FcV3uW5V6Sl8YVGMtFV3ER6bzeWDnxn+ZPOis
         82EiHgDY2KXg0biQVW3Zs2PaLBp5UReuuI4Qv7ewu8OWaRzVsOmBUN0kDYEmZCj+KYu6
         Ar9Q==
X-Gm-Message-State: AOAM530zNIUnpKzkX1DS8GXkchx7H9dbfPWI6GZcO9TiBMxRAHs97FGs
        bK0CzNUsxtCpqz63pFp3ok0=
X-Google-Smtp-Source: ABdhPJz2QFuq/0hIitI7o6BhjYff+v1Q7QasTTIS1Kix0hm+cE76tur+f/mDVSOqA9ozRF0Tfecrow==
X-Received: by 2002:a17:906:c109:b0:6f4:d700:2e66 with SMTP id do9-20020a170906c10900b006f4d7002e66mr26995147ejc.738.1653430013871;
        Tue, 24 May 2022 15:06:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o16-20020aa7c510000000b0042617ba63b1sm9888194edq.59.2022.05.24.15.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 15:06:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntcg0-003cif-No;
        Wed, 25 May 2022 00:06:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Date:   Tue, 24 May 2022 23:55:02 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
 <Yo00X0NEu8N0MnZV@google.com> <Yo1TIQqvlxhvLZ58@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo1TIQqvlxhvLZ58@nand.local>
Message-ID: <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Taylor Blau wrote:

> On Tue, May 24, 2022 at 12:39:11PM -0700, Jonathan Nieder wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> > On Fri, May 20 2022, Taylor Blau wrote:
>> > 	On Mon, Nov 29 2021, Taylor Blau wrote:
>>
>> > 	> +static void write_mtimes_header(struct hashfile *f)
>> > 	> +{
>> > 	> +	hashwrite_be32(f, MTIMES_SIGNATURE);
>> > 	> +	hashwrite_be32(f, MTIMES_VERSION);
>> > 	> +	hashwrite_be32(f, oid_version(the_hash_algo));
>> > 	> +}
>> [...]
>> > 	But since this is a new format I think it's worth considering not usi=
ng
>> > 	the 1 or 2 you get from oid_version(), but the "format_id",
>> > 	i.e. GIT_SHA1_FORMAT_ID or GIT_SHA256_FORMAT_ID.
>> >
>> > 	You'll use the same space in the format for it, but we'll end up with
>> > 	something more obvious (as the integer encodes the sha1 or sha256 nam=
e).
>>
>> Agreed.
>
> I know we recommend using the format_id for on-disk formats, but I think
> there is enough existing uses of "1" or "2" that either are acceptable
> in practice.
>
> E.g., grepping around for "hashwrite.*oid_version", there are three
> existing formats that use "1" or "2" instead of the format_id. They are:
>
>   - the commit-graph format
>   - the midx format
>   - the .rev format
>
> Moreover, I can't seem to find any formats that _don't_ use that
> convention.

It's used in the reftable format.

> So I have a vague preference towards using the values "1"
> and "2" as we currently do in these patches.

I suspect that's less "vague" and more "c'mon, I'm using it in
production already" :)

Anyway, I'm fine with leaving it be as you have it currently. I'd first
encountered this magic with reftable I think, and only recently found
that we use 1 and 2 in these other more recent places.

> (TBH, I don't find "sha1"
> significantly more interpretable than just "1", so I would be just as
> happy leaving it as-is).

Hrm, I'd think having it sha1 or s256 in big-endian would be a bit more
self-explanatory. I.e. SHA-256 is 2, not 256, and our 3 (if that ever
arrives) is likely not to be SHA-3 (but probably some successor).
