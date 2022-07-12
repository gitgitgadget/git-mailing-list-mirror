Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E0C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiGLHC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiGLHCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:02:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B693F8CC91
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:02:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so12661338eja.8
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x4IU0Lx87X4qFfGk9+Tg271vluOnqHbiqT4AHKLfFTc=;
        b=Rr44nCHPuTrCuNJzlD7MYRo/MyqI7jKGt3w8tJsKR7Iev4cf9Ch8UVwIg/9zoRNo1v
         NmNVcONAfUNbgPxXlonlFIcuLCe+j/sB3ZS727ONwV9ayKUXB4NqTBrFpKDBxrY60HXH
         Lsq4o8lUH9LuxEJCEJRGaHE++/CqxhSfYRiMH5SoX0lyZvNV8fAaWrpgHQ9jNC9eDPZE
         Ene6HpShPnbS1+QU4G5GiNPoVhZ7LvPNVbz+bxu/kmQyAbyl9J0Hsj9ZSNRPUpOD/fVA
         Y/tBAP+igglfJYf0/vInYbYOpU54FxFKl/bGUAcY3s/lOeUkp/9HpSQm5Ul2vGUUV/X4
         cPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x4IU0Lx87X4qFfGk9+Tg271vluOnqHbiqT4AHKLfFTc=;
        b=xTEDdKQ+SaNv1hmTwkSH4nOrSJtwynemQGza6xWlrfG/TupMnfrMAyS2RI6WtGkXmm
         TrYMEgX2lGppEqOBLLv77XSmaXmEzD2FajrUeB0+W6bnoQowTbscG49fzZG+yCvaKDfN
         bSRNdhdZc3op84U3z9kuKexHbVIv0Qp77Ms//2Km871fxXB15tdhg7lg55I4iSNPZ2V2
         +Tc1Ef+ZVAnBTxOcK/0uarvP6DMLUs1J5FuyAPqLW5SlyVo15tBNTtSXoKkMKlIBd8LL
         ZwCEjo22HtFH5sS8bfoagRNUBf994jb7WHML2TFSCgN5cfO0hwaMp1Hcs1zdsxZViPU6
         jCsg==
X-Gm-Message-State: AJIora9hD6RnbKjHIQhW1qi1jrbslZ2LLz9KAG2NtjXwG5/Qx5Sg5Bjm
        YpbgArLTLETI7qZzFWPu3s0=
X-Google-Smtp-Source: AGRyM1sQq+jPU+ckhPGz2ZWpXi97LGMU9gjkRIj8NC//1TFgh4kdJKuSK14dAOpxny8LhURSlop6qw==
X-Received: by 2002:a17:907:2c54:b0:72b:64bd:cbf7 with SMTP id hf20-20020a1709072c5400b0072b64bdcbf7mr6331547ejc.116.1657609341152;
        Tue, 12 Jul 2022 00:02:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f10-20020a05640214ca00b0043a09f6fc24sm5565675edx.47.2022.07.12.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 00:02:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oB9uV-0018q6-FX;
        Tue, 12 Jul 2022 09:02:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/4] .clang-format: Add a BitFieldColonSpacing=None
 rule
Date:   Tue, 12 Jul 2022 08:56:46 +0200
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-2.4-cb69bfa0d0d-20220711T110019Z-avarab@gmail.com>
 <YsynY24oV47q7YxU@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YsynY24oV47q7YxU@tapette.crustytoothpaste.net>
Message-ID: <220712.86czea6cg4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-07-11 at 11:37:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Formatting bitfield as "unsigned foo:1" is the usual style in this
>> project, not "unsigned foo : 1", which clang-format will use by
>> default.
>>=20
>> Before & after this change running "make style-all-diff-apply" will
>> yield:
>>=20
>> 	582 files changed, 32029 insertions(+), 29794 deletions(-)
>> 	579 files changed, 32065 insertions(+), 29818 deletions(-)
>>=20
>> However this highlights a major limitation in this approach, because
>> clang-format v12 or newer is required for this rule, but that version
>> was only released in April 2021.
>
> This isn't supported on Debian stable, which has clang 11.  I think we
> should expect that to be a viable development target here, and I know
> it's what some Git developers actually use.
>
> I think for now we should drop this patch, and we can reconsider it in
> the future.

That makes sense, but the unanswered question is still how we should
relate this to your proposal of standardizing on clang-format.

I.e. this & maybe AlignArrayOfStructures (and probably some other
things) are probably things we'd like to enable to closely match the
style we have now (in the case of that setting, because we've converted
the rest to designated initializers).

So we'd be left with one of:
=20
 1. Just formatting according to the style an older version supports,
    even if it's not the preferred one.

 2. Require the newer version, after all you don't *need* to use
    clang-format, it's OK that we can run it somewhere...

 3. Fix some things now, maintain some whitelist of exceptions, and work
    towards parity (possibly with running a newer clang-format e.g. in
    CI).

 4. Something else...?
