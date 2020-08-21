Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C51CC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6386D207BB
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTxMDzKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgHUQ24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgHUQ2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:28:49 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6AC061795
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:28:23 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id b26so1101120vsa.13
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC044wAJ9M/wh1gfwzFGiYfS1czFGXnJlhZ8Iaa7gH8=;
        b=bTxMDzKs5iOoCVXVBilNDpid/3VSAtdj2uBQvDCPfNLrb6FPRXHG5R2V70u3idQyXn
         te765vaj4L6AdbSjgbwt3jP4ITG5eiG9JhHuefjY9a89fnCJX8n3PimzdNsDfZ1E0csr
         +9CQaUUG2LfNOjySmWfTsYBUWn3+QzdfHn424h0lRHkObgkDpRKH+3Af4jykAEjAGdPP
         AIaF0b+e0AMm8LZWqNXpYOnZRdHe/RYqM8rCgeIxdSiueFwI+PdLNfqx+rx655pSwsDo
         7HNSNzV0nMgYe/DmO/X/t8rMVxRj5qPwIr3KHgBoigg0GR7R/XafxFOMk2xOhuU6Fu/o
         0wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC044wAJ9M/wh1gfwzFGiYfS1czFGXnJlhZ8Iaa7gH8=;
        b=MC/0YyTGH/UBx9yOybNcz4ifInfwu69HjDlJS7pPt1tAm5iVyp15QMgaPWfzf72Vh+
         uNpTld/S+4TELnOIFPPEz5yr1OWc8n22dFMKMZEBp2vhtbEB23PXz4j6IBcNmrX5I5DC
         YGdJMfQby1PgeVd39C/rSrRq+msXZ7Y5LT2ZTFIwjyfTE2RIQobNFum5Vj7PMkbzcm7A
         3qpPBh8CmbzoXAs3/GxvlV4rb2jDBv58eItG9UUV/OHHYeYrxvrn+uBjKQBRtVh2nK3P
         To7Y2tBvVbgT613ffB6hprTLuWMhstNmtyUb/4ckzkhRqvdjlD4w72xaWefRIBIkfXlT
         kBUA==
X-Gm-Message-State: AOAM532tdWZywr+pV0TvEyqd+zxjw/JKUXwK/1H6klgOIFB7MKMpnlZc
        pFJSXdR4eqZG/QT5vmujRs2BsROyzSd0BwVzoRw=
X-Google-Smtp-Source: ABdhPJwdabrKd5IROWUnKnMshGijL6s3XTSF6cWEjididyyV8ei/As4xL9ka4FAK1+UmiCv4Jf0YQ5zFz+R1xk535kk=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr2447496vsn.54.1598027303120;
 Fri, 21 Aug 2020 09:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com> <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
 <20200818174116.GA2473110@coredump.intra.peff.net> <CA+P7+xqfAqnoKBeOiO6f7tdyi_7M=wKpmnFoWBt6UHbOqbYCzQ@mail.gmail.com>
 <20200821023335.GA3124022@coredump.intra.peff.net> <xmqqr1s09djt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1s09djt.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Aug 2020 09:28:11 -0700
Message-ID: <CA+P7+xpc_jOc5kQ3eicSGUEO+GSr9a3fZ6TUyeEPvy+YSVdGNg@mail.gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 9:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Yes, I'd agree we should be applying the negative refspecs first, and
> > then de-duping / looking for collisions. Which I think is what the patch
> > is doing currently.
>
> Good to see that we thought this through.  The reasoning deserves to
> be recorded somewhere (perhaps a comment just before making the call
> to apply the negative refspec).
>
> Thanks.

I am hoping to add a test case for this as well!
