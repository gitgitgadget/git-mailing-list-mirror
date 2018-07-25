Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4191F597
	for <e@80x24.org>; Wed, 25 Jul 2018 18:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeGYTyj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 15:54:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40764 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYTyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 15:54:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so7557417ljc.7
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+4zR+CBh4BG+bsVT+ZcQSwTiFRR/pIXKGj31YRBI9KY=;
        b=j1o3x5uedbH9/4BPxzdYA77/jlKQbrJX9ew5pfUHUcuymmRgRNPOINv1TvrUK0YYFB
         0YKb9KUPJ4clna+WwYLDBxAucoHOupDhmwfgTIVGWzZZyHM5ER56xhm5EvzAQcw3G5tS
         9gli80SuoypI//nmGlbK3q8frKJYq5HoHNTUaMlTo5oE81T9LN7nVOUwZ7+70j+GvxTw
         wpy9Ef8h8A7Vfx9l9TQpZn91u0vuKN0DVQW9ymBn9SfsTf0GL99+4H26ASNYdmgcJlZB
         iH5xz200dRZCCxX5Wbt03o5/JB4wmwHTFhSE8THdHLl/3KMulXeOifA+34XTXcxB+71w
         SFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+4zR+CBh4BG+bsVT+ZcQSwTiFRR/pIXKGj31YRBI9KY=;
        b=OvDXErzW7kC5RjUGaztKSMe+hMkp+U5iTbRRaKajf2zXhbes2ynTLcuAwo3lzRJVj2
         W5pYZZBeyungMuUELi14/azkRLlB35dXdQ0yxvQrR30meuiLTU2W2TP2PLpfKB6thHw9
         fuLm/ltWus2vwBAJIlrr2NUgOLha7l1Ou1BBXbCVTH8LmPloGbR9fNNvJ3Fp3HwVzK4y
         /CrB8XIHLxSde69pO+9AzYZjfcyguGjcWzCUp5P/eTwf1IdugMlNCFm/lIJoPeBnZ/1N
         o1BVnvfdPbZ4D3WvIICUanVxhKboAxQaPuobL1rdZBtun/o9C1i80X2hghel6eYzOG6h
         Mn+A==
X-Gm-Message-State: AOUpUlHDoBh9/DfCju6HarHIGjP10yAgHoRyrnQs0b0mMlia0xNKV+sj
        QXz2tSxiRMynSnN6wTMAQwaxd7Lv3jeH5ukInWQ=
X-Google-Smtp-Source: AAOMgpehybQOtVhMrFtIk4PaCYxB8G81jDROXi7w1eABroWYkBYR1AC21PbR85ReX1/6mt3X3/TfeLOl0Hv2FJlefSI=
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr15742464ljh.98.1532544102841;
 Wed, 25 Jul 2018 11:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180610150521.9714-1-max@max630.net> <20180610150521.9714-4-max@max630.net>
 <20180725121435.20519-1-szeder.dev@gmail.com> <20180725145100.GA1959@jessie.local>
In-Reply-To: <20180725145100.GA1959@jessie.local>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 25 Jul 2018 20:41:31 +0200
Message-ID: <CAM0VKjkSMqPy=N3_0HUNxpCFwusrD_XE5j7kMsE4L-79g2t_VA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] http-backend: respect CONTENT_LENGTH for receive-pack
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 4:51 PM Max Kirillov <max@max630.net> wrote:
>
> On Wed, Jul 25, 2018 at 02:14:35PM +0200, SZEDER G=C3=A1bor wrote:
> >> +    # sometimes there is fatal error buit the result is still 200

> >> +    if grep 'fatal:' act.err
> >> +    then
> >> +            return 1
> >> +    fi
> >
> > I just happened to stumble upon a failure because of 'fatal: the
> > remote end hung up unexpectedly' in the test 'push plain'.
>
> Did it happen once or repeated? It is rather strange, that
> one shoud not fail. Which OS it was?

Only once, so far.  It was one of my OSX build jobs on Travis CI, but
I don't know what OSX version is used.

'act.err' contained this (which will get line-wrapped, I'm afraid):

++handler_type=3Dreceive
++shift
++env CONTENT_TYPE=3Dapplication/x-git-receive-pack-request
QUERY_STRING=3D/repo.git/git-receive-pack
'PATH_TRANSLATED=3D/Users/travis/t/trash
dir.t5562/.git/git-receive-pack' GIT_HTTP_EXPORT_ALL=3DTRUE
REQUEST_METHOD=3DPOST
/Users/travis/build/szeder/git-cooking-topics-for-travis-ci/t/t5562/invoke-=
with-content-length.pl
push_body git http-backend
<...128 zero bytes...>fatal: the remote end hung up unexpectedly

I couldn't reproduce it on my Linux box.

> There have been doubds that a random incoming signal can
> trigger such a failure.
>
> > What does that "sometimes" in the above comment mean, and how often
> > does such a failure happen?  I see these patches are in 'pu' for over
> > a month now, so based on the number of reflog entries since then it
> > happened once from about 30-35 builds on Travis CI so far.
>
> "sometimes" here means "for some kinds of fatal error
> failure", there is nothing random in it.

> >> +    ! verify_http_result "200 OK"
> >
> > ... this function would return error (because of that 'if grep fatal:
> > ...' statement) without even looking at the status, but the test would
> > still succeed.  Is that really the desired behavior here?
>
> Yes, it is a desired behavior. A failure is expected here,
> and the failure does not show up as non-200 status, as
> described above.

OK, then I misunderstood that comment.

Perhaps a different wording could make it slightly better?  E.g. "In
some of these tests ..." instead of that "sometimes".  Dunno.
