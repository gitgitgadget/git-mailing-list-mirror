Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B167C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiAKUYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiAKUYq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:24:46 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF5C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:24:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id v6so499317iom.6
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/9foJOcAld0A+EyTrPMYOTQetz1WHElHrn1E6B+7uM=;
        b=Zp/avnGC9+KXVLdlAS2v66WMfJ5DNGIhcO3FCMYmNUximi5Ho6OYDsXdLkK6av9KWd
         dhzT/YifGD9yLsC3aBl2XYAsHuYurMWKjQUNi5kFFs2S6VJcImGtebdqcuqvMBRwTX3E
         BEjacdjS/5l8CAArz1O+J5BDLSjJ/wXjvRCy9hyoQAee0ZYql8OGHPMU8uzXLGE+uJ8E
         mC8MEnlo51S6m9pv/Xi5n7tYWdh8pQCiOEN3MiRYdJ7t4/TmbH09ajOimSikcusP8TkK
         S0ifOhHWOXCFzic3nYgmYIWAcWMAgdTpede0/tpQDZGER/h1UU5OJPdFEMZ3VpoB4cBa
         KZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/9foJOcAld0A+EyTrPMYOTQetz1WHElHrn1E6B+7uM=;
        b=H4/GoN/dwe8+i2FCUcXAzJnz029EreM/TYsj+MqzM+tI96mUsa9ZnbnIGnONvfbHac
         HmMMq+9uDMQXzjMkb67imxA7nnX/Bn6MBpCQkWguyFaSx3IeIYdlEMDNifVvQk3NYG0J
         ++7lYMKsMigpHcNUhuzuv/tQfnZ9Qy2obzpUc5q1meH1O+SKUWzmmteKSKd5VlE+3Ua8
         ip2F5XTU5SARrUWR9V88N5NpvTGnDs16GblzDRY71A8jr7iFOo1IuoJz385Ose1JQqH8
         /Pd/8RKYZyXF3VsZtr8KmSf7wHkI5fEipm6cgHdf/qYRJlHqjZ7jEWqoycSAwNzzyuQ+
         Ny2g==
X-Gm-Message-State: AOAM532YctuvSIQMupbt627NGrCBnQhKkS9isx9wGUz/uF0ggI1oLGfY
        r9iUd6svGs8+BlVOGwFWmkxeKQ==
X-Google-Smtp-Source: ABdhPJxEZDnqmwnay0jW2judBwsx0/KI/9504i8g3Jn6T7V3hL+EWCyIVFJwZxuaUmVA8NNfaOKGVQ==
X-Received: by 2002:a02:c6a5:: with SMTP id o5mr3274546jan.145.1641932685397;
        Tue, 11 Jan 2022 12:24:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l14sm6310774iln.11.2022.01.11.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:24:45 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:24:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Message-ID: <Yd3njKcopXVZ+69C@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
 <Yd3aZ5Q9Ph0H+Ijn@nand.local>
 <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
 <Yd3dao5Qh5yl/cBs@nand.local>
 <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
 <Yd3mCVLyxkVTNcS9@nand.local>
 <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 09:21:11PM +0100, Johannes Sixt wrote:
> Am 11.01.22 um 21:18 schrieb Taylor Blau:
> > On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
> >> Am 11.01.22 um 20:41 schrieb Taylor Blau:
> >>> On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
> >>>> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> >>>>> In any case, you're only setting the lower half of `min` high. Maybe:
> >>>>>
> >>>>>     uint64_t min = ~0ul;
> >>>>
> >>>> yeah, that works.
> >>>
> >>> I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
> >>> somebody more confident than I in this area would be welcome :).
> >>
> >> It does not work on Windows: unsigned long is 32 bits wide. You have to
> >> make it
> >>
> >>    uint64_t min = ~(uint64_t)0;
> >
> > Perfect; this is exactly what I was looking for. Thanks!
>
> Actually, on second thought, UINT64_MAX would be even better.

:-). I think that either is probably fine; I couldn't remember if
UINT64_MAX was part of POSIX or not (and clearly didn't bother to check!)

Thanks,
Taylor
