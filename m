Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A23C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F1923DB4
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392429AbgLKAoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbgLKAoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 19:44:15 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D82C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:43:30 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so7071126wmf.3
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+cmaO3HSbaLVXG8n9Dx55EWjbTr38xRYTrkwUFQslc=;
        b=b2GrsO7yDpBluA1NE1qVui9jfbqCtOG7ZY49VpcswG+ZHoI9c2eJpisHwYyckg0GyX
         wSlSsJU3z5yQ1+IH1OJXXswhPuNb1oi1Iyq1NB+Ou8cfYFafPcPH4rc2LVGdsFJellch
         mB+0QWFl4RvjEawZrgcggZ5M9ViE03zBoUBp93bAN78Sco0c4Yd7c7F5G2D1Udm2Qn95
         quB7rcnevgeCu/oELinUM3HDcSSD7VT5ZPmsGQSfOp0dOGC+PZaesuxqR+rJ3zgmSR49
         2GW28qB6MX9QmTdUhiIrdKtIX1CVE9MpnH9daUI/16NDfaGOLGfrNIx1qmEYjawdSa2x
         04Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+cmaO3HSbaLVXG8n9Dx55EWjbTr38xRYTrkwUFQslc=;
        b=cYMK+gfmBEsykTJE60idP2sicYH43wX85lVRu7PYbCTnxWDF3lJwJRzKIlXgvrL0p0
         0PVaPR1v1/ZeCJrmGjEHlNdVFBueV6vS83riH9mgaFShE2eUIs5dUn8RMQw+h5oHn1S/
         6sjd/YY1Bhxjj40TxOecjiWPiBOAM4dgShWU+K24pm4j/uIDwSK56i7CMP6FT43OkDrE
         E3FEv1GDfdGVPsjE0vzCxgRdkIKUEdV8iobFsFuRsz8MP36RSitCS4HoesmPZ9ZIrzdk
         1ukiWqS/+pN8NgW8tb54b2aFVo3DWegziskuDk7RlgOeN9ES5xmMb4SiuvXi9nGLCkXb
         WPtA==
X-Gm-Message-State: AOAM532IpCGsruxk0QK908KKjU1Mjo4iQvSRfMUdtErIm3ZRHY3sTkrV
        OMEPqoe2F5+QqOe3BNK6ivAQnZ7T/5rxgj5290Q=
X-Google-Smtp-Source: ABdhPJw1ZS6HQlb6GjPn3oeilSCVIeqgMPjj1qNXH4iTevIynJ1JHhc0WDsVhjLfS3pVijnSdJT6nuZxzc5FoRbposQ=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr10769278wmg.37.1607647409620;
 Thu, 10 Dec 2020 16:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com> <X9EI8c9yeX136ewm@coredump.intra.peff.net>
 <CAMP44s19FKYT5LNUxbGZP3czFmhe9t5B-FAfH+V2btNvMNW31g@mail.gmail.com> <X9I+eisn7sQuWZ1J@coredump.intra.peff.net>
In-Reply-To: <X9I+eisn7sQuWZ1J@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 18:43:18 -0600
Message-ID: <CAMP44s2yBLD+4GTny-GxAuoUdg66zChebsKc=-V7AeOw+RTx-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 9:27 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 09, 2020 at 07:55:55PM -0600, Felipe Contreras wrote:
>
> > >   - t0 is specifying not to indent function return types when they
> > >     appear on a separate line. But our style is not to put those return
> > >     types on a separate line, anyway. Do we need this?
> >
> > Right. I recall at some point it was annoying me that types were auto
> > indented magically at wrong times. Testing "ts" that doesn't seem to
> > happen anymore, but it also doesn't seem to be working at all.
> >
> > Do you see some difference from "t0" and "ts" with:
> >
> >   void
> >   main(void) { }
>
> No, but picking it does seem to impact a larger example. If I open up
> wt-status.c and modify the first function to be:
>
>   static const char *
>   color(int slot, struct wt_status *s)
>   {
>
> then reindenting it with t0 versus ts makes a difference (and I do
> prefer the t0 behavior).

I see.

For some reason this is indented:

  void
  main(void)
  {

But not this:

  void
  main(void) {

> But we would not use that split-line style in
> our project in the first place, I don't think.

No, we don't use it, but I recall some problems when not setting it
(perhaps pasting code with that style).

Anyway, I can't reproduce any of the problems, so I'm fine with dropping it.

Cheers.

-- 
Felipe Contreras
