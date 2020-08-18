Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB25EC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ED420772
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqyJjsq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHRUDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgHRUDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 16:03:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07BC061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 13:03:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t10so23551378ejs.8
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KofySLbD7+WJfPy5RvSMpq21B8XZ+8NPLUNBcz4dJ3s=;
        b=LqyJjsq1bWk5dWozllRavQsqmL3ijP9rfx2i9ygsd/JoIwHqLSyfrB7snm6dUzO+2f
         WgeCR+sMi04lcHf4+te5fWHveUeTRH4OZO7phRXJOjlDFQchWpClTH3Ckv5ji9Qa3zHH
         Zjtitdcji5nAbsH1ddb1W8zsE3FDuzHKJnUKqWYW07nG+2vdoT81KdTwGmynM3VT8mL6
         T8w0ZxGeoVScqqMw80WvjdT+In/ASP+Cv6WivG4aEAVyviltbqYpJajtjor03elNmdNJ
         5TuWlvsg1xD/t1fgfbs1LK1K+akPz0PiT/EgCmPQ8j38MPAjdLH1X4UZyHE+hsG34wCD
         TpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KofySLbD7+WJfPy5RvSMpq21B8XZ+8NPLUNBcz4dJ3s=;
        b=q652N5X5lxFCT00Js9N78wV5oGssP+ua8fqEnGnD5zj1fMp1Juyzm2cPyLKOHq+baY
         svxLf4v4KnS4g2aU7bm0dLrkobFSRjRiLdK1Gt1cMOg3RiNsYGCpOl5U827o31H+I6nA
         W+T7Qt/aBV2AELWIZyNTbyN6FgVZlHCzJx5f2+0YnS4JtQGoC8XhbglJ8EDLZ9gvuJmk
         b89gZSLxYB17R01hOlH70MR6f6UfqDaLsPX8s+yDxRy7gInUrAE7FAI0bI4Szl6eM95a
         83y0XarpljsFCMFZWqRrX2N+j4ZqVnK4vkqAXo5pn25bzUOseifPAwT8YVoW4zSdHPvf
         sHeA==
X-Gm-Message-State: AOAM531kzDjwdK8DBZIfH5Trfi2u1Fkk5+JFtMpl7LB7xnNlp5zEEZth
        H0JHc2bfwkbEQ8bsOAkCztT7Iu3K02aNb1EyyUzciw==
X-Google-Smtp-Source: ABdhPJzxa1QljOtdIU0rHEDfrjSgkKIAQSwLsOgrrsI+T5nXonvGq9fSXpMwgiNa9OZPJ2t26OhzyNVucw30/XxrO6o=
X-Received: by 2002:a17:907:408c:: with SMTP id nt20mr21276724ejb.503.1597780981824;
 Tue, 18 Aug 2020 13:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
 <xmqq1rk3zs7l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rk3zs7l.fsf@gitster.c.googlers.com>
From:   Carmen Andoh <candoh@google.com>
Date:   Tue, 18 Aug 2020 16:02:51 -0400
Message-ID: <CA+Twho+A9QjQ7g8NcV4+n0eOEUfuaRBqT8=7SiR0GCunLfu4Qw@mail.gmail.com>
Subject: Re: Git Inclusion Contributor Summit Registration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah the dreaded day/date meld.  Monday, September 7th at 5 PM PDT.
This is September 8th times zones UTC 0 through +12.

Thanks for the clarifying questions Junio.


On Tue, Aug 18, 2020 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carmen Andoh <candoh@google.com> writes:
>
> > This is a free event.  We encourage anyone interested to register by
> > Tuesday, September 7th.
>
> Monday Sep 7th, or Tue Sep 8th?
