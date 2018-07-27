Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E491F597
	for <e@80x24.org>; Fri, 27 Jul 2018 23:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbeG1A7c (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 20:59:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43298 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG1A7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 20:59:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so2646923ybl.10
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHW81SiF5VCGYisJ5rGn+lA5PvPdaJIxoMdChBak6/s=;
        b=nZuPQmV0H+qKDcqD/T31F4CIxjIEGPbiHXb6w5ONK91KRuDd4uZgtm5TWSwZTH2DwN
         4QEZnjld1DRT5i6ZsqmeYzZt4sTNwRWTLLpKOHLkWpyHf921BOwziZDK6F3Cy/AevWgt
         PO/vbzL45zYiuRYzwvC1jeOvStrBj7dNrTSBA2yAn2Xphz6u65iC5kXKDns1gf6a86Vh
         9Bznf2uFXlFtd2kXfXrPw7KCcx8/2TyY6AW1aO6A386PYNl203uiiPTLezWhp9NfPs1h
         Uir1PLhS88G596zUUuCFXNPJlNFCqywXkyzJXtpgzZdlDdiSG9YGNJfAPYUBvhbA8LEO
         WGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHW81SiF5VCGYisJ5rGn+lA5PvPdaJIxoMdChBak6/s=;
        b=WE732GBJrwBNHjZ+kzATykQlg5I22jDDDYrstz5sIJy9bhrjC3IJq9aY7UzxtLBBhP
         hDp/saPfGYP2SZKO2SRL9si/nMukXqyBUih0Mr9IMj7N2Jt4SVHV5eJGhaBBWuPzFscr
         mRj2AE3JaIDOxJt5aO41X84sPOFkbGQm+uS1vcY2ogpgXmml/Lec4Vo8KIRTa89HJT7S
         F9qu3nHJG6k2eFa0APBlWOyh4RBYOdTuTAIgExVqdt7jE5N/CwnDgF1wkfwVdFPO7sJv
         b1dtarom22dfy+i3/gNZHp3k80Bvky32uB+R/1+4bTZUsGuwJV/sRrq3uJqLEm9+iVf+
         cVIA==
X-Gm-Message-State: AOUpUlGUFE3ZKW9ycO64xH2GStvmQkPp2AEKjmQlRw74dYaiaPDuiGE7
        LrSp3bqLYI0EIniavjrawIhdFoqEh/EcNiohUcx4WeQIxao=
X-Google-Smtp-Source: AAOMgpf4A1y0k3hUxNCyhODdmLjLYssBTWsxB4g1EbSVPOa5sS+4hmlr3JOZ2Ir2u1AOBypMzmjZocKMZ/x+n+xss/U=
X-Received: by 2002:a25:dc47:: with SMTP id y68-v6mr4381717ybe.515.1532734521856;
 Fri, 27 Jul 2018 16:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180727205117.243770-1-sbeller@google.com> <20180727212140.GA54208@google.com>
 <xmqqfu04l5ns.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfu04l5ns.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jul 2018 16:35:10 -0700
Message-ID: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 2:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Brandon Williams <bmwill@google.com> writes:
>
> > Either way you're probably going to need to be careful about how you do
> > string comparison against the different parts.
>
> Good suggestion.

The suggestion is a rabit hole and was a waste of time.

However I did some more manual testing and inspected the code
with trace_printf debugging, and it turns out the strings compared
are brought into the correct form already.

> >> +    # v.a.r and v.A.r are not the same variable, as the middle
> >> +    # level of a three-level configuration variable name is
> >> +    # case sensitive.
>
> In other words, perhaps add
>
>         # "V.a.r" and "v.a.R" are the same variable, though
>
> and corresponding test here?

I removed that section and went for a shorter,
more concise expression.

patch to follow.
