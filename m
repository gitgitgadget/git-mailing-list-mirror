Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153DE1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfFLTlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:41:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLTlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:41:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so7751871wmf.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JlRIEUoDNf+Lb1YPKYdzSfTOthIzXdVVVwdVGVJSp8U=;
        b=fxdoCz8MF2eIX4jWMp5sF0bUxl5cAKwUx7uBg5ZeLBY5d7HbBg0dIoSgEDASvHQZRc
         rU9mO0O/Y12yLlAAccRfIpnyy/BXkWlAHsOFeS/i7ZxKWm4SG7htF9cLZOEX/w9s/uwO
         /02uDacx+cb6pagR6DERhGsFeJTquPqVVvYEDneDN6ZIKU6eI8cKHuB0oQBUZ24oiUe+
         l7As5gFsLy4mXl8r9AJJCAo6VI16yLtvWXNxkuzc1rzcectspy3Xr9YsGLaObNEZFWU3
         HpI/BwvUX3N9jA95iIOKdJyc2PuoHNLcWMNd/fxJGL++66WhK6ZWPTEXdxT2FlHxGpxg
         jE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JlRIEUoDNf+Lb1YPKYdzSfTOthIzXdVVVwdVGVJSp8U=;
        b=CUVXqNhLSOMdnPzYoLJ3sFfagYDFQzRlNko8hvmLfX2vkJm7uF7b6rlB6rDTTnEWIY
         Sl4w/DkQWYy+RvyvwOcAjD40XXufVu5vKakhxIyEE/vSwYP+KNRsxEAU4bdITbUtu6Ip
         3WDJe49C8U5gpEh7yOQCfKCF8rgnosFgPDmH0GhX2nJ7rkZ10TYljnl4N5DOWl+s3/qy
         CCv8ulKvfCMRXR2Lc+qGOvV0f8IkrLLakkAVqDjxmpZfj02ns6L0pe7RwmVKktWJh10E
         3Fzm/tOPVphAI2aGP/kfFaMcy+Vg5GAO0TfF86+EElPxBmVfXinVVa3QhqFjzdZv04Jm
         UGyw==
X-Gm-Message-State: APjAAAWRmm5UxG0GVnhPjXCivzBwIMIVeGDCE5qqZigw/+5CmtYA0RJu
        d6NlZSjP09dlxAXchBLiS8fYAB3z
X-Google-Smtp-Source: APXvYqyIv5QI1fwBlEd3RkOcAdsUJ8/7n/xXSIFrnXEggJxQ9F5CVyKnplnafICwEeGnCKNld35dsA==
X-Received: by 2002:a1c:9a05:: with SMTP id c5mr559498wme.36.1560368469835;
        Wed, 12 Jun 2019 12:41:09 -0700 (PDT)
Received: from szeder.dev (x4db4038e.dyn.telefonica.de. [77.180.3.142])
        by smtp.gmail.com with ESMTPSA id s10sm966469wrw.45.2019.06.12.12.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 12:41:09 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:41:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190612194106.GJ4012@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 11 Jun 2019, SZEDER Gábor wrote:
> 
> > On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
> > > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > >
> > > > -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
> > > > +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
> > > >  EOF
> > >
> > > Yuck,
> >
> > Oh yeah...
> >
> > >... but I do not see how else/better this test can be written
> > > myself, which makes it a double-yuck X-<
> >
> > Perhaps hiding those spaces behind a helper variable e.g.
> > 'dump_term_clear_line=Q<80-spaces>Q' and embedding that in the here
> > docs specifying the expected output in these three tests could make it
> > ever so slightly less yuck...
> >
> > > Are we forcing out test to operate under dumb terminal mode and with
> > > a known number of columns?
> >
> > 'test-lib.sh' sets TERM=dumb relatively early on, and in these tests
> > we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
> > term_columns() defaults to 80.
> >
> > However, if the terminal were smart, then we would have to deal with
> > ANSI escape suddenly popping up...
> 
> And I fear that is *exactly* what makes
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10539&view=ms.vss-test-web.build-test-results-tab
> fail...

Isn't it a sign of a problem in that Windows test environment that
it mistakenly believes that the terminal is smart, even though it has
been explicitly set to dumb?

