Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B9C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85874206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="VJU6Bdtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgAaKhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:37:02 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35358 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgAaKhC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 05:37:02 -0500
Received: by mail-wm1-f49.google.com with SMTP id b17so8110932wmb.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 02:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtocHtlWu4lWy25dD3JREeijr/iJaW4ReNU3c6qclWI=;
        b=VJU6BdtxLlKoJDHcdo0e/m3f3WLuRKwVqkhd5qk5VL/xEBnIVYG44Iu3i5Qt/Hhq9w
         hk4YHVAnqHP5K1mY/1Vae6CavEMGCkFpgav8qpLrhN2KgT22sKKBFMXqupK91lcUMV4B
         Os3sxtyG6bF8Pq87Wp2CIrfYyexIn5VtB7USA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtocHtlWu4lWy25dD3JREeijr/iJaW4ReNU3c6qclWI=;
        b=cVK8m/B9mHzHak4nwNcB1eFEz9TBDmXAdH2vdRKNB/v26rTl1lU9XC+lwoCqqUSIIE
         Fp/pK35n89QjBbvaUwFJBARZSFadOpwOfnvmoEqD3G6vc7e/IX72KXhQ+EGxoGHML0X+
         svyNSvD84mnsWuvCRl1ByuEIj6eWszlXehPLxHQoUJa3IiYGlyqkO10LBLpCNo1H9yOU
         WtS68YTu3V8wgbdLg80d43ZxkxDV13hUsfJC8P0KaoivMi+Wx9Yi5mEWwhpGyNiSp8FW
         2o1Lj09TvNG/54qYk8WkDyH3B+GZFcShqGmwjTC4pvxX9JW4T3MZV2BCDEb9zCL1MFs9
         0JLA==
X-Gm-Message-State: APjAAAWItBqtOSQIDOMW7QSXRM6YwxIGiAZQrZODNURKizb6VDP3jwkb
        mpdutto7gEZhY58SNhpyocxKTCGPQIQ+vHn+Jm2IFQ==
X-Google-Smtp-Source: APXvYqxOV64h8RTws3V0zoutXVGeiGDzS8TheSZqI9U8nK0eMX0zYH4lQQA2Xq2GlqiYrIl6UgnjI/w6bIjvfBaHME0=
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr11688776wmk.135.1580467019897;
 Fri, 31 Jan 2020 02:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20200129111246.12196-1-luke@diamand.org> <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org> <20200129111246.12196-4-luke@diamand.org>
 <20200129111246.12196-5-luke@diamand.org> <CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com>
 <xmqqzhe4btr0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhe4btr0.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 31 Jan 2020 10:36:48 +0000
Message-ID: <CAE5ih78VwT3iRb8pmyN9g-JnU2dET2ZZ4X8CHWSxdARtq3-tEg@mail.gmail.com>
Subject: Re: [PATCHv1 4/6] git-p4: create helper function importRevisions()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jan 2020 at 19:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Jan 29, 2020 at 6:13 AM Luke Diamand <luke@diamand.org> wrote:
> >> This makes it easier to try/catch around this block of code to ensure
> >> cleanup following p4 failures is handled properly.
> >>
> >> Signed-off-by: Luke Diamand <luke@diamand.org>
> >> ---
> >> diff --git a/git-p4.py b/git-p4.py
> >> @@ -3555,6 +3555,73 @@ def importHeadRevision(self, revision):
> >> +    def importRevisions(self, args, branch_arg_given):
> >> +        if len(self.changesFile) > 0:
> >> +            output = open(self.changesFile).readlines()
> >
> > Not a new problem (since this code is merely being relocated), but is
> > this leaking the open file? Should there be an accompanying close()
> > somewhere?
> >
> >     f = open(self.changesFile)
> >     output = f.readlines()
> >     close(f)
> >
> > or something.
>
> Hmph, I was naively hoping that the (never assigned to any variable)
> last reference going away at the end of the statement would make the
> file object dead, and we can let eventual GC to close it.
>
> Nevertheless it would not hurt to explicitly control the lifetime.

You are right, there is no file descriptor leak. It's easy enough to
write some test code to demonstrate this.
