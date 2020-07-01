Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC6EC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C620F20747
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRCn5sUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgGAKph (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgGAKph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:45:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41506C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 03:45:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a12so24462146ion.13
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CDh1nFP3yi2mFYGOYzrJlUBc+RVcOA8MmpC4PGf9a/g=;
        b=SRCn5sUEk+0iVa3kxcAgrB1A746TpDPWfvDTwhxVdeiZHRFS9wnXYc4xlUVw4muwlK
         ngWEkxMLl1s809PSOXUL+MMgIYBUFwyK+SZ13QJ0bg/auhExyihf/Sc1qDwdYLEQNIJb
         e1cksUCzY4XdOt4QRaMlSxES9K+JcoeE3+6IVg6nf5b1/Xc6Ht/3+Kb/DlZ4FEZtfnyN
         2bIcevhv4xVjElChUi3BXDTh1hKGXAlM3chh1wz/PdDE2qYami2YzrYUw3GcJJGRNyKm
         81l5wuxMceENefIZYqPWZZnnYMVbTaqbdYrYBOhEu5+oIe8ayyknpNsv4LbMXsM1vLul
         ki9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CDh1nFP3yi2mFYGOYzrJlUBc+RVcOA8MmpC4PGf9a/g=;
        b=lWyhUwnkkuHckzmsI9L0dBUW0u29qrItteplYC6iEPPWTM8vRlc4k+uzdWy8qtf3db
         uc9MFz0s0BbC9XbYOPiDy530FaetoCAglBUJDv5jv0OckOOsspyqdKb5bDdBJAwQ5jzo
         St/yGYRMvFxWxTMI75YiyRSBwIb4VlhHXYqiytA2dM90v5NVt/dvI6kKWsh54ev432Do
         pZU0ykhAr950REXkwYSHRnGDHcoFawlOD48ryvqq0UqjdsoHSdKqI6sVsffqqAEB15Sx
         cWJV6PALC8axbqN5LXMkpW+w9qLAyPqCPzJSkrP4O4h08v73a6h49TG+LZI8xuWHI6+B
         4/tA==
X-Gm-Message-State: AOAM530ZE6vO0LrLU5751RGpBBEeyBHKP6C293IhtIJHQQ6Q/kvpp1Ru
        I4j9kSBu8fWJLSjQnF8kBAGwDSjOFAR5ZMtIQzsbrw==
X-Google-Smtp-Source: ABdhPJy7PuOytuha/cpcwgf+cVyzE3XcKLjU1QwpGlCWDlhykDx/pMP8S96f02W1PA2Lh8jI+QA64DAd2Ff33p4uBiQ=
X-Received: by 2002:a02:c785:: with SMTP id n5mr28447358jao.75.1593600335939;
 Wed, 01 Jul 2020 03:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8m1=0n8zzoW--g_XLebJFqFSXpBpTr+1S58z7snLTt-0Q@mail.gmail.com>
 <87tuyrd0ng.fsf@igel.home> <CAH8yC8kxY5mV0p-98W0uDN7PLxmNR4LkNcz9vbKsq21aTd-qQg@mail.gmail.com>
 <87lfk3czae.fsf@igel.home>
In-Reply-To: <87lfk3czae.fsf@igel.home>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 1 Jul 2020 06:45:25 -0400
Message-ID: <CAH8yC8=SgS1=mpSM_7j8FQzreVPfE5U_tnsCz9ixZoBHLUuM7A@mail.gmail.com>
Subject: Re: Why won't git checkout a branch?
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 6:20 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jul 01 2020, Jeffrey Walton wrote:
>
> > On Wed, Jul 1, 2020 at 5:50 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >>
> >> On Jul 01 2020, Jeffrey Walton wrote:
> >>
> >> > $ git checkout m4
> >>
> >> Try a newer git version:
> >>
> >> $ git checkout m4
> >> fatal: 'm4' could be both a local file and a tracking branch.
> >> Please use -- (and optionally --no-guess) to disambiguate
> >
> > Ack, thanks.
> >
> > This does not look normal, either. I don't want to create a new
> > branch. I want to work on the existing branch.
>
> To disambiguate, use `git checkout m4 --' if you want the branch, and
> `git checkout -- m4' if you want the local file.

Perfect, thanks.

So the way to checkout that always works is to append --. Is that correct?

If so, I will start using it everywhere.

Jeff
