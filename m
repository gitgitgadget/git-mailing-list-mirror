Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1081F404
	for <e@80x24.org>; Sun, 21 Jan 2018 11:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeAULwk (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 06:52:40 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:33688 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeAULwj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 06:52:39 -0500
Received: by mail-ot0-f177.google.com with SMTP id d7so1847156oti.0
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fRFpWuMTVJ8+zPZzvB/B+hEIKF7MJuJmnCjWlWM6/xY=;
        b=bzlHzY7mZ8hedqtvWGLrN/1rf765qWTt+C2LtPNPRCyC2npPKJTfqzueDCjuJRB3Lb
         hfy0F0aAlsN87f7d3HNuQ++xffZrXIrbkmYk6DieszFFxueNvq09RiPiydupNpV9YjvC
         RQtEkwLZhhk/pSvCv9PTEomn7k5LkdVRxdwrl00O2iSCiJnkl3rjzUNoEJIICc9Pgevv
         qlewm6eWRXAqe3Yri8TnUWBoYHjxO9d1mXkMTIKsVk8OmzkkOTZXG+2RaTRD6f5vliXp
         a/FxSh3ma2JNeMiNtbEzNSFatUUTRPNJCmMf3JayB1Yk+hSccMC0ZEROoxrEW7IgiWqc
         VMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fRFpWuMTVJ8+zPZzvB/B+hEIKF7MJuJmnCjWlWM6/xY=;
        b=QybzNMEokLv8pyFvc7wmdveJkebiPjJ1dFVjfTKNZtTE92xl2twA2m1BZYdoqZu+BL
         DC2XDmEK6X4/iZeeWM1WnTOw7j+HJXu9/a4ze8cRsnZCR1+PrX8+DCNVpgXJ571++ABC
         spL0DY96RChAPjplbz2DPeKTi7eVo79SxepYUNq0UXnRZn2w55hwAEwGXljRe6vOdDQe
         idMwipFd+hLMcThlnbFOGdicglOqM7zGv2QwAV1fOGfzuCw0FKe385dh+d2G9qfyOvWN
         /+KZwwa9NmohPcS2kpgu737/F6WZDzohuX57XOPBdi1q0OwUxP88p/76izd3MUVck3EI
         t8eA==
X-Gm-Message-State: AKwxytepO/PScLq5ao4jZiHlnjVzpiA4GVeC8tXAhs20RGXgNvBCzamU
        lv1ulhPKwnKGd9n8aFT2SaIge5LEx9ZYwNU70Mk=
X-Google-Smtp-Source: AH8x224VOiOESQ+T92VTNZWLIQSpWyvKSCykV9V+dcx6Y4nEBY2CZNt/VEBkgAWysA7m9nbRbGVLpe8V8SXDAbbB7Ho=
X-Received: by 10.157.87.133 with SMTP id q5mr2632407oth.106.1516535559013;
 Sun, 21 Jan 2018 03:52:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Sun, 21 Jan 2018 03:52:08 -0800 (PST)
In-Reply-To: <xmqqa7x9pnda.fsf@gitster.mtv.corp.google.com>
References: <20180118095036.29422-1-pclouds@gmail.com> <xmqqa7x9pnda.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 21 Jan 2018 18:52:08 +0700
Message-ID: <CACsJy8AecDh6Bxo6xCBG+4AY5GCdtZgb2Cs2QXo5MYZvD7XKcQ@mail.gmail.com>
Subject: Re: [PATCH] dir.c: print correct errno when opendir() fails
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 4:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> The call invalidate_directory() between opendir() and warning_errno() in
>> theory could make some system calls and change errno. Prevent that by
>> warning immediately after opendir().
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  This is on top of nd/fix-untracked-cache-invalidation which is now on
>>  'next'. Sorry I waited too long to send the replacement and it's now
>>  too late.
>
> Well, we'll see a rewind of 'next' soonish anyway, so you can just
> tell me to tentatively kick it back to 'pu' to be replaced with a
> reroll if you prefer.

Please kick it back to 'pu'.
--=20
Duy
