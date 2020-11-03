Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B3C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 03:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E23207BB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 03:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=barzilay-org.20150623.gappssmtp.com header.i=@barzilay-org.20150623.gappssmtp.com header.b="kN2cl+u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKCDOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 22:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgKCDOC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 22:14:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8380C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 19:14:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id j24so22037367ejc.11
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 19:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Jt1HQJhLfq7D9hTgbhrbcygC+EqbzKz85l5NMxSo1E=;
        b=kN2cl+u0TaARfm/bwg/AnD4R5Md+K3IeD756HIIld7Mb+vioF7aBDVi4WiDlZkd2R/
         ziQWnAZ1FWV2HD/mgKnjGrwxQY19LVpIeNt8HXz3qB3uXBPoWibevoMLCv2SXBVHZGyR
         pSinz2gfpty1CnKFiZwvGz+obqQ3INZow4mwBpSO4Yznbi3n1qp6eiX2ijEaIVaJQ0tx
         oXT7AMSzmh9wLNIV18VsEVSRcs+3HZUFSBdSK3F2ew4SW3oU/e+JYnqvSBWaQk+ejW16
         g6WCHlQXqECLMFJGfdx6VoXBdBp4nOaOBlbLeZzp3jFVM/ikFEOiqOsPvx1jDh6picxI
         htig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Jt1HQJhLfq7D9hTgbhrbcygC+EqbzKz85l5NMxSo1E=;
        b=Mmkyzt8beyOyg0NgbopIPHTRxWxvfNYJ9Qf6Etbp3Lnpqk795/YpLBy3b8MuVdYWmS
         s4gRnIsxK8KmiQGBuX97V1TVaRwQFhTepX5YaEV4Lr9HUcNduU2eSlCTNs2GJJMhoDd6
         FGE4Yt7crJKmEtes7vZZTahyXZUXCWWRcXhSiwnWNHsHYfGrZTlJEVgJI4ZtTkQEqMI4
         Koamfdte82d2tcbZeh7YIa7VkUiylXroq3MU5C0HcwbRpmb3v5yN//tajdQI73Gx2ltH
         OLQUpb7SR6mZ6TkQFmEa/HzUnYW3XPYnJ12MggLEKkhcyPuRyKi3+6ZH5CLKIEfgkUpP
         DAAg==
X-Gm-Message-State: AOAM532sPBnhUbaJOeB3T7Q3A15IQeI6+K4P3zz7MkYIA6IaeUWgxmqe
        j3CqnEpeglqDFUFF2coXtMvonrJyyrov/eh7tYkzurfJ2UXq8A==
X-Google-Smtp-Source: ABdhPJyYiUARiTAmNjDDXcgiOxfHGuwuuk6B9tOcu6dmLZLXwerYiaQ7jixuF6Pn3NHBLd9x/E3aTGBd2PFlsFrhsIQ=
X-Received: by 2002:a17:906:b312:: with SMTP id n18mr8781685ejz.353.1604373239332;
 Mon, 02 Nov 2020 19:13:59 -0800 (PST)
MIME-Version: 1.0
References: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
 <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de> <CALO-gusRt4J5ar45mo7un-EENyt5cX2SQvcXgyMmaHNZg5bFUg@mail.gmail.com>
 <xmqqlffjs8ws.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlffjs8ws.fsf@gitster.c.googlers.com>
From:   Eli Barzilay <eli@barzilay.org>
Date:   Mon, 2 Nov 2020 22:14:07 -0500
Message-ID: <CALO-gusFac+GNrB9Rcbqteyv+gs5h0A-PTxnwRswZMhTnNBFyA@mail.gmail.com>
Subject: Re: git-diff bug?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 5:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eli Barzilay <eli@barzilay.org> writes:
>
> > How is it valid?
>
> Just this part.  Any patch output that correctly explains how the
> preimage text changed to the postimage text is a "valid" diff, and
> that is how Ren=C3=A9 used the word.

To be clear, the "valid" in my question is about the correctness of
the expected behavior, which (as I disclaimed) is likely a problem of
the text that explains these expectations.  If validity is only about
the correctness of the resulting transform, then it is obviously
valid, as well as the other alternatives that you included (and
therefore this is not the meaning that I used, otherwise I wouldn't
have sent this).

In any case, I think that I now see the problem: the (sparse)
explanation says "Ignore changes whose lines are all blank.".  It
would have been helpful to clarify with "(but blank likes that are
*part of* a change are still shown)".

Thanks,
--=20
                   ((x=3D>x(x))(x=3D>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
