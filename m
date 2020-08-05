Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E4C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F63C22CF7
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEZyM2bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgHEQny (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgHEQmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:12 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53EC034601
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 04:35:51 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 125so8430480vsg.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hws1USB0shfBCwcOHeyIFz1CeCVQyD9W3NB3949ceU8=;
        b=vEZyM2bcI/P/+9adQZ/CiO7V1H2fchHc2gcjP02MebTFj38TMlzVVHTNm7UKPcL87K
         53F/ZYrm0n9xXtMYpUmThNo4Orc7dUvEW79KmuxlQLmx57EwXaoN0gVMVYsm3/t+fdrR
         VJvysUNi41yICOfwy0j259NCJYBmcraQX2r+qdB7aa/GB8e8u99n4NDUDX+lNwG3Aw3k
         qvopbOt87Z/okktgM1P+wsqSGlSJxJpegD2hztE49lIEp2wl0owrKAxqhl5cJTOV4A64
         wbCMyot9K2Bb2bcQ2uk/+sjjibpXgcaqxObc458hbhH7lWXdbCli4grLnwJcfF3MWG9e
         F9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hws1USB0shfBCwcOHeyIFz1CeCVQyD9W3NB3949ceU8=;
        b=kLxwhdZlZgZ7KaWtj7UD75uaIfyJYFhll4vAPNpkVZHnwxCf68HZu6+qkj/XJQc/5h
         kiVeGb+QrW/8gsC3GrwA5LTQ59dYqltKELWuZMAcfHkWHOB7IotAGnGZA1R9N5+O3Gjj
         pwMulWQVVPX6XSTkQkDZ6dBHEsR9O6PZS0VZVmCCq1BrzwFBU7W1CdW0TH3yh2x4HsMn
         8tRzpg86I3wZaZ8NFMps0CXLp/ttqtDDmLef0gX2GGZ9Df+UrTLh3OGXV/HgS9By8dDM
         yYvCJLurNPLA49IUrd56BMRgnEaTAS93vW7cQvbuqCRJixulH+igXWUDOZLuC018qHLq
         N/jg==
X-Gm-Message-State: AOAM530wKwrDOma0j/sPHSo5XbFmanh/iAS+NHNipPm61TbksISTk5sQ
        OeE0omXcvTApoJjxY//vIMWIaZ/5ITGFw6B9cB0=
X-Google-Smtp-Source: ABdhPJzFy4eOCwyzpuxJS9CcEoRSg9xqaxtfiVGJ+ztf6qkYIAkH/1D2rrEhWxtX9WJSPn45WBZ0Y923v98pThnVW6M=
X-Received: by 2002:a05:6102:2373:: with SMTP id o19mr1516417vsa.118.1596627340445;
 Wed, 05 Aug 2020 04:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200805084240.GA1802257@coredump.intra.peff.net>
 <CAN0heSqsHGL2Pb37d2dWL+RCWac4z8mjpM-v6v6zsxH_8cWQjQ@mail.gmail.com> <20200805100351.GA2126375@coredump.intra.peff.net>
In-Reply-To: <20200805100351.GA2126375@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Aug 2020 13:35:28 +0200
Message-ID: <CAN0heSqmsrvf8-Xq6TNqfGONLJir2w9+4QA3_6KKkFiVH2Rc9w@mail.gmail.com>
Subject: Re: racy test failure in tb/upload-pack-filters
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Aug 2020 at 12:03, Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 05, 2020 at 11:27:22AM +0200, Martin =C3=85gren wrote:
>
> > > -       grep "tree filter allows max depth 0, but got 1" err
> > > +       test_i18ngrep "tree filter allows max depth 0, but got 1" err
> >
> > This one isn't translated, so this hunk could be dropped. Or maybe you
> > wanted to knowingly cast a slightly wider net? (And this does fit the
> > subject of your patch.)
>
> Neither message is translated in itself, but the bug can happen with
> either of them (because of the translation of the "remote error"
> string). The tree-depth one was actually in the first failure I saw, but
> when I re-ran it to produce output for the commit message, I got one of
> the other tests.

Braino! Thanks for (re-)explaining so patiently. I even tried dropping
that hunk and running a fair amount of "--stress" -- never failed.
Without the other hunks, "--stress" hit the failure pretty much
instantly. Oh well, brute force doesn't always beat actual thinking.

Martin
