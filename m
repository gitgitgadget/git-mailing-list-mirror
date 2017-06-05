Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6E31F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdFETDE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 15:03:04 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33855 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdFETDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 15:03:02 -0400
Received: by mail-pg0-f46.google.com with SMTP id v18so14623310pgb.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qisZ3VcwFSR0PUuSoTmcc0oFzlSMqg+6XLM+gwOxe9s=;
        b=XMg7T5Pa6Ff9mDpK54FXGmCzzW4bX9ju2NiqENXRIoeuZjn/YnCK1ycah1LzNfnX0i
         Sthr73fa/bHaeI9d5QO0fQeY/SZhwVaVgjtjmDeVIJY6oEIu+m4Z2Ssm2cLldFF9DIgs
         dQ2OvvlzsiVzy5D/GvrzsD2tlv13CPGOJuP5fZOQsLbJDqbdm/1oEx4iqev5waDFcceU
         y1Ruh6I++L4KIEAxRykWIbX1nlZLiXm7KR22QJi7/XoJQL+AkcCXUL0Mr29/wUOL7VLa
         u7tvu8NW37JI769ErZ/V1FFFih3+4bq186Mkqpcq/d9Tlprx5Xnw8EFK7Q5JKO86hIs/
         +eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qisZ3VcwFSR0PUuSoTmcc0oFzlSMqg+6XLM+gwOxe9s=;
        b=Hp69ZNS61DL413sqp017RX8FFNlmTI2MW+LZRfYL9qOoYaxzjIaVPjkKqoN1Mt6x69
         o9PpIup2+tvG+lXSK1hxxQJWSAkFIogib/Pfg2l8PTB602tGGVFx7DYJd7b5vN6XOP/C
         XzycACmVIUPbuUeBu3csDNICR607ra4HQvDaepKr9wY3VHDhDjlTHJV35hJAhyUiNuJl
         po43atP0CkwXUhpFhvuYkAWn9s3TWUjEsSwFBvCIWlITDnD88vXmhsBmvKeVNNYIrSt5
         uSJ8MMp+1weE3pKzsbJaZfNm+b5IdYbm03zZAjsjIp9DI2OIBwFoUiXrwa/5V2w/SkXi
         QPgw==
X-Gm-Message-State: AODbwcBGwOZcxgDoGifGo6b495viLeyuVGDh/iWW9K8lpkzvbEQTTJC/
        46J6fXJ2OjFRdhR5QxU2oCL8oCA8xFHw
X-Received: by 10.98.68.156 with SMTP id m28mr16533680pfi.48.1496689381029;
 Mon, 05 Jun 2017 12:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 12:03:00 -0700 (PDT)
In-Reply-To: <CACBZZX5FP_jxXaT+NW8g2JqH89iYajHPjHhxCj=_vWnkxZ=rYQ@mail.gmail.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
 <1D06FFF7-C36D-4072-8B37-4C9DC45E4442@gmail.com> <CACBZZX5FP_jxXaT+NW8g2JqH89iYajHPjHhxCj=_vWnkxZ=rYQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 12:03:00 -0700
Message-ID: <CAGZ79kZn+bjtqBYTWuYqfsKdA=eWreNHQPCLVDGiS_8977VcTA@mail.gmail.com>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That's never going to be a problem on a less beefy machine with
> --state=slow,save, since the 30s test is going to be long over by the
> time the rest of the tests run.
>
> Cutting down on these long tail tests allows me to e.g. replace this:
>
>     git rebase -i --exec '(make -j56 all && cd t && prove -j56 <some
> limited glob>)'
>
> With a glob that runs the entire test suite, with the rebase only
> taking marginally longer in most cases while getting much better test
> coverage than I'd otherwise bother with.

I wonder if this functionality is rather best put into prove?

Also prove doesn't know which tests are "interesting",
e.g. if you were working on interactive rebase, then you really
want the longest test to be run in full?

And this "judge by time, not by interest" doesn't bode well with
me.

I have a non-beefy machine such that this particular problem
doesn't apply to me, but instead the whole test suite takes just
long to run.

For that I reduce testing intelligently, i.e. I know where I am
working on, so I run only some given tests (in case of
submodules I'd go with "prove t74*") which would also fix
your issue IIUC?
