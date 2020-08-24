Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C2AC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA062074D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVHsj3E5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXT0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHXT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:26:33 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F9C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:26:33 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id a13so5067497vso.12
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQp0WjFlG6BkUa5JA3S0Zd5kEBfC+GVlPWKZ3EWwTe8=;
        b=YVHsj3E5/4Cc8EIABXR1sam+mCgS022FCTJwHtLLVgH2mlVhX2GKE/67L2W1xRaPgU
         BOVrZV/DkNc84xVeh1iSDj9wvKtkraKNvkI30cyR30XOydfxqcvRpzYXiqFqwZlyBv+Z
         x7WYnm9UWJftgKT2UKjdQrLXuBcMfzSVmUNOUcsEaYb0b/QnLYUGORDUFL+sG3b1840t
         m+3ZJBebqyE2nbBhKP/mzeLYnaXFQJBvLWeisj+UN4buAcPx3qUrsmUHEZPnwDXDZ+Wt
         +FTa/fZlJbNjLHnkhQL2dFRw0edswh3W+vr5nIR7JazDGe3yAsUjFNx/sVc2ErJRNQqD
         Lc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQp0WjFlG6BkUa5JA3S0Zd5kEBfC+GVlPWKZ3EWwTe8=;
        b=fVwkHdwyeYuhCKBqwFLf/NmZ+zqge0io3mh3+DAyJtUXlU0j4bIt39idb4zxUwkdXl
         +m4DL9p/liizhrjM8FQG5EA8bjNnuhxQ5X2tZmODygyywV8lGIzxEvTdpl9GDbV4r84X
         SwvQD7nxCRk+G+tn/tWBIyaG2aGGbzjddzhiaxG0Z+881MuPRYtFLo8CbESpZHhIDvEp
         VUURGrwe8vpweMWfCqa1w8ZzTBkleVDbUn7uisalb7vUmRKVl5Y8l7hABSUHqzl4uHHy
         fcncRvo3hMSjGCB/m5VEpnHZNkg9+TY6KbBJAdTAoB5skhmuiBIXmTfx842nHNgOOEnF
         Cy9Q==
X-Gm-Message-State: AOAM532QW0cu8YslcgA+kmTOvGgR55waDzVVT/nSr7tRTeBuwVHrOiFF
        1yN7P96o4x5V0ESvEzzY/epHKHTy3G4AFVeecIg=
X-Google-Smtp-Source: ABdhPJyvGb/p+DbTY4lvEMHpOOsrmMlaVdIk7fvb1GtprQ3xlEH/M8ovIfmeRgdCg1t1VuktqYBbX48mTZRYodOoqB8=
X-Received: by 2002:a67:7d8b:: with SMTP id y133mr3772668vsc.87.1598297191644;
 Mon, 24 Aug 2020 12:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
 <20200821215247.758978-2-jacob.e.keller@intel.com> <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet>
 <xmqqk0xo53pi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0xo53pi.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 24 Aug 2020 12:26:19 -0700
Message-ID: <CA+P7+xp_ajhC_vN0jLY6AVS+cSgLNK5SeybxSwoT16ripUdqkw@mail.gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The `?:` operator is not supported e.g. by Visual C. Let's not use it.
>
> Thanks.  IIRC that was GNU extension?
>

Yea, probably.

From wikipedia, [1], "In GNU C and C++ (that is: in C and C++ with GCC
extensions), the second operand of the ternary operator is optional.
This has been the case since at least GCC 2.95.3 (March 2001), and
seems to the original elvis operator."

Thanks,
Jake

[1] https://en.wikipedia.org/wiki/Elvis_operator
