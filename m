Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27976C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC0064F93
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhCKQRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhCKQRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 11:17:32 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039FC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 08:17:32 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u62so7878848oib.6
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AHurpjhKCyXzSmtw2uLj1ztAyv9mlTPQ/Nwu0h8Tpr8=;
        b=l3hewqa0xUVj1mnE1dcfGZRAuVRCZKZ+ou0BasO08hxKJdkfSkA3Yg0e2VHIZaUwZi
         Mz6BzYN28tSKAVnJmrsObz/cE1eAOotGyJ+Zwp9Rtf06HhwqAKMsut5IA9KFR9k1AdaW
         be1NOeh2PhyouHSC3pd3FKO+h3nAIt4zxfbvb823oRviSw280kfWQ+dld4GtulThEPKZ
         ZFV5VfRbYVjT1jWjJuKQ8Qij7qrOM7begsiO8KI1O0trl3frETC1dRWeaOasdnsvWJQZ
         0QRTOFtHhCnAi2RdfRqRDSi6Wi5ML4shl4sFu806OMVtwl2blbd0OtfPigfTPyx2svj8
         /BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AHurpjhKCyXzSmtw2uLj1ztAyv9mlTPQ/Nwu0h8Tpr8=;
        b=e6ZHX7+q+yysHgFIlh4etx+cUpN8GnzZIbPpO90IRb+zGNmFDG0nwNVoyOvDmcjYmU
         kzqH+gdJvemIEA4nWR9LKSNaKZYdKzip4YQ6vrzJoDSyr5XoFhjCwIXMjDPJSO2PIrNl
         zq8om7zD6MXMI4Hiqfcbq76KK9xw8ekAqrOPKmQJC7iwf6wFcMA6NOeY5WTMogiAQS2s
         dzakVaw6MqJiGiaqHeCNWa88BFhFI9aezNKwmyoyLpxNlVAgmq2LDribWxokw2DFRFQa
         k35D16PvhBcAlaCaesCXMhIjN8kA2gER0X47ocYEHhh77GH9FoUJWKIPEFGXu8K+1dX9
         yNNg==
X-Gm-Message-State: AOAM533impCg6dxX9Tzhv+iQzqHnPtE/JbtOhV/G9Nzxb4zpKUoipHcj
        aoC2xUrGJqZTpWRQf/MqFMu6B6h1P+hhXcZw67M=
X-Google-Smtp-Source: ABdhPJwPTNaxwrQoWkC+9aATFfZZKYBmw6P07AXyHjarHGz/KAcuJDOzYpuVJJUXC9uIDFX+KA8952Bf1B/eVbfVHXc=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr6756158oij.167.1615479451524;
 Thu, 11 Mar 2021 08:17:31 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmtvafl62.fsf@gitster.g> <87r1klhq3y.fsf@evledraar.gmail.com>
In-Reply-To: <87r1klhq3y.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Mar 2021 08:17:20 -0800
Message-ID: <CABPp-BHLNm14c9Sxv6zWBod7wxK6gSWwt=SR3J4NVObAprcomQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 3:44 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Mar 11 2021, Junio C Hamano wrote:
>
> >  Will merge to 'next'.
> >  In the longer term, we might want to remove filter-branch and nudge
> >  folks to more modern tools.
>
> Did we ever have a re-discussion of adding Elijah's
> git-filter-replacement-whose-name-I-always-forget to git.git? :)

git-filter-repo (https://github.com/newren/git-filter-repo)

The original discussion you were probably thinking of was at
https://lore.kernel.org/git/CABPp-BHqdKvsUDx40Tz-A3z32TN_KWcDENWb8zsaidxxf8=
SNCg@mail.gmail.com/.

Re-discussion was at
https://lore.kernel.org/git/CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_=
9skA@mail.gmail.com/.

Resulted in https://lore.kernel.org/git/20190828002210.8862-1-newren@gmail.=
com/
instead.
