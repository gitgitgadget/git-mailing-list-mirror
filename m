Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FADC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C4613CC
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 08:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhGAIVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhGAIVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 04:21:31 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA8C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 01:19:00 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id x12so3334170vsp.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KqGdjftGXyhKVB7dLAKX/1BDqGusInZ5MimjSG1GYNo=;
        b=jzq9gvv3kmOlT66JbJtrqHfIWPIDuiVlxe/zyhN70G99UDewF20GFhm9ArRGpVazq0
         kkoQIj//VhfzcHTmIdRAbGfVAu7tL+dz3ROXRTVkK25mvLcb7N4ptMDOASpfKdi/yWQ4
         +4/1J/qJeonEbSISGEWJodHwETk+ERELbbFlH7MYjdAVbT4VZ/CxDA6fyY5jzpYc52zs
         TKMlOMAdFIlMDGc8ZVeqE+BlXPM2c3AlEw9m+bx7JivlVAAcEJyLES4hugs+UA4qTges
         96jSpDH+dAl93u07uzlq1aOQEd3nLxv7C3MrewHmtJJaFsFSerh9uJMFXWcBV9ejWoAL
         6/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KqGdjftGXyhKVB7dLAKX/1BDqGusInZ5MimjSG1GYNo=;
        b=AggfSYUZ0vdKzQ1at9jLRDCiaQovnhidalD8DaXo4YIElCB2Jm8D//eHwLSNJtHbgd
         tWKylctLhnc+6h8ZbRzkx4r3oAdTiF2kCkwLqmELitqUDu6j9UspqbY6gYisiEX30/sJ
         8Iiq3J9t6hcjezF5CSN58uW4ABQcPHF0GnzsjKXifFaEUHfxFtFhQgPT7l20GHnMhyNW
         72OVxtDZQnH54POOE4MnHE5quIiMSP1smQpejKDGw+MXS3m3T5JXfPoqmrPS8sNGCMPO
         l2HPGeAKkev4FeysrsqBZC7tiVwSNrfgIfSHQyBDosCRQHd5OFogrtDz1DLYYCBTOUCJ
         hXuw==
X-Gm-Message-State: AOAM531FG7D4crGFFGzghxFOGx520/qnFKhNm4K/Es/wLj+U7GpqH9yi
        rEwd953Eggo/Ji4PHzXznJa523qfZsejlFr7uowCbw==
X-Google-Smtp-Source: ABdhPJzbwYxWr+wAEyeS/Tqksxqm50DyH8D6ELDhLjnc8TwMGoU12rtVHZlKy2DRUN0G6LfUcuu2tcM2eZal5iZ5XNQ=
X-Received: by 2002:a67:7fcf:: with SMTP id a198mr27700844vsd.50.1625127539127;
 Thu, 01 Jul 2021 01:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
In-Reply-To: <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 1 Jul 2021 10:18:48 +0200
Message-ID: <CAFQ2z_MGJ7Qo5fq7bnwXi3m32iVeaC2WfdsKjRW0JO4Tq+M37Q@mail.gmail.com>
Subject: Re: Structured (ie: json) output for query commands?
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 7:00 PM Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> I'm used to automating git by parsing stuff in Unix shell style. But
> the golden days that gave us Perl are well behind us.
>
> Before I write (unreliable, leaky, likely buggy) text parsing bits one
> more time, has git grown formatted output? I'm aware of fmt and
> friends, I'm thinking of something that handles escaping, nested data
> structures, etc.
>
> Something like "git shortlog --json".
>
> Have there been discussions? Patches? (I don't spot anything in what's co=
oking).

<unpopular opinion>

text parsing is fine if you're doing a one-off, but if it's anything
that needs to be just moderately complex, robust or long-lived,
writing a proper program is a better idea. I'd recommend either go-git
(single file programs can easily be run with "go run"), or Dulwhich
(no experience, though) in python.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
