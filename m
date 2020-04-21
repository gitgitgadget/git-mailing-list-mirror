Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB7C54FD0
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537A12071C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNUUoVnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDUMed (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgDUMec (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 08:34:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C850C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 05:34:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j20so10117105edj.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Quz7Fpfl+guAsZNJ+x5K4QU0PgnUnhrY/67sFjiKPdo=;
        b=DNUUoVnB2tZJdreDNiS/s+fN0gwtOO4wpfvhOt1VNwAnRDWICYR8/euToghhIk+NZw
         Mxks+7Be7KWDDDe6Hr/7NOkDR4azzHnDUaXwQpU0sk/IG9Qdo/3Y+dh3xWU4lYWvjt0X
         bCMVMIR1hQ3LPeqtz+U5UCHm9nxIHbwQtXUZCPIYi8LH0DMg7CHPRCPyEZvXEHuLeaHq
         KIdSV5cVShRp4hgxRM3WVmx6f89lAVqdygeCPvuAG5aWwW7P/sq+KFKS7usyNqoyZ1es
         29+uGjb3ej7k4YjAJtRZjvJeJGwkOnlpYzp9tUnIv/hxay3e2MJqREDPGBbMEdRTH9bx
         lWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Quz7Fpfl+guAsZNJ+x5K4QU0PgnUnhrY/67sFjiKPdo=;
        b=Om8uY2uvw5UfuM2diP3UlJedfY0aHgkZhPx70+5Xm11wMGqs+d74TGYezYI6nCSEwm
         vfoFbPIgVDh81Mbl2ymUcP6NV8/ct+ttZHmEjCxTa62zsxinXwYOatEx1fXfiEN3g3im
         LqPhKMETRrk+7KuFw/6WWGBQR9dPxd4PwdMjHxZzZIj3ypauhQn2MVN+vIc7AqPYcndN
         ejYvDGEWw8/ovKLnDsB+lwm66dlL+jOV5ls7M9K20acqhptfGagLxZpq/jcDGJbp0Ovg
         BuwB2AmltOq4aRlD//bcupiWfWW4kplvH7ky3a6Sj40ohCxfAJTORyww1CYQczWTJsO/
         gF8g==
X-Gm-Message-State: AGi0PuYNUVjx45EvJvb1I+Wy5+zu7IPrYqlswDa2zZTUpEgAqg48IWjn
        NwDSmRxCTS1Bw4/fT0Vkv8kWsuZPcrej8bqeaas=
X-Google-Smtp-Source: APiQypIvr7W11Xk8ylCWOQOnWGmH9piOB9u7Gkkr8H2f3wR18UdolotP66kqbHJ47Ph6iSzI1H1tqBu77RfI/XbSQkY=
X-Received: by 2002:aa7:cc88:: with SMTP id p8mr18590322edt.387.1587472470098;
 Tue, 21 Apr 2020 05:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com> <20200318101825.GB1227946@coredump.intra.peff.net>
 <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
 <20200417174030.GB2103@syl.local> <20200417180645.GJ1739940@coredump.intra.peff.net>
In-Reply-To: <20200417180645.GJ1739940@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Apr 2020 14:34:18 +0200
Message-ID: <CAP8UFD0kqSQAnpfUxqDn_qwigQZhq7zyxY_CZhd1nJzqHT1cqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        James Ramsay <james@jramsay.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 8:06 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Apr 17, 2020 at 11:40:30AM -0600, Taylor Blau wrote:
>
> > > What do you think about something like:
> > >
> > > [promisorFilter "noBlobs"]
> > >         type = blob:none
> > >         uploadpack = true # maybe "allow" could also mean "true" here
> > >         ...
> > > ?
> >
> > I'm not sure about introducing a layer of indirection here with
> > "noBlobs". It's nice that it could perhaps be enabled/disabled for
> > different builtins (e.g., by adding 'revList = false', say), but I'm not
> > convinced that this is improving all of those cases, either.
>
> Yeah, I don't like forcing the user to invent a subsection name. My
> first thought was to suggest:
>
>   [promisorFilter "blob:none"]
>   uploadpack = true
>
> but your tree example shows why that gets awkward: there are more keys
> than just "allow this".

I like your first thought better than something that starts with
"uploadPack". And I think if we let people find a subsection name (as
what I suggest) they might indeed end up with something like:

[promisorFilter "blob:none"]
     type = blob:none
     uploadpack = true

as they might lack inspiration. As filters are becoming more and more
complex though, people might find it much simpler to use the
subsection name in commands if we let them do that. For example we
already allow:

git rev-list --filter=combine:<filter1>+<filter2>+...<filterN> ...

which could be simplified to:

git rev-list --filter=combinedFilter ...

(where "combinedFilter" is defined in the config with
"type=combine:<filter1>+<filter2>+...<filterN>".)

[...]

> > We're not using them, but without them we suffer from a problem that if
> > we can get a SIGPIPE when writing the "sorry, I don't support that
> > filter" message back to the client, then they won't receive it.
> >
> > Szeder's patches help address that issue by catching the SIGPIPE and
> > popping off enough from the client buffer so that we can write the
> > message out before dying.
>
> I definitely think we should pursue that patch, but it really can be
> done orthogonally. It's an existing bug that affects other instances
> where upload-pack returns an error. The tests can work around it with
> "test_must_fail ok=sigpipe" in the meantime.

Ok, maybe I will take a look a this one then.

Thanks,
Christian.
