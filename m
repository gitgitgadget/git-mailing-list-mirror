Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69377C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1068164F5E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhBDSsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbhBDSrg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:47:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582ECC0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 10:46:55 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id m7so4730242oiw.12
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 10:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bJ3ogUdSLo+T78BlWUgaCgz0mcsDV2lQSK2SlDk88DQ=;
        b=I7ufc02a/gSJHBQAYGQanwS0efhN0pMEI60xMgOLJ+hpGgIN/PQAT1nVjVTuy0X9Qs
         fhzRVz/fjRBuft7FEp0d9S3m45yZCDpgQoi+QT4XIszVe/h8W0eZrDZb6sRsFm5Aqkqx
         QgFjAhyvReelhSkJ7d3VVAhkZZOqNNGCedTfW49EVlqbhtf/twRHCJvVm7l+mBQcdVSe
         U1igNXveWRsEYJtHwUnFbqUNi2I+apgUG1dIGQ8GXLGMfQ7NxLVEyWEEOJUmknXJQuHp
         +2BvqBcOiaCEEgMLCh6XrvQCW9cRHH2jKQdNPe/H7TpzQwObSm/o7GewirsUqdeNYges
         HlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bJ3ogUdSLo+T78BlWUgaCgz0mcsDV2lQSK2SlDk88DQ=;
        b=nILe3J1r+wwgSM6ZKbiHaFLu9pXjfQvgupSnWxHubSXUC+g/kX71cly18N5TET2Z6j
         5PPljhP11j4JezzbsdaG2Fc8xRe5N4QGyAdQKzQXjFG+kWpayMI/RZBrvFYRiuPlj+G6
         xb3dkQQQHkcWscEkounSVVEy4R9hgCWIqZyknfrnAiFo3BrHWj4pVWPzmBcQl3Lwrk+/
         +hRyUdpmTQ5eFMuvq5DNW9xyw2Ue9652vqzBvWX1KqkRvlg913vwMF9UGfImiD6AVm49
         tBaISfAPhIzP8oBwMrPfYIGzFT54WuZVvM7LGOd9o0l+MEWlCuYAAE9D7E7YOVIcCiIg
         TH0w==
X-Gm-Message-State: AOAM53187+ZNYS/MR+02Z3gDSDi3IQOVPdJ9zOmSMRbDgXUvboTv7EPj
        P4oB0NSX8D84LqbOMe7en9DNgSsQYqCUT8Dvxkg=
X-Google-Smtp-Source: ABdhPJyda+pOcNDMx993+jZdBREBE9vlK1Sn/aDG2eJhuMpNHkzwXfTcoQ5GmHJ3G+AJnaGsT4YShVIWCSBFb/3mEXM=
X-Received: by 2002:aca:ab08:: with SMTP id u8mr613270oie.84.1612464414007;
 Thu, 04 Feb 2021 10:46:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> <7b8cfb2721c349f2bcebec98f84291b1cffd3b49.1611954543.git.gitgitgadget@gmail.com>
 <875z3ep30j.fsf@evledraar.gmail.com>
In-Reply-To: <875z3ep30j.fsf@evledraar.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 5 Feb 2021 00:16:41 +0530
Message-ID: <CA+CkUQ_YDxF+fphzyQRD1OkFh7NGEmHUABvRiAjL-H52MHyH3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: use pretty.c logic for trailers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jan 31, 2021 at 2:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Given that the goal of this series is to unify this parsing logic
> between log/for-each-ref, why do we need to then copy/paste the exact
> same docs we have in pretty-formats.txt?
>
> At the very least we should move this to pretty-formats-trailers.txt or
> something, and just include it in both places, or better yet just refer
> to the relevan parts of "git log"'s man page, no?

Ok. I will refer to the trailers part of "pretty-formats"'s man page
in "git-for-each-ref"'s man page.

> And similarly, here we have now mostly duplicated tests for this between
> here and t/t4205-log-pretty-formats.sh.
>
> I think the right thing to do is to start by moving the tests that are
> now in t/t4205-log-pretty-formats.sh relevant to this formatting into
> its own file or something.
>
> Then instead of duplicating the tests here, just prepare them to be
> changed so that we can add both "git log" and a "git for-each-ref"
> invocation to some for-loop, so we'll test both.

With this unified trailer logic, "git log" and "git for-each-ref"
still behave differently.
For e.g.: "git log" does nothing for unknown/incorrect trailer option,
whereas "git for-each-ref" stops.

Even if we move trailer related tests for both into a new file, I
guess we still need to test trailers for both "git log" and "git
for-each-ref" separately?

Thanks,
Hariom.
