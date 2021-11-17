Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5388C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F7661994
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhKQAvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 19:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 19:50:59 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578FC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:48:02 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id p2so2059272uad.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uvDekjO57Eek2tlsX11nU5pt8QHKw7Vmw/pHoUnIfYE=;
        b=NsTcerKVcuirA825i3EAkQunmJI43zKi1Ddes2baIsC1qfFGhdQu8G4CsJfebBaEju
         18JOVnRGHrBj27uU4TP5RktoFyGnaeDOUqby8a7gYw+8GmRFiLFfNpBh9nboVpEHnFMo
         5UxdH/k81lv+KRXv6aOl8+6ik9w14VOOL9jscE8v8O7aocR1hgnRN/5zZVG4G+7jbBLP
         feymsT4V0VSnJPekHKJeTFU6EPlPMClYaBRjuidQMZujrkw6KqbWwvfvvzMT6/KhxAv3
         O9HiRKUfIYcGjqJ/+U6XJ316lGjtKPFSzM4Zi4H2EDzVRzPbXj6h3dyOmF/e8gPWcv5U
         QmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uvDekjO57Eek2tlsX11nU5pt8QHKw7Vmw/pHoUnIfYE=;
        b=KrYZBfdca+TG6ZQ2iisTFJd8EPmnrQNC/xKWKYuQUF5Pp1cD59CpGhDIMSI4o1UjS4
         Q9hn7Y3429vMFqq8C2m3HDFwp4DoiN+0CjwZIn1EoFn3eYP7mtB6p4scmttdKlZqMKem
         dXXbDOLACApORQFozXSPnL3vb2aSPY723jciDxjWkvVqc2A86F35NzIWazyVzMViygRF
         XKotfpj8kVsNbK3uVvhMuuPThPwrfS3M65dssORtORFelariOkCUcsy7pVZkwTvdFzy4
         +kOnzo7kPC16xgKa0pwfnwDOqfOvfderYrVsfaPPirbQ/EqOvBk6yKbmPt7aK/igoL8q
         9QDA==
X-Gm-Message-State: AOAM530dIJqshXByRWe8Q49VmRb5xNit9WVfK48gvar/E0DiySdde5Me
        Wjr8A0J9RdC68ZK0JAhUDCSBIosSdht8FdSpEvg=
X-Google-Smtp-Source: ABdhPJzpcofGjpL1x6ALiCKAU+tr/6NZm5BeESnqdW1OPLYolSTGd4z6HwE6y95oh6WLQug2JRLt5cwttrGulGKVNKQ=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr17319994uae.96.1637110081401;
 Tue, 16 Nov 2021 16:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
In-Reply-To: <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Nov 2021 16:47:48 -0800
Message-ID: <CAPUEsphYqg4rvvrODL9yYCeL7wkjyR0RcEVaZiYQHy_2D1-oxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
To:     rsbecker@nexbridge.com
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 4:01 PM <rsbecker@nexbridge.com> wrote:
>
> We do link with libcurl and use OpenSSL as a DLL to handle TLS. The under=
lying random source for the nonstop-* configurations as of OpenSSL 3.0 are =
PNRG supplied by the vendor (HPE) on ia64 and the hardware rdrand* instruct=
ions on x86. I know that part of the OpenSSL code rather intimately.

Older versions of OpenSSL exported (AFAIK) a usable version of
arc4random_buf() that could have helped here; it seems to still be
there in libressl[1] which is mostly API compatible and might be worth
looking into IMHO even if as you pointed out will need an
implementation similar to what OpenSSL does internally.

[1] https://cvsweb.openbsd.org/src/lib/libcrypto/arc4random/
