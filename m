Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04DEC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BB364E39
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 15:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMPOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 10:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMPOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 10:14:03 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F2C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 07:13:22 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id f4so2567872ybk.11
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cqb3KdmnXAmsRacKstSFJMiLQVerm4x/3OyL4iTcbkQ=;
        b=BZSlNfEtorVwg9MHF13vWmkpSs4YRNVkK836wocLI0rBE+XO5TJwgIZZdCJ8W1iQgW
         UlHEUXE+eeWg5cx/ggVc3DSMiA5YqKwJ3hydWZDUXxa4aeg2y5xwWb7aXz4QNmBqLrci
         m/zajhpF3WNvod3z5bgHmfGTc/Fsd9iPEdjftv/DA1U2DdtKO2xKjk98BhiN4rLluI7P
         NvTQRZOvZdEi//+Vtv7vuOCHle3aJ3O3GaRBkvjqSn2TuQeQDqU6RuigbWfacF0p0l0L
         xIOcBNORAIPyarbfEz9jOIK8aHdiw6n4lhli1tiNa5W78XMOByMI00V629xSmxiIJ6sT
         BpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cqb3KdmnXAmsRacKstSFJMiLQVerm4x/3OyL4iTcbkQ=;
        b=UNKKii3P8o3O27T7XV1C5L0CulfO4ASN0QIf9BxDoQPpkbL0k0LkFehR5kGzi5rs3+
         iILsalV1euunjZhlNfbsrp4ORuNeBXjs15nfBNd+BkNjh1sq9sKrXcDNt6nHddZu+JfO
         rBnC/vURF7KEfXTwe20tJRifx6/2OTG7sgAihcoSowKHG0pqWXBaML71RrzPR74Ke0P+
         1PDzuBg+Yp2PLkuWhRYvERjmNaoaXZHN35NTWNkSnhvfCJH84aPmMQ3MbKIzz3hg3pPN
         ILWGQKXhf0BiXdlY7ogQ5QlTBmNm0nnvwrP5CE9lTmeSDC0+LWZpW8DbmmpFsVitRkYp
         BX2w==
X-Gm-Message-State: AOAM531gZ7IjHOgtiuezrf7mZaUCgbUghvKxeXreRIJw9mSYEYk2psYk
        k6CByOcF79nHhY3qj1myS58FmTcXwSqCSEWcF9Y=
X-Google-Smtp-Source: ABdhPJwWmISuZlLvg/eZFzILAtUu7k1PYO9oovDZzMbnnpilO+4Cvn2+NKF+d0RYzflu045t5yzyWbUibeaEmF99QC4=
X-Received: by 2002:a25:1842:: with SMTP id 63mr10639746yby.238.1613229202044;
 Sat, 13 Feb 2021 07:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20210120124906.GA8396@szeder.dev> <20210121025331.21658-1-worldhello.net@gmail.com>
 <xmqqft22w9v2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft22w9v2.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 13 Feb 2021 23:13:08 +0800
Message-ID: <CANYiYbHZsvGpVPUbtpm3fPWgnNaL32yUMk5B-rrm_NUkm9fXmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] use unique out file in t5411
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > t5411 has some test cases for the behavior of failed 'git push'
> > commands.  Even the 'git push' command ended, the output file
> > may still be updated with messages from 'git-receive-pack' command
> > running in background.  This breaks test cases which reuse the
> > same 'out' file.
>
> I do not recall hearing from SZEDER who raised concerns about "a lot
> of churn that can be avoided by a change in the code to die more
> gracefully" in his previous round's review.  This has been in 'seen'
> for a long time, so let's move it down to 'next'.
>

SZEDER's concerns about "a lot of churn that can be avoided ..." is in
this post:

    https://public-inbox.org/git/20210120124906.GA8396@szeder.dev/

I think current implementation of the client side of git-push is OK.
It's no necessary to add more code and more roundtrips for git-push
client side to complete the protocol in order to wait for end of the
server.

--
Jiang Xin
