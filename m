Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85E51F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdHWWAD (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:00:03 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38604 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdHWWAC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:00:02 -0400
Received: by mail-wm0-f47.google.com with SMTP id l19so8111435wmi.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UIn+vcMOuPqtvMR7BemNl2XTauRYERfTeMRdXR4eVyY=;
        b=pwBuwZcpTWKwgiBWpvb2nLWO4UKtIlb+9s+wK3ZmqA4hA/aP8M509QHrXqhijmFIsv
         hENj5bRDT+NrIrjfaHyYrZWStf6DOwvxfVZvUgSqJreor5yW4hz17H1gzhx5b/CVL3kE
         IbKue9dckPuvM5lLjcLFAzRI4Lpi9QcDNrx8IFbrBS0ResAxqdFcIIgVWnYAdLwfC/fp
         HX0fQ3GppuDeGUNGbDnqF7Y8vQBsY2qaJVmyfPVPgmwkC6BJocprUquJ9TfT+WOenC12
         88j82ILrgQUTceR/cBmlROR4t0EtSK8jhoRlAU3ChOnhpsdZFj8Bir2kUH1U6xGmeLrR
         XQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UIn+vcMOuPqtvMR7BemNl2XTauRYERfTeMRdXR4eVyY=;
        b=qruVA0CH26X4c2kF3CEYhcuNDmcwp4s53KzqCm8br1PfsZO/90bKG0Sd32E+SAT6PU
         OdRBMj6KCkZR/K/4U8yFbUfz7/+01JgHKiiDsosS9h/5ghjBqseLkN2cPSUE5VxEoUiY
         5R9hH41f9bAp2w9mc2Gw0hFnfOK4pdV1411RfsTdN806nkkwmeMGm8xl251Z74ofjlmu
         sNEIaE9NWt8++ZR5Ti+luGaqzPnFjMccwgprrpcuWNKBl/RIIodx5sIpcvGvpYHucR8v
         AweVM/j5foiwgOnHuh3EFwyNxQZ3RtMMAMTTfG9fnhziLcp96cITr9zpQtWLCuER5YKW
         iEfA==
X-Gm-Message-State: AHYfb5ii8P8Fq1to+MWHvtnoNz6Tol1ixQmigCl/VLCoJP2v4vTJocm6
        f4oSgNcUOgcn4ySOIO1ZLxtipyIgtVLL
X-Received: by 10.80.153.99 with SMTP id l32mr1516991edb.293.1503525601404;
 Wed, 23 Aug 2017 15:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.182.5 with HTTP; Wed, 23 Aug 2017 14:59:40 -0700 (PDT)
In-Reply-To: <20170823102102.20120-1-git@matthieu-moy.fr>
References: <vpqo9r6lhzq.fsf@anie.imag.fr> <20170823102102.20120-1-git@matthieu-moy.fr>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 23 Aug 2017 14:59:40 -0700
Message-ID: <CA+P7+xrUgC9M9VeZTKL4K=ro23arrWHL+F5YUUTj_ZU8t24kkg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] send-email: fix garbage removal after address
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 3:21 AM, Matthieu Moy <git@matthieu-moy.fr> wrote:
> This is a followup over 9d33439 (send-email: only allow one address
> per body tag, 2017-02-20). The first iteration did allow writting
>
>   Cc: <foo@example.com> # garbage
>
> but did so by matching the regex ([^>]*>?), i.e. stop after the first
> instance of '>'. However, it did not properly deal with
>
>   Cc: foo@example.com # garbage
>
> Fix this using a new function strip_garbage_one_address, which does
> essentially what the old ([^>]*>?) was doing, but dealing with more
> corner-cases. Since we've allowed
>
>   Cc: "Foo # Bar" <foobar@example.com>
>
> in previous versions, it makes sense to continue allowing it (but we
> still remove any garbage after it). OTOH, when an address is given
> without quoting, we just take the first word and ignore everything
> after.
>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> ---

I pulled this and tested it for my issue, and it fixes the problem for
me. I think the approach in the code was solid too, extracting out the
logic helps make the code more clear.

Thanks,
Jake
