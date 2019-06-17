Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F16A1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFQSkw (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 14:40:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53338 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQSkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 14:40:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so480073wmj.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d2dmP9QeIka1AII1z5c4lM1rqInqlzOuwo5kOT1sJq4=;
        b=Pt4bjJ1OS0oATNrUIHZOWaiV4nzbg71kCRhccgZb0XSoRPD7VOgHSidrnQNV72SwNq
         xRphcOO3GMchgKm809N4e1f3+vSJTeKGTi3z9/bKPaWiwAokbUj8LpctFhFLnylAsPND
         6ITLwHz67CimNhA2ZLyUeutrFV/2zWi/BOvLLDa5oV6QnHeGkzP+Neb1boAiNUwfEwxJ
         7Wqvz+QMBD0FiWgT0Vt5jTotPWNdFeZDlcJ6k+T12VY+kQOKKqCjOOuBEbttd+Cml8SI
         VnYjjmxiL9hohYEGNUq2uKdWruXlj/m754EP3T9AMV8hlWvjOHpjR+VoYK4a7ElVywps
         3Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2dmP9QeIka1AII1z5c4lM1rqInqlzOuwo5kOT1sJq4=;
        b=piPxPKJAQfMFeDmJYGFp7tsfLydOuqFPJGnt6AsIH0ZK/1rZJ/womF43x0KiJ4BwjT
         poieJ+w8oIXJS5HOhDlFExj3MQnWp9fI2afUiyXDQmxROcWBEFpAQafk1REh5Q/ENjeM
         mcs6JihHNnlizn7fxbqe9Mf79omn+F5oyegJYv2BKSI25PfQtT4yiZ2c5IF8dPqKwrqk
         M/m7SHfdj3TlXpBMEkje2tPHZtgxYyOHYTuyRCBD1xN0twEFd422r4lHPQaeJX3Fgac1
         KYbkKIqj6TWNwXx5Ow0eGeSH13PIVwu/p0Ub8BMOWD7wA+f5fvCNg8wCVkCepLIvN+xk
         UWrA==
X-Gm-Message-State: APjAAAXlLZyz8MAEnI8GCieH0Bd0g0y81oyUL0TbuCDYFA3t/MjHmsd0
        mUQou24MCwiq+24dTP/ToTs=
X-Google-Smtp-Source: APXvYqxEHE1uVLgexmrxOZLJVsi/SdbSvv0vG7osM+Ciym9gG5Eh23oCAfPwvn3wUvSfbY+4og4yrQ==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr45781wmc.108.1560796850274;
        Mon, 17 Jun 2019 11:40:50 -0700 (PDT)
Received: from szeder.dev (x4db66496.dyn.telefonica.de. [77.182.100.150])
        by smtp.gmail.com with ESMTPSA id a12sm8331318wrr.70.2019.06.17.11.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:40:49 -0700 (PDT)
Date:   Mon, 17 Jun 2019 20:40:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190617184047.GK31952@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190612194106.GJ4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 08:42:29PM +0200, Johannes Schindelin wrote:

> > > > However, if the terminal were smart, then we would have to deal with
> > > > ANSI escape suddenly popping up...
> > >
> > > And I fear that is *exactly* what makes
> > > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10539&view=ms.vss-test-web.build-test-results-tab
> > > fail...
> >
> > Isn't it a sign of a problem in that Windows test environment that
> > it mistakenly believes that the terminal is smart, even though it has
> > been explicitly set to dumb?
> 
> I investigated this today.
> 
> Mind you, I still think that it is totally inappropriate for a test case
> with the title 'rebase -i respects rebase.missingCommitsCheck = warn' to
> validate the expected progress output, in particular since it verifies the
> progress on non-sophisticated terminals, i.e. the totally least
> interesting and least common scenario.
> 
> In short: I stand by my suggestion to fix these tests (i.e. ignore the
> progress altogether) in a preparatory patch in your patch series.

I agree and will try to get around to it in the coming days.

> In case you are interested in the details, please read on, otherwise just
> mark this mail as read and move on.
> 
> Still with me? Well, here you go, enjoy the ride.

Sure!

[...]

> I hope you, dear reader, can appreciate the number of circumstances that
> had to come together to trigger this bug.

Thank you, it was both educational and entertaining :)

