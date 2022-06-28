Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473ADC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 17:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiF1R2p convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Jun 2022 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiF1R2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 13:28:43 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1640B23D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 10:28:43 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3177f4ce3e2so124494467b3.5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 10:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wgmnxfkTx4UiiZQppbMQQ5wXIogFOWwbnlWfEW33Hzw=;
        b=dS7SCMUqv9T4+PEG3Js+sacE79Rro+c9jXoazjoghB2v5yUGd/SUEvyoTz7932N4H4
         xGxCdhm3RjiP/vA9GKT/M1SQw1u8lmrGK89Ew9RPW6GoakW3dEri/dZTKVO3Sko/rOJ1
         iYqaU/8EjdXdxuNbIAV8W1kApE1pX9pgLU+QwQE9WPBT/alGciVmuwTg0J/S1mDGsmCT
         +IIdF34XQaOzU1uhlviVtNkAusokmMkYZaVavAghBZ/zKetJ7bchhOmAdUV+XbV+ybWn
         g9Mv/3K4Yk0szaH1zYtIxwOsSJvN7+cv69YHYf+4lNTgyKh7Y4pB6Yjvq8buN4INZCax
         +D6g==
X-Gm-Message-State: AJIora/yPVBrZVnSZ4mWHXADqq4VlWB2kqy8Kx4GhaIFbKc23DJzqaBh
        zqndY6Q8PshmwCO3IqC+NSaiNsswOyoWwxdNKOA=
X-Google-Smtp-Source: AGRyM1t0dX2Lg1u9t5J6R7igBC9LnoYrzuqV0Q4Gda7yi7hKpjzEZ8/BEB2uAY03pKqWPgIVzOMRjAbLpjNGHRR52Uc=
X-Received: by 2002:a81:5857:0:b0:31b:8e8b:ded4 with SMTP id
 m84-20020a815857000000b0031b8e8bded4mr19631968ywb.70.1656437322242; Tue, 28
 Jun 2022 10:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656403084.git.dyroneteng@gmail.com> <065b7c9ccb5a412526a934f9b67c8be64a40fc7f.1656403084.git.dyroneteng@gmail.com>
 <220628.86sfnpf96x.gmgdl@evledraar.gmail.com>
In-Reply-To: <220628.86sfnpf96x.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jun 2022 13:28:31 -0400
Message-ID: <CAPig+cR9XL3dRuRrH9kCrqUqu5HwAJstgkp9eTJVBZ0TBZ+Wjw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, tenglong.tl@alibaba-inc.com,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 5:13 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jun 28 2022, Teng Long wrote:
> >       if (bitmap_equals(result, tdata.base))
> > -             fprintf(stderr, "OK!\n");
> > +             fprintf(stderr, _("OK!\n"));

As a minor additional bit of help, you can use fprintf_ln() from
strbuf.h which will automatically output the trailing "\n":

    frpintf_ln(stderr, _("OK!"));

(Aside: Use of fprintf() here is a bit odd since there are no
formatting directives in the argument, thus fputs() would have been a
better choice, but that's a cleanup for another day and a different
patch series, probably.)
