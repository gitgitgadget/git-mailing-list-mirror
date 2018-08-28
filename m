Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF6D1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeH2B3L (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:29:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42696 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH2B3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:29:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id r10-v6so2422210edp.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXq20nnl1c/z0YGjiWan+YoZiGdzY7qkVatF26QRbVw=;
        b=IWMRIrOcjlFvp/5+zQbxZ14yzRaoxWz1CXNd2/5JBwIVmC3wY7Zv31kP0LbXbQSsvU
         cqthpu4ppBuwgQuIPAVO2dAoki5+n/LHYx7JE/CGpSAgCyALFXi8oj/LVTUQ1PEKF8Hc
         GRFex6DjN2wH8Co46KXmxGN/rMwlCMIhtjJ86QWfS8mABG9aycSDXxZndPF3F9wByx/f
         IxaZUFyYHQAhXbVAPOfk3L6Xodep2Vidxeml5XtCB7tt5N1AzpiZcKEp0oF7saum7EQQ
         PZwzN4dPaeq56DfG7UfcJWMb1AMZ399QlnEmvSfwiI78xXM2j6kVSiJItU6zKYJRizpS
         aQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXq20nnl1c/z0YGjiWan+YoZiGdzY7qkVatF26QRbVw=;
        b=luBtybJeN6RI+4gJl+WyeWX3tLiD8TUfnyNN+JN3wPnWA7O4jeb3fXopN7/6YKORov
         boQJk8gWpdCWStVZ2OWm3cbQjOEUod3eedoVL/NdHdrNNX88pCxJJbud+uu+2YUuxWMV
         lXEdVkRK7hxzOyS0FNtpe4F7CswmVDOzwZ6sybFI5ahrcSG/a8ZOuO8ICCVlgQ1LIJWo
         4tXP1QNrpbWi3NTS4vZTgzGSx6J7jfNR4BwGUcBOFkMqQYmvfWj2rKqk7Otx2XxdeKAM
         ObMFPVxSgLRR/V6h+W0OLmK6FeOBq/D76DRB+HmYnQDJfek7EO+SFDOZGqESuYjfLPPf
         1fZA==
X-Gm-Message-State: APzg51DNVJ2CqRyBT6NERPrLO8a0F+urn555x3rCrHknZRp2Zt3HTYVJ
        6MvtY1xkv3zSZPdCeQjntbfzYkk+TNKirK0WdzDHIQ==
X-Google-Smtp-Source: ANB0Vdbrzk080VNXMNmhL9gNulVarluo+LqmG8yneiddofeVlZxkYBcqThlO3Iqii5hSSS/MD8rXOghxXIdFF0Qc9OQ=
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr4326203edd.243.1535492136702;
 Tue, 28 Aug 2018 14:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
In-Reply-To: <20180814180406.GA86804@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Aug 2018 14:35:25 -0700
Message-ID: <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > -           echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
> > > +           echo "gitdir: ../../../.git/modules/sub3/modules/dirdir%2fsubsub" >./sub3/dirdir/subsub/.git_expect
> >
> > One interesting thing about url-encoding is that it's not one-to-one.
> > This case could also be %2F, which is a different file (on a
> > case-sensitive filesystem). I think "%20" and "+" are similarly
> > interchangeable.
> >
> > If we were decoding the filenames, that's fine. The round-trip is
> > lossless.
> >
> > But that's not quite how the new code behaves. We encode the input and
> > then check to see if it matches an encoding we previously performed. So
> > if our urlencode routines ever change, this will subtly break.

And this is the problem:
a) we have a 'complicated' encoding here, which must never change
b) the "encode and check if it matches", will produce ugly code going forward,
    as it tries to differentiate between submodules named "url_encoded(a)"
    and "a" (e.g. "a%20b" and "a b" would conflict and we have to resolve
    the conflict, although those two names are perfectly fine as they do not
    have the original problem of having slashes)

Hence I would propose a simpler encoding:

1)    / -> _ ( replace a slash by an underscore)
2)    _ -> __ (replace any underscore by 2 underscores, this is just the
          escaping mechanism to differentiate a/b and a_b)

3) (optional) instead of putting it all in modules/, use another
directory gitmodules/
    for example. this will make sure we can tell if a repository has
been converted
    or is stuck with a setup of a current git.

> This is exactly the reason why I wanted to get some opinions on what the
> best thing to do here would be.  I _think_ the best thing would probably
> be to write a specific routine to do the conversion, and it wouldn't
> even have to be all that complex.  Basically I'm just interested in
> converting '/' characters so that things no longer behave like
> nested directories.

Yeah, then let's just convert '/' with as little overhead as possible.

Thanks,
Stefan
