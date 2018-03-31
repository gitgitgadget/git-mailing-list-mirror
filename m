Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8381F404
	for <e@80x24.org>; Sat, 31 Mar 2018 04:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeCaEky (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 00:40:54 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44970 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeCaEky (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 00:40:54 -0400
Received: by mail-ot0-f195.google.com with SMTP id p33-v6so4869369otp.11
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FO3NEdQhl2BXhvkeeI1K/pCuMojkpOrb7rp50/RCuVA=;
        b=h64hxCPpczEWZxNXLyO8Rb7E9K+haKvWdHdE/3MEpR6545Lx9GcwDODn6rDnBN/sqW
         2FYU/jeR0R1MmyJBEGRPLzh9UwdRfNrmatbHWz89ZkE/LlTHLlx5BolwjxdA62250ZiU
         oepYO0HC9wtON6f9YpmGlwXKwKlANBkWKpieXK37aIUT+mxA13QtU7wMXpasAzSEVaCr
         mN9IAvFEbhX+n3UtWb//Fja9xViLh7LPQACsG0GzEXgx7HSEgPXzj43KADJxbiWlt4N4
         wcFRDK+gKA5D7jv2x+6c6Dmo1pyg5h2B3kZMPzZTLS04KmgSkkdebUXNJsbUBkwuv9Ju
         1V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FO3NEdQhl2BXhvkeeI1K/pCuMojkpOrb7rp50/RCuVA=;
        b=bsJyc2rwtAqOXMAusnsyXI5yTD2yeej9+1eLafMUL5RtGRxGe103CbyAxgTK+ynXno
         ISRvnbQ0qWJEumv8vJj1EVgHaG78aX0OQOK7Ccf2wZWphufxfmVJOfs6lOrsACnP1+Ph
         MShyY9iLyOFSHHLCLd/r/4ICOEcRy6d7EjKzc8RxDokIzR0YlAcQh+VNK1Yp0uV7vNkJ
         i8G3Aip05hkmgk8++cIJ2Pt118slwRvV6qKD87quoPH+c12WPXlZ4anIdd/fSXF+ewAX
         hYO70mdWbxvmUhHy064683dADNVrmWmAYnA6eacKc3ivblS0DkSYdyLAMUvyomKi0+DF
         EwXA==
X-Gm-Message-State: ALQs6tCH5Fa6MQEfNOhkWDMiWslTGeph3GQoNCORqpv5bX/FE7VYiDDq
        YQ3QTnSorVIpJ42xvSIXhYldG6clGtc+g+HlUAk=
X-Google-Smtp-Source: AIpwx4/h5b9gVk1AAmu3rhosX9Yad7VenGmVLeClAo7u14Ld/3ySApE24TNfEHg4Xg80cJm8vKfHs8L16eJMKiHypSc=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr923647otq.75.1522471253491;
 Fri, 30 Mar 2018 21:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 21:40:23 -0700 (PDT)
In-Reply-To: <20180330205905.GG14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-9-pclouds@gmail.com> <20180330205905.GG14782@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 06:40:23 +0200
Message-ID: <CACsJy8DFpqa5DYmNpBpeWOW1a3UH64AHa2vG3nkJVLoMR73wqQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/13] pack-objects: shrink z_delta_size field in
 struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 10:59 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 24, 2018 at 07:33:48AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> We only cache deltas when it's smaller than a certain limit. This limit
>> defaults to 1000 but save its compressed length in a 64-bit field.
>> Shrink that field down to 16 bits, so you can only cache 65kb deltas.
>> Larger deltas must be recomputed at when the pack is written down.
>
> Unlike the depth, I don't think there's any _inherent_ reason you
> couldn't throw, say, 1MB deltas into the cache (if you sized it large
> enough). But I doubt such deltas are really all that common. Here are
> the top 10 in linux.git:
>
>   $ git cat-file --batch-all-objects --batch-check=3D'%(deltabase) %(obje=
ctsize:disk)' |
>     grep -v ^00000 | sort -k 2nr | head
>   a02b6794337286bc12c907c33d5d75537c240bd0 769103
>   b28d4b64c05da02c5e8c684dcb9422876225ebdc 327116
>   1e98ce86ed19aff9ba721d13a749ff08088c9922 325257
>   a02b6794337286bc12c907c33d5d75537c240bd0 240647
>   c550d99286c01867dfb26e432417f3106acf8611 177896
>   5977795854f852c2b95dd023fd03cace023ee41c 119737
>   4ccf9681c45d01d17376f7e0d266532a4460f5f8 112671
>   b39fb6821faa9e7bc36de738152a2817b4bf3654 112657
>   2645d6239b74bebd661436762e819b831095b084 103980
>   b8ce7fe5d8def58dc63b7ae099eff7bd07e4e845 101014
>
> It's possible some weird workload would want to tweak this. Say you were
> storing a ton of delta-capable files that were big and always differed
> by a megabyte. And it was somehow really important to you to tradeoff
> memory for CPU during the write phase of a pack.

We're not short on spare bits so I will try to raise this limit to 1MB
(not because you mentioned 1MB, but because the largest size in your
output is close to 1MB).
--=20
Duy
