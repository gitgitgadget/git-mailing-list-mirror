Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3361F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 23:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbcIAXhL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 19:37:11 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37773 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbcIAXhK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 19:37:10 -0400
Received: by mail-it0-f48.google.com with SMTP id e124so9459613ith.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c3J3LDI3YP14nWiiKA4Xa8Hn0e3IJySemA6GtzhFkS0=;
        b=WLWrw6mN/mpZiELLAJyhcRUsUYB5A2OLaACpHaIxD/nZ0VXHpRDB7S3gf7ooq/Dxj4
         oASmPJZ2anLj2OCup0G28FMoWVVyhJ5UE0K8iPRKDo22E531BQRkZmbRU6+p/VL2Nx1k
         BVDMknbzYE2uy0KzgRw4juTeX4+DMJUcfd16vdwZjMZf+JO6okUHIyba0lWm7DxMb3cH
         UloCfcmh3YavrmO2anaA2UmbRFjubEWbo7oqN7RN/c5bPXw6+V0NtmmLnO8fLsjB9Iqo
         O5IIrMWvtvxLEzqOOOY6o6MEZBHS7HnVctbpCmmgvvX+S7bm5fHT3VfldOvKfLZhRMFI
         wgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c3J3LDI3YP14nWiiKA4Xa8Hn0e3IJySemA6GtzhFkS0=;
        b=m4rtDmt2jGa9xfLVlJ208KGSrz9b5V3L/+rVDfswxzvxhDquDvs7BmKIpOElphD05K
         ZI6JLcziOkQSXgstkboCTQr2zutj+TgeNzD/QpoiMib+vOtDINIS/63/JRbkS4RhWZpR
         qhTgJNHlhfadXAKmrQULMpd4eVQms0/C6ebjwoIdZdTbfuem7K1RcWpbmc2LJp8Yx1Gl
         vKaqX+bap26uOF6NwU03Q3/yxT4Ft5AgQWJwNSBfGYYI4+FUKMlKYTkR6dRerx1cDfNk
         K5m8Z95fDlelDIPLFdZ+zLzdrNNVAPM/WRj5Dv1vpqycWrJ2EYXz8I3yFNLvCs0R7AjF
         FSYQ==
X-Gm-Message-State: AE9vXwMkrD2fXElJii4g/eEHXfasx5AFDV/LX6FG/vG+yidlvu6Dr/ifpcgMA3phO4cSbroOjb7uEqeMtUY0HNfM
X-Received: by 10.36.189.68 with SMTP id x65mr428687ite.97.1472773029301; Thu,
 01 Sep 2016 16:37:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 1 Sep 2016 16:37:08 -0700 (PDT)
In-Reply-To: <1472753809733-7657450.post@n2.nabble.com>
References: <1472753809733-7657450.post@n2.nabble.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Sep 2016 16:37:08 -0700
Message-ID: <CAGZ79kZdk0rkmryTQzJgXvX8Jxm2=iYfB1ttPq0qRHbPgS4UsQ@mail.gmail.com>
Subject: Re: bitmap creation failed
To:     gjarms <gjarms@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 11:16 AM, gjarms <gjarms@gmail.com> wrote:
> Hi Git Experts,
>
> We have been exploring various ways to improve git cloning time, one among
> them is using bitmap which is suppose to save time "counting objects".  but
> i have problem creating bitmap since the repository contains 100's of pack
> files. the bitmap file is not created when i use "git gc".
>
> I have the following entries in my .gitconfig.
>
> [pack]
>         packSizeLimit = 10m
>         writebitmaps = on
>         writeBitmapHashCache = on
>
> If i just dont use "packSizeLimit = 10m", then bitmap is created just by
> running git gc
>
> Can you please make me understand ?, What i understood is that the bitmap is
> created when there is a single pack file, but if i split it into multiple
> pack file, the bitmap generation fails with the warning
> "warning: disabling bitmap writing, as some objects are not being packed".

So I guess your single pack is larger than 10m, so it tries to create
multiple packs,
and that is not supported as bitmaps only operate on one pack.

Stefan

>
> Regards,
> Arumuga
>
>
>
> --
> View this message in context: http://git.661346.n2.nabble.com/bitmap-creation-failed-tp7657450.html
> Sent from the git mailing list archive at Nabble.com.
