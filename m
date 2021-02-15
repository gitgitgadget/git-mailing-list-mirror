Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD2C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C171160232
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBODQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 22:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBODQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 22:16:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6BC061574
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 19:16:14 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v24so8064028lfr.7
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 19:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bgAM0CCgM1d8GC1jMii03hHav+QmAQUX9pdxEzoxJxU=;
        b=Jsg0mpHokl44l01RR4RXUDIgALzRVicV5vlvwXj3w6AWGjZcpoC2vMXSRe/uSpVBH+
         NNx2AC1lAN7PK0STOHi3TGFak7X50CvYfrEeGuXo5yNCym9aqLFRz3CvkWMFDAULkkvM
         6+NCEK43h4oKkiTwCFI9SrOJhbKIIHmpITc3+uq90EtI2vxOt5DFqC42llc5yYCoq+0z
         2UC/wufOOsdcfppqiR4w5dqqsPaAhQvb3D4YSknnp6sNaoBpIqWtZfl/p67R+F/PYM45
         zAtts+fr5BtKXMhux2U74w4yNQp+Q0MKm22kaaPK25SBOLVb6KsmTeoUHUnd+ICpXhYP
         53fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bgAM0CCgM1d8GC1jMii03hHav+QmAQUX9pdxEzoxJxU=;
        b=DsCsImZ22BepSdSJ1u3pbLWTHlDTUPAYdpTH4QbGhKMyH1gwUP9C9cCr7cdeP4lQkX
         jNVwyQCFpaX1916mZi/5QFHi6LUGODoRoI3UxXk3ZGtbmTcmsfDBUqMWDNGbDBhO9rR4
         oybZPB75JeV2J5GpHeK8YbkAuWgHnEEmyNEcm54Iwwb973O1DPKd1OSkqk1bLZJZxAJV
         MdpWGzL7RzBiqtT/muwfKpytHgidEjri6Bu5sTMtC64eTClLD7vBVowcqWYdBnpVZajc
         aXGJVnFlc64jp/RrHkNcBoMEXxwBOZXf2ayHMYiTvchpbXkBdiCTwTpZUfIkJ4LZCdgq
         4NEw==
X-Gm-Message-State: AOAM533lNBmjNN2X6e6gFhL14UBbqtJ40YQWlyK5EPtYaqSm/6Qx5lgL
        coGvQH1gDmW0W6BXFkHp1av42V9vCafPaHBYcKc=
X-Google-Smtp-Source: ABdhPJzg8ujeY8oBwf+CWVnko0JSySH5/14JdO0mviLzg9radjsCsQlciQ/bMwL49nbOIrviYCmlgNERDObwm2ChJXw=
X-Received: by 2002:a19:3806:: with SMTP id f6mr7827765lfa.242.1613358973101;
 Sun, 14 Feb 2021 19:16:13 -0800 (PST)
MIME-Version: 1.0
References: <87tuqebj6m.fsf@evledraar.gmail.com> <20210215005236.11313-16-avarab@gmail.com>
In-Reply-To: <20210215005236.11313-16-avarab@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 14 Feb 2021 19:16:01 -0800
Message-ID: <CAPx1GvfFPWvJsj+uJV7RZrv1rgEpio=pk6rKF2UrjHebVY=LPA@mail.gmail.com>
Subject: Re: [PATCH 15/20] gitattributes doc: document multi-line userdiff patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is extremely trivial, just something to consider if you are
already doing a reroll:

On Sun, Feb 14, 2021 at 4:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> index 90992e2136..225c17b90d 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -794,6 +794,23 @@ backslashes; the pattern above picks a line that beg=
ins with a
>  backslash, and zero or more occurrences of `sub` followed by
>  `section` followed by open brace, to the end of line.
>
> +Multiple patterns can be supplied by seperating them with
> +newlines. They will be matched one at a time and are compiled as
> +separate patterns, and thus the first capture in each such pattern is
> +`$1`, see further discussion of captures below.

This is a comma splice (https://en.wikipedia.org/wiki/Comma_splice).
Use a period or semicolon to fix it.

(overall comment, haven't quite finished scanning the series yet but it
looks good!)

Chris
