Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24586C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 03:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB72D2073E
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 03:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="eXEimM0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGRDJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgGRDJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 23:09:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80488C0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 20:09:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so14861041lji.9
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 20:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fH2VUTgrCDusXU+GwIZnYzRkaDrNqPaWZ7N2O017vmo=;
        b=eXEimM0vFVDKLUf7WEO8YF0tr/4IYuAg1dYsSbKc3POiL/M2Xi0R7vLkVG8qx2wEDy
         OL/b2ks1EWTW9Hxq1bmnSWyG3JPJOanBeCcK/D0AiB4n5ePM5ILs889mN21zVh0YO81F
         IBOB0JLywfJDRTHOB1GyaMRlIucAtHhMscaiB0yDbfmIKUVbwUXF74RxBy8V0fMOgQjl
         hTe1mDQxYra3fmDPWId3EVLE3JRcn3EETasYgBZUVi5J1ZCXOw+4L2PrslFSsGIEvL9/
         Zhz+9UNhbIDQa3sNR5ytthkjJ/JLv8lG0kPj2RECMlD85NSEEAtvMyScRUrKBz088SRb
         FoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fH2VUTgrCDusXU+GwIZnYzRkaDrNqPaWZ7N2O017vmo=;
        b=Nm5+/SqdOGLBKXYk7o29fCFJSX6cv73uKlt6izjVs0GYH5AVG5QpPTGoV8At0V+j0L
         oFOf8nmu0hBKy2GleQvC0xc3cKkrUh4QcFS1k/cbuiLWjUqeaTKeF4h9YgdSSFJXhGaB
         X+XkgeG2xS9g36idrIvNvqd9EKBRhr09uW8MJrhwwjyMBOERnWWyNo5hcZu3ybGWUSvY
         RKe34SKI0LxoL6GeG7jura5IBlAVRj+DBnbTwI4ZVasM9SMyfWYXku/9iPuWmyyuVjpJ
         JOpGV/PbBWaNHbWp4FBJ3h5Lo9zEVXk+8qgUcp4SICDB5nMlGbXQ4H84m5QNJLlrLMTr
         bPtA==
X-Gm-Message-State: AOAM532VRbS/Qc+BS2TSxKzaQGjLBFeVsEXlpdzfRDi/nq6Qp6LIRyRN
        cma0zvOAR/LjeR5N9I6MWCaKIGW/Nc9B+DtG68b2EA==
X-Google-Smtp-Source: ABdhPJyWBFrBWYZMHGobQDCaHFuOpeqoMvYiowkZ2O1Avx8xXGDzRCee5Ue9+XADgQ4ctbkrginO+LS3Yv8egFfjel8=
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr6168463ljj.200.1595041785633;
 Fri, 17 Jul 2020 20:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593208411.git.matheus.bernardino@usp.br>
 <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 18 Jul 2020 00:09:34 -0300
Message-ID: <CAHd-oW6mvaANTBX5sVEi49s_Ku71-ZXqhyePtkwbCKaTK7tm4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends thread-safe
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Dscho

On Thu, Jul 16, 2020 at 9:56 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Fri, 26 Jun 2020, Matheus Tavares wrote:
>
> > +     value = pthread_getspecific(hexbuf_array_key);
> > +     if (value) {
> > +             ha = (struct hexbuf_array *) value;
> > +     } else {
> > +             ha = xmalloc(sizeof(*ha));
>
> I just realized (while trying to debug something independent) that this
> leaves `ha->idx` uninitialized.

Thanks for catching that! I fixed it in my local branch.

> But as I mentioned before, I would be much more in favor of abandoning
> this thread-local idea (because it is _still_ fragile, as the same thread
> could try to make use of more than four hex values in the same `printf()`,
> for example) and instead using Coccinelle to convert all those
> `oid_to_hex()` calls to `oid_to_hex_r()` calls.

Yeah, I agree that removing oid_to_hex() in favor of oid_to_hex_r()
would be great. Unfortunately, I only used Coccinelle for basic
things, such as function renaming. And I won't have the time to study
it further at the moment :( Therefore, I think I'll ask Junio to drop
this series for now, until I or someone else finds some time to work
on the semantic patch.

Alternatively, if using thread-local storage is still an option, I
think I might have solved the problems we had in the previous
iteration with memory leaks on Windows. I changed our
pthread_key_create() emulation to start using the destructor callback
on Windows, through the Fiber Local Storage (FLS) API. As the
documentation says [1] "If no fiber switching occurs, FLS acts exactly
the same as thread local storage". The advantage over TLS is that
FLSAlloc() does take a callback parameter.

I also removed the ugly `#ifdef HAVE_THREADS` guards on the last
patch, as you suggested, and added some tests for our pthread_key
emulation. In case you want to take a look to see if it might be worth
pursuing this route, the patches are here:
https://github.com/matheustavares/git/commits/safe_oid_to_hex_v3

[1]: https://docs.microsoft.com/en-us/windows/win32/procthread/fibers#fiber-local-storage
