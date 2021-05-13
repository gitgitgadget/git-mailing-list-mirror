Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5AEC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E3461438
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhEMHoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhEMHnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:43:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A3C06138B
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:41:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s20so33086386ejr.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Y6Ub29H9grSp02Z3Kroig6BzaQPiuTxulTVRlfJjoYY=;
        b=nx2M5jp8vnNLby5E6z12BwPdIvwcEqo2bd+E5MIkIrcrFCYLp98tRR26exRN/yi4FS
         qlK7PzPZMKH3AGZOPzAsKB/IM8nYYIabBiUrYMa+RWl5d3OsQyociTlU1nPH7HOpY17Z
         5AjBByonrOezovfioz6MeTna/qN/9iaeSMflNPGfdv2P0/beLR/c/k4im8lEDIIjpqRh
         GFJpv3paWJtl9oZNRiQUMP3YO/TkzFTe37dKRbYRZemj8NbxdURDsJGWZa4SW74BG6W+
         ZIrC+DiIQadS8SDS933/Wb/WUvvIb6qgPfo0KRgn/3d1ZC0pkzqYCm70Vc6espxUuxAQ
         WodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Y6Ub29H9grSp02Z3Kroig6BzaQPiuTxulTVRlfJjoYY=;
        b=nF6KawfhxHFwgk13FZW1W7VXACi7K0UsmjDz02I7GLglsUZhy2x6EWTzDWcnunUwSH
         nQrU9l6amXH6rARxigazCQIvyphs/6HLG1mJSXBTwx8x9uG2W/26dP796u7v7bOd0nX6
         azpJxKuAmMOx9ebXmdAXYrdMnUlA3ZO2SGxsczmBN23ixgYjvEAp0lGcuB8tkqkJJC/W
         tU1la4P0Kty0fEMCkIUwfr3imFwqcdHE6WA3MRek1Yp4ynVM6Ysvy9fOqA8SkKTCeO52
         CQELe5IDt7mMQ188mtiplj6dJmiSgQdMShJCGvA3KH/47nicoWMroBczri3X7OKF2uJ9
         fzGQ==
X-Gm-Message-State: AOAM530IIc2Nmvo8bEGoFDnVCCGSPR3tpCvQlJW60WcCjDR5oYju/P0G
        XbQ1RcLE4MKdRuz56WMrZv8=
X-Google-Smtp-Source: ABdhPJz/fGqR70VodJ/ZXRFnBOl/b7gPZ+pRaATQOyWV530W8Kph75O3WP0UW25sSWEtcI1oy19ecQ==
X-Received: by 2002:a17:906:c827:: with SMTP id dd7mr42465293ejb.225.1620891711295;
        Thu, 13 May 2021 00:41:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mf25sm1338071ejb.101.2021.05.13.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:41:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 0/9] send-email: various optimizations to speed up by >2x
Date:   Thu, 13 May 2021 09:37:36 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <YJxmmyM9/3KBFPTg@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YJxmmyM9/3KBFPTg@coredump.intra.peff.net>
Message-ID: <87sg2rrsg1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 12 2021, Jeff King wrote:

> On Wed, May 12, 2021 at 03:48:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> As noted in the subject this speeds up git-send-email invocations by
>> ~2x or more, and brings the very slow t9001 test from running in ~26s
>> on my box to ~12s. It's no longer consistently the slowest test I run.
>>=20
>> This is basically done in two ways: We lazily invoke "git config" to
>> get config, before it's very eager, and deferring Perl compilation
>> with s/use/require/g.
>
> Splitting my reply, since the other one got deep into test-suite timing
> details.
>
> The techniques here look overall pretty reasonable. I think the module
> lazy-loading makes the overall code a _little_ uglier, but IMHO the
> speedup you're getting is worth it (I was surprised how much of the
> improvement comes from that versus avoiding git-config subprocesses).

Yeah, it's mostly uglier, but I think it's worth it. Some parts are
better afterwards though, i.e. the SOME_RARE_BARE_WORD is now
Module::It::Is::In::SOME_RARE_BARE_WORD, which makes it easier to
understand where it's from.

> My only concern is changing the interface of Git::config_regexp() in the
> final patch. Do we need to have a config_regexp_with_values() to avoid
> breaking third-party users of the module?

As noted in 3/9 I don't think we need to worry about it, it's recently
introduced (a few months) API in Git.pm for send-email itself. I think
we can just change it.

In general I think it's unfortunate that we have (at least in principle)
a "public by default" module like Git.pm that's mostly for our own use.

This series doesn't try to deal with that in general at all, I'm
somewhat of the opinion that we should just fork it at this
point. I.e. have a Git.pm we freeze in time, and a Git/Ours.pm that's
going to be the private API.

I stopped with these optimizations at the point of refactoring away
Error.pm, which is a large contributor to compilation time, but as long
as it's a public API that can't be done without changing the public
API. If all we needed to worry about was send-email, git-svn etc. just
changing it to Perl-native exceptions would be trivial.
