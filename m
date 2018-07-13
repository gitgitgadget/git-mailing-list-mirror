Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058EB1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 21:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGMV04 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 17:26:56 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35630 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbeGMV04 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:56 -0400
Received: by mail-yw0-f193.google.com with SMTP id t18-v6so12255988ywg.2
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcEF1xmw7BxAAdAYmPxRyVOa2z9xCoy4lGV0yOzNTFw=;
        b=vbpwsinqMMhQ54Wjm1I5znEplHVyeHv97CG5/K0PCxXxXZN1by54Eshzr1mgd0heyY
         gv8+KJpOvYHyCUpsQ5VZEss1tzmx2cPyhO7S4XwTrUTo2SeGUVFoBZNTIOcY11tsfcPy
         Lt26W6qF1TQDHYi3E01cKOTj9/HkD5RnaWL9zXOQ9d9uHLAqFj7e74fweyjZK7zpcrVh
         6FIJdO3yV4rcJV/GDkPkh6iJSxRSmg4dZ0P7vTXpOH9M4nXa+R3DB/jI/ubpFFHcRpx5
         CKR4UUHHjL/Zw/mcMDuv6E4qPkFgCMaz6UjEgSI4G9ndC0Dhv8f671f9261So3Y5g4Of
         DFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcEF1xmw7BxAAdAYmPxRyVOa2z9xCoy4lGV0yOzNTFw=;
        b=o8+6meKC6LaIpZhdaAjUPHHUfUrOaJOAHekb7NSjZDKVRwffwIDX8189yPf8tWOMGn
         S8dFW10xQ6j46Lfnm5lP3c/QWXEBdUgiZpDio31RTObG/q/SzqToUFaIbMlp7OgSiJxG
         EJd4hDJnlcIpHPzco+EhtfJmPkNYK7pAglC/GCmmylCJ1ZbALowJF0YDlvYhCw24Sg26
         JIRwO2siXZgVfvRAWEShSIrFKVeE5VCxpoFY2AV8IfhWhfNQkJi8mxO6j8x/sLf4VRTA
         bG9EePt5PFU3ilNzsplUSpgVcTB35xkAFSlKqL8+8SIc8gs97rpJxjlGomnVn3+E5sq8
         RT8Q==
X-Gm-Message-State: AOUpUlHGF6adHFpgPgMIx4SldPzrMd4Rfc4D3CIXdIK1SnvgYNR2ahHk
        fKJ+oakRiYdJuT6582/xA4BThX2zQjWsgKytrRjeBA==
X-Google-Smtp-Source: AAOMgpcfN5oP30KMLgjBcJzD0l89K9c7HoNZf+XtwerzSS/h+lImQs9EAOos8kUpzt0iVPlV3GJ6ScjAZPZSDzSRJL0=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr4264971ywa.340.1531516235689;
 Fri, 13 Jul 2018 14:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180713204350.GA16999@sigill.intra.peff.net> <CAGZ79kakrS_tk=x4Rb9qSu9e4RVSJ=J64eOdasKhOy=g8kV68w@mail.gmail.com>
 <20180713210452.GA18909@sigill.intra.peff.net>
In-Reply-To: <20180713210452.GA18909@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jul 2018 14:10:24 -0700
Message-ID: <CAGZ79kYpZy4q4vD3z5oZNZYgCYWu4YWeA4DX=E8jFW9=XUe7_g@mail.gmail.com>
Subject: Re: [PATCH] blame: prefer xsnprintf to strcpy for colors
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 2:04 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 13, 2018 at 01:58:05PM -0700, Stefan Beller wrote:
>
> > > I'm sad that this strcpy() wasn't caught in review. IMHO we should avoid
> > > that function altogether, even when we _think_ it can't trigger an
> > > overflow. That's easier to reason about (and makes auditing easier).
> >
> > Can we somehow automatically find "bad code" either in pathces
> > or in new code (such as pu), e.g. as a coccicheck for these functions?
>
> I'd be happy to declare strcpy() totally banned (and it more or less
> is). I found this with a simple "git grep", though it seems like a
> trivial application of coccinelle to find it. The question is what to
> convert it into.

into some "meta BUG("your review process failed")"? :-)

> xsnprintf() is often a good choice, but not always
> (e.g., if the destination isn't an array, we'd have to get the size from
> somewhere else).
>
> I wouldn't be surprised if there's a way to ask coccinelle to convert
> the easy cases and barf with an error on the hard cases or something. I
> don't know the tool very well.

I was just suggesting that tool as it is run on pu by some automation,
hence it would not fall through the cracks. I mean how often to you
happen to run git grep looking for strcpy on our code base and do we
want to rely on that in the long run?

Stefan
