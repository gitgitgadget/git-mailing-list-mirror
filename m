Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD4BC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 04:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8AB206E9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 04:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPInhYi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCOEEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:04:53 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43080 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgCOEEx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 00:04:53 -0400
Received: by mail-ed1-f47.google.com with SMTP id dc19so17496556edb.10
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 21:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq3GE2CxFzN+ChD+G0lBAa6u2/ZujpCUMiYX4kXh6Wo=;
        b=sPInhYi/zMEN8dc0/QzpKRSHK1rIWdWz91AKbxgduMrmEbYONAy9BSeG5XMNrhfi1N
         jTbZ5bG+KhUpkRwbjn2S/UN7DHeqp/KPV2TwjcH4ONuyctrx+bp+9v9buSgBuIrAGZpb
         Va2pSTNGojsymrssm4U6ExeZOpBOcvlCQzwjvhH+wW1uTrNg8P2Llx4h4DCorFXugEl5
         Op1SYRqegC0xpkai402cxLfcWwp3KtQJsf/ePjHYG1o8W1WMdYbeWQDwBuW91z6IkB36
         Ypobj8V91Mutb+LTWI7EoQ8cHlj6TJEfMGS3PaUrN0gfqsnkoTj3xSotRB6AmPhQoFnP
         eiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq3GE2CxFzN+ChD+G0lBAa6u2/ZujpCUMiYX4kXh6Wo=;
        b=k4y05lDv/Gg7LvrTGdxJ8PoWeMu272xsXTpGMP1KcR8t9d1r7Y4LEp1xdORU7sgtRz
         q+Zx/fOeIczLtjUAink8MIPF5A+sXII048ZXvdSubNoZORR8LRGHmmuUMCEZs1RePSMy
         rH/V3v23vT5axGNItkAh4KMZ2nX5O9hAIlRtwsBLBhLlJSEYSLGXSQ7pXvDnMkpN5aDq
         k+1oIupa0p3bGR5XZDE8lSTGA9bbe7fHZtgTBmB4jecX2yxmUQ2lwphw8vzfEkx+K4Qc
         2J24xZGzcHNkuqrAw+lq98egeRqxMf8qvEnXFYmd5PSN4N5mjD3kZ+Vf8qjjJ9lrJOtA
         95zw==
X-Gm-Message-State: ANhLgQ1j4k7HRzKZ2xTLENu3cdvHcmJugxYQISg/T154TFeTQR+FisoF
        VW/rtznebnvWnz2ZXVubfPUxWqbWM2UowZ3ZOUCzr9aYqkE=
X-Google-Smtp-Source: ADFU+vtNVTT0kBYl+ZYjyni8OeCAJpylVEbiEbBBjpyCBjQkusHvzST8Tc1yw69dOYo1QQx8ce+WeGyZcUp0V7QmJB4=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr17502214edv.273.1584168246409;
 Fri, 13 Mar 2020 23:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com> <20200312175151.GB120942@google.com>
 <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com> <20200312230931.GF120942@google.com>
In-Reply-To: <20200312230931.GF120942@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 14 Mar 2020 07:43:55 +0100
Message-ID: <CAP8UFD1ouu1EkJjGYuzJahZNX+QW-XyEPD-2Vfp8jMYNuVYkAA@mail.gmail.com>
Subject: Re: [Question] Is extensions.partialClone defunct?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 13, 2020 at 12:09 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Christian Couder wrote:
> >> Jonathan Tan wrote:
>
> >>> Hmm...besides giving the name of the promisor remote, the
> >>> extensions.partialClone setting is there to prevent old versions of Git
> >>> (that do not know this extension) from manipulating the repo.
> >
> > That could be true of "remote.<name>.promisor = true".
>
> To be clear, Jonathan is referring to a specific feature of the
> extensions.* settings.  See
> Documentation/technical/repository-version.txt for details:
>
>   2. If a version-1 repository specifies any `extensions.*` keys that
>      the running git has not implemented, the operation MUST NOT
>      proceed. Similarly, if the value of any known key is not understood
>      by the implementation, the operation MUST NOT proceed.
>
> No other config key has that property.

Yeah, right. I was very tired and it was late when I replied, so I was confused.

> > On Thu, Mar 12, 2020 at 6:51 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> Christian, what would your prefered way be to fix this?  Should
> >> extensions.partialclone specify a particular "default" promisor
> >> remote, or should we use a new repository extension for multiple
> >> promisors?
> [...]
> > So I'd rather obsolete "extensions.partialClone = <remote>" and to
> > find other ways.
>
> I *think* that means "new repository extension".

Yeah.

> That suggests something like
>
>         [extensions]
>                 multiplePromisors = true

Yeah, I think I suggested "[extensions]\npromisorremotes=<bool>" but
"multiplePromisors" is probably better.

> >                                                              or maybe
> > we could have another extension alltogether like
> > "[extensions]\npromisorremotes=<bool>" and over time obsolete
> > "extensions.partialClone" altogether. I prefer the later.
>
> I think we're going to have to continue to support
> extensions.partialClone=<remote> for a long time anyway (breaking the
> ability to work with existing repositories is expensive), so I'm
> reasonably comfortable with multiplePromisors being a separate
> extension.  Some faraway day, we can introduce
> "repositoryFormatVersion = 2" that mandates support for these
> extensions by default, allowing us to clean up and simplify.

Yeah, I agree.

> I can start writing a proposed patch to send this evening or tomorrow.

That would be very much appreciated! Thanks!

> This behavior has been around for a few releases so it would want to
> cook until the 2.27 cycle.

Yeah, and partial clone is experimental, so I think it's ok.
