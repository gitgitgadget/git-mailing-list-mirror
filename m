Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9235C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1BB2070A
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke9iV0TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgEVPtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEVPtW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 11:49:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301CC061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:49:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so13573731ejq.5
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K2Gwd20+0UWgF9yBdDUIxwEzVdpv0UQzTK8FKk5l8b4=;
        b=Ke9iV0TQeA+kVgkO9waIRUTYPvbEGBvTG+BLTpjP3R43x42RZtPFJ1LQfIzl1rlCfT
         sLUdKkmQ2ndOFcd9JB/jfyzm3gJ1wfSb0uhzPFIhnVe/PDJM0DiAfst9sUKlUpUyBBQC
         PvK3EGiKOjmlWwGUXeSlCTiWP2Kxke/kpLzZ3tzPjMpWdnJQc5ckbLQ3gCblsyUCLJWd
         aRd6vU5L5duxHQJkwRnEQh+Ht2rbIv4tVpU+2wB9URPKXwlGSW510l6l9VCaNwKC61Lj
         YUypLBiccO2uqUSc8B8TIFYDLroHUW1D1qhfSbqlB6U7T885zMEtcMXXvDVkGzmlKwZ9
         95lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K2Gwd20+0UWgF9yBdDUIxwEzVdpv0UQzTK8FKk5l8b4=;
        b=lfRovJcZKUIlgvWPDNqLo7AlfsJ0aN0w1IvlxkRpSrgPQrmguqveak5CIp7x2XiQhg
         EFT29Gy1UVWHQG1vDcCC0XU4zJsJOWHbprjaIzy+vTjCgH99yPbgEU1J56TuOCGqNU5m
         /t64qv8eFhhVUJiue3SDgYjuSyM3nrULRlXgy0K2Im3NlfpraZqmWwsA/gv7Ypk5JdIV
         Va/yp/TjHwtILAALEryen0LS6krYNG4BHoRBnpk3ZGBKg+dByYqd/gCCvt54F8nEQjkm
         SNuE/qRqnqyJlxmyLzQfciLEwlO28+mwL2Lezfz4QjCodIXdN99cFH1hhZIyy2iJPz9z
         MRgw==
X-Gm-Message-State: AOAM533uaAPxh3khuPLORft3E7o17Y9r33bN/tzCoJdhHilKhld7Yylw
        GgmTkY4kqHhrdCzMUME25T79y5BaJL8Q8SnzlsLuM52p
X-Google-Smtp-Source: ABdhPJxqFC4XwPN3vq5jauV65dJfjWVzncJ34xqJlkHguPxyuCG065kZ1WaOgTriYCFcTW+LDVozlu4HLN4hjpbPwUw=
X-Received: by 2002:a17:906:4ec2:: with SMTP id i2mr9050375ejv.211.1590162559971;
 Fri, 22 May 2020 08:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200520195214.62655-1-carenas@gmail.com> <20200520232627.30901-1-carenas@gmail.com>
In-Reply-To: <20200520232627.30901-1-carenas@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 22 May 2020 17:49:08 +0200
Message-ID: <CAP8UFD1Oa6g4kj8GDhDC-3ry1eFyg-aD+JVDtfK1TkJKuL8v-Q@mail.gmail.com>
Subject: Re: [PATCH v2] bisect--helper: avoid segfault with bad syntax in
 `start --term-*`
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 1:31 AM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> 06f5608c14 (bisect--helper: `bisect_start` shell function partially in C,
> 2019-01-02) adds a lax parser for `git bisect start` which could result
> in a segfault under a bad syntax call for start with custom terms.
>
> Detect if there are enough arguments left in the command line to use for
> --term-{old,good,new,bad} and abort with the same syntax error the origin=
al
> implementation will show if not.
>
> While at it, remove an unnecessary (and incomplete) check for unknown
> arguments and make sure to add a test to avoid regressions.

This looks good to me!

Thanks,
Christian.
