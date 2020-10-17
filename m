Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B3C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 08:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74672072D
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 08:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg2V5Q0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437627AbgJQIJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 04:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437624AbgJQIJt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 04:09:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF04C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 01:09:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w141so5344310oia.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXkgqtfzvEx/FFaTF9d07XmFsZBxc3mMMlWjR6UiUPA=;
        b=lg2V5Q0Sz24q+YsoLwPeifQcJ5DRUtqbCm0v8Z79juzFiAAlHNBf73ezg8/odeO4L4
         RX+hFPNbbhA1Oqr4yLsQPtS1XbR+kkfzOGdhR9ouh7fFI3aXP33bOXWoPJ46zTdpWvaf
         IdZqIitvbCeXL2KbK2WsDIHiTjPrgYH8h9yE6fS9nlDPpQQOD4whgu4t4ZvugacDlmth
         HGelRVZnYxa6PDWltRK68YpqYJPt61CHT8pMHaSPYkmVtXpeEUwI+nuxGOE5FJIkFOZ7
         AdH7s3I7TjazlQf9+NGChvRIsfF+8yZZTSZQHCfvn0KAnLWyU4tFmRzMi457v5yLAaav
         uklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXkgqtfzvEx/FFaTF9d07XmFsZBxc3mMMlWjR6UiUPA=;
        b=irv+MrYDaX4OrbPNGPryAFKuV832Vswab+yEpjOZEWReKbYq/EK6TrDeP6j+IFkZmW
         y2e/cPf1gXgDvrpfeHhk14X60FkyQmbbyq8chhgrvrmnu/zJswwQy29YoXX3qV8EQg3j
         Sb4T3uM9UB8fvPlhYoSZYM8uylssR/YrN6E0baYk8UvNpNCw3vioU8V5xt53/+H1BtXC
         Tyg8UZ5m2eyviRSKVilQs/Gia5Ara0z8pybdQ8GcK5aduJjGKIvPjoRd058h1aRDvUSL
         5Lj1R8/rvHcUHYXQzIYLEWVlaojg76+gCh25JD99SQcldJ1/U5jG5JlGd5vheg6pXRWg
         62Wg==
X-Gm-Message-State: AOAM532WffIh2QC+GA/S0M6BvXw/jGwA0i2RW+Mnsmt9k06Sl5zgPm9+
        FjBbqfvaMo2/Gy2IwRN3RhAsYA66OGZYt5E+uk+MZ8+Cna8=
X-Google-Smtp-Source: ABdhPJwPWVe55m8m3PeeaAigltMZ4N3veD5lGC08JKXg7vGTO+56kQp7O93OOYcKQKpE9HU+g9+MaaX+wo38HVjcaAc=
X-Received: by 2002:aca:55c3:: with SMTP id j186mr4982492oib.98.1602922188711;
 Sat, 17 Oct 2020 01:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPSFM5eK1RFTbdTbF8dHMzcRh1SnSfzqh_5re22qS=KFoVRNJg@mail.gmail.com>
 <CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_DCYZGw@mail.gmail.com>
 <CAPSFM5cXN57z56Cvq-NX1H4raS7d8=qXEFDQqpypJfoYzbxcyA@mail.gmail.com>
 <CAPSFM5dxuEsGkFNTjCF4tLE611n1zLt2z+2JU03dORHxSK1i6w@mail.gmail.com> <xmqqblh3fgg6.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblh3fgg6.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 17 Oct 2020 13:39:37 +0530
Message-ID: <CAPSFM5dnV7q6y-CuCR90U7=fyow9pZ3dnViDjx+zFdFZ_s=hBQ@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 16 Oct 2020 at 00:46, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > Thank you Christian and also I apologise, since I forgot to cc the
> > mailing list on last reply .
> >
> > I have submitted the patch[1] for the microproject "modernizing the
> > test scripts" and would be glad to have reviews from the community and
> > will work on updates required .
>
> Welcome.
>
> If "Charvi Mendiratta" is the name you go by, please correct the
> author names and sign-offs on your patches to match it.
>

Thank you Junio, I have done the changes and sent the other patch series .

> > While working on the same , I got familiar with the mailing list ,
> > guidelines , workflow and also learned more about the git commands.
> > Next , I would also like to know how to proceed further and learn more
> > about code base.
>
> Nice.
