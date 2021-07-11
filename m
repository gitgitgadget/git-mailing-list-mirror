Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9881C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C161351
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhGKEzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 00:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKEzF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 00:55:05 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D81C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:52:18 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so604538otl.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpaZL2hG/zxxXjkxrD1mzglhNzu6BhCbLjDnytpX3qs=;
        b=qiN/C/3bzer+eKQVYoiObljmUExEijkmoSFc0+H5/avvAJN/38vQz/de5p4mj7wqV0
         mn8SSs8cgYOh3l9egIFeRffDqVy5KfzLXpiGolDux0lQMuF43YoiLEJFk6+oygQrlRxx
         3O19+0009N1176vsoma5xyVtA+LMyZEMyxUilrDD1I0skAEqx2+nGsNbMBacbHNaf7Da
         moxvfC9DvxuAGyEEYwvZj0EWRL2ffMN4fxprckFEuU5Y2NSXwxbTe0K1PuPGrdGIeKHD
         dKI4NKVBPzq0IxmoqIIH8nCBSRrXDCPtMFUKByKrkpziafTpVpj/VvRuHfI04uOunORy
         bqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpaZL2hG/zxxXjkxrD1mzglhNzu6BhCbLjDnytpX3qs=;
        b=msDwXiPYqDdFbg1anewTjBBeSlJE/T8Er82LO7Ek9i49H+SWQJ6DQiAw6FHLZ3QSND
         bt+QLn0gQfHs3gWsAy2E9/92O/x/N2vpUqfCx+9P6aSbUuU88ot6TP/lphoyeBkSGr88
         OxQP2+y++69Xr1qHdCvCvO8SLnlxaFJ0Ey+hO6MqB9GUXzOmTAJ7IeJ+n5jyv/VTliGw
         9iFozRP08+iUb6CUT1UUhj/rxubFGtN7foverj6sA7clHaX7PfWv40xN9/Do7atOCu9U
         YCuimXMukuQAj+YQ1R3j1yYIXD1VvDnE/bahOJcOHU2hOUQX/B5o56AcRN6qN8hOvsNr
         l8vA==
X-Gm-Message-State: AOAM531KgCRywsN6Dml7eVECeBaw2GRH5TvHFUbAhvjQukJ+r2vn8Nmj
        6KqiWK3P230ZIWaThwIQrlEYFXPhOoQqFVlLWpo=
X-Google-Smtp-Source: ABdhPJxt6mY/v/cXZIBfVARnBiE/CKBDYOcONT0meNwewZWEB/F3FmisT5R/9u6DDpbtT2iZU0H5jYYiSZkdh+uUBhg=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr32095661otp.316.1625979137374;
 Sat, 10 Jul 2021 21:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
 <450310cd-7b01-58f5-1f74-739d61db97fa@gmail.com>
In-Reply-To: <450310cd-7b01-58f5-1f74-739d61db97fa@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 10 Jul 2021 21:52:06 -0700
Message-ID: <CABPp-BGQtYeRtK77=7fn7xJPPYV9h=duroTw1tQqbz-9-BXP=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: clarify documentation for rename/copy limits
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 9:37 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 11/07/21 07.46, Elijah Newren via GitGitGadget wrote:
> >   -l<num>::
> > -     The `-M` and `-C` options require O(n^2) processing time where n
> > -     is the number of potential rename/copy targets.  This
> > -     option prevents rename/copy detection from running if
> > -     the number of rename/copy targets exceeds the specified
> > -     number.
> > +     The `-M` and `-C` options can require O(n^2) processing time
> > +     where n is the number of potential rename/copy targets.  This
> > +     option prevents the quadratic portion of rename/copy detection
> > +     from running if the number of rename/copy targets exceeds the
> > +     specified number.  Defaults to diff.renameLimit, or if that is
> > +     also unspecified, to 400.
>
> Why not just defaults to diff.renameLimit if the default for it and -l
> are both 400?

Good point; I'll make that change and include it in the next re-roll.
