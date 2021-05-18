Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14520C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94246109E
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349519AbhERNT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhERNT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:19:57 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB7C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:18:38 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id m129so2039447vkh.9
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qhJBVa10QlawsRbp9O6G5F4Jhbw28sVAgFeDa+A8K50=;
        b=C7AR7ty3YhDUl1syFNhKdQNLGsBoTDsMgxkc/1wN7wNyUIcgTsoPGGmAD4nD2Ttx4v
         lkq9EY2RiBoAGkgiWhWGwaQQ/qJqpkWTGOgOlFifdNOWBVCHnVq3O5aCE1n/5y0Mp8Hd
         +pqiPdfXjvJPJxgJ4aLb2EbmF8p8ezeKIOPA3oM+feZgRJjlCsw6WNcTSilwA0M+9BJH
         FoI5bxw+fEsGHOMb5DJqVEK7IvPtz7g14EQuEq/2/rp1JUlCRfmRSWX85bxWUWfctBvX
         GmXPX2VYlYv7xYKAhlCAWRLWF9pUorqtnEFlg8dNFtcccMdddVZ1kZLQ5Eb/dNBmFfRs
         kpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qhJBVa10QlawsRbp9O6G5F4Jhbw28sVAgFeDa+A8K50=;
        b=LgBClaQiH6iwkgAJvXoe3OUi6+9eXUc2K40vZVfzE31gSiAg7ktqZlQMbCbmibp+XD
         aC7mjvtuUAmH2s3YwldQHF6MoCftNS1kCm2+ZT1dj+0pi0XBNKMShGHfrlG7P0vVq9ZP
         jlDmmGwomhMJDyAlnZ/Kmhzmx/DZoUNo7fX7S4cSSGVmZl6i3QkAouGfh3jYdQ6wyz+3
         vEcxctgq7TkawIKCYrmQTfS+OwBH/aoalhfT0GVYpjXUpoRCkIR715WBM/7QHczsEBa2
         xm4cRNPvKO7lzWFA3bjjQthWc7AKaDsgSjLMQGwsCGaTtScNevQTKiX2jXf3bg50TD/v
         x98A==
X-Gm-Message-State: AOAM533Serx+QuYWfh87pEFk4IPg5ys8lYkPhqOsMGIdlYYblq3SLDHx
        izjcy9NbfZ1et+w6q8vHaYxk//smLAfh70Rpk1wyjA==
X-Google-Smtp-Source: ABdhPJxl7McbZi9atzFwQtJ0vLsUok61Qk+mUowE4W1cNgV1Y4ZBOJJnPxBZa5RcOcYJNTMMjFo2kKE6v1rYySN+rTU=
X-Received: by 2002:a1f:5687:: with SMTP id k129mr5903158vkb.8.1621343913851;
 Tue, 18 May 2021 06:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
 <f5711aa9-e70f-8bb1-09d9-4f283b010d46@ahunt.org>
In-Reply-To: <f5711aa9-e70f-8bb1-09d9-4f283b010d46@ahunt.org>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 18 May 2021 15:18:21 +0200
Message-ID: <CAFQ2z_Os02GHCcPX0Hcin7+va232Di5wFBbdbOBqEehJvTFbFA@mail.gmail.com>
Subject: Re: [PATCH v7 23/28] Reftable support for git-core
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 7:24 PM Andrzej Hunt <andrzej@ahunt.org> wrote:
> > +             } else {
> > +                     oidread(&old_id, ref.value.val1);
> > +             }
>
> This seems to assume that 'ref.value_type =3D=3D REFTABLE_REF_VAL1' - but=
 do
> we expect to have to handle the other types
> (REFTABLE_REF_VAL2/REFTABLE_REF_SYMREF)? When I run tests in seen
> against ASAN I see the following errors in t0031, which suggests we're
> running this code against REFTABLE_REF_SYMREF too - but I don't know if
> that means that this code should be able to handle the other ref types
> or if there's a bug higher up the stack. (AFAIUI REFTABLE_REF_DELETION
> is already handled because reftable_table_read_ref() already returns 1
> for deletion, but the other cases seem valid?)

Curious.  I didn't know it was supported to create symrefs in a
transaction, but I've added an assert to make sure this doesn't
trigger any sanitizers.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
