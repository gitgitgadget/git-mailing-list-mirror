Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68295C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 13:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2083323380
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 13:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbhATM7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388001AbhATMc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 07:32:27 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0BC061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:31:47 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d189so24795844oig.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OXst9burjnpEQSq/OEiZy2onkNVe11HBqO9FTRdh4k=;
        b=pVXCNSOKu6jmdJ3HVr03xwAVpXDCmv5svsBbNXVju2AMg203bP9J1g/I6VfQj0vYJm
         LROdlpR+Jv6umsEZbQrAkujs2moOUfxCsU+hBX0NQltj0HCKf8KJaK80viDnJkKrvXUX
         6fdACJyuXGlqjScFzomjackJVHWk3ysIw/Qi5eIS7oFcccuBnHeRAoTKaK8w6kvSpDVn
         51Dt6fUDMF+2IbCII4q7Pndtoea6mJ1VKCx/s5E3K/8q5zJG9pVWVH+gtnRDy95ebjiF
         I0LhvX5tfstGXzFMTnBhi3WqoBxpUGMU0owTMxWfmb30nP32Lm6hrkEkwFyaUOMqFNWz
         v07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OXst9burjnpEQSq/OEiZy2onkNVe11HBqO9FTRdh4k=;
        b=LmeJorMXsQ5KO86kuXvgHq2ALPDnhTf/HbWjVa332/6poetm6155JxTmYLToHnH1ba
         tnIeF4GrpEgAd0RhSjT65Q50oVQmXnEZeuSesDFD9+vdg9ZnoAxwD2gT1cgpsgcYS4Ow
         c60K5xVmfElxpMjXNeFc9lpRv/4lbjpzurql3CHwauzF2Ae7LCU5LjKjnMJjfpD6ytGS
         6vsBTDFIGrW/xr87n/tIw7WC9A1/+N+jgQha3ObPoJ2CC9RKMYeTTzewyKN/rneqfoQD
         9U6o4pvTwBd3jVOkhkzvKdHzWD4QhGzvGuCEWN3aJigz0R8rf0K3YHuvwFDs2Fiw5qP4
         Wv1w==
X-Gm-Message-State: AOAM532xcW0eCaxg+TjKXwonv5aW4A3mAj1FxqgdScimAJjC47/ccg6a
        SO3O9FFEslkWu4ZYwiVK/JzT23INq9pFFEEGCy4=
X-Google-Smtp-Source: ABdhPJyuodz+CtZS7HkDZ7vq/Tx8bMokNeARqtYQT56zsPe4aL4vNrty5nsPaoCZQo7Ky2UVg1+z8MhTwkVNZkQ4NgI=
X-Received: by 2002:a54:479a:: with SMTP id o26mr2691665oic.48.1611145906354;
 Wed, 20 Jan 2021 04:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com> <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
 <7c11da69-d2f1-0aab-80bc-d8ae8735f8ca@gmail.com>
In-Reply-To: <7c11da69-d2f1-0aab-80bc-d8ae8735f8ca@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 20 Jan 2021 18:01:35 +0530
Message-ID: <CAPSFM5f9JJk5xY-f2mNwHjZZfo-=LzSCpA2Q73T-ASGMxfqqeg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 20 Jan 2021 at 16:34, Phillip Wood <phillip.wood123@gmail.com> wrote:

> >[...]
> > Similarly, if we have sequence like `fixup -c`, `fixup -c`, `fixup -c`
> > then also it will fixup
> > up all the content and here it allow user to edit the message, so
> > opens the editor once
>
> It is good that we only open the editor once in this case - I'd not
> thought about chains of `fixup -c` before reading this. Do we have a
> test to verify that the editor is only opened once?
>

No, we don't. But I also agree, it's a good idea to add a test for it.
I think may be one sequence with 'fixup -C', 'fixup -c', 'fixup -c'
and the other 'squash' , 'fixup -C', 'fixup -c', is sufficient for
testing. Or any other suggestions for testing it ?

Thanks and regards,
Charvi
