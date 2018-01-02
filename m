Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4560A1F404
	for <e@80x24.org>; Tue,  2 Jan 2018 00:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeABACp (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 19:02:45 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:36528 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeABACo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 19:02:44 -0500
Received: by mail-ot0-f175.google.com with SMTP id w4so12187079otg.3
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KrMk36HL6hTJGlDRJryJwYwkm8t/6kFoYwfP8WnNPec=;
        b=ueBAKJf8cs1/UucC4umpYJl9EbSI+OHMHn/vJplVYTH35yESOJcaRYAuUdQHyCKWOk
         9onFiRA1DQ8fAcJ02v8I5+zQIG+6sMjQgTxcoZfJBW6iL2iN0Zvq2DJP6Y8IIS+C2ZDW
         UwEh5+guUjRg88XyerEYgtpSYJ5aBSmDayV5N86dm1+2m/jp7N3eTJfupYocuafCW9BM
         mLYhrlyI7Zc5RoEOBDAsr/zvkIAm35oIjLktOpDAARwNvC9teO7bR5oAHLSuiVdPZNcD
         4K/SwAL7n1zwRhOKeZEbh8dRImEthakwGprimS1RfuHRc9MlOSZNAhy0hdDquuhti66G
         bhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KrMk36HL6hTJGlDRJryJwYwkm8t/6kFoYwfP8WnNPec=;
        b=XV28QWK/PoEHTPkzfnhBYbmeQfi0tMZwuKhdpXx8XAhSxN9uQLr5xX2vxhcGceQyxY
         3tDquGdycaR2Sj5qJyXL5WwNQ3Wa8FvBywzCgUAe1RLRdxQQLgbuHA6f9bV3bdU5ly6e
         9lSOd7e/zdWY1RfyaF5dPE020ZY2d+gQ5qVVezSDRznlFHC4SV0RsqTBOIeD6VU2ZE2w
         jlxvI8R1C9Cg2fPH0pSLm3Oct2R5hCC/OxamdFEFSLZ1XiRVLV5vcGtkadVsJWqS2t3c
         OYmbSM8VPdZ9tqTqLRss6X6/DE1L4QP7qkWNm0WCR6YVJ6yWx/rLzdGtgMV2wQOoHQke
         4Jvg==
X-Gm-Message-State: AKGB3mKVSGAic+HPZmMnvg3Zdz/sJbn8pPV2d2Z2mn24CKIQyF3EfiSP
        FVOt4TJPuKRAz1jAdA+5HqkGy+SElYL1E8xRHFU=
X-Google-Smtp-Source: ACJfBouOQznqChPFpC6du4QOIGSbRCW/Y4p+erWuLOzIsrc8QnJXsMwNzq0bEIsUzHJ3sHhiOytwBLoxHMa7f72xB+4=
X-Received: by 10.157.4.13 with SMTP id 13mr1351693otc.106.1514851363488; Mon,
 01 Jan 2018 16:02:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 1 Jan 2018 16:02:13 -0800 (PST)
In-Reply-To: <87h8sar5sl.fsf@evledraar.gmail.com>
References: <20171228002807.22388-1-pclouds@gmail.com> <87h8sar5sl.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Jan 2018 07:02:13 +0700
Message-ID: <CACsJy8CvYcLm7YGYenea=58EVesLMBiOh3eWMWWSr8LLDsGmPQ@mail.gmail.com>
Subject: Re: [PATCH] dir.c: avoid stat() in valid_cached_dir()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 2:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Dec 28 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>
>> stat() may follow a symlink and return stat data of the link's target
>> instead of the link itself. We are concerned about the link itself.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  I noticed this while looking at the untracked cache bug [1] but
>>  because it's not directly related to that bug, I'm submitting it
>>  separately here.
>>
>>  [1] https://public-inbox.org/git/CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r=
8PQPrDt9bM_EA@mail.gmail.com/
>
> I'm slowly trying to piece together a re-submission of this whole
> series, if this is a bug and not just an optimziation shouldn't there be
> some test case that demonstrates this bug?

It's kind of hard to demonstrate the bug. I think when path->buf is a
symlink, we most likely find that its target's stat data does not
match our cached one, which means we ignore the cache and fall back to
slow path. This is performance issue, not correctness (though we could
still catch it by verying test-dump-untracked-cache, I guess; I could
try writing a test case for this if you want). The less unlikely case
is, link target stat data matches the cached version and we
incorrectly go fast path, ignoring real data on disk. A test for this
may involve manipulating stat data, which may be not portable.
--=20
Duy
