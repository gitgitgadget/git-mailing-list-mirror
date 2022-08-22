Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D39C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHVHqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiHVHqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 03:46:24 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78679A1B1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 00:46:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id w188so2194570vsb.10
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2C09atgW8mOfZeF+6mU5n17g8UrcEvOhT9n7hpYuZmY=;
        b=L948HWgtrF0udzFN+t6VVI4nwEQqLX/yL0ibW74Cecc3weKOq1+ugqIcz/T89POhaG
         8vtuHxDAzREtxhZq4oG8FWOCNhy1pW/SsQRdSkGbnSzv6J32KZfoOnFKjVD8Kc3KYJbj
         vWqoHfbZ41kMykD7EZwBXSZuM8twlEU4NeoNRjFHUXA10ntGZYFhebMOYdJ+Wd+/eyxH
         x3ieuW1i6zQB5pa1cK+que/h6Fxa7ExVu0cISoDojUgrpBRPFE9jSFfc6qRt6CzLljy7
         Rbiiuoo/MpQv/I3R2q5vu/IF8aFXb3mH9WixiD7swHGmHZL518yZUzx2w37PGsHTAAEs
         lt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2C09atgW8mOfZeF+6mU5n17g8UrcEvOhT9n7hpYuZmY=;
        b=ler0caGbihdAUg19u8wzdFYOixt1ImHojtpHW5kbi/wjhcq4BhRKMwtevZ15EOt/hr
         eloPH/3i8ZJS5dMzQ//zyAccq3YrdhKaZ9RYqzUy7RyGd8yZUqfB7Ug24SAWWepvUSJo
         CHneg1YTUwYvXNNjITkEoVCsThX3nkHFtRNzAdUJppgV2TJXr9UPkCtu+tHBYZ2hu+vi
         Wevw9VwX5Ao3w4opD+KRaEKaOvHG46L2WOy1IsD+cUYjcdUsyhoUqZ4wEcuucxAu5Nnj
         B9DrdG01kUQeF+rB2xrjXifusL6a5C/pozRKwYoB0LotGdVZaCF1J6vN4Ot/iQbZCDJZ
         vZrg==
X-Gm-Message-State: ACgBeo0KicIt+ZK4HMtjolhzVgQOnHXwxCS8AMEhqMoEMQeTnkkmDkoV
        MvBmNrplzp4sPiw9R0lbDvuoKdPvcdv+KqVg7gxYTgFQUd0=
X-Google-Smtp-Source: AA6agR7UaYvpel9pUkaFfK0SO5AjJ/ZMTr7n1oUfBsF9e79CYQUVZusVCZJOg0cZiCW4YuTnx5kJLwGbvJhFxn/4pgs=
X-Received: by 2002:a67:d905:0:b0:390:57db:659d with SMTP id
 t5-20020a67d905000000b0039057db659dmr1494443vsj.31.1661154381525; Mon, 22 Aug
 2022 00:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net> <Yv9P4O3WCrR9f9o2@coredump.intra.peff.net>
 <5f10be7e-424a-ed3b-bb77-75f1e026b2ae@github.com>
In-Reply-To: <5f10be7e-424a-ed3b-bb77-75f1e026b2ae@github.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Aug 2022 09:46:11 +0200
Message-ID: <CAFQ2z_PHq6wFbZwiRnpS4NDmUu3nbRyhq=302Pys31mPa8VTew@mail.gmail.com>
Subject: Re: [PATCH 5/6] reftable: drop unused parameter from reader_seek_linear()
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 9:06 PM Derrick Stolee <derrickstolee@github.com> w=
rote:
>
> On 8/19/2022 4:54 AM, Jeff King wrote:
> > The reader code passes around a "struct reftable_reader" context
> > variable. But the seek function doesn't need it; the table iterator we
> > already get is sufficient.
>
> If we wanted to make it seem more like it was a method of something,
> it now looks to operate on the table_iter, so the method name could
> change to something like "table_seek_linear()" which might satisfy
> both goals.

+1. Name should be table_iter_seek_linear to stick with naming
conventions, and should move to the top of the file next to other
table_iter methods.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
